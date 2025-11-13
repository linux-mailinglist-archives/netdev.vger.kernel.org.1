Return-Path: <netdev+bounces-238350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD108C57B12
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F73422625
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E032FFF8B;
	Thu, 13 Nov 2025 13:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="zouGLXSf"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167BA86352
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039919; cv=none; b=iQsvIBPN0IUmwwgmjHhv19RkaT9DlVmaCfKSgEXwXrPi49/4BiOw88brA/xA7Lgek4aKTK73+9wR1MXrGkJpKWjHpx1bc9H02cyeP4Ivi/H+jyRJYxXaJmYlEqy/fa8/jAqEIIVEE7pYhkDnovVRw4A0vHuzbjZJHy/5n09wREk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039919; c=relaxed/simple;
	bh=HCslL9Tv3pZn4ALU4gywYqPOJdbsgx2sGYM7Umy34JY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jaT5QtnKgPtS0mmJXeP4uLD1xFJQsPYQ6ztZszAvbZtYeAI6uZEMvq1bPzbWVtYKGgrvoNsePoOjKTtdOY746YoVPo83jbdTQkSCDLfBV3h/YWqdXuJvsDmyULhN+2F19O4zzIY6jYj46iuKOtU1aj0iIx2UCVBptEKYkJQEBec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=zouGLXSf; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.58] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 68E50200C97C;
	Thu, 13 Nov 2025 14:18:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 68E50200C97C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1763039915;
	bh=vkOFf+40st8SAG1bl6TUuoS4ylg1UwVl+SBDKNxq1mY=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=zouGLXSf7CKIl+d7RAPFUHZrYOqXe59xi6sW0J/GX+d6JLGmJvuoa2+22BkAtUylT
	 TyrF49184egBzqAKcqBIsbm4A4EDyng19grDJlW85bEtxIRzIT/8JC27f9a+7An0/P
	 d7e170RL6b4kyrMg5TKNQ+KnM04NF5xyQJgiG/q0P3HEybmgiZzKsP19N/vUNSsdkF
	 l4Az7Y1YWzZgEgR0tE8S6Iy8WTdfTT/BNleoryFIx8QKDXByLekHffLI51X36fgrOB
	 GSzR03A7iFokB9NW9WxFqkpLAZKQ9xp6jHU7Dvw9sD1eI5pOVJ0Qk0gWMPQnIv5UTq
	 e8FvQ6RvwayHg==
Message-ID: <46a0fab0-e904-4745-a0df-28cfb8a00bee@uliege.be>
Date: Thu, 13 Nov 2025 14:18:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Justin Iurman <justin.iurman@uliege.be>
Subject: Re: [RFC net-next 0/3] ipv6: Disable IPv6 Destination Options RX
 processing by default
To: Tom Herbert <tom@herbertland.com>, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org
Cc: justin.iurman@uliege.be
References: <20251112001744.24479-1-tom@herbertland.com>
Content-Language: en-US
In-Reply-To: <20251112001744.24479-1-tom@herbertland.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/25 01:15, Tom Herbert wrote:
> Set IP6_DEFAULT_MAX_DST_OPTS_CNT to zero. This disables
> processing of Destinations Options extension headers by default.
> Processing can be enabled by setting the net.ipv6.max_dst_opts_number
> to a non-zero value.
> 
> The rationale for this is that Destination Options pose a serious risk
> of Denial off Service attack. The problem is that even if the
> default limit is set to a small number (previously it was eight) there
> is still the possibility of a DoS attack. All an attacker needs to do
> is create and MTU size packet filled  with 8 bytes Destination Options
> Extension Headers. Each Destination EH simply contains a single
> padding option with six bytes of zeroes.
> 
> In a 1500 byte MTU size packet, 182 of these dummy Destination
> Options headers can be placed in a packet. Per RFC8200, a host must
> accept and process a packet with any number of Destination Options
> extension headers. So when the stack processes such a packet it is
> a lot of work and CPU cycles that provide zero benefit. The packet
> can be designed such that every byte after the IP header requires
> a conditional check and branch prediction can be rendered useless
> for that. This also may mean over twenty cache misses per packet.
> In other words, these packets filled with dummy Destination Options
> extension headers are the basis for what would be an effective DoS
> attack.
> 
> Disabling Destination Options is not a major issue for the following
> reasons:
> 
> * Linux kernel only supports one Destination Option (Home Address
>    Option). There is no evidence this has seen any real world use
> * On the Internet packets with Destination Options are dropped with
>    a high enough rate such that use of Destination Options is not
>    feasible
> * It is unknown however quite possible that no one anywhere is using
>    Destination Options for anything but experiments, class projects,
>    or DoS. If someone is using them in their private network then
>    it's easy enough to configure a non-zero limit for their use case
> 
> Tom Herbert (3):
> ipv6: Check of max HBH or DestOp sysctl is zero and drop if it is
>    ipv6: Disable IPv6 Destination Options RX processing by default
>    ipv6: Document defauit of zero for max_dst_opts_number
> 
>   Documentation/networking/ip-sysctl.rst | 38 ++++++++++++++++++--------
>   include/net/ipv6.h                     |  7 +++--
>   net/ipv6/exthdrs.c                     |  6 ++--
>   3 files changed, 36 insertions(+), 15 deletions(-)
> 

Adding the two IETF 6man related threads ([1,2]) to bring context and to 
highlight what has been discussed so far.

  [1] 
https://mailarchive.ietf.org/arch/msg/ipv6/J_9vPNzyllNAudXwJdqdHwgzT8A/
  [2] 
https://mailarchive.ietf.org/arch/msg/ipv6/jMTQJz5bAVmLyBhtgh-pmJR3MMM/

