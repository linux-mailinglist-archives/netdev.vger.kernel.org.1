Return-Path: <netdev+bounces-76914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A7186F653
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 18:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C431C20979
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 17:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02F87603C;
	Sun,  3 Mar 2024 17:03:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9B41A80;
	Sun,  3 Mar 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709485420; cv=none; b=E8lL/fGWaoOUoNugEFbn+kucrprnOiPBOdOnXIHJ0t6/GHjQysD5Y9JK/uRI3raggy2N9bQxUGuR5nV7Xe+RGzVJSsGZweTsg9RNbnnEjHZ3e7BJ4vbNrFloDWmZQXi1+ToyFdQkmwceIMcW286mHBbFdAsQk6S6ch4582B6UGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709485420; c=relaxed/simple;
	bh=VUws4B8KxC6iqq7l6ZrU1SlkYalVDKAq9rQpX9xceU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFSuHQ8TjALtGoqt33p/bPEOoFdAKcx2RCubAutp4R4OsXVs+gUZqyys2JfMPqrLRQjZ44Q30ZkEx4WR7f6Tc+QJrQwdzVaBz7n6Qy5+xT4eNSUTqWotTVoq+JCqXkFWCtDUTasVRzAXxS3+ItfBPR0sXrKM6/5a6gJuJSsS2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1rgpFA-00066g-29;
	Sun, 03 Mar 2024 17:03:20 +0000
Date: Sun, 3 Mar 2024 17:03:16 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Eric Woudstra <ericwouds@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Message-ID: <ZeStVG-GI0V-cYHK@makrotopia.org>
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
 <ZePicFOrsr5wTE_n@makrotopia.org>
 <d29b171b-c03a-44db-8e0d-15f9bd35c4b5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d29b171b-c03a-44db-8e0d-15f9bd35c4b5@lunn.ch>

On Sun, Mar 03, 2024 at 05:47:24PM +0100, Andrew Lunn wrote:
> > > +/* u32 (DWORD) component macros */
> > > +#define LOWORD(d) ((u16)(u32)(d))
> > > +#define HIWORD(d) ((u16)(((u32)(d)) >> 16))
> > 
> > You could use the existing macros in wordpart.h instead.
> 
> I was also asking myself the question, is there a standard set of
> macros for this.
> 
> But
> 
> ~/linux$ find . -name word*.h
> ./tools/testing/selftests/powerpc/primitives/word-at-a-time.h
> ./include/asm-generic/word-at-a-time.h
> ./arch/arm64/include/asm/word-at-a-time.h
> ./arch/powerpc/include/asm/word-at-a-time.h
> ./arch/s390/include/asm/word-at-a-time.h
> ./arch/xtensa/include/generated/asm/word-at-a-time.h
> ./arch/riscv/include/asm/word-at-a-time.h
> ./arch/arc/include/generated/asm/word-at-a-time.h
> ./arch/arm/include/asm/word-at-a-time.h
> ./arch/sh/include/asm/word-at-a-time.h
> ./arch/alpha/include/asm/word-at-a-time.h
> ./arch/x86/include/asm/word-at-a-time.h
> 
> No wordpart.h

It's very new:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/include/linux/wordpart.h


