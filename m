Return-Path: <netdev+bounces-109161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD099272CE
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 089A7B234ED
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 09:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515061A4F27;
	Thu,  4 Jul 2024 09:18:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F181A2569
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084718; cv=none; b=YblZCTMZsw4BgZzKJk8frXraGhecM57KmyRg6rjt2xWeRKxHk6xQcjP5Cl5TnDW0GIHT+kUWE4bsIUYkJFMa3m13Qw0J8yJngOqwwVd3pb3UqakdorFewS8oyQHg9lZ0OpmjWxXT4OrByds16EVCcDsr2ug4baC/7u1JM/kDxVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084718; c=relaxed/simple;
	bh=bi4hGzzS785L1RQDZot841FBWDEz5qJ59Ip/7FvPcto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNE1EjBOEkwnCx808XpqNVOots1rXti8b+FW88+Q6VDWHEamaGIcBZtfRWvD7cSiSzAWs89TmDGyp62MeQZAPmo1VyD4cvF4MI7QA0wWqPbmjePbi30G7NbLQtAnS6byGcI3WCpPWif4OWDlp4yJIGIidIC71Z8tp/sc/7z+DCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.2])
	by gateway (Coremail) with SMTP id _____8Bx7vDqaIZmZuEAAA--.3003S3;
	Thu, 04 Jul 2024 17:18:34 +0800 (CST)
Received: from [192.168.100.8] (unknown [223.64.68.2])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTcfmaIZm_uI6AA--.6339S3;
	Thu, 04 Jul 2024 17:18:31 +0800 (CST)
Message-ID: <84815edf-d63d-4f4a-9aea-83c2115be45f@loongson.cn>
Date: Thu, 4 Jul 2024 17:18:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 08/15] net: stmmac: dwmac-loongson: Add
 phy_interface for Loongson GMAC
To: Serge Semin <fancer.lancer@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com,
 chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn,
 netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, si.yanteng@linux.dev
References: <cover.1716973237.git.siyanteng@loongson.cn>
 <b6c038eb4daa00760a484692b192957d3ac574db.1716973237.git.siyanteng@loongson.cn>
 <s72su7rcpazqhvzumec6yiw25ickabmcvd4omcz35gyqjv7meo@hoqzgm7bpyfv>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <s72su7rcpazqhvzumec6yiw25ickabmcvd4omcz35gyqjv7meo@hoqzgm7bpyfv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxTcfmaIZm_uI6AA--.6339S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E
	87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2
	Ij64vIr41l4c8EcI0En4kS14v26r126r1DMxAqzxv26xkF7I0En4kS14v26r126r1DMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0HUDJUUUUU==


在 2024/7/2 16:43, Serge Semin 写道:
> On Wed, May 29, 2024 at 06:19:47PM +0800, Yanteng Si wrote:
>> The phy_interface of gmac is PHY_INTERFACE_MODE_RGMII_ID.
> It's better to translate this to a normal sentence:
> "PHY-interface of the Loongson GMAC device is RGMII with no internal
> delays added to the data lines signal. So to comply with that let's
> pre-initialize the platform-data field with the respective enum
> constant."
>
OK. Thanks!


Thanks,

Yanteng


