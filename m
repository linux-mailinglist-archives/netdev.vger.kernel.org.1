Return-Path: <netdev+bounces-244321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D703DCB4C2F
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 06:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A08730111A9
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 05:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BC220C48A;
	Thu, 11 Dec 2025 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T203esBN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B34B17555;
	Thu, 11 Dec 2025 05:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765430814; cv=none; b=HbiXdZcdnPXbR5UpKdXNC0V4dl4nT8KTPI0o02y+0UgJJVi/DdnQQHiX4pIuXPEiu/A3nEw/FanNiHE49sCjxn9tHMqJOUwv7oBxKK+kDRcGqthIb93gjCO8CPD3+c7NHozko5ur4o8z8P9sP3PiCAPJAM5wB69SJ5EsL398+cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765430814; c=relaxed/simple;
	bh=JfiVLZzDbMu81FCDfELxXxRKa/eCGvjPeVTUrMNbiJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ED921cq+ns0lVHdg9MKfQip3/xaPh6MYAr4idPJ+4PQC7kdDzDaBLg8S7uzGQZlqldjpybPNH49Wx4lLoO6JYkuS8UaY+V7vWMlvaP1aJwCYH9i5PaAosS3Tsvm7NHu9hCGdjD2ZBUDBx8lq96e/xVE85iBwj3MIBgYvuh3zF+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T203esBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4FAC4CEFB;
	Thu, 11 Dec 2025 05:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765430814;
	bh=JfiVLZzDbMu81FCDfELxXxRKa/eCGvjPeVTUrMNbiJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T203esBNf/aoCuL6CSMYGbTY85xBAx4rKZ+/jAAdMDlQ4st6p72YkgEmyg8LiCGZj
	 grBWTyZwa5xVr34fEMeSjI72coazpFIBoYAxTVWolvWL61Mxvx4ghoc0AMU+0k6jZA
	 PPfSmKH65dI+9d8wOOKtQ+jEbJzuROwBp7p6GIes6nEmfPskNa6EDJMS/p27urBF0Q
	 FdhBtadJKU7rqvYYfZGB2o0byvSTDr8nrt0D3cn/xTxvhcfNtOJebR9NuW+L6LeSNX
	 ge9QT8WCx9v1a6h/RKA+dS1ibBhhthw2BmCcZxOxeVCtdZUGUd8zcs421lMYfbSbNh
	 ZQdvDU2CndKKA==
Date: Thu, 11 Dec 2025 14:26:46 +0900
From: Jakub Kicinski <kuba@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Crt Mori <cmo@melexis.com>, Richard Genoud
 <richard.genoud@bootlin.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Luo Jie <quic_luoj@quicinc.com>, Peter
 Zijlstra <peterz@infradead.org>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Simon Horman <simon.horman@netronome.com>, Mika
 Westerberg <mika.westerberg@linux.intel.com>, Andreas Noever
 <andreas.noever@gmail.com>, Yehezkel Bernat <YehezkelShB@gmail.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH 8/9] bitfield: Add comment block for the host/fixed
 endian functions
Message-ID: <20251211142646.17642a46@kernel.org>
In-Reply-To: <20251210100846.04e59dcf@pumpkin>
References: <20251209100313.2867-1-david.laight.linux@gmail.com>
	<20251209100313.2867-9-david.laight.linux@gmail.com>
	<20251210182300.3fabcf74@kernel.org>
	<20251210100846.04e59dcf@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Dec 2025 10:08:46 +0000 David Laight wrote:
> > possibly also add declarations for these? So that ctags and co. sees
> > them?  
> 
> The functions are bulk-generated using a #define, ctags is never going to
> find definitions.

I know. That's why I said declarations. But for code completions etc
decl is enough.

