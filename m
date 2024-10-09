Return-Path: <netdev+bounces-133438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4A3995E67
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 06:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 602E02858E2
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 04:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54497DA88;
	Wed,  9 Oct 2024 04:01:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3C4208D0;
	Wed,  9 Oct 2024 04:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728446487; cv=none; b=qnCEUs1HXhsffSbx2lpAHFMB5glQd6KYV5PKHbJbIZj0PDkCM88PaZXO8mhA7+EwTjg5R8wcCg0bJTh0PCtGHWp39tgxCeZPEosPqBbjXMKbFS4Xl6BxfA+FWs+ttZNt73IQ5aaxiy0/OtoB4N93UP+aZogkY9m4jc7duBHmBV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728446487; c=relaxed/simple;
	bh=+bdt4wCsFD8+3uEMXQ2EhtbEH6h0HBfecTlOUUKVkWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k++by5oHFarDypIKgWl2Vp2htl53lYwQJeBo3opJbE6+s7TSKoqJcUtT5cN2+Pgef+5LGHuOlVQ+NBi351OGtz3HHXSct26FNmypxgVJeon7aU0w8x4c0QvK483AcaPzlw0yCIlGxAB7kFG6VGw5UYWMXu7v89njCJ21t+f0EII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XNfJg4F35zfd3m;
	Wed,  9 Oct 2024 11:58:59 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 39EFC18006C;
	Wed,  9 Oct 2024 12:01:23 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Oct 2024 12:01:22 +0800
Message-ID: <a3f94649-9880-4dc0-a8ab-d43fab7c9350@huawei.com>
Date: Wed, 9 Oct 2024 12:01:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 14/14] mm: page_frag: add an entry in
 MAINTAINERS for page_frag
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>
References: <20241008112049.2279307-1-linyunsheng@huawei.com>
 <20241008112049.2279307-15-linyunsheng@huawei.com>
 <20241008174350.7b0d3184@kernel.org>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241008174350.7b0d3184@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/9 8:43, Jakub Kicinski wrote:
> On Tue, 8 Oct 2024 19:20:48 +0800 Yunsheng Lin wrote:
>> +M:	Yunsheng Lin <linyunsheng@huawei.com>
> 
> The bar for maintaining core code is very high, if you'd 
> like to be a maintainer please start small.

I did start small with the page_pool case, as mentioned in
[1] of a similar comment, and the page_frag is a small
subsystem/library as mentioned in commit log.

I think I still might need a second opinion here.

1. https://lore.kernel.org/linux-kernel/dea82ac3-65fc-c941-685f-9d4655aa4a52@huawei.com/

