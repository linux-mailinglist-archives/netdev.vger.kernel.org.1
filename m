Return-Path: <netdev+bounces-227820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD1DBB8298
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 23:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F3419E4DA8
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 21:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046362561AB;
	Fri,  3 Oct 2025 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9y5mGAB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F372264C8
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759525443; cv=none; b=aJMk90HD0NW0nezEe0nWQOl78eI5x4Sb6ugMbZ9Q0ox1A5kcge7KZ/1gS12ndyafLinjdopOHOlVeiqO/1YvpMnREcyvddBbbuDjlqjt3IvD4gEVpQsqEmXKCEpk0xjkQ0/x/W0rDvtfmxCSNzySuyYIDBghhJuMUZrKf9h8LTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759525443; c=relaxed/simple;
	bh=jbvRJiBvhQeNWjdr8otd4Qx5K+z7TEFvV+uGY8gcaT8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWUJLTEetiTvVxOUMr6d2hm0O2sgYmKBu5uQ0xgNeONjYznxKx+RfdJEf71Pxc2SF1WdlxksKpEu9knlkZ80PYpTR9u2qGwKc//Lk6nZenu2rTNCCCD4hG6tMtP5VtAv/r4sQ+3Ngx9WkvFacTXdYsjGHQwO99WENjC1U6Bct0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9y5mGAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4EAC4CEF5;
	Fri,  3 Oct 2025 21:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759525443;
	bh=jbvRJiBvhQeNWjdr8otd4Qx5K+z7TEFvV+uGY8gcaT8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q9y5mGAB2SRASa5Q7NM3xqX8Mqi4RaJdm7Nkspvv9IPQFsTy5vQY44phZmXq1cQdQ
	 ADqBK8q5Iz6v26mkz976cfdHffEzEhNe3sbysyC/XuxPEdyjX7+laki4ixhyGipmEc
	 0rawICPNubDefp/mYVHNB6Dib5OBuDcTLUykN4/L7msn6ZCol0ysPT66mhg+wgojlU
	 AtqQsV/7Sdwe6YsDmT6HstEv9RwVf0vNXtn60rjdIM9ttnGAvRZAgUqpNBmQ5+1VZU
	 7yHIiXJiOm7cVVkBzpU70HyFIy5nSvscxGnfr/+w5wxcTBJo0a2DFcvU8NXFp1vBih
	 ArgOpqI8dpbHQ==
Date: Fri, 3 Oct 2025 14:04:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2] doc/netlink: Expand nftables specificaion
Message-ID: <20251003140402.1c5bef8d@kernel.org>
In-Reply-To: <20251003175510.1074239-1-one-d-wide@protonmail.com>
References: <20251003175510.1074239-1-one-d-wide@protonmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 03 Oct 2025 17:55:34 +0000 Remy D. Farley wrote:
> Getting out changes I've accumulated while making nftables spec to work with
> Rust netlink-bindings. Hopefully, this will be useful upstream.
> 
> This patch:
> 
> - Adds missing byte order annotations.
> - Fills out attributes in some operations.
> - Replaces non-existent "name" attribute with todo comment.
> - Adds some missing sub-messages (and associated attributes).
> - Adds (copies over) documentation for some attributes / enum entries.
> - Adds "getcompat" operation defined in nft_compat.c .
> - Allows ynl_gen_rst.py script to handle empty request/reply attribute.

Please don't send a reply in a previous thread and 4 min later a new
version of the patch :(

BTW this doesn't apply to net-next.

