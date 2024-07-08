Return-Path: <netdev+bounces-109932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF7392A4F7
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA042B226A2
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AC513E3F6;
	Mon,  8 Jul 2024 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgVOK1Pa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84513DDAC;
	Mon,  8 Jul 2024 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449879; cv=none; b=mLTAug6RUqSYlE6Z5RbgTIjgG5IGogyWo13lvaw3qjaUnrCbEyD6dh72Puguc3zGxYGnEW5ga8GR1Z32Tp8GVW+GpGDxjSqVrPhqEQd0+swRNm3RVV8LsZ5+MXokxhXCyjIuriOGjNwFe3/jtn8Zo9CAcJrIKE/V+2h0b03t5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449879; c=relaxed/simple;
	bh=XOlkof7heUnyINqmNnRU1NkGO2/QrognmlUxLHzJxxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HE4cvdP5JgRC5A1HW6WK57mCqNZAQA2cOn4yeT/scwRdBMPrbjbEMCAdRJ/u7+jABoa5C5kLipz6RgSoD7g/aqbmzIOKdHFLrIne00/Io3r49y0PnToLHBo8VdEAmoMh2UfTtDSFFyAyWdmygkAUCpCTQsLR8CgiLDM1QwpYk+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgVOK1Pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D20C4AF0C;
	Mon,  8 Jul 2024 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720449879;
	bh=XOlkof7heUnyINqmNnRU1NkGO2/QrognmlUxLHzJxxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mgVOK1PaoG2+z5fHjbpQCgjbgXDapnKot4qp1Ol8fk83NoRQSblAvhGWpLebd7doa
	 cTP+xvUle8d1sugEXAqIuHZcB+rHUGG6vynie3vHsnmM69LZjPB1deOvEjqFhXRdQS
	 21ZNXf1aIE+qlXrG+1zwh/YndRa2Jn2WJ0fe9SkgQJEQpI1ra7RF90jQoTfFCVLp6k
	 KbMYCsFOKi97JTR0uatjDYb29zLiR6XmbpPZVCzb8ucOrYg3uAX0iPEsNGF2hLg8sk
	 txKlvK2edCIljuKCJg+FL/QEGqyq1Q8TzDmNDROcG8pRrzK2SqNfvNq4Mk5NNawwVV
	 MEVJH8Vea9NZQ==
Date: Mon, 8 Jul 2024 08:44:37 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kamil =?iso-8859-1?Q?Hor=E1k?= <kamilh@axis.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, edumazet@google.com,
	devicetree@vger.kernel.org, davem@davemloft.net,
	conor+dt@kernel.org, netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com, hkallweit1@gmail.com,
	kuba@kernel.org, florian.fainelli@broadcom.com, krzk+dt@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 3/4] dt-bindings: ethernet-phy: add optional brr-mode
 flag
Message-ID: <172044987681.3165374.12381204340909635857.robh@kernel.org>
References: <20240708102716.1246571-1-kamilh@axis.com>
 <20240708102716.1246571-4-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708102716.1246571-4-kamilh@axis.com>


On Mon, 08 Jul 2024 12:27:15 +0200, Kamil Horák (2N) wrote:
> There is a group of PHY chips supporting BroadR-Reach link modes in
> a manner allowing for more or less identical register usage as standard
> Clause 22 PHY.
> These chips support standard Ethernet link modes as well, however, the
> circuitry is mutually exclusive and cannot be auto-detected.
> The link modes in question are 100Base-T1 as defined in IEEE802.3bw,
> based on Broadcom's 1BR-100 link mode, and newly defined 10Base-T1BRR
> (1BR-10 in Broadcom documents).
> 
> Add optional brr-mode flag to switch the PHY to BroadR-Reach mode.
> 
> Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


