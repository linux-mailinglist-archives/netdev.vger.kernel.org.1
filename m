Return-Path: <netdev+bounces-299949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DDCzHUWwMWqupAUAu9opvQ
	(envelope-from <netdev+bounces-299949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:21:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C46936952BE
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:21:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=Hrj1CtZu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299949-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299949-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8503A303259D
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 20:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AE4388394;
	Tue, 16 Jun 2026 20:16:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442A735DA78;
	Tue, 16 Jun 2026 20:16:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781640996; cv=none; b=fiWqlH+G4H5ciXQ26fDohZbJS2qS48HETHF/mZp22lrTHyxe8clcjlmmz+k2z0JX6tXUTjZSk5ciKJ+/VJFTyaCh9HfNE+xgwRdcloa6jiu1EAnS0ox6GPsNFE4ZtiWlQvMiPe/tsv4YkujFw9Km6l7AHvKOau5pCts6q4qN1Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781640996; c=relaxed/simple;
	bh=db3qSJli4jDRZof723oGb/+ks3Jt+72/lbJ9c8+t6vE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=UvUPBZ2IIa3JQcun7v6Yci6AsR8E/dyAHYiIjcYGqa1GsQRNMPtElSOCdWukM8gc1aqyAxjBos4chyiLl/fJOEsQuMABPyqjkEx/QcfuFUCS30GlkgJV9p7BmSXAKkvAmiD+zp9TzSFeNb5K+AjCjioJ6A7tZF+w++NoBsAvhRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Hrj1CtZu; arc=none smtp.client-ip=185.70.43.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781640990; x=1781900190;
	bh=Tyu4xAn0C8J9jySsHHCTPZlC9QmtEw5NEsTGCRFwJYE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Hrj1CtZuEcPFlA13UBav/ma3CMPBpI/O0G3g7nft3pwgQ2y9l0TTH3HZYrP+S0v8t
	 dv/NG7bWZmcK4BM5ZxOl+BgOzYwj3wUzN0FDPxGP/MhRnB8SMRS6fLJDtCwfw5R6mX
	 nEx1bSJto7bh7SWqhMUUfwFF5phgLPKE4iLiseAqSlvFR/9O+ze6UaOqVZI4HWlSlj
	 4+DAoADzQFNnnduM4SoXnLNdNdLdSFMUTq1WsLD3uMUbUvUNLkGyf+XiKbWSt8Hw2r
	 fMXLXxJhKvzkQAAxcAHzihLhabmmzR7drGh/k6ChOLMIVBPFWlZR86Bv0sMQR0VVj9
	 DPnt1ixL4v3zQ==
Date: Tue, 16 Jun 2026 20:16:22 +0000
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Matthieu Buffet <matthieu@buffet.re>, Paul Moore <paul@paul-moore.com>, Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, linux-security-module@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Landlock: LANDLOCK_ACCESS_NET_CONNECT_TCP bypass via TCP Fast Open
Message-ID: <20260616201615.275032-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 7635c85011b3c8fa2ca156887e0c834759c13cf8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299949-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mic@digikod.net,m:gnoack@google.com,m:matthieu@buffet.re,m:paul@paul-moore.com,m:edumazet@google.com,m:ncardwell@google.com,m:linux-security-module@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[proton.me:dkim,proton.me:email,proton.me:mid,proton.me:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C46936952BE

Hello Micka=C3=ABl, and Landlock folks,

A task confined by a Landlock ruleset that handles
LANDLOCK_ACCESS_NET_CONNECT_TCP and is denied connecting to a given port ca=
n
still establish a TCP connection to that port by using TCP Fast Open, i.e.
sendto(fd, ..., MSG_FASTOPEN, &dst, dstlen) on a fresh stream socket. The
network-egress confinement for TCP connect is silently bypassed.

Affected
--------
Any kernel with CONFIG_SECURITY_LANDLOCK=3Dy and Landlock enabled that supp=
orts
the TCP network access rights (Landlock ABI >=3D 4, since Linux 6.7). Confi=
rmed by
source inspection on mainline (v7.1-rc7) and reproduced on Linux 7.0.11
(Landlock ABI 8). No CONFIG beyond Landlock + IPv4/IPv6 TCP; TCP Fast Open =
client
is enabled by the per-netns default (net.ipv4.tcp_fastopen has TFO_CLIENT_E=
NABLE
set), so no sysctl change and no setsockopt are required.

Root cause
----------
LANDLOCK_ACCESS_NET_CONNECT_TCP is enforced only by the socket_connect LSM =
hook
(hook_socket_connect -> current_check_access_socket). security_socket_conne=
ct()
has exactly one call site in the tree, net/socket.c (the connect(2) syscall=
).

TCP Fast Open performs an implicit connect inside sendmsg:

  tcp_sendmsg_locked()            net/ipv4/tcp.c  (MSG_FASTOPEN branch)
   -> tcp_sendmsg_fastopen()      net/ipv4/tcp.c
   -> __inet_stream_connect(..., is_sendmsg=3D1)  net/ipv4/af_inet.c
   -> sk->sk_prot->connect()      net/ipv4/af_inet.c  -> tcp_v4_connect()

This path establishes the connection to the address taken from msg_name but
never calls security_socket_connect(). The only LSM hook fired on the sendm=
sg
path is security_socket_sendmsg(), and Landlock registers no socket_sendmsg
hook, so LANDLOCK_ACCESS_NET_CONNECT_TCP is never re-checked. __inet_stream=
_connect()
itself carries no LSM hook (only the cgroup-BPF pre_connect, a different
mechanism).

Notably the kernel already mediates the analogous AF_UNIX implicit-connect =
on the
send path via the unix_may_send hook, which Landlock does register
(hook_unix_may_send) -- so the sendmsg-implies-connect pattern is recognize=
d, but
the TCP Fast Open case has no equivalent coverage. The MPTCP fast-open path
(mptcp_sendmsg_fastopen -> __inet_stream_connect) is a second producer of t=
he
same unmediated connect (by source inspection; not separately reproduced).

Reproducer
----------
A self-contained, fully unprivileged PoC is available on request. It forks =
an
unconfined TFO-capable loopback listener, then in a child applies a Landloc=
k
ruleset handling LANDLOCK_ACCESS_NET_CONNECT_TCP with no allow rule
(landlock_create_ruleset() with handled_access_net =3D
LANDLOCK_ACCESS_NET_CONNECT_TCP, no landlock_add_rule(), then
landlock_restrict_self(); every TCP connect is denied) and tries the forbid=
den
port two ways:

  (1) connect(fd, &dst)                 -> -EACCES   (Landlock enforces CON=
NECT_TCP)
  (2) sendto(fd2, buf, len, MSG_FASTOPEN, &dst, dstlen)
                                        -> succeeds; the listener accepts t=
he
                                           connection and reads the payload=
.

Observed on Linux 7.0.11 (Landlock ABI 8):

  [1] connect(2)            -> ret=3D-1 errno=3D13 (Permission denied)
  [2] sendto(MSG_FASTOPEN)  -> ret=3D14 errno=3D0 (OK/queued)
  [+] listener ACCEPTED the confined child's connection; payload=3D"..."

connect(2) to the port is denied while sendto(MSG_FASTOPEN) reaches the ide=
ntical
port and delivers data.

Impact
------
A sandbox that uses LANDLOCK_ACCESS_NET_CONNECT_TCP to restrict outbound TC=
P
(e.g. to keep a confined component from reaching an internal service or a
metadata endpoint) can be escaped by an unprivileged, self-confined task wi=
th no
CAP and no namespace transition -- for any destination port, since the
implicit-connect path never consults the connect hook regardless of address=
 (the
run above shows one port). It is an integrity
bypass of the network-confinement property; no memory safety is involved.
I score it CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:N/I:H/A:N (6.5 Medium) -- the
confined task escapes the policy authority that defined its sandbox, a scop=
e
change; 5.5 if you treat the Landlock boundary as the same authority (S:U).

Note on the in-flight UDP series
--------------------------------
The "landlock: Add UDP access control support" series (v5, Matthieu Buffet,
https://lore.kernel.org/r/20260611162107.49278-3-matthieu@buffet.re) adds a
socket_sendmsg hook, hook_socket_sendmsg(), but it returns 0 for non-UDP
sockets:

    if (sk_is_udp(sock->sk))
            access_request =3D LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
    else
            return 0;

so a TCP socket using MSG_FASTOPEN still bypasses LANDLOCK_ACCESS_NET_CONNE=
CT_TCP
even after that series lands. It may be most convenient to fix this there.

Suggested direction
-------------------
Re-check LANDLOCK_ACCESS_NET_CONNECT_TCP on the implicit-connect path: eith=
er have
the socket_sendmsg hook evaluate CONNECT_TCP for stream sockets when the ca=
ll
performs an implicit connect (mirroring the AF_UNIX unix_may_send handling)=
, or
place the check inside __inet_stream_connect() so a single chokepoint cover=
s
connect(2), TCP Fast Open, and the MPTCP fast-open sibling.

I am happy to send a patch for this if you would like me to.

Best regards,

Bryam Vargas
Independent security researcher, HEXLAB S.A.S., Cali, Colombia
hexlabsecurity@proton.me


