Return-Path: <netdev+bounces-206480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD65B0342D
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 03:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84263B5EF0
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 01:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C0218DB1C;
	Mon, 14 Jul 2025 01:33:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5F61FC3;
	Mon, 14 Jul 2025 01:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752456807; cv=none; b=eJA5c3QNT1FgekfBvOJ8Az1AJorqrRrYCdF9buZz17HCk0+fKSqQanlL+ox38lKMIJZAz81l6z4Q4XgdqPCpvyhAukwaxpmIQMj2gmraESYYFOB1xZ6DSJwfr1gEQIZo9B4RlRnky3Wij8loNAPhS4DB0JALQHJ0ZYjfYJsxwTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752456807; c=relaxed/simple;
	bh=r1kM/Haa7Tx+Zcf4hKijkQlvaLnqp6m4o+dFNcNXVkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NERdyrnIAfsdoLgOxLFKPqU2zvRM1Cv1JLPfUr9r9oMMn0jZrQGbBIkj9Gw9MPiLNSuT8sxZvgYvqsKH8Wo9AcZCnRupIyllFQViHk8hZIyDkdWcL2YPoTc9Ltg15irHSKoTM7UZokdoPMI5jc9gF8PrVvM2jF0qs77ePSCA8IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bgPsL5Ln0z29dpR;
	Mon, 14 Jul 2025 09:30:46 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C6101800B2;
	Mon, 14 Jul 2025 09:33:23 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Jul 2025 09:33:22 +0800
Message-ID: <a6d0ccd7-7342-42e1-b653-1a5d4a99a363@huawei.com>
Date: Mon, 14 Jul 2025 09:33:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: mcast: Remove unnecessary null check in
 mld_del_delrec()
To: Markus Elfring <Markus.Elfring@web.de>, <netdev@vger.kernel.org>, David
 Ahern <dsahern@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Kuniyuki
 Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>
References: <20250712092811.2992283-1-yuehaibing@huawei.com>
 <3e9b1ec2-68e2-4d5f-9c74-c64503f178ac@web.de>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <3e9b1ec2-68e2-4d5f-9c74-c64503f178ac@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/7/13 3:32, Markus Elfring wrote:
>> These is no need to check null for pmc twice.
> 
> Can another wording approach be more appropriate?
> 
>   Avoid a duplicate pointer check in this function implementation.
Ok, thanks.

> 
> 
> Regards,
> Markus

