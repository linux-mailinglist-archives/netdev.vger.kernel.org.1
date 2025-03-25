Return-Path: <netdev+bounces-177300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6511A6ECF7
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 10:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682D33A590F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76DE1DE8A5;
	Tue, 25 Mar 2025 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1oobzg6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AEF1DC98B
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895911; cv=none; b=BhdX3jtroywVzqDhfvZPmLnovd/lLEb+cl2xybdtcmhKVHSOF9v2FMu3axUvVq2v/C6/wdCvAgItNjWXRSG2WI26w5VAF2cjpNIQLOfI0WtvYHmfftFTatNEWHoZLsc0dBXTc95pG1X86EINGm/gn3cAdIKNFga5hu8K+n8Opdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895911; c=relaxed/simple;
	bh=pherTIo/w/j1N99925KbcU52bpWwy9gIvp7yOTrRYIY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kWU+56pWHtJMaxgiGzSe2x/iaW/njWGisafam+DALlPnAeagiaHM5XwPtMOeFTKC7PEtkxnP0qVb2RO77td5c+CWDt+ZNtnAakvUBgp0BptdmotWmV4dtewC+tXlm/0llhCP5OQfmAPy2J6bF9VN0aIRvIjUkFse+nRPi1uDL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1oobzg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7769DC4CEE4;
	Tue, 25 Mar 2025 09:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742895910;
	bh=pherTIo/w/j1N99925KbcU52bpWwy9gIvp7yOTrRYIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G1oobzg6d21UfzA9RU5QMVDyjRyPsYRf8hOZIiEnwBWfl5aNA1S+256wTMpijoB71
	 eKej1TVfFnejG2Wt56UNHieZcT8I55kuXM8uSJKJvJ7jsVjr9EtwBDt/egglfrek5B
	 lGQYTUckoM03GwXNsqgDWPTWSfK9yv4Dt1JTrxCdA8jU1oQywJM28iV6nCvYdf3PP9
	 gzVrMvoB6NjU8q9VoM4qb7dj4SDKop8ntgXfxijsGG4HDzsheG0KGf2aH+35I4FseI
	 lcE7tT6Xpd5qa0X8QrsA5odFRm6kXR0DbQR0hHPqLn3srU6Y8poL15y6dGa3xn6Brv
	 l7i7GOC3/4k6Q==
Date: Tue, 25 Mar 2025 02:45:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johan Korsnes <johan.korsnes@gmail.com>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: au1000_eth: Mark au1000_ReleaseDB() static
Message-ID: <20250325024502.70a84c3f@kernel.org>
In-Reply-To: <16fd5d51-fc2e-453c-9e81-c2530e4d3ea7@gmail.com>
References: <20250323190450.111241-1-johan.korsnes@gmail.com>
	<Z+D1NpUDCsIZLAEP@mev-dev.igk.intel.com>
	<16fd5d51-fc2e-453c-9e81-c2530e4d3ea7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 09:21:29 +0100 Johan Korsnes wrote:
> > Thanks for fixing it
> > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > 
> > You didn't specify the tree (net vs net-next in [PATCH ...]). If you
> > want it to go to net you will need fixes tag, if to net-next it is fine.  
> 
> Thank you for the review. I don't mind adding fixes tags and re-submit,
> but would that be preferred in this case? Or will it just be noise for
> the maintainers?

Just noise.

Michal, when PW bot guesses the tree correctly there is no need to flag
the problem to the contributor. The tree designation makes our life
easier but not enough to deal with reposts.

