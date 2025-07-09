Return-Path: <netdev+bounces-205296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A87AFE192
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 09:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCB33B704A
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 07:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7EB22154D;
	Wed,  9 Jul 2025 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q39oaTT7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707CB1E0E0B;
	Wed,  9 Jul 2025 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752047178; cv=none; b=PGNlj/tUtoF/nLH+JY6yaMbVEmwvfEc7yfe+kq3kaZRh3cf+AGPdr83+UDlhcW2Nx661gVUeLCbGBK/lXG0vda82nSW2DWaK2pgjfHgVFerrsHrek0nctz9dOizyJZxz+BP41/c9QKTiXdl2I4VGW2hjOo/zRQ8U1ZE2v5f8C7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752047178; c=relaxed/simple;
	bh=Wwooc6QvI3kYRhEkAEkhHkOtrspGXOlhQ25M+ckDh6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNAURI8QYY5ngXuhvDaTaqgaWM1IKZ5/UDtHoRta+g8n+oY9MbDejvyb/gpgb2jrr/2QI758PCkrzU0/SdZLfiQ0f2OzwQEoAmCWdaf8I5wMqKIFU9DyhY9OiFEKHdQt/x3ZeOaXsrPbkGn/v+dAk2amDJevcGzNS4mU+/krP4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q39oaTT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B652AC4CEF1;
	Wed,  9 Jul 2025 07:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752047178;
	bh=Wwooc6QvI3kYRhEkAEkhHkOtrspGXOlhQ25M+ckDh6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q39oaTT7JgmUspVLiFLnfUlaaB++PVEVePT5m2vVkkxes5HC4AjSnH30DyNAhn+F+
	 KF8uoSwT2ve62Rwl7HPcULJmMQM9Y0y6MSw0EAWE1aa3/XyApqvQNlaoe7Fsgqj6W0
	 hllNHbLHaSD229VQ5LW+5Maxddp4pAOpmIzWUHGqE5tMm8mZCtwxriCwRmVOrulx1e
	 P5MZJOpDla8VM5U4qfeJtbH6mCob0YljtHCKLLVbLQ3qIKd/z/O0FvGH4Gx/PtI707
	 gaNqzHnTMNEbBom9LXZJH8c5JlnD69aVb0mYhl3SFWPRpRtKv9GRABXpv4l9AoaWAK
	 V/TGZSWy/x12g==
Date: Wed, 9 Jul 2025 09:46:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de, horms@kernel.org, 
	jacob.e.keller@intel.com, u.kleine-koenig@baylibre.com, hkallweit1@gmail.com, 
	BMC-SW@aspeedtech.com
Subject: Re: [net-next v4 1/4] dt-bindings: net: ftgmac100: Add resets
 property
Message-ID: <20250709-simple-blue-chinchilla-164051@krzk-bin>
References: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
 <20250709070809.2560688-2-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709070809.2560688-2-jacky_chou@aspeedtech.com>

On Wed, Jul 09, 2025 at 03:08:06PM +0800, Jacky Chou wrote:
> In Aspeed AST2600 design, the MAC internal delay on MAC register cannot
> fully reset the RMII interfaces, it may cause the RMII incompletely.
> Therefore, we need to add resets property to do SoC-level reset line to
> reset the whole MAC function that includes ftgmac, RGMII and RMII.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml       | 21 ++++++++++++++++---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


