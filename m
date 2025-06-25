Return-Path: <netdev+bounces-201155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A899BAE84DA
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB851BC5939
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C76725D8E6;
	Wed, 25 Jun 2025 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="lqnYTu6b"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2F721D3EF;
	Wed, 25 Jun 2025 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750858355; cv=none; b=ncRtr2gWGf9HtPI18oMpZb9bviWaE177P8S/a7qo+RGERU6bbwzcqVvXA3PtOBLfPoKt82JOAptA9vXNKy9wa0MxhVsYpnrCTQeGLP83ua2ZELZdT1SQpSu4ky6mMAbdr5BZVXRk6n4FwlORhoRk3cp1SLNvlphhuzVTgN0hk/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750858355; c=relaxed/simple;
	bh=r1PRzg4Ne+U9D2V89dmGc+vjS1zzvB9VWoGDwjzRV0w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lswOmZ/nyDVrVkucLfjgotfj3Pu/yCbtP3OuO4X/6eJWMDztfQSTe5FmiSIWLQCE9nhlzaOQ81q7wftRmFiL8Ovr9vUIxaqLGbGrLvcLmTbDSujrqq3SUQLaiJcfPMSbNAgUIDJzjdLJCtPlZJmpTCzjRs5w4ZLqp/kVUogV5NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=lqnYTu6b; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=MO1G+VfoWaA5Lpkx4zXr0I7Bq0kqRKDgrhrFFwxt/54=; b=lqnYTu6bcHN+l7CFQlxLnuSAQD
	j7S0rDLWQ2VSZtAZebVg2xNlC3c6M3EOS0I7GNrsNEGA4CJECY/wxnsev17aR0gNbQc70W2hkikUY
	3bcWmewshAVU03IoYxoQDBfwiKUua4qPe5z46aJ+KtyKN5fhSQSbtFmEZ5QxwsdlEcgTgQIQD+Lox
	OvMknEDFWLXQmvrJvOHw7MZwL30U1y7j2U7wQ3yWr+8mqRmBUvjcfi/xtplg0QVnHKBBc8W3qtmHW
	Q0adC5zfNwKnREvaJraCkSP8e8/ySRyj1syLk+mL1MpilOqHMaDy9DjdTwWMYK2cd23nN94Q+e5hA
	K6qDsW8g==;
