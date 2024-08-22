Return-Path: <netdev+bounces-120785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978F195AACB
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 04:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997351C221AE
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 02:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C4111712;
	Thu, 22 Aug 2024 02:07:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A961E848C;
	Thu, 22 Aug 2024 02:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724292453; cv=none; b=lk4azt1QNf4CcAo0Qfgn+ZplTKU0vHNWUFLy5DVmwqKj3gLJuowlgVDtrK7WwV2giDNjlnLyqUcPewjmyTcvZge/MTSpTnjNRik6AzESQKGv9lBIUx0cCXKkpIJ3h5v9NUpZThDGh4McaDuQzjtwdcCKYnGjc0rAdB3GrkQlFVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724292453; c=relaxed/simple;
	bh=K+NGOBxSv7laM1te1jg9i9jl5n8vrjzha6+KKvkwIW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T2WZ2bkD7VSs6TfNvVB5z11yFjcPmpelSZH5sxRT1Z9VGe0eNCfav8dvj7aFrSdwlZmNSETvDuDql8XZBYYG15g1+hXWBu1WzAQg0KyPN0lUTuO/okocsflqOJ7qi6geLE13pl6HFP5FsY5Y21R7F0ZGSBpuPcT0bPC2A8OFOT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wq64L61dDzpStN;
	Thu, 22 Aug 2024 10:05:54 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 300BE1800D3;
	Thu, 22 Aug 2024 10:07:27 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 Aug 2024 10:07:26 +0800
Message-ID: <2d67e112-75a0-3111-3f3a-91e6a982652f@huawei.com>
Date: Thu, 22 Aug 2024 10:07:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] net: dsa: Simplify with scoped for each OF child
 loop
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240820065804.560603-1-ruanjinjie@huawei.com>
 <20240821171817.3b935a9d@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240821171817.3b935a9d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/22 8:18, Jakub Kicinski wrote:
> On Tue, 20 Aug 2024 14:58:04 +0800 Jinjie Ruan wrote:
>> Use scoped for_each_available_child_of_node_scoped() when iterating over
>> device nodes to make code a bit simpler.
> 
> Could you add more info here that confirms this works with gotos?
> I don't recall the details but I thought sometimes the scoped
> constructs don't do well with gotos. I checked 5 random uses
> of this loop and 4 of them didn't have gotos.

Hi, Jakub

From what I understand, for_each_available_child_of_node_scoped() is not
related to gotos, it only let the iterating child node self-declared and
automatic release, so the of_node_put(iterating_child_node) can be removed.

For example, the following use case has goto and use this macro:

Link:
https://lore.kernel.org/all/20240813-b4-cleanup-h-of-node-put-other-v1-6-cfb67323a95c@linaro.org/


