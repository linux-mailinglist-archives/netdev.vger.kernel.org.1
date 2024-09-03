Return-Path: <netdev+bounces-124644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A91BA96A4FC
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4E11F26A58
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03E18BC39;
	Tue,  3 Sep 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuGHg7wn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F031E492;
	Tue,  3 Sep 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725383064; cv=none; b=RBSJB8eNJRMupenLWg03owgFrmEdCIcPQ/2Td10JuADpul3ivRfr9Q17LtkiEwUv/XkE8PT1kYJ5RkaezMhH8c3jSGIadk7+K6NB7Gwf8vksSufGsUFt6xfj0CY1lTUIHJnWUy/2Dxw3rlfhB2K2H8/hpht15Ftgeyf4pROOTi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725383064; c=relaxed/simple;
	bh=pGn21AlLH83VAFP2QcI0XeFnk7qfUU2mFm+gHJVxwCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/J0S68K0cZ16sykg3+rn45mIkHAEGAiGcB9Ku7wSDsu4001rj5jU5esvUhrXM5kvCkCFvnHN/v1cQNS3lwSTTF820CzjtybCMGc9y3wnDNP8CQk7e7Qvas6dayPwu4N25RCVHgVEGZhAEVgjglHButidZI7cbDUAUN3zy1lF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuGHg7wn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1605BC4CEC4;
	Tue,  3 Sep 2024 17:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725383064;
	bh=pGn21AlLH83VAFP2QcI0XeFnk7qfUU2mFm+gHJVxwCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XuGHg7wnn9LiqRtBbmPjR0u4R1XdFvPWCD/MKYSYxjHRhUnU1mpFGjmmYY3AWwhwM
	 hF2rbIfplNsjk9BG0g33pYQwyRNpbkgGR4KC+HaCAExf8FGbu8TTRp8rAu+v2v+tob
	 FKsQs/qYeTngHA3qhfJs0u02FtRmJYTpLaWIn7gWTbAi5ssJRo0fGGomlyOPJYjKnz
	 cgQ0PMlfhJeV+3UJoaBPbtld0KqwIKp3Nkehrk9uQVTSSpU4gfRRQ52TBLpnh1Jo0i
	 9bNOfTz84tUvp3qCjdygHwFV8q5dO847io4/z81gQMAbDQBD9S/oT/vf5inWvwbc5d
	 cntu11qerEyeA==
Date: Tue, 3 Sep 2024 18:04:19 +0100
From: Simon Horman <horms@kernel.org>
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@collabora.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: enetc: Replace ifdef with IS_ENABLED
Message-ID: <20240903170419.GH4792@kernel.org>
References: <20240830175052.1463711-1-martyn.welch@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830175052.1463711-1-martyn.welch@collabora.com>

On Fri, Aug 30, 2024 at 06:50:50PM +0100, Martyn Welch wrote:
> The enetc driver uses ifdefs when checking whether
> CONFIG_FSL_ENETC_PTP_CLOCK is enabled in a number of places. This works
> if the driver is compiled in but fails if the driver is available as a

maybe: compiled -> built-in

> kernel module. Replace the instances of ifdef with use of the IS_ENABLED
> macro, that will evaluate as true when this feature is built as a kernel
> module.
> 
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>

...

