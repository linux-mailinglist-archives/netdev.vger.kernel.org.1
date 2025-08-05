Return-Path: <netdev+bounces-211779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AF8B1BB23
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C182D18849B5
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F2D2264A6;
	Tue,  5 Aug 2025 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htbK/Ara"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323B91DFF0
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754423260; cv=none; b=PZYUXgcTG6IumbD7HFifKCwOIX0KaI4cCr7MiBfnpbmKG2jcvYA4Ett2ppJYcEE/cUh8THu85lR908zAQvvHKLua1K3bGWnhGDnpkCc4xbWBBSeEoyk6u+TEG+7hIeSSKRoQhzd1wKAMT97UbKG86XFA0To2+d99QY/pHd9c4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754423260; c=relaxed/simple;
	bh=2kAmmtJgfM3QTJtTBPTuSG7ml0fYwgF+Z65UNgw8FDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPNlqWsQDQTZU/JyUe28ZfFs/GKxJ9pnUH5F3AQDNiR5T5mBV75uzng3/JNQdMPc5/wvdCkpkZMPNxFhOJ7fZH/8UU8Mp3jtbf7PIdAEXsEJkOINDqsQ8qLko50ZYl/FYxIStnZPetQODOZcihTTlJbatPVTOoFiet0JIrZrNPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htbK/Ara; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BB4C4CEF0;
	Tue,  5 Aug 2025 19:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754423259;
	bh=2kAmmtJgfM3QTJtTBPTuSG7ml0fYwgF+Z65UNgw8FDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=htbK/Ara2v5y5NVGLmKaP5GL+WiOkkGErNmKHxqrqi113hXPqW/yTelDNWCQPN0co
	 3W2YNHL5oNVB83VbpHnhAyXZsVWXLTMDgGz/2uW86G1jaVaf+0kJOwP1iWqshKhJIt
	 U/PwvC97kTzO/zTqCi+3W0nmzhz7zCr4rKTQeTagUilL2+KLmvenL2qVgwxyNbuaiX
	 DW2VVHgs6mX19IdujLrmb6/SlXrl5tHdXQrzz145zxjTpNItK24VT5ChjuFQ4nwm2D
	 wGiCivbKTPczzem8etuFAnvHPC5QnbNjXnhzImZYfMYJ+8k0mTNOhNhPKvVrzLDuEg
	 w++WwUBjKBP3Q==
Date: Tue, 5 Aug 2025 20:47:35 +0100
From: Simon Horman <horms@kernel.org>
To: David Hill <dhill@redhat.com>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH 1/2] PATCH: i40e Improve trusted VF MAC addresses logging
 when limit is reached
Message-ID: <20250805194735.GA61519@horms.kernel.org>
References: <20250805134042.2604897-1-dhill@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805134042.2604897-1-dhill@redhat.com>

On Tue, Aug 05, 2025 at 09:40:41AM -0400, David Hill wrote:
> When a VF reaches the limit introduced in this commit [1], the host reports
> an error in the syslog but doesn't mention which VF reached its limit and
> what the limit is actually is which makes troubleshooting of networking
> issue a bit tedious.   This commit simply improves this error reporting
> by adding which VF number has reached a limit and what that limit is.
> 
> [1] commit cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for every
> trusted VF")
> 
> Signed-off-by: David Hill <dhill@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>

For future reference: please observe the rule that there should
be a delay of 24h between posting versions of a patch to netdev.

https://docs.kernel.org/process/maintainer-netdev.html

...

