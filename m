Return-Path: <netdev+bounces-222671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8522B55558
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77825AC01A2
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE153168E4;
	Fri, 12 Sep 2025 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdpOcydJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF71230DED0
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696897; cv=none; b=SGzpilejTGPKaCUWStPaipGcGdQUdhdEJ57KmkcHNT1Ora6M4Cy/8IJI8g11Q7UBFYsJT9I9jXpJ/miDgn8/Fzq9UydoGHpJqy80I85QnyCeJIE6wOXyL7X7szOApCdWREsWP+JG4yHsN6KPuZQngpFOPvYDcmAEBNUAgvnKfDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696897; c=relaxed/simple;
	bh=uFd3tbEtG91YZlY2JzXFJ2gZgRzXgW19GD02hzF9VDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7GO552rL467Pa5F9WOns7aIT1bSV0ycUTUxgRUpoLcZzWxuWr1LznO9Yqk8PhObX53aMUtR6fMKVZ4Q4QQiCCu/KJ0ZFL9u23uXqxGs2NsRK/q1/XvXsyXTIDzxwJewvZFM/OjHJyfbCa8h3cEqD1YrO1nPnNo2kdwWYn6OSUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdpOcydJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DE0C4CEF1;
	Fri, 12 Sep 2025 17:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757696896;
	bh=uFd3tbEtG91YZlY2JzXFJ2gZgRzXgW19GD02hzF9VDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdpOcydJczKuNqE+f8hxU+XqCPJl25oJ9uxwWFs9b/CcYS8IT7LGh8h4fdROETxwz
	 d5aRphnyNo1Jb3HvHIBQfNBOhAxA0ndUE55f4D+qb/zmIijgDtBPi7bDpmJWZJ98dT
	 Op1lkTGKNIRexVputt3FC+1pE71BilwRZ5K3uzPoteH5omF4bdYx1ZVhZ7U3ZtQP6r
	 EKL2XUBg2mmVqs/CbmP8wdWYqRiSL7VRzcw2cHMleR+u6V2NMsuHHTH2qkIg/c066/
	 3oMe6tpzc9CbsjTDuoQi1wbQFXBKKEbtD/tL/MJY7ME9nIHqnE1krOP3gr1S7GjHxc
	 GdwCv9KTRhhDw==
Date: Fri, 12 Sep 2025 18:08:12 +0100
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	intel-wired-lan@lists.osuosl.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] add FEC bins histogramm report via
 ethtool
Message-ID: <20250912170812.GC224143@horms.kernel.org>
References: <20250910221111.1527502-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910221111.1527502-1-vadim.fedorenko@linux.dev>

On Wed, Sep 10, 2025 at 10:11:07PM +0000, Vadim Fedorenko wrote:

...

> Carolina Jubran (3):
>   net/mlx5e: Don't query FEC statistics when FEC is disabled
>   net/mlx5e: Add logic to read RS-FEC histogram bin ranges from PPHCR
>   net/mlx5e: Report RS-FEC histogram statistics via ethtool
> 
> Vadim Fedorenko (1):
>   ethtool: add FEC bins histogramm report

nit: histogram
     (Also in the subject of this email; the cover letter)

...

