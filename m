Return-Path: <netdev+bounces-280568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNQDDtNw6WniZgIAu9opvQ
	(envelope-from <netdev+bounces-280568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 03:07:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 830FC44C01C
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 03:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FED03015A43
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 01:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBB4274B5C;
	Thu, 23 Apr 2026 01:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="oNNrOc8v"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578924EA90;
	Thu, 23 Apr 2026 01:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776906447; cv=none; b=Rkc8mQVxuAMCEapKZm6ViN6AQIkrt3ozWypSqo/GsZQEVssLT782QPoe6XYZpSnPWYTaFQaPyqAn6gQiu4yAOEvTzEF1IHW5UhusbDbQyj6ZusYT5a3Bk5cIm2eSn8nSz5NlmoUwDx8966oPuxYoBauCbI/Do6SLEP9jhX8w9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776906447; c=relaxed/simple;
	bh=tYCzHor47hqxp8rLOA7WTY/+BbPkDn44rqQOP1bXeYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhtOaOmwQy2ZihQ/FF9aBGlibNfBQvDTVRdy5kMkGBdJxpCfzM4hlO+yJM1oCXBDMsYz+JszjBfBLVOpNQhUXFITqBux+QFoFyT1JfB+Z+Sh1mPnIB+H4l5SkBcgRoas6m/kLIpB8n8HZR/riMDkofBh9JGuk/DYStj0GFiHZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=oNNrOc8v; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776906372;
	bh=eggo0kWU9G/tlBHOtS1ZEL/eQvikyrXBED2PxIykBh0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oNNrOc8v8kRJDRSBvpqlIW4hSnkP3+bOWfBhRtqh+j+pKNF8shWqVE4J/uhTo3ZKG
	 zumbmQIOc6EHJbGHg8gvPczUD7tWUDKuoVRpKqKHXk4BrJLl4Cy5QgtUw4TjpY3d0K
	 CLiq9a2vcLYKKJIrFpRzv0tgIXxNA63rvaG9GhSw=
X-QQ-mid: esmtpgz13t1776906365t1bceb4d6
X-QQ-Originating-IP: +2maIw1gtaxOC5WLdgL2MajtIYHujWkA+NSD3rmx6ZU=
Received: from uos-PC ( [117.152.201.246])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 23 Apr 2026 09:06:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17469408873635827104
EX-QQ-RecipientCnt: 12
From: Morduan Zang <zhangdandan@uniontech.com>
To: Remi Denis-Courmont <courmisch@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com,
	zhanjun@uniontech.com,
	Morduan Zang <zhangdandan@uniontech.com>
Subject: [PATCH net v2] net: phonet: do not BUG_ON() in pn_socket_autobind() on failed bind
Date: Thu, 23 Apr 2026 09:05:57 +0800
Message-ID: <87A8960A2045AF3C+20260423010557.138124-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <81A6570B633FF6FE+20260422013807.63087-1-zhangdandan@uniontech.com>
References: <81A6570B633FF6FE+20260422013807.63087-1-zhangdandan@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MrosOnwPZ59QofduHQP5G2zL4G75JMULfaVNVig0+pTmebN6YD2IKTxP
	wi0sKdiak6z0zNA+NA/i5ESqaSWQ66Ye8lpAqltAEAPPOeMvybQ/3YgVSGtb/25QjUCFw2f
	ksnYfUuYoacDEylnC11V633n5SXk76VNKdX6lhhqpYB0XTzo/tQFIl/YvJ8xpgubay3eUcK
	3sHCn7avnuSJwcJrKSVNeU6FIRPfCXixpF4LuPUpmK+iFnOLUhwSbvWomUn+BpgZ634ac5H
	5JCD3abqTtsnqbCVoqZ920hw2jfEIEK2gc+Uiwrrm+4rxgEJjgW5C/CeRpmMsAI+g1AYH0N
	kttWjX3iZhgc1UUfIXxcM44/weTg8UMqxZ49MuFTqdfAsLvTjYhkY+n+BJ40/xzPsVpNxUz
	HOmLO6QajEdb41ypzXQu9098xjamHiqfyLiiz9MQkgN+wpeJp5eXt9KkfV/+UQAwjDup4Ov
	MbI9/n1N6LKbBSlyI30C25XZ0+kjp0WeNjhUtDC9y8+BSjGH6H+TJYuBv6rr6hYoRfEH919
	kZfYgAo1UOY4OT8mYS5j5dHAgvPzHd8y0NTPRR4PQKlHlkeZI8sZmT7SQd8Z2xrPLsvZGaa
	EZA967wY/LQO2wrbo5TdxGAqkUO9GciuAJ0xtLO4OAN8yOc0gZXxu3vw2J7+FHMBHgRdOaJ
	Ed3VDvzFGowTozPoQcdneHrmu5Ehy7UWMZcIc8S5zSLyzSDtOLOXn7JRdky9deaHQOsNbm3
	Y0kvfFs88ylCYzvGrybQA6OSLQqOJAHGzM0gUzDd3KpEy8WHCWMwnYr8v23ayrBTyFKz0kh
	XVSHldwpoz6jj5sBYiQoniVEcbLb4pXTq+nY7Jr1jbL72TyYpTFZtRSUsqbzfera46ghdXp
	MzQ2UjrHMo4xjDP1IvAsFWbw3O3X3mko/GWuXRQOSqiBFlu/PMiSEHTFKGTCi4xuVMRp6Ih
	FRtJC5OgX4rCipzSlV80ATG4apUYr55mVDrAKEhNaKDsem35dPYEFmh9E6g60OcpdPS8cHS
	ZIyxlDOfqZbvRt7blCv1elFWfznMs8r23bOElKkm/jE5HyMBJNIvWqhD2/0Hz0tbF016nLY
	OlwzfAws6gCj23XD19O2cFWqwZ36Zt6jg==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280568-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangdandan@uniontech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,706f5eb79044e686c794];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uniontech.com:email,uniontech.com:dkim,uniontech.com:mid,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 830FC44C01C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot reported a kernel BUG triggered from pn_socket_sendmsg() via
