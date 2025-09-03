Return-Path: <netdev+bounces-219703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9C8B42B34
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C2B16A085
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 20:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE423054FC;
	Wed,  3 Sep 2025 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvJVPQ+H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27F2D46CB;
	Wed,  3 Sep 2025 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932214; cv=none; b=iqPfSNLtrm6UCkvKtIh9ue+WO3CNz3dsfEGiBF1bIPM5BbNxBnY3ewFgS6hWquiEiBgSJET81zHvitmwHXRhQZ53llpozen0nBfdGszc6DTEbEtUYFLI0G0monJyInCYGZG/i8IWp8Ata+tl1kz2C0kjyq8W1M5Huw2dXfzjsDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932214; c=relaxed/simple;
	bh=ZrWBzTUTC9WAJnOWtFKBqgBmqR3PSN/MgEY8CcIWquE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ro7E/cFYbwmAM/QSEC/mnqfzPfbG6TcU9TdJ+usU8kv/2tI4/6Bi2a4cF+16L126t6DkxaMwXRzIo8fpGCNCQZudtYKdkDMnEhDf1AvbG6AJ1OzxmdcXN0PxZzKzxkZzwX0KNxf7Hz11fMaPmrWOlE4zzi1MAV/ehuzneR/FYo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvJVPQ+H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5E0C4CEE7;
	Wed,  3 Sep 2025 20:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932214;
	bh=ZrWBzTUTC9WAJnOWtFKBqgBmqR3PSN/MgEY8CcIWquE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TvJVPQ+HQ/rwtKiosl4LwntAXSfNwkXfqX1dGopbUp7W1REtiKer5OaqMuzAD15WM
	 QN0Whv2F9y9QSIQwGBaVFwmOLhhw3+5C2x2uvdVSgxmfLbojk7hG1fB2DLdPXQsN8r
	 VoAB2qJO2XXzWHHtzH6mf3+Jp6Vxu57TCED4bQZgLqnBQiVVhu4jazenSk7SxNENrx
	 oybCGHLnpntuWEvbT/MTJj5CHsuU0hzYfvhjHKAHBTsqAPfZ+wbKcYvfQiiTnhGlma
	 xGFKUP7XKMy9btc04i0W7N1+Ee7kOdmn7RCU6sq4w8FYuZQHdnYE0X0WrmzMmu7aLs
	 quW5rmAQThpxw==
Date: Wed, 3 Sep 2025 15:43:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Conley Lee <conleylee@foxmail.com>
Cc: linux-sunxi@lists.linux.dev, edumazet@google.com,
	linux-kernel@vger.kernel.org, mripard@kernel.org,
	devicetree@vger.kernel.org, andrew+netdev@lunn.ch,
	netdev@vger.kernel.org, wens@csie.org, davem@davemloft.net,
	kuba@kernel.org
Subject: Re: [PATCH] dt-bindings: net: sun4i-emac: add dma support
Message-ID: <175693221068.2743688.18419126286062022173.robh@kernel.org>
References: <tencent_4E434174E9D516431365413D1B8047C6BB06@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4E434174E9D516431365413D1B8047C6BB06@qq.com>


On Wed, 03 Sep 2025 16:22:38 +0800, Conley Lee wrote:
> The sun4i EMAC supports DMA for data transmission,
> so it is necessary to add DMA options to the device tree bindings.
> 
> Signed-off-by: Conley Lee <conleylee@foxmail.com>
> ---
>  .../bindings/net/allwinner,sun4i-a10-emac.yaml           | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


