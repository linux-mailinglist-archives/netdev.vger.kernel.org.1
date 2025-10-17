Return-Path: <netdev+bounces-230593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C435BEBB66
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B871AE2251
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE46233155;
	Fri, 17 Oct 2025 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NFA9eQCf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55AD354AC1
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 20:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760733801; cv=none; b=ZImjVEHfFaYD1DvZkwcCJYw8eZPPudjURygwk0NiMz3Sg5LTdfWF1QVutANSt7PTkUrT6l6EMgBxIRWNTJ5FZv7QBexPk2cFAIkQyrPJ1HatVpValaH5DW3EuoGKxTp9XWlsJ5zpBRSZI6U+ZBUA99iRiK6K165VOwRWbZsZQGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760733801; c=relaxed/simple;
	bh=ZGieWUKEoPrg5JVOSIEF3tMHlOUM+hodV9Ycu5Aa/mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoE0a9n1uEV4+33N9/oHs4mbt7+uLBb2VQ6DelEnByGfT1BBseQA5KccNNmtsbY0S6Iaga8CWTSPpdde6rLZEbC1O7wBvMJjt6VD8Y68VDYc5DkOxdn4C/P5ZLuWfBCIhEOmVLgmXPrvCww5kM/lq0iWZeWnQi0pWMONecfYQy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NFA9eQCf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g7ZTpipc2oIw0ciZ3NBuRFR6Z+WK+DS1IXgceIEhbD8=; b=NFA9eQCfEsPhlQIrKncBfr1Wrx
	aOfnRDzU4ud2wcK/mmV9J8303HMd58FJscrGXGYO99jSLXbcIwi2B3N3lM01tiS/Wp4qtI6FC+gSf
	6X+v8IbZWyOFTfq7AKu0Dz74F3vffD/gXNUX2wq7ZwZ3GtNvX3xRQIGbcqbZ0HVEzlRg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9rI6-00BKKx-HN; Fri, 17 Oct 2025 22:43:10 +0200
Date: Fri, 17 Oct 2025 22:43:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: hkallweit1@gmail.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH net-next 2/2] net: phy: micrel: fix typos in comments
Message-ID: <71d62125-6ad6-4df5-8bcc-cbde86da8549@lunn.ch>
References: <20251017193525.1457064-1-alok.a.tiwari@oracle.com>
 <20251017193525.1457064-2-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017193525.1457064-2-alok.a.tiwari@oracle.com>

On Fri, Oct 17, 2025 at 12:35:21PM -0700, Alok Tiwari wrote:
> Fix several spelling and grammatical errors in comments across
> micrel PHY drivers. Corrections include:
> - "dealy" -> "delay"
> - "autonegotation" -> "autonegotiation"
> - "recheas" -> "reaches"
> - "one" -> "on"
> - "improvenent" -> "improvement"
> - "intput" -> "input"
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

