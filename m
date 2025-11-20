Return-Path: <netdev+bounces-240352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 410CEC73B45
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id D45B82412A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 11:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4F7332904;
	Thu, 20 Nov 2025 11:23:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1373B32FA1F
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637782; cv=none; b=t5qN9LLPh71zgay9ofA3rJOuxJhoSMWboDjkn/o65bOLX9Agpmq2AzaORvttHnaDN2DYkmABdlJC3VPC3pHo6m3TwNJWQWPYfDxvqVsLabpCQ+tUIiMkaZ5jCB21hSdxUgUAKaMTu6gBGuNU/9QJyUTJcppfszh20PeiJnBrbNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637782; c=relaxed/simple;
	bh=lAaaANDENYGNByX/6L5SYl6YqxN2PBSxWCsn7d/pbWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TsBQeSqvlhyNXfaVtHLBfE+b01K02NmGLZWdCVzwbM/4iLIq0KvQFEP/pipbz82uErs9ZWzPKqNP2t1Xtdv5/vSCf41drPF6SYYGrvWaSg3zi72IA59kQM+zZzhcFSeSzQ/XXEJik7t8e5B8LNtFeyb9an2RDiu4kWuk/f5bhsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dBwtQ4KtWzHnH8Y;
	Thu, 20 Nov 2025 19:22:22 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EFF51402ED;
	Thu, 20 Nov 2025 19:22:57 +0800 (CST)
Received: from [10.123.122.223] (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 14:22:56 +0300
Message-ID: <ed1f533c-1fff-4bb2-b710-69f96ffa0ad2@huawei.com>
Date: Thu, 20 Nov 2025 14:22:56 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute2-next 1/1] Support l2macnat in ip util
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>, <andrey.bokhanko@huawei.com>,
	<edumazet@google.com>
References: <20251118112347.2967577-1-skorodumov.dmitry@huawei.com>
 <20251118080611.2e5bdec7@phoenix.local>
Content-Language: en-US
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
In-Reply-To: <20251118080611.2e5bdec7@phoenix.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500004.china.huawei.com (7.188.26.250)


On 18.11.2025 19:06, Stephen Hemminger wrote:
> On Tue, 18 Nov 2025 14:23:47 +0300
> Dmitry Skorodumov <skorodumov.dmitry@huawei.com> wrote:
>
>> Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
>
> Good start, but you need update ipvlan_print_opt as well.
> The trigraph is getting long enough that it is time for a helper function.
>
> Also need to update man page.

Updating man will be tricky: ipvlan/ipvtap part is near totally missing in man... I'll try, but likely help with final editing will be appreciated.

Dmitry


