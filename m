Return-Path: <netdev+bounces-174222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE9AA5DDEB
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315EB7AD601
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B62124293B;
	Wed, 12 Mar 2025 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bYtfIQCp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C3923F38F;
	Wed, 12 Mar 2025 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785935; cv=none; b=eJteu5/HwWCdXqGPkEpOuvqR+Iagz/kPiG9TSMvvHqDJGSV0L81y5SdnQ4YAOgsgXJ1lhvA/PuP6tmh1+vNHgSv15j1yBEFmU1T5tm9akmWbetXByxLi44dmPeoEaVSJF1lVid0RKKDRNYJnLYiUovRpPdSjH2gR0Fgvv8Bw1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785935; c=relaxed/simple;
	bh=mrmea888E5Dssk2tV3wb2er0cgRGTeCz9otVTPzTT8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0Go8PJspx7WnOcg+X6dxMZb9C3ILXwGGeH4COGZ/O5CvcIU5R1q7AAisuu/gTfTLxEhL6E6KqulA9NV5d/Q/oOZZjNjgswzrx926qJK4ygT4AAu5Q5/QkuwHzT6kXWbWutsAZKukYW7wL7+jzCrV+XtyYfdbh9+xtPhlrNVR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bYtfIQCp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4gO+URnsQQ7ytYQbborbvXI40PBwXJiX1pwI38d3wI8=; b=bYtfIQCpfh6upACEiKQBnm2fs5
	Fqq1bTrOCNhzTh/e00oyD1XeftmKbWLXGXC3O3X/LASJT6TMYK3D8/UUnt8oX7oji+I5AR29MmdhV
	/1XJhJI/0A+dSe9RWwCdqGweaTjOLU613LbaSpbXiKXebqk1oySBf7EKCvbvalKu9/pI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsM5P-004fuS-BF; Wed, 12 Mar 2025 14:25:27 +0100
Date: Wed, 12 Mar 2025 14:25:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	michal.simek@amd.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, git@amd.com,
	harini.katakam@amd.com
Subject: Re: [PATCH net-next V2 2/2] net: axienet: Add support for 2500base-X
 only configuration.
Message-ID: <ad1e81b5-1596-4d94-a0fa-1828d667b7a2@lunn.ch>
References: <20250312095411.1392379-1-suraj.gupta2@amd.com>
 <20250312095411.1392379-3-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312095411.1392379-3-suraj.gupta2@amd.com>

> +	/* AXI 1G/2.5G ethernet IP has following synthesis options:
> +	 * 1) SGMII/1000base-X only.
> +	 * 2) 2500base-X only.
> +	 * 3) Dynamically switching between (1) and (2), and is not
> +	 * implemented in driver.
> +	 */
> +
> +	if (axienet_ior(lp, XAE_ABILITY_OFFSET) & XAE_ABILITY_2_5G)

How can we tell if the synthesis allows 3)?

Don't we have a backwards compatibility issue here? Maybe there are
systems which have been synthesised with 3), but are currently limited
to 1) due to the driver. If you don't differentiate between 2 and 3,
such systems are going to swap to 2) and regress.

	Andrew

