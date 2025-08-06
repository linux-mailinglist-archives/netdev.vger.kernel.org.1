Return-Path: <netdev+bounces-211856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EFEB1BF04
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 05:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4663E1888475
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 03:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0184A190676;
	Wed,  6 Aug 2025 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="iAwn0t0i"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4289A2E3718;
	Wed,  6 Aug 2025 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449548; cv=none; b=IipRCiby/1cwadlnMfBjX0UK1Mth4BD+LYV7aVbRInBNDRu6U06J0Afvpimmfd1pJJ6WN+pipDkLlkzXInbFuvxUL7rWbxy4qlltwayugD93fVCQdPmyoz87ttjbvPJqcyI3caQOxdnihD1edXGb+xtHd4iAZLSMAYqlH/h0bLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449548; c=relaxed/simple;
	bh=N/zOvjBqKESD7r48tT7sB0c0pTptIFUp4F/avtfGWho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDkIVf3y/wVJ0i6TysNyTf2T7cwV9THp/zEwWuwYb7aKgYX4sgHda71yBLTWih2bhdGd538k5TXUuezoNZFJeMY5eE4el/oIukc7D5zEqo7Tpvo9Sqd8/DknEcipllDsmuV1LzWADef5Im5fMaga/Tf9PJJeyFw5OgNzNETVF1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=iAwn0t0i; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A08E325D80;
	Wed,  6 Aug 2025 05:05:45 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YuG87osi2Cgz; Wed,  6 Aug 2025 05:05:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754449545; bh=N/zOvjBqKESD7r48tT7sB0c0pTptIFUp4F/avtfGWho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iAwn0t0iJnRWyP/ihfobwuarrYwO2EUspOYUMuYMGwREaOXY/pyQMKn8DsSQdELfD
	 SkNthXwDvifmNnp9j0urPDmxR/8aCuuw602P+hyu8wozhOirVYY/V5a0e64W66ral3
	 HgZs7TfXBPbUtochyMqNwCHHULB0vcbwDFR1sjMCPjl5ZR0lcC/NB2Q6KRN7Eu+F/h
	 lPCdvqBl3/ROtqWJR0UHYbLUYK47CJH1W32ywAq7khiRRt5BoD/8iCIhmLC3XIvCqn
	 gGSBok+P9kS/FPozMXSqyrrgCmQm3zuzDnDtn/xHA0DDlrm6Y2zAcfOAJHYoS3M8Av
	 j+GeS0n9rvJVg==
Date: Wed, 6 Aug 2025 03:05:33 +0000
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] dt-bindings: net: thead,th1520-gmac: Describe
 APB interface clock
Message-ID: <aJLGfQaPqeEsX8AX@pie>
References: <20250801091240.46114-1-ziyao@disroot.org>
 <20250801091240.46114-2-ziyao@disroot.org>
 <20250805-portable-jasmine-marmoset-e34026@kuoka>
 <aJI4WiigJFoYPXU1@x1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJI4WiigJFoYPXU1@x1>

On Tue, Aug 05, 2025 at 09:59:06AM -0700, Drew Fustini wrote:
> On Tue, Aug 05, 2025 at 08:39:59AM +0200, Krzysztof Kozlowski wrote:
> > On Fri, Aug 01, 2025 at 09:12:38AM +0000, Yao Zi wrote:
> > > Besides ones for GMAC core and peripheral registers, the TH1520 GMAC
> > > requires one more clock for configuring APB glue registers. Describe
> > > it in the binding.
> > > 
> > > Fixes: f920ce04c399 ("dt-bindings: net: Add T-HEAD dwmac support")
> > > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > > Tested-by: Drew Fustini <fustini@kernel.org>
> > 
> > You cannoy really test the binding, except part of build process and we
> > do not consider building something equal to testing.
> 
> Good point. I've since provided my Reviewed-by: in this v2 thread so the
> Tested-by: should be dropped if there or is another series or when
> applying this v2.

I'll send v3 of this series soon, dropping the Tested-by and adding
Krzysztof's Acked-by tag. Thanks for the guidance!

> Thanks,
> Drew

Best regards,
Yao Zi

