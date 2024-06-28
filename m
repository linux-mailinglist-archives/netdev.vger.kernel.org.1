Return-Path: <netdev+bounces-107815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB13691C6FE
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 21:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AD31C22602
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0847770F3;
	Fri, 28 Jun 2024 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="POcrKtHK"
X-Original-To: netdev@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CC3757ED;
	Fri, 28 Jun 2024 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604698; cv=none; b=CtR0aHEnnAvDUwWN2B33jQDzjz1s9uJ1R7fixmQnxL25oqgkc3kWjJPmee3RVgtVKwgmFWC9JgeppjfpzG07u8KhyHp9mha0g7U+zsg0lyU8Y5MFyVMd+pCnqpS1AY0ErpDKNPmC54jIuGGxvYQR8wn7lkqZBQUfrYSy4wl7CKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604698; c=relaxed/simple;
	bh=HC7XejqTSDq8JmmZQR6kTmlT6s38ElC7/BJdCkeCDoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pd+eMU6yI2kMyGN1wq/X/REyUhONtdlgr+Q1QLa6UrXejTKPvxKrvyK9r5yNNkT9v2vB4XfQ7JGVNO3Rt9WpDJaqp45jC/4FuTJS5mE64UXB8I5a6crM0y6MtPTRMxZcA4xG16I4L/30n6kX70CShKIrgeQDDkUa7xezb+ouybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=POcrKtHK; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Sh9NkNmBlbDEM3+46XPxqidE2npRUNTYyIv5P3xGwTA=; b=POcrKtHKpHJ4edH2e1sV8hKbbq
	DFFK9Tc5qH8t5Vug4hNLTYNByL6I6H4sR8txYjlsImlhj9w8tSsyN4jaDTLEv5y3pS8PWgt8octaw
	Ho2ZSINdacuPDxgHF0yIjiwzc8Lun46GcCVC7TSb38WRmicfUzf4IsO+BDZxj3BSrabo=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sNHj6-000Pxz-2M;
	Fri, 28 Jun 2024 21:57:44 +0200
Message-ID: <6c9f98de-4090-4fe2-8fa3-446c1907f50b@nbd.name>
Date: Fri, 28 Jun 2024 21:57:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
To: Arnd Bergmann <arnd@arndb.de>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>, lorenzo.bianconi83@gmail.com,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 krzysztof.kozlowski+dt@linaro.org, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, upstream@airoha.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 benjamin.larsson@genexis.eu, linux-clk@vger.kernel.org,
 Ratheesh Kannoth <rkannoth@marvell.com>, Sunil Goutham
 <sgoutham@marvell.com>, Andrew Lunn <andrew@lunn.ch>
References: <cover.1718696209.git.lorenzo@kernel.org>
 <f146a6f58492394a77f7d159f3c650a268fbe489.1718696209.git.lorenzo@kernel.org>
 <2d74f9c1-2b46-4544-a9c2-aa470ce36f80@app.fastmail.com>
 <Zn7ykZeBWXN3cObh@lore-desk>
 <6b234ecb-e870-4e5b-b942-bee98e139590@app.fastmail.com>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <6b234ecb-e870-4e5b-b942-bee98e139590@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.06.24 21:34, Arnd Bergmann wrote:
>>> > +static irqreturn_t airoha_irq_handler(int irq, void *dev_instance)
>>> > +{
>>> > +	struct airoha_eth *eth = dev_instance;
>>> > +	u32 intr[ARRAY_SIZE(eth->irqmask)];
>>> > +	int i;
>>> > +
>>> > +	for (i = 0; i < ARRAY_SIZE(eth->irqmask); i++) {
>>> > +		intr[i] = airoha_qdma_rr(eth, REG_INT_STATUS(i));
>>> > +		intr[i] &= eth->irqmask[i];
>>> > +		airoha_qdma_wr(eth, REG_INT_STATUS(i), intr[i]);
>>> > +	}
>>> 
>>> This looks like you send an interrupt Ack to each
>>> interrupt in order to re-arm it, but then you disable
>>> it again. Would it be possible to leave the interrupt enabled
>>> but defer the Ack until the napi poll function is completed?
>>
>> I guess doing so we are not using NAPIs as expected since they are
>> supposed to run with interrupt disabled. Agree?
> 
> The idea of NAPI is that you don't get the same interrupt
> again until all remaining events have been processed.
> 
> How this is achieved is device dependent, and it can either
> be done by masking the interrupt as you do here, or by
> not rearming the interrupt if it gets turned off automatically
> by the hardware. My guess is that writing to REG_INT_STATUS(i)
> is the rearming here, but the device documentation should
> clarify that. It's also possible that this is an Ack that
> is required so you don't immediately get another interrupt.

The interrupt handling of this hardware is pretty much the same as what 
many other devices do: the interrupt status is not automatically cleared 
by the hardware, so the write at the beginning of the interrupt handler 
does that explicitly.
Within the same handler, the interrupt is then masked to ensure that it 
does not fire again until the NAPI poll has completed.

Performing the status write after the poll has completed would be wrong, 
since that leaves open a small race window where events might be missed.

- Felix

