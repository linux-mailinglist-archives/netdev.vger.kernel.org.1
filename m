Return-Path: <netdev+bounces-236875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBF6C4128D
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 18:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91545188530F
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 17:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CF43370E1;
	Fri,  7 Nov 2025 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mwq1wm0H"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE579337694
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762538015; cv=none; b=WLXPTWSVgXzXI/wyZJm0Zez9/BsMY2P7rxtShl4PoBYpNlo8P7/RKUp7R/ZNkcgyttcduQ+3LvmyDcmjtywr3Qu8H2Y2ZbKBKF3UBQGX2m0ZUTpl7XZELOY5udP4YSAlRSw+xC8Ymt9QMGV0wSjQ5bzpiSrSrupn2mHoJGT2bAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762538015; c=relaxed/simple;
	bh=fs7/9+UAJ0O37vS4AEZpPSq7wJqBLQloS7BQLOVYoUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2zI3YDdv+OKKmaTKKFKkhuuT029ngsXT4vg9bHeB9HtsPeR/T9EcI9Q9aRxjZOj3WBIrVFYSu523S0cT3Gnrdy5sC5FU2aU+5j/IvIyGSkrTrnHuuUNQ9CJ3G7Ra0manQPKmo8IGX7GsQrcKxyKYc6I4t3UkhDVN2mhk0VP2DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mwq1wm0H; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <52bbb293-d3c6-435b-b306-fe6782512a1b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762538007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJ7ANzwEsj0X5PDTfV3hCmixDXnOUw5mE09Z9QH8E+A=;
	b=Mwq1wm0HEinHxsKQAK2CJ2hHuidzwJjGCgkZKCMEdf8kKyw3auaxc5H+QFtAVsceUaslm7
	qy8PXe3TngLQ2YfQxmHMnSUpfKrDLeWm/ZQSI6u9B3hvz3+6/VZFieJpITrd9uC33o6YOJ
	a+mZ2Wj6TRGfZdIjk7aSFi9NvCBawVA=
Date: Fri, 7 Nov 2025 17:53:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ethtool-next v2] netlink: tsconfig: add HW time stamping
 configuration
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
References: <20251105192453.3542275-1-vadim.fedorenko@linux.dev>
 <20251107104602.69e2607f@kmaincent-XPS-13-7390>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251107104602.69e2607f@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 07/11/2025 09:46, Kory Maincent wrote:
