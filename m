Return-Path: <netdev+bounces-224701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0567B88803
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 11:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6D95A05D0
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35AA2BE638;
	Fri, 19 Sep 2025 09:01:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8C1CEACB
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758272512; cv=none; b=aTrMRyxZor7bIf56k4JdXtZb9XowE8jehhFOzCm4h3BmNGu4bjIZvloP0yYi1JoMRXoVx8Z2JWBYWyM1eKCvc9DlD5B/HgzfeR1ZVERyqd5xOxvbcKkE0nUsHAmEbsKKWr3qLu3gtibM5YQdeQCUa0VI7p6zldBT2RpweJ3sph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758272512; c=relaxed/simple;
	bh=MQfLE7RaPJT/JClthmUYPQ+x05fhr6/BNuiKRhWUfII=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eEZHRdUclnYprShS4hkPzboXmjU3hnCGgpkbzevOvaLKH+FRm5b5EFNwgGWVwIS7AW7SHxcngJS2txLRojNG/zjXOUHj913J5ZXX70LwwTdUXosoA3nyi8TZlAxn0amtWc5xk2sEvslEchPtDzwdvtgFzv9wuK9RJLDMPXN/bpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz6t1758272479t66a0470a
X-QQ-Originating-IP: nYVQsPafpZCe8iH2VJZM0C2GEUBe1md+Ilx8KVdGPH4=
Received: from smtpclient.apple ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 19 Sep 2025 17:01:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12964140934289989908
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH RESEND iproute2-next] ip/bond: add broadcast_neighbor
 support
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <8eba0896-3156-474e-8521-c345d6d2e11c@gmail.com>
Date: Fri, 19 Sep 2025 17:01:07 +0800
Cc: netdev@vger.kernel.org,
 Stephen Hemminger <stephen@networkplumber.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9DB0492E-33D8-4478-B228-CAE5AEAC2D2C@bamaicloud.com>
References: <20250914070609.37292-1-tonghao@bamaicloud.com>
 <8eba0896-3156-474e-8521-c345d6d2e11c@gmail.com>
To: David Ahern <dsahern@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M8JnMGwRo1mQZH/4EN3UqMl20QDE7oKN/WK4VCFUGlwABEvzMQFH6lVW
	zv6fQntGwkch/3RAXdM8e0LAsPr5Qy1rbkBQbqSXbrokq5t1u3o5eQqNxCx1ZJo3FoxF6Zt
	FtWWJ/rVifXpTe6MYOs5VNbqb8n5uimpLg13k+t6Z6xTeIeega5wIuVKjJkcnSASHex2ItF
	9qqKesYPRPqgOeCvfJb2Po9nF+aO+RaZbu5+YlP0hE0pvArRh+nlcxzdIUaAtEUyvARd0Ui
	6lG8MiIFynOascW/xPGqp1A1gPlgEXhf3yBuWFEFhbacz2sGy38p9zcD/D6SmEkumuXZYSL
	Yux6vyDjQEp3WlMA6FajpArPxq81EHMWrRnrbY4IGX96sn9az4Mhg3/M+3gjYwbvVsBCVI4
	mUx7GXAkCEaXhG7ZelqWxZSxdw95ASJwiISe0deoUnW0ACWnaEXF5+WHL8vKXKsj4JV8mLb
	UJa0X33mUpEO6WKq+EnSMyfkP1jwePsQIMumC3GfTCVuENpHMeS9qqAgXmfQ5wk9tRD6DGs
	PUVAXoam7Ke9TIV7/MEBdZMNCBbGHtzYNs6m+64pekIk827ehGIXkb6+c1PmIuFRNenZ9zV
	cXe2F+HhRtGMkXalXeAdHLcQf/6ZCasdEW1uypKh9FpW09ouFCNPyzzsAXCUEIydSjKFPWe
	W3LLbARfqBip+PvcGgSNeT40gr2U/94a+NpAF78dYK0QiE941ZWMlfNHLwh3VtRIFDpqYCX
	Deln+M/y6DeCImGCR8KG+tG/uR9of9T0aKiYd6D092ceBtggF1BRg7taQt9dayLIXT98Gmy
	hFKfK34s8ZZoW0jT3YCi1h4h3YJBCWiMhwb4PsoRiXNqbCxgddAmZDSJtvzuUl3CEpXY5cg
	b8Y8cK381KIU7er3b1X2EES2Mg5LsmqDUz5A9cX5DlJdUjqsLUa7MhvESX2JPOmJkVC+FvY
	WePyzZA+7dVdgP2WnwaxEi9v7+srgZrqbAd4Gk56hgcOwNzRH5G0ifrpN
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B49=E6=9C=8818=E6=97=A5 10:45=EF=BC=8CDavid Ahern =
<dsahern@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 9/14/25 1:06 AM, Tonghao Zhang wrote:
>> This option has no effect in modes other than 802.3ad mode.
>> When this option enabled, the bond device will broadcast ARP/ND
>> packets to all active slaves.
>>=20
>> Cc: Stephen Hemminger <stephen@networkplumber.org>
>> Cc: David Ahern <dsahern@gmail.com>
>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>> ---
>> 1. no update uapi header. =
https://marc.info/?l=3Dlinux-netdev&m=3D170614774224160&w=3D3
>> 2. the kernel patch is accpted, =
https://patchwork.kernel.org/project/netdevbpf/patch/84d0a044514157bb856a1=
0b6d03a1028c4883561.1751031306.git.tonghao@bamaicloud.com/
>> ---
>> ip/iplink_bond.c | 16 ++++++++++++++++
>=20
> you need to update man/man8/ip-link.8.in under the bond section.
>=20
No option descriptions as follows were found in manpage. There is only a =
description of bond_slave. I don=E2=80=99t know where to update.=20

Usage: ... bond [ mode BONDMODE ] [ active_slave SLAVE_DEV ]
                [ clear_active_slave ] [ miimon MIIMON ]
                [ updelay UPDELAY ] [ downdelay DOWNDELAY ]
                [ peer_notify_delay DELAY ]
                [ use_carrier USE_CARRIER ]
                [ arp_interval ARP_INTERVAL ]
                [ arp_validate ARP_VALIDATE ]
                [ arp_all_targets ARP_ALL_TARGETS ]
                [ arp_ip_target [ ARP_IP_TARGET, ... ] ]
                [ ns_ip6_target [ NS_IP6_TARGET, ... ] ]
                [ primary SLAVE_DEV ]
                [ primary_reselect PRIMARY_RESELECT ]
                [ fail_over_mac FAIL_OVER_MAC ]
                [ xmit_hash_policy XMIT_HASH_POLICY ]
                [ resend_igmp RESEND_IGMP ]
                [ num_grat_arp|num_unsol_na NUM_GRAT_ARP|NUM_UNSOL_NA ]
                [ all_slaves_active ALL_SLAVES_ACTIVE ]
                [ min_links MIN_LINKS ]
                [ lp_interval LP_INTERVAL ]
                [ packets_per_slave PACKETS_PER_SLAVE ]
                [ tlb_dynamic_lb TLB_DYNAMIC_LB ]
                [ lacp_rate LACP_RATE ]
                [ lacp_active LACP_ACTIVE]
                [ coupled_control COUPLED_CONTROL ]
                [ broadcast_neighbor BROADCAST_NEIGHBOR ]
                [ ad_select AD_SELECT ]
                [ ad_user_port_key PORTKEY ]
                [ ad_actor_sys_prio SYSPRIO ]
                [ ad_actor_system LLADDR ]
                [ arp_missed_max MISSED_MAX ]

>=20
>=20


