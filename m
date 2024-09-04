Return-Path: <netdev+bounces-125202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 066C496C3EE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 18:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388701C2262E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4223B1E0080;
	Wed,  4 Sep 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLbDOkBA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C51DFE1F;
	Wed,  4 Sep 2024 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466801; cv=none; b=cpQwydyzbbVxBFh23DBwVZbMVUx2VEEy66BGTPExCXfxClO6kI23vjz8MWyJGg6qKjeQ62Fcr4cN62P5hzZ9FNepMpfaYXivbZHWjzrb2OuXW/8WJV87dj75+Nxm0/VMSGRT0WRJ2Y1Ak1KADd9rMJMNFXzvEZoadAcJyi1FxsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466801; c=relaxed/simple;
	bh=fy/rsKq5NUQWjqhj2FXqgVEaar6Pzvr/oBS+ncPkFSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGTXF+yqjBH92PUtuGuHM5OhmGupYlnt8xRF7Hx5Ogmur9HcyZ4nxk/XNXGbbFuD1Ol5yKoOJkMlRnOjcZQuoomu9rs1/e1Kc9mNNvMd4jaXgb5yjaNwDgu4Tw9lHYdKqk1kXPESoeuBCMMR5hDsL9MQWZeAK/EQszLSW6F6hwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLbDOkBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE99CC4CECE;
	Wed,  4 Sep 2024 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725466800;
	bh=fy/rsKq5NUQWjqhj2FXqgVEaar6Pzvr/oBS+ncPkFSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLbDOkBAvb2SUY2IUCT5wZdur4Xc6ULFJGf8wfbyqa8DDSSzF7HRCpVy9iWieNdsb
	 MXgNQc0b25bbiB43dQVZW1By4lUEtQL8pHTSIFR2TBICbYDsBmvcX8dMRYOAiX13pm
	 cdOpC5lvGLdzi8Tsi5mhJ7skodn+1ao7IIFfhKced7qKt/4boAWGP9iY/VvFCMrDYH
	 P4hTZXzgqwfyEn2s2mKh2Ra4dOD4WISdOFtuBmMsX2vwG9XKRU3PzKCj7ruDAtwEvo
	 slraiOvs6EQjeHijzUs3EUMnZJF5CP7AKslaWAJDKCv0Q1IbO+PH8wXuAD0j3mHByp
	 Ip3cFUjCabQug==
Date: Wed, 4 Sep 2024 17:19:56 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] net: xilinx: axienet: Remove unused checksum
 variables
Message-ID: <20240904161956.GY4792@kernel.org>
References: <20240903184334.4150843-1-sean.anderson@linux.dev>
 <20240903184334.4150843-2-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903184334.4150843-2-sean.anderson@linux.dev>

On Tue, Sep 03, 2024 at 02:43:32PM -0400, Sean Anderson wrote:
> These variables are set but never used. Remove them
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>


