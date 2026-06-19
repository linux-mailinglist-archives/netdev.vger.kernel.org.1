Return-Path: <netdev+bounces-300566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fPu8OGyXNGoTcQYAu9opvQ
	(envelope-from <netdev+bounces-300566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:12:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6E56A383A
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:12:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=bKmSPQh3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300566-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300566-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62DC230221F1
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EA62D6E72;
	Fri, 19 Jun 2026 01:12:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2072D7D2E
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 01:12:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781831528; cv=none; b=MzcGISXq4dKFknQFCj/ckbMl7STp9eA8+X4aei1/HUM63kFA6Zxae79XsXRcfV9i4mqMR16WFE4oXhjrgnZo9JI5AR9ZgCgtlKxMWiKJOLcuRoiFouUYPlsPqLPwmKYiJ1mwUCAzXUEgTzqViwVif0r1y1QAEA1CgZ6BuMSQVP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781831528; c=relaxed/simple;
	bh=UeM6pamAl4ywOpSLza3EOHnSPwbVt5s2v3DCHEFSi0k=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DlwovXhuBOtDqBGlSdpmw64H6YOI6B8TL2DbCY6QySc8+x1nssXEdNkvNZMh9uTjgUg3bKQXcdAL37wHQTIneRjmVvNj57kjSLLP8pdckaaFr1O8WzeRFU1BjLYnh1WwFzXBmP4n/lqmo7NSgpYs7yQW2DjoJwdfooE1dnhILQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bKmSPQh3; arc=none smtp.client-ip=79.135.106.121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781831517; x=1782090717;
	bh=2XNCRhy4uaOiOmuU4tNaw0+tI3srLdlDb52wwhIwtyE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bKmSPQh3YFC7+VcvZjA1WkrEP+cR0Qm/TV9Bs+WD4GbfYmkUJesx9dQbpOxNCy6qG
	 +FqeB/5z4MC9TJ+7vL1XLbL81Ky0dk9Y33nEnI4CdXtdfkItJBkD9AyopX26NOh00v
	 1cHwDWnseWc6LA54CuAAh5CwTSd+7Zcb3+D/bwMAreJgPxsAQIlkRgXSmNSWtFKSQ8
	 njnrng9zuSAAtG6tnCve30Djm9TnsRjyQNllQEJNa7SmhzxqfEP273HBcJdkj3pJem
	 7M6v/wjaze6mAUG/Ny+Rk7X+4ciucPGNxhBd2sDjlf8WCguFpSuUad3cKhrADGi7Wk
	 9W3pLKG4bhKSw==
Date: Fri, 19 Jun 2026 01:11:45 +0000
To: John Johansen <john.johansen@canonical.com>, linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Mickael Salaun <mic@digikod.net>, Stephen Smalley <stephen.smalley.work@gmail.com>, Matthieu Buffet <matthieu@buffet.re>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: AppArmor: TCP Fast Open bypasses connect mediation (last unaddressed LSM)
Message-ID: <20260619011138.264578-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 07f0b31b3d290527fbe6492402348c1c56250175
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300566-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:john.johansen@canonical.com,m:linux-security-module@vger.kernel.org,m:apparmor@lists.ubuntu.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:mic@digikod.net,m:stephen.smalley.work@gmail.com,m:matthieu@buffet.re,m:ivanov.mikhail1@huawei-partners.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stephensmalleywork@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[proton.me:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[paul-moore.com,namei.org,hallyn.com,digikod.net,gmail.com,buffet.re,huawei-partners.com,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:dkim,proton.me:mid,proton.me:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A6E56A383A

Hello John, and LSM folks,

I have been working on the Landlock TCP Fast Open connect bypass [1]. Steph=
en
Smalley's SELinux fix for the same issue [3] -- "Similar to Landlock, SELin=
ux was
not updated when TCP Fast Open support was introduced ..." -- made me go ba=
ck and
check the rest of the connect-mediating LSMs, since I had only been looking=
 at
Landlock. With Landlock [2], SELinux [3], and now TOMOYO [4] all getting fi=
xes,
AppArmor is the last one with the same gap and no fix yet.

Root cause (shared with the others)
-----------------------------------
security_socket_connect() has a single call site, net/socket.c (the connect=
(2)
syscall). TCP Fast Open performs an implicit connect inside sendmsg:

  tcp_sendmsg -> tcp_sendmsg_fastopen -> __inet_stream_connect(..., is_send=
msg=3D1)
              -> sk->sk_prot->connect()                 net/ipv4/{tcp.c,af_=
inet.c}

This never calls security_socket_connect(); the only LSM hook on the path i=
s
security_socket_sendmsg(). mptcp_sendmsg_fastopen reaches the same code and=
 is a
second producer.

AppArmor
--------
apparmor_socket_connect() requests AA_MAY_CONNECT; apparmor_socket_sendmsg(=
) (via
aa_sock_msg_perm) requests AA_MAY_SEND. These are distinct bits, and apparm=
or_parser
compiles them independently: "network send inet stream," yields accept mask=
 0x02
while "network connect inet stream," yields 0x40. So an egress-restriction =
profile
that grants send but not connect is bypassed by MSG_FASTOPEN.

Reproduced on 6.12.88 with apparmor active. Under a profile granting the in=
et/inet6
stream lifecycle except connect:

  aa-exec -p egress_restricted -- ./probe
  [TCP ] connect(2)=3DEACCES(blocked)  sendto(MSG_FASTOPEN)=3DOK(reached)  =
=3D> connection established
  [TCP6] connect(2)=3DEACCES(blocked)  sendto(MSG_FASTOPEN)=3DOK(reached)  =
=3D> connection established

(The coarse "network inet stream," idiom grants connect anyway, so this onl=
y bites the
fine-grained "allow send, deny connect" policy that the asymmetry is meant =
to serve.)

Fix
---
Same shape as the TOMOYO [4] and SELinux [3] fixes: in apparmor_socket_send=
msg (or
aa_sock_msg_perm), when MSG_FASTOPEN is set and msg_name carries a destinat=
ion on a
not-yet-connected stream socket, additionally require aa_sk_perm(OP_CONNECT=
,
AA_MAY_CONNECT, sk). I am happy to send that patch and the reproducer.

(A single core check in __inet_stream_connect(), gated on is_sendmsg, would=
 have
covered all five LSMs and both the TCP and MPTCP producers in one place -- =
the kernel
already mediates the analogous implicit-connect-on-send for AF_UNIX via
security_unix_may_send and for SCTP via security_sctp_bind_connect. But sin=
ce the
other four LSMs are taking per-hook fixes, AppArmor matching them is the co=
nsistent
move; mentioning the core option only in case it is preferred.)

[1] Landlock: LANDLOCK_ACCESS_NET_CONNECT_TCP bypass via TCP Fast Open (rep=
ort)
    https://lore.kernel.org/r/20260616201615.275032-1-hexlabsecurity@proton=
.me
[2] landlock: fix TCP Fast Open connection bypass (Matthieu Buffet)
    https://lore.kernel.org/r/20260617180526.15627-2-matthieu@buffet.re
[3] selinux: check connect-related permissions on TCP Fast Open (Stephen Sm=
alley)
    https://lore.kernel.org/r/20260618175513.112443-2-stephen.smalley.work@=
gmail.com
[4] tomoyo: Enforce connect policy in TCP Fast Open (Matthieu Buffet)
    https://lore.kernel.org/r/20260619002207.61104-1-matthieu@buffet.re

Thanks,
Bryam Vargas


