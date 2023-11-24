Return-Path: <netdev+bounces-50798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E887F72E5
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E0D3B20EB0
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 11:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C5D1DDD7;
	Fri, 24 Nov 2023 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq+honKY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88A1C2BE
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 11:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF09C433C8;
	Fri, 24 Nov 2023 11:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700825996;
	bh=CpShTYB4hE9zKqGXLgFZBpMCqhHl4rCNulHtnBw6yaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sq+honKYgOxI/giV4itny5wrEDVdHXMj1KgOq5QEpibbq5CoFmRvTZmhS2BuaebzE
	 P3XYIE8zakuXbpgq8fKx/7xiDU4P/wWN0KHcjZVfzeEEXrwf99EBs88FRMK4v/4MIB
	 8vcMHG3wFyRZiq0uaP/3RJTA/UgTeRb/L1T5B/XfcQq6SrDgIcuYrXPygjd6qdxbLv
	 C+gG+lC5KD6fngtQKFv6oOKu/DoNooZg4eZjQOGdlAc8JViD3sbdyKNgYeB8MoUZGd
	 lIJ9tzKp/PA8GgwzrSF43LZZhEI8KcH+yeulpWJBy9k2D4FkXqu8nM5BkGulg/ZqmX
	 DmcEkSpSE67Mw==
Date: Fri, 24 Nov 2023 11:39:51 +0000
From: Simon Horman <horms@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH net v1 1/2] net/mlx5e: Correct snprintf truncation
 handling for fw_version buffer
Message-ID: <20231124113951.GN50352@kernel.org>
References: <20231121230022.89102-1-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121230022.89102-1-rrameshbabu@nvidia.com>

On Tue, Nov 21, 2023 at 03:00:21PM -0800, Rahul Rameshbabu wrote:
> snprintf returns the length of the formatted string, excluding the trailing
> null, without accounting for truncation. This means that is the return
> value is greater than or equal to the size parameter, the fw_version string
> was truncated.
> 
> Reported-by: David Laight <David.Laight@ACULAB.COM>
> Closes: https://lore.kernel.org/netdev/81cae734ee1b4cde9b380a9a31006c1a@AcuMS.aculab.com/
> Link: https://docs.kernel.org/core-api/kernel-api.html#c.snprintf
> Fixes: 41e63c2baa11 ("net/mlx5e: Check return value of snprintf writing to fw_version buffer")
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


