Return-Path: <netdev+bounces-250595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F7BD38442
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADED930FDF43
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEA839C634;
	Fri, 16 Jan 2026 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RFgRY2sI"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5061D3A0B33
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588053; cv=none; b=MNMol0mFR20O0rL2vvwF9jnE/z+RSehYWdNP4Zqiif/KaTCJcvBgrn7N3Kmv9NZ5KETocPN24dRKIYzrZQDS/u8UnQqtbtwYqqD1cfMW3M0KfOUFA5I7OQdKfcUO815V4Kf8IhJVrtp87Jf2fJn9v1cA7trduEBKcOpRzntuk38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588053; c=relaxed/simple;
	bh=rKVfbx5b3NHIz96zrGog3gdN7qEDREG19ZAC1KiUd3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sB5hMEIyIjKu6QSsWNGTrqbKF2Kk28ll9mnXJdWaIUzysr0YoDzFbN19/ayFCaORbz8oNTILeSUxvUpeQ9uVGI0kLl05YuVZxSS06MO0D5ZQH0XGqCFyjEzibdXB5IC3A0a3mJ99PbAlhOjRUF7aFPeA1Tox0AXLTxls27hptrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RFgRY2sI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9D02B4E42117;
	Fri, 16 Jan 2026 18:27:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6817C606F9;
	Fri, 16 Jan 2026 18:27:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 616D010B68C23;
	Fri, 16 Jan 2026 19:27:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768588043; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=M9QR7Zfctf+mqpFF5OtHWXHDrgz/+4rKeF7GVZtlVBo=;
	b=RFgRY2sIGvEGUEUZPSs3f1xmwal9VBo1eHybEb1WaE5/CQo5uZtqT8e2GY+NEad65eBC+w
	k5ky8nxJhCdQeByMFpc27f654Pd7C0iRNtLloxAUEkFPP0oFNoAd7WvcCu8XiAbC5n5Ikw
	69Fb+6Zyu2h5J2aeI20XHtOIvf66GY45GhK09KvzEeKiZVhopIS70FjyR2IP8wip5cvznJ
	LPrpz9uwt8oC3HYNW4e1Tdm0gdc05lW1rktDb599MG4wVpNcgyf6aKwYEYF/VlFCqAO35f
	Bkbu8DWGw/PSg7CoMQPmdaF8XPdpDgSlSg2bUM1a7Xs0DH47I8oc02qEHCMnuA==
Message-ID: <3a93c79e-f755-4642-a3b0-1cce7d0ea0ef@bootlin.com>
Date: Fri, 16 Jan 2026 19:27:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: fix transmit queue timed out after
 resume
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Tao Wang <tao03.wang@horizon.auto>, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <aWd9WUUGhSU5tWcn@shell.armlinux.org.uk>
 <20260115070853.116260-1-tao03.wang@horizon.auto>
 <aWjY7m96e87cBLUZ@shell.armlinux.org.uk>
 <aWlCs5lksxfgL6Gi@shell.armlinux.org.uk>
 <6a946edc-297e-469a-8d91-80430d88f3e5@bootlin.com>
 <51859704-57fd-4913-b09d-9ac58a57f185@bootlin.com>
 <aWmLWxVEBmFSVjvF@shell.armlinux.org.uk>
 <aWo_K0ocxs5kWcZT@shell.armlinux.org.uk>
 <aWp-lDunV9URYNRL@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aWp-lDunV9URYNRL@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 16/01/2026 19:08, Russell King (Oracle) wrote:
> On Fri, Jan 16, 2026 at 01:37:48PM +0000, Russell King (Oracle) wrote:
>> On Fri, Jan 16, 2026 at 12:50:35AM +0000, Russell King (Oracle) wrote:
>>> However, while this may explain the transmit slowdown because it's
>>> on the transmit side, it doesn't explain the receive problem.
>>
>> I'm bisecting to find the cause of the receive issue, but it's going to
>> take a long time (in the mean time, I can't do any mainline work.)
>>
>> So far, the range of good/bad has been narrowed down to 6.14 is good,
>> 1b98f357dadd ("Merge tag 'net-next-6.16' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next") is bad.
>>
>> 14 more iterations to go. Might be complete by Sunday. (Slowness in
>> building the more fully featured net-next I use primarily for build
>> testing, the slowness of the platform to reboot, and the need to
>> manually test each build.)
> 
> Well, that's been a waste of time today. While the next iteration was
> building, because it's been suspicious that each and every bisect
> point has failed so far, I decided to re-check 6.14, and that fails.
> So, it looks like this problem has existed for some considerable
> time. I don't have the compute power locally to bisect over a massive
> range of kernels, so I'm afraid stmmac receive is going to have to
> stay broken unless someone else can bisect (and find a "good" point
> in the git history.)
> 

To me RX looks OK, at least on the various devices I have that use
stmmac. It's fine on Cyclone V socfpga, and imx8mp. Maybe that's Jetson
specific ?

I've got pretty-much line rate with a basic 'iperf3 -c XX" and same with
'iperf3 -c XX -R". What commands are you running to check the issue ?

Are you still seeing the pause frames flood ?

Maxime

