Return-Path: <netdev+bounces-61448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CAB823BF6
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 06:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93142B249D1
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 05:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE9A18AF1;
	Thu,  4 Jan 2024 05:58:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DDE18C29
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4T5G7W2S3lz1g1Vq;
	Thu,  4 Jan 2024 13:56:55 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (unknown [7.185.36.236])
	by mail.maildlp.com (Postfix) with ESMTPS id AAC7D180021;
	Thu,  4 Jan 2024 13:58:21 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 13:58:21 +0800
Received: from [10.67.121.229] (10.67.121.229) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 13:58:21 +0800
Subject: Re: [PATCH v2 iproute2 0/6] rdma: print related patches
To: Stephen Hemminger <stephen@networkplumber.org>, <leon@kernel.org>
References: <20240104011422.26736-1-stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>
From: Chengchang Tang <tangchengchang@huawei.com>
Message-ID: <d8a7fb20-823e-2117-9e09-61b32e5d2dda@huawei.com>
Date: Thu, 4 Jan 2024 13:58:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240104011422.26736-1-stephen@networkplumber.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)



On 2024/1/4 9:13, Stephen Hemminger wrote:
> This set of patches makes rdma comman behave more like the
> other commands in iproute2 around printing flags.
> There are some other things found while looking at that code.
>
> This version keeps similar function names to original
>
> Stephen Hemminger (6):
>    rdma: shorten print_ lines
>    rdma: use standard flag for json
>    rdma: make pretty behave like other commands
>    rdma: make supress_errors a bit
>    rdma: add oneline flag
>    rdma: do not mix newline and json object
>
>

Both pretty and oneline are working well.

Tested-by: Chengchang Tang <tangchengchang@huawei.com>

