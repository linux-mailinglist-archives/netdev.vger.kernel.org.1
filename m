Return-Path: <netdev+bounces-216720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B45DB34FFF
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188771B2553A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 00:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAA3482EB;
	Tue, 26 Aug 2025 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRper9K3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532B39FD9;
	Tue, 26 Aug 2025 00:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167053; cv=none; b=J8lvstvkY1CcslSjeJiiwvIxCMORIg25B9QzGAVg0qvRtF91tb1hBN/098R+cboc26KwMy4M2QlfyVGKvaef4HYZ/G6CIiSVXG+FrV/Ql2FCNKsMaaN5L4aX9gvse3zs9er0SbTejvv1mGZD9b+wTYCglsojleYFgeX1S4Edae4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167053; c=relaxed/simple;
	bh=2nvgMWEBcRoHjbA0LvUctkIE9xi1xgdfkDXBknxcz1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfOWb2Xw3XKWMdumg6khH5G40OCcKuqa0QhdzhqnPnLGEU7I9DaOSNvpkF4AqaQDwR4bwb5Cc9L3yIJIdDKJV0+9xRRgrp35CzNGDQ1VHV2qMd5lnVLblq72uUg5CB7vXCaeTib051w3HoI2CKFbcR0tQmqRP3w0boeUX1gH+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRper9K3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4E0C4CEED;
	Tue, 26 Aug 2025 00:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756167052;
	bh=2nvgMWEBcRoHjbA0LvUctkIE9xi1xgdfkDXBknxcz1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lRper9K3rv+dMkHJbvaIUY/hPpQ7YptgaAOf8LKoPZso6EDpTy3yxSNztaNXWR8FD
	 M12+tnnPhfAYWB4B5KjE2IT190PHwhBxrPxMgn20nl2KSPCYBshIfgWc56Lk/xUxhB
	 QSPKcN50sCBhGWR9iPqKTaqVp+ZF+k1nIEgILwEFMnYR9cqX3FTvigFHp9/Ql6HYMW
	 7HuYCjjaxWEqD6xdsjTAaJfNydlNzWAjc7E9kz4KjeFUatU8ElfkAeMaWcmPQr8jfG
	 /JAM31LMZAZ133pLwC3QEMR67aHCrfnIva7kKUhjbq1s467vlQ34Vq+QDyGBYXBG+u
	 A41RpJ/sd3r/A==
Date: Mon, 25 Aug 2025 17:10:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Xu Liang <lxu@maxlinear.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] net: phy: mxl-86110: add basic support for
 led_brightness_set op
Message-ID: <20250825171051.1fd1806d@kernel.org>
In-Reply-To: <58eeefc8c24e06cd2110d3cefbd4236b1a4f44a2.1755884175.git.daniel@makrotopia.org>
References: <58eeefc8c24e06cd2110d3cefbd4236b1a4f44a2.1755884175.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 18:38:27 +0100 Daniel Golle wrote:
> +static int mxl86110_modify_extended_reg(struct phy_device *phydev,
> +					u16 regnum, u16 mask, u16 set)

For the future patches -- the names of register write helpers are
unnecessarily long in this driver. They make us go over 80 chars
for no good reason.

