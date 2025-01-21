Return-Path: <netdev+bounces-160047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 003FCA17F20
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C053A3D9B
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 13:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727A71F2C4E;
	Tue, 21 Jan 2025 13:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MD8geIto"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E501F2C3E
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737467321; cv=none; b=vC2LE04g51dVoAfEc+TFdZT0AJ6Z7BWlTpB4vOwi8zXP1aDTmqPyaff3zctzAqy6gIFqp9b5/jQ981wbIIUNSRewEkjHl/iISzCMRIV6WJ6wOGTOEI8LIJGNgEa4khb+bQYxOd4uQ6yuYoTgjicx5Fd+QrR0cNomwDZxJk3w1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737467321; c=relaxed/simple;
	bh=A1veeuuDV4mUrpjQBHR1woepVyEYnaVMB8tp7YWwLX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nacMlaNtpFx09iUHp/WazpUt78zHwmSg33hpuiIWBGueIjlELNIdz2abf2Ut9/llhblisj4+sxaK1xYosnEmtS8sF8nh/vmeAVQXzl7+uDtdVlihRAfWAfjP+yy3yxEd2x6eTAVKa16lBLQfA9hVjCZ5wp8pAR0ShIFZM2ayLvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MD8geIto; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e49da678-3bed-47e0-9169-67a777edd700@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737467307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A1veeuuDV4mUrpjQBHR1woepVyEYnaVMB8tp7YWwLX8=;
	b=MD8geItoywKwvi410Xh5hTFCZ+4Z/GAKCp/KyV1RltaFDmUNxW4MiOugDF7szcAclFwLK3
	ofTtKmkpkINwwMfGyntCd6SSvDdJrWqe4K42C70UXeeWJaCxsGWr8pdbY6xfcCRJpEFQGp
	b7bzRTEB7wXCImDbOfbRutZRXOGAoAE=
Date: Tue, 21 Jan 2025 21:47:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Add fix_soc_reset function
To: Huacai Chen <chenhuacai@kernel.org>, Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, fancer.lancer@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250121082536.11752-1-zhaoqunqin@loongson.cn>
 <CAAhV-H7LA7OBCxRzQogCbDeniY39EsxA6GVN07WM=e6EzasM0w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <CAAhV-H7LA7OBCxRzQogCbDeniY39EsxA6GVN07WM=e6EzasM0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 1/21/25 17:29, Huacai Chen 写道:
> Hi, Qunqin,
>
> The patch itself looks good to me, but something can be improved.
> 1. The title can be "net: stmmac: dwmac-loongson: Add fix_soc_reset() callback"
> 2. You lack a "." at the end of the commit message.

> 3. Add a "Cc: stable@vger.kernel.org" because it is needed to backport
> to 6.12/6.13.

Then we also need to have a fixes tag.

Thanks,

Yanteng



