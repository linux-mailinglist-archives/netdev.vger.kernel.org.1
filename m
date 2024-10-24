Return-Path: <netdev+bounces-138600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3819AE454
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1839284807
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364321C8797;
	Thu, 24 Oct 2024 12:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvKDt0Un"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7F914B08E;
	Thu, 24 Oct 2024 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771350; cv=none; b=X/4oOJftYtQwkxptoJcS1P5HIwT9RDCsjbGLg1g/sGRqfVpFHx5NwrjM1ZDff1YxmRqeZkirhjPXefGY72gMImIYKRek0Woq5qPE5Z5We4bmLdkuS+coBPGbTmxN2ugUDzCXEShgQolitJp8/j/U+MRpvvw2EgoQ9zo2KJaYDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771350; c=relaxed/simple;
	bh=iHUIDKe3kskteOV95KX7xvooXvXUy+WtU3HlqQrJnJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGUAmRP4+8bDjrK72U2NJBVEU3zRU/nM1M1ok0AlIB5YSI+a80GFiohnwTmPgtP+k5ItXRtUaQjHAGHiUX4uqBd+bHy74Ls6ysbaU/oKt2/PzLpCKFdXinxcyMLm7gNHQ7QN6AINj+yXvEpkG0U8Denb5IeT80wkygLm3V/FZrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvKDt0Un; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD1DC4CEC7;
	Thu, 24 Oct 2024 12:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729771348;
	bh=iHUIDKe3kskteOV95KX7xvooXvXUy+WtU3HlqQrJnJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WvKDt0Un0J8x6icLo1AoJsRhY8abAydWi6DlM5/PfV9LSyMdYUTzDwkzs2CTY7o9k
	 Fk74ZixGCrTEmiW/4zyeClOeXFLqGthg9PXypimN7FzF3qEnG37yzUCOJ7qvlLGPRO
	 WAGrBWADtEtbOtOHjLvDIukP+WHFxyEZ3F3e6Bbx83q9tv4PphP/GXD4p2txGxcFkv
	 WXqlEkzlVWyQK7r3URwSXhvmQe2klyTxu4n0p2J3p9jjWXsg4HT8eXfDz7Plc1WuXH
	 Jx27vLlyGuAXt3oZZAQcBy2txHdpCqRvQIJHUIgQ56zuZz3F9hh6Bw3gu5eVEl4o9z
	 M5APbwJy0fDFA==
Date: Thu, 24 Oct 2024 13:02:24 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] amd-xgbe: use ethtool string helpers
Message-ID: <20241024120224.GH1202098@kernel.org>
References: <20241022233203.9670-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022233203.9670-1-rosenp@gmail.com>

On Tue, Oct 22, 2024 at 04:32:03PM -0700, Rosen Penev wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


