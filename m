Return-Path: <netdev+bounces-125127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDB296BF87
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00FAFB21FCA
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B201D935E;
	Wed,  4 Sep 2024 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fz/DfScd"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B136A1EBFF7;
	Wed,  4 Sep 2024 14:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458611; cv=none; b=LBCJBxKO5KJXKb4fQEH06GFGY6ImCecH1/io1E2eGrsoJrVNY3/eQ/RMvVvqvA6AHS9fvyUM8/DmayfYaqL8fQKm/xCHPww6ausZAMsNl2Cyq/oelyjNdjHoHIgUICIXbebVpuenb5QDIXZ3xelnZadniITc/ThSSKKW7WVwdb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458611; c=relaxed/simple;
	bh=1ekO9YCEhIpPrY0sQ/GPP+oJ+n2HUSBdjdYlqbxTPtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uy6lXzBpj5H3X1Ck8/jAFfo+7XW40wVZSGpTqwWsDcbn3r52bRt9yM6inZUdb+Kf2zIr8wktB1avQkkCGNqV6Q+Sn0bhTDqjZdvBRaiQT/NPTVlAI5s6evtAQ5Wev3u5sS5Ka9o1h0l7FGrMyYuBEPUavcpaod9DdP3Af5tPq6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fz/DfScd; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DTKNpaDl7/InA7kL56zxwEAKPoUkAAboRbpUNBIP10A=; b=fz/DfScdqVFh7gcANxtSqUq8WR
	KGjaMydaTHCmIiDCRmDqCYqsFDuIOlFUTaj2NuudEEk+7uXGUqddwl2Qm65lFAqY8z2xpKhq92KCX
	eYFAwAe2F7qVccMey52vrSjDXI56XFep1ruDZv0H6XctD5daCoTD6+oIfEpubkbH0+3g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1slqb7-006Z8K-Qd; Wed, 04 Sep 2024 16:03:01 +0200
Date: Wed, 4 Sep 2024 16:03:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	netdev@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 12/15] iopoll/regmap/phy/snd: Fix comment referencing
 outdated timer documentation
Message-ID: <a269cf5e-2ba0-40c3-a7f2-9afa0e8c6926@lunn.ch>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
 <20240904-devel-anna-maria-b4-timers-flseep-v1-12-e98760256370@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-12-e98760256370@linutronix.de>

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 6b7d40d49129..b09490e08365 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1374,11 +1374,12 @@ int phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum);
>   * @regnum: The register on the MMD to read
>   * @val: Variable to read the register into
>   * @cond: Break condition (usually involving @val)
> - * @sleep_us: Maximum time to sleep between reads in us (0
> - *            tight-loops).  Should be less than ~20ms since usleep_range
> - *            is used (see Documentation/timers/timers-howto.rst).
> + * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops). Please
> + *            read usleep_range() function description for details and
> + *            limitations.
>   * @timeout_us: Timeout in us, 0 means never timeout
>   * @sleep_before_read: if it is true, sleep @sleep_us before read.
> + *
>   * Returns 0 on success and -ETIMEDOUT upon a timeout. In either

I know it is not in scope for what you are trying to fix, but there
should be a : after Returns

* Returns: 0 on success and -ETIMEDOUT upon a timeout. In either

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

