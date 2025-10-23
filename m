Return-Path: <netdev+bounces-232008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFC6BFFEDD
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53E2F18C2210
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 08:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13422FD1B9;
	Thu, 23 Oct 2025 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Z9EtBMWu"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17F2F7AAF
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761208196; cv=none; b=phZr01ktPUmg451Sm+63X5JoJNxgz4cjjL6qv/fmxC0R41lf66RQiPvDnjXrtLRobx03+5xSz6VBpNQBEhsgcYvEGInHLek9r90GPnelxzD8HokOzswNdj9Xcw3ijQquZD7hYAbScAhv/i/c1+MQl5WfhIInq3uD2tFSOs/3xM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761208196; c=relaxed/simple;
	bh=RVOGLO4SU6Ag9PiMozB+SId9BXOCoH5S3lwExhVdiQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lSSXaMqbEQsxYxNbXhuZ4jzex2+OnhrpWauT2pVMNRLxD2ZVzHCxi3Un9P5GbAZTmp6Y5kMyOu+Xneodkzv7WimblvbgPyPrUbbICG7jSQwSUWw0YOO6dlheSGAHdvznFkqX8VrySgTKC32actUVMjVwyZEQ7aheysWxPuJA8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Z9EtBMWu; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2C2F8C0C408;
	Thu, 23 Oct 2025 08:29:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F3BE86062C;
	Thu, 23 Oct 2025 08:29:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BA200102F245F;
	Thu, 23 Oct 2025 10:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761208190; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=r9GcjNdKx0l5qe7F9q2vo9g6zEhRHjHM5Fp6gH11pEQ=;
	b=Z9EtBMWuXLdFsMpNL5Is/fGSdVkHMoU8On73jz/5/ppGCGeFA/s+BGs5fNBndHP/oE871A
	Kwf77bbihCJTwF2SHIIloFW/npmFuSEW9T1aNCmWFlVk2urveiGjvVxKBzjOcUb1FuPTjc
	N1UZY1+fzrl69/hREa0jTum9igth/ny1umb8LP1B7v+4PWW18Pc8iVnihuAgBElu6Zckg7
	ZpqK34HeP6g3pp37DftoKuVKZpL/yre5EvwGMsncIEtc8X6Q9BvAHc+tTTVlK7g3aJqFTy
	SL91odbrCbiLSoeyIKOUWZKhCaCe0ibxcolKfL2yT5j0H6Q1Gqr/UAJmto0eBA==
Message-ID: <ac505a82-1a01-4c1d-8f9b-826133a07ecf@bootlin.com>
Date: Thu, 23 Oct 2025 10:29:26 +0200
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
 <911372f3-d941-44a8-bec2-dcc1c14d53dd@bootlin.com>
 <20251021160221.4021a302@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251021160221.4021a302@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 22/10/2025 01:02, Jakub Kicinski wrote:
> On Tue, 21 Oct 2025 10:02:01 +0200 Maxime Chevallier wrote:
>> Let me know if you need more clarifications on this
> 
> The explanation was excellent, thank you. I wonder why it's designed
> in such an odd way, instead of just having current_time with some
> extra/fractional bits not visible in the timestamp. Sigh.
> 
> In any case, I don't feel strongly but it definitely seems to me like
> the crucial distinction here is not the precision of the timestamp but
> whether the user intends to dial the frequency.

Yes indeed. I don't have a clear view on wether this is something unique
to stmmac or if this is common enough to justify using the tsconfig API.

As we discuss this, I would tend to think devlink is the way, as this
all boils down to how this particular HW works. Moreover, if we use a
dedicated hwprov qualifier, where do we make it sit in the current
hierarchy (precise > approx) that's used for the TS source selection ?

Maxime

