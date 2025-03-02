Return-Path: <netdev+bounces-171005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379AEA4B18D
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 13:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467FD164BCE
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 12:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0191E285A;
	Sun,  2 Mar 2025 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJo7TUP8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF051DDA1E
	for <netdev@vger.kernel.org>; Sun,  2 Mar 2025 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740918216; cv=none; b=Y3QHO3xuVbvfN/OwN/pMwvrCz9+3oiqdcTAEgXqTROEkqqhqC9UjbWjz+Nr4HmZtodcnd22DvB7p+WdkvNgIdWDCaoypbYo2fW+OKjuG5SWOtaH6WHfbO2/skjdd7EtFcdZgA++9rOXwK56CqJ8Tx04bm+HjFcr/7y4Jx4sWaWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740918216; c=relaxed/simple;
	bh=wXMy6xTWhVWz2cPJcJU3axWhtUuIpK45W2OTXMVoXpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZS78lwZIh7P4gEOmtDdhcI3tZf6D39xfGp2diM4u+qv0QXpNTepWHkD4Hh9PESh1qzS5ELJx2BUzqejnbUgf22zUdjOy29IMqxqw23zeKcXCW45kTP17Fy8aqOn9dD9IuPuM0va/FkDXgducpItobbBgjP6Y2zskvMmzGvINayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJo7TUP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7BEC4CEE5;
	Sun,  2 Mar 2025 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740918215;
	bh=wXMy6xTWhVWz2cPJcJU3axWhtUuIpK45W2OTXMVoXpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJo7TUP8FZSSLDFkHrY46ffqMzwMnBRum3kpH05Ab8DedNpJu6L8gcW4UpSRwetNw
	 YToX/m0p5QaH1gEdI9/9VAYHIWchlLelPh5ERPWlLVEkLrPlpRDpB+I5/xBvVWe0n6
	 Cu1+6fL6relVsLtZ3xgYma7TtM1IfzkpMTHYjjdrs6V6witpWZZGVMBssWVa7LUMfE
	 aAO+shyqYf+HUjrlKIdueSPUyzUIn5Kyg2EoLkd9cXhR8ZUuL2aCBgR0bFXop8hnxg
	 6P87dUa1DKHBMfo9hNsUX8zFS2gzjZIflKmayx4ZVayZF6Ii1bg+cpAvkSa0/k8TnD
	 ebR6wq0eUSqRQ==
Date: Sun, 2 Mar 2025 14:23:31 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	weihg@yunsilicon.com, wanry@yunsilicon.com, jacky@yunsilicon.com,
	horms@kernel.org, parthiban.veerasooran@microchip.com,
	masahiroy@kernel.org
Subject: Re: [PATCH net-next v7 07/14] xsc: Init auxiliary device
Message-ID: <20250302122331.GC1539246@unreal>
References: <20250228154122.216053-1-tianx@yunsilicon.com>
 <20250228154137.216053-8-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228154137.216053-8-tianx@yunsilicon.com>

On Fri, Feb 28, 2025 at 11:41:38PM +0800, Xin Tian wrote:
> Our device supports both Ethernet and RDMA functionalities, and
> leveraging the auxiliary bus perfectly addresses our needs for
> managing these distinct features. This patch utilizes auxiliary
> device to handle the Ethernet functionality, while defining
> xsc_adev_list to reserve expansion space for future RDMA
> capabilities.
> 
> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> ---
>  .../ethernet/yunsilicon/xsc/common/xsc_core.h |  14 +++
>  .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
>  .../net/ethernet/yunsilicon/xsc/pci/adev.c    | 115 ++++++++++++++++++
>  .../net/ethernet/yunsilicon/xsc/pci/adev.h    |  14 +++
>  .../net/ethernet/yunsilicon/xsc/pci/main.c    |  10 ++
>  5 files changed, 155 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
>  create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.h
> 

The auxiliary device split logic looks right to me.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

