Return-Path: <netdev+bounces-202427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 660AEAEDD5A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A134216FC35
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8111DF974;
	Mon, 30 Jun 2025 12:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="piYlEXJy"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B6B1DFF7;
	Mon, 30 Jun 2025 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287542; cv=none; b=c2Qpm0i1mDZceYuxF8MTyUH0N3aIVjdfbuUfsPay3zaUIWEmbwxeQhgmhXYrDOOuv8eQ+y+xB52WQ0/FtBiV82KzYqT1dGhtYgYTw9LBMp95IExkAXON9PtZbsXwJVrk7syUe6Z/UmaVCub5oUuKZY0CJnzeG2NSvQ1JHut/XSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287542; c=relaxed/simple;
	bh=nI6ubp+e9wwWOQEzFxWxfJ8iVfs97f4UpsJdUisnoxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2F+O+fUSFtfJstWy6ySqxHHn0BPaVzazLgTW4jyBLlNnJBLomKhKlMYHuHsCYiuo/Q80J5pLufrx4+1wcKhrHPIj3TkUAri0sXX0ksC6+HH027pvMMdr9X7TPPfbuIuPs/VRfub47Pz9Mp1Hz6UH/vmgudHorCKurhiV9v7mig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=piYlEXJy; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751287536; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CHy/aj7Sn9juzFVwa9OaHVeiczeTLceLUFgOEXprNU0=;
	b=piYlEXJypkwW3L2h79WCrH+NQRt5qT/2o4djgi1ztWKISRVF86qqjDf83Cjy4AOQDOpwjket1nrEYKszwgHauxVFUzEg/Tjt2Cvkb1mm48Gn75LiLwFlQj9bN2rs7NyS/fzPkt6uxWrN9dREflKKaEYUWTXfKL/J2DU0CiswDXg=
