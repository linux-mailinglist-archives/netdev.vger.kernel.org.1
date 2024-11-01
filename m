Return-Path: <netdev+bounces-140931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0F09B8AFD
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 07:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74F4D280C3D
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 06:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9C014D2BB;
	Fri,  1 Nov 2024 06:08:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBAF14C5BF;
	Fri,  1 Nov 2024 06:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730441314; cv=none; b=gepCHyPKeipZiN2VU0WGn7EsN+aHRXGAwjNv3N7uWAsrT9ZrIuhH/joFX5J+PS9FT3+l0WLBq6vFPVtUBiGRVjGpxgj2438ZarRC/94EC9PAzHn9sBmNcIZeN5c5xlxS6Y0jQQjCRTr7hVRg5+i6qzygzB2MfGp4I+RamF2mUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730441314; c=relaxed/simple;
	bh=QCKu+9mVz1iPuk0V3GSi8I15IDVahcS/+5pOcgvR1No=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ebOddzY1JGyPyEp9ynXtEUG7exP+jI9tjQEQsz3KLICUVsCbHnpUSncwIwF+/TlITVyt3EE6QZq+XlMUW4Ml9eqS3tdiIaZb33pEykdLq7dFrK+qJt/L9fKxtYj9ZRbZNbclUzPX9wZvebHwoG8uXT0/JoQyVP+DQVSSJjSY8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xfr3d1gWfz2FbsR;
	Fri,  1 Nov 2024 14:06:53 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A37C61A016C;
	Fri,  1 Nov 2024 14:08:27 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Nov 2024 14:08:26 +0800
Message-ID: <bf66c7a6-af2f-436f-a8eb-50dd46d014d6@huawei.com>
Date: Fri, 1 Nov 2024 14:08:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
	<shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net-next 1/8] net: hibmcge: Add dump statistics
 supported in this module
To: Jakub Kicinski <kuba@kernel.org>
References: <20241026115740.633503-1-shaojijie@huawei.com>
 <20241026115740.633503-2-shaojijie@huawei.com>
 <20241031184527.1d6afe84@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241031184527.1d6afe84@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/11/1 9:45, Jakub Kicinski wrote:
> On Sat, 26 Oct 2024 19:57:33 +0800 Jijie Shao wrote:
>> +	HBG_STATS_REG_I(rx_framesize_64, HBG_REG_RX_PKTS_64OCTETS_ADDR),
>> +	HBG_STATS_REG_I(rx_framesize_65_127,
>> +			HBG_REG_RX_PKTS_65TO127OCTETS_ADDR),
>> +	HBG_STATS_REG_I(rx_framesize_128_255,
>> +			HBG_REG_RX_PKTS_128TO255OCTETS_ADDR),
>> +	HBG_STATS_REG_I(rx_framesize_256_511,
>> +			HBG_REG_RX_PKTS_256TO511OCTETS_ADDR),
>> +	HBG_STATS_REG_I(rx_framesize_512_1023,
>> +			HBG_REG_RX_PKTS_512TO1023OCTETS_ADDR),
>> +	HBG_STATS_REG_I(rx_framesize_1024_1518,
>> +			HBG_REG_RX_PKTS_1024TO1518OCTETS_ADDR),
>> +	HBG_STATS_REG_I(rx_framesize_bt_1518,
>> +			HBG_REG_RX_PKTS_1519TOMAXOCTETS_ADDR),
>> +	HBG_STATS_REG_I(rx_fcs_error_cnt, HBG_REG_RX_FCS_ERRORS_ADDR),
>> +	HBG_STATS_REG_I(rx_data_error_cnt, HBG_REG_RX_DATA_ERR_ADDR),
>> +	HBG_STATS_REG_I(rx_align_error_cnt, HBG_REG_RX_ALIGN_ERRORS_ADDR),
>> +	HBG_STATS_REG_I(rx_frame_long_err_cnt, HBG_REG_RX_LONG_ERRORS_ADDR),
> Please do not dump in ethtool statistics which can be accessed via
> standard APIs like ethtool -I, queue_stats or rtnl_stat.
> https://docs.kernel.org/next/networking/statistics.html

ok, in V3, I will modify this patch according to this document.

Thanks,
Jijie Shao