pn_socket_autobind():

  kernel BUG at net/phonet/socket.c:213!
  RIP: 0010:pn_socket_autobind net/phonet/socket.c:213 [inline]
  RIP: 0010:pn_socket_sendmsg+0x240/0x250 net/phonet/socket.c:421
  Call Trace:
   sock_sendmsg_nosec+0x112/0x150 net/socket.c:797
   __sock_sendmsg net/socket.c:812 [inline]
   __sys_sendto+0x402/0x590 net/socket.c:2280
   ...

pn_socket_autobind() calls pn_socket_bind() with port 0 and, on
-EINVAL, assumes the socket was already bound and asserts that the
port is non-zero:

  err = pn_socket_bind(sock, ..., sizeof(struct sockaddr_pn));
  if (err != -EINVAL)
          return err;
  BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
  return 0; /* socket was already bound */

However pn_socket_bind() also returns -EINVAL when sk->sk_state is not
TCP_CLOSE, even when the socket has never been bound and pn_port() is
still 0.  In that case the BUG_ON() fires and panics the kernel from a
user-triggerable path.

Treat the "bind returned -EINVAL but pn_port() is still 0" case as a
regular error and propagate -EINVAL to the caller instead of crashing.
Existing callers already translate a non-zero return from
pn_socket_autobind() into -ENOBUFS/-EAGAIN, so returning -EINVAL here
only changes behaviour from panic to a normal errno.

Fixes: ba113a94b750 ("Phonet: common socket glue")
Reported-by: syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=706f5eb79044e686c794
Suggested-by: Remi Denis-Courmont <courmisch@gmail.com>
Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
Signed-off-by: zhanjun <zhanjun@uniontech.com>
---
Changes in v2:
 - Fold the extra port check into the existing -EINVAL test so that
   autobind now reads as a single compact "not already bound" guard
   using unlikely() (Remi Denis-Courmont).
 - Reword the accompanying comment accordingly; no functional change
   vs. v1 other than the code-style simplification.

v1: https://lore.kernel.org/all/81A6570B633FF6FE+20260422013807.63087-1-zhangdandan@uniontech.com/
---
 net/phonet/socket.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index 4423d483c630..bbd710d95b97 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -208,9 +208,15 @@ static int pn_socket_autobind(struct socket *sock)
 	sa.spn_family = AF_PHONET;
 	err = pn_socket_bind(sock, (struct sockaddr_unsized *)&sa,
 			     sizeof(struct sockaddr_pn));
-	if (err != -EINVAL)
+	/*
+	 * pn_socket_bind() also returns -EINVAL when sk_state != TCP_CLOSE
+	 * without a prior bind, so -EINVAL alone is not sufficient to infer
+	 * that the socket was already bound.  Only treat it as "already
+	 * bound" when the port is non-zero; otherwise propagate the error
+	 * instead of crashing the kernel.
+	 */
+	if (err != -EINVAL || unlikely(!pn_port(pn_sk(sock->sk)->sobject)))
 		return err;
-	BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
 	return 0; /* socket was already bound */
 }
 
-- 
2.50.1


