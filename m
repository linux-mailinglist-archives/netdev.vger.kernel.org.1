Return-Path: <netdev+bounces-232621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C27C076A9
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 18:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7F5F4E93AB
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 16:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85B233B958;
	Fri, 24 Oct 2025 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDeNgxpx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F66309F1E;
	Fri, 24 Oct 2025 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325060; cv=none; b=qmtfah8g2Z2Kykb1WbQlZw6VfN6W1PS7p7+PzH+NywbRIjHyVg0+hv5vLg4ZXqH17cd8YglssHlZ7Sy3a/SKgYvPtAN5HFM4fUskIz9bmRHoGbV+nyB+dOWrGJJRpVuP1RQYtXnC0u/iGLm2vxNsC7wrD7EopWd2PWMRghrU6Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325060; c=relaxed/simple;
	bh=DJwgWQV6LS0y1HCZdTukbp7eZ5b2oG/b60BU6bAySRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUBGVZ0DW4xmLLTuOpuTwN4xkPGH298BvxawQYpuxuzu2WGUxA/sCuYqy3Jd3I/kZX3aRQjCQMt6tvVIZ8kSWitBEaAtrFDbLhmhDWy+6np0acDrMgUJ+OVhW9njrJGz2Gsw+Tpnrl0lyIc0TyG3UwRiTtW8igY/NG0gmho/iBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDeNgxpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356DAC4CEF7;
	Fri, 24 Oct 2025 16:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761325060;
	bh=DJwgWQV6LS0y1HCZdTukbp7eZ5b2oG/b60BU6bAySRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDeNgxpxlfWKCDa5lCi+7eDV6CLbBTSTQ0BI8fCL4g3akCIqJee7S0pfUG+TKpkb1
	 EO1iPBo5W+rlWfRyhW4bdyKJUH6YS3FvDWnPCzgrQy9UjzouQzSTyp4RgzV4+IKpeu
	 oXj119hem00USE8NLX6A+mqmmg8RhiW5+J/VzwiU7TtI6O4IiYctQBbvj4WLqJjvHI
	 fhfbIO8fESHwCfSxtXXu6p3rJrNKhhlQBgLSAVx9BzhTJHJj2x//XVoMOzy37z3V7O
	 mzk3OzVCJT7mkghK3wt4fjeMC8Y9SeOkvcDZt1UKOEBcav6XVkq6AngqfHHKz0VKRx
	 +LHUfZaSgpkYw==
Date: Fri, 24 Oct 2025 17:57:34 +0100
From: Simon Horman <horms@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>, kernel@pengutronix.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Austin Zhang <austin.zhang@intel.com>,
	Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>
Subject: Re: [PATCH v5 04/10] arm64: dts: socfpga: agilex5: smmu enablement
Message-ID: <aPuv_q3beG7kEj9N@horms.kernel.org>
References: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
 <20251024-v6-12-topic-socfpga-agilex5-v5-4-4c4a51159eeb@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-v6-12-topic-socfpga-agilex5-v5-4-4c4a51159eeb@pengutronix.de>

On Fri, Oct 24, 2025 at 01:49:56PM +0200, Steffen Trumtrar wrote:
> From: Austin Zhang <austin.zhang@intel.com>
> 
> Add iommu property for peripherals connected to TBU.
> 
> Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@intel.com>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

As Austin Zhang is the author (as listed in the from line),
their Signed-off-by is needed.

...

