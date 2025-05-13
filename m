Return-Path: <netdev+bounces-190159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 907AEAB55D7
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 15:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463461B46000
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 13:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08701F151D;
	Tue, 13 May 2025 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tfUyWd+n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6228FD
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142350; cv=none; b=PeTF0V02VHemQCwz0S2rG/P9DixHrNDdbfM9R4npc3c5xt8cn60oB5bGNjBSYBx4eGAoG0FqN637NFZQAFQLcO1m/9ahHvfXrwYgtvMktX7Gp4wUyxBsak1sKqTlk+RFWnfMXCAzLQ4WPB4Xyxo1WRMWF6q7H6gKJBg6XaT8754=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142350; c=relaxed/simple;
	bh=OTsl9sCNo4NDJ/iSjRqhZFyIH2sSlHmGZ24poH2ro+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2T+BHkBRf7obyn29gJposBU2Y7dpmWGOnSVouogDzCf8stWBHPI4AFeg4UqnE9FkYwXWIo49/5qfRkLNg+vKo0ABYb6Mk+r6pKlXE/3gDMrv6uoGEbQVoU3cM3FiGMJ+sT03+3xAg2KXnx+2+KRoDVR0Bc5xFVwB0Ix9bGQpwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tfUyWd+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ED4C4CEE4;
	Tue, 13 May 2025 13:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747142350;
	bh=OTsl9sCNo4NDJ/iSjRqhZFyIH2sSlHmGZ24poH2ro+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tfUyWd+n76epb63s5wSvnn12xSyWn+xgV1UVG4x5EED4rCoNke2PU4pkVAE6yytG8
	 qfVD2ghP5D1VODO4XovCycNRwofBLQSITSBoeqGfPZMPBXM3LyaoD/8Kf/pMP4wuq1
	 ml8R0Z2UTvDK8LUGlic7swMYfcGHHfZBi3vOsnjn75HwYVpTLPeaAQJvJh4sArdOzS
	 Sba4jLHgPJyOCh8t7UJHYPQm0xeoV52TGR1ciZzDAh0zE0Q/fiqnxpXNx0uMxRWCT/
	 11wpXLEGWmKj1rPJFlIPWZkAiIUgV6rqKB1y+faNyakOI9OjGJ+znalnV/ZmHZUNPS
	 wCBeOcwxkSjEA==
Date: Tue, 13 May 2025 14:19:05 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gakula@marvell.com,
	hkelam@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
	bbhushan2@marvell.com, jerinj@marvell.com, sd@queasysnail.net,
	netdev@vger.kernel.org
Subject: Re: [net v2] octeontx2-pf: macsec: Fix incorrect max transmit size
 in TX secy
Message-ID: <20250513131905.GZ3339421@horms.kernel.org>
References: <1747053756-4529-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747053756-4529-1-git-send-email-sbhatta@marvell.com>

On Mon, May 12, 2025 at 06:12:36PM +0530, Subbaraya Sundeep wrote:
> MASCEC hardware block has a field called maximum transmit size for
> TX secy. Max packet size going out of MCS block has be programmed
> taking into account full packet size which has L2 header,SecTag
> and ICV. MACSEC offload driver is configuring max transmit size as
> macsec interface MTU which is incorrect. Say with 1500 MTU of real
> device, macsec interface created on top of real device will have MTU of
> 1468(1500 - (SecTag + ICV)). This is causing packets from macsec
> interface of size greater than or equal to 1468 are not getting
> transmitted out because driver programmed max transmit size as 1468
> instead of 1514(1500 + ETH_HDR_LEN).
> 
> Fixes: c54ffc73601c ("octeontx2-pf: mcs: Introduce MACSEC hardware offloading")
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

Thanks, I see that OTX2_ETH_HLEN is already taken into account in several
places including otx2_hw_set_mtu() and otx2_get_max_mtu(). So I agree with
this change.

Reviewed-by: Simon Horman <horms@kernel.org>

...

