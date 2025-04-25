Return-Path: <netdev+bounces-186071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC2BA9CF61
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 19:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5FF1BA020F
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E9319E7FA;
	Fri, 25 Apr 2025 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uonfJQgG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9A191F8C
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601486; cv=none; b=Mte6qKyu2z81biYS7Z+gJ8Zob9NGrVZStFtkpzqn2UpY05dErvJGR6QWB+HMQC4xjmimXN49yKSRUJTAG0cpX1JOCxoMr2gZOuSiagfS3lR3ALpFzg9olmtfTyys6IzaN8itC4Z3VXUlRClWoyJZOrawABs5EhTpQoEIIrQ6pqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601486; c=relaxed/simple;
	bh=Dw2ozB0vM3/AU5yhl6y9gwhEkFP0Rm7la2gkIQvVwY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5m2Zk6Uqeypf7osUjhyhfTxNK3joEwhmi9/CMsSJIGcSuUjJbaJSWhlh8cXepepzueYHelwIRkIFanQWD3UUzrGJ6l2gpdNfzK1pvXlyUdvo4jti8F75o6Bm2O2AmeTQw+LeilzT1RhKHVLsmZbJNo/GEiIQISMaS8XjcY/O6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uonfJQgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B53DC4CEE4;
	Fri, 25 Apr 2025 17:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745601486;
	bh=Dw2ozB0vM3/AU5yhl6y9gwhEkFP0Rm7la2gkIQvVwY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uonfJQgGg1Os6qZVHlB1TGTK0WDwZoqgi1KkiO4DoCPSPHpLT76t6qclYHnXY8t2i
	 YObtVIWw/RtqYE0X7p00VVCJpoutFBfiOvN6gSuephBzjpqOrUVEwY0FkKJIdwA2UM
	 c7eaa51jOYZpupkEzRxWqaOlFAcxFr672nY6bVGHspiKDiItBSr1ve+kYwUZM59ROT
	 0kPQsU+2ZlJbSiEZQrN+jA/kWTC4olpzrJLUy+JYT9IGGAw07fVS6v6PbdrjcbT5wL
	 7DlxFoRnT5h5aBNrVGOkARzNiKefxnsnJr7PqsRxIO52yW/IwHNqmC0H2xhy04qA8y
	 +JgzOaaTk3adg==
Date: Fri, 25 Apr 2025 18:18:02 +0100
From: Simon Horman <horms@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 2/3] io_uring/zcrx: selftests: set hds_thresh
 to 0
Message-ID: <20250425171802.GR3042781@horms.kernel.org>
References: <20250425022049.3474590-1-dw@davidwei.uk>
 <20250425022049.3474590-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425022049.3474590-3-dw@davidwei.uk>

On Thu, Apr 24, 2025 at 07:20:48PM -0700, David Wei wrote:
> Setting hds_thresh to 0 is required for queue reset.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>

Reviewed-by: Simon Horman <horms@kernel.org>


