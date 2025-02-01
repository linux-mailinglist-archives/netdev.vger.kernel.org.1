Return-Path: <netdev+bounces-161919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6AEA24A0C
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 16:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06357165049
	for <lists+netdev@lfdr.de>; Sat,  1 Feb 2025 15:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C751ADC95;
	Sat,  1 Feb 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NH4dx4t5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2777182
	for <netdev@vger.kernel.org>; Sat,  1 Feb 2025 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738425014; cv=none; b=jGyh1EPS94wC2NUe3S3sEAyDswHJGfniIz2mjplV1B8cPJATVSBKZV+k5HY2s8QGIs5DxSfbKGt0hm4k5V8zrTn5HJWBE9E8JYGueC7Oa7+ADxL1CQu3J5NrtVe8yjs9vnHhCtjmzC8RKYhte3PawBZCVoqTkTXnL8mT28oWrng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738425014; c=relaxed/simple;
	bh=11RCtfiqbETzLPUsjPrZEi/zD02gS98aKiTtDQQEStk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fbwt/5UAgOafvMQ7CjFXYblRdSPGLGsh3br2zvpqnR9iK8bnO7KlBECabXkZnospxjmk1lEFVlDtsYvhuwLD+ZY3I8NsLOBV6QvlthRjAkbi9oBwyYI4/nwAkS5c3jg/RkAFqPo9jCkvkNd6sEGCpWg0/8sc5lJfN1QPCgZyjUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NH4dx4t5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E014C4CEE0;
	Sat,  1 Feb 2025 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738425014;
	bh=11RCtfiqbETzLPUsjPrZEi/zD02gS98aKiTtDQQEStk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NH4dx4t5O/zKKGpN3YtgR4cyClkVoc5gBILLBLVRotKR6A+P95/sSTwDSR56Srefb
	 PMIeLzB0ygTP1RW8tNgItA3wtN5uQeptQqP1uSTQa30xkafkJr/ASi4YTIYJYPmmE4
	 6AgG+Xm6DVBFAXbRMhaW7oQ5blXkWIl61HzhNHz0MkgYKWCtuid9Hd9Gjuo4og7plk
	 bXvIRNkMb1Zs5BsiVq6G4Iy8SkDlZuIlgCMQoMXlN5Dee8F6xHFmdbPfZT/d1eAChn
	 S85/lsdfLAWeMvi3wqa79fyXh7TUayYpTxValkC6uLeLu/KmVJ8RfU6p+SoqMOuLAi
	 xbSveHdTNEkog==
Date: Sat, 1 Feb 2025 15:50:09 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	nbd@nbd.name, sean.wang@mediatek.com, ansuelsmth@gmail.com,
	upstream@airoha.com
Subject: Re: Move airoha in a dedicated folder
Message-ID: <20250201155009.GA211663@kernel.org>
References: <Z54XRR9DE7MIc0Sk@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z54XRR9DE7MIc0Sk@lore-desk>

On Sat, Feb 01, 2025 at 01:44:53PM +0100, Lorenzo Bianconi wrote:
> Hi all,
> 
> Since more features are on the way for airoha_eth driver (support for flowtable
> hw offloading, 10g phy support, ..), I was wondering if it is neater to move
> the driver in a dedicated folder (e.g. drivers/net/ethernet/airoha or
> drivers/net/ethernet/mediatek/airoha) or if you prefer to keep current
> approach. Thanks.

<2c>

Hi Lorenzo,

There already seem drivers to be drivers under drivers/net/ethernet/mediatek/
which are built from more than once .c file. So I think it is fine
to leave Airoha's source there. But, OTOH, I do think it would
be neater to move it into it's own directory. Which is to say,
I for one am happy either way.

If you do chose to go for a new directory, I would suggest
drivers/net/ethernet/mediatek/airoha assuming as it is a Mediatek device.

</2c>



