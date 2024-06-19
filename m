Return-Path: <netdev+bounces-105024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E1590F753
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B807F1C21BEF
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CA222EED;
	Wed, 19 Jun 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJgCXZRw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34494A19
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827367; cv=none; b=VbbYH5j3nOgOTYjPGk97rNsvBMkexxF7XcrBg569vErJ+PjlYBO99dyOF1vGtWtibgLXWLjaoVKqg8x1Cp8I9XzxB3hLYJeUHpjPUY2lqR7eRLQLGADqDi4YisDjNPbBalrNzlRfSRgzk/KB8juWWeWw31EOAq+WVW5wOF3tNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827367; c=relaxed/simple;
	bh=0jDl0DG37xnZAFv5UegVmB79dPdIrZ49CqozNt9xAyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWK7yNPwUFtF4o0sLMZ89RUNFg8ac2SGQ1dc0IkdEG/YGqsUYNolz6rUkZaNu51tAf+BDilSUUI684vUqdxwOMeNa8w3VfeQcj81XhRhwcwIe339qW3ka28KGyyRCitTzaQI/T4DWBxkhuCOj2RPhhhfGlUsWV+r1k2XMjPJ05Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJgCXZRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0679DC2BBFC;
	Wed, 19 Jun 2024 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718827366;
	bh=0jDl0DG37xnZAFv5UegVmB79dPdIrZ49CqozNt9xAyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJgCXZRwKUtK8PwTaUAAbWYpEHed95bLNQ1lNyiihSaWdjbsy9JACnhjtzFW0HxcH
	 FWBKGVqv3+DQ3OAC4JNz/ZYQCV1IPJ3PVUQQ+6jV0V+acHDXcZRCAoODEmO6uQz5VH
	 LBKInLuu40Q8bo5kpoxQ9eRNFRGVdX5kl/Y90UuviXYSOOXNsnbUkgEhUkI9ah6TuN
	 IqLGv+uwxm1gQ+RVaaX0JzIoVP13bwKTQ3V9kgCIC4qW3UxMfoytmTe7aFdlochazp
	 n5OIP4g4TDjnPKblsZxifQJlSAA2DDgY7IfZtkjZV/esq3X6trzVpl4/GrlJKtNKFG
	 PEHDXw291TS8g==
Date: Wed, 19 Jun 2024 21:02:42 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH net 1/3] bnxt_en: Update firmware interface to 1.10.3.44
Message-ID: <20240619200242.GX690967@kernel.org>
References: <20240618215313.29631-1-michael.chan@broadcom.com>
 <20240618215313.29631-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618215313.29631-2-michael.chan@broadcom.com>

On Tue, Jun 18, 2024 at 02:53:11PM -0700, Michael Chan wrote:
> The relevant change is the max_tso_segs value returned by firmware
> in the HWRM_FUNC_QCAPS response.  This value will be used in the next
> patch to cap the TSO segments.
> 
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 311 ++++++++++--------
>  1 file changed, 178 insertions(+), 133 deletions(-)

Hi Michael,

Maybe it is not important. But this is a rather large patch for net.
Could we consider a more minimal version as a net, deferring the rest
to net-next?

...


