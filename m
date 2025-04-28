Return-Path: <netdev+bounces-186526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A5CA9F85A
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BE01741A8
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2D4291166;
	Mon, 28 Apr 2025 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK/jI2XW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC450269883
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864351; cv=none; b=FDVMZhiLVTgs+E0ewgbmHrHURQZRmbou4R3bRXosr7EVXUJaOGqiXc8G8CF/Iv+7Qhj+zgL8glIoOH/QeMmpMykvSgOeie2Tx0pkzbsZ/EiMqhUGhslIhH78QE379ms2aw555onZDVm88tHlKB0tkdYm/PM+Jgg0/UFuyP1yODk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864351; c=relaxed/simple;
	bh=KvgdHRHzIfQADm9nfMoEsy5sX/FgyGKJngfKD3Fwujg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0S6Gh9JtvhiISt/6idcIWOkuwDmgWoNPcLUB6inBMVoZPcgd2/7jR1kRw5+lvHyKS+hFglb4sSJoyWfU07iJPHKtGI5NghFnG+y+kOp6J/e/jSPxWK0MO/WqXIfswxM9KdELU82sDhHIDjUincFJyX4N8cn5FMJAg85wdhgj+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK/jI2XW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D8AC4CEE4;
	Mon, 28 Apr 2025 18:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745864351;
	bh=KvgdHRHzIfQADm9nfMoEsy5sX/FgyGKJngfKD3Fwujg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LK/jI2XWQeRf+dZ8jHhYCvURyXsBFfZzckscSyRRvgZo99eZQsTNHpfKR5UQ1c0He
	 gEK6k49Dm5qJgMQyACSauoGeqvQDvxFiszeOm7wD1Mxw1kGUksEI27IhslLRJCWth9
	 GQvkcgVMouePcXd7yFrQIzkZcNX8dqKDNddNCqd9kguG1OgHY6HHC58whWvaXilNKi
	 /EzzvDa7ce0mJ3ZDoGnFws3eGg72rBUo2bniO7YibbVw5fNfaUqZ76kDpljOzI27iR
	 GKVdqPQsXoPmefHK0Grn4CCDRznIG/Y740GAylzCUKnTfIG/CFAoHLaqZZEPCbes2m
	 mHtLpeeSigFoA==
Date: Mon, 28 Apr 2025 11:19:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Jiri
 Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink
 port function
Message-ID: <20250428111909.16dd7488@kernel.org>
In-Reply-To: <95888476-26e8-425b-b6ae-c2576125f484@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
	<20250424162425.1c0b46d1@kernel.org>
	<95888476-26e8-425b-b6ae-c2576125f484@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 15:11:04 +0300 Moshe Shemesh wrote:
> > Makes sense, tho, could you please use UUID?
> > Let's use industry standards when possible, not "arbitrary strings".  
> 
> UUID is limited, like it has to be 128 bits, while here it is variable 
> length up to the vendor.
> We would like to keep it flexible per vendor. If vendor wants to use 
> UUID here, it will work too.

Could you please provide at least one clear user scenario for 
the discussion? Matching up the ports to function is presumably
a means to an end for the user.

