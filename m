Return-Path: <netdev+bounces-151715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A53C9F0AEE
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D8C280C4E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D21D1DE4F9;
	Fri, 13 Dec 2024 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVXYSFgH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B201DE4E5;
	Fri, 13 Dec 2024 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089206; cv=none; b=Ejy9MukmhI2derRk9M1Hy+EhO4LdowmKYbxQ6pgfKavJoaZ3mHA1PMqW9QbcKhGCqHO1/l1/0Xjd7dkfxmexM1Q1x1r7mDGVroH88MsEAUDsPSSZPe6No2YcFOD933NTzq14yOr76wxDyF5S4Rqhd01TJU9hp+4TePF7LkMOX0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089206; c=relaxed/simple;
	bh=2ZWKisQ+EEB8m0h3GAkTv+JQi+wBMeB7ciblXjMimiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mF93TkWuYux2W87w+kwlw4QuLBj8EMTJPggXlyvMwJU0djyggAbh2BazyKuhSc/O5EsLIP7NLcLqIQZAbBZfWmUKeZX9NvQ/AB5etD1vZZHsnnbwfRAXCyJfq6yvZt0a6iK8cCy86+lGAYNtaFB4CXmvgXhSdekSpESC32i5PAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVXYSFgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8C9C4CED7;
	Fri, 13 Dec 2024 11:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734089205;
	bh=2ZWKisQ+EEB8m0h3GAkTv+JQi+wBMeB7ciblXjMimiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bVXYSFgHoO6t7rLpP6A6u2dYAlhDxrMCikGN5orngiMgrhHut+o1EJ0jmXdrHDWtx
	 lSagyW6vbzbaNRgJJZWQBmUFq79CM9u9W3E5BLzZ5nJgpEH0Pjmh82YLpoEfhh31JB
	 C+gVhj6N9isYQxuUOC6RgtykYIggJSIjVKBpQX+Hgbxy8eRXVv70ZwqGFBExs1ofYz
	 uQEKJplvDt9jDpJPvTZg/zO22TtOzeKil0eG5H2Rv3OlUSuubeP3685iVFPDYmfV+T
	 oHnDGf0T6EeV7UWJ9Dc+pOlS9YQxKkyFLiguQvREPUbhll/Jw2ie0GacqZilNRPSH6
	 JxqYDEXoUg/Mw==
Date: Fri, 13 Dec 2024 11:26:41 +0000
From: Simon Horman <horms@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next] ethernet: Make OA_TC6 config symbol invisible
Message-ID: <20241213112641.GM2110@kernel.org>
References: <3b600550745af10ab7d7c3526353931c1d39f641.1733994552.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b600550745af10ab7d7c3526353931c1d39f641.1733994552.git.geert+renesas@glider.be>

On Thu, Dec 12, 2024 at 10:11:43AM +0100, Geert Uytterhoeven wrote:
> Commit aa58bec064ab1622 ("net: ethernet: oa_tc6: implement register
> write operation") introduced a library that implements the OPEN Alliance
> TC6 10BASE-T1x MAC-PHY Serial Interface protocol for supporting
> 10BASE-T1x MAC-PHYs.
> 
> There is no need to ask the user about enabling this library, as all
> drivers that use it select the OA_TC6 symbol.  Hence make the symbol
> invisible, unless when compile-testing.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Target at net-next instead on net, as suggested by Simon,
>   - Replace Fixes-tag by description, as suggested by Simon.

Reviewed-by: Simon Horman <horms@kernel.org>


