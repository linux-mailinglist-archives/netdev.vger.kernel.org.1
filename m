Return-Path: <netdev+bounces-194108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4962EAC75C3
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 04:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4144E7A8B
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 02:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAC12222A0;
	Thu, 29 May 2025 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUJX5dXw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D071526AEC;
	Thu, 29 May 2025 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748484967; cv=none; b=LAjqZDv0TWkvP9aZlJifG3W6aaG8hAZ4XIkb/TfWsCmoxhmzdRgCo/PWxPH/qkUmPpIbpZqz3O2Y24kDhAzm5XDHUjwj9uu94eVmLB0CYGxFFG1vO9fgYxq/1/I9o1sSzOxZAmJgvoyFaRtMC2eeu7UMdFgzNpk4xiPVr/H31CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748484967; c=relaxed/simple;
	bh=VP/IQdT2nGS/s+RGboroFvF7fX6MZ+U9ZwH4o4Nlc4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+HJez0DwCGaPJr3EJjaNh5F9t0END50GRiWCI1d/aqj57AgwxBPE1CXHrDNxJyDP/Tp1f7dxm6PiYQY8G6qA+258o4ghI8GT/UEiw1u8gZWUzurPN+xpk8K1M1c0Gv47btRqHzuXsM3SNCpcmybXJS2hDO0bfLzOAt5YrCHrv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUJX5dXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39DDC4CEE3;
	Thu, 29 May 2025 02:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748484967;
	bh=VP/IQdT2nGS/s+RGboroFvF7fX6MZ+U9ZwH4o4Nlc4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iUJX5dXw3a9NowbtG9QFD71irkXCZh7CBN6jIJVPGflF05BtdPBfQWEAZFhl6G7Kh
	 DwjF6+Lyuc+vXaa6Y3SJ33rGHopC6CArMOeXebJjHE4mZpqLYZ0iOwxebMp8Cb/xGV
	 wmAUy1QJ0HnWG3CNveRLvaMCdP/LaBI1IKkdWo9LbTM1W3YiDS5MmZVBWkeuHl/HX5
	 6zJ0W5VPWgkj9M5Vi8tYn4gpUKGFHmeUJNV/ZMkWM0jQuDw0SzSBjCvmAVAGmIQOMH
	 66Yj8lsujPYS6EdiAY3NuVUkRsszgOlp4Tz90XeEIkgPPyrl83LcjrEhIkI+JaDBja
	 ltk+hdZUgSvsg==
Date: Wed, 28 May 2025 19:16:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexis =?UTF-8?B?TG90aG9yw6k=?= <alexis.lothore@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, Phil Reid
 <preid@electromag.com.au>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jose
 Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH v3 0/2] net: stmmac: prevent div by 0
Message-ID: <20250528191606.66034ab3@kernel.org>
In-Reply-To: <20250528-stmmac_tstamp_div-v3-0-b525ecdfd84c@bootlin.com>
References: <20250528-stmmac_tstamp_div-v3-0-b525ecdfd84c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 May 2025 10:29:49 +0200 Alexis Lothor=C3=A9 wrote:
> Hello,
> this small series aims to fix a small splat I am observing on a STM32MP157
> platform at boot (see commit 1) due to a division by 0. This new
> revision add the same check in another code path possibly affected by
> the same issue, as discussed in v2.

v3 doesnt apply cleanly. Could you rebase on latest net and repost?

