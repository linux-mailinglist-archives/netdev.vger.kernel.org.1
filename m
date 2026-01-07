Return-Path: <netdev+bounces-247556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E24BCFB9FB
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76D7F3047119
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BD01ACED5;
	Wed,  7 Jan 2026 01:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8mS8hHm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42DC18C008
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767750498; cv=none; b=WP6ZvUUD6uKiB2bgIQLCDvbWsCRzpbkmgo6X4Lnu+GqHNsz3cB/7RahipKWfkaCp4JqdgylhNJhGerNVzTRNAHvUdg0uI4z1X/F8Zk3CS8k0uUYsqeX309Ln9p3c3IFEmcbqOMrZg0uuBDSpYuFraiydI0KsPTv6+lruo2qyo44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767750498; c=relaxed/simple;
	bh=OMqs9Y/XqslkGbzFKIbzBnsbDkbyUzUfmVc6deigixE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJMmfPka++v3QkYgCVLdkg6NmXUzQx/YAFBDFonGcXlL+j8sdkRfu2ySECYAYkNUgEUjm5Dc3mlG34p4wSrpsjMkNw7OOqURcescCEn6IC7kfkQALEwFw43KY6606UeWDxdeWdk+kguHWy7iCwqs8uw2RrPpzRK1IQq2Wtj/4wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8mS8hHm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F93C116C6;
	Wed,  7 Jan 2026 01:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767750498;
	bh=OMqs9Y/XqslkGbzFKIbzBnsbDkbyUzUfmVc6deigixE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n8mS8hHmRH12HU2eNPyhX+wSXvl63DnqRcnSb9izgbyEA/1ncbA8Mi9k7SdBHiO5Z
	 3lRik4+FoECjgGuz/UdkrQfYq78rJLP9zMVGo2ZXIJ/HZg7b4jV5L4ROa1nO1nHcsL
	 kmLKbD904+XP4CPJAJKL+2CM85AdCqUxD1oaWRL3rwUDqqobvO7ohnerLZp5bWbCsa
	 X5J8YSRFwPOBqbK8Ao9A7o+NBwouBUUQz0h5zoa6zmOH2ssg8uBIAareuRce5OjNn8
	 NkFuO71SzI/d3LJgVaNS66xBuNCjnvDLLSXFhDhlkF5n74sTzemUv67r5tr9KJDT1i
	 yTB1FbJlVpOJA==
Date: Tue, 6 Jan 2026 17:48:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Simon Horman
 <horms@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next] ethtool: Clarify len/n_stats fields in/out
 semantics
Message-ID: <20260106174816.0476e043@kernel.org>
In-Reply-To: <20260105163923.49104-1-gal@nvidia.com>
References: <20260105163923.49104-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 18:39:23 +0200 Gal Pressman wrote:
> - * @n_stats: On return, the number of statistics
> + * @n_stats: On entry, the number of stats requested.
> +	On return, the number of stats returned.
>   * @data: Array of statistics

Missing a '*'
But stepping back we should rephrase the comment to cover both
directions instead of mechanically adding the corresponding "On entry"

FTR my recollection was that we never validated these field on entry and
if that's the case 7b07be1ff1cb6 is quite questionable, uAPI-breakage
wise.
-- 
pw-bot: cr