> On Wed,  5 Nov 2025 19:24:53 +0000
> Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
> 
>> The kernel supports configuring HW time stamping modes via netlink
>> messages, but previous implementation added support for HW time stamping
>> source configuration. Add support to configure TX/RX time stamping.
>> We keep TX type and RX filter configuration as a bit value, but if we
>> will need multibit value to be set in the future, there is an option to
>> use "rx-filters" keyword which will be mutually exclusive with current
>> "rx-filter" keyword. The same applies to "tx-type".
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>>   ethtool.8.in       | 12 ++++++-
>>   ethtool.c          |  1 +
>>   netlink/tsconfig.c | 78 +++++++++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 89 insertions(+), 2 deletions(-)
>>
>> diff --git a/ethtool.8.in b/ethtool.8.in
>> index 8874ade..1788588 100644
>> --- a/ethtool.8.in
>> +++ b/ethtool.8.in
>> @@ -357,6 +357,10 @@ ethtool \- query or control network driver and hardware
>> settings .IR N
>>   .BI qualifier
>>   .IR precise|approx ]
>> +.RB [ tx
>> +.IR TX-TYPE ]
>> +.RB [ rx-filter
>> +.IR RX-FILTER ]
>>   .HP
>>   .B ethtool \-x|\-\-show\-rxfh\-indir|\-\-show\-rxfh
>>   .I devname
>> @@ -1287,7 +1291,7 @@ for IEEE 1588 quality and "approx" is for NICs DMA
>> point. Show the selected time stamping PTP hardware clock configuration.
>>   .TP
>>   .B \-\-set\-hwtimestamp\-cfg
>> -Select the device's time stamping PTP hardware clock.
>> +Sets the device's time stamping PTP hardware clock configuration.
>>   .RS 4
>>   .TP
>>   .BI index \ N
>> @@ -1296,6 +1300,12 @@ Index of the ptp hardware clock
>>   .BI qualifier \ precise | approx
>>   Qualifier of the ptp hardware clock. Mainly "precise" the default one is
>>   for IEEE 1588 quality and "approx" is for NICs DMA point.
>> +.TP
>> +.BI tx \ TX-TYPE
>> +Type of TX time stamping to configure
>> +.TP
>> +.BI rx-filter \ RX-FILTER
>> +Type of RX time stamping filter to configure
>>   .RE
>>   .TP
>>   .B \-x \-\-show\-rxfh\-indir \-\-show\-rxfh
>> diff --git a/ethtool.c b/ethtool.c
>> index bd45b9e..521e6fe 100644
>> --- a/ethtool.c
>> +++ b/ethtool.c
>> @@ -6068,6 +6068,7 @@ static const struct option args[] = {
>>   		.nlfunc	= nl_stsconfig,
>>   		.help	= "Select hardware time stamping",
>>   		.xhelp	= "		[ index N qualifier
>> precise|approx ]\n"
>> +			  "		[ tx TX-TYPE ] [ rx-filter
>> RX-FILTER ]\n" },
>>   	{
>>   		.opts	= "-x|--show-rxfh-indir|--show-rxfh",
>> diff --git a/netlink/tsconfig.c b/netlink/tsconfig.c
>> index d427c7b..7dee4d1 100644
>> --- a/netlink/tsconfig.c
>> +++ b/netlink/tsconfig.c
>> @@ -17,6 +17,7 @@
>>   #include "netlink.h"
>>   #include "bitset.h"
>>   #include "parser.h"
>> +#include "strset.h"
>>   #include "ts.h"
>>   
>>   /* TSCONFIG_GET */
>> @@ -94,6 +95,67 @@ int nl_gtsconfig(struct cmd_context *ctx)
>>   
>>   /* TSCONFIG_SET */
>>   
>> +int tsconfig_txrx_parser(struct nl_context *nlctx, uint16_t type,
>> +			 const void *data __maybe_unused,
>> +			 struct nl_msg_buff *msgbuff,
>> +			 void *dest __maybe_unused)
>> +{
>> +	const struct stringset *values;
>> +	const char *arg = *nlctx->argp;
>> +	unsigned int count, i;
>> +
>> +	nlctx->argp++;
>> +	nlctx->argc--;
>> +	if (netlink_init_ethnl2_socket(nlctx) < 0)
>> +		return -EIO;
>> +
>> +	switch (type) {
>> +	case ETHTOOL_A_TSCONFIG_TX_TYPES:
>> +		values = global_stringset(ETH_SS_TS_TX_TYPES,
>> nlctx->ethnl2_socket);
>> +		break;
>> +	case ETHTOOL_A_TSCONFIG_RX_FILTERS:
>> +		values = global_stringset(ETH_SS_TS_RX_FILTERS,
>> nlctx->ethnl2_socket);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	count = get_count(values);
>> +	for (i = 0; i < count; i++) {
>> +		const char *name = get_string(values, i);
>> +
>> +		if (!strcmp(name, arg))
>> +			break;
>> +	}
>> +
>> +	if (i != count) {
> 
> It would be nicer to have a small if instead of the big one:
> if (i == count)
> 	return -EINVAL;

Fair, dunno where I got this pattern. Thanks!

> With that change:
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> Thank you!
> 
>> +		struct nlattr *bits_attr, *bit_attr;
>> +
>> +		if (ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_NOMASK, true))
>> +			return -EMSGSIZE;
>> +
>> +		bits_attr = ethnla_nest_start(msgbuff,
>> ETHTOOL_A_BITSET_BITS);
>> +		if (!bits_attr)
>> +			return -EMSGSIZE;
>> +
>> +		bit_attr = ethnla_nest_start(msgbuff,
>> ETHTOOL_A_BITSET_BITS_BIT);
>> +		if (!bit_attr) {
>> +			ethnla_nest_cancel(msgbuff, bits_attr);
>> +			return -EMSGSIZE;
>> +		}
>> +		if (ethnla_put_u32(msgbuff, ETHTOOL_A_BITSET_BIT_INDEX, i) ||
>> +		    ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_BIT_VALUE,
>> true)) {
>> +			ethnla_nest_cancel(msgbuff, bits_attr);
>> +			ethnla_nest_cancel(msgbuff, bit_attr);
>> +			return -EMSGSIZE;
>> +		}
>> +		mnl_attr_nest_end(msgbuff->nlhdr, bit_attr);
>> +		mnl_attr_nest_end(msgbuff->nlhdr, bits_attr);
>> +		return 0;
>> +	}
>> +	return -EINVAL;
>> +}
>> +
>>   static const struct param_parser stsconfig_params[] = {
>>   	{
>>   		.arg		= "index",
>> @@ -109,6 +171,20 @@ static const struct param_parser stsconfig_params[] = {
>>   		.handler	= tsinfo_qualifier_parser,
>>   		.min_argc	= 1,
>>   	},
>> +	{
>> +		.arg		= "tx",
>> +		.type		= ETHTOOL_A_TSCONFIG_TX_TYPES,
>> +		.handler	= tsconfig_txrx_parser,
>> +		.group		= ETHTOOL_A_TSCONFIG_TX_TYPES,
>> +		.min_argc	= 1,
>> +	},
>> +	{
>> +		.arg		= "rx-filter",
>> +		.type		= ETHTOOL_A_TSCONFIG_RX_FILTERS,
>> +		.handler	= tsconfig_txrx_parser,
>> +		.group		= ETHTOOL_A_TSCONFIG_RX_FILTERS,
>> +		.min_argc	= 1,
>> +	},
>>   	{}
>>   };
>>   
>> @@ -134,7 +210,7 @@ int nl_stsconfig(struct cmd_context *ctx)
>>   	if (ret < 0)
>>   		return ret;
>>   	if (ethnla_fill_header(msgbuff, ETHTOOL_A_TSCONFIG_HEADER,
>> -			       ctx->devname, 0))
>> +			       ctx->devname, ETHTOOL_FLAG_COMPACT_BITSETS))
>>   		return -EMSGSIZE;
>>   
>>   	ret = nl_parser(nlctx, stsconfig_params, NULL, PARSER_GROUP_NEST,
>> NULL);
> 
> 
> 


