Return-Path: <netdev+bounces-198484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65231ADC512
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5DB91893B1C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322C628C2D7;
	Tue, 17 Jun 2025 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urM31CXt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A051E8322;
	Tue, 17 Jun 2025 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149199; cv=none; b=t3QYYeR7TTslbnXt+lv3fjB+X7xG3OERP3LoT30N2gGBV/02M9DeYHbrrYsHXL2dSY7IPN/1QbIhRhou0V0foLc4mfhF9CkdaZYU+vrMXMNkl77aINY4O+JoEGc2bFjGJOvb1n2uaA3Klq/q0Y5NAk7M+LAXocJLLZWQ0VLVdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149199; c=relaxed/simple;
	bh=J3uBircDaCsikS6zp/2NlGSEyMrpYXwN6XyXGUf2EPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5YSJmNTNsHl4SmVVvO1yHFvxj5l8T2C2dq4x9UY56lRb3TSBYrC5E/8fCGEy4W20kuY3qGl9un8JjuDwZCDDD+TRHyy4jwe/DbTibcaJALXWwj0oANjQOvqHyN55aqW2xOnSe/5VAD+57WHPqXmWEYHw4wTogRQXUqIJiIySMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urM31CXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9135C4CEE3;
	Tue, 17 Jun 2025 08:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149198;
	bh=J3uBircDaCsikS6zp/2NlGSEyMrpYXwN6XyXGUf2EPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urM31CXtBBmq58JIbq06B4BahJitYR6DPcw8Q5YoOiNtXXkt9/03apRE0RRdvqQ0I
	 vBY9DCKkSHs0TXs4lMrjyCCfa9wKkcROEYW/2nVT4awHQwPQHnL6KCQQTvf4f8pQ9W
	 w8q45rzfoI/S2/Hixt9JFaUFXY/7E3UPuNXNHMxOTCYuj8+D/GC/OvZEl8jdemp3oP
	 Gkz5/5or+8Oup7KM62NKY1hNR3Ul9ZJ1epytcdBlvlo+obwEuCY9DxfDsnlt48zZ2h
	 toWk5lbO/0DxPxADcALs+ZzYMWWXxAO24/YdjSvSQoG9lAQUK/S0/vdbKOZ7epOl6e
	 +buiooYjlpQcA==
Date: Tue, 17 Jun 2025 09:33:14 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [PATCH] MAINTAINERS: Remove Shannon Nelson from MAINTAINERS file
Message-ID: <20250617083314.GE5000@horms.kernel.org>
References: <20250616224437.56581-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616224437.56581-1-shannon.nelson@amd.com>

On Mon, Jun 16, 2025 at 03:44:37PM -0700, Shannon Nelson wrote:
> Brett Creeley is taking ownership of AMD/Pensando drivers while I wander
> off into the sunset with my retirement this month.  I'll still keep an
> eye out on a few topics for awhile, and maybe do some free-lance work in
> the future.
> 
> Meanwhile, thank you all for the fun and support and the many learning
> opportunities :-).
> 
> Special thanks go to DaveM for merging my first patch long ago, the big
> ionic patchset a few years ago, and my last patchset last week.
> Cheers,
> sln
> 
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Nice symmetry.

Enjoy whatever comes next and thanks for all your contributions.
It's always been a pleasure.

Reviewed-by: Simon Horman <horms@kernel.org>

...

