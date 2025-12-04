Return-Path: <netdev+bounces-243555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 068EDCA392A
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 13:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5073E304A11C
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 12:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D8B334C0A;
	Thu,  4 Dec 2025 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fertJK3v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29422C11D9
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764850398; cv=none; b=Iru/JS3OKFM7rK++56Z1DM4XxTB2SHj7ctp0ahLX/4Fxt8iXSCziQt6q3A4UJUf+1PDjpOvDQ9tjgR30EDuXiv33pP8ZDA8RF8TXoMpI19HTii3JYTiQT0vu2lsvjT0R+MpJHKeuNOX8fOCiVCiZ5mPDrbW197gH+ggndCNdZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764850398; c=relaxed/simple;
	bh=8PhKmUb0KY2Az7phOGasKG2VAdTvG3/Edj7Im9P6Y6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IN5Z0mTpsfMgb6KdGw7wAN43Ppt0zwk/oyDOb0QjH6rmbBXnCWDI6cgzUoOPTRsHqtStwAYj7sqOQfArp0JFir2aIq3KyeEiZzoFBAPMNRLFWNxcihLKvKQo1WV54uDZ4jL/9elIyG5Fh8pGDIyFumVd+g1ClKauMqkNxyHnvWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fertJK3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF39C4CEFB;
	Thu,  4 Dec 2025 12:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764850397;
	bh=8PhKmUb0KY2Az7phOGasKG2VAdTvG3/Edj7Im9P6Y6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fertJK3v8tyXoqlw8K8f0wFchzmzGwwzXG817NbPk4e/CKrvv35bPaPX/G4Rb7+zn
	 Cpjam6tPIp+E417rAA9LkZ+K/AdJkKE5VCAXovOyo/GXz4LZgBXV8g7bc11tPzRjep
	 12V2r4GKzVumJ79Ais4HSmvJhrdbbr3c1lmJuKviA6I/QQzBy3RRhz6T1wKzDAa920
	 kENWcf8w2pK2Fw8wgSQHJ98/LZZ0TR8u1La/VvKDAp2xFkMqw3rypYbW4kD0et1FhN
	 78AlcQeXCWafCnSUS24U4iFX/ehmtB8bRzXmXmucz0Xw/c6M73I1+9R1wJJMb7Uf25
	 oFmegPEleSqHw==
Date: Thu, 4 Dec 2025 12:13:13 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 1/6] ice: initialize ring_stats->syncp
Message-ID: <aTF62QTI8CsfxF8g@horms.kernel.org>
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-1-6e8b0cea75cc@intel.com>
 <aSWB3gsh4KpDZae9@horms.kernel.org>
 <16579efc-97b0-4a0a-b70c-7362904ddfee@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16579efc-97b0-4a0a-b70c-7362904ddfee@intel.com>

On Wed, Dec 03, 2025 at 02:23:06PM -0800, Jacob Keller wrote:

...

> Tony is going to help work with me to separate this lone patch from the
> series and prepare it for submission through net separate from the rest
> of the series. Unless there's other review that requires it, I likely
> won't post a v5 to Intel Wired LAN, but wanted to confirm that we'll
> submit this fix through net.

Ack. No objections from my side.



