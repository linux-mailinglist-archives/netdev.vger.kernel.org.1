Return-Path: <netdev+bounces-240349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 565D1C73A8A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48FE634BE42
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C97C32D7F0;
	Thu, 20 Nov 2025 11:15:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92687309DCE;
	Thu, 20 Nov 2025 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637314; cv=none; b=uxRxINm2kEebtCAgwYKewI3l9165Uwmmjx3TbvKYMNRnTyJqhe+tQmGNFJ8HHeJYbHg22AcBKt11X7HUU84524jsqhuDpdsfS0FPE2Xr+KbR33csiPDa8UzmXV9SyUsTzXgCuJXCMapY0kp/oktARwkmPz19F3fJw/RDvsUINiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637314; c=relaxed/simple;
	bh=W1Z3YYT11xxegUyeuBR7SCeDeW5tJ3eIuqEMn543jPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EIhe0mLeO1G6IjjO7h85dit9BOgHqbtnPFf6wJnyE3cxGwBpd+ltuca046Vd9HoDS/aW9/RaQxntkh7flLyw0F050Oe1vKxmLoW264mqEmoQSTcZFiF7F5t3KaJm96XjTjdbmxwGaOm9WqAT9MoqSXmO4wJCN8JeRttgaEEMskA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dBwjC1vSFzJ467K;
	Thu, 20 Nov 2025 19:14:23 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id A351114033F;
	Thu, 20 Nov 2025 19:15:08 +0800 (CST)
Received: from [10.123.122.223] (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 14:15:08 +0300
Message-ID: <4e73c06e-fec9-4760-804a-eeca0d44943d@huawei.com>
Date: Thu, 20 Nov 2025 14:15:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/13] ipvlan: Fix compilation warning about
 __be32 -> u32
To: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<andrey.bokhanko@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>
References: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com>
 <20251118100046.2944392-6-skorodumov.dmitry@huawei.com>
 <CANn89iJvwF==Kz5GGMxdgM6E8tF8mOk0gUqSt2Lgse-Cvpo9=g@mail.gmail.com>
 <20251118172612.1f2fbf7f@kernel.org>
Content-Language: en-US
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
In-Reply-To: <20251118172612.1f2fbf7f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500004.china.huawei.com (7.188.26.250)


On 19.11.2025 04:26, Jakub Kicinski wrote:
> On Tue, 18 Nov 2025 04:47:03 -0800 Eric Dumazet wrote:
>> On Tue, Nov 18, 2025 at 2:01 AM Dmitry Skorodumov
>> <skorodumov.dmitry@huawei.com> wrote:
>>> Fixed a compilation warning:
>>>
>>> ipvlan_core.c:56: warning: incorrect type in argument 1
>>> (different base types) expected unsigned int [usertype] a
>>> got restricted __be32 const [usertype] s_addr  
>> This is not a compilation warning, but a sparse related one ?
>>
>> This patch does not belong to this series, this is a bit distracting.
>>
>> Send a standalone patch targeting net tree, with an appropriate Fixes: tag
>>
>> Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
> Not sure we should be sending Linus "fixes" for false positive sparse
> warnings at rc7/final..
>

Not sure how to proceed! Is it op if I send this path as "net-next"?


