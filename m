Return-Path: <netdev+bounces-238073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AA2C53C40
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 18:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37E84A3CCC
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 17:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDE2345CB7;
	Wed, 12 Nov 2025 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EGEgDhh6"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6DA346E68
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968285; cv=none; b=euv/QW5D/RtzhsbU3b2OwlC6Bsrp7rnvslF1xtAaxUgopotAVQsrqI/4xPqAjEuKJ5QQRFnFqn5f5HR7otgtLEkvjdHNDo5KToznPl4wWWQkSgO65YFzws+dr3F1MHMR8hkE1ttyeTO4YSwaFKmjUKXRpGxG2BNkpp6KzfVs9EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968285; c=relaxed/simple;
	bh=5vmteXCVjQPw0CDtVLfXXdhil5eP2xxZ4pv1MmN7hBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIwZHAYSSgip5cozeg+RaAlGQ0z+9Mjkgj3Za/9Np9q+GrgHCp+FQR+LzmdhHMN4hV2C3+zRy3A5mJ/Wo4dSVi4mb1qS4td/DgBYRJ2nuNbcPt+QGS6ruGq/t0fRSd9WWvJM1DUKdYE28EC1zw+pyCFHg1As/J3MlaGU2IP9FyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EGEgDhh6; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3df1dd80-4268-4505-bc79-87392a8bbb34@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762968281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J4OlFfA8Wsy8+Zg9Z2AWpRcJsKYB0XQWBLpGoRAKFQs=;
	b=EGEgDhh6eRijKnpkt9yIFEp0lhHGzSnKt0aiVyATD26fwqd5f9PSz5zUJy+2HPyDLhH333
	uGYq2g1olpzWoTacvCd5Sa+/e2tiWT1hQn+4HAEDHUqP91sZSb5gCc74bMzE0WJnWoPoJl
	88laDSjqzFzW8JKw/o+ZaNhEEOidpJc=
Date: Wed, 12 Nov 2025 17:24:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH ethtool-next v3] netlink: tsconfig: add HW time stamping
 configuration
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
References: <20251107182044.3545092-1-vadim.fedorenko@linux.dev>
 <20251112094849.23b344af@kmaincent-XPS-13-7390>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251112094849.23b344af@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/11/2025 08:48, Kory Maincent wrote:
> On Fri,  7 Nov 2025 18:20:44 +0000
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
>> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
>> ---
>> v2 -> v3:
>> * improve code style
>> v1 -> v2:
>> * improve commit message
>> ---
>>   ethtool.8.in       | 12 +++++++-
>>   ethtool.c          |  1 +
>>   netlink/tsconfig.c | 77 +++++++++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 88 insertions(+), 2 deletions(-)
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
>> index d427c7b..f4ed10e 100644
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
>> @@ -94,6 +95,66 @@ int nl_gtsconfig(struct cmd_context *ctx)
>>   
>>   /* TSCONFIG_SET */
>>   
>> +int tsconfig_txrx_parser(struct nl_context *nlctx, uint16_t type,
>> +			 const void *data __maybe_unused,
>> +			 struct nl_msg_buff *msgbuff,
>> +			 void *dest __maybe_unused)
>> +{
>> +	struct nlattr *bits_attr, *bit_attr;
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
>> +	if (i != count)
>> +		return -EINVAL;
> 
> It seems you update your patch too quickly and don't test it.
> It should be "if (i == count)" here.

You are right, thanks for catching it.
v4 is on the way.

