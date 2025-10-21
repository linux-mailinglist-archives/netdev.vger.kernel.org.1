Return-Path: <netdev+bounces-231105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0ECBF522B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8774231A5
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 08:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F0287272;
	Tue, 21 Oct 2025 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ujd1EYVB"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A642C0279;
	Tue, 21 Oct 2025 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761033741; cv=none; b=gFgC5ozA0vHDz91YFTDkdg2Ed7j65cZJtkbYGCxidBKBAtueKhdhB1UrKAA/xXzkTKwtAV7XHtIc9/5hx0LPQb2l63YINctoZZz99N8dEF7TYcXhZEilJgsmthks3112ZCtmIsVHM9Gks5I/bLJqibaDhVEjtL7YowuePx7l5GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761033741; c=relaxed/simple;
	bh=VbThsJznKFD+NheQ9uNHDmuNUxq8TTfMjDafcPKUYO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZmGetyU+GKaQVpIokjEf+sHpPrqqhGaWZcBlmd12XTQd4N0+L96BRhCTuh4ZYPjO81NC2yqXqqRpshBDSFCYzENuNJAMi3PP429cNI5HdXz7NYKx7dPzXe0XNXhEMKujpy8Yz5SkcRfU+uQWR0M/sYXrCQsgl0SkN/inv4Yg44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ujd1EYVB; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BFC36C0B88D;
	Tue, 21 Oct 2025 08:01:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6544860680;
	Tue, 21 Oct 2025 08:02:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31523102F23E1;
	Tue, 21 Oct 2025 10:02:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761033736; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=OegdgNVbNw+KkRfrQDXaRBUpYFyQJOKVqsrjfmccusE=;
	b=Ujd1EYVBFKWa1NGizpbWWxW2JcSND0EfAG/uNPgiqM7MtxUPYXj8cvBuZHZECAxyzULNWV
	vrBlgx+YQ+SGfoxQFPBmfmlzDf2JlljWJvY9YIOQUM2sXrr9XlN/apuAR7bMj4vNmsHh1/
	CRK5W1KvP9/Grku+NViQRRcU4ACaP/dnORToyb2wIEjCCszc3MjS2hBUR2jgaINm1limPa
	iDTrdcJxefCwoOcD+uhypcdvOMqpgmish1KWBWd97oAHVNiFi36612MUwzASchfzMz7Bwe
	k4HUKjjt+XkJ2xwwejOCLPGk3Mot3GrOuwvIWFVqM/8uha1dTJIck21eUTKtkg==
Message-ID: <911372f3-d941-44a8-bec2-dcc1c14d53dd@bootlin.com>
Date: Tue, 21 Oct 2025 10:02:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: stmmac: Allow supporting coarse
 adjustment mode
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251015102725.1297985-1-maxime.chevallier@bootlin.com>
 <20251015102725.1297985-3-maxime.chevallier@bootlin.com>
 <20251017182358.42f76387@kernel.org>
 <d40cbc17-22fa-4829-8eb0-e9fd26fc54b1@bootlin.com>
 <20251020180309.5e283d90@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251020180309.5e283d90@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On 21/10/2025 03:03, Jakub Kicinski wrote:
> On Sat, 18 Oct 2025 09:42:57 +0200 Maxime Chevallier wrote:
>>> If the HW really needs it, just lob a devlink param at it?  
>>
>> I'm totally OK with that. I'm not well versed into devlink, working mostly with
>> embedded devices with simple-ish NICs, most of them don't use devlink. Let me
>> give it a try then :)
>>
>> Thanks for taking a look at this,
> 
> FWIW I dropped this form PW in an attempt to unblock testing of
> Russell's series.

Yup no problem for me

> I'm not convinced that the tsconfig API is correct
> here but I don't get how the HW works. Could you perhaps put together
> some pseudocode?

I'm not fully convinced either, devlink could also work. I already have 
a patchset ready that uses devlink for that.

Let's see if I can do a better job explaining this timestamping
parameter :


- In "fine" mode (mapped to precise qualifier if we go with the
tsinfo approach), which is the mode currently used in stmmac :

  u32 accumulator
  u32 addend
  u64 subsecond_increment

  at each ref ptp clock cycle {
    
    accumulator += addend;

    /* accumulator and addend are 32 bits. addend is adjusted
     * to control the drift of the target frequency.
     */
    if (accumulator overflows)
      current_time += subsecond_increment

  }

Main advantage: We can fine tune when we update the current_time, so
basically we can multiply or divide the ref ptp clock based on when
the accumulator overflows, and use the resulting clock as the
timestamp source.

In practice for stmmac, we set the addend to a value so that it takes
2 cycles to overflow, and we adjust the subsecond increment when
updating the PHC frequency. This gives a precision of 46-ish ns.

We do this by design as the ptp ref clk may be fairly slow (down to
5MHz in some cases). If we try to rely on accumulator overflowing at
every cycle to update the time, we'd have to overflow multiple times
per cycle, and the computation of the addend value simply overflows,
cf commit 91a2559 ("net: stmmac: Fix sub-second increment") [1]

This is basic PTP follower mode, we continuously update
the clock used for timestamping.


- In "coarse" mode :

  u32 subsecond_increment

  at each ref ptp clock cycle {
    current_time += subecond_increment
  }

We increment time at a fixed rate. The current_time can only be adjusted
by setting the entire current_time, which is jittery or even non-monotonically
increasing. However, we can use a 20ns increment (or even lower if the ref
clock is faster), and if our ref clock is externally provided by a high
precision source, this allows implementing Grand Master mode with the
highest possible precision.

[1] : https://lore.kernel.org/netdev/20200415122432.70972-2-julien.beraud@orolia.com/

Hopefully that's a bit clearer WRT what the HW can do.

Let me know if you need more clarifications on this, I'll send another
iteration once Russell's cleanup lands, using either devlink or tsconfig
depending on what we chose here.

Maxime

