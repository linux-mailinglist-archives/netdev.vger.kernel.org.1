Return-Path: <netdev+bounces-307715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mssNHRJQV2paJAEAu9opvQ
	(envelope-from <netdev+bounces-307715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:17:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A22F875C593
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:17:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=fastmail.im header.s=fm2 header.b=RSCwVxn2;
	dkim=pass header.d=messagingengine.com header.s=fm2 header.b="F vzY+MM";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307715-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307715-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=fastmail.im;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 476EB3091879
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B3E3EB0F6;
	Wed, 15 Jul 2026 09:07:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A473C2B80
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 09:07:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106437; cv=none; b=iyiJH/j9e3c8YhSCporEfb76gog33y/cDN/smfhoNYN+EDVzkLmtoDBdLt9BJy6Q8bKmDgYWd3nG6JhB6xshaODKezP7FgF14EvZmyaer2VYNn6qkKW71+ZIJ2X0U+t0bVzj2zKetgdfQ2nmkI38IpZK/3U3ZpnufnBmPVC9bjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106437; c=relaxed/simple;
	bh=GYrJ/0FAhOiqcnhdZ6VGpsC8yVn5h4fiX6kDivkZ2WE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=U2gdJuFp/7eCtGd5b2RJ9uWebgFdCJ4jvP1uNcw2FXbbVAtMpMMr4TEzoK5AgwwuAqlrV8CZPoK6B0/STY+CU28p2nIsobcPc3Sh5N7gCfq2i74sOXAlN8xC9ZGJwS+IBPj2+LUjPHEJPLWzwyRdlKH9kkLQobZlWQiM33pcWxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=RSCwVxn2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FvzY+MMC; arc=none smtp.client-ip=103.168.172.142
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailflow.phl.internal (Postfix) with ESMTP id 295C51380017;
	Wed, 15 Jul 2026 05:07:13 -0400 (EDT)
Received: from phl-imap-03 ([10.202.2.93])
  by phl-compute-10.internal (MEProxy); Wed, 15 Jul 2026 05:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784106433;
	 x=1784113633; bh=mBLbhtUzs6efT6n92VdCknqZiLLsM3XciT2X2Wkrp78=; b=
	RSCwVxn2HE4Mhob5jllxAzsmzutoV+ciH3BirwFlrZ9TB3p8MJzhPaZ4qWvBwl32
	Tg6z8D/Qbc+Q98r6fXmRSwllJdl830PJGFV54RJ20Fb29vPz1pjsrB9C2mSUvVjF
	vrtbPL1BEIWygIU4qjuQGHUxPWaHPOgcN5xB4Uh4uO9euQct5f/QBFF5bo3V2u4B
	UmZoQ5iK1RJAZ/8nmuM6RNNtZTrf7rBOt6pR+Pz/0ZsDt4Sp3bhsJduIPXhh3H/7
	f6cFue49WsIOL7/TnzhiKc2pdpCc8u3Gjo9KGcmHUP4UfjLhHPKk0Ok30i0GVHWq
	mazCfVy8+ZY6wnGmEDivCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784106433; x=
	1784113633; bh=mBLbhtUzs6efT6n92VdCknqZiLLsM3XciT2X2Wkrp78=; b=F
	vzY+MMCZtZMV8TzeL+OJcoKDxl+dqHQlkEXAdGe6NuXhk44McqXpj7rp/tYZzCzf
	bAKzPGbbW+jGmXBcjwcS+/ctHYmaQ14ZWjAk0Ii8PH1nJeYQc90peRPjUbJOYNaL
	YEWj6NKTudBiRIxxrZ2GnX9kOC1tXZhulNLXYitAJkaWjdHrhgXkasCO4Ko9o3zF
	ZipYhdPNpJeEcHEV6RU8kfUfIPukCj74Jj/cTfg8WxAlKKZDHt2o0zEZt0jRbHfB
	k9+2EFuhUZNLy+/G6FgS9WRWOQkJ0BKg1mbwKGrHhi4v8QT7f+E9OdOWg/nw1Ubz
	kJ1cjwyfm5tkt993npDsQ==
X-ME-Sender: <xms:v01Xak2B028_E8AuUMovwcVabMVBqLNd6WHGWDs2sawXhvONImzjyA>
    <xme:v01Xap4PxHebWQ8gDEvzAa0yGk3NdG9wCuY1wON1dQJii94_a7IiT1UYjMT2EuaTS
    29mu6gxHFvh56m_W4FHwdekuuOUvi-WhYANNJJmvSKJ-DbAs0RhgAQ>
X-ME-Proxy-Cause: dmFkZTF0ivpkm8c2GkqassHOsFbpF4p2wG8S8Cfs7zYx0qh76U7ML0VVnC7dz5u9O3Agya
    CohnpNWhv1LmnRzdn/oe53qtuyZg9eJ8RiG9AWzrbKNyDK71x49kChKH8r9KjwByKdfvjF
    eYvXJC4r6djQ/brr3dkiy4GtbZP4Ysi0RRYB30IthZ292dwBJmBWXchDh2JBXOi4y3gOfk
    Tlqu2FzpWXIiLFJweUzWuAuxsKebtaarT9W1RCcwzac/mVfsp2jUxacTPuD31FzK7WiiF/
    NXjKJsbWktUzitJ8ZXYHHgqQVT7O46Y84lifUKHp+3e5vGn/Z1Md6/e644BqDRyvi4/cDe
    4Bs9QdzvQethkdLMeEqUp1zt95ZmBSizX9R65wnHDB/ER51CEUmQxkLjZw56gTgPcPxemz
    RBoxGDVumUslHeOffoRZsr20DMxGQdW7nozDmXN3pnCQSOrSXb34eGSdL9fAVCGg27uHD0
    3WfqlM1vFZaJAyaOYxT+ZTB9BLXcjvb8TkHf9dIvCPkaytHn2qxVyjdExFtiTbWmUmIFaU
    Jlzmrz+b2zadwYUgkAieopgmuqxgQDhklzmTijonA45b9hMVv/fMZs0AI+L8lysQXEVdWV
    bbZeVENljJiK9jo7hfL/JNjx0i539ioJLunL4PqUgWxbQWanjHBYw0/Ly/jA
X-ME-Proxy: <xmx:v01XavGsTysH8h4PoJk5xCafKf5orA1d5h7Q6tNyUtPcGfvXlbZ3xQ>
    <xmx:v01Xaph_sYhakldqK8IBmSZbbE9da8tlYLc_WM-dTTry_1yrVjWtxQ>
    <xmx:v01XalpcDRQM8yDjhFjzlN2bqJVrH5ly0hccL8PyZyVoqoRzswJB0w>
    <xmx:v01XapQ1as_T-Jf4fA1-5yzDaV82U6IsdjM3m4Dvqqntq53vKZcoZw>
    <xmx:wU1XavITWTuIl_oicrJVX2VzSk0cZaZqyhjMRvlaeelhmlfw9qaA1nLE>
Feedback-ID: i559e4809:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C7DA718E0074; Wed, 15 Jul 2026 05:07:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 15 Jul 2026 12:06:51 +0300
From: "Alice Mikityanska" <alice.kernel@fastmail.im>
To: "zebang.li" <zebang.li@samsung.com>
Cc: "Alice Mikityanska" <alice@isovalent.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, "David Ahern" <dsahern@kernel.org>,
 "Eric Dumazet" <edumazet@google.com>, "Florian Westphal" <fw@strlen.de>,
 "Simon Horman" <horms@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Xin Long" <lucien.xin@gmail.com>, netdev@vger.kernel.org,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Nikolay Aleksandrov" <razor@blackwall.org>, "Shuah Khan" <shuah@kernel.org>,
 "Stanislav Fomichev" <stfomichev@gmail.com>,
 "Willem de Bruijn" <willemb@google.com>,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>, nh78.kim@samsung.com,
 kwangho2.kim@samsung.com, h10.kim@samsung.com, hongfei.tang@samsung.com,
 yajie.yan@samsung.com
Message-Id: <ad089459-361c-4209-9fdc-675cc4a658bc@app.fastmail.com>
In-Reply-To: <a6f4c117-f58f-4cd7-910a-0fff3c3aeb27@blackwall.org> <(raw)>
References: <20260710134242.216538-1-alice.kernel@fastmail.im>
 <CGME20260715061259epcas5p378f743489493da324fc9092ed2dfe147@epcas5p3.samsung.com>
 <a6f4c117-f58f-4cd7-910a-0fff3c3aeb27@blackwall.org> <(raw)>
Subject: Re: [PATCH net-next v9 0/9] BIG TCP for UDP tunnels
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.im,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fastmail.im:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zebang.li@samsung.com,m:alice@isovalent.com,m:andrew+netdev@lunn.ch,m:daniel@iogearbox.net,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,m:kuba@kernel.org,m:lucien.xin@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:razor@blackwall.org,m:shuah@kernel.org,m:stfomichev@gmail.com,m:willemb@google.com,m:willemdebruijn.kernel@gmail.com,m:nh78.kim@samsung.com,m:kwangho2.kim@samsung.com,m:h10.kim@samsung.com,m:hongfei.tang@samsung.com,m:yajie.yan@samsung.com,m:andrew@lunn.ch,m:lucienxin@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.im];
	TAGGED_FROM(0.00)[bounces-307715-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fastmail.im:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice.kernel@fastmail.im,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[isovalent.com,lunn.ch,iogearbox.net,davemloft.net,kernel.org,google.com,strlen.de,gmail.com,vger.kernel.org,redhat.com,blackwall.org,samsung.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid,isovalent.com:email,fastmail.im:from_mime,fastmail.im:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A22F875C593

On Wed, Jul 15, 2026, at 09:11, zebang.li wrote:
> On 10/07/2026 16:42, Alice Mikityanska wrote:
>> From: Alice Mikityanska <alice@isovalent.com>
>> 
>> This series is a follow-up to "BIG TCP without HBH in IPv6", and it adds
>> support for BIG TCP IPv4/IPv6 workloads in vxlan and geneve. Now that
>> IPv6 BIG TCP doesn't require stripping the HBH in all various
>> combinations in tunneled traffic, adding BIG TCP becomes feasible.
>> 
>> Patch 01 adds accessors for the length field in the UDP header, as
>> suggested by Paolo in review. The usage of udp_set_len is then added in
>> the following patches that start using length=0 in BIG TCP UDP packets.
>> 
>> Patches 02-04 close the gaps that prevent BIG TCP packets from going
>> through UDP tunnel code.
>> 
>> Patch 05 validates packets in udp_gro_receive to exclude packets with
>> length=0 from GRO aggregation.
>> 
>> Patch 06 is for proper formatting in tcpdump (set UDP len to 0 rather
>> than a trimmed value on overflow).
>> 
>> Patches 07-08 bump up tso_max_size for VXLAN and GENEVE.
>> 
>> Patch 09 adds selftests.
>> 
>> Thanks all!
>> 
>> v9 changes: Converted the selftest to iptables counters to avoid the
>> issue with tcpdump pcaps taking all space in /tmp.
>> 
>> v8: https://lore.kernel.org/netdev/20260706181941.385672-1-alice.kernel@fastmail.im/
>> 
>> v8 changes: Addressed Paolo's and Jason's review comments. Made the
>> selftest more robust, added checks for SACK and mode with disabled tx
>> checksum offload on lower veth netdevs. Added details to commit
>> messages. Kept skb_segment logic unchanged, because the frags overflow
>> issue is not specific to BIG TCP.
>> 
>> v7: https://lore.kernel.org/netdev/20260611192955.604661-1-alice.kernel@fastmail.im/
>> 
>> v7 changes: Addressed Paolo's comments to properly block malformed
>> packets with UDP length=0 at udp_rcv level.
>> 
>> v6: https://lore.kernel.org/netdev/20260602093931.516281-1-alice.kernel@fastmail.im/
>> 
>> v6 changes: Lowered the packets threshold in the selftest to pass
>> upstream CI on debug kernels, also made it configurable.
>> 
>> v5: https://lore.kernel.org/netdev/20260526161200.1135899-1-alice.kernel@fastmail.im/
>> 
>> v5 changes: Rebased, dropped one of the patches that came in via the net
>> tree, addressed an overflow in nsim_do_psp found by Sashiko.
>> 
>> v4: https://lore.kernel.org/netdev/20260512165648.386518-1-alice.kernel@fastmail.im/
>> 
>> v4 changes: Rebased, addressed Sashiko AI review [1] and Willem's
>> comment about netperf flags.
>> 
>> My comments on Sashiko AI review per patch:
>> 
>> 01: I'd prefer to keep the cases that I haven't tested outside of the
>> scope of this series, which is for VXLAN/GENEVE tunnels, not for ESP.
>> 
>> 02: The patch doesn't have behavioral changes other than fixing the
>> checksum. The final uh->len assignment assigns the actual length, not
>> 64k.
>> 
>> 03: The check can't be loosened, because total_len is also assigned to
>> UDP length. BIG TCP works in the mode without GRO hint option.
>> 
>> 04: Fixed the fallback value for udplen. BIG TCP is fine, it's the
>> uh->len = 0 case, uh->len can't exceed 64k.
>> 
>> 05: In the BIG TCP case, partial GSO splits the SKB in two. If full
>> segmentation is needed, the SKB is split in many MSS-sized SKBs without
>> fragments.
>> 
>> 06: Invalid packets from the wire are addressed in 08.
>> 
>> 07: __udp_gso_segment only handles UDP GSO packets, which can't be
>> bigger than 64k. Kept udp_set_len_short in nf_nat_mangle_udp_packet, as
>> the function doesn't support BIG TCP packets anyway (see
>> mangle_contents).
>> 
>> 08: udp_gro_receive handles packets before aggregation, there are no BIG
>> TCP packets at this point. RFC 768 doesn't say that padded UDP packets
>> are valid. Real jumbograms don't seem to be supported in this path
>> anyway.
>> 
>> 09: The packet goes to skb_udp_tunnel_segment, not __udp_gso_segment.
>> __skb_udp_tunnel_segment handles this case.
>> 
>> 12: Improved process cleanup by killing everything inside netns before
>> deleting them, and by avoiding killing netserver outside of netns.
>> netperf with -r in TCP_STREAM mode works, and the option has the
>> intended effect, but I replaced it with -m. Added dependency check for
>> tcpdump.
>> 
>> [1]: https://sashiko.dev/#/patchset/20260410150943.993350-1-alice.kernel%40fastmail.im
>> 
>> v3: https://lore.kernel.org/netdev/20260410150943.993350-1-alice.kernel@fastmail.im/
>> 
>> v3 changes: Fixed the redirect in the selftest, rebased over my L2TP fix
>> [2] for the syzbot report [3].
>> 
>> [2]: https://lore.kernel.org/netdev/20260403174949.843941-1-alice.kernel@fastmail.im/
>> [3]: https://lore.kernel.org/netdev/69a1dfba.050a0220.3a55be.0026.GAE@google.com/
>> 
>> v2: https://lore.kernel.org/netdev/20260226201600.222044-1-alice.kernel@fastmail.im/
>> 
>> v2 changes: Addressed the review comments: added UDP len helpers,
>> consolidated UDP len sanity checks in patch 08 into one, added
>> selftests. Added fixups to related code (patch 01-03).
>> 
>> v1: https://lore.kernel.org/netdev/20250923134742.1399800-1-maxtram95@gmail.com/
>> 
>> Alice Mikityanska (8):
>>    net: Use helpers to get/set UDP len tree-wide
>>    net: Enable BIG TCP with partial GSO
>>    udp: Support BIG TCP GSO packets where they can occur
>>    udp: Support gro_ipv4_max_size > 65536
>>    udp: Validate UDP length in udp_gro_receive
>>    udp: Set length in UDP header to 0 for big GSO packets
>>    vxlan: Enable BIG TCP packets
>>    selftests: net: Add a test for BIG TCP in UDP tunnels
>> 
>> Daniel Borkmann (1):
>>    geneve: Enable BIG TCP packets
>> 
>>   drivers/infiniband/core/lag.c                 |   2 +-
>>   drivers/infiniband/sw/rxe/rxe_net.c           |   4 +-
>>   drivers/net/amt.c                             |   6 +-
>>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   2 +-
>>   drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   2 +-
>>   drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
>>   drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   2 +-
>>   .../marvell/octeontx2/nic/otx2_txrx.c         |   2 +-
>>   .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +-
>>   .../ethernet/mellanox/mlx5/core/en_selftest.c |   2 +-
>>   drivers/net/ethernet/sfc/falcon/selftest.c    |   4 +-
>>   drivers/net/ethernet/sfc/selftest.c           |   4 +-
>>   drivers/net/ethernet/sfc/siena/selftest.c     |   4 +-
>>   drivers/net/ethernet/sfc/tc_encap_actions.c   |   2 +-
>>   .../stmicro/stmmac/stmmac_selftests.c         |   4 +-
>>   drivers/net/geneve.c                          |   4 +-
>>   drivers/net/netconsole.c                      |   2 +-
>>   drivers/net/netdevsim/dev.c                   |   2 +-
>>   drivers/net/netdevsim/psample.c               |   2 +-
>>   drivers/net/netdevsim/psp.c                   |   8 +-
>>   drivers/net/vxlan/vxlan_core.c                |   2 +
>>   drivers/net/wireguard/receive.c               |   2 +-
>>   include/linux/udp.h                           |  27 +++
>>   include/trace/events/icmp.h                   |   2 +-
>>   lib/tests/blackhole_dev_kunit.c               |   2 +-
>>   net/6lowpan/nhc_udp.c                         |  10 +-
>>   net/core/pktgen.c                             |   4 +-
>>   net/core/selftests.c                          |   4 +-
>>   net/core/skbuff.c                             |  10 +-
>>   net/core/tso.c                                |   3 +-
>>   net/ipv4/esp4.c                               |   2 +-
>>   net/ipv4/fou_core.c                           |   2 +-
>>   net/ipv4/ipconfig.c                           |   6 +-
>>   net/ipv4/netfilter/nf_nat_snmp_basic_main.c   |   4 +-
>>   net/ipv4/route.c                              |   2 +-
>>   net/ipv4/udp.c                                |   7 +-
>>   net/ipv4/udp_offload.c                        |  49 ++---
>>   net/ipv4/udp_tunnel_core.c                    |   2 +-
>>   net/ipv6/esp6.c                               |   5 +-
>>   net/ipv6/fou6.c                               |   2 +-
>>   net/ipv6/ip6_udp_tunnel.c                     |   2 +-
>>   net/ipv6/udp.c                                |   7 +-
>>   net/ipv6/udp_offload.c                        |   2 +-
>>   net/l2tp/l2tp_core.c                          |   2 +-
>>   net/netfilter/ipvs/ip_vs_xmit.c               |   2 +-
>>   net/netfilter/nf_conntrack_proto_udp.c        |  15 +-
>>   net/netfilter/nf_log_syslog.c                 |   2 +-
>>   net/netfilter/nf_nat_helper.c                 |   2 +-
>>   net/psp/psp_main.c                            |   2 +-
>>   net/sched/act_csum.c                          |   4 +-
>>   net/xfrm/xfrm_nat_keepalive.c                 |   2 +-
>>   tools/testing/selftests/net/Makefile          |   1 +
>>   .../testing/selftests/net/big_tcp_tunnels.sh  | 188 ++++++++++++++++++
>>   53 files changed, 340 insertions(+), 102 deletions(-)
>>   create mode 100755 tools/testing/selftests/net/big_tcp_tunnels.sh
>> 
>
>
> Hi Alice,
>
> This patch looks promising, but I noticed that it does not include a 
> modification for `skb_gro_receive`.
>
> Currently, for UDP data aggregated via GRO, if the resulting packet 
> size exceeds 65536 (`GRO_LEGACY_MAX_SIZE`), this check will return 
> `-E2BIG`.
>
> To allow UDP GRO aggregation beyond this limit (similar to the existing 
> TCP behavior), we should update the condition to include `IPPROTO_UDP`.

Thanks for the feedback! That's a good idea for future development,
however, I'd like to keep the scope of this effort limited to BIG TCP.
The series is already big enough, and adding UDP GRO might be not as
trivial as it seems. At the very least, it requires adding another
selftest to cover the new paths. In the worst case, it might need more
tweaks in the datapath in case something breaks at later points in the
pipeline. Moreover, since UDP GRO is not transparent for the userspace
(unlike BIG TCP), the userspace might rely on assumptions about max
aggregation size, and this topic needs additional research.

To sum up, it's a good direction for further research, which can be done
independently after merging this series, but I'd rather keep the scope
of this series clear and limited to BIG TCP. Note that the current
version of skb_gro_receive doesn't block tunneled BIG TCP traffic, which
is proved by the selftest and manual testing.

Thanks,
Alice

> I suggest the following modification:
>
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 35f2f708f010..01e56ad629c2 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -117,7 +117,7 @@ int skb_gro_receive(struct sk_buff *p, struct 
> sk_buff *skb)
>                 return -E2BIG;
>         if (unlikely(p->len + len >= GRO_LEGACY_MAX_SIZE)) {
> -               if (NAPI_GRO_CB(skb)->proto != IPPROTO_TCP ||
> +               if ((NAPI_GRO_CB(skb)->proto != IPPROTO_TCP && 
> NAPI_GRO_CB(skb)->proto != IPPROTO_UDP) ||
>                     p->encapsulation)
>                         return -E2BIG;
>         }
>
> Thanks,
> zebang

