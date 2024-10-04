Return-Path: <netdev+bounces-132162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037609909B7
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71EF2B21627
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F0C1CACD6;
	Fri,  4 Oct 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrIfdnSX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B264CDEC;
	Fri,  4 Oct 2024 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060845; cv=none; b=ljMvvFQHrMkeJUE/49apmqP9wtbLJkguNGDEj618q9Dy5d13+GWhcomL8bwbzlt3JJFle8z8Vt4RTdpYMSXlBkMIFDa3Iv/5Aahmhcv+CMvJoJwe2yo8YGUaTcCM+SK9CvAKkWD3pV3Bqay1p48HLO4bNh7Ypx5rQ9is9YU02iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060845; c=relaxed/simple;
	bh=iurMIIOVs0Th0Z6Z1T/KALAKx3P3ouO/bs1pjgQbhAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dntmr8KJO6KklLIR0HNIVHbAm40mPYXKGaro27UO1nAMclgyUmASVmUSf1aPrgsJSoYKZ0YWWctjkMtjqa2+Rff8Mpve+uDC4K78+ja64bCgKd1xsUuyH4xl9JWDSXd2swuZ9GhRHqSa7xdIKMoAJfsVQD3BO9Vl9JnK4y4OIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrIfdnSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7015EC4CEC6;
	Fri,  4 Oct 2024 16:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728060844;
	bh=iurMIIOVs0Th0Z6Z1T/KALAKx3P3ouO/bs1pjgQbhAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mrIfdnSXywnsRIijQUjNiP81fDRvrs+J6vR3Bpbu2dF9BZ9duFkWPJfewHfIOi8+o
	 0LyHAtg+GLTidwfDb7XGD6qr2ifacnBJNix5HOiTQR0FDgnqG8NTSL1+WCHj4ivj71
	 ZFu/VTmtnDdQX7LA2OO8vKqgCooSj+3Yk7U0PE+aGKeS9eToXNPFdEnFGHlrHAyS55
	 FxrmTJCAyj47UHVXDxhtYnklyaaBNGZDsxnVbjpOKC3c/EgB4+YWnBF/UNoIFnXDQU
	 LZT6un+BHAS+oWtDPGogqaNVnaDtAQZN5g9hvC2K6RiCOB7BDZ2xV0J6wbGhY0IS+T
	 hSnRt8XaBAoWg==
Date: Fri, 4 Oct 2024 09:54:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Christian Marangi <ansuelsmth@gmail.com>, Tim
 Harvey <tharvey@gateworks.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: dsa: mv88e6xxx: Support LED control
Message-ID: <20241004095403.1ce4e3b3@kernel.org>
In-Reply-To: <20241001-mv88e6xxx-leds-v4-1-cc11c4f49b18@linaro.org>
References: <20241001-mv88e6xxx-leds-v4-1-cc11c4f49b18@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Oct 2024 11:27:21 +0200 Linus Walleij wrote:
> This adds control over the hardware LEDs in the Marvell
> MV88E6xxx DSA switch and enables it for MV88E6352.

Hi Andrew, looks good now?

