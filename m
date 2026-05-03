Return-Path: <netdev+bounces-283516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLQ5IrCt9mlDXgIAu9opvQ
	(envelope-from <netdev+bounces-283516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:06:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BA14B40EB
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 04:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 002B1300A3A5
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 02:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5F1234964;
	Sun,  3 May 2026 02:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="IcIA02mK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082E215F42
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 02:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777773995; cv=none; b=euS7K8MD+n7hSR7Uxtp9QlbpC9tDPjmW8pRIxZqOJYePUmgBllltnVLR2sk15BeFpDs1/BXAbkcWPMCy+llXMf0o2Ab6cDo8+dO1FWyllXc/LuOxF6CWgWAsJjNbnUnUgr3pINutZRtUof7clivdKe7QS4QxvR/Uhz4pwBvaS2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777773995; c=relaxed/simple;
	bh=qTcHuUwch6LxOFnkGYTL4CalYWxKwr9/UP8XDKGTT/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4RVMedy3d93tbbgCHKgsKs57ge38yaihvQ2jNyruRfYPey6Vp4kehvIwLKZ4q1X5af0k+KIkv0JL823TJFylwmLmYoXSfNZJ+qFr+OuZcBbrB5CLfUYgjS91cp82NqAmFLm6xVaF9ORhn8oaofdGNJJTiyNm3IT/FEZOt6wtdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=IcIA02mK; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8ee63e91acfso236391385a.2
        for <netdev@vger.kernel.org>; Sat, 02 May 2026 19:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1777773992; x=1778378792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pi7lj8hY/RV2kHI36GdoypDFeZXohRaZRLU99hRCU8E=;
        b=IcIA02mKrh9cSLWZmfS2DujBZyk8sv50e4HrhVIIw+ClMHZKas/ZydC0ERbuySKjOa
         XLw25N3UJB2JWpKFF4/kd+OjeY8ro+3aHC1M9EjhAwZZoGYB4zKaQiLwqeNguRtvTRgt
         hwHisICTRc41PvUcNPyDT1gZem76y/MnSkeT1OF/kEEHQ30nzug1LtixNapAlmj81xZq
         XgNyZB99TvfK4TKtTyRCXvsefrR17Tc7f9YL3sfvyUkPrdHfpL0FnPu336AcRIIVJ3DD
         9434m04rZZtrSWigXZMfJSZFzgZrm8WpNyoQQFGf+6finIjld8BrfC0hKZ+mClFb+Z8+
         sbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777773992; x=1778378792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pi7lj8hY/RV2kHI36GdoypDFeZXohRaZRLU99hRCU8E=;
        b=VawpGncIiYH0XRAHmeDOIjXFS0NQVDj4VbI0vyI1rOqHsSu4mv5RKCNCzPcBP4JhAT
         u4khOtgbmi9bYPTvE097Wl75ebylF7KrTeZdR451QFBqdtNBZd+HdJRNyp46tDfM2I8t
         CMVPK+gSr0zFook6JrZq6dt09fJ5/rY8jIL5z7ILcZMZbmG96nlJx9rDvgTtzplSEG0+
         Ctqs89om3x4WDyMP344C5exeVsqyfuNRYcqhu599mk5WiCqg7sEWoQe9FsbbPKjf4rBq
         narSWwNNYQMENzBsd+neaDu07Cag7LthJ3bUbYJRHMoLt22cwAkZxS6coc8rxnjgcbXH
         QKjg==
X-Forwarded-Encrypted: i=1; AFNElJ8sdx0eYiT+Im64gl+tGkaMJzPgakyLtVVHnLawC6kvgcoGOG0wgDJ50uvpyGH6Xlq4Pq/6Fwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5sCw1sohX44YE+qlba/Ah2kU7u/9W6+IJ6myAz6woY6gsY/5o
	r5XCf739vfran4T9ggbJh3Ntm4hn3H1TMH5CEibHQ1+6LYi9b5Ls1mh/R3rIQHuw428=
X-Gm-Gg: AeBDietoRNVHwQLsxVgrf5CzEL2No8zRUcTQnBY/CJwyNc+mPKUzozDMAtaOfd06MMi
	oBIJlJgRuLeUwfcq2gLQgUw4YKgyuX2JjRsBuCmrQ7xQ+dV2cDnGObnLKPCtt8Q8z5z9XTdwprU
	vxqBrlutTA7guFMMsx75HDV1q+EchVD9/AWg5yz0KHH0tOq+RaYFNr4JYHmPj0G9FlOatKx9Ymk
	5bBRmpyhiHnFsGhKq5qzPgN1OO0AYqYvbs8egN8bbNYS0U9wjCC7i8vwKNsJGNoMHdNJqxIrlLU
	IGnbSyMZUw+j3MwYg3UOY8MdhPhE77rtuFsN6+sj5RTfv7j5oe15iCumipFMWy2MoCn3qUMvoOM
	3tMJjjZyxDqhE+TWz8LzsEAu1dqmE5Dc0BRk/J4TDhyoM3DYLpYwHDei6Gs7RP0LvaG8vhXZHaL
	95xWFzevwsdfJxfp2oCkrD14Y1pHTlKZ0Q0Ckkj3acJoh90EvWNC+e0rGkMQCxdF7nZeDjXamge
	g==
X-Received: by 2002:a05:620a:4083:b0:8f1:5e8f:ffe8 with SMTP id af79cd13be357-8fd16aa97ebmr768552485a.23.1777773992247;
        Sat, 02 May 2026 19:06:32 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d831ac7sm72634806d6.49.2026.05.02.19.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2026 19:06:31 -0700 (PDT)
Message-ID: <083e91d0-d86f-4de9-a01f-ce44eadacc13@riscstar.com>
Date: Sat, 2 May 2026 21:06:28 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/12] misc: tc956x_pci: add TC956x/QPS615
 support
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, andersson@kernel.org, konradybcio@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, linusw@kernel.org,
 brgl@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com, a0987203069@gmail.com,
 alexandre.torgue@foss.st.com, ast@kernel.org, boon.khai.ng@altera.com,
 chenchuangyu@xiaomi.com, chenhuacai@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, hkallweit1@gmail.com, inochiama@gmail.com,
 john.fastabend@gmail.com, julianbraha@gmail.com, livelycarpet87@gmail.com,
 matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
 prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
 rohan.g.thomas@altera.com, sdf@fomichev.me, siyanteng@cqsoftware.com.cn,
 weishangjuan@eswincomputing.com, wens@kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-12-elder@riscstar.com>
 <f9336d01-e2d1-4894-848a-17ab20976872@lunn.ch>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <f9336d01-e2d1-4894-848a-17ab20976872@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D9BA14B40EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[riscstar-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[riscstar.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,arndb.de,linuxfoundation.org,riscstar.com,oss.qualcomm.com,gmail.com,foss.st.com,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283516-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[riscstar-com.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elder@riscstar.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riscstar-com.20251104.gappssmtp.com:dkim]

On 5/1/26 4:07 PM, Andrew Lunn wrote:
>> diff --git a/drivers/misc/tc956x_pci.c b/drivers/misc/tc956x_pci.c
> 
>> +static inline void chip_reset_assert(const struct tc956x_chip *chip,
>> +				     enum reset_id id)
>> +{
>> +	tc956x_reset_clock_set(chip, true, true, true, (u8)id);
>> +}
> 
> This is in drivers/misc, where the rules might be different. But in
> netdev, we don't like inline functions in .c files. It is better to
> let the compiler decide.

That was a mistake.  I agree with that perspective.  These functions
were moved out of the header file because they were only used here.
And in the process, I neglected to drop the inline.  Will fix.

>> +static void chip_init_state(struct tc956x_chip *chip)
>> +{
>> +	/* The only IP block we currently use is MSIGEN */
>> +	chip_reset_assert(chip, RESET_MCU);
>> +	chip_reset_assert(chip, RESET_MCU1);
>> +	chip_reset_assert(chip, RESET_INTC);
>> +	chip_reset_assert(chip, RESET_UART0);
>> +	chip_clock_disable(chip, CLOCK_MCU);
>> +	chip_clock_disable(chip, CLOCK_SRAM);
>> +	chip_clock_disable(chip, CLOCK_PLL);
>> +	chip_clock_disable(chip, CLOCK_SGMII);
> 
> With my networking hat on, this one standard out.
> 
>> +	chip_clock_disable(chip, CLOCK_REFCLK);
> 
> The name REFCLK is sometimes used as for the clock signals for RGMII?

You're saying that the REFCLK disable stood out, and you want to
understand what "REFCLK" actually represents?

I believe this is an *output* reference clock signal generated by the
TC9564.  Looking at the schematic for the RB3gen2 it leads only to
a test point.

However I want to compare notes with Daniel on Monday about this.

Would it draw less attention if it were named "REFCLKO"?

In any case we can add some reassuring comments.

> 
>> +static int
>> +tc956x_function_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct tc956x_chip *chip;
>> +	unsigned int msigen_irq;
>> +	int ret;
>> +
>> +	/* Despite being a PCI device, we require devicetree */
>> +	if (!dev->of_node)
>> +		return -EINVAL;
> 
> Might be worth a dev_err(), since it is unusual.

Good suggestion.  I'll add that.

Thanks a lot for your review.

					-Alex

> 
> 	Andrew


