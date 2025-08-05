Return-Path: <netdev+bounces-211825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB48CB1BCE2
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 00:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BD116E89C
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 22:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF429B77C;
	Tue,  5 Aug 2025 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX+wdZPA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B591173;
	Tue,  5 Aug 2025 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754434745; cv=none; b=uDjYeFHp0O8XlN9dw9LQc4khNS4UObrrj4f3mrzPOnB6qAJyiwk7mJT0hvBfkjbteIkHM1eGu45kus18sqe+r1TTP/dY5itPu+G68qvItXxiO0DS37c0lYf0dtBiMuWjQzXlhmpnB8g2mB3WmLLq6riDFbGVUUoJ7+XXCafx+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754434745; c=relaxed/simple;
	bh=YsBCRG5uQoW4PSOw7lm3ioila+fQ+QnBnLGXvYPYuj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Co8FL9r7mSigsYvveUgJc/YcUGo7UVofL0z1qcNH7nNvfBH3R/r5FavsjGQam3/yZZEiVCGR2AXFSjpfvcgqXik1kwTIy/Fz+A92hSq/e4pZ9IVE57FORX/gvOD2DowMxmUO6MmiLwZEJ4526nPJUIxdxZX5PgrfZ8BuTRp0eBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX+wdZPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E818C4CEF0;
	Tue,  5 Aug 2025 22:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754434745;
	bh=YsBCRG5uQoW4PSOw7lm3ioila+fQ+QnBnLGXvYPYuj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lX+wdZPAHzyvDCekNwwduz+y3WTBUq0W19HSPLLco3rAVcsOgor06/xr5a0g2oCIc
	 Kva8wWErtACJYVaDzUaXCUer34DzQCMi2kOEDpepJ92apM+DUgtK1t/FG9nxr0pZYg
	 izMX1OENOeJIXCpCcmO42VYoPhjkKv9EvM0ZzaxvW6vOOaCAwRA3j7qGu4JTNevCv4
	 W2DXb3mS5344v2vdoOyBUSVYqxojkBKrewVqKY+lam43HF/fJZ1zNsN9L0z0nlHfI1
	 gcmjJ2JWvggFUu73frXbQ8diAeT7eF9yDbEujHkKGQkfniDq2xxeHoXkeOyNdLcFOw
	 jIMJs8GVEpeJw==
Date: Tue, 5 Aug 2025 15:59:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Piotr Kubik <piotr.kubik@adtran.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Kory Maincent
 <kory.maincent@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 0/2] Add Si3474 PSE controller driver
Message-ID: <20250805155903.736ef6b1@kernel.org>
In-Reply-To: <89e056f0-f5c2-48e0-a8c3-458bce3f0afa@adtran.com>
References: <89e056f0-f5c2-48e0-a8c3-458bce3f0afa@adtran.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Aug 2025 15:07:09 +0000 Piotr Kubik wrote:
> These patch series provide support for Skyworks Si3474 I2C Power
> Sourcing Equipment controller.
> 
> Based on the TPS23881 driver code.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v6.17,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

