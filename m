Return-Path: <netdev+bounces-95967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ABA8C3ECC
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374D61C226CD
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 10:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F229214A0BB;
	Mon, 13 May 2024 10:23:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D7A14A4F9
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595809; cv=none; b=aIo7hMnnK2yCqQBr64fSEjefQyn1hhjDcxgc6kYbi6/s/3vLGkuCS3bTN/UUPtmWRfoYHwikSb2vwRaAiDGL4zq22ZdxnA6EB4Q2fM6ec8OB6ZivDr1rn0jsa2ZVJyTq6iW/5lJ5rnj1cZiN8I0z569tAaw4qkaOaK19OYmutNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595809; c=relaxed/simple;
	bh=eYJIZTrc7lzAFpFrWS+2BOwADKlCJhROg36dbqRAgE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IF5oFWPRi5fzq8SK3sTHxdDbSrCKQcgv7LI80/qlWC75oM9m2cvhc3k7Dh8dek7AMUr1ekBG5FcjRMiyvq+aQV9lVFWwfptQnIyK/1GP/cWwNlqJAnt3Qg8d8lrrRtBb/GsCBcBVScYC4w+92erohFNPliCL20cpG0hBnM6UHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8CxBesd6kFmMCMMAA--.18175S3;
	Mon, 13 May 2024 18:23:25 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxLN4b6kFmu9IcAA--.51613S3;
	Mon, 13 May 2024 18:23:24 +0800 (CST)
Message-ID: <02e83207-d2a9-4057-8205-4954f34cc3ec@loongson.cn>
Date: Mon, 13 May 2024 18:23:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 08/15] net: stmmac: dwmac-loongson: Add phy
 mask for Loongson GMAC
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <d0607989f5bf64c4251259af72d8816469e8865f.1714046812.git.siyanteng@loongson.cn>
 <uc3stkm4yyaudv7x3gaarx2xipxglrrnwo4ixht35gkaq2bec2@zpg6roiq5pnu>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <uc3stkm4yyaudv7x3gaarx2xipxglrrnwo4ixht35gkaq2bec2@zpg6roiq5pnu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxLN4b6kFmu9IcAA--.51613S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtFW5XrW7uF4rWr1fCw4ftFc_yoWxZrgEga
	1YqwnF9w4IvF1Fkr47KFy5ZFy7WFyjvrn3KryxGwsrCw1Fyr45Jrn8G3s3ZFyrXa1IyF1q
	9rs8ur4agryqkosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU82jg7UUUUU==


在 2024/5/4 02:28, Serge Semin 写道:
> On Thu, Apr 25, 2024 at 09:06:11PM +0800, Yanteng Si wrote:
>> The phy mask of gmac(and gnet) is 0.
> First of all the GNET PHY mask won't be zero as you setting it up to
> ~BIT(2) in the patch 13 yourself. Secondly the stmmac_mdio_bus_data
> structure instance is Z-malloced, thus it will be zeroed anyway. So
> the only reason why the explicit stmmac_mdio_bus_data::phy_mask
> zeroing would be useful is to signify the difference between the GMAC
> and GNET devices. But that difference could be relatively easy
> inferred from the code. So to speak IMO the patch has a little value.
> I would drop it.

OK, drop it.


Thanks,

Yanteng


