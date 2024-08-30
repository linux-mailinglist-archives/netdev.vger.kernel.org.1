Return-Path: <netdev+bounces-123623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82B1965CA2
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5411FB24CFB
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 09:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8AF16F909;
	Fri, 30 Aug 2024 09:23:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDD113A261;
	Fri, 30 Aug 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009810; cv=none; b=Xa2XLCnfVH0cUw3otev18fW3DmYX4Y0nW7o7obakzOgWuO98bP02g/KBOKmaMHnI4Kxay4P+TOKOQZ4W3GgpqXhyluL9ezOOSwx0PmQfcOc8lhzJkTn1SnJQ0Ua48wrYz+s/2cSd8wwOJei5LmtrOF9oASmgY7jTxgkiImC4exw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009810; c=relaxed/simple;
	bh=1R+SfJ/WVBPghR5dznv1Q28M32MHt8/ZCt2EAXc61yM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gj8r9Fx0+t6P35PAdf/mKxbWVfMEODhT/HHyk9bXZLFhtFWF7awGpQx+4gshHS7MPI1Brp0JwK3cBG62DfrJY0+go8DvZXG6TvQ7f1W8eDtknMqDKGyGw1kV8RXlKI6ZiJpcJCZ8vzbgI8hnzoqJWAvb5kHY7eVx5za5zsbz7lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WwCNW0ZP2z18MwS;
	Fri, 30 Aug 2024 17:22:35 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id CB513140360;
	Fri, 30 Aug 2024 17:23:25 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 30 Aug 2024 17:23:25 +0800
Message-ID: <e4099e41-bfa4-5f8a-f38a-ebfca0a19e00@huawei.com>
Date: Fri, 30 Aug 2024 17:23:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH net-next 3/3] cxgb: Remove unused declarations
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <bharat@chelsio.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240829123707.2276148-1-yuehaibing@huawei.com>
 <20240829123707.2276148-4-yuehaibing@huawei.com>
 <20240830073624.GG1368797@kernel.org>
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <20240830073624.GG1368797@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2024/8/30 15:36, Simon Horman wrote:
> On Thu, Aug 29, 2024 at 08:37:07PM +0800, Yue Haibing wrote:
>> These were never implenmented since introduction in commit 4d22de3e6cc4
>> ("Add support for the latest 1G/10G Chelsio adapter, T3.").
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> Hi,
> 
> I agree that these were never implemented, but I think the at the
> correct citation is:
> 
> commit 8199d3a79c22 ("[PATCH] A new 10GB Ethernet Driver by Chelsio Communications")

Indeed, I missed this one, thanks!

> 
> ...
> .