Received: from 30.221.128.140(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WgCGO0A_1751287534 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Jun 2025 20:45:34 +0800
Message-ID: <b13fd9f0-6f65-404b-9625-e431ee45ed17@linux.alibaba.com>
Date: Mon, 30 Jun 2025 20:45:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ptp: add Alibaba CIPU PTP clock driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250627072921.52754-1-guwen@linux.alibaba.com>
 <0b0d3dad-3fe2-4b3a-a018-35a3603f8c10@lunn.ch>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <0b0d3dad-3fe2-4b3a-a018-35a3603f8c10@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/6/27 15:57, Andrew Lunn wrote:
>> +#define PTP_CIPU_LOG_SUB(dev, level, type, event, fmt, ...) \
>> +({ \
>> +	static DEFINE_RATELIMIT_STATE(_rs, \
>> +				      DEFAULT_RATELIMIT_INTERVAL, \
>> +				      DEFAULT_RATELIMIT_BURST); \
>> +	if (__ratelimit(&_rs)) \
>> +		dev_printk(level, dev, "[%02x:%02x]: " fmt, \
>> +			   type, event, ##__VA_ARGS__); \
>> +})
> 
> Please don't use such wrappers. Just use dev_dbg_ratelimited() etc.
> 

Agree. This was for compatibility with older kernels, I should
change it to new helpers.. Will fix in next version. Thanks!

>> +static int cipu_iowrite8_and_check(void __iomem *addr,
>> +				   u8 value, u8 *res)
>> +{
>> +	iowrite8(value, addr);
>> +	if (value != ioread8(addr))
>> +		return -EIO;
>> +	*res = value;
>> +	return 0;
>> +}
> 
> This probably needs a comment. I assume the hardware is broken and
> sometimes writes don't work? You should state that.
> 

Yes, If the cloud device thinks the written value is not what it
expected, the write will fail. I will add a comment about that, thanks.

>> +static void ptp_cipu_print_dev_events(struct ptp_cipu_ctx *ptp_ctx,
>> +				      int event)
>> +{
>> +	struct device *dev = &ptp_ctx->pdev->dev;
>> +	int type = PTP_CIPU_EVT_TYPE_DEV;
>> +
>> +	switch (event) {
>> +	case PTP_CIPU_EVT_H_CLK_ABN:
>> +		PTP_CIPU_LOG_SUB(dev, KERN_ERR, type, event,
>> +				 "Atomic Clock Error Detected\n");
>> +		break;
>> +	case PTP_CIPU_EVT_H_CLK_ABN_REC:
>> +		PTP_CIPU_LOG_SUB(dev, KERN_INFO, type, event,
>> +				 "Atomic Clock Error Recovered\n");
>> +		break;
>> +	case PTP_CIPU_EVT_H_DEV_MT:
>> +		PTP_CIPU_LOG_SUB(dev, KERN_ERR, type, event,
>> +				 "Maintenance Exception Detected\n");
>> +		break;
>> +	case PTP_CIPU_EVT_H_DEV_MT_REC:
>> +		PTP_CIPU_LOG_SUB(dev, KERN_INFO, type, event,
>> +				 "Maintenance Exception Recovered\n");
>> +		break;
>> +	case PTP_CIPU_EVT_H_DEV_MT_TOUT:
>> +		PTP_CIPU_LOG_SUB(dev, KERN_INFO, type, event,
>> +				 "Maintenance Exception Failed to Recover "
>> +				 "within %d us\n", ptp_ctx->regs.mt_tout_us);
>> +		break;
>> +	case PTP_CIPU_EVT_H_DEV_BUSY:
>> +		PTP_CIPU_LOG_SUB(dev, KERN_ERR, type, event,
>> +				 "PHC Busy Detected\n");
>> +		break;
>> +	case PTP_CIPU_EVT_H_DEV_BUSY_REC:
>> +		PTP_CIPU_LOG_SUB(dev, KERN_INFO, type, event,
>> +				 "PHC Busy Recovered\n");
>> +		break;
>> +	case PTP_CIPU_EVT_H_DEV_ERR:
>> +		PTP_CIPU_LOG_SUB(dev, KERN_ERR, type, event,
>> +				 "PHC Error Detected\n");
>> +		break;
>> +	case PTP_CIPU_EVT_H_DEV_ERR_REC:
>> +		PTP_CIPU_LOG_SUB(dev, KERN_INFO, type, event,
>> +				 "PHC Error Recovered\n");
> 
> Are these fatal? Or can the device still be used after these errors
> occur?

The clock can't work as expected if these events happened.

The gettime operation will get an invalid timestamp whose
PTP_CIPU_M_TS_ABN bit is set and return -EIO.

> 
>> +static int ptp_cipu_enable(struct ptp_clock_info *info,
>> +			   struct ptp_clock_request *request, int on)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int ptp_cipu_settime(struct ptp_clock_info *p,
>> +			    const struct timespec64 *ts)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int ptp_cipu_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int ptp_cipu_adjtime(struct ptp_clock_info *ptp, s64 delta)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
> 
> I've not looked at the core. Are these actually required? Or if they
> are missing, does the core default to -EOPNOTSUPP?
> 

See reply to Vadim :)

>> +static ssize_t register_snapshot_show(struct device *dev,
>> +				      struct device_attribute *attr, char *buf)
>> +{
>> +	struct ptp_cipu_ctx *ctx = pci_get_drvdata(to_pci_dev(dev));
>> +	struct ptp_cipu_regs *regs = &ctx->regs;
>> +
>> +	return sysfs_emit(buf, "%s 0x%x %s 0x%x %s 0x%x %s 0x%x "
>> +			  "%s 0x%x %s 0x%x %s 0x%x %s 0x%x %s 0x%x "
>> +			  "%s 0x%x %s 0x%x %s 0x%x\n",
>> +			  "device_features", regs->dev_feat,
>> +			  "guest_features", regs->gst_feat,
>> +			  "driver_version", regs->drv_ver,
>> +			  "environment_version", regs->env_ver,
>> +			  "device_status", regs->dev_stat,
>> +			  "sync_status", regs->sync_stat,
>> +			  "time_precision(ns)", regs->tm_prec_ns,
>> +			  "epoch_base(years)", regs->epo_base_yr,
>> +			  "leap_second(s)", regs->leap_sec,
>> +			  "max_latency(ns)", regs->max_lat_ns,
>> +			  "maintenance_timeout(us)", regs->mt_tout_us,
>> +			  "offset_threshold(us)", regs->thresh_us);
>> +}
> 
> Is this debug? Maybe it should be placed in debugfs, rather than
> sysfs.

These are considered attributes of the CIPU ptp device, so I perfer
to put them in sysfs.

But I found sysfs prefers only one value per file [1]. The format
here may need to be improved.

[1] https://docs.kernel.org/filesystems/sysfs.html

Thank you for these comments!

Wen Gu

> 
> 	Andrew


