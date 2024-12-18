Return-Path: <netdev+bounces-152814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE5B9F5D5B
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDA7188D2FB
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509221474C9;
	Wed, 18 Dec 2024 03:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8PmS1MW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270DC1E487;
	Wed, 18 Dec 2024 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492168; cv=none; b=RMslbsROaccMSEbPSdwap1xLUlN0B/2PpoAgYfl99+nV5LtLrZcCf5g+d2I+BpCCkpa7cX/8drhoN6H15bhLJtQzvqxR5qV7fE//2yP8xIXht2lPOGjaAC3kvvebui/VRz0BiGt9sAjejXDoiDDtVOpxTOthD8SBxgqZUYLNJW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492168; c=relaxed/simple;
	bh=oRalAg49UDoRwrsjhBzRw/8nro4oOvSRV5E++4q3jIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmbiO+qKcpO2QApqrYxZABeOdygkz/hmpR2rz/na6QnAFsrJuDuM/3GhIoa3g6we9FjgI9bBjZNpxN7vpNPHVi94ptgOr31zr2fOZnbHuRwDdW75B7mrz/AVbO6xJLUNKt17xTaFRI72jWQdZjKO3NoiVpbUUDnwOjX6JJv613A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8PmS1MW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F44C4CECE;
	Wed, 18 Dec 2024 03:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734492167;
	bh=oRalAg49UDoRwrsjhBzRw/8nro4oOvSRV5E++4q3jIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r8PmS1MWpm7fA9jGjpXakHBw5nPK7IyhdZFQ154VOCpYDEpwThNQMwUwkYE5jS+BI
	 vdMzMDh1EDE5Ze4kDozi8CGndXxHa+Yy3VOyNzOHZwqTRA+9bPYOyTzmh6LmuRMCQV
	 drHrMGtZrq3NpwWREjEwBM3sIGyDRJjqFE2X3JATlNyB96XxEUIqkc5bZiXXfpKYSY
	 NM/V5HTud/eu7QZpXT3rLegP12Jhum1DQvVRNeHvBJfYV+xPOpVq/8lt9Z9zNHdcJN
	 JuZl5o1G73l5c3U6bDrqkLReWbLDaXYSF3bONDnEVaydxYVoASeOnB/KvsZmPKpZ50
	 0OW097LD02Y4Q==
Date: Tue, 17 Dec 2024 19:22:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
 <linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next v7 2/5] net: phy: microchip_rds_ptp : Add rds
 ptp library for Microchip phys
Message-ID: <20241217192246.47868890@kernel.org>
In-Reply-To: <20241213121403.29687-3-divya.koppera@microchip.com>
References: <20241213121403.29687-1-divya.koppera@microchip.com>
	<20241213121403.29687-3-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 17:44:00 +0530 Divya Koppera wrote:
> +
> +static int mchp_rds_ptp_ts_info(struct mii_timestamper *mii_ts,
> +				struct kernel_ethtool_ts_info *info)
> +{
> +	struct mchp_rds_ptp_clock *clock = container_of(mii_ts,
> +						      struct mchp_rds_ptp_clock,
> +						      mii_ts);
> +
> +	info->phc_index =
> +		clock->ptp_clock ? ptp_clock_index(clock->ptp_clock) : -1;

under what condition can the clock be NULL?

> +	if (info->phc_index == -1)
> +		return 0;

