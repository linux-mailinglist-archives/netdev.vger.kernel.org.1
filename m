Return-Path: <netdev+bounces-12854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A5C73927C
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 00:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BCE2816C7
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 22:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CE51D2CE;
	Wed, 21 Jun 2023 22:24:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FAF1C766
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 22:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB272C433C0;
	Wed, 21 Jun 2023 22:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687386257;
	bh=bYXuZ1J2NcBvckXF0PUlsYtNP6V2bG54LkEEnRX+kf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jLcN6ircnx2eC/6O5Qp0bE77KqYhV+EvHVpUkju/rYlCuAvZvmNRtKS+zbN90Gl/k
	 McuhJEekHqpxPzOIWPlZ5IF+MES4Vth9ZHylAoh8HAs/OvcXqTrHoqHDmSJCLg5HZo
	 a4zZJbyRecAqCLElWc9WUIsGxH5jEsTz/hIzlmdLlKgAW7qT3BVvjA3X2KKab7agDy
	 frnR2BoW/HoVb3/ayFU5RmiDonWFHYYCnOt4fJ7xItOoBaRc0YKYC8HO/GEWCJf6Ag
	 yeUppnOtfdEnenhNu9iFuCiNah9lYW3V2FvNm2rX9eFjkcN9WMq5D+YDangFilOEr8
	 ZtSRjkr3uVPfA==
Date: Wed, 21 Jun 2023 15:24:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>, Simon Horman
 <simon.horman@corigine.com>, Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net-next v1 2/3] net: phy: phy_device: Call into the PHY
 driver to set LED offload
Message-ID: <20230621152415.0bf552f3@kernel.org>
In-Reply-To: <20230619215703.4038619-3-andrew@lunn.ch>
References: <20230619215703.4038619-1-andrew@lunn.ch>
	<20230619215703.4038619-3-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jun 2023 23:57:02 +0200 Andrew Lunn wrote:
> +	/**
> +	 * Can the HW support the given rules. Return 0 if yes,
> +	 * -EOPNOTSUPP if not, or an error code.
> +	 */
> +	int (*led_hw_is_supported)(struct phy_device *dev, u8 index,
> +				   unsigned long rules);
> +	/**
> +	 * Set the HW to control the LED as described by rules.
> +	 */
> +	int (*led_hw_control_set)(struct phy_device *dev, u8 index,
> +				  unsigned long rules);
> +	/**
> +	 * Get the rules used to describe how the HW is currently
> +	 * configure.
> +	 */
> +	int (*led_hw_control_get)(struct phy_device *dev, u8 index,
> +				  unsigned long *rules);

Why not include @led_hw_control_get in the kernel doc?
IIUC the problem is that the value doesn't get rendered when building
documentation correctly, but that should get resolved sooner or later.

OTOH what this patch adds is not valid kdoc at all, and it will never 
be valid, right?

