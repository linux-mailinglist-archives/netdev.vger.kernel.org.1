Return-Path: <netdev+bounces-182001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792CBA874D2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 00:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7287F16050B
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 22:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D63019885F;
	Sun, 13 Apr 2025 22:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b="AxyU4evI"
X-Original-To: netdev@vger.kernel.org
Received: from mx01.frank.fyi (mx01.frank.fyi [5.189.178.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6038A1946AA
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 22:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.189.178.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744585021; cv=none; b=GRG5K0s1r3coDnLMmB0xLzhV3dUCy+68hGMJsWWYEv1NKI8vwpOgsSYm5X1+Fr2O9MFJkk1cDA2nuDc/9TWgC/f2GRFz1TxmBsO6Ibnf2tWsIMDLtB/bIURJr7EshlC91kDBejE+9Za1+N4/5E/10H/xb0dXAR5O3Rkp2xMlOXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744585021; c=relaxed/simple;
	bh=WkHQmS/XzH9hb69sm8D0SwJxvdp3CBHAdp24qoCi4oE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N2KneFzYcVvwJvjeiVoK7MBHHii3g1LWk+Sudf5FfP2HPhYNFfqXjmI9V9lJk/ywpcVxNErriEg+cYN9ST8o6yHCy7kIGFMWYyUxfnSy51OvqrRn1A+o2ByueAcAR7xs0cI5erSg2LJEMeVR3yXjz4ILs8aJpZOI3yNUttBKxHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi; spf=pass smtp.mailfrom=frank.fyi; dkim=pass (2048-bit key) header.d=frank.fyi header.i=@frank.fyi header.b=AxyU4evI; arc=none smtp.client-ip=5.189.178.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=frank.fyi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frank.fyi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=frank.fyi; s=mail;
	t=1744585017; bh=WkHQmS/XzH9hb69sm8D0SwJxvdp3CBHAdp24qoCi4oE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=AxyU4evI0RyIzZ3MquPm0BjNrJAEMydM9haaE77RitN6sviUo3iDGCDZy4xJCuPu9
	 4xw5/I2favITgT2arnEDX3cplD4lDoDHQ1HNxf87KEP4lxzmTSycI+pTJ8A8H9usrT
	 u/yXiCL5ROaSnHf4alil7IQbjKEPn8k2ybNpvRlw1B5eVjIDVwIse9xBci4LQ79ouc
	 lCEsN+w9MuDjvXqACvFldF8iUbBqxj7BM+WZcKvmUYvWkp8dx2pS2iLQy1oE8VJNI4
	 brNOhn20Vb735QMd94MwsrOe48IRJXwqBkEgIcUtT2QUen3BxJ0VcPzl6sneCCwu2g
	 Q8k4+XZWcv2Wg==
Received: by mx01.frank.fyi (Postfix, from userid 1001)
	id 16BC21120180; Mon, 14 Apr 2025 00:56:57 +0200 (CEST)
Date: Sun, 13 Apr 2025 22:56:57 +0000
From: Klaus Frank <vger.kernel.org@frank.fyi>
To: jon@unidef.net, netdev@vger.kernel.org
Subject: Re: Is there a way for ifconfig to return wan ip addresses?
Message-ID: <3cde6506-821c-43f9-a53e-4ddddbb90f79@frank.fyi>
Reply-To: netdev@vger.kernel.org
User-Agent: Mozilla Thunderbird
References: <711321ED-4C88-4006-8612-B7699E838481@unidef.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE, en-US-large, en-US
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <711321ED-4C88-4006-8612-B7699E838481@unidef.net>

Hi,

the short or the long answer?
The short answer "yes, but no".
Also your router may not even know your wan ip either (in case of CG-NAT).

The long anser:
It is quite complicated as there are way too many "standards" for this 
and none of them is universal. Basically you'd have to try a bunch of 
different approaches and somehow also figure out what to do with 
conflicting information. I'll provide them as a kind of list as maybe 
one of them alone (without having a truely universal algorithm for it) 
may be enough. Further I'm going to assume you mean for IPv4 as in an 
IPv6 network you'd already have your GUA(s) on your interface (well, or 
at least on a interface, not necessarily the upstream one but anyway 
thats a different topic).
* RFC 7788 "Home Network Control Protocol"
* RFC 7618 "Dynamic Shared IPv4 Allocation"
* RFC 6886 "NAT Port Mapping Protocol (NAT-PMP)"
* RFC 6970 "Universal Plug and Play (UPnP) Internet Gateway Device - 
Port Control Protocol Interworking Function (IGD-PCP IWF)"
* RFC 7291 "DHCP Options for the Port Control Protocol (PCP)"
* RFC 7225 "Discovering NAT64 IPv6 Prefixes Using the Port Control 
Protocol (PCP)"
* RFC 2663 "IP Network Address Translator (NAT) Terminology and 
Considerations" See address binding and e.g. RSIP, RSA-IP, RSAP-IP in 
Section 5
* RFC 3022 "Traditional NAT" Section 5.3 says your border router may 
allow some hosts to use public IPs and may (without mentioning how) 
advertise information (like the public IP) from the public link to them.
* [RFC 5597 "NAT DCCP Requirements" Section 1: "Also, a separate, 
unspecified mechanism may be needed, such as Unilateral Self Address 
Fixing (UNSAF) [RFC3424] protocols, if an endpoint needs to learn its 
own external NAT mappings."]
* RFC 3424 "IAB Considerations for UNilateral Self-Address Fixing 
(UNSAF) Across Network Address Translation"
* RFC 2766 "Network Address Translation - Protocol Translation (NAT-PT)"
* RFC 2765 "Stateless IP/ICMP Translation Algorithm (SIIT)" can be 
parsed out of the statelessly translated IPv6 address interestingly that 
RFC also mentions "Determine when (...) needs to be allocated and then 
allocation needs to be refreshed/renewed" but it doesn't mention how to 
do this.
* MIPv6 RFC 3519, RFC 5944, ...: But doesn't specify how the 
implementation looks like, just that it is needed. "In the presence of 
NATs, an improved solution would require the ability to discover the 
translations done by each NAT along the route"
* RFC 3027 "Protocol Complications with NAT" Section 2.3, and 5
* draft-ermagan-lisp-nat-traversal-20 "NAT traversal for LISP" also 
specifies a way to discover the public IP
* Host_Identity_Protocol RFC 9028 and RFC 5207 Section 4
* RFC 8445, RFC 8489, RFC 5245, RFC 8656, RFC 5128, 
draft-rosenberg-mmusic-ice-nonsip-01 aka. ICE, STUN, TURN, WebRTC, SIP, ...
* RFC 5853 "Requirements from Session Initiation Protocol (SIP) Session 
Border Control (SBC) Deployments" Section-3.4.2
* RFC 2205 "Resource ReSerVation Protocol (RSVP)" + RFC 6780 "RSVP 
ASSOCIATION Object Extensions"
* RFC 7599, RFC 7598, RFC 6145 "MAP-T"
* RFC 7597, RFC 7598, RFC 2473 "MAP-E"
* RFC 6346 "The Address plus Port (A+P) Approach to the IPv4 Address 
Shortage"
* RFC 7600 "IPv4 Residual Deployment via IPv6 - A Stateless Solution 
(4rd)" by reversing the address mapping or if the CE supports it using 
one of the other approaches.
* TR-069 CWMP (WAN/ISP side)
* TR-064 LAN side
* "curl -4 https://ifconfig.co"


But if you're asking for advice on how to handle this I'd say:
1. Try to go IPv6-first and/or IPv6-mostly, just way less headach and 
better performance.
2. Where not possible either go the kinda radical way and use tor or i2p 
as an overlay and have them deal with nat traversal or if that is 
undesirable use something like libp2p or a webrtc library.
3. If all of that doesn't work try to connect to and proxy through a 
TURN server.
4. If that also doesn't work try to connect to a HTTP(S) proxy that 
supports HTTP-CONNECT tunnel
5. (no experience so far, but is newer and could work in some 
environments) the *-over-QUIC RFCs (RFC 9250, RFC 9221, RFC 9000, RFC 
9220, RFC 9484, RFC 9298, RFC 9297, and ongoing drafts: 
https://datatracker.ietf.org/wg/masque/documents/)

Tbh I personally when neither going IPv6-only or working around the v4 
NAT with e.g. a VPN isn't an option would just use tor, i2p, libp2p, or 
Yggdrasil as my overlay and let them deal with the hard parts. Basically 
I'd use e.g. the Tor Projects Arti project as my transport layer 
https://gitlab.torproject.org/tpo/core/arti Tor and i2p have the added 
benefit of being fully End-to-End encrypted and the endpoint addresses 
being unambiguous and cryptographically ensured.

Also just a note if you're leaving the SOHO and SMB environments and 
also having to deal with enterprise networks then you basically don't 
have any way to autodetect this as there are ofte multiple (literally 
countless) nats to different public IPs depending on destination, 
protocol, or even network saturation. You basically have to let the 
admin/user provide one manually.
(And side note, I also have already used it to link stuff together 
without a centralized public server)


Sincerely,
Klaus Frank

On 2025-04-13 10:51:29, Jon wrote:
> Maybe by interfacing with the router?
>
> You can somehow send some kind of query to the router using router protocols, and it’ll process a return packet with the wan ip address I think, per wan ip address attached to the router
>
> Or you can flat out make a standard for all routers to adhere to when returning wan ip addresses, along with others stuff like live latency checks or some kind of network security module
>
> Or someone awesome can implement some kind of protocol or handshake method for linux router distributions to return the wan ip address directly from the linux router
>
> I think my packet thing will work
>
> You can send a packet through the lan network, and it should return the wan ip address, I think, just through multiple layers or something



