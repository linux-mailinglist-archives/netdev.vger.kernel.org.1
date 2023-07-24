Return-Path: <netdev+bounces-20437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C97A575F910
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 15:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D64F1C20B5A
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 13:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737F89470;
	Mon, 24 Jul 2023 13:58:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724F8C15
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 13:58:58 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7190618E
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690207136; x=1721743136;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NPiwupa9t8YKDwSwTQOsNFLig1lIbwPc5gnDmsk//9g=;
  b=isIuTHgr8WchitPkPazqOT7QK3Vd2W5ykihnZpqXYlQQi02Jm59UBmgd
   3c8lzX98oZrrhQzLfWb8NwUNOvhLcZRTxq/8BYF9EeI2JvZAR5fYSCAJ6
   kkf2mGmWZ3XLH1P8+xDnlQb1bgz0aw8IlhT6gIZyg9hcx46otzsBejizN
   eTYcSt2sowFwA8lRcPsV296p5kqbUjN81tONduFmyd47xP7Gnk2/L8Ndo
   +VksZe1Bl4GMVLLuM7NPPk42OWq14lN78hc/9SSNMJQs0AJ/mANa/HCBE
   TZY4+vHtyVtCPokcEXcrR4CjxkkqcvsZNgeK6gw3QUTyf2fMRiRYtQyCw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398353887"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398353887"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 06:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="760798777"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="760798777"
Received: from mszycik-mobl1.ger.corp.intel.com (HELO [10.237.140.125]) ([10.237.140.125])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 06:58:53 -0700
Message-ID: <24784f80-df7b-a666-a56b-9b4c288978a1@linux.intel.com>
Date: Mon, 24 Jul 2023 15:58:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH iwl-next v3 6/6] ice: Add support for PFCP hardware
 offload in switchdev
Content-Language: en-US
To: Andy Shevchenko <andy@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 wojciech.drewek@intel.com, michal.swiatkowski@linux.intel.com,
 aleksander.lobakin@intel.com, davem@davemloft.net, kuba@kernel.org,
 jiri@resnulli.us, pabeni@redhat.com, jesse.brandeburg@intel.com,
 simon.horman@corigine.com, idosch@nvidia.com
References: <20230721071532.613888-1-marcin.szycik@linux.intel.com>
 <20230721071532.613888-7-marcin.szycik@linux.intel.com>
 <ZLqfJZi/14dyEzhH@smile.fi.intel.com>
From: Marcin Szycik <marcin.szycik@linux.intel.com>
In-Reply-To: <ZLqfJZi/14dyEzhH@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 21.07.2023 17:07, Andy Shevchenko wrote:
> On Fri, Jul 21, 2023 at 09:15:32AM +0200, Marcin Szycik wrote:
>> Add support for creating PFCP filters in switchdev mode. Add support
>> for parsing PFCP-specific tc options: S flag and SEID.
>>
>> To create a PFCP filter, a special netdev must be created and passed
>> to tc command:
>>
>> ip link add pfcp0 type pfcp
>> tc filter add dev eth0 ingress prio 1 flower pfcp_opts \
>> 1:123/ff:fffffffffffffff0 skip_hw action mirred egress redirect dev pfcp0
> 
> Can you indent this (by 2 spaces?) to differentiate with the commit message
> itself?

Sure.

> 
>> Changes in iproute2 [1] are required to be able to use pfcp_opts in tc.
>>
>> ICE COMMS package is required to create a filter as it contains PFCP
>> profiles.
> 
>> [1] https://lore.kernel.org/netdev/20230614091758.11180-1-marcin.szycik@linux.intel.com
> 
> We have Link: tag for such kind of stuff.

Are you sure this is a valid use of Link: tag? Patch that is linked here is
in another tree, and also I want to have [1] inline for context.

> 
> ...
> 
>> +	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ENC_OPTS) &&
>> +	    fltr->tunnel_type == TNL_PFCP) {
>> +		struct flow_match_enc_opts match;
>> +
>> +		flow_rule_match_enc_opts(rule, &match);
>> +
>> +		memcpy(&fltr->pfcp_meta_keys, &match.key->data[0],
>> +		       sizeof(struct pfcp_metadata));
> 
> Why not simply
> 
> 		match.key->data
> 
> ?

Will change.

> 
>> +		memcpy(&fltr->pfcp_meta_masks, &match.mask->data[0],
>> +		       sizeof(struct pfcp_metadata));
> 
> Ditto.
> 
>> +		fltr->flags |= ICE_TC_FLWR_FIELD_PFCP_OPTS;
>> +	}
> 
> ...
> 
>>  #ifndef _ICE_TC_LIB_H_
>>  #define _ICE_TC_LIB_H_
> 
> Seems bits.h is missing...

Will add.

> 
>> +#include <net/pfcp.h>
>> +
>>  #define ICE_TC_FLWR_FIELD_DST_MAC		BIT(0)
>>  #define ICE_TC_FLWR_FIELD_SRC_MAC		BIT(1)
>>  #define ICE_TC_FLWR_FIELD_VLAN			BIT(2)
> 
> ...
> 
>>  #define ICE_TC_FLWR_FIELD_VLAN_PRIO		BIT(27)
>>  #define ICE_TC_FLWR_FIELD_CVLAN_PRIO		BIT(28)
>>  #define ICE_TC_FLWR_FIELD_VLAN_TPID		BIT(29)
>> +#define ICE_TC_FLWR_FIELD_PFCP_OPTS		BIT(30)
>>  
>>  #define ICE_TC_FLOWER_MASK_32   0xFFFFFFFF
> 
> ...and (at least) this can utilize GENMASK().

It can, but it's unrelated to this patch.


Thank you for review!
Marcin

