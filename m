Return-Path: <netdev+bounces-172803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8006A561C5
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 08:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B097A93CE
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 07:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252C01A3177;
	Fri,  7 Mar 2025 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWklyrBs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46F01A314C;
	Fri,  7 Mar 2025 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741332546; cv=none; b=VNJ0At+WCPaFsM178TRo34ly3xggmjBG8SmNGsH6Wnjv4wmueY64LZOs35BIn2GYdZC6PQt403z6b7S/yB3rV+xJPm8ldSBzVH8SQnzP95oXvZOOeuKvCjh4ojEDXj10GFPrapq5UJCa3FB4guFaI0DH4lhZA1L8P/KXi/UKICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741332546; c=relaxed/simple;
	bh=2QV4HyitRVqMFXPW4Hi7wniqOCXjn7Z/b1mVwIcEbs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htA5eIuUMF7F9V/gcSPf83nPychhWe3GaMMbNQ3HMHfQrJNdEnbE1qd3i/OH99xMH9rUXoHJi9ntlh4vG4VyIiAs6GQGydV6tcHsTmFUahUkg1bKRHJVpXG2+1x/pPDazJFzeaUtCcFAfQPS/LFwK8HXj15O2Sa55dR24mTpBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWklyrBs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C8DC4CED1;
	Fri,  7 Mar 2025 07:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741332545;
	bh=2QV4HyitRVqMFXPW4Hi7wniqOCXjn7Z/b1mVwIcEbs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WWklyrBsCLgsFwE4UpYcmgzEcle2ZjJQEOQhpnkw5nX0m//baSpQhvwAlVWxTum4d
	 vAQ8gJ8WV3oNddWIKGgM5ZocxhTUnnzawLDhUJGSTzDfPQVr2eSljSGBw6TQk2Ss7p
	 PIx1D0w249ZsHFvtVVIq/qVcCbQawwBToLy+l4DPZIaWCJ3i3X3xufgoQ5sxxA/ZuE
	 YFoy+wE6ZV9y40CTDBA/JWdaWO2QnhUrqiMKUv8d5WF6OubfcChH/LsZCykOoAalZF
	 VVnDCjcl1pEI12NF/r+xd2+1DSQpp8lwNPFG8nWpjNIozwRuRQxP0x9YmjQXF+LwDS
	 oyw6Iw+1tATmQ==
Date: Fri, 7 Mar 2025 08:29:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Guangjie Song <guangjie.song@mediatek.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Richard Cochran <richardcochran@gmail.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 06/26] dt-bindings: clock: mediatek: Add new MT8196 clock
Message-ID: <20250307-mindful-raspberry-cow-c112ce@krzk-bin>
References: <20250307032942.10447-1-guangjie.song@mediatek.com>
 <20250307032942.10447-7-guangjie.song@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307032942.10447-7-guangjie.song@mediatek.com>

On Fri, Mar 07, 2025 at 11:27:02AM +0800, Guangjie Song wrote:
> Add the new binding documentation for system clock and functional clock
> on Mediatek MT8196.
> 
> Signed-off-by: Guangjie Song <guangjie.song@mediatek.com>
> ---
>  .../bindings/clock/mediatek,mt8196-clock.yaml |   66 +
>  .../clock/mediatek,mt8196-sys-clock.yaml      |   63 +
>  include/dt-bindings/clock/mt8196-clk.h        | 1503 +++++++++++++++++

Filename matching binding, so mediatek,mt8196-clock.h

I would not even dream about people testing patches before sending
them...

Best regards,
Krzysztof


