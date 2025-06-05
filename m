Return-Path: <netdev+bounces-195260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4171ACF192
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 16:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EA6164A04
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 14:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97136272E50;
	Thu,  5 Jun 2025 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQP5nU+k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DD51F956;
	Thu,  5 Jun 2025 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132763; cv=none; b=N/CBO+1QalvdQBuNT0EYlfxh+uIHZ5aWYyZW1/oAMAyc64pDZRD+d1AUikDwSU8foLZIaZUeaqO758B0AP0V1aF4w/OFo32mfHC3gqbZoMKIMcKAHTKa50KdBOg5r7q09kJ42EvwRmFdR/c567FuZ0ZWyJG2k55Nswglo1BAMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132763; c=relaxed/simple;
	bh=H84nLkI3ISIc0XZxOb82bQ47deaFwc09tK9XpfuXpoE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaQ1gmuRV818SxXkndNfAAn1UWsOkmimPxFs4/wJj4DnrLBApSEFd+rm4tPk9HvlFmXFKTrux5md2xWfYAjrAbeWVNszJ3NnFj+4oXM9To8t8Qj8bvFDwOl7iKXT4sAt0uzuNvY7pWfE3vmz4hGGFierKf2/ClcNXCiHPssCG88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQP5nU+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D653BC4CEE7;
	Thu,  5 Jun 2025 14:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749132761;
	bh=H84nLkI3ISIc0XZxOb82bQ47deaFwc09tK9XpfuXpoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mQP5nU+k5wknXL42DeCVSwgqclJwF6QQTDEopazgpCVt+hNmNOatPq2mNu5ws0ao8
	 fygyVWFQw8KoAwpPAoafke3rJbZHbqWcqubQlfN0LYbCrvYl6hbYZTP3OPEJJTFfMR
	 aHSTqBhhGlRJWYhZAq2ZchIH/ozI8zlYmDW2AFg8aN+p/ksp+4n4ttHpv3aw/xUKzR
	 k2kpQHdYwZbrB2AakLVZYJH3mylXJkhk1fFGQCYdagZ2a0B9YepamAOt+hW1W8+4xT
	 u+h6NC9dPyvb7ZTxBa1XCNUk70Ic9CY70hcOZAf4s2apqwiz1Jwd6WEi5frkXV7yZw
	 L3fr1IPXpptTA==
Date: Thu, 5 Jun 2025 07:12:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 corbet@lwn.net, danielwinkler@google.com, davem@davemloft.net,
 edumazet@google.com, haijun.liu@mediatek.com, helgaas@kernel.org,
 horms@kernel.org, johannes@sipsolutions.net, korneld@google.com,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 loic.poulain@linaro.org, m.chetan.kumar@linux.intel.com,
 matthias.bgg@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 rafael.wang@fibocom.com, ricardo.martinez@linux.intel.com,
 ryazanov.s.a@gmail.com
Subject: Re: [net-next v1] net: wwan: t7xx: Parameterize data plane RX BAT
 and FAG count
Message-ID: <20250605071240.7133d1a5@kernel.org>
In-Reply-To: <20250520122141.025616c9@kernel.org>
References: <20250514104728.10869-1-jinjian.song@fibocom.com>
	<20250515180858.2568d930@kernel.org>
	<20250516084320.66998caf@kernel.org>
	<20250520122141.025616c9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Jun 2025 17:17:22 +0800 Jinjian Song wrote:
> The parameters are used by data plane to request RX DMA buffers for the entrire lifetime of
> the driver, so it's best to determine them at the driver load time. Adjusting them after the
> driver has been probed could introduce complex issues (e.g., the DMA buffers may already be
> in use for communication when the parameters are changed. While devlink appears to support
> parameter configuration via driver reload and runtime adjustment, both of these occur after
> the driver has been probed, which doesn't seem very friendly to the overall logic.

no.

