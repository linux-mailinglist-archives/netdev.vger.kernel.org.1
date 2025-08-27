Return-Path: <netdev+bounces-217383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40608B38812
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7903B21C0
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBC22C3278;
	Wed, 27 Aug 2025 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um3ox1ST"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3612D060B
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313696; cv=none; b=LpCx3l+h/FNpucqD7PaWJYsdzBsjR4DOi5UNJCmob7oQ33I67ttdB96+Q4TAx3SeDRrPMf9zvk86s/Gp9uIi62ov+r1Py+bYSV0OMe/3jhCekyYPn2kzilMsBti0AWYxc4eezA+MTvzLu3UJyY7nXnDmBM7VBC9BLPchPngG6g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313696; c=relaxed/simple;
	bh=O1hLLI/Qgyk/q+OgNWL9ju0b7u2Ra68jqZaW8Wl7Z0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZeRDP04wBB0fJC3Y2sX3yx9Y3lP+PrSviVn9f/aGNbpGPVaNzXXnRn/kawx9qtzY+GlI2lxoM4QXGoyAGLBj+eAu/JnKWS1TipKeRqKc0i6X0n4MQLq8Ax/ZOyztN6bfFaedQssopSfoYW0phxLFay4hBuuGW2zaJGyairpQIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um3ox1ST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199CBC4CEEB;
	Wed, 27 Aug 2025 16:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756313695;
	bh=O1hLLI/Qgyk/q+OgNWL9ju0b7u2Ra68jqZaW8Wl7Z0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Um3ox1SThcr5HYr4PIxx6Vs5SMupq0pOmcXSM7O7XUyeMQPtQD+fRSELMQjsYx3qB
	 iVmyZEvafE1ESh0MmJncOpb0kQeb9K2WGWTTDuKhm1t5EAnKiZCrkFAX4vxlR1DvPl
	 7hS04c3p649/5uYuocG2WOwJB0SRP8agpK3X/hiUCdzTvdQ5M0oygoLW3/nuFfnXcQ
	 TyieKXfdwKUJ91lB8ZojDL4y5LR6b11lxhiveGeU8gdMZSD+X2Kbzr5/uFtNptbQC4
	 5x8b4uZvZAKjI25Qy1CwWuakcQa2ncHlRSxGtxEaNlDofWoLRT/H6CbCwptByWGqgB
	 jw5Kxb0nYfk5A==
Date: Wed, 27 Aug 2025 17:54:52 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 06/13] macsec: use NLA_UINT for
 MACSEC_SA_ATTR_PN
Message-ID: <20250827165452.GH10519@horms.kernel.org>
References: <cover.1756202772.git.sd@queasysnail.net>
 <c9d32bd479cd4464e09010fbce1becc75377c8a0.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9d32bd479cd4464e09010fbce1becc75377c8a0.1756202772.git.sd@queasysnail.net>

On Tue, Aug 26, 2025 at 03:16:24PM +0200, Sabrina Dubroca wrote:
> MACSEC_SA_ATTR_PN is either a u32 or a u64, we can now use NLA_UINT
> for this instead of a custom binary type. We can then use a min check
> within the policy.
> 
> We need to keep the length checks done in macsec_{add,upd}_{rx,tx}sa
> based on whether the device is set up for XPN (with 64b PNs instead of
> 32b).
> 
> On the dump side, keep the existing custom code as userspace may
> expect a u64 when using XPN, and nla_put_uint may only output a u32
> attribute if the value fits.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


