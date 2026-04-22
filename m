Return-Path: <netdev+bounces-280283-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGP3BVMn6Gl0GAIAu9opvQ
	(envelope-from <netdev+bounces-280283-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:41:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 690764411EC
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F06A8303740F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 01:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5DC2D2495;
	Wed, 22 Apr 2026 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="kx6z7qmX"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1481A683E;
	Wed, 22 Apr 2026 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776821986; cv=none; b=o5KZH0WjQ3RN09tew6g3Pmdmn1im+HSG8t2GU640GnPi1LoXFGSf9CfAo70aGTdOTKkBDW83Z6CbjjBsTSTq/PgpZWDqW6+/oVk5LmNYyswziKucvPt3gk7BicNwHv9eVOkrTG2nVTrduCctUyb0Cc9lPkkgIz0Pp/snqYbcHOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776821986; c=relaxed/simple;
	bh=KPoefrbDlYdgEkq1Oc3rv+rOreYVear+zYnH46ggdiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmwLV0xFwH9haJNZbWy2rXVwV3VxTey1WC2OkMtJabfCz04CMRK8HDyKZ5GTqcjM11S7DkzJbWuv7qckS/7S4ayTJg/JfJd2yUYsuFCsMaMA6bw4CrEv54GcKp++Aqw+6qZBQpfGk5h+dKHXNmbt0C6FtALQLYp4112wRcX+6Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=kx6z7qmX; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776821898;
	bh=0SFROJnxEFjNuBWD3T850Wl5IdXYhvpLCGmsyfo7PhE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kx6z7qmXjQWmEhiiHHusXksH5Lx8dTB7xYUrvyIhlkmRUjwsY5mAPc2/GMLzPvbzb
	 hr5PokRzfSBm3k9piWR8P7BBCYEPbFOGwrq9+4C/OfZGI3yvj6w3l4jVgeWbZ5QoR4
	 ocApEogaEFeu/8vQ+B5/PP91gF3sJFLSO0lp3b7g=
X-QQ-mid: esmtpgz12t1776821891tb5bd6548
X-QQ-Originating-IP: dRcKjiKEY7JDiIZf+UScizh5xd7Ti8SkLtoHinoiRIQ=
Received: from uos-PC ( [117.152.201.246])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Apr 2026 09:38:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5004916965120226722
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
	Morduan Zang <zhangdandan@uniontech.com>,
	zhanjun <zhanjun@uniontech.com>
Subject: [PATCH] net: phonet: do not BUG_ON() in pn_socket_autobind() on failed bind
Date: Wed, 22 Apr 2026 09:38:07 +0800
Message-ID: <81A6570B633FF6FE+20260422013807.63087-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: Mt2Mrcw1zqlnczN/Mq9h+Hxd3y9jjnOErqtp8rX3h9o7D+HgIQzSzveM
	HEUvKqFz8t7yv9IkD7EgYbIuvOGbnuX6XDVnzfXlRVOHRbIYNk0Eo9LVvIwR8ZPoOP7LqjO
	rtc5KNNMbGZf5GaIh/BX0doMmXHdjaRtDs8QtjUoy5WcAipypAqpsusyAxI832voL4yzcP9
	r7+9gSyYNgXfC0mMKrDOWT+a2Pbu+W6M30Iz+pS8TZn/fxlNWHKfN4EkTlh89LOKStyBvDe
	OdajsRAQbJnGKvDOC9H/mzNOMU67l+tJC5Jdwl1Dms6cKXKOOpMI3LweiJHqJ2oRhNgohU3
	s7sh2ttezBH0KWc4ITfrtexFFOdZy270me7ug7AEAU/gyegXrM9Mpwxs/4f9gGmVXsBrqaV
	PizLXG1Oab8tEQ9zV674lZp3RHFe8OdugpteHtjEaXIPQaAyElxuBuKxV38dn0tyGjyW75C
	oemy2tdin2OcOd7E2glGg3d9LY/4SZ9LrClhjyOoPwLxgEidSecN8uhZtry/h5ZdD1oOsRu
	P8FqNzyilmIxQROjqSzRzN1MchqjFu/MJSOW4B7eR1W01IgqMULw7Kk8f/UakI0BcEwco2c
	j/kipt5YTkxhS8gDU9COn3fNmKDHZf3MsV+lBRwk09Cs0x+NsRrS29e4URrdxnXlUajHJ8j
	8NoLneZ2odkIGZK+iIctY4gIojbboqCIFzLrMeC3ZPKE1L6eUeg5uM+K/HJ8HZK0Yyu2XFa
	5xh6BxpTktCI0q3rMwsClKm70GTDp14wdPRA32C5P9W7lSPsca8wZuphIzWRnVyrdy2Gzzn
	5mwr/2AUpwfeSUa5NF/2rzdnOBAo2x2MfJnN4lESi0lEaH3/dJNdQMXe0xL8pxYCdsJBqvC
	nTUWv67aNJfyDEnEEVcAxddKYbITGh0yufMK5/VDanXWF7ilBVVN3MvkeRrIR9AgTXWKzeE
	8NNKuIDhCFjHV5NGciDXPjBI7b7Opz+OEY1mN9aGAG8xdaIIGotZeWZxzWpY6MoXQqFFa3q
	RNxweye+KnMMlM+AkylaWvZ09Zn9gjIPhhLI+jB2Ul6Ve+k6taStb52rADcQQFngLa5iLHH
	L2BTz1waiee
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280283-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangdandan@uniontech.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,706f5eb79044e686c794];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 690764411EC
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
Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
Signed-off-by: zhanjun <zhanjun@uniontech.com>
---
 net/phonet/socket.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index 4423d483c630..de9108adfe1c 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -210,7 +210,15 @@ static int pn_socket_autobind(struct socket *sock)
 			     sizeof(struct sockaddr_pn));
 	if (err != -EINVAL)
 		return err;
-	BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
+	/*
+	 * pn_socket_bind() can return -EINVAL both when the socket is
+	 * already bound (pn_port() != 0) and when sk_state != TCP_CLOSE
+	 * without a prior bind.  Only the former is an "already bound"
+	 * success for autobind; otherwise propagate -EINVAL instead of
+	 * crashing the kernel.
+	 */
+	if (!pn_port(pn_sk(sock->sk)->sobject))
+		return -EINVAL;
 	return 0; /* socket was already bound */
 }
 
-- 
2.50.1


