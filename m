Return-Path: <netdev+bounces-150687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEEE9EB2DA
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 15:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D574E283318
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456DF1AAA35;
	Tue, 10 Dec 2024 14:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fh8JLPzu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C751AA1DB
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733839993; cv=none; b=PjF/rqdmLvBFRPFdZTwF/lTp5dqOPnxWXVQPwNYCHxNtpwMStaR7CXc+jAimSQF2blQl+U3X39dVuMxk9uziwe3Z2oiKtftolgirA2CQtcfXf5CcgHp9cmY/Rr2N6e95Q1TwztQeV+DmGT0hU/q8qZUAMSLBcsBt1ZgnSzo+WxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733839993; c=relaxed/simple;
	bh=6j/GjObx+vYqn6uQONyN/W2dugTIFOVihStr7h40tUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRqZsXapMP5w+bsN8u3zhgQVswYv90dibjPphI4rnEdR5lF2/XBd+bkZj9wq4mRz9JsHSajZ7yLlSwohQFONUIp3b0pAekkGw+pVb9b8FUF3YlRzbQ1DNhNAGAed4R3aAzSKNLlRhPtfBWnVI3O/MQFJ1HwJGAe3rUiAmXVviC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fh8JLPzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9295EC4CED6;
	Tue, 10 Dec 2024 14:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733839992;
	bh=6j/GjObx+vYqn6uQONyN/W2dugTIFOVihStr7h40tUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fh8JLPzuOKTqavmbEuewagvwq46TsqTOVMw969l/IPBWCiFwJFpU7EYXU93TwmE07
	 iWerqTRGWcnGd91u7pz7u1JQoBMnw3kLWH4pKvEyX2/Brwx1V3Rb9G18GOo1RmT4QG
	 eH91DAq++D19X3oDAFjFXYUtOAjLGSV/MORusJLtTc/0vID7r6ev1ApUL4izNlaQlT
	 o6F7DOoEGubbX9ZZiJc2pfmyo381gZ4M61eFaSsMjw0RHRisQh6/rAGKwXTUyf1L0K
	 eFOrBFPeq2Z23xsDvk9CS3e7i13wpx8r0gnDnMAatr530m9Uxm9pqEzg836qKmlfQG
	 yiqcI8RJGuJlA==
Date: Tue, 10 Dec 2024 14:13:08 +0000
From: Simon Horman <horms@kernel.org>
To: Jesse Van Gavere <jesseevg@gmail.com>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, andrew@lunn.ch, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Jesse Van Gavere <jesse.vangavere@scioteq.com>
Subject: Re: [PATCH net v2] net: dsa: microchip: KSZ9896 register regmap
 alignment to 32 bit boundaries
Message-ID: <20241210141308.GE4202@kernel.org>
References: <20241207225906.1047985-1-jesse.vangavere@scioteq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207225906.1047985-1-jesse.vangavere@scioteq.com>

On Sat, Dec 07, 2024 at 11:59:06PM +0100, Jesse Van Gavere wrote:
> Commit 8d7ae22ae9f8 ("net: dsa: microchip: KSZ9477 register regmap alignment
> to 32 bit boundaries") fixed an issue whereby regmap_reg_range did not allow
> writes as 32 bit words to KSZ9477 PHY registers, this fix for KSZ9896 is
> adapted from there as the same errata is present in KSZ9896C as
> "Module 5: Certain PHY registers must be written as pairs instead of singly"
> the explanation below is likewise taken from this commit.
> 
> Fixes: 5c844d57aa78 ("net: dsa: microchip: fix writes to phy registers >= 0x10")

Hi Jesse,

Sorry to nit-pick but the Fixes tag should be placed along with other tags
at the bottom of the commit description. In this case exactly
above your Signed-off-by line - no blank line in between.

> 
> The commit provided code
> to apply "Module 6: Certain PHY registers must be written as pairs instead
> of singly" errata for KSZ9477 as this chip for certain PHY registers
> (0xN120 to 0xN13F, N=1,2,3,4,5) must be accessed as 32 bit words instead
> of 16 or 8 bit access.
> Otherwise, adjacent registers (no matter if reserved or not) are
> overwritten with 0x0.
> 
> Without this patch some registers (e.g. 0x113c or 0x1134) required for 32
> bit access are out of valid regmap ranges.
> 
> As a result, following error is observed and KSZ9896 is not properly
> configured:
> 
> ksz-switch spi1.0: can't rmw 32bit reg 0x113c: -EIO
> ksz-switch spi1.0: can't rmw 32bit reg 0x1134: -EIO
> ksz-switch spi1.0 lan1 (uninitialized): failed to connect to PHY: -EIO
> ksz-switch spi1.0 lan1 (uninitialized): error -5 setting up PHY for tree 0, switch 0, port 0
> 
> The solution is to modify regmap_reg_range to allow accesses with 4 bytes
> boundaries.
> 
> Signed-off-by: Jesse Van Gavere <jesse.vangavere@scioteq.com>

...

