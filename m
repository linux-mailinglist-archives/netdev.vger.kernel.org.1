Return-Path: <netdev+bounces-162179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0643A2607A
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 17:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9B318868A2
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889A6154426;
	Mon,  3 Feb 2025 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVxUArQx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F801804A
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601188; cv=none; b=VX4fRd/YZEUVd+qcYX5T1WQR9BrHDy/xh5ofUMiF2FMOVgOOC8mQ0uFbdRxg6Grg81lhA0aEMFboi4sqCloo9bZ6sCPjdtqcijf847lPHOIanDqqImOeEC35C81nlYdzTbN9dWJsrAcuJ0m6dCrI3DOiBJZtRT2Ny5RJTkGKbMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601188; c=relaxed/simple;
	bh=2x58gP+L9Aq2+tW4TV+bMLf08YoiRxLzIS/yjXmu/F4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oz9ODojFPII6luZ+ZOzX3lqssijuqs2KUqt5gGFYHETJvDwBle1+/gxG3D4hSdOkrgLE8/WeX5G0AESN2SJbdgmqGE2cd/ek5pRJ9P7TtueMBDQSDhfl40fJdnDs3ipRLX0dN8jmSdyxWokWpSM83xd11+OmHlxOWwPs00pOWXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVxUArQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAFCC4CED2;
	Mon,  3 Feb 2025 16:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738601188;
	bh=2x58gP+L9Aq2+tW4TV+bMLf08YoiRxLzIS/yjXmu/F4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZVxUArQx9wuP94rVG7t5N+ONfWiyRHqhsOzP/B/9a6jPTP7m8xbwiHS8iiQjLuLWH
	 uRxs5UTGL9xuOc8DJFFt8ZH/8wGE6MANUTZ6YYkF16HpWlDYsN2MKRMHkZRrXOx/ym
	 46jwaDaLS1BP/7N0v7vvgHiFZRweCvltZQswpd+ozrvhHWrlfWo8qrwTeZ8RZdMpPT
	 pw+dn8y/fHpgZPolmN3oGxy0kUejhHqD2CUiG47NtPxHo4iF0MRMkM808M6mD4/WBU
	 RH6f6bQ0kDfidWpAjh57mWaAstVzWLR9VLulgk0Atcc7hNsQVv0gtMTywgj04L3TLP
	 Gr0aDPBTfMlPA==
Date: Mon, 3 Feb 2025 08:46:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch
Subject: Re: [PATCH net 2/2] MAINTAINERS: add a sample ethtool section entry
Message-ID: <20250203084627.54982995@kernel.org>
In-Reply-To: <9f6c2d87-bb45-4c95-af93-7d2ca5f1dcc3@lunn.ch>
References: <20250202021155.1019222-1-kuba@kernel.org>
	<20250202021155.1019222-2-kuba@kernel.org>
	<20250203105647.GG234677@kernel.org>
	<9f6c2d87-bb45-4c95-af93-7d2ca5f1dcc3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Feb 2025 14:29:23 +0100 Andrew Lunn wrote:
> > In the first instance this seems like a good direction to go in to me.
> > My only slight concern is that we might see an explosion in entries.  
> 
> I don't think that will happen. I don't think we really have many
> sections of ethtool which people personally care about, always try to
> review across all drivers.

Agreed, FWIW.

> Even if it does explode, so what. Is ./scripts/get_maintainer.pl the
> bottleneck in any workflows?

Only concern there could be the keywords, we had issues with regexps
being too expensive in the past. There are plenty examples of how to
do them right now, tho.

