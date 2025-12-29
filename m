Return-Path: <netdev+bounces-246208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E11CE5DE8
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 04:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 958603016374
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 03:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EAB27AC4C;
	Mon, 29 Dec 2025 03:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYvj2dcf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB68E27603A;
	Mon, 29 Dec 2025 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766978536; cv=none; b=Z7NmlKVZnGCWM+h5SrVF2LRa+sVxi34kP9MhYVolCKeE13otAn6CxsiQ7WGOGl6YUzShTDwUiXKOO1mpCxlzRUv3xfj6q6Zt5Mt0S+7nGq3ijuFl+/TwJiqTcYP+zkjFtRw6UC6EGSGxDAJISPXceXKF92f5CehsYc5BPiKFoqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766978536; c=relaxed/simple;
	bh=iMOwSeRjpeTdmhpbDFTXK3GxNzK21mVjxmWjTae4W0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eW57hHWZ043fNvJrqWGOUJmILxJQh1tXiznjSi4Ko5TJiBeNc3NYTJamvey1/+ubvYEUyV5Iyata/S13DiCeKPGsd2C+qchldJgsBYr0wkQE36AY8E2DV42k6bUfVXFQ38OmpCA3m2gBggn4oVfIOMmCobXKsEwQwgNzQ7u9ZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYvj2dcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA0EC4CEF7;
	Mon, 29 Dec 2025 03:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766978534;
	bh=iMOwSeRjpeTdmhpbDFTXK3GxNzK21mVjxmWjTae4W0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LYvj2dcflad8dWsJ/37E/ZrG96khd1FdNl8iNIrzRLOiduGwWhNL4aLcmb2HN0Jwl
	 PYyJrsQZQh68FzIggoGUeB9E5Nh4QBkQWxY0T9LmQ0hXYvRrsGOCTd50ICrreWyYWW
	 lU2PQ3oI7zuo9i6qRxGfvfJB8n+Og0fXkA/XzhAt34z6Bu4sNfI5V4xpUTQbdkLVtB
	 Nky0fhx+WvAYYGAuiIcVXrUlYCAjARBxmCGX8eRj3jNg7Nzh9txDmOUeDlSg/hElSK
	 e6fhAldWXq/WV8xRfbQly1nC9XnQQduWMi1yzFaKUxh4s6URa/B6m7Mnx0d6r8OVK1
	 19dcYSmTq03tw==
Date: Mon, 29 Dec 2025 11:22:05 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	richardcochran@gmail.com, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: imx943-evk: add ENETC, EMDIO and PTP
 Timer support
Message-ID: <aVHz3aDIptmJ5llD@dragon>
References: <20251116013558.855256-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251116013558.855256-1-wei.fang@nxp.com>

On Sun, Nov 16, 2025 at 09:35:56AM +0800, Wei Fang wrote:
> This series add ENETC, EMDIO and PTP Timer support for the i.MX943-EVK
> board.
> 
> Wei Fang (2):
>   arm64: dts: imx94: add basic NETC related nodes
>   arm64: dts: imx943-evk: add ENETC, EMDIO and PTP Timer support

Applied both, thanks!

