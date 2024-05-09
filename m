Return-Path: <netdev+bounces-94751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24CD8C0933
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 03:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC121C20E62
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 01:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDBD14A9D;
	Thu,  9 May 2024 01:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g48XRvdR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89606FB1;
	Thu,  9 May 2024 01:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715218659; cv=none; b=B2rBiY7OljqN09dtJXksWfURgRj5ZjQhM+mVJLTPQJ/RkZoolMVHt0Q5Ncmgrgop8wPB7Ys8E0+B3NDdBFbNBf/gO/ZZTQxmu4pwoNKaIx3jA0YmLCj9iMQk8PxRloqFm2BZ/tPcvlJJpsQ/TfCDz6g9YYk1j1y1EpF5/tewy80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715218659; c=relaxed/simple;
	bh=coPx62UMXppxx51kD/azsD0fV3HT0qXrbSmJxDtqKpI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvCr7NBYE/G5BZnAuYqEwNSk5bhewILUwO6AfOTSVnjp60uQQvd3UY9kDulH2AYn7kKRRvYNqGoDUk+AjfBdMzXYJ6Kl9Ho/0hCcXfzBKiaZ44PDLDl1n9g4dK3FJd8692KGfW6w5pAd+04BMdQT0Jy5CFua9TwORfpeZz1Zikw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g48XRvdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E3AC113CC;
	Thu,  9 May 2024 01:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715218659;
	bh=coPx62UMXppxx51kD/azsD0fV3HT0qXrbSmJxDtqKpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g48XRvdRfu4AmTShMz66SyzGm8IZtvSnj0h6+MYEgKGf/gheurw24jFSgZjQ2VT9D
	 SLC4kc+PgWDz14NLbaTEHweA26airiQCFU+M/Uq+QZe8ouTnXvv5/ZPq0J2mQzyqW5
	 b56nnXp/RixmM2aSj73VWcSKDDjMlA2FqTjS6lmFeZqbmVji0oFmHXeWOXxp+0ZlbY
	 eEE+qghr1tg94QvFssmDtY/EWmODJbJM0pCDgJJCr+gLt0U98dQ0ferAnj2bd77Gko
	 9cnZcxdC0yAfzZAAM6soTc0y+J78v+xgCo9qi9z0a0AkI4yQgjPGdh7hUJbyYrZ1CM
	 LYIj0SZfPnFUA==
Date: Wed, 8 May 2024 18:37:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tushar Vyavahare <tushar.vyavahare@intel.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, pabeni@redhat.com,
 ast@kernel.org, tirthendu.sarkar@intel.com
Subject: Re: [PATCH bpf-next] tools: remove redundant ethtool.h from tooling
 infra
Message-ID: <20240508183738.7204c6cf@kernel.org>
In-Reply-To: <20240508104123.434769-1-tushar.vyavahare@intel.com>
References: <20240508104123.434769-1-tushar.vyavahare@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 May 2024 10:41:23 +0000 Tushar Vyavahare wrote:
> Remove the redundant ethtool.h header file from tools/include/uapi/linux.
> The file is unnecessary as the system uses the kernel's
> include/uapi/linux/ethtool.h directly.
> 
> Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>

Acked-by: Jakub Kicinski <kuba@kernel.org>

Thank yoU!

