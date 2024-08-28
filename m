Return-Path: <netdev+bounces-122921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE439631D8
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00ACA1F23533
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB8D1AC453;
	Wed, 28 Aug 2024 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm7YSjv2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E6A15A858;
	Wed, 28 Aug 2024 20:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877271; cv=none; b=Ij4mJkmnnjnQ6iio/vyRx6u0N0r+RF8lPyF+yHqe9TseWB+TydEcnX6/df/ec88tsLRZPjjZjhoTUS4bcRkvlrWBrG07j4QPLRNA1BQPWBmXg/s8OoaFqzScIBgGSIgMTKpZOhp8bCOSx+7uwydLIgTzl4CLHkGIE7tFhgN/Tzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877271; c=relaxed/simple;
	bh=5nh14G/bAWdxRuLW4E1LaIv42sHt5q+xeuHO9WcnG50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILDU97rSAUYKvUCpowbIs242Atbh/qWw+HGcrMmlS47ee9MCC8L2lCH1M+A+53os5kK/Ve+Nak1Cda1plnowcbt7lApt4UoS8SC1TAetutDlpQ7Rn7NWQvPDxYkWtn8cEIqvwr3zfgbQg/qha39xrQkl+EUhyvuwsEO5cMiElVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm7YSjv2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAE1C4CEC0;
	Wed, 28 Aug 2024 20:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724877270;
	bh=5nh14G/bAWdxRuLW4E1LaIv42sHt5q+xeuHO9WcnG50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hm7YSjv2aZ71mf4UjBdQ3sJO7bdjlmFVRDRe6RdLkkKr/Kxe0RLnzBLakuMQdtwDi
	 EDk9K7ZVmbZbsU6EtMpAhpwX2xLqmgn+97sWevLpeeSJew/IR7sKKMn6lg3okaRTpJ
	 dA2Dkq6lD9rfGDxSY0jAsm9eghBkJVRX64IfZLUiIlZmFgwiyrsR/9ErfPlew+jfcF
	 t2aCoG59SsrxHfgUrWRswWaG08fDNhSzU3dzRSwTWY6P7Lk82Ahp8x/IIkj9ZFqrmj
	 hmu8P2WEsSv7Q1xDtSOLF/f4i9f+gZuAt/3fEypuJIlxnX+VTrZW+ub96kozCXCQi2
	 a8yrjq/28uIMA==
Date: Wed, 28 Aug 2024 13:34:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 kernel@pengutronix.de, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v3 1/3] phy: open_alliance_helpers: Add defines
 for link quality metrics
Message-ID: <20240828133428.4988b44f@kernel.org>
In-Reply-To: <Zs6spnCAPsTmUfrL@pengutronix.de>
References: <20240822115939.1387015-1-o.rempel@pengutronix.de>
	<20240822115939.1387015-2-o.rempel@pengutronix.de>
	<20240826093217.3e076b5c@kernel.org>
	<4a1a72f5-44ce-4c54-9bc5-7465294a39fe@lunn.ch>
	<20240826125719.35f0337c@kernel.org>
	<Zs1bT7xIkFWLyul3@pengutronix.de>
	<20240827113300.08aada20@kernel.org>
	<Zs6spnCAPsTmUfrL@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Aug 2024 06:50:46 +0200 Oleksij Rempel wrote:
> Considering that you've requested a change to the uAPI, the work has now become
> more predictable. I can plan for it within the task and update the required
> time budget accordingly. However, it's worth noting that while this work is
> manageable, the time spent on this particular task could be seen as somewhat
> wasted from a budget perspective, as it wasn't part of the original scope.

I can probably take a stab at the kernel side, since I know the code
already shouldn't take me more more than an hour. Would that help?
You'd still need to retest, fix bugs. And go thru review.. so all
the not-so-fun parts

> > Especially that we're talking about uAPI, once we go down
> > the string path I presume they will stick around forever.  
> 
> Yes, I agree with it. I just needed this feedback as early as possible.

Andrew? Do you want to decide? :)

