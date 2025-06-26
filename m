Return-Path: <netdev+bounces-201523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF12AE9C25
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627BD3A8F2B
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3712B274FF4;
	Thu, 26 Jun 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icYoqMhn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8612727F0;
	Thu, 26 Jun 2025 11:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750935983; cv=none; b=LYMqzMLeiiXQhr4HrlrvaVByB1aEnHfyKndbAzB/EJlTdhVXQ89w0vdd33jjXzCy48PkavlLfrCu8cREmSTQ00G3uX6xBGbqoX9SUXPWnocRv4p/Z9+OsFCpJrRJ4sfnapaBB004FLsxP9vz6jfoO0lGNocg+xSVvhZeZwLVcWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750935983; c=relaxed/simple;
	bh=x7q5skRjz1OVgPcEtm4Z3B1dc5BXdbgM2Msi2ETyg6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1ROYI/1V8mqfWh0sOCtThDtja4RM+ZJAYCt/o3WXXa8A4F+XCoQucx6MCaChswQP/ZfM1NyOBeNG/R8bsqw3OrnrYtzBha3pMXQWAh6X07t+c97dMsXjR9vUurfro0QcidFpnthVl9B4KW94NN+VzKR53jWIs0hr6hlgRFoXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icYoqMhn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C07C4CEEB;
	Thu, 26 Jun 2025 11:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750935982;
	bh=x7q5skRjz1OVgPcEtm4Z3B1dc5BXdbgM2Msi2ETyg6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=icYoqMhnqYMQnSt4bSPYDHPDWBr6x5oglxgY9OfIgYI/cdFz6wOfqAHwP+0WA3d2v
	 X2FdQnArtRzcfWU7Dk0qFmLh/QISndbDXnCAV1IxxjE1cyozVD0c3EbsDR/zROPkUc
	 /c4QMKrgIzKuY8CcNywNZte7YdxR0aXEigfw0hVWFzpA7KahkOqS7WrG1dx+uk3i/l
	 2k2JGhJA8Zzc5JDjJmROP4L8XEqpphC2if+YgYWzUGsyz2s/BTdRd5dGMeaXB/kz2N
	 YgQ+wrOhtvEXn0JzZti5d4Pe3TePvTMhFivE9hSGUaPT3znloIlERLamqLKvFkDhH4
	 Fwny1X2zfHAgA==
Date: Thu, 26 Jun 2025 12:06:19 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] atm: idt77252: Use sb_pool_remove()
Message-ID: <20250626110619.GW1562@horms.kernel.org>
References: <20250626075317.191931-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626075317.191931-2-fourier.thomas@gmail.com>

On Thu, Jun 26, 2025 at 09:53:16AM +0200, Thomas Fourier wrote:
> Replacing the manual pool remove with the dedicated function.
> 
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Hi Thomas,

Unfortunately this patch doesn't apply cleanly on net-next,
which is a pre-requisite for our CI to process it.

I suggest reposting this patch once your other patch to this file [1]
has been accepted.

[1] [PATCH v2] atm: idt77252: Add missing `dma_map_error()`
    https://lore.kernel.org/all/20250624064148.12815-3-fourier.thomas@gmail.com/

The code change itself looks good to me.

-- 
pw-bot: deferred

