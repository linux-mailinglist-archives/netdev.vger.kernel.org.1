Return-Path: <netdev+bounces-255302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCfgEi1dfWnKRgIAu9opvQ
	(envelope-from <netdev+bounces-255302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:38:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FE8C00A3
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E06D300D442
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDB92FD1DB;
	Sat, 31 Jan 2026 01:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammer065.de header.i=@hammer065.de header.b="RkdZmJjY"
X-Original-To: netdev@vger.kernel.org
Received: from omashu.hammer065.de (omashu.hammer065.de [78.46.39.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E02BEC55
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.39.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823530; cv=none; b=oqnmU5WM/HwOt8pntwx0FCN0gtiFqrMI3XFIsN9pPW0+3+H3HzUUGm5gg4Tou7IHkHdU4YQ1WK23L18D0TIkED4DAQLJTry8F3czI+90SO3U5URpDtfGR7tLuctTeLY4c4EabAn1Oe1zncLtz5Bq7IotxusK0VpJCvWeC0FcT9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823530; c=relaxed/simple;
	bh=dvbpuBgfHkXvI74jwsIi70OCwWGSabjyNTtw1X9EsBQ=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=lc/J1ChXVJ10q6hiLG7+VsvvxuqRTw5PGK55fPBxGS1IieMjqnJ/b6cStz/vf8pFeMaFHETNqOkIFbq0E3j8y9O+3GDbyqlSz5Xr7VUURWTnMauTGmHnLbGfQEp5CyZPjXVib+Kp0kcXPF+O6UImD8d688Gp53LAQXzpgdgURBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hammer065.de; spf=pass smtp.mailfrom=hammer065.de; dkim=pass (2048-bit key) header.d=hammer065.de header.i=@hammer065.de header.b=RkdZmJjY; arc=none smtp.client-ip=78.46.39.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hammer065.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammer065.de
From: hammer065 <hammer065@hammer065.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammer065.de;
	s=dkim; t=1769822936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TsTvVyiUF/FkiGnwPy6wcq92IsSNiO4BYxtZJZk8CUg=;
	b=RkdZmJjY/ldtvZWW11z53acUH8tzfCEHXVZ4sudguhVmCQK3oYlZIrkiybdvIsKEGa1PWy
	6EWWu0vVK43EnNLl66+9kMDUwaU4q4xjtbdXbylbj9+hdF34tioBBMocORzFHaoowmNl3y
	XH/a/Vhms1APDgV1uPGO3DzSP38Pm0v8JxH60Btul+7Vm0tOEjlu1RGwfXLg5AsQrOywWD
	M/HwIjd+4YZjAQpA5pF6koroJR2L2KxIh/VEnSbyYs364idSbs2OWqlNkLkzm9NmXa4Dsa
	MpaT2bJcLWpG7C/C200iOJ1UxkoJw2PCHsdE3EW/lP+2T3m4LFwT1szLf0mF1g==
Authentication-Results: omashu.hammer065.de;
	auth=pass smtp.mailfrom=hammer065@hammer065.de
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH net] ip6_tunnel: use skb_vlan_inet_prepare() in
 __ip6_tnl_rcv()
Message-Id: <37F1606C-F47C-4E56-8EA2-BC0D1CCAB835@hammer065.de>
Date: Sat, 31 Jan 2026 02:28:40 +0100
Cc: Hirokazu MORIKAWA <morikw2@gmail.com>,
 davem@davemloft.net,
 eric.dumazet@gmail.com,
 horms@kernel.org,
 kuba@kernel.org,
 netdev@vger.kernel.org,
 pabeni@redhat.com,
 syzbot+d4dda070f833dc5dc89a@syzkaller.appspotmail.com
To: Eric Dumazet <edumazet@google.com>
X-Spam-Level: **
X-Spamd-Bar: ++
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hammer065.de,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hammer065.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255302-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,kernel.org,vger.kernel.org,redhat.com,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hammer065@hammer065.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[hammer065.de:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,d4dda070f833dc5dc89a];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hammer065.de:mid,hammer065.de:dkim]
X-Rspamd-Queue-Id: 96FE8C00A3
X-Rspamd-Action: no action

Hello together,

I=E2=80=99ll chime in as I was the original reporter of the downstream =
issue at OpenWRT:
https://github.com/openwrt/openwrt/issues/21737

> Can you provide detailed instructions ?
When setting up an ipip6 (IPv4 in IPv6) tunnel on top of another =
(IPv6-only) interface,
received ipip6 packets do not get decapsulated to the tunnel interface.
However, one can see that they get received on the parent (IPv6-only) =
interface.


Steps to reproduce:
1. Have an IPv6-only interface, which has access to another server which =
receives and answers ipip6 packets (for example an AFTR server of your =
ISP).
2. Create an ipip6 tunnel interface, using the afore mentioned interface =
as a =E2=80=9Eparent=E2=80=9C and use it as a NAT.
3. Send *any* IPv4 packet (in this example an ICMP ping) which then gets =
encapsulated as an ipip6 packet.

Local IPv6 device <-IPv6-> AFTR-Server / Remote IPv6 <-IPv4-> Remote =
IPv4

ip a:
xx: ipv6-only: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue =
state UP group default qlen 1000
    link/ether
    inet6 [Local IPv6]/128 scope global dynamic noprefixroute
       valid_lft forever preferred_lft forever
yy: ipip6-tunnel@ipv6-only: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1460 =
qdisc noqueue state UNKNOWN group default qlen 1000
    link/tunnel6 [Local IPv6] peer [Remote IPv6] permaddr =
abcd:ef01:2345::
    inet 192.0.0.2 peer 192.0.0.1/32 brd 255.255.255.255 scope global =
ipip6-tunnel
       valid_lft forever preferred_lft forever

ip -6 t:
ipip6-tunnel: ip/ipv6 remote [Remote IPv6] local [Local IPv6] dev =
ipv6-only encaplimit none hoplimit 64 tclass 0x00 flowlabel 0x00000 =
(flowinfo 0x00000000)


Expected:
When the AFTR server sends the ipip6 encapsulated response packet, it =
gets decapsulated on the tunnel interface as an IPv4 packet.

tcpdump -i ipv6-only:
IP6 [Local IPv6] > [Remote IPv6]: IP 192.0.0.2 > [Remote IPv4]: ICMP =
echo request, id 56869, seq 0, length 64
IP6 [Remote IPv6] > [Local IPv6]: IP [Remote IPv4] > 192.0.0.2: ICMP =
echo reply, id 56869, seq 0, length 64
IP6 [Local IPv6] > [Remote IPv6]: IP 192.0.0.2 > [Remote IPv4]: ICMP =
echo request, id 56869, seq 1, length 64
IP6 [Remote IPv6] > [Local IPv6]: IP [Remote IPv4] > 192.0.0.2 ICMP echo =
reply, id 56869, seq 1, length 64

tcpdump -i ipip6-tunnel:
IP 192.0.0.2 > [Remote IPv4]: ICMP echo request, id 56869, seq 0, length =
64
IP [Remote IPv4] > 192.0.0.2: ICMP echo reply, id 56869, seq 0, length =
64
IP 192.0.0.2 > [Remote IPv4]: ICMP echo request, id 56869, seq 1, length =
64
IP [Remote IPv4] > 192.0.0.2: ICMP echo reply, id 56869, seq 1, length =
64


Actual (due to the mentioned commit):
The ipip6 packet does not get decapsulated, so only the sent IPv4 =
packets are present on the tunnel interface.
However, the ipip6 packets get properly received on the parent =
interface.

tcpdump -i ipv6-only:
IP6 [Local IPv6] > [Remote IPv6]: IP 192.0.0.2 > [Remote IPv4]: ICMP =
echo request, id 56869, seq 0, length 64
IP6 [Remote IPv6] > [Local IPv6]: IP [Remote IPv4] > 192.0.0.2: ICMP =
echo reply, id 56869, seq 0, length 64
IP6 [Local IPv6] > [Remote IPv6]: IP 192.0.0.2 > [Remote IPv4]: ICMP =
echo request, id 56869, seq 1, length 64
IP6 [Remote IPv6] > [Local IPv6]: IP [Remote IPv4] > 192.0.0.2 ICMP echo =
reply, id 56869, seq 1, length 64

tcpdump -i ipip6-tunnel:
IP 192.0.0.2 > [Remote IPv4]: ICMP echo request, id 56869, seq 0, length =
64
IP 192.0.0.2 > [Remote IPv4]: ICMP echo request, id 56869, seq 1, length =
64


> I have no idea what MAP-E or DS-Lite are.
I have no idea what MAP-E is, but Dual-Stack-Lite is a way for ISPs to =
save on IPv4 addresses
by providing a CG-NAT in form of an dedicated AFTR server, which receive =
and respond to ipip6 packets
and therefore providing access to the IPv4 internet with customers only =
receiving an IPv6 address(-range).

I hope this clears everything up. If not, feel free to ask further =
questions about the issue. :)
If it helps, I can provide a bare-bones example config for OpenWRT to =
test against.

Best regards,

-- hammer065=

