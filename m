Return-Path: <netdev+bounces-233666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C74C172DD
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 747464077BF
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 22:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207C62DF714;
	Tue, 28 Oct 2025 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETgH2vqR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E925126B0AE;
	Tue, 28 Oct 2025 22:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689968; cv=none; b=TWg7Cdnb27HQ+pmPzyR5G+7NTdOAnUurQwo6wImP/rT4nic/jCr1+3JzrZ3r0VQEJgFwHBVYXwsOr70/PFyFL7F7gWlQ10rztOZpfuSQgR3jx52gB00ISxrgUykZMuXA5pi3x90Q/TttP6DKXuHw8NZJyqbUymwKjJHUGHhoIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689968; c=relaxed/simple;
	bh=yzrt0FYCMLcKcOf8fkJpIi0sW/mpdZ4QYj6NRuWqX6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/lQVzJKwvbGwi3UyhVdAqVIJ5kN/Muq8hWvkOyQCbrIjvBeQqHNNCYP1gwH4BBQ5XE2UbckNk0yiPbFhdNHtT+WvG5kMotQ/I2bgLO6RSr5P5D8riyaOyJ1ozDx2gXQGl7b5VElBtVYcDGG0YJy5mUi/Qc1VLBr5WC4wWbU4Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETgH2vqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C785C4CEE7;
	Tue, 28 Oct 2025 22:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761689967;
	bh=yzrt0FYCMLcKcOf8fkJpIi0sW/mpdZ4QYj6NRuWqX6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ETgH2vqRVFELtRx6mfXR2jj78Pj7OJ1UhP25bGPbjy2Z3qr2B3AWDbQb6Ee91di0G
	 0EiK455ipRcrCx/Eum8WD9d85EQ388CwVjcM3c6v2RglaQasBguyLUSeFKC4sqyJHl
	 dlMoHSz+6nskNWpFaPgK6O36SLGauKkvnuPk2Lvfi4n/ybY+k2tZS7XQ92I9hqBa80
	 fjeYtAQUUV7WqOjnMoUPlUFIyssJiJ+6JoXbUinYWIQOz7fN5g0/RSSPTi3H9cky4u
	 SdKAgRuxqEQSO681n+jsQIgC6QjY/QAbb8GVUaCxobtFeFivoryWYLc3Hzp4WX+MYZ
	 la612AfZ5BfZQ==
Date: Tue, 28 Oct 2025 15:19:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: stmmac: Add a devlink attribute to
 control timestamping mode
Message-ID: <20251028151925.12784dca@kernel.org>
In-Reply-To: <20251024070720.71174-3-maxime.chevallier@bootlin.com>
References: <20251024070720.71174-1-maxime.chevallier@bootlin.com>
	<20251024070720.71174-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Sorry didn't get to review this in time.

On Fri, 24 Oct 2025 09:07:18 +0200 Maxime Chevallier wrote:
> +   * - ``ts_coarse``

This is not a great name IMHO. Is "coarse" from the PRM?
It's the increment that's coarse, right? Not the timestamp
This naming confuses me greatly.

> +     - Boolean
> +     - runtime
> +     - Enable the Coarse timestamping mode. In Coarse mode, the ptp clock is
> +       expected to be updated through an external PPS input, but the subsecond

I guess the definition of "PPS input" got diluted but technically it
means Pulse Per Second, right? Here IIUC we need an actual 50MHz clock
fed in?

> +       increment used for timestamping is set to 1/ptp_clock_rate. In Fine mode
> +       (i.e. Coarse mode == false), the ptp clock frequency is adjusted more
> +       frequently, but the subsecond increment is set to 2/ptp_clock_rate.
> +       Coarse mode is suitable for PTP Grand Master operation. If unsure, leave
> +       the parameter to False.

My understanding based on your previous explanation is that basically
in one of the modes the frequency cannot be adjusted. It's only usable
if a very stable reference clock is fed into the device (or otherwise
we "trust" the clock that's fed in). So that's why Grand Master.

In the other mode we can tweak the frequency more accurately.
But it comes at a cost of the HW time incrementing 2x larger step.

If that's the case I think we should update the documentation and
rename the knob to indicate that it's the frequency adjustment that's
coarse.

