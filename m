Return-Path: <netdev+bounces-16716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623E074E7C8
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB661C20CD9
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 07:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79900171D2;
	Tue, 11 Jul 2023 07:18:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3FA5CBC
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 07:18:38 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69364E1
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 00:18:36 -0700 (PDT)
Message-ID: <51f59838-8972-73c8-e6d2-83ad56bfeab4@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1689059913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Glorww3jb1WDB73Ds5xaD17upv+XiymsR47SZpDKVX4=;
	b=DT2/acMSUyL0S7XLhzy3tLGa2QJIg+tWYgkqvEBt/WAgCNdVwUujePICDRqHjXtcV4AUQ+
	4voAda+alPwElEnthza/XwlJbz+LWLFDy2B6RW5xkxcuXijxnS6ONqoWwBMcjP3oX/3RSR
	OFffM2H62Dm26/y0fWY3j46Qycg2QXBz8HnNiNdIDYvAjm+nOqCv4iIX2O8VVeaW7p8qJR
	IpF/Ch862Wk2Xc0OH20nAXwIbNgOrtOqZqtlTUZigI76RltvMPOZsnWjrfq9fkLfoIAszF
	dBQLf8NLo/i+UZVbDCl2tjk/Z2iSzYPC8jv5Y1ykDZ7F8McTVY+uIcJwEg78Cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1689059913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Glorww3jb1WDB73Ds5xaD17upv+XiymsR47SZpDKVX4=;
	b=9Y1uA0LLihdi/vDXKh25O+4L13MDUYyfUpbpNTQxFq7lxPha1eCXwVNDC7iCc9+dIWkdKh
	VVzfBZ8RmunzTSCw==
Date: Tue, 11 Jul 2023 09:18:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, kurt@linutronix.de,
 vinicius.gomes@intel.com, muhammad.husaini.zulkifli@intel.com,
 tee.min.tan@linux.intel.com, aravindhan.gunasekaran@intel.com,
 sasha.neftin@intel.com, Naama Meir <naamax.meir@linux.intel.com>
References: <20230710163503.2821068-1-anthony.l.nguyen@intel.com>
 <20230710163503.2821068-2-anthony.l.nguyen@intel.com>
 <20230711070130.GC41919@unreal>
From: Florian Kauer <florian.kauer@linutronix.de>
Subject: Re: [PATCH net 1/6] igc: Rename qbv_enable to taprio_offload_enable
In-Reply-To: <20230711070130.GC41919@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Leon,

On 11.07.23 09:01, Leon Romanovsky wrote:
> On Mon, Jul 10, 2023 at 09:34:58AM -0700, Tony Nguyen wrote:
>> From: Florian Kauer <florian.kauer@linutronix.de>
>>
>> In the current implementation the flags adapter->qbv_enable
>> and IGC_FLAG_TSN_QBV_ENABLED have a similar name, but do not
>> have the same meaning. The first one is used only to indicate
>> taprio offload (i.e. when igc_save_qbv_schedule was called),
>> while the second one corresponds to the Qbv mode of the hardware.
>> However, the second one is also used to support the TX launchtime
>> feature, i.e. ETF qdisc offload. This leads to situations where
>> adapter->qbv_enable is false, but the flag IGC_FLAG_TSN_QBV_ENABLED
>> is set. This is prone to confusion.
>>
>> The rename should reduce this confusion. Since it is a pure
>> rename, it has no impact on functionality.
> 
> And shouldn't be sent to net, but to net-next.> 
> Thanks

In principle I fully agree that sole renames are not intended for net.
But in this case the rename is tightly coupled with the other patches
of the series, not only due to overlapping code changes, but in particular
because the naming might very likely be one root cause of the regressions.

I probably should have just squashed it with the second patch,
but my initial idea was to keep them separate for clarity.

Also see:
https://lore.kernel.org/netdev/SJ1PR11MB6180B5C87699252B91FB7EE1B858A@SJ1PR11MB6180.namprd11.prod.outlook.com/
https://lore.kernel.org/netdev/0c02e976-0da6-8ed8-4546-4df7af4ebed5@linutronix.de/

Thanks,
Florian
 
>>
>> Fixes: e17090eb2494 ("igc: allow BaseTime 0 enrollment for Qbv")
>> Signed-off-by: Florian Kauer <florian.kauer@linutronix.de>
>> Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
>> Tested-by: Naama Meir <naamax.meir@linux.intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>  drivers/net/ethernet/intel/igc/igc.h      | 2 +-
>>  drivers/net/ethernet/intel/igc/igc_main.c | 6 +++---
>>  drivers/net/ethernet/intel/igc/igc_tsn.c  | 2 +-
>>  3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
>> index 639a50c02537..9db384f66a8e 100644
>> --- a/drivers/net/ethernet/intel/igc/igc.h
>> +++ b/drivers/net/ethernet/intel/igc/igc.h
>> @@ -191,7 +191,7 @@ struct igc_adapter {
>>  	int tc_setup_type;
>>  	ktime_t base_time;
>>  	ktime_t cycle_time;
>> -	bool qbv_enable;
>> +	bool taprio_offload_enable;
>>  	u32 qbv_config_change_errors;
>>  	bool qbv_transition;
>>  	unsigned int qbv_count;
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 281a0e35b9d1..fae534ef1c4f 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -6126,16 +6126,16 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
>>  
>>  	switch (qopt->cmd) {
>>  	case TAPRIO_CMD_REPLACE:
>> -		adapter->qbv_enable = true;
>> +		adapter->taprio_offload_enable = true;
>>  		break;
>>  	case TAPRIO_CMD_DESTROY:
>> -		adapter->qbv_enable = false;
>> +		adapter->taprio_offload_enable = false;
>>  		break;
>>  	default:
>>  		return -EOPNOTSUPP;
>>  	}
>>  
>> -	if (!adapter->qbv_enable)
>> +	if (!adapter->taprio_offload_enable)
>>  		return igc_tsn_clear_schedule(adapter);
>>  
>>  	if (qopt->base_time < 0)
>> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
>> index 3cdb0c988728..b76ebfc10b1d 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
>> @@ -37,7 +37,7 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
>>  {
>>  	unsigned int new_flags = adapter->flags & ~IGC_FLAG_TSN_ANY_ENABLED;
>>  
>> -	if (adapter->qbv_enable)
>> +	if (adapter->taprio_offload_enable)
>>  		new_flags |= IGC_FLAG_TSN_QBV_ENABLED;
>>  
>>  	if (is_any_launchtime(adapter))
>> -- 
>> 2.38.1
>>
>>

