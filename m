Return-Path: <netdev+bounces-233794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 738D2C18918
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16407349BCA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 06:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671D72EA754;
	Wed, 29 Oct 2025 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o/f2BvsK"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1891F3BA4
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721169; cv=none; b=YGw/Ip3WZdtKkQgE4L5PaXbmF7hQR0QogB5+51De15sBz97wbu5FZBAnjwF+NaYKDCy1fgjYEAspIvnfDgTIRTG6BstkSmax4Da1n+fxHxqAXg+z1Bd+085008bhLPsLMly8e0t9NMEN4wCn+nBzNoqYghcb9W3L+T6BXh9+i20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721169; c=relaxed/simple;
	bh=kWhnFmEBQExl8DKtrg8teAgBLG0Bzqsg1+3VyWXOmm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+dvksYWAN6cNxPa0FROiWy7ESHtMlsLCYEVp2YthXS97LF/az/9bo0WxDZJvXWHfE4vFxLsnEwuApGIC4izxkPy1Xk5H/K/yDnV37ldfrbzyFiieJCh7MIFSXYHGTvQY8VrscodABXK4ZYXz9vGGAatk8YHYZISmwyYvoMqoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o/f2BvsK; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8222CC0BEBA;
	Wed, 29 Oct 2025 06:59:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C0F63606E8;
	Wed, 29 Oct 2025 06:59:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D513F103115AD;
	Wed, 29 Oct 2025 07:59:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761721162; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=F+KTjI1TM7mg6rcCTezA/+UdyBmDty2R5itDbwstprQ=;
	b=o/f2BvsK1UFERMGggVndtxtQP6Off6yNARbRDm45ax8eVzx6q68dtBRTepmeXOju2Zrq3a
	jaH+noqfpaC8Gu9aTjShhjImZRq0X0lMCzzDXyVJkOV7o4wSw+RMjBH+bXzHKaF9tkTROV
	xfMczXjE0dkfTw6GY31uyOk+FWRoY+ASP+3TunTC9hMPsZKyBfeTrlkyznVPrxgBCea9mQ
	2Xi6esdXpqoG2p1KkVm/nKFR0lzaKIy8qT0jhpGlqno5jw0YDmn+UgDngAdIfvQmhRa5BL
	6T0m1GLtxuLgtVRF0l+z7bz9fdL2atrz2GKf0Q2UD7zXVuJDHwzF8H2BIqxAaw==
Message-ID: <71310577-7cea-42ce-8442-49e09e0b958a@bootlin.com>
Date: Wed, 29 Oct 2025 07:59:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: Add a devlink attribute to
 control timestamping mode
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251024070720.71174-1-maxime.chevallier@bootlin.com>
 <20251024070720.71174-3-maxime.chevallier@bootlin.com>
 <20251028151925.12784dca@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251028151925.12784dca@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On 28/10/2025 23:19, Jakub Kicinski wrote:
> Sorry didn't get to review this in time.
> 
> On Fri, 24 Oct 2025 09:07:18 +0200 Maxime Chevallier wrote:
>> +   * - ``ts_coarse``
> 
> This is not a great name IMHO. Is "coarse" from the PRM?

Yes, it uses "fine/coarse"

> It's the increment that's coarse, right? Not the timestamp
> This naming confuses me greatly.

That is true, the ts_ was added as this configuration is done based
on the timestamping control registers, and is refered to as
"timestamping control fine update" in the register defs :(

So you are correct that in the end the clock frequency is coarsely
adjusted.

The patch was applied, should we revert or add another patch to rename
that parameter ?

> 
>> +     - Boolean
>> +     - runtime
>> +     - Enable the Coarse timestamping mode. In Coarse mode, the ptp clock is
>> +       expected to be updated through an external PPS input, but the subsecond
> 
> I guess the definition of "PPS input" got diluted but technically it
> means Pulse Per Second, right? Here IIUC we need an actual 50MHz clock
> fed in?

For GM, yes indeed. I can update the doc accordingly.

> 
>> +       increment used for timestamping is set to 1/ptp_clock_rate. In Fine mode
>> +       (i.e. Coarse mode == false), the ptp clock frequency is adjusted more
>> +       frequently, but the subsecond increment is set to 2/ptp_clock_rate.
>> +       Coarse mode is suitable for PTP Grand Master operation. If unsure, leave
>> +       the parameter to False.
> 
> My understanding based on your previous explanation is that basically
> in one of the modes the frequency cannot be adjusted. It's only usable
> if a very stable reference clock is fed into the device (or otherwise
> we "trust" the clock that's fed in). So that's why Grand Master.
> 
> In the other mode we can tweak the frequency more accurately.
> But it comes at a cost of the HW time incrementing 2x larger step.
> 
> If that's the case I think we should update the documentation and
> rename the knob to indicate that it's the frequency adjustment that's
> coarse.

That's fine by me, just let me know abut the exact process, I can followup
on that :)

Maxime

