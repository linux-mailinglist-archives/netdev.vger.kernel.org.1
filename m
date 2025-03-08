Return-Path: <netdev+bounces-173192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8E4A57CB0
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 19:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACABC188BD05
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 18:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFB71B6CEF;
	Sat,  8 Mar 2025 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mM71RI3n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5359189F57
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741457961; cv=none; b=fNwWxiGXYkTR2aCXx8fSr3n6EVDlvje09b6ZffEZ+UYWGQn8G18KiXYXFHL1n/FBX8PO7SztCzzYKaqslOwb5/pzs6tPcmc2USFB3AH5MJQf8P4KTg8g/5cUWC++wMMUfTB8XxKa9ja7uyOE3vVd5ZW5TqvFogvc4RPW2FTtJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741457961; c=relaxed/simple;
	bh=PeNt9G9bylaQc2qsKhMbm9b8bhmZVq3+fzP5IVwQgYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6/pV5LxPQ+ah7kSW/KJCL26O9IdC3pTzAJ03+MqKb03yNDXmcziWnaAw7iS4fX35d3i54mGgi+U5UwaQlZ6rZ7G6k+iDGlOJvJjO2CAVB2QvUHw7wiLP/8hIN7OXUgfEmC5G88Xz2rkzUiLATCdz99o9zjkm59PNmUJQOOlCmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mM71RI3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A988DC4CEE0;
	Sat,  8 Mar 2025 18:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741457961;
	bh=PeNt9G9bylaQc2qsKhMbm9b8bhmZVq3+fzP5IVwQgYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mM71RI3nsR3oapPHSp4lay0Mt3SQ6yK+OY5uGdmlYQY7Yq3GwgfEWBH72XLriW3hz
	 PnrjkpXRMmoSUTeSOyL7G4d4lxAaruNaxzwwIUHudqP464a+MM451u1i2QvMa3nMan
	 qySpBnaGFUrBbNuTPQXYIiwWsz1DyQb9MZ4hDHvZLb52PfzTRVAnzqZO/wqyhkQESm
	 IunqikDpnMqfHnpwAtg0hXUFP25s99ODhu8ph2nKJT7Vl0cMX5shQOLniYILhKb62/
	 hxkAjo05nU60ex/Cv/QfYWQkK59+qAqi7WZ3xJkUtTYC7oy8nhNpix2niz38lTgCfj
	 1Z0WcrA9yrxGg==
Date: Sat, 8 Mar 2025 18:19:18 +0000
From: Simon Horman <horms@kernel.org>
To: Janik Haag <janik@aq0.de>
Cc: davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: cn23xx: fix typos
Message-ID: <20250308181918.GM3666230@kernel.org>
References: <20250307145648.1679912-2-janik@aq0.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307145648.1679912-2-janik@aq0.de>

On Fri, Mar 07, 2025 at 03:56:49PM +0100, Janik Haag wrote:
> This patch fixes a few typos, spelling mistakes, and a bit of grammar,
> increasing the comments readability.
> 
> Signed-off-by: Janik Haag <janik@aq0.de>

Thanks Janik,

I guess that as the scope of the patch changed the subject should too.
That notwithstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

