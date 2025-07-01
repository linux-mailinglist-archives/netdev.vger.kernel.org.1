Return-Path: <netdev+bounces-202918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECCFAEFAC8
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E814E1AA1
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32349277CB2;
	Tue,  1 Jul 2025 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXte49Oe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3CE277CAF
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376593; cv=none; b=iL7J5UfK2Tf7KsN+7VNxzNnA8GoB5EzR44ZE1UYjG2eJRVnlLPxvgYnF8g4jDnixshUZOHsAwaKFhK4kvFpA4xHuf0x7uTITYBtFJrHwBMzgqK2c6c2jcnVIhfMXRoL1KiPadCBdTnaZ1xkEwKS93/0LP8WBo4gocnQZe7SRvk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376593; c=relaxed/simple;
	bh=cxyqQluJxNNqQlQCzaNlVcNNepmsuZRdBJDbi9dx7ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7S4UMZP08zSC7vS5y5UCbcAcX8E/s6/VgtUax9ct4jCZXWcIoA3N+P2cXk9lj6ymbs09IJT9+B4iRuPaKaX9Jqtf9mirXMmHdHf2dMBcqsAfM+PtGTCui+sOPFoaA6U4aMJS0YsUtfe6tSiKBYVWXcHYu9jzr5fJhzuAVCFXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXte49Oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3252BC4CEED;
	Tue,  1 Jul 2025 13:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751376592;
	bh=cxyqQluJxNNqQlQCzaNlVcNNepmsuZRdBJDbi9dx7ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pXte49OevGDkwA1K5vTyctpNBIerUXIpCYsGAzsVTqP8Ihz55xlJdzKYXhZ0RNSsH
	 uvL8l2GYrmuRLeHykhqTdd3ddTjoP9XR2XWvTnw85giP3mQIqJ8WZFNkUWwn9IHpw5
	 /w0cAZYDlE6oSVuciHjulU7arle8g65nDy/VL7fJ7xkS8DqeYHNyOqkOMLkA6u/71D
	 mL6mtq10aRRYh6k+lLPzvgURkINVjBfXB6v/3iYYLFBoY3I38UgTWsOG/8G7MG2tHy
	 5vgncMwS+tizAyD3AfbzeJ3+QxQnEFSqmHoYLrXgDX9gsjeYyXgNbC/zaT1jsIJ011
	 XZUN06Ialai+A==
Date: Tue, 1 Jul 2025 14:29:48 +0100
From: Simon Horman <horms@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Loktionov <Alexander.Loktionov@aquantia.com>,
	David VomLehn <vomlehn@texas.net>,
	Dmitry Bezrukov <Dmitry.Bezrukov@aquantia.com>,
	Pavel Belous <Pavel.Belous@aquantia.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] net: atlantic: Rename PCI driver struct to
 end in _driver
Message-ID: <20250701132948.GS41770@horms.kernel.org>
References: <20250630164406.57589-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250630164406.57589-2-u.kleine-koenig@baylibre.com>

On Mon, Jun 30, 2025 at 06:44:07PM +0200, Uwe Kleine-König wrote:
> This is not only a cosmetic change because the section mismatch checks
> (implemented in scripts/mod/modpost.c) also depend on the object's name
> and for drivers the checks are stricter than for ops.
> 
> However aq_pci_driver also passes the stricter checks just fine, so no
> further changes needed.
> 
> The cheating^Wmisleading name was introduced in commit 97bde5c4f909
> ("net: ethernet: aquantia: Support for NIC-specific code")
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
> Changes since implicit v1 (available at
> https://lore.kernel.org/netdev/20250627094642.1923993-2-u.kleine-koenig@baylibre.com):
> 
>  - Improve commit log to explain in more detail the check
>  - Mention the introducing commit in prose and not in a Fixes: line
>  - trivially rebase to a newer next tag
>  - explicitly mark for net-next in the Subject line

Thanks for your patience and making these updates.

Reviewed-by: Simon Horman <horms@kernel.org>

