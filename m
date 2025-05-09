Return-Path: <netdev+bounces-189288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83958AB178A
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22E8F7B958C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1772E21D3CD;
	Fri,  9 May 2025 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KOWq51lH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCFC20FA96
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746801285; cv=none; b=mYAjYT1VOpTDaSQZkSw5UpHLhbuTSouaAo7KrwLmm34R2GB6xuUjVpARSO9/xX8FVlBrVJCgY9bPZX0tmJtDCT0RBvpQIeqHQOzldg26FWC/sAFDg//bwJKfG6HRo2XLf8w9uoTkXNVgqm6zrTBKZmTKEb7EkuBFNKg0LI9U6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746801285; c=relaxed/simple;
	bh=756Q5IdStUvvBkHvhRRLAq9Lg+E4LZrTlROZs67yW2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxqbZSiISyUX8zXKEfpkk7M/+6G56ULNANrHs+g9iXM8iKwR041tcGaxGw0BMle14cRt0CQh/aGfG9/lpJ5Ht8CFvkD+pSPYA+WAeGHBgeKKcsowf49Kg1ZRwKTG3XLSX5AuqijmbbM+Au1olcve6NImufeWiuo//hhAlhss/xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KOWq51lH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a3Sved/6oHj+tri8LRnIQ4ykIRJJ6yaTpZEr7WgjJ+c=; b=KOWq51lH8IyhcDXh8maI6i+vim
	vV2/Xcz0cPFYvs32nkVq4MkvKnqbaAKNTky/kTVaTWw7iqk0lJnR5hgVNcf9M1RF5IAe5aMqjVUA0
	yIlQqtrC3N8YAlFZYdSbjSWn5toGNvnA7KJWRb2VxSOpX3vob1xo9wxCiBIClwSA3rHQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uDOoC-00C7iw-PG; Fri, 09 May 2025 16:34:40 +0200
Date: Fri, 9 May 2025 16:34:40 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net-next 01/10] MAINTAINERS: add Sabrina as official
 reviewer for ovpn
Message-ID: <7ca63031-79a5-490d-b167-41cc5e53ff26@lunn.ch>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-2-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509142630.6947-2-antonio@openvpn.net>

On Fri, May 09, 2025 at 04:26:11PM +0200, Antonio Quartulli wrote:
> Sabrina put quite some effort in reviewing the ovpn module
> during its official submission to netdev.
> For this reason she obtain extensive knowledge of the module
> architecture and implementation.
> 
> Make her an official reviewer, so that I can be supported
> in reviewing and acking new patches.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> Acked-by: Sabrina Dubroca <sd@queasysnail.net>

Agreed. She deserves the credit.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

