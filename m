Return-Path: <netdev+bounces-246495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E86CED3F4
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 18:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0AAD3007252
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 17:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBF32EFD95;
	Thu,  1 Jan 2026 17:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eAv5axdw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95D42E2F1F;
	Thu,  1 Jan 2026 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767289434; cv=none; b=M+Lmi6mqCJyVdbdcA9/INv8HopONIYdlrzdMSJ7C6dQUtTbuzNq6JRD4nTd1zj4EFynkDd7Sc9qnvSLE6cm60LUKfipaElVJlLvPnLh1hVXOfR+SxHIqVC8zk79XEeBIEf5SrMsxadP4BlbyipuNuyhidwodyH0eFQF786t+h6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767289434; c=relaxed/simple;
	bh=8OWtH6d11T139XRjdlZVjy86THcJjqyH7sZz65YdM1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXPsLeRwTVJIymW0IMSuEd0ncSRwqz3wh76gyn7FU4gIlwW65qPz0zhqDOvgVb8ge6fasZapCrco5WE1DUuuukK+lLV027xsm0mYumlUWQhYTA6tls3cxLsJGQNZjLAJNNQKqLlQLx4VHFaWOpn3ncwnwPvqv0W4bLTSc9bDyrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eAv5axdw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ct5vIeuM3pnRkd7r4+7GyKo373O2Sf6tlFOwpODQT60=; b=eAv5axdwTT540Hyh6nHYPVaTGr
	epGhkk62MKja7RKPvqg6XMd9bJHC/5MjcbvVpeddvnzADpOZelY/lyp4XSPcoekYAmQKYxXS2zp0/
	OWU3l/jTKYqiQtU0TQoaYwU5eHAYi12LLBim9jaTbEOf0L4+k6XSi7E8sD8BSu/Yt8UE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vbMi2-0015h0-Ef; Thu, 01 Jan 2026 18:43:38 +0100
Date: Thu, 1 Jan 2026 18:43:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Josua Mayer <josua@solid-run.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 2/2] net: sfp: support 25G long-range
 modules (extended compliance code 0x3)
Message-ID: <b88e844d-96a7-48fd-bfc8-a33b2fe32e19@lunn.ch>
References: <20260101-cisco-1g-sfp-phy-features-v2-0-47781d9e7747@solid-run.com>
 <20260101-cisco-1g-sfp-phy-features-v2-2-47781d9e7747@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101-cisco-1g-sfp-phy-features-v2-2-47781d9e7747@solid-run.com>

> Unfortunately ethtool.h does not (currently) provide a bit for 25G
> long-range modules.
> Should it be added?
> Are there any reasons to not have long-range variants?

Please add it.

Thanks
       Andrew

