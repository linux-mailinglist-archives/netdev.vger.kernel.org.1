Return-Path: <netdev+bounces-215084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84942B2D158
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 03:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F112A475F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 01:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06B11C1F05;
	Wed, 20 Aug 2025 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/AKtw8R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4A71BFE00;
	Wed, 20 Aug 2025 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755652929; cv=none; b=Ow3Lptj4lUujscvDfWYMF11S1ofj/zgBU3PDqMLRHsOXRZ4KLKBcQNXwj/+pS3Q9nHBsZGmJEL7a9ToeV1DNBdgWkw2hytKX/CX0vK7hxykSThdLDuLk/nh3vX0rhrx1QQ6GgStjev4g8rNWd45gWg5sCQ3MLFuE7rbTdAf5DCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755652929; c=relaxed/simple;
	bh=giJrwNr4gTNI+BHt14QArf7z8KvI8kFYYAqwhT6nAzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hFaQvIoHewMK84SD5UUuMkGY7lbiBAe2gsB1ro3Fr3IiXCZAURQ13yveHZQ5jjy4k0LsIsC+YGc3fDTgW5qsvH+827az/iTQ9eCwEloRTl7GCWTCn6gverR3PalLg5F8oVzhOuN7st9vVo/3trHa0ftYTWWpYeaA+mCIbN0bGFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/AKtw8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB17FC113CF;
	Wed, 20 Aug 2025 01:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755652929;
	bh=giJrwNr4gTNI+BHt14QArf7z8KvI8kFYYAqwhT6nAzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H/AKtw8RMqpy1JosLZEooNgULsO4wBZsWKirV3sTpu1SUB2bXcRfWL680obJWgZL2
	 AyX7yUuQmp9vkp8MoF7VGXbza+fcDlaEm5p3EZovW9zmudPrjyGHouiATXHPu+gzu0
	 e0fpta8hr+QKHjiGrwIuvKMFZVktAABjw1hXwGIXXaG1hQSTdfUfTTHd0EXKD1hvB/
	 q/DbOERoiBF3qlZMa/h3Cg11HLD7szlcYO8lHJ+bihAfzFQWVVjlIIfxMmJqMknj0e
	 BiuD7Ffl90P1nV82+pNwmGSinDFwuMfrPbwchulcA9nyCKIFPiUQMdVKrqYeWQyN8s
	 1ZEURTQMJupow==
Date: Tue, 19 Aug 2025 18:22:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rohan G Thomas via B4 Relay
 <devnull+rohan.g.thomas.altera.com@kernel.org>
Cc: rohan.g.thomas@altera.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Serge Semin
 <fancer.lancer@gmail.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>, Ong Boon Leong
 <boon.leong.ong@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Matthew
 Gerlach <matthew.gerlach@altera.com>
Subject: Re: [PATCH net-next v2 3/3] net: stmmac: Set CIC bit only for TX
 queues with COE
Message-ID: <20250819182207.5d7b2faa@kernel.org>
In-Reply-To: <20250816-xgmac-minor-fixes-v2-3-699552cf8a7f@altera.com>
References: <20250816-xgmac-minor-fixes-v2-0-699552cf8a7f@altera.com>
	<20250816-xgmac-minor-fixes-v2-3-699552cf8a7f@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Aug 2025 00:55:25 +0800 Rohan G Thomas via B4 Relay wrote:
> +	bool csum = !priv->plat->tx_queues_cfg[queue].coe_unsupported;

Hopefully the slight pointer chasing here doesn't impact performance?
XDP itself doesn't support checksum so perhaps we could always pass
false?

