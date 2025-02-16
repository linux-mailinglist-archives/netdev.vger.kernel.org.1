Return-Path: <netdev+bounces-166763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2E7A373B4
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 10:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8683ADF60
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 09:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBB018DB03;
	Sun, 16 Feb 2025 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1jIDVnw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBC918C33B
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699961; cv=none; b=nQ/kabQ4uVRg+pZLkwRiCQu4pj6RJX73oUQOMPUhzUMSPhsGLMckupuO40AwpSLz793/D7rK0ryvQnq1rwBRPlbKcBjuAnqU5VQbR7QDuj5BAJF1+nnaf3AAB7HZwSlG6nBE+RYJ+uwZbyOumgEip63MJXL745BvqQOYTZRAIms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699961; c=relaxed/simple;
	bh=JhbqIgw6KVqmKp440CFX6SqHipQonaNeojdpUoI/w+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOYHKpKQXUyoC/YF3B3Jbu96062of301NpBJkKv1/qlbjrSORPYIbmkbAjqlyuO0ruhnaS/RHEjalQIyaCNyxsK5f60vF+JaygPi8gS1ddK0RT/1PM1CMXYuOHuOgUw9OQdR51J9nRhkTQPAl0OvH24n9FaNlQ+TSFu7ifGIhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1jIDVnw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CC7C4CEDD;
	Sun, 16 Feb 2025 09:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739699960;
	bh=JhbqIgw6KVqmKp440CFX6SqHipQonaNeojdpUoI/w+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t1jIDVnwARF2cUh1LGUxBd0Y0qlFvRzfZDyk6YSvuJHlsMtL/ts1+qBpfPSXXLMHa
	 hJqA0+1DMlA+/6ebmSB2GgRA4Tid2BnmsVThLNdojtnA+RByYhTUe7fN7PcCdXVsYW
	 Qke+sQpWjXob17XNii228uv02Aha+7lc4FALfwbWSHYpUUJ2J4HOb93ybPBNZBdnT+
	 p3j4igNk4i2KoIV21uswwQBlTYCsp+1P69ifqK7NiFQir3XxcYOGS1hrxgJglR+z+f
	 cWxksTqbvjtjqawcG10Yfxc+Vlo+LNtQYsiKgBtXZifLr4v0Cfif4osmjsRzBOBV3P
	 BhWAC+8AlLrxQ==
Date: Sun, 16 Feb 2025 11:59:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: tianx <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	weihg@yunsilicon.com, wanry@yunsilicon.com, horms@kernel.org,
	parthiban.veerasooran@microchip.com, masahiroy@kernel.org
Subject: Re: [PATCH v4 07/14] net-next/yunsilicon: Init auxiliary device
Message-ID: <20250216095915.GT17863@unreal>
References: <20250213091402.2067626-1-tianx@yunsilicon.com>
 <20250213091418.2067626-8-tianx@yunsilicon.com>
 <20250213143702.GN17863@unreal>
 <0e83c125-b69e-46a0-a760-fe090b53bc70@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e83c125-b69e-46a0-a760-fe090b53bc70@yunsilicon.com>

On Fri, Feb 14, 2025 at 11:14:45AM +0800, tianx wrote:
> On 2025/2/13 22:37, Leon Romanovsky wrote:
> > On Thu, Feb 13, 2025 at 05:14:19PM +0800, Xin Tian wrote:
> >> Initialize eth auxiliary device when pci probing
> >>
> >> Co-developed-by: Honggang Wei <weihg@yunsilicon.com>
> >> Signed-off-by: Honggang Wei <weihg@yunsilicon.com>
> >> Co-developed-by: Lei Yan <jacky@yunsilicon.com>
> >> Signed-off-by: Lei Yan <jacky@yunsilicon.com>
> >> Signed-off-by: Xin Tian <tianx@yunsilicon.com>
> >> ---
> >>   .../ethernet/yunsilicon/xsc/common/xsc_core.h |  12 ++
> >>   .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   3 +-
> >>   .../net/ethernet/yunsilicon/xsc/pci/adev.c    | 110 ++++++++++++++++++
> >>   .../net/ethernet/yunsilicon/xsc/pci/adev.h    |  14 +++
> >>   .../net/ethernet/yunsilicon/xsc/pci/main.c    |  10 ++
> >>   5 files changed, 148 insertions(+), 1 deletion(-)
> >>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
> >>   create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.h
> > <...>

<...>

> >> +	[XSC_ADEV_IDX_ETH] = XSC_ETH_ADEV_NAME,
> >> +};
> >> +
> >> +static void xsc_release_adev(struct device *dev)
> >> +{
> >> +	/* Doing nothing, but auxiliary bus requires a release function */
> >> +}
> > It is unlikely to be true in driver lifetime model. At least you should
> > free xsc_adev here.
> >
> > Thanks
> 
> Hi Leon, xsc_adev has already been freed after calling 
> auxiliary_device_uninit. If I free it again in the release callback, it 
> will cause a double free.

You should follow standard driver lifetime model. Your
auxiliary_device_uninit() is wrong and shouldn't exist from the
beginning.

Thanks

