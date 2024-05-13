Return-Path: <netdev+bounces-95947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4218C3E4E
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 290BD283051
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FAC1487F4;
	Mon, 13 May 2024 09:46:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F229219E7
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593572; cv=none; b=TyTq8lNxYcThohWD4eFRNITWPFlf7cv5Xt6+ySPTlXo0/4gL+aa/xn9zTDVH1XY5osdCsElaOiEHepBF2AvapStQSgTw3GCsgWXR8w1LeZ+znRULGZfCQJlVFhzLrCHi5vH6jN668ib2D3XHguX+JE499hRVgoJE1Lr0qienVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593572; c=relaxed/simple;
	bh=QLFBlAY2g18QAVL8xNt5PB1nRoDDMkuVeodLKiJrch0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbZsB+GcDHZXlAjNgsSVea/AE4f81B4yeqEtNPCaHzNON9wp80Rv02SprWp+ltOG8bDIaIJ/m/RN3SWSTY0cSZE5O8lMwpgMssWdpgbUtPZC1vXn22TyKhrLdTE69Ma7GZpLLP1iKCrTEq6NKX42SxXgO/OGQzC5g+WlsjcNixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8BxN+lc4UFmqiAMAA--.17647S3;
	Mon, 13 May 2024 17:46:04 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxX1Va4UFmUMocAA--.35016S3;
	Mon, 13 May 2024 17:46:03 +0800 (CST)
Message-ID: <892e56f4-1b89-409a-8acf-27a10578c5a9@loongson.cn>
Date: Mon, 13 May 2024 17:46:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 03/15] net: stmmac: Export dwmac1000_dma_ops
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <12eab04fb430b58574731fbab98ee1354f91100c.1714046812.git.siyanteng@loongson.cn>
 <uyvl7lcleoaw4hze5y6z5ihbnzdvc2e6zwmmsgfskkuqslgwae@p7nnrsc6ry6k>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <uyvl7lcleoaw4hze5y6z5ihbnzdvc2e6zwmmsgfskkuqslgwae@p7nnrsc6ry6k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxX1Va4UFmUMocAA--.35016S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrXw1DJF4kZrykZF4UWF48GrX_yoWxGrXE9w
	sa9F4DCaykJFsay3WktF4kAayxCFWUAr1fK3y5Xr43A34rJFWkXFZ7Ar95Zw10qwsIkws3
	urn3ZF1ayryfCosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=


在 2024/5/3 18:27, Serge Semin 写道:
> On Thu, Apr 25, 2024 at 09:01:56PM +0800, Yanteng Si wrote:
>> The loongson gnet will call it in the future.
> More descriptive commit log:
>
> "Export the DW GMAC DMA-ops descriptor so one could be available in
> the low-level platform drivers. It will be utilized to override some
> callbacks in order to handle the LS2K2000 GNET device specifics. The
> GNET controller support is being added in one of the following up
> commits."
>
> Other than that the change looks good. Thanks.
>
> Reviewed-by: Serge Semin<fancer.lancer@gmail.com>

OK, Thanks!


Thanks,

Yanteng


