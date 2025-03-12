Return-Path: <netdev+bounces-174148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8F5A5D9AD
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470F5189BFE9
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FD723A9B9;
	Wed, 12 Mar 2025 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="I31qYX3K"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-14.ptr.blmpb.com (va-1-14.ptr.blmpb.com [209.127.230.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B92E234988
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772288; cv=none; b=HFt7okqnNtBvKdr4FRIMfTVeP6ySOXJGRwC/8cyW8EZECsRnuFITUOOqDu8P8ozRo4jqnvk3SCIwtjE2PhrOyMFHHUUpCv13+xP6eyhoOMbc6002JzTUlaCJdbGoac6b7TDR9PhfEQvGMhrDxJJavGk8XRrVL81vjzqhYpHcKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772288; c=relaxed/simple;
	bh=It8wPEbTfuXLg+xqXYSKZ+iOCxL7h/LiHMKzqHxJdG8=;
	h=To:Cc:Date:Mime-Version:Content-Type:Message-Id:From:Subject:
	 References:In-Reply-To; b=UpjVLPGjNgdcPIiIEZoHexWxvlLJ4gl9qSbEDne8Ny5sRTq0aMyF1YmnfbpH6eZgMwsjVOe01XvhdXyeHItbPmv5vm28ZDJTEKKOv76AC1Y4S9LkfcspQVUf6zFuIe+X2HB99HgUWc2EWpNkeZDIOOCvHehX2FV71WTai/KOsNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=I31qYX3K; arc=none smtp.client-ip=209.127.230.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1741772268; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=p4U95rgvzzB0lugv/TkDi8GY6kPVotLB9+bBFiziDjw=;
 b=I31qYX3KiYSfk5Vq31wIqaaexfmp8EOZ/y03d0KJ5VJHSatE76/H3Mm8mm9KygL7unQxYv
 ffOArXBACWxNXwLExxXPPPhxMdvfSIqKtk/C8+gWp2vRjVgerxYjnoBqsGmG0mgNpJMDCG
 e+3iGgJUxdbBRhQZpZFR7MlnNy7cHCraRjNmWHZXWt95MLEbVb8LIefCQ/IWhRBC9FZ89r
 x1kXeiQpQb01aAoAr/WxlI3CA6w++GDY/nSad4alReIP4MaAwxwQK1X+z7gSdRJIkzcZ6b
 qfrCXj3EQWLa9ahCZOB3NJgQoD+2MRcrLuzqeVPgb4fIAPZ8y51f5rx3EINzXg==
To: "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>
Date: Wed, 12 Mar 2025 17:37:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <45010804-3eec-4517-98de-a7c87fa5b07c@yunsilicon.com>
X-Lms-Return-Path: <lba+267d155ea+8af514+vger.kernel.org+tianx@yunsilicon.com>
Received: from [127.0.0.1] ([218.1.186.193]) by smtp.feishu.cn with ESMTPS; Wed, 12 Mar 2025 17:37:45 +0800
From: "Xin Tian" <tianx@yunsilicon.com>
Subject: Re: [PATCH net-next v8 14/14] xsc: add ndo_get_stats64
References: <20250307100824.555320-1-tianx@yunsilicon.com> <20250307100858.555320-15-tianx@yunsilicon.com> <c6d1c981-7a5a-4d63-baeb-1d81c388f526@redhat.com>
In-Reply-To: <c6d1c981-7a5a-4d63-baeb-1d81c388f526@redhat.com>
User-Agent: Mozilla Thunderbird

On 2025/3/11 23:28, Paolo Abeni wrote:
> On 3/7/25 11:08 AM, Xin Tian wrote:
>> +void xsc_eth_fold_sw_stats64(struct xsc_adapter *adapter,
>> +			     struct rtnl_link_stats64 *s)
>> +{
>> +	int i, j;
>> +
>> +	for (i = 0; i < xsc_get_netdev_max_channels(adapter); i++) {
>> +		struct xsc_channel_stats *channel_stats;
>> +		struct xsc_rq_stats *rq_stats;
>> +
>> +		channel_stats = &adapter->stats->channel_stats[i];
>> +		rq_stats = &channel_stats->rq;
>> +
>> +		s->rx_packets   += rq_stats->packets;
>> +		s->rx_bytes     += rq_stats->bytes;
> This likely needs a u64_stats_fetch_begin/u64_stats_fetch_retry() pair,
> and u64_stats_update_begin()/end() on the write side.
>
> /P
Good suggestion, I will change it.

