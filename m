Return-Path: <netdev+bounces-117507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9079794E23D
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F3B28112C
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA7A14B950;
	Sun, 11 Aug 2024 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CqLOOs0Q"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FB8C8E9
	for <netdev@vger.kernel.org>; Sun, 11 Aug 2024 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723393326; cv=none; b=sY5EJm8Tz2OzJ5596ZeOchy4XqF6qAwSKW07AgvYg57EbKF5QAqyLSsK3znjuWQVBeNUm9QgzKqFHM3SY4/uaB3KpaXUHkEnGJZRARBjfv59YTNCjjrRfvKLLC6SquMYo5e7vYnw7wzulaCQMvjsEJoipzpOSP2Re+AKD6heniU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723393326; c=relaxed/simple;
	bh=BVPqU00/FL0CJ+/6ekr1FAxLTOVi744gvqcFgpIy7e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+SsUF5NMtw5a+QLUcxZ71UaSQq2NmQ4hLgeBzC3ZMtqjXBayUxoEtHhO4HxBK/uyVfY7iN+gKopj3oM4qiZoDoNypg65J7aDIA6w5tag61eWvSk5nWW2CielQYg2z3SjF2y/RFn2tPuLEbBZ1UYfeQG6G4QKFe4ohA1scTzWPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CqLOOs0Q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8wG9AYa+8Ux4yfE0QiQnPT8Atv0QDOt+Qzb/1c9XJiY=; b=CqLOOs0Q/Ive7N3wD8G6DcIGuO
	sU+4nmVJPzJHNa+IU9yXoictnC6rYSmTYJVlH4kG70WQiz2ddAUWymAQxANNUmmkzvI88YmpLxAIm
	Hu8xKKvivmbxsBQwsv+FIpwnrXk5jMg7yNyAKbP8MBe4oqium638EalJ5NtF/FH3l54s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sdBKV-004Vf7-4C; Sun, 11 Aug 2024 18:22:03 +0200
Date: Sun, 11 Aug 2024 18:22:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Enguerrand de Ribaucourt <enguerrand.de-ribaucourt@savoirfairelinux.com>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
	kuba@kernel.org, Tristram.Ha@microchip.com,
	Arun.Ramadoss@microchip.com, horms@kernel.org
Subject: Re: [PATCH v2 net-next] net: dsa: microchip: ksz9477: split
 half-duplex monitoring function
Message-ID: <51ca6e1e-b3db-4a05-9da9-1ff5493a53f1@lunn.ch>
References: <20240808151421.636937-1-enguerrand.de-ribaucourt@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808151421.636937-1-enguerrand.de-ribaucourt@savoirfairelinux.com>

> -	ret = ksz_pread8(dev, port, REG_PORT_STATUS_0, &status);
> +	/* Errata DS80000754 recommends monitoring potential faults in
> +	 * half-duplex mode. The switch might not be able to communicate anymore
> +	 * in these states. If you see this message, please read the
> +	 * errata-sheet for more information:
> +	 * https://ww1.microchip.com/downloads/aemDocuments/documents
> +	 * /UNG/ProductDocuments/Errata/KSZ9477S-Errata-DS80000754.pdf

The 80 character rule is not sacrosanct. We allow strings which will
appear in the log to be longer than 80 because they are hard to grep
for otherwise. The 80 character limit is really about keeping the
indentation level low, encouraging lots of small functions which do
one thing, and does it well. This is exactly what you are doing here,
taking a big function and splitting it up into smaller functions with
less indentation. I see a URL as something which should not be split
like this, it should be allowed to be longer than 80 characters,
because i want it to be easy to copy/paste into a web browser.

With that fixed, please add a Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

