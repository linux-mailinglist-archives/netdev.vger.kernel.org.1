Return-Path: <netdev+bounces-126539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6E7971B94
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669DD1C23558
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A767A1B29DE;
	Mon,  9 Sep 2024 13:50:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156E91B3F23
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889809; cv=none; b=r5L3xNHaiMnIUOdX25QEz/W7YYYm/3VYfYSk+64PmY9ZXdOotX9Votw4NcoiF72zE/eN7pn4DlQtT0rBHPBLhp4LAnarjwJndYLZO3yL9CKTxeiBIgN11x1b+VJuUCROd/uhySRyKvSEdJQEiEOYsi7BZlXNiDWb48608Y0wKL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889809; c=relaxed/simple;
	bh=4XfnCB7MTSfY2+WpkPgJoFJWjCzx5qwN5FMxeyD9h1k=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=A7bs1PkgWmIUxxuS8MxegXh9QFgWWXcQmw5PUqW6twcrrNtHNJSQEhEFFaUuBhcEOfg1V/7cGAQtePDRCidbS5jI8fBZsEcVTk5p04iwz77+pjE+gPKPPU/c4JfP4CE9gyDhu8bOB+b/tDuO9QGtauPVQrbSzm1SH9kIYoFIF/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X2Sqj2LsczyRYC;
	Mon,  9 Sep 2024 21:49:21 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 02D0E1401E9;
	Mon,  9 Sep 2024 21:50:05 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 9 Sep 2024 21:50:04 +0800
Subject: Re: [PATCH -next] MIPS: Remove obsoleted declaration for
 mv64340_irq_init
To: Jakub Kicinski <kuba@kernel.org>
CC: <sebastian.hesselbarth@gmail.com>, <netdev@vger.kernel.org>
References: <20240826032344.4012452-1-cuigaosheng1@huawei.com>
 <20240827142543.277b1bad@kernel.org>
From: cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <bd53d64c-0e1e-cec0-a2ed-c4eded4fe84d@huawei.com>
Date: Mon, 9 Sep 2024 21:50:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240827142543.277b1bad@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200011.china.huawei.com (7.221.188.251)

On 2024/8/28 5:25, Jakub Kicinski wrote:
> On Mon, 26 Aug 2024 11:23:44 +0800 Gaosheng Cui wrote:
>> The mv64340_irq_init() have been removed since
>> commit 688b3d720820 ("[MIPS] Delete Ocelot 3 support."), and now
>> it is useless, so remove it.
> Most of the drivers which used this header have been deleted.
> Please move the only 3(?) defines that are actually used into
> arch/powerpc/platforms/chrp/pegasos_eth.c
> and delete the file completely.
I hava re-sent a new patch v2 with this change, thanks.

