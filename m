Return-Path: <netdev+bounces-140138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0509B556B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82D92845F4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2370020ADE7;
	Tue, 29 Oct 2024 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKvwbwPD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4803206E92;
	Tue, 29 Oct 2024 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239140; cv=none; b=SHg8tdxBXwcNET6oklo77DhcdXqAZhP134KPPmGYLJaF+GfF/xL9BRZWAmg9PLqlb8CsH3+96rp8IfYTLnY+V9d5RNhjB+CMXoATN3ZB/Zpp5n79HhWGd4KoBwQbOp0V19MPq/dCCTntO45AhAAkspP4OciA+OKKZYbjQLDf91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239140; c=relaxed/simple;
	bh=UbpQzkUTWm45exTpBQeEuDpUh3FZIWDnpsfqppEizFY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLD/K9SfT4YNrFzpOjA9b1SUQvGvUmtQS4IBYqiAHgwZ0jj2UYSvmTRfG9HcXuwJ9dH3JvIm0QPSyXr3FN58GxezQAOEthrm1Is1A4Zt+B7DC298VqBx/bqJ/6o2akMp1/N8tG5wdSISpnimuWjYdSrybaiWC8UXPo6JNAdopNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKvwbwPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4230C4CECD;
	Tue, 29 Oct 2024 21:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730239139;
	bh=UbpQzkUTWm45exTpBQeEuDpUh3FZIWDnpsfqppEizFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fKvwbwPDX1QEZAkInxmLMERwCC9dXfCjlxRKFKad97pu5hmalG/XidGR6iXzoIonN
	 1dnlJ+TvmYvcumjcmunMSE1nxbVVFyEAdXZilfpnVBYcT9feDz9dCRQ0JcS2Zyulz8
	 WY2yxYtS3Tz4f+EpHAErjsP/y1LR/daXhP+jqZ48PlTUhwgR6bP3pb0IsiYHV27y0y
	 7UXHQH3pl4p3+qU8eVhQdbSQN1+cU6ScSZpbnXjPaE9J0zSBjDeMXLF+dZscPMphnt
	 ZlH3tuTLB5qhRH1W8FfyXv97pl08Y36R8woemgaQYSKFfypi2pbN8H101Kwq5G/aYd
	 AE/hnF+IFwtbg==
Date: Tue, 29 Oct 2024 14:58:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, a.fatoum@pengutronix.de,
 conor+dt@kernel.org, dinguyen@kernel.org, marex@denx.de,
 s.trumtrar@pengutronix.de, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/23] dt-bindings: net: snps,dwmac: add support for
 Arria10
Message-ID: <20241029145857.29a4f360@kernel.org>
In-Reply-To: <20241029202349.69442-13-l.rubusch@gmail.com>
References: <20241029202349.69442-1-l.rubusch@gmail.com>
	<20241029202349.69442-13-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 20:23:38 +0000 Lothar Rubusch wrote:
> The hard processor system (HPS) on the Intel/Altera Arria10 provides
> three Ethernet Media Access Controller (EMAC) peripherals. Each EMAC
> can be used to transmit and receive data at 10/100/1000 Mbps over
> ethernet connections in compliance with the IEEE 802.3 specification.
> The EMACs on the Arria10 are instances of the Synopsis DesignWare
> Universal 10/100/1000 Ethernet MAC, version 3.72a.
> 
> Support the Synopsis DesignWare version 3.72a, which is used in Intel's
> Arria10 SoC, since it was missing.

Please split out patches 11 and 12 as a separate series.

