Return-Path: <netdev+bounces-280961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GIFJe4l62muJAAAu9opvQ
	(envelope-from <netdev+bounces-280961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:12:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB5345B3FE
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 10:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 212153011C40
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 08:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49473815C3;
	Fri, 24 Apr 2026 08:12:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ursule.remlab.net (vps-a2bccee9.vps.ovh.net [51.75.19.47])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51722256F;
	Fri, 24 Apr 2026 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.19.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018322; cv=none; b=FYVnNwkvid7/MJxhHASq15bNXyQo6k03vLQy1KepBA//nKa9uWTGKhu7Jndh2Zvua/ehkXKRiZMB9MtXzSAx/dZW/A3i1scb5b9GatdFOe57xBCBS6nrRxQ75rRZZ6XB3FPt6Gts4xG5JM7HCj4yzl5RL5/lZM34O7TpiVnYxMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018322; c=relaxed/simple;
	bh=wkbcj40A5IvpdOg9HaOB/QavQjZwK4YHCEYvQnGoZdE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EciNyFCSs6zu4PcvMXTpPtHXzf9lCbdIL6QS3Ewcy/h/h7yj243xegwmedRBp/wYIn49R5bo3CgZE69qt4cSqZBeCADerReurMwBk1ycsG3ZJ9n7GPRqCtiB2ymAFJNo3ZOJM1ASYMSDBY9S/lgmN84nxBx154I2xODbuxxwn5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=51.75.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from ursule.remlab.net (localhost [IPv6:::1])
	by ursule.remlab.net (Postfix) with ESMTP id C5AF3C016E;
	Fri, 24 Apr 2026 11:01:51 +0300 (EEST)
Received: from ehlo.thunderbird.net ([2001:14bb:cc:dede::4701:b01])
	by ursule.remlab.net with ESMTPSA
	id zvk6H28j62mujgMAwZXkwQ
	(envelope-from <remi@remlab.net>); Fri, 24 Apr 2026 11:01:51 +0300
Date: Fri, 24 Apr 2026 11:01:51 +0300
From: =?ISO-8859-1?Q?R=E9mi_Denis-Courmont?= <remi@remlab.net>
To: Morduan Zang <zhangdandan@uniontech.com>,
 Remi Denis-Courmont <courmisch@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 syzbot+706f5eb79044e686c794@syzkaller.appspotmail.com, zhanjun@uniontech.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net_v2=5D_net=3A_phonet=3A_do_not_BUG=5F?=
 =?US-ASCII?Q?ON=28=29_in_pn=5Fsocket=5Fautobind=28=29_on_failed_bind?=
User-Agent: K-9 Mail for Android
In-Reply-To: <87A8960A2045AF3C+20260423010557.138124-1-zhangdandan@uniontech.com>
References: <81A6570B633FF6FE+20260422013807.63087-1-zhangdandan@uniontech.com> <87A8960A2045AF3C+20260423010557.138124-1-zhangdandan@uniontech.com>
Message-ID: <2EF979DF-C8DA-4691-A699-E3EA58A21E17@remlab.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BDB5345B3FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280961-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[remlab.net];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[uniontech.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[remi@remlab.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.990];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,706f5eb79044e686c794];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,remlab.net:mid,remlab.net:email]



Le 23 avril 2026 04:05:57 GMT+03:00, Morduan Zang <zhangdandan@uniontech=
=2Ecom> a =C3=A9crit=C2=A0:
>syzbot reported a kernel BUG triggered from pn_socket_sendmsg() via
>pn_socket_autobind():
>
>  kernel BUG at net/phonet/socket=2Ec:213!
>  RIP: 0010:pn_socket_autobind net/phonet/socket=2Ec:213 [inline]
>  RIP: 0010:pn_socket_sendmsg+0x240/0x250 net/phonet/socket=2Ec:421
>  Call Trace:
>   sock_sendmsg_nosec+0x112/0x150 net/socket=2Ec:797
>   __sock_sendmsg net/socket=2Ec:812 [inline]
>   __sys_sendto+0x402/0x590 net/socket=2Ec:2280
>   =2E=2E=2E
>
>pn_socket_autobind() calls pn_socket_bind() with port 0 and, on
>-EINVAL, assumes the socket was already bound and asserts that the
>port is non-zero:
>
>  err =3D pn_socket_bind(sock, =2E=2E=2E, sizeof(struct sockaddr_pn));
>  if (err !=3D -EINVAL)
>          return err;
>  BUG_ON(!pn_port(pn_sk(sock->sk)->sobject));
>  return 0; /* socket was already bound */
>
>However pn_socket_bind() also returns -EINVAL when sk->sk_state is not
>TCP_CLOSE, even when the socket has never been bound and pn_port() is
>still 0=2E  In that case the BUG_ON() fires and panics the kernel from a
>user-triggerable path=2E
>
>Treat the "bind returned -EINVAL but pn_port() is still 0" case as a
>regular error and propagate -EINVAL to the caller instead of crashing=2E
>Existing callers already translate a non-zero return from
>pn_socket_autobind() into -ENOBUFS/-EAGAIN, so returning -EINVAL here
>only changes behaviour from panic to a normal errno=2E
>
>Fixes: ba113a94b750 ("Phonet: common socket glue")
>Reported-by: syzbot+706f5eb79044e686c794@syzkaller=2Eappspotmail=2Ecom
>Closes: https://syzkaller=2Eappspot=2Ecom/bug?extid=3D706f5eb79044e686c79=
4
>Suggested-by: Remi Denis-Courmont <courmisch@gmail=2Ecom>
>Signed-off-by: Morduan Zang <zhangdandan@uniontech=2Ecom>
>Signed-off-by: zhanjun <zhanjun@uniontech=2Ecom>

Acked-by: R=C3=A9mi Denis-Courmont <remi@remlab=2Enet>

