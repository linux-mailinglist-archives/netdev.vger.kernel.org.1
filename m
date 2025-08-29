Return-Path: <netdev+bounces-218369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59350B3C3BE
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 22:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE89D7B2C65
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 20:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B210326D7C;
	Fri, 29 Aug 2025 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WGeAQZy/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306C1257AFB;
	Fri, 29 Aug 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756499051; cv=none; b=ZHqm0GEaxYHgMycm1DjmOFvkAlZ70I0CL19KJUOC+Fpw7u0W6TsFscRA7cj2vHsVuXJ0T7WUjsKrJ1CIyPtraLzaqJ6pAgxaaMjPGKFAal0K/rjQIMBYfS2uuvJ/YPe7VqdXPg7N1AeOlQc05XWS5R63O4D5/Rnzxr+BWjxKDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756499051; c=relaxed/simple;
	bh=yi+ZJVWGcWjlJIli+hY7OokPuHAffYBSEZfUcWfDxtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cfI2fc5OjERd9lv63qI2LfI+kEqMdmwTkCIhLaiTQSwe1NM/Daj4+Ir1/1b+VZKtMiDRWJbTGtKrtErqpJFyQDcpQdCWSVt/igQwhxM4JBH9eULZiWMaVFVZ9s/H0AKefulTBZoUlGxbDgKi4k6ECUfF7xPBCd8fG9Zp/vvo8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WGeAQZy/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3qMnwKU+PAnsDGVKpWJp849y111qs9Ha8vvt9znvheE=; b=WGeAQZy/fQonRCmPk3uOUlUZxa
	kreDZZyJHmGnkXOiQVLkx3IMLbhFZyUOQUXtgytqElM9uKx23NbsUTzI2s/zbVANEbzm08SxlWV7E
	RApQRuDLAYE/ezBnnhWHc7kfl1EzlPRZI6kSRezVpLxs8BUzK71Wc7lY+RpfLwaeAErQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1us5dm-006WNw-Kt; Fri, 29 Aug 2025 22:24:06 +0200
Date: Fri, 29 Aug 2025 22:24:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jack Ping CHNG <jchng@maxlinear.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, davem@davemloft.net,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, yzhu@maxlinear.com,
	sureshnagaraj@maxlinear.com
Subject: Re: [PATCH net-next v3 2/2] net: maxlinear: Add support for MxL LGM
 SoC
Message-ID: <65771930-d023-49e1-87a7-e8c231e20014@lunn.ch>
References: <20250829124843.881786-1-jchng@maxlinear.com>
 <20250829124843.881786-3-jchng@maxlinear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829124843.881786-3-jchng@maxlinear.com>

> +This document describes the Linux driver for the MaxLinear Network Processor
> +(NP), a high-performance controller supporting multiple MACs and
> +advanced packet processing capabilities.
> +
> +The MaxLinear Network processor integrates programmable hardware accelerators
> +for tasks such as Layer 2, 3, 4 forwarding, flow steering, and traffic shaping.

By L2 and L3, do you mean this device can bridge and route frames
between ports? So it is actually a switch?

	Andrew

