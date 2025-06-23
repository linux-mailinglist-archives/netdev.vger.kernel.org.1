Return-Path: <netdev+bounces-200416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EEAAE5784
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9621D4E2EBB
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 22:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BEA225A38;
	Mon, 23 Jun 2025 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mYNE2fZx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2CE223DF0
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750718499; cv=none; b=gb1wfdWuHTdITbBKbr3vcuMB3GhPdohnXGfmum01u6Of8S1CyXGPLrOJHvdd2QVYvDAkzyw0I61VJg7IVNlPgBLCLhAojapHe2SAYf7eeH6gzEvPP4UeeS2ZOHwlOv6TtjQNurEBo1edmXETK6WkqjFHiZnXV/lGDvnDpEX81oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750718499; c=relaxed/simple;
	bh=iYil0v+gmm/lAOtVdVSwHEZxhLs+7hSGPH+Csm4Tuys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gC90YfA/AeovfoGb+Zy/neGfoN3pAGpEiETUumNeMXjcokilL5VaYQTd3I6IfJZeNeemedv4ixar7oQhAXqlRqpecw+GdiUC9R861o0dEpogLYUF4nFGzwre0C1o8onXJxT3oNKPIYrLff8OAD3e/nFSVKrP4yzyBz+BKWbJdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mYNE2fZx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TBdd5fKgL8h6YYPwIVYxM3u+oaP9BwyeJ35ovwljydw=; b=mYNE2fZxJqAd1mT4tfKYMIaAQt
	wxkzD7/eyzKFrjIjjFBNNDqMIWAZgmYzdcZn0t0tow+4QwRnKGXnHQXbqcJHEFMAziieHFcfIMuKc
	R4VF0otVXDLpRXtNQDSQK4OsLw8eF4dSOAWVOU9L6ETEUe4ChEVsHt5p6dXPocn89T1I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uTpr4-00Gjmv-3I; Tue, 24 Jun 2025 00:41:34 +0200
Date: Tue, 24 Jun 2025 00:41:34 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jonas Karlsson <jonas.d.karlsson@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: cadence: macb: only register MDIO bus when
 an MDIO child node exists in DT
Message-ID: <bdabd8af-ca82-4435-9d6c-571be9a2e3ed@lunn.ch>
References: <aFl4LSaVfY7sz3Pr@burken>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFl4LSaVfY7sz3Pr@burken>

On Mon, Jun 23, 2025 at 05:52:13PM +0200, Jonas Karlsson wrote:
> Prior to this patch, the MDIO peripheral was enabled for every GEM
> instance, even if no MDIO child node was defined in the device tree.
> In a setup where gem1 shares the MDIO bus with gem0 but has no MDIO
> subnode, gem1 would still scan the bus (both Clause 22 and Clause 45),
> adding unnecessary delay to the boot sequence.
> 
> This patch changes the driver so that each GEM instance only registers
> its MDIO bus if it has an explicit MDIO child node in DT, e.g.:

What is missing is a paragraph starting something like:

This is safe and won't cause any regressions because ....

When writing this paragraph, please take into account:

https://elixir.bootlin.com/linux/v6.15.3/source/drivers/net/ethernet/cadence/macb_main.c#L818


    Andrew

---
pw-bot: cr

