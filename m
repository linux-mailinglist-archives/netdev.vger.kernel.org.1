Return-Path: <netdev+bounces-124346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438A596914A
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 04:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D132834AF
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 02:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA421CCEC4;
	Tue,  3 Sep 2024 02:06:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EF61581E5
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 02:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725329174; cv=none; b=ON0BwHAOl1mjgrUxTltoOGuickXt2gBbWDherwKLVl8A5p9cxVAGtieAzwFFE/Pky3iNjSdmiA9DTkvtIQL/baDCvglNkYI4gtl7Y6vvTfCdEMDN4yxLBetNQxQojtSkl3d9Kvoi2m8mienkegMqu3iHQW1HTQ5zC7I+dcQCpKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725329174; c=relaxed/simple;
	bh=E8apGhay4HjJ9sUylasxZbos5bQ52XM1jSpNDISg/sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=U5CeeLD2trXBqwAT2o73DO7sinaJin0dqAg8ThVvPngm8xkVRlooWDo2TzyJ7DIObj7xBNzXiOjg5baV4+gSokv2aEJ9ettGFr140hofd1u4nVe9A1Dkt9cJ2hE3BGdV3aTC8rucT3WwLA0Z4CZnThej45g1UPHGYNk6eC3z1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WyTSg5f6Cz1xwrY;
	Tue,  3 Sep 2024 10:04:03 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id EAF911A0188;
	Tue,  3 Sep 2024 10:06:03 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Sep 2024 10:06:03 +0800
Message-ID: <d20a0971-a03b-ce24-1111-ca06de234cd6@huawei.com>
Date: Tue, 3 Sep 2024 10:06:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] netlink: Use the BITS_PER_LONG macro
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<christophe.jaillet@wanadoo.fr>, <horms@kernel.org>, <netdev@vger.kernel.org>
References: <20240902111052.2686366-1-ruanjinjie@huawei.com>
 <20240902183944.6779c0a5@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240902183944.6779c0a5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/3 9:39, Jakub Kicinski wrote:
> On Mon, 2 Sep 2024 19:10:52 +0800 Jinjie Ruan wrote:
>> sizeof(unsigned long) * 8 is the number of bits in an unsigned long
>> variable, replace it with BITS_PER_LONG macro to make it simpler.
> 
> Does coccicheck catch such cases?

Yes


