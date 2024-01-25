Return-Path: <netdev+bounces-65771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B91683BA60
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 07:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E71D1C23026
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 06:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0668210A1E;
	Thu, 25 Jan 2024 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HCEZMljK"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBEA1C3D
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706165800; cv=none; b=V2YepC0trglnVOv2c5nzd9VyzZHFKrOrdGyH0rmeqQIqpxyWnIIK32TthZH2TaFwNK6uxrNnA8Wl1c1y31ZgZovDQ+JpAoUr5hpTN1v4U1mr1/5GaWxDJ4/LeJ2g9rkB7i1FqpX7f/1ztYCdDyRS49AJ6vdt0D61CRNWMkF5LSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706165800; c=relaxed/simple;
	bh=AvwuYZw7EnayiCaxmOtO2OJ/oCOi5ywWVCqNnCYuxV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DlYCHfHbgjtiOcYjKUwGhAaLZNj50U+ZJnrbTZ/0C5WdMCiNM5Vwgi6A800Kmp08VZnDTZKKTblAlXOOhvil1+E2e6WL6XW5hLv8p6wamIg32RnaIfzYiozJn/GDE9hKg1gs0IfKqytPP7mT43BkX1TKpG648c5GErRDJliW1nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HCEZMljK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=DsBMx08ahP4nqAs1bOMhfx3wcDF6qcG7sqoIktziPcw=; b=HCEZMljKR5+t8v+JpnQaivf4Nm
	jsODc6YeSv7aYGUhKdicZLyMOxZVYj/+Ju7clddvv60JBGSmdh0WNWSZkvzd3vrj5GU5q+J59Y0Vo
	c1D15jCZFXiwezHrUQYwklavpzpdcKAaT6Z9MFbKNQavc3V+dG/42PtVfJaEj9DkznYqSysDaTCDr
	9B5tEGib58fgyk5LCcORckaDwcltNaZlvzqrk23i7uy8Ts4sf2/2WShM5V8k7LAfSW3Ru42391K7s
	nPL+Nb8X+CLu4Xdg90LOrLGYU9vgm70f1MQ9iU7EsvBrlS1oI9Bgesx0LcFEb4F0rnkVvTfJleKoi
	I6f8EXBQ==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.6])
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rStf6-00000004y2C-2NUr;
	Thu, 25 Jan 2024 06:56:33 +0000
Message-ID: <193e10a3-2eb9-49cf-a1b3-710dc1c1df9e@infradead.org>
Date: Thu, 25 Jan 2024 15:56:25 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ps3_gelic_net.c issue (linux kernel 6.8-rc1)
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 sambat goson <sombat3960@gmail.com>,
 "Linuxppc-dev@lists.ozlabs.org" <Linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <CAC1vu61dspNPx7eVSsV1htnC0d+p4m3pzuv+9jQcyAFJEF4Y3w@mail.gmail.com>
 <71205a49-86f7-48a7-94ce-cfd94e8b103d@csgroup.eu>
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <71205a49-86f7-48a7-94ce-cfd94e8b103d@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 1/25/24 15:46, Christophe Leroy wrote:
> Hi,
> 
> Le 24/01/2024 à 09:41, sambat goson a écrit :
>> 	
>> Hi,
>> I've just test it and find below code not proper in function 
>> "gelic_descr_prepare_rx", line 398.
>> it causes error as my attached file.
>>
>> descr->skb = netdev_alloc_skb(*card->netdev, rx_skb_size);
>> if (!descr->skb) {
>> descr->hw_regs.payload.dev_addr = 0; /* tell DMAC don't touch memory */
>> return -ENOMEM;
>> }
>> descr->hw_regs.dmac_cmd_status = 0;
>> descr->hw_regs.result_size = 0;
>> descr->hw_regs.valid_size = 0;
>> descr->hw_regs.data_error = 0;
>> descr->hw_regs.payload.dev_addr = 0;
>> descr->hw_regs.payload.size = 0;
>> descr->skb = NULL;                     ---->line 398
>>
> 
> Looks like a copy/paste error from gelic_descr_release_tx() in commit 
> 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures"), the 
> whole block is wrong I guess, not only the descr->skb = NULL;
> 
> Geoff, can you fix it ?

Thanks for reporting the problem.  I'll look into fixing it.

-Geoff

