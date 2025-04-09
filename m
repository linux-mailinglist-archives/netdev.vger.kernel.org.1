Return-Path: <netdev+bounces-180633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FE2A81F6C
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8C58A6C5B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966F325A656;
	Wed,  9 Apr 2025 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="T9/1VkR0"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-22.ptr.blmpb.com (sg-1-22.ptr.blmpb.com [118.26.132.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E1925A336
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744186007; cv=none; b=jnWpPOa0wKO/3+oZVN4E4PJ+cvKzx1HbiGOyfPZNu/5d+fbQ6KM1Sj3oKMSy/JTt/O18CaxS2/ORaCODqkTWq92AjD1nKvOGXoddMDXDznIrnEKp3I8LLoBIOsVStRozqjmUMCXsdHE9jtPJOi8szJqEfc0hXvM44sfqpofPdQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744186007; c=relaxed/simple;
	bh=UOPZbgq++e+RgsqyP6fSGebMe6k4ywg9laY08okf3VA=;
	h=Date:References:Cc:From:Subject:Content-Type:To:Message-Id:
	 Mime-Version:In-Reply-To; b=p6E24fsU6HuMoI/tmQr0OPpMrhY3AisrR+VF5lEjJw1veetmoc9vxRxvaJrMjbRyaTg07gGuzBtuypuyv2QJDr4xbeF2taC2lbzG7AlvIli9CvVfoN7FOmVuLc64JxZ8hiVFP4OsjVgcwVv4Dni2NzyvAR4n5dWJS2poZHXSymQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=T9/1VkR0; arc=none smtp.client-ip=118.26.132.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1744185996; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=9sHOZH56bAmY2cYjLuDeRJw33Q5MJTFtaA44qKujOqM=;
 b=T9/1VkR0BamDFIHhZBaGJf8cjlhgCR6+pz676W9nQodo7tJ0Csf/iwGKlLpgbGZ0Yh24He
 FARaZwr/LieoVj8vjRGMgCnGOCyWAP2FtnOJomU6k+5W5YNGG8nC4kgZOmcInuFZ+Rs54s
 fKyDQ/4smW56DORtbX7k177qp/2cs1yFAjzn96w05oAVrmtP/ngeDjEHXs59g8WlCgkear
 Fy+OU0ozxZ2tp1wlp8RPuGvSLgiXg90UXuYUEWpmW01dOwRhgziiRRs15bnykSAC1Xgb2c
 KkO6UmGeAIhnJu2cmO0Vn7zpTUWBY9wrdYFB0kZaujXhX0agkjvjFucT8Ple0A==
Date: Wed, 9 Apr 2025 16:06:30 +0800
References: <20250318151449.1376756-1-tianx@yunsilicon.com> <20250318151520.1376756-14-tianx@yunsilicon.com> <20250326102737.GB892515@horms.kernel.org>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, 
	<davem@davemloft.net>, <jeff.johnson@oss.qualcomm.com>, 
	<przemyslaw.kitszel@intel.com>, <weihg@yunsilicon.com>, 
	<wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>, 
	<kalesh-anakkur.purayil@broadcom.com>, <geert+renesas@glider.be>, 
	<geert@linux-m68k.org>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
From: "Xin Tian" <tianx@yunsilicon.com>
Subject: Re: [PATCH net-next v9 13/14] xsc: Add eth reception data path
Content-Type: text/plain; charset=UTF-8
X-Original-From: Xin Tian <tianx@yunsilicon.com>
To: "Simon Horman" <horms@kernel.org>
Message-Id: <f821b757-9c10-4005-8974-e7fb8ccfd95b@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20250326102737.GB892515@horms.kernel.org>
X-Lms-Return-Path: <lba+267f62a8a+6bb920+vger.kernel.org+tianx@yunsilicon.com>
Received: from [127.0.0.1] ([116.231.163.61]) by smtp.feishu.cn with ESMTPS; Wed, 09 Apr 2025 16:06:32 +0800

On 2025/3/26 18:27, Simon Horman wrote:
> On Tue, Mar 18, 2025 at 11:15:21PM +0800, Xin Tian wrote:
>
> ...
>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h b/=
drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
> ...
>
>> +#define XSC_SET_PFLAG(params, pflag, enable)			\
>> +	do {							\
>> +		if (enable)					\
>> +			(params)->pflags |=3D BIT(pflag);		\
>> +		else						\
>> +			(params)->pflags &=3D ~(BIT(pflag));	\
>> +	} while (0)
> Hi Xin Tian,
>
> XSC_SET_PFLAG() seems to be unused. Perhaps it is best to drop it and
> add it when needed.
>
> And, FWIIW, I would have implemented both XSC_SET_PFLAG() and
> XSC_GET_PFLAG() as functions as there doesn't seem to be a reason that th=
ey
> need to be macros.

I=E2=80=99ll remove both of these macros along with the other=20
|priv_flag|-related code.

The |priv_flag| features are only configured through ethtool, which is=20
not in this patchset.

I=E2=80=99ll add them later along with the ethtool-related code.


Thanks

>
>> +
>> +#define XSC_GET_PFLAG(params, pflag) (!!((params)->pflags & (BIT(pflag)=
)))
> ...
>
>> diff --git a/drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c b/driv=
ers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
> ...
>
>> +bool xsc_eth_post_rx_wqes(struct xsc_rq *rq)
>> +{
>> +	struct xsc_wq_cyc *wq =3D &rq->wqe.wq;
>> +	u8 wqe_bulk, wqe_bulk_min;
>> +	int alloc;
>> +	u16 head;
>> +	int err;
>> +
>> +	wqe_bulk =3D rq->wqe.info.wqe_bulk;
>> +	wqe_bulk_min =3D rq->wqe.info.wqe_bulk_min;
>> +	if (xsc_wq_cyc_missing(wq) < wqe_bulk)
>> +		return false;
>> +
>> +	do {
>> +		head =3D xsc_wq_cyc_get_head(wq);
>> +
>> +		alloc =3D min_t(int, wqe_bulk, xsc_wq_cyc_missing(wq));
>> +		if (alloc < wqe_bulk && alloc >=3D wqe_bulk_min)
>> +			alloc =3D alloc & 0xfffffffe;
>> +
>> +		if (alloc > 0) {
>> +			err =3D xsc_alloc_rx_wqes(rq, head, alloc);
>> +			if (unlikely(err))
>> +				break;
>> +
>> +			xsc_wq_cyc_push_n(wq, alloc);
>> +		}
>> +	} while (xsc_wq_cyc_missing(wq) >=3D wqe_bulk_min);
>> +
>> +	dma_wmb();
>> +
>> +	/* ensure wqes are visible to device before updating doorbell record *=
/
>> +	xsc_rq_notify_hw(rq);
>> +
>> +	return !!err;
> Perhaps it can't occur in practice, but err will be used uninitialised he=
re
> if the alloc condition in the do loop above is never met.
Sure, I'll initilized it to 0
>> +}
> ...

