Return-Path: <netdev+bounces-73285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAA185BC0F
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 13:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E83C1C20B4E
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32B66996B;
	Tue, 20 Feb 2024 12:27:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA43767C62
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432032; cv=none; b=M1vypZWDsp+XGLbNZ0ZVtJF+FwriQI0Fq0qK+RzIH+eWE4g3g5Y45GAq3XcWmFVtVXuAVVrej7TkqncqisKV+LlVCVFbtYB2cG6eVRut50bFqJm7gmyjpY9Q3yrC52DYydVrnEnuxhJp+GFiE2EwfzzDCSVH5CbUL8gsWo6Hdm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432032; c=relaxed/simple;
	bh=6ZB4CanqgJUkj2DwoUXmNrC8k6WO23uMtpwBInue2bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgGk2A89g7elcoagZxRVnDHLRJwWOmHpxjf2eMmSzfbZzB9nsyZj8G4ICAbMpx1kH8xgt0FU9jMwuEWmeNnl0FWPU6UMUlHjrQt+UxEcjnAhMBmz/AdsQOeXOg8ZnA82NFGg9UTlRUNbg4ck4+Dhn4tSk0XJuzUdQfPoXpuMGnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5C16E61E5FE01;
	Tue, 20 Feb 2024 13:26:35 +0100 (CET)
Message-ID: <dc03726a-d59b-47a1-b394-7a435f8aee1a@molgen.mpg.de>
Date: Tue, 20 Feb 2024 13:26:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-next v1 2/2] ice: tc: allow ip_proto
 matching
Content-Language: en-US
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, wojciech.drewek@intel.com,
 marcin.szycik@intel.com, netdev@vger.kernel.org,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, sridhar.samudrala@intel.com
References: <20240220105950.6814-1-michal.swiatkowski@linux.intel.com>
 <20240220105950.6814-3-michal.swiatkowski@linux.intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240220105950.6814-3-michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Michal,


Thank you for the patch. Some minor nits from my side.

Am 20.02.24 um 11:59 schrieb Michal Swiatkowski:
> Add new matching type. There is no encap version of ip_proto field.

Excuse my ignorance, I do not understand the second sentence. Is an 
encap version going to be added?

> Use it in the same lookup type as for TTL. In hardware it have the same

s/have/has/

> protocol ID, but different offset.
> 
> Example command to add filter with ip_proto:
> $tc filter add dev eth10 ingress protocol ip flower ip_proto icmp \
>   skip_sw action mirred egress redirect dev eth0
> 
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_tc_lib.c | 17 +++++++++++++++--
>   drivers/net/ethernet/intel/ice/ice_tc_lib.h |  1 +
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> index 49ed5fd7db10..f7c0f62fb730 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> @@ -78,7 +78,8 @@ ice_tc_count_lkups(u32 flags, struct ice_tc_flower_lyr_2_4_hdrs *headers,
>   		     ICE_TC_FLWR_FIELD_DEST_IPV6 | ICE_TC_FLWR_FIELD_SRC_IPV6))
>   		lkups_cnt++;
>   
> -	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL))
> +	if (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL |
> +		     ICE_TC_FLWR_FIELD_IP_PROTO))

Should this be sorted? (Also below).

>   		lkups_cnt++;
>   
>   	/* are L2TPv3 options specified? */
> @@ -530,7 +531,8 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
>   	}
>   
>   	if (headers->l2_key.n_proto == htons(ETH_P_IP) &&
> -	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL))) {
> +	    (flags & (ICE_TC_FLWR_FIELD_IP_TOS | ICE_TC_FLWR_FIELD_IP_TTL |
> +		      ICE_TC_FLWR_FIELD_IP_PROTO))) {
>   		list[i].type = ice_proto_type_from_ipv4(inner);
>   
>   		if (flags & ICE_TC_FLWR_FIELD_IP_TOS) {
> @@ -545,6 +547,13 @@ ice_tc_fill_rules(struct ice_hw *hw, u32 flags,
>   				headers->l3_mask.ttl;
>   		}
>   
> +		if (flags & ICE_TC_FLWR_FIELD_IP_PROTO) {
> +			list[i].h_u.ipv4_hdr.protocol =
> +				headers->l3_key.ip_proto;
> +			list[i].m_u.ipv4_hdr.protocol =
> +				headers->l3_mask.ip_proto;

(Strange to break the line each time, but seems to be the surrounding 
coding style.)

> +		}
> +
>   		i++;
>   	}
>   
> @@ -1515,7 +1524,11 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
>   
>   		headers->l2_key.n_proto = cpu_to_be16(n_proto_key);
>   		headers->l2_mask.n_proto = cpu_to_be16(n_proto_mask);
> +
> +		if (match.key->ip_proto)
> +			fltr->flags |= ICE_TC_FLWR_FIELD_IP_PROTO;
>   		headers->l3_key.ip_proto = match.key->ip_proto;
> +		headers->l3_mask.ip_proto = match.mask->ip_proto;
>   	}
>   
>   	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.h b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> index 65d387163a46..856f371d0687 100644
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.h
> @@ -34,6 +34,7 @@
>   #define ICE_TC_FLWR_FIELD_VLAN_PRIO		BIT(27)
>   #define ICE_TC_FLWR_FIELD_CVLAN_PRIO		BIT(28)
>   #define ICE_TC_FLWR_FIELD_VLAN_TPID		BIT(29)
> +#define ICE_TC_FLWR_FIELD_IP_PROTO		BIT(30)
>   
>   #define ICE_TC_FLOWER_MASK_32   0xFFFFFFFF
>   


Kind regards,

Paul

