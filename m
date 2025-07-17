Return-Path: <netdev+bounces-207839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05ABBB08C3E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 13:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC6A1C2470E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881852BE02B;
	Thu, 17 Jul 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NA6OF22G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F54129B793;
	Thu, 17 Jul 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753371; cv=none; b=IrV1WDjXkoLhNGFt5e1eGJr3J4Ozd+cFptdpNHlZCgGPAk9/V51dZc0WoerseoyRUOyt1To7lYdbwzqiwJc2wKFrYlt2k8sFC+5XXvofT3VYsCJTcQ2zZx7Iy6P4kcRxwVEjwkkDynWQostD/3vzSedL0blSF7zgwN/c3+6vQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753371; c=relaxed/simple;
	bh=hMkZ7rOnRnk26gYxzjQto293cBTRfIY410XV0zYYQ3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZHpMJH+UWDZ4uZBgnFt2GvN71UkqKagSc0HcgHL08DRCbxJV+Jsou37rIxVMMqCF3ES8qamTrFKJJMtkGRu+xM+KZiddrVlBjJcofzdF0CsqjhqKo+8R9zQcxFcxIBVOBt6ItSkdGKkln82i4HomAQpOV1+uJsD/CFIoeV+ql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NA6OF22G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18276C4CEE3;
	Thu, 17 Jul 2025 11:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752753370;
	bh=hMkZ7rOnRnk26gYxzjQto293cBTRfIY410XV0zYYQ3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NA6OF22GS37DEsL+IMSngVjDSz6MtJcmCrExcEcz9rrsVUhKxZEYAJaFXBpr4G4+3
	 mVK8wVMtIIZOwRCM6oIEwSFeI/KzJ06XSZhoJ7f50xFR9xq5AT/oZBzFYxF4I/rujS
	 9x+YzGOO9kIH8PE4ePAifBO6bm2d2l3BWsJstqnRcsHgWsSS5BX60cpsXkjycm3pKe
	 ZSua/CJ0cM3H6BBasgl8KMh5hqZ462HyeS5bxP2ocxVH3CUzsRq6ASHXsnHfl2ZRG2
	 2GFTYt/LPp8J1ov8tAIDAhSQcalF9JjZ/7dKix2hU/TIq/V3Kaq4viZnlIQ1aqQkZX
	 sD4XyvLll5WVg==
Date: Thu, 17 Jul 2025 12:56:06 +0100
From: Simon Horman <horms@kernel.org>
To: Dennis Chen <dechen@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH] netdevsim: remove redundant branch
Message-ID: <20250717115606.GA27043@horms.kernel.org>
References: <20250716165750.561175-1-dechen@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716165750.561175-1-dechen@redhat.com>

+ Petr

On Wed, Jul 16, 2025 at 12:57:50PM -0400, Dennis Chen wrote:
> bool notify is referenced nowhere else in the function except to check
> whether or not to call rtnl_offload_xstats_notify(). Remove it and move
> the call to the previous branch.
> 
> Signed-off-by: Dennis Chen <dechen@redhat.com>
> ---
>  drivers/net/netdevsim/hwstats.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Thanks Dennis,

This looks like a nice clean-up to me.

I guess this is an artefact of the development of this code as this pattern
has been present since the code was added by Petr Machata (CCed) in
commit 1a6d7ae7d63c ("netdevsim: Introduce support for L3 offload xstats").

Reviewed-by: Simon Horman <horms@kernel.org>

