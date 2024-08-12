Return-Path: <netdev+bounces-117688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A3294ED0E
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93725282D29
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1DD17A594;
	Mon, 12 Aug 2024 12:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RrgLxgN0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0DD178CE7
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465889; cv=none; b=bGa7i9tPqtlpIBq+qqZHgtivjL6fv+YlMZcoHYDhh3pwkJAq3TLewsaY6J/CkhcFgLPpu/5rUt3j8L8miyvYydG+pqA54HVFGUvJDi8YaD32RJNf+Q1qHSyP8/eqZerh49+lqvbohbzYCIwUgKImagxoGHZBLw5mrhuQf2av7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465889; c=relaxed/simple;
	bh=8NTe93kqcwHHqti0IU2af3LlmwUehNMknLq/0ypmLYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVL5peAbGjby+pKvTNrfr1aiD2PbJ+S09yik+rmFl4xz5RjhShG+I+pGxJSMXpkOUzwAAzX8Rttw+pScxdYymtkF70+3jkn9cmlCW990Qj6c/NEeEQX2SzXfxiiI+jDzdIZASvHxl0Mx2In6sIAca+zORk9bUpk5saeM1hzWJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RrgLxgN0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eIm67ftMucS8bkO6GSK0z/e/jMB6EDZfHBlQej9UMoU=; b=RrgLxgN0B2vw/dAp6ftH8raxyv
	d4b6Du20tdK4Lm/a/S+8zGm/enhJuL7IwgiylPrf4A417AId4E0hd6QS/PZttKL9NTFSFusUekYWV
	Lzo9g7WgOT+1oQWyoKyFwHW2Wl7n9EnFgjFOmdcBlWfTlSfiJK7bn3VayAFvmGNoGKww=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdUCq-004Zhj-7K; Mon, 12 Aug 2024 14:31:24 +0200
Date: Mon, 12 Aug 2024 14:31:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	kuba@kernel.org, Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com, horms@kernel.org
Subject: Re: [PATCH v3 net-next] net: dsa: microchip: ksz9477: split
 half-duplex monitoring function
Message-ID: <036a0488-678f-4a66-be57-c2dffb0ab1bd@lunn.ch>
References: <20240812080212.26558-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812080212.26558-1-enguerrand.de-ribaucourt@savoirfairelinux.com>

On Mon, Aug 12, 2024 at 08:02:13AM +0000, Enguerrand de Ribaucourt wrote:
> In order to respect the 80 columns limit, split the half-duplex
> monitoring function in two.
> 
> This is just a styling change, no functional change.
> 
> Signed-off-by: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

I think davem merged v2 just before i commented.

It would be nice if you sent a followup patch which unwraps the URL.

	Andrew

