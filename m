Return-Path: <netdev+bounces-300191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zU83LMStMmoi3gUAu9opvQ
	(envelope-from <netdev+bounces-300191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:23:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ADC69A7F6
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 16:22:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=digikod.net header.s=20191114 header.b=OGam9oUy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300191-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300191-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83C40301F309
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0618425CEE;
	Wed, 17 Jun 2026 14:22:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91333217F27
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 14:22:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781706173; cv=none; b=kQmrIb0MQA6NWsXN5goWplDKy1FbHEkpy4oekDtJ3EsrsWStswK5TzcTpZMMMRgm4ZgvteGW4cWazuU/wSShyMd2GJiyuOc5Kxyiz6q6I/yDovZTcZfCZ9BEk/4oH9D+otkeg7b8PXOdoUi9/0hvAPLuP+e5+DsBrryDTP9tIEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781706173; c=relaxed/simple;
	bh=DW6zU2zOMsFZI7KDUAES4xQ9+xPurQXeOEmfIhtkeF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BugLNtCOYYeuAaZNvGSJuh6Fw/p0vBgyiOAybieVE2eVL1PvbSHRNCGkQxHlTNVmq9YSZGv+uJv55P8CFT1SL0we5enc88eAKyvw8wu+mj9BFHkLGYdzUOScwjOq9VPAQhlzCmIYB5Ktwa+C9W/Beww2/NyaZqBJ14zAsvlfpd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=OGam9oUy; arc=none smtp.client-ip=45.157.188.9
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ggR0415QKzd9x;
	Wed, 17 Jun 2026 16:22:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781706163;
	bh=RwmEzQ+Rlqy195PCTmMZLaQG5VPFhIgJkiiDmwpaCho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGam9oUyF651V2o8AF4gyiC7WhSJX0Z2Xg5DajQ328tL9+z+4b9pmmPCZvYYsnT41
	 JarXu/ulqHSKkcucaecD+bJo9k0UQrWzYaxkidJsq36yFHHNh76xPa9Lv6H+gFYPUB
	 ClJOmm/S5AiRqMGF9E6t2p04hRcEfQt+mtZaiOOI=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ggR031zwnzYCV;
	Wed, 17 Jun 2026 16:22:43 +0200 (CEST)
Date: Wed, 17 Jun 2026 16:22:37 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Paul Moore <paul@paul-moore.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Subject: Re: Landlock: LANDLOCK_ACCESS_NET_CONNECT_TCP bypass via TCP Fast
 Open
Message-ID: <20260617.eemahv8ui7Ee@digikod.net>
References: <20260616201615.275032-1-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616201615.275032-1-hexlabsecurity@proton.me>
X-Infomaniak-Routing: alpha
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.75 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.91)[subject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[digikod.net:s=20191114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300191-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[digikod.net:+];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:gnoack@google.com,m:matthieu@buffet.re,m:paul@paul-moore.com,m:edumazet@google.com,m:ncardwell@google.com,m:linux-security-module@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ivanov.mikhail1@huawei-partners.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[digikod.net];
	FORGED_SENDER(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mic@digikod.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,digikod.net:dkim,digikod.net:mid,digikod.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86ADC69A7F6

Hi,

Thanks for the report.  This was previously identified by Mikhail and
Matthieu, see the related issue:
https://github.com/landlock-lsm/linux/issues/41


On Tue, Jun 16, 2026 at 08:16:22PM +0000, Bryam Vargas wrote:
> Hello Mickaël, and Landlock folks,
> 
> A task confined by a Landlock ruleset that handles
> LANDLOCK_ACCESS_NET_CONNECT_TCP and is denied connecting to a given port can
> still establish a TCP connection to that port by using TCP Fast Open, i.e.
> sendto(fd, ..., MSG_FASTOPEN, &dst, dstlen) on a fresh stream socket. The
> network-egress confinement for TCP connect is silently bypassed.
> 
> Affected
> --------
> Any kernel with CONFIG_SECURITY_LANDLOCK=y and Landlock enabled that supports
> the TCP network access rights (Landlock ABI >= 4, since Linux 6.7). Confirmed by
> source inspection on mainline (v7.1-rc7) and reproduced on Linux 7.0.11
> (Landlock ABI 8). No CONFIG beyond Landlock + IPv4/IPv6 TCP; TCP Fast Open client
> is enabled by the per-netns default (net.ipv4.tcp_fastopen has TFO_CLIENT_ENABLE
> set), so no sysctl change and no setsockopt are required.
> 
> Root cause
> ----------
> LANDLOCK_ACCESS_NET_CONNECT_TCP is enforced only by the socket_connect LSM hook
> (hook_socket_connect -> current_check_access_socket). security_socket_connect()
> has exactly one call site in the tree, net/socket.c (the connect(2) syscall).
> 
> TCP Fast Open performs an implicit connect inside sendmsg:
> 
>   tcp_sendmsg_locked()            net/ipv4/tcp.c  (MSG_FASTOPEN branch)
>    -> tcp_sendmsg_fastopen()      net/ipv4/tcp.c
>    -> __inet_stream_connect(..., is_sendmsg=1)  net/ipv4/af_inet.c
>    -> sk->sk_prot->connect()      net/ipv4/af_inet.c  -> tcp_v4_connect()
> 
> This path establishes the connection to the address taken from msg_name but
> never calls security_socket_connect(). The only LSM hook fired on the sendmsg
> path is security_socket_sendmsg(), and Landlock registers no socket_sendmsg
> hook, so LANDLOCK_ACCESS_NET_CONNECT_TCP is never re-checked. __inet_stream_connect()
> itself carries no LSM hook (only the cgroup-BPF pre_connect, a different
> mechanism).
> 
> Notably the kernel already mediates the analogous AF_UNIX implicit-connect on the
> send path via the unix_may_send hook, which Landlock does register
> (hook_unix_may_send) -- so the sendmsg-implies-connect pattern is recognized, but
> the TCP Fast Open case has no equivalent coverage. The MPTCP fast-open path
> (mptcp_sendmsg_fastopen -> __inet_stream_connect) is a second producer of the
> same unmediated connect (by source inspection; not separately reproduced).
> 
> Reproducer
> ----------
> A self-contained, fully unprivileged PoC is available on request. It forks an
> unconfined TFO-capable loopback listener, then in a child applies a Landlock
> ruleset handling LANDLOCK_ACCESS_NET_CONNECT_TCP with no allow rule
> (landlock_create_ruleset() with handled_access_net =
> LANDLOCK_ACCESS_NET_CONNECT_TCP, no landlock_add_rule(), then
> landlock_restrict_self(); every TCP connect is denied) and tries the forbidden
> port two ways:
> 
>   (1) connect(fd, &dst)                 -> -EACCES   (Landlock enforces CONNECT_TCP)
>   (2) sendto(fd2, buf, len, MSG_FASTOPEN, &dst, dstlen)
>                                         -> succeeds; the listener accepts the
>                                            connection and reads the payload.
> 
> Observed on Linux 7.0.11 (Landlock ABI 8):
> 
>   [1] connect(2)            -> ret=-1 errno=13 (Permission denied)
>   [2] sendto(MSG_FASTOPEN)  -> ret=14 errno=0 (OK/queued)
>   [+] listener ACCEPTED the confined child's connection; payload="..."
> 
> connect(2) to the port is denied while sendto(MSG_FASTOPEN) reaches the identical
> port and delivers data.
> 
> Impact
> ------
> A sandbox that uses LANDLOCK_ACCESS_NET_CONNECT_TCP to restrict outbound TCP
> (e.g. to keep a confined component from reaching an internal service or a
> metadata endpoint) can be escaped by an unprivileged, self-confined task with no
> CAP and no namespace transition -- for any destination port, since the
> implicit-connect path never consults the connect hook regardless of address (the
> run above shows one port). It is an integrity
> bypass of the network-confinement property; no memory safety is involved.
> I score it CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:C/C:N/I:H/A:N (6.5 Medium) -- the
> confined task escapes the policy authority that defined its sandbox, a scope
> change; 5.5 if you treat the Landlock boundary as the same authority (S:U).
> 
> Note on the in-flight UDP series
> --------------------------------
> The "landlock: Add UDP access control support" series (v5, Matthieu Buffet,
> https://lore.kernel.org/r/20260611162107.49278-3-matthieu@buffet.re) adds a
> socket_sendmsg hook, hook_socket_sendmsg(), but it returns 0 for non-UDP
> sockets:
> 
>     if (sk_is_udp(sock->sk))
>             access_request = LANDLOCK_ACCESS_NET_CONNECT_SEND_UDP;
>     else
>             return 0;
> 
> so a TCP socket using MSG_FASTOPEN still bypasses LANDLOCK_ACCESS_NET_CONNECT_TCP
> even after that series lands. It may be most convenient to fix this there.
> 
> Suggested direction
> -------------------
> Re-check LANDLOCK_ACCESS_NET_CONNECT_TCP on the implicit-connect path: either have
> the socket_sendmsg hook evaluate CONNECT_TCP for stream sockets when the call
> performs an implicit connect (mirroring the AF_UNIX unix_may_send handling), or
> place the check inside __inet_stream_connect() so a single chokepoint covers
> connect(2), TCP Fast Open, and the MPTCP fast-open sibling.
> 
> I am happy to send a patch for this if you would like me to.

Yes please.

> 
> Best regards,
> 
> Bryam Vargas
> Independent security researcher, HEXLAB S.A.S., Cali, Colombia
> hexlabsecurity@proton.me
> 
> 

