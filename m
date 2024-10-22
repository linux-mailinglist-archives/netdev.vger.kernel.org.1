Return-Path: <netdev+bounces-137875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B78F9AA375
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A361C1C212A9
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3558619DF8B;
	Tue, 22 Oct 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HB0hdF6l"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C411E481
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729604524; cv=none; b=kOFw+noRsIlCAM7nTip0IrWM9TPpVfsaZuT12JcqWmmvvB7hky8qQ/5PsPtY93vovBMAA+UiavPFXQ3MHNwp2Km/lLxjBDGi9LjdHdQYisBQRQ3lI/Y+YDJ/PWVSmwoCyI1Ng0mAgaSk2J+CHRZm8ra6fZNeCQdEpbgyNHJ7SVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729604524; c=relaxed/simple;
	bh=8LAHlmvjCnVLI3R/XveM3jnZq8nkdvQkV6ZdRTfkY7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AeNhTXTMx5WLrjMXehHV+BRQhvCe+UAG7pLYZFpszJZf/qMX+65P8zotk6siG6H2IF1zliTkMDD8VSKACMcpOF3n2GyhVXyG02RoTgnQBiKr6q80WZsWWF3HA9Q8f0DP0v575UHkr5dtcQ++B9Og9sREV0fYts2cN1R9xXXWOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HB0hdF6l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bC9ouSOrTg2bSNVUD8GkLfHziRerJBFjvfJeszfjZbo=; b=HB0hdF6lnW2UfolSwb2Wvwuubf
	rHo0Iw6CpyLeXIp/uFvLLW/KWJdfPevDc7bmgIf6f1EANpsNrSvVmR+e/tatTL/W5HTS60dqb9Zek
	kjt1c2GkM03jZP/0vrasz+2Zws0Fq1d5IE6hAzPfz2DSPqueApf4POVdOy8LsZbdTb4g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t3F93-00AqXg-BD; Tue, 22 Oct 2024 15:41:57 +0200
Date: Tue, 22 Oct 2024 15:41:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5ZCz6YC86YC8?= <wojackbb@gmail.com>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com
Subject: Re: [PATCH] [net,v2] net: wwan: t7xx: add
 PM_AUTOSUSPEND_MS_BY_DW5933E for Dell DW5933e
Message-ID: <3b34817c-ea4f-484a-abb5-1e6619c6d0ca@lunn.ch>
References: <20240930031624.2116592-1-wojackbb@gmail.com>
 <e2f390c7-4d58-47fb-ba86-b1e5ccd6e546@lunn.ch>
 <CAAQ7Y6Z2xkgxv36=WOxbUArCw3eBeY0nx_7nAH36+Wicjs_fPg@mail.gmail.com>
 <562c8ee8-7ce3-4343-9d93-b01be1235954@lunn.ch>
 <CAAQ7Y6aqLJoScfVD3NMyw_0r42qYS2BCCWa5iRDaM8h1EKwwkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAQ7Y6aqLJoScfVD3NMyw_0r42qYS2BCCWa5iRDaM8h1EKwwkg@mail.gmail.com>

> Hi Andrew,
> 
> The chip of Fibocom FM350 is MTK T7XX,
> It is the same chip as our device.
> 
> We tested the Fibocom FM350 and It had the same issue as our device.
> The following tests use the same environment and steps:
> a. Make data call to connect Internet
> b. No data is transferred to the Internet and wait one minute.
> c. use test script to capture and count power_state until one minute.
> 
> Result:
> 1. When autosuspend_delay_ms is 20000,
> Our device's d3_cold time is 0%
> Fibocom FM350's d3_cold time 0%
> 
> 2. When autosuspend_delay_ms is 5000,
> Our device's d3_cold time is 80%
> Fibocom FM350's d3_cold time 60%
> 
> So this problem is a common problem.
> Should I remove PM_AUTOSUSPEND_MS_BY_DW5933E,
> and modify PM_AUTOSUSPEND_MS to 5000 at my patch?

A sample of two is not great, but does suggest there is nothing
special about the DW5933E, and all users can benefit from this change.

Please do change PM_AUTOSUSPEND_MS.

       Andrew

