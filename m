Return-Path: <netdev+bounces-149920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FDE9E8224
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 21:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 676E218842D2
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 20:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2ED1547C8;
	Sat,  7 Dec 2024 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xN+prU3T"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F05614A4C7
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733605136; cv=none; b=iBOqGNMKsSTb60ayYAGnpQtfGPc0yc85sfV96X2ETywbLMO3JsBJGAU+/GagEFmOz3o5S599eIVq4x8cDQSs/Ze4K9OlbMQ5BYxWw4YA8ceHADZaH1TzMhUTdvKS/QI6oqan8VpOJVOr6ewE+Jm42hPoVwDIL0/hrdGvWE5HSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733605136; c=relaxed/simple;
	bh=rciwtYQY+x63l+55XRKtL1FtnUzI6nWzPS4Or9UOSEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IF3DhKlpMr04VtxzmKp68lpjdJQxFxRtIo30ve/o5uh6zLsxg5mofKqgiivP//iI/2ORCE8EFdMlhwpAvqtJggVmFw9tKahoYPQmO7E8HDE59r0au6TAG602UwCgeqXA3kYiEI8+I+MRGq60CAQNFyFD1K4B25tsZG/RQksD31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xN+prU3T; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=lIhXs6yCbLlsLP0p2PsU7ZNtz0quwmmK25e3wWUBEic=; b=xN
	+prU3TgZnLe6Y66EBb2bzoflEmvSXG9PTAurKC7yRaKLpYiFbSJYK7N96I0p6AGKVkQKiutE/5YN+
	PEOYVmT/3psFwPX6LHmLejXS9PuHA4EYJhTvwtjSNCTv70VQ927UV/yuGqVsKjnas7qNHmqg2w4/Q
	FEGWGwMG40KqVtM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tK1t6-00FVPv-6N; Sat, 07 Dec 2024 21:58:52 +0100
Date: Sat, 7 Dec 2024 21:58:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@jo-so.de>
Cc: netdev@vger.kernel.org
Subject: Re: KSZ8795 fixes for v5.15
Message-ID: <9e0efd14-ea5c-459f-a70c-b34e61bc47b1@lunn.ch>
References: <uz5k4wl4fka3rxoz2tkvpogiwblokbpo72p3sdjdbakwgfbwfi@bzxazuhkhbps>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <uz5k4wl4fka3rxoz2tkvpogiwblokbpo72p3sdjdbakwgfbwfi@bzxazuhkhbps>

On Sat, Dec 07, 2024 at 09:44:46AM +0100, Jörg Sommer wrote:
> Hi,
> 
> it's me again with the KSZ8795 connected to TI_DAVINCI_EMAC. It works on
> v5.10.227 and now, I try to get this working on v5.15 (and then later
> versions). I found this patch [1] in the Microchip forum [2]. Someone put it
> together to make this chip work with v5.15. I applies fine on v5.15.173 and
> gets me to a point where the kernel detects the chip during boot. (It still
> doesn't work, but it's better with this patch than without.)
> 
> [1] https://forum.microchip.com/sfc/servlet.shepherd/document/download/0693l00000XiIt9AAF
> [2] https://forum.microchip.com/s/topic/a5C3l000000MfQkEAK/t388621
> 
> The driver code was restructured in 9f73e1 which contained some mistakes.
> These were fixed later with 4bdf79 (which is part of the patch), but was not
> backported to v5.15 as a grep shows:
> 
> $ git grep STATIC_MAC_TABLE_OVERRIDE'.*2[26]' v5.15.173
> v5.15.173:drivers/net/dsa/microchip/ksz8795.c:55:       [STATIC_MAC_TABLE_OVERRIDE]     = BIT(26),
> $ git grep STATIC_MAC_TABLE_OVERRIDE'.*2[26]' v6.6.62
> v6.6.62:drivers/net/dsa/microchip/ksz_common.c:334:     [STATIC_MAC_TABLE_OVERRIDE]     = BIT(22),
> 
> Can someone review this patch and apply it to the v5.15 branch?

Hi Jörg

Please see:

https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Option 2.

       Andrew

