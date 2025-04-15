Return-Path: <netdev+bounces-182891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CD8A8A47B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B19189DDE5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDB5205AB8;
	Tue, 15 Apr 2025 16:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXHAB2QE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2092260C
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744735612; cv=none; b=mt7wPLj2vonzaIyDd3tSUkhKZGAKoyaO0EBeGldxJiNGASZtXNpgBL5TY7HLGv4m0e9makKHl4dMu441yh6e6R4BoP0pX52W6K3kilSa0Tx1J63BJGbl5DVVf/WfZS8klkIdGL8NuqMluWxOG0tbtfCzBd69YALHSgVN3TUEPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744735612; c=relaxed/simple;
	bh=yBYhKalO0eyKXF9bwwARIr3E25XGc1Xv23k1pb9l+oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBjPfJheOr5sByVKKHYEFegZS8CUqjmRLv9BcDgbTr6njNBlDNp22YeLudrSIny3VCtTgmas+eG1UKwpJEV6qCkxdOmVXH3/dTLtau0kaDGcZIxcQiT+lxYg6/V0T9BWewOUW/MAmlFJdK6j8frrXmuvnwOoGtvS3npGhMgCEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXHAB2QE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1A7C4CEEB;
	Tue, 15 Apr 2025 16:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744735611;
	bh=yBYhKalO0eyKXF9bwwARIr3E25XGc1Xv23k1pb9l+oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXHAB2QETg7/xAKnRiQBIqmOuRh76UBn0ptVDCCcrL96fNskUproq+cImkbRSJMCW
	 ZQBIxA+6tyITePvTZr/V/6VZPw1KNMPt/Os5u+1dswJdZGcYnBkyZQRmyms3EIJNtK
	 iDew7WCbYyZiMZgmEjU/HIkG09UD3RS0Duc4StVU2gLxnXzTYp6kAsLT6Fq7KuvHWb
	 2j03g+Ni3kIveiEMQfUQvWdZzmKDM2WypOrE4X2NhS0Ji27ezhE3TLDcGvbVyb1Uu0
	 yzqD6ELcdiAS5+QjX9hHOwGtc/bdPmcV0pDWH0cvEw55P+tPDkz0oB3IPWRRmtOHWE
	 E2HZM7+SLKwag==
Date: Tue, 15 Apr 2025 17:46:47 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: remove redundant dependency on
 NETDEVICES for PHYLINK and PHYLIB
Message-ID: <20250415164647.GB395307@horms.kernel.org>
References: <085892cd-aa11-4c22-bf8a-574a5c6dcd7c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085892cd-aa11-4c22-bf8a-574a5c6dcd7c@gmail.com>

On Sun, Apr 13, 2025 at 11:23:25PM +0200, Heiner Kallweit wrote:
> drivers/net/phy/Kconfig is included from drivers/net/Kconfig in an
> "if NETDEVICES" section. Therefore we don't have to duplicate the
> dependency here. And if e.g. PHYLINK is selected somewhere, then the
> dependency is ignored anyway (see note in Kconfig help).
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


