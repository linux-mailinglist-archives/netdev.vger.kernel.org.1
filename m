Return-Path: <netdev+bounces-226023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E477B9AEBD
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 18:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B53323965
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 16:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6F13148A8;
	Wed, 24 Sep 2025 16:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgwBXZZS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054F9313289;
	Wed, 24 Sep 2025 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758732789; cv=none; b=JGf9hlNPQCkLF/ztfzDnLE4iXr2HWOaiAcjgSUpwTXw2lTv3aUGNBDvs9Wg+tmsDMWmLqSoPJ5YU4YK4suaKMtqdajPevCpHROSBHmr6QWKizyiZscYK1LzNDs+XjNfVlSe3tA4LvqkeAbyDX+ajRUaKNZC7pnunRdsUyvT2OsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758732789; c=relaxed/simple;
	bh=kxcEY+ROYEFNM8We3XDr6cPqC9ljW2yZcjwNFr32eR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaR9pkZb72vbhnsmHheNWBgGnVZCtiIqUuuhIdgWIT3k4CxCdBxaNBa3W1kmYmQSJ954dFoBLLQ0uObPjD1tvusNJ94ESknIwCz9MOvgjoHpTdkrDYGcZXHBQm0MRDO8T72e17LJksd8ythmr1JFY555BzAKMZgYq7lTlmeJuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgwBXZZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C69C4CEE7;
	Wed, 24 Sep 2025 16:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758732788;
	bh=kxcEY+ROYEFNM8We3XDr6cPqC9ljW2yZcjwNFr32eR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NgwBXZZS42/rTsqQR17N3NkOjWIdpJz4P94rG31qAfySt1sc1ovSqRjTMDURZvzDT
	 lGkAv3NdsR2BZ9en0U0Wa+CqX7QiTysWTXSy3bRTsRtAjxm2PzYDvUjnis9pbRNrPI
	 sxYTOhuj4Fi5PEUljV01usb2CMcgnixQXJgSTG577z2L379CqOwcy0Xq+1wQ9mRd25
	 YOWU3wUV5UQLKeqT9MvHlZYjB7fsKg6l2D88GJBJ5NcrVrQUCSAO7H3EuTEaiD5vnb
	 pW1MOA++pMhisBv4jwn9A3M5GIgqrde30CFvuG97cHtABDOoaqaNK/iLbo0duaB2fY
	 CpcZFMC4i8DUQ==
Date: Wed, 24 Sep 2025 17:53:03 +0100
From: Simon Horman <horms@kernel.org>
To: Sathesh B Edara <sedara@marvell.com>
Cc: linux-kernel@vger.kernel.org, sburla@marvell.com, vburru@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, hgani@marvell.com,
	andrew@lunn.ch, srasheed@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [net-next PATCH v1 1/2 RESEND] octeon_ep: Add support to
 retrieve hardware channel information
Message-ID: <20250924165303.GO836419@horms.kernel.org>
References: <20250923094120.13133-1-sedara@marvell.com>
 <20250923094120.13133-2-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923094120.13133-2-sedara@marvell.com>

On Tue, Sep 23, 2025 at 02:41:18AM -0700, Sathesh B Edara wrote:
> This patch introduces support for retrieving hardware channel
> configuration through the ethtool interface.
> 
> Signed-off-by: Sathesh B Edara <sedara@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


