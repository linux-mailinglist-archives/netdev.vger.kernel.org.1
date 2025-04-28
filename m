Return-Path: <netdev+bounces-186349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF75A9E931
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 09:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5B33B8393
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 07:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732461DDC2B;
	Mon, 28 Apr 2025 07:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t94DEvDU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4069F1DB34B;
	Mon, 28 Apr 2025 07:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745824982; cv=none; b=TkTibaQfPQ7PESXTT8Td7EIrwrhJOUBAEViUvfV+ZSXyj0GT8XRIMIUHYIgOw9twgmwUvu2mtK5o4vouDjgxKrXp1cagynxvcvTF63Xbfq95UG3e3mdZRBmZOQh19wQi/C1ZqmfnczD9ANCfDSOQ1vYzxBddDBRCQFSiaAMHkIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745824982; c=relaxed/simple;
	bh=qP/8wVu9kz7JxXZ42YE7w0X2oBw+B6PGhKfko70XC1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lY5vXv91b9kpFK3/sM+TZelj03xGYaB0soDCP08HufA1uKV5A/ChW+9xG7doh82Xq73mqejtKujdQ7T0kHAVREWo/qeYgjxsFLLVinotrqrYrWR3SlDiy+wdI/Bp840K3myoFRpzf7o9KNIBIxn7Ghoc3pHcHcaEv8hhjMywCmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t94DEvDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC7BC4CEE4;
	Mon, 28 Apr 2025 07:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745824981;
	bh=qP/8wVu9kz7JxXZ42YE7w0X2oBw+B6PGhKfko70XC1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t94DEvDU03gDddW43clwxceIcPAB2+GzF2WaZICJGfgbmDrd1Ns4viVu7ZniKI/Zv
	 dJG6PV3+RmBkV2AGzDsqvuC6UQEpvebsYRWW1JSYJgwj1/ia+GJ7Zc+znQtbp67iYa
	 4eN68nGvHpFr4MUEkGV3Q5zqBkCx1IUfYohtQoRZtHvK47qxLtGRVH0G1NuZOpTsuC
	 1yrR/OZ57JtDnLBuTPskbe45xdaN4UkaqYgYkwkBZWAYM8jaIurkvZDBx4ztRe7cWQ
	 HsDGJqKihvuGc8p+wk32Q/L9HpXztpak8KSDED4aw6D6VxPG9AipDCwWBWqqZrQrLN
	 mO6hqAQMGF+VQ==
Date: Mon, 28 Apr 2025 09:22:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Maxime Ripard <mripard@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andre Przywara <andre.przywara@arm.com>, Corentin Labbe <clabbe.montjoie@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: sunxi: Add A523 EMAC0 compatible
Message-ID: <20250428-prehistoric-fragrant-bear-163afa@kuoka>
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
 <20250424-01-sun55i-emac0-v2-2-833f04d23e1d@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424-01-sun55i-emac0-v2-2-833f04d23e1d@gentoo.org>

On Thu, Apr 24, 2025 at 06:08:40PM GMT, Yixun Lan wrote:
> Allwinner A523 SoC variant (A527/T527) contains an "EMAC0" Ethernet
> MAC compatible to the A64 version.
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml | 1 +

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


