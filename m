Return-Path: <netdev+bounces-233659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C872C1716F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7A15345CA5
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 21:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD2E2F12CE;
	Tue, 28 Oct 2025 21:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rh6M5Scp"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961542F5A37
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761688098; cv=none; b=IQbzTYQM/6YbzW3316QqtpDk3GAvzPh0liBNmkad0Pv6ZGjLe4xa8up3uLdXgh30Rfw3nNw/NfSVcVqK1JPyMcZIeiv3d0VcsmgMyJiwP1U95utK9zb/W7Hv+AJVa8HGVZFp6f0R3GizNdFwO+tNg3RQifr5/1J1InZck9ZAxmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761688098; c=relaxed/simple;
	bh=CZVI0U5sVkC4mo1tiQOsy+Sv1UxdNUH3jaZ9D1nJXT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IvJE1xYQUZrJOV4UAJMH5qPphdO9+SdXF8en2O9UMNffNcCGUsE4Dtm0HHx+vQKTVhtjAFjhb/tgu/wROePL75xIhusC813nN7Twgf3mMtXSYNfXGLiTYubmXWBCfwz9FbtkYTOUfrF0RUoLFqBeQUPlYpbVXIWsU7bnJJf8HA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rh6M5Scp; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ef2ea988-bbfb-469e-b833-dbe8f5ddc5b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761688090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3kOjP94Pbp9s7JPnBPTClo4lNqh3jF46KrnNQrK3gg=;
	b=Rh6M5Scp1YUsi+8RdPbNpK3VqKYNyGwsCMiIeGPYoKM3ffD6Bs0afHFAzlg+daNCksP4o3
	r/Dd64y8kj9jHGotBFrwM93nUy1dFE9hUZPlxCSULqTDG9jh0zBlT6s1rlzOSLgQJHcJt6
	DCOgM0ohusWSyiMevn7ANMCc+3CTbpE=
Date: Tue, 28 Oct 2025 21:48:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ethtool-next] netlink: tsconfig: add HW time stamping
 configuration
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Kory Maincent <kory.maincent@bootlin.com>
References: <20251004202715.9238-1-vadim.fedorenko@linux.dev>
 <5w25bm7gnbrq4cwtefmunmcylqav524roamuvoz2zv5piadpek@4vpzw533uuyd>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <5w25bm7gnbrq4cwtefmunmcylqav524roamuvoz2zv5piadpek@4vpzw533uuyd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/10/2025 16:57, Michal Kubecek wrote:
> On Sat, Oct 04, 2025 at 08:27:15PM GMT, Vadim Fedorenko wrote:
>> The kernel supports configuring HW time stamping modes via netlink
>> messages, but previous implementation added support for HW time stamping
>> source configuration. Add support to configure TX/RX time stamping.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> As far as I can see, you only allow one bit to be set in each of
> ETHTOOL_A_TSCONFIG_TX_TYPES and ETHTOOL_A_TSCONFIG_RX_FILTERS. If only
> one bit is supposed to be set, why are they passed as bitmaps?
> (The netlink interface only mirrors what (read-only) ioctl interface
> did.)

Well, yes, it's only 1 bit is supposed to be set. Unfortunately, netlink
interface was added this way almost a year ago, we cannot change it
anymore without breaking user-space API.

> 
> Michal
> 
>> ---
>>   ethtool.8.in       | 12 ++++++-
>>   ethtool.c          |  1 +
>>   netlink/tsconfig.c | 78 +++++++++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 89 insertions(+), 2 deletions(-)
>>
>> diff --git a/ethtool.8.in b/ethtool.8.in
>> index 553592b..e9eb2d7 100644
>> --- a/ethtool.8.in
>> +++ b/ethtool.8.in
>> @@ -357,6 +357,10 @@ ethtool \- query or control network driver and hardware settings
>>   .IR N
>>   .BI qualifier
>>   .IR precise|approx ]
>> +.RB [ tx
>> +.IR TX-TYPE ]
>> +.RB [ rx-filter
>> +.IR RX-FILTER ]
>>   .HP
>>   .B ethtool \-x|\-\-show\-rxfh\-indir|\-\-show\-rxfh
>>   .I devname
>> @@ -1286,7 +1290,7 @@ for IEEE 1588 quality and "approx" is for NICs DMA point.
>>   Show the selected time stamping PTP hardware clock configuration.
>>   .TP
>>   .B \-\-set\-hwtimestamp\-cfg
>> -Select the device's time stamping PTP hardware clock.
>> +Sets the device's time stamping PTP hardware clock configuration.
>>   .RS 4
>>   .TP
>>   .BI index \ N
>> @@ -1295,6 +1299,12 @@ Index of the ptp hardware clock
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
>> index 948d551..2e03b74 100644
>> --- a/ethtool.c
>> +++ b/ethtool.c
>> @@ -6063,6 +6063,7 @@ static const struct option args[] = {
>>   		.nlfunc	= nl_stsconfig,
>>   		.help	= "Select hardware time stamping",
>>   		.xhelp	= "		[ index N qualifier precise|approx ]\n"
>> +			  "		[ tx TX-TYPE ] [ rx-filter RX-FILTER ]\n"
>>   	},
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
>> +		values = global_stringset(ETH_SS_TS_TX_TYPES, nlctx->ethnl2_socket);
>> +		break;
>> +	case ETHTOOL_A_TSCONFIG_RX_FILTERS:
>> +		values = global_stringset(ETH_SS_TS_RX_FILTERS, nlctx->ethnl2_socket);
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
>> +		struct nlattr *bits_attr, *bit_attr;
>> +
>> +		if (ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_NOMASK, true))
>> +			return -EMSGSIZE;
>> +
>> +		bits_attr = ethnla_nest_start(msgbuff, ETHTOOL_A_BITSET_BITS);
>> +		if (!bits_attr)
>> +			return -EMSGSIZE;
>> +
>> +		bit_attr = ethnla_nest_start(msgbuff, ETHTOOL_A_BITSET_BITS_BIT);
>> +		if (!bit_attr) {
>> +			ethnla_nest_cancel(msgbuff, bits_attr);
>> +			return -EMSGSIZE;
>> +		}
>> +		if (ethnla_put_u32(msgbuff, ETHTOOL_A_BITSET_BIT_INDEX, i) ||
>> +		    ethnla_put_flag(msgbuff, ETHTOOL_A_BITSET_BIT_VALUE, true)) {
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
>>   	ret = nl_parser(nlctx, stsconfig_params, NULL, PARSER_GROUP_NEST, NULL);
>> -- 
>> 2.47.3
>>


