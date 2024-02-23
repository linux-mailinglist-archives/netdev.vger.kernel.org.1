Return-Path: <netdev+bounces-74210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D8D860759
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 01:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D151F21D3D
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 00:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99158197;
	Fri, 23 Feb 2024 00:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZK5xOgy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708E518E;
	Fri, 23 Feb 2024 00:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708646487; cv=none; b=fmmjjUUNIR/4NsWOWXrubDJ1drcWr9RefRpYIBjvPAlNzBkwzC8HVQrMKAEQoR7bBYWACX4MN61RwyOrJE5bLewsxvLLjs8f5Q2R4Re6IwWrmRpKGrhG+G4RI/JI/kD231fxI5dB7KeXqIlNF7wZT3a6RlI+55PKqoJfFz9wukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708646487; c=relaxed/simple;
	bh=7HpXtVPfbSflmwH8ytnW/f1jUNlThUmTImviciAMV5M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3MlzOsTU5QSvbwHcNAbotzJL60+kk9oImjutBTvEB/lUSC11aEO0npoTLSAk8oza0xv5x28Fcu92PCp2DGKlc18T/qr4JsAxj3D73hXQcWjcW050j3Nyuxs466FTrLIMxijUviuYNYMoYBL8nuYH+wH7ArxKq7XwFltfGzet0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZK5xOgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39306C433F1;
	Fri, 23 Feb 2024 00:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708646487;
	bh=7HpXtVPfbSflmwH8ytnW/f1jUNlThUmTImviciAMV5M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hZK5xOgyls6kDLO7IZalUnBF9Qa9PPPP4Tq75ElwxQa1zQQh/kvdBt18p/Ka8/rRZ
	 Wz8N5r/AgcuWm7yxVKW7Hmg/2Qk/J69x/gn3Z444XSVEbndYoaCVtWT6SfktFlC53V
	 7vV6M2kLkcPG20Rmp/bghBJ7cIXT0NQW80/Lu96foKPX5unL39tdQHxzseh5Fa4XSo
	 mhkZNKjWMgeXnE6BON3/fKuNjCYGglBhf91tOQ2hKSlqnlUGNc+c/99P+2EV9dYUhq
	 NbI8uYz+nKUg8G/jF13pelA63PUiFUJzSvNUjnK0gediLspZmAXtGwXKXe2s6JBfL2
	 VkWjv9TH0oBSA==
Date: Thu, 22 Feb 2024 16:01:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Chen <justin.chen@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 opendmb@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, rafal@milecki.pl, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 6/6] net: bcmasp: Add support for PHY
 interrupts
Message-ID: <20240222160125.5aae2231@kernel.org>
In-Reply-To: <34ee3b60-3560-4e22-be79-b191e7b9e91d@broadcom.com>
References: <20240222205644.707326-1-justin.chen@broadcom.com>
	<20240222205644.707326-7-justin.chen@broadcom.com>
	<34ee3b60-3560-4e22-be79-b191e7b9e91d@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 13:56:45 -0800 Florian Fainelli wrote:
> > +		if (intf->internal_phy)
> > +			dev->phydev->irq = PHY_MAC_INTERRUPT;  
> 
> There will be a trivial conflict here due to 
> 5b76d928f8b779a1b19c5842e7cabee4cbb610c3 ("net: bcmasp: Indicate MAC is 
> in charge of PHY PM")

FWIW the trees have now converged so the series no longer applies.
Please rebase & resend.

