Return-Path: <netdev+bounces-119257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 550DB954FE5
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 19:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3BC51F2598F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 17:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7401C0DCA;
	Fri, 16 Aug 2024 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBDBBJav"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC92BB0D;
	Fri, 16 Aug 2024 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828761; cv=none; b=UWyV7a72l7I0YOTUF3PEHwgAiR5S3h/BLfzteXiBGoUr6FW3AdjYPwB0QhJ6S6/103qQs7avuTPsqrVBtwaqGAEMxsF3TgIWtq4ub4nucSdyVO8HUZz5vy93rBv7kp7rDpxLseGGG2NXa8oqkOcDwtib4m+f0/iJ+CaARvHGIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828761; c=relaxed/simple;
	bh=bA5v8L/Zi8lF8/Q1yUfx1zshloYJ1VZTDObf6bcb2Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVsUGzSO+WdcIRl5VjzroonSZdcaSH/b02hzUOuU+HMGy2JM6pZyrBR2fYeuxX4zZq0vFa83VGK3FS1m6bYQTcIidBkBQIXz6+T6d8vF7O2Mg5NYrE15DkdhO8LbarKq3m/4k78CFWZzIta2QcKPqNqwUl/LX3VejOC7XkJ5rqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBDBBJav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A44C32782;
	Fri, 16 Aug 2024 17:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723828760;
	bh=bA5v8L/Zi8lF8/Q1yUfx1zshloYJ1VZTDObf6bcb2Jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eBDBBJavlUe6ZtGDVWSki90KjLSx2L/c5QyiHUBNalB3yBfFgfrIXNYbIsdRRkJCo
	 jYrxc8SMKVr5TYufQb5LXtc2dgMde8uXWxb5tq3gyDGPyyJtFgQcW3tXI632vWfrZF
	 hz8CdVEgFyu14/CArguZwssmhfPfRDNHnslJUycLcEi+XewvFCXwBcZMihRgSX5qOa
	 dnsnCciIAyuAaooTXKE8tz7XtVTkw7CkbcdSElBEvFhTYwdSfYg6RdFxQ20KxNANqd
	 HLbYVPVhMCHDmGyohifNW94bQGx7A/ENAqZDeoutEcNGEDV2X1wTGU3DjzWHDU/2BK
	 0BOnrwSGOy2Iw==
Date: Fri, 16 Aug 2024 10:19:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/3] ethtool: Add new result codes for TDR
 diagnostics
Message-ID: <20240816101919.785f6e9a@kernel.org>
In-Reply-To: <20240812073046.1728288-1-o.rempel@pengutronix.de>
References: <20240812073046.1728288-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 09:30:44 +0200 Oleksij Rempel wrote:
> Add new result codes to support TDR diagnostics in preparation for
> Open Alliance 1000BaseT1 TDR support:
> 
> - ETHTOOL_A_CABLE_RESULT_CODE_NOISE: TDR not possible due to high noise
>   level.
> - ETHTOOL_A_CABLE_RESULT_CODE_RESOLUTION_NOT_POSSIBLE: TDR resolution not
>   possible / out of distance.

Oleksij, please improve your postings. You have no cover letter here.
No link to previous postings. You didn't take Andrew's review tags 
from v4.

