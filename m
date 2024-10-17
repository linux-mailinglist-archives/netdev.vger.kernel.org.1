Return-Path: <netdev+bounces-136575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 977799A2291
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 14:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32984B26063
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A593C1DDC2E;
	Thu, 17 Oct 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIh2Bk/6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB661DD9AB;
	Thu, 17 Oct 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729168776; cv=none; b=YzK8eV+BuwogmdezgDou0oTZF92GYzoeDH9HW5Fw24OpGM5XyLkp/4m83XUBq60hArmpV9t/tdzeoKDdzONRk1L/GvztDZNUtfQadbwmwWWxWNQlLWWFuFBYFuysItNKlUMX+txlV7eO9/cz4M6uaBUcFyVj7+TXVBemjFfD8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729168776; c=relaxed/simple;
	bh=hSORhyt+r5npsU5xYPFuTfyRV44mxPLdfFMXv659EYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfI1HJid1tG+BoZlhsO1SbtlsYZPPOJ3h6sDZKHz8k6qcvSNc1/5T2I/9B55BdST3tQUyBguHV9eS9q5NUTbO8yl20qgyXI8jyo2uMklteB4eqhb1IW62ZJfrsHOiqsFxpMOFDUcRMMt4RRAX2CHTNyc3VzjIS2GzKAVrW7GLyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIh2Bk/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289DDC4CEC3;
	Thu, 17 Oct 2024 12:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729168776;
	bh=hSORhyt+r5npsU5xYPFuTfyRV44mxPLdfFMXv659EYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIh2Bk/65/4iHX3VqrTQxeEUOsCFVEADFVv3DpQ46Tpd4lXvW345wAks6Z94pbdrC
	 0BCgSJgrTilpkLNXVy+aC5quvFBeIKMc5kly7xhmJOougC6B4vsP4KBITLDxvhCZDe
	 IneHt2zwg4vpaRvwSiNjbjxTm1w96gMZmZwg+03npU7hRtODP+Hc6gnkvZ0RVgLFA1
	 BXJHR4RlnMfaG0buh+v/mk9y72sLKs4vT139Umb9PIC9vNlJEf/zO2aAxuTBSvPgyh
	 ndviIYzWCD6g565f1aZO+ygQhQpBTH5k4nLkRYq2ifLecID97AZ2XYObZlU9mOc0M3
	 v15lLlb/Z3o+A==
Date: Thu, 17 Oct 2024 13:39:31 +0100
From: Simon Horman <horms@kernel.org>
To: Furong Xu <0x1207@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com
Subject: Re: [PATCH net-next v1 1/5] net: stmmac: Introduce separate files
 for FPE implementation
Message-ID: <20241017123931.GG1697@kernel.org>
References: <cover.1728980110.git.0x1207@gmail.com>
 <e4bfea2845a0f6fafb2e6db539292510b494372b.1728980110.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4bfea2845a0f6fafb2e6db539292510b494372b.1728980110.git.0x1207@gmail.com>

On Tue, Oct 15, 2024 at 05:09:22PM +0800, Furong Xu wrote:
> By moving FPE related code info separate files, FPE implementation
> becomes a separate module initially.
> No functional change intended.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


