Return-Path: <netdev+bounces-221947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2D5B52666
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 04:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0A21C2549F
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 02:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F972080C1;
	Thu, 11 Sep 2025 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjunBDWs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB8F1FE47B
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757557249; cv=none; b=UsOSI4ma7pCAO9ZbB923j40Hsr+nrmndYyFD3Kd/nexyqIkWITK84VvXYftHb7SMEwlJotIjrxPgbL8wmFoiuFfBSziud3Ti9+LXJMyIIQSrGRPxA5N3I8Weu3SJAOkijGSapmBLcPNAxAm3uy4ZkgdKspVkkTCH7TviBNc5rKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757557249; c=relaxed/simple;
	bh=y4LGsIt6DW1EPHVwyRegVZy7VlOB2lVS708kYtqKdIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uS3rdl8oEUsh4VkUQ8dupayOOz2JwvAU4zGDu07uYtA3V4BlLq3LqZqxaiWAAyYiK4q45m9bu3gplSHdG4/0dQkmBS2Q7cyrhUsSzG8VDPz7/FPuhuf9zICKhjwEXLrRTSMLxSDs3aLWu0eh2qj+QkV6+4LuQ0x1hpvlxBX9Nho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjunBDWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB247C4CEEB;
	Thu, 11 Sep 2025 02:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757557248;
	bh=y4LGsIt6DW1EPHVwyRegVZy7VlOB2lVS708kYtqKdIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XjunBDWstfFX6ceAWcCmGJb0fPDNuWQVYFQXp8VG4ynZHTqr48BQAgHP+9S7JS57E
	 FGWCUIfM2UioYKYWkyjBtVq56lckPWDrXn/Eu+snF5ezIVxAkLeUoFkLdQoGWSkbAh
	 Jlb+ugFByPrnssoA8cQbxCD+ltcHvlC/QCC3HkYb+XXwhRwBPMI1xP3SoUrv4H+G23
	 nfuC9YE3qa+fD/8ZywumSi1tzo8+y4HrxuHsxqcD+obIpb6dv2mj4EoPIKucAzmyMx
	 sxyJVBeJZv0O9syWCHY/RYerzu181TOMUo6IPxyUWBEKHuqLG5pgj6EaxR/TSES9+W
	 X/RVGTf5ck2IQ==
Date: Wed, 10 Sep 2025 19:20:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net 0/4] wireguard fixes for 6.17-rc6
Message-ID: <20250910192048.75941267@kernel.org>
In-Reply-To: <20250910013644.4153708-1-Jason@zx2c4.com>
References: <20250910013644.4153708-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 03:36:40 +0200 Jason A. Donenfeld wrote:
> 1) A general simplification to the way wireguard chooses the next
>    available cpu, by making use of cpumask_nth(), and covering an edge
>    case.
> 
> 2) A cleanup to the selftests kconfig.
> 
> 3) A fix to the selftests kconfig so that it actually runs again.

These don't really seem 6.17-worthy TBH.
Do you care deeply or can we push these to -next?