Received: from [122.175.9.182] (port=60840 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uUQEh-00000008O3i-2rWy;
	Wed, 25 Jun 2025 09:32:24 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id D2F2B1782036;
	Wed, 25 Jun 2025 19:02:15 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id A7F81178171F;
	Wed, 25 Jun 2025 19:02:15 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5M6jJ8by_iVD; Wed, 25 Jun 2025 19:02:15 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 60A781782036;
	Wed, 25 Jun 2025 19:02:15 +0530 (IST)
Date: Wed, 25 Jun 2025 19:02:15 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	s hauer <s.hauer@pengutronix.de>, m-karicheri2 <m-karicheri2@ti.com>, 
	glaroque <glaroque@baylibre.com>, afd <afd@ti.com>, 
	saikrishnag <saikrishnag@marvell.com>, m-malladi <m-malladi@ti.com>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	diogo ivo <diogo.ivo@siemens.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	horms <horms@kernel.org>, s-anna <s-anna@ti.com>, 
	basharath <basharath@couthit.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <1528407284.1597726.1750858335213.JavaMail.zimbra@couthit.local>
In-Reply-To: <68f46d06-c2ba-461b-9d88-8d76f9f84a8f@linux.dev>
References: <20250623135949.254674-1-parvathi@couthit.com> <20250623164236.255083-12-parvathi@couthit.com> <68f46d06-c2ba-461b-9d88-8d76f9f84a8f@linux.dev>
Subject: Re: [PATCH net-next v9 11/11] net: ti: prueth: Adds PTP OC Support
 for AM335x and AM437x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF113 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds PTP OC Support for AM335x and AM437x
Thread-Index: gttxIigjDUoI0uhJByj5kfnS0rDDyw==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> On 23/06/2025 17:42, Parvathi Pudi wrote:
>> From: Roger Quadros <rogerq@ti.com>
>> 
>> PRU-ICSS IEP module, which is capable of timestamping RX and
>> TX packets at HW level, is used for time synchronization by PTP4L.
>> 
>> This change includes interaction between firmware/driver and user
>> application (ptp4l) with required packet timestamps.
>> 
>> RX SOF timestamp comes along with packet and firmware will rise
>> interrupt with TX SOF timestamp after pushing the packet on to the wire.
>> 
>> IEP driver available in upstream linux as part of ICSSG assumes 64-bit
>> timestamp value from firmware.
>> 
>> Enhanced the IEP driver to support the legacy 32-bit timestamp
>> conversion to 64-bit timestamp by using 2 fields as below:
>> - 32-bit HW timestamp from SOF event in ns
>> - Seconds value maintained in driver.
>> 
>> Currently ordinary clock (OC) configuration has been validated with
>> Linux ptp4l.
>> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
>> ---
>>   drivers/net/ethernet/ti/icssg/icss_iep.c     | 155 ++++++++++++++++++-
>>   drivers/net/ethernet/ti/icssg/icss_iep.h     |  12 ++
>>   drivers/net/ethernet/ti/icssm/icssm_prueth.c |  56 ++++++-
>>   drivers/net/ethernet/ti/icssm/icssm_prueth.h |  11 ++
>>   4 files changed, 230 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c
>> b/drivers/net/ethernet/ti/icssg/icss_iep.c
>> index d0850722814e..85e27cc77a3b 100644
>> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
>> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
>> @@ -14,12 +14,15 @@
>>   #include <linux/of.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/timecounter.h>
>> +#include <linux/clocksource.h>
>>   #include <linux/timekeeping.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/of_irq.h>
>>   #include <linux/workqueue.h>
>>   
>>   #include "icss_iep.h"
>> +#include "../icssm/icssm_prueth_ptp.h"
>>   
>>   #define IEP_MAX_DEF_INC		0xf
>>   #define IEP_MAX_COMPEN_INC		0xfff
>> @@ -53,6 +56,14 @@
>>   #define IEP_CAP_CFG_CAPNR_1ST_EVENT_EN(n)	BIT(LATCH_INDEX(n))
>>   #define IEP_CAP_CFG_CAP_ASYNC_EN(n)		BIT(LATCH_INDEX(n) + 10)
>>   
>> +#define IEP_TC_DEFAULT_SHIFT         28
>> +#define IEP_TC_INCR5_MULT            BIT(28)
>> +
>> +/* Polling period - how often iep_overflow_check() is called */
>> +#define IEP_OVERFLOW_CHECK_PERIOD_MS   50
>> +
>> +#define TIMESYNC_SECONDS_COUNT_SIZE    6
>> +
>>   /**
>>    * icss_iep_get_count_hi() - Get the upper 32 bit IEP counter
>>    * @iep: Pointer to structure representing IEP.
>> @@ -87,6 +98,28 @@ int icss_iep_get_count_low(struct icss_iep *iep)
>>   }
>>   EXPORT_SYMBOL_GPL(icss_iep_get_count_low);
>>   
>> +static u64 icss_iep_get_count32(struct icss_iep *iep)
>> +{
>> +	void __iomem *sram = iep->sram;
>> +	u64 v_sec = 0;
>> +	u32 v_ns = 0;
>> +	u64 v = 0;
>> +
>> +	v_ns = icss_iep_get_count_low(iep);
>> +	memcpy_fromio(&v_sec, sram + TIMESYNC_SECONDS_COUNT_OFFSET,
>> +		      TIMESYNC_SECONDS_COUNT_SIZE);
>> +	v = (v_sec * NSEC_PER_SEC) + v_ns;
> 
> How can you be sure that the nanoseconds part does belong to the second
> which was read afterwards? In other words, what is the protection for
> the sutiation when an overflow happened right after you read ns but
> before reading of seconds?
> And another question - you copy 6 bytes of seconds counter directly into
> the memory. How will it deal with different endianess?
> 

We are analyzing further to check the possibility of the race condition.
We will review and address this in next version.

>> +
>> +	return v;
>> +}
>> +
>> +static u64 icss_iep_cc_read(const struct cyclecounter *cc)
>> +{
>> +	struct icss_iep *iep = container_of(cc, struct icss_iep, cc);
>> +
>> +	return icss_iep_get_count32(iep);
>> +}
>> +
>>   /**
>>    * icss_iep_get_ptp_clock_idx() - Get PTP clock index using IEP driver
>>    * @iep: Pointer to structure representing IEP.
>> @@ -280,6 +313,78 @@ static void icss_iep_set_slow_compensation_count(struct
>> icss_iep *iep,
>>   	regmap_write(iep->map, ICSS_IEP_SLOW_COMPEN_REG, compen_count);
>>   }
>>   
>> +/* PTP PHC operations */
>> +static int icss_iep_ptp_adjfine_v1(struct ptp_clock_info *ptp, long scaled_ppm)
>> +{
>> +	struct icss_iep *iep = container_of(ptp, struct icss_iep, ptp_info);
>> +	s32 ppb = scaled_ppm_to_ppb(scaled_ppm);
>> +	struct timespec64 ts;
>> +	int neg_adj = 0;
>> +	u32 diff, mult;
>> +	u64 adj;
>> +
>> +	mutex_lock(&iep->ptp_clk_mutex);
>> +
>> +	if (ppb < 0) {
>> +		neg_adj = 1;
>> +		ppb = -ppb;
>> +	}
>> +	mult = iep->cc_mult;
>> +	adj = mult;
>> +	adj *= ppb;
>> +	diff = div_u64(adj, 1000000000ULL);
>> +
>> +	ts = ns_to_timespec64(timecounter_read(&iep->tc));
>> +	pr_debug("iep ptp adjfine check at %lld.%09lu\n", ts.tv_sec,
>> +		 ts.tv_nsec);
>> +
>> +	iep->cc.mult = neg_adj ? mult - diff : mult + diff;
>> +
>> +	mutex_unlock(&iep->ptp_clk_mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +static int icss_iep_ptp_adjtime_v1(struct ptp_clock_info *ptp, s64 delta)
>> +{
>> +	struct icss_iep *iep = container_of(ptp, struct icss_iep, ptp_info);
>> +
>> +	mutex_lock(&iep->ptp_clk_mutex);
>> +	timecounter_adjtime(&iep->tc, delta);
>> +	mutex_unlock(&iep->ptp_clk_mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +static int icss_iep_ptp_gettimeex_v1(struct ptp_clock_info *ptp,
>> +				     struct timespec64 *ts,
>> +				     struct ptp_system_timestamp *sts)
>> +{
>> +	struct icss_iep *iep = container_of(ptp, struct icss_iep, ptp_info);
>> +	u64 ns;
>> +
>> +	mutex_lock(&iep->ptp_clk_mutex);
>> +	ns = timecounter_read(&iep->tc);
>> +	*ts = ns_to_timespec64(ns);
>> +	mutex_unlock(&iep->ptp_clk_mutex);
>> +
>> +	return 0;
>> +}
>> +
>> +static int icss_iep_ptp_settime_v1(struct ptp_clock_info *ptp,
>> +				   const struct timespec64 *ts)
>> +{
>> +	struct icss_iep *iep = container_of(ptp, struct icss_iep, ptp_info);
>> +	u64 ns;
>> +
>> +	mutex_lock(&iep->ptp_clk_mutex);
>> +	ns = timespec64_to_ns(ts);
>> +	timecounter_init(&iep->tc, &iep->cc, ns);
>> +	mutex_unlock(&iep->ptp_clk_mutex);
>> +
>> +	return 0;
>> +}
>> +
>>   /* PTP PHC operations */
>>   static int icss_iep_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
>>   {
>> @@ -669,6 +774,17 @@ static int icss_iep_ptp_enable(struct ptp_clock_info *ptp,
>>   	return -EOPNOTSUPP;
>>   }
>>   
>> +static long icss_iep_overflow_check(struct ptp_clock_info *ptp)
>> +{
>> +	struct icss_iep *iep = container_of(ptp, struct icss_iep, ptp_info);
>> +	unsigned long delay = iep->ovfl_check_period;
>> +	struct timespec64 ts;
>> +
>> +	ts = ns_to_timespec64(timecounter_read(&iep->tc));
>> +
>> +	pr_debug("iep overflow check at %lld.%09lu\n", ts.tv_sec, ts.tv_nsec);
>> +	return (long)delay;
>> +}
>>   static struct ptp_clock_info icss_iep_ptp_info = {
>>   	.owner		= THIS_MODULE,
>>   	.name		= "ICSS IEP timer",
>> @@ -680,6 +796,18 @@ static struct ptp_clock_info icss_iep_ptp_info = {
>>   	.enable		= icss_iep_ptp_enable,
>>   };
>>   
>> +static struct ptp_clock_info icss_iep_ptp_info_v1 = {
>> +	.owner		= THIS_MODULE,
>> +	.name		= "ICSS IEP timer",
>> +	.max_adj	= 10000000,
>> +	.adjfine	= icss_iep_ptp_adjfine_v1,
>> +	.adjtime	= icss_iep_ptp_adjtime_v1,
>> +	.gettimex64	= icss_iep_ptp_gettimeex_v1,
>> +	.settime64	= icss_iep_ptp_settime_v1,
>> +	.enable		= icss_iep_ptp_enable,
>> +	.do_aux_work	= icss_iep_overflow_check,
>> +};
>> +
>>   struct icss_iep *icss_iep_get_idx(struct device_node *np, int idx)
>>   {
>>   	struct platform_device *pdev;
>> @@ -701,6 +829,18 @@ struct icss_iep *icss_iep_get_idx(struct device_node *np,
>> int idx)
>>   	if (!iep)
>>   		return ERR_PTR(-EPROBE_DEFER);
>>   
>> +	if (iep->plat_data->iep_rev == IEP_REV_V1_0) {
>> +		iep->cc.shift = IEP_TC_DEFAULT_SHIFT;
>> +		iep->cc.mult = IEP_TC_INCR5_MULT;
>> +
>> +		iep->cc.read = icss_iep_cc_read;
>> +		iep->cc.mask = CLOCKSOURCE_MASK(64);
>> +
>> +		iep->ovfl_check_period =
>> +			msecs_to_jiffies(IEP_OVERFLOW_CHECK_PERIOD_MS);
>> +		iep->cc_mult = iep->cc.mult;
>> +	}
>> +
>>   	device_lock(iep->dev);
>>   	if (iep->client_np) {
>>   		device_unlock(iep->dev);
>> @@ -795,6 +935,10 @@ int icss_iep_init(struct icss_iep *iep, const struct
>> icss_iep_clockops *clkops,
>>   		icss_iep_enable(iep);
>>   	icss_iep_settime(iep, ktime_get_real_ns());
>>   
>> +	if (iep->plat_data->iep_rev == IEP_REV_V1_0)
>> +		timecounter_init(&iep->tc, &iep->cc,
>> +				 ktime_to_ns(ktime_get_real()));
>> +
>>   	iep->ptp_clock = ptp_clock_register(&iep->ptp_info, iep->dev);
>>   	if (IS_ERR(iep->ptp_clock)) {
>>   		ret = PTR_ERR(iep->ptp_clock);
>> @@ -802,6 +946,9 @@ int icss_iep_init(struct icss_iep *iep, const struct
>> icss_iep_clockops *clkops,
>>   		dev_err(iep->dev, "Failed to register ptp clk %d\n", ret);
>>   	}
>>   
>> +	if (iep->plat_data->iep_rev == IEP_REV_V1_0)
>> +		ptp_schedule_worker(iep->ptp_clock, iep->ovfl_check_period);
>> +
>>   	return ret;
>>   }
>>   EXPORT_SYMBOL_GPL(icss_iep_init);
>> @@ -879,7 +1026,11 @@ static int icss_iep_probe(struct platform_device *pdev)
>>   		return PTR_ERR(iep->map);
>>   	}
>>   
>> -	iep->ptp_info = icss_iep_ptp_info;
>> +	if (iep->plat_data->iep_rev == IEP_REV_V1_0)
>> +		iep->ptp_info = icss_iep_ptp_info_v1;
>> +	else
>> +		iep->ptp_info = icss_iep_ptp_info;
>> +
>>   	mutex_init(&iep->ptp_clk_mutex);
>>   	dev_set_drvdata(dev, iep);
>>   	icss_iep_disable(iep);
>> @@ -1004,6 +1155,7 @@ static const struct icss_iep_plat_data
>> am57xx_icss_iep_plat_data = {
>>   		[ICSS_IEP_SYNC_START_REG] = 0x19c,
>>   	},
>>   	.config = &am654_icss_iep_regmap_config,
>> +	.iep_rev = IEP_REV_V2_1,
>>   };
>>   
>>   static bool am335x_icss_iep_valid_reg(struct device *dev, unsigned int reg)
>> @@ -1057,6 +1209,7 @@ static const struct icss_iep_plat_data
>> am335x_icss_iep_plat_data = {
>>   		[ICSS_IEP_SYNC_START_REG] = 0x11C,
>>   	},
>>   	.config = &am335x_icss_iep_regmap_config,
>> +	.iep_rev = IEP_REV_V1_0,
>>   };
>>   
>>   static const struct of_device_id icss_iep_of_match[] = {
>> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.h
>> b/drivers/net/ethernet/ti/icssg/icss_iep.h
>> index 0bdca0155abd..f72f1ea9f3c9 100644
>> --- a/drivers/net/ethernet/ti/icssg/icss_iep.h
>> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.h
>> @@ -47,21 +47,29 @@ enum {
>>   	ICSS_IEP_MAX_REGS,
>>   };
>>   
>> +enum iep_revision {
>> +	IEP_REV_V1_0 = 0,
>> +	IEP_REV_V2_1
>> +};
>> +
>>   /**
>>    * struct icss_iep_plat_data - Plat data to handle SoC variants
>>    * @config: Regmap configuration data
>>    * @reg_offs: register offsets to capture offset differences across SoCs
>>    * @flags: Flags to represent IEP properties
>> + * @iep_rev: IEP revision identifier.
>>    */
>>   struct icss_iep_plat_data {
>>   	const struct regmap_config *config;
>>   	u32 reg_offs[ICSS_IEP_MAX_REGS];
>>   	u32 flags;
>> +	enum iep_revision iep_rev;
>>   };
>>   
>>   struct icss_iep {
>>   	struct device *dev;
>>   	void __iomem *base;
>> +	void __iomem *sram;
>>   	const struct icss_iep_plat_data *plat_data;
>>   	struct regmap *map;
>>   	struct device_node *client_np;
>> @@ -70,6 +78,10 @@ struct icss_iep {
>>   	struct ptp_clock_info ptp_info;
>>   	struct ptp_clock *ptp_clock;
>>   	struct mutex ptp_clk_mutex;	/* PHC access serializer */
>> +	u32 cc_mult; /* for the nominal frequency */
>> +	struct cyclecounter cc;
>> +	struct timecounter tc;
>> +	unsigned long ovfl_check_period;
>>   	u32 def_inc;
>>   	s16 slow_cmp_inc;
>>   	u32 slow_cmp_count;
>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> index 67ee4c72d3d6..7e90f9e71921 100644
>> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> @@ -39,6 +39,8 @@
>>   #define TX_START_DELAY		0x40
>>   #define TX_CLK_DELAY_100M	0x6
>>   
>> +#define TIMESYNC_SECONDS_BIT_MASK   0x0000ffffffffffff
>> +
>>   static struct prueth_fw_offsets fw_offsets_v2_1;
>>   
>>   static void icssm_prueth_set_fw_offsets(struct prueth *prueth)
>> @@ -642,13 +644,49 @@ irqreturn_t icssm_prueth_ptp_tx_irq_handle(int irq, void
>> *dev)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> +/**
>> + * icssm_iep_get_timestamp_cycles - IEP get timestamp
>> + * @iep: icss_iep structure
>> + * @mem: io memory address
>> + *
>> + * To convert the 10 byte timestamp from firmware
>> + * i.e., nanoseconds part from 32-bit IEP counter(4 bytes)
>> + * seconds part updated by firmware(rev FW_REV1_0) in SRAM
>> + * (6 bytes) into 64-bit timestamp in ns
>> + *
>> + * Return: 64-bit converted timestamp
>> + */
>> +u64 icssm_iep_get_timestamp_cycles(struct icss_iep *iep,
>> +				   void __iomem *mem)
>> +{
>> +	u64 cycles, cycles_sec = 0;
>> +	u32 cycles_ns;
>> +
>> +	memcpy_fromio(&cycles_ns, mem, sizeof(cycles_ns));
>> +	memcpy_fromio(&cycles_sec, mem + 4, sizeof(cycles_sec));
> 
> the same question is here - there is a possibility of overflow
> between these 2 reads...
> 

We are analyzing further to check the possibility of the race condition.
We will review and address this in next version.


Thanks and Regards,
Parvathi.

