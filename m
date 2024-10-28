Return-Path: <netdev+bounces-139593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FEA9B376A
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3746A2819BB
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 17:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043B21DF25A;
	Mon, 28 Oct 2024 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1sfpJAI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D074C1DF253
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135645; cv=none; b=C9UASiJAd41MzyM8p13Yt1OE9SQbADOT4ozNOQqs4yeWqntydYft8zdfzxf2Yvpwn8w2F1iwJloaJYEsx/1kdmEwknIrhCUoAG75mhZQZRlw/7F1fn/MCBPlIjBKzRiw281GZ61n4kECgvltr7sSK1i+Bx/S2wHjFL2AQ0ElJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135645; c=relaxed/simple;
	bh=3RvSL9Q/u8DmvbvA1JZLW6q61QnhZw9bpLaNZYTH4gA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRPrw2edXaSCLvcvbrB29r1jJ5FsEEU7hAKrXvURWg7xkNWVQdnU5sXpPba92/Cg4g8NmBjTvjq9R1pzqAVcXs4XykkrhC1JwUSnPS7MR5AlxHhBofwsdaHLqShAPp8zqJAh5IjP2/CMw/aeuUWyjSlc3OMy7jr7fUfzub+WdCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1sfpJAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F74C4CEC7;
	Mon, 28 Oct 2024 17:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730135645;
	bh=3RvSL9Q/u8DmvbvA1JZLW6q61QnhZw9bpLaNZYTH4gA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b1sfpJAIzZtHIurEARhMTQ/ux5vDY48ubPVRQLt5u45VCeMTuscFrEM3WZ6LER9cz
	 +UpG4JXR0XcKdsHmV2NxwfOijNMA7bFSHCD6SQpTvVB4DX+B1LBU4uTaE7WSya5ORV
	 zJnp5mvZP1N7G8Ogr85W81ZatHfFqhMFyT4eLzfOBL8ORlJGjWRtqi4su0hWNCp0BY
	 YR2w7U08WFdNz8Vg8U1bkggkwIr3h1FS1yAm0CfxcYWxb/6ROh6G3SPvs8cpSj52xu
	 2JV6FClYalyLitIW+vMGu6WgXQW+kNS6g4+oQMhvkOunT+J1JKZrZPcFQ/wU29TSwj
	 UBX62m0jMDW5A==
Date: Mon, 28 Oct 2024 10:14:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, saeedm@nvidia.com, leon@kernel.org,
 tariqt@nvidia.com
Subject: Re: [PATCH net-next v3 1/2] dpll: add clock quality level attribute
 and op
Message-ID: <20241028101403.67577dd9@kernel.org>
In-Reply-To: <Zw93LS5X5PXXgb8-@nanopsycho.orion>
References: <20241014081133.15366-1-jiri@resnulli.us>
	<20241014081133.15366-2-jiri@resnulli.us>
	<20241015072638.764fb0da@kernel.org>
	<Zw5-fNY2_vqWFSJp@nanopsycho.orion>
	<20241015080108.7ea119a6@kernel.org>
	<Zw93LS5X5PXXgb8-@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 10:19:57 +0200 Jiri Pirko wrote:
> >> Not sure what do you mean by "clock info". Dpll device and clock is kind
> >> of the same thing. The dpll device is identified by clock-id. I see no
> >> other attributes on the way this direction to more extend dpll attr
> >> namespace.  
> >
> >I'm not an expert but I think the standard definition of a DPLL
> >does not include a built-in oscillator, if that's what you mean.  
> 
> Okay. Then the clock-id we have also does not make much sense.
> Anyway, what is your desire exactly? Do you want to have a nest attr
> clock-info to contain this quality-level attr? Or something else?

I thought clock-id is basically clockid_t, IOW a reference.
I wish that the information about timekeepers was exposed 
by the time subsystem rather than DPLL. Something like clock_getres().

