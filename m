Return-Path: <netdev+bounces-157906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 861F6A0C461
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01EC18897E4
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DD31E764A;
	Mon, 13 Jan 2025 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sFJ5pf2Y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08611C4617
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736805976; cv=none; b=DWSxMb2Mf4KG7ix2+Wavv/i6p73AtdmsKRCWlen6b8v26H0MVxGZuelsI9JitF4os/selaf/tcsqXMo1JmTXUHGKpXfDce/bymZLAh1nE4RumjRj9ePiVcU7AOdTfTRQENfnj7McCHXfx+0ixlCFVkrnjyrqPNc1dgGQZakiNnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736805976; c=relaxed/simple;
	bh=mqvDBESw9Glw++Vu7zElG61P2EO2YlAuV2MJIfK1Pyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPJTForJXT/VSyNiELKLjXoY0NyQQYqjdSpixkQpUeHSUpbBrCstzYGau/fphNHgso/GUs+Z+8JeK9NLObKNf32DfrY4KF1Iv0QrIP+JeGeqFmI2zmASzFZAU9R0+zW0+TurkxpRCAIHz7c1o7bTfbgzKj9StTuYJtvzs0sVcfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sFJ5pf2Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qMmJ39dl9UT3+PtcqwDYiQUFlpnz4M+OoQbkywqkiac=; b=sFJ5pf2YCwZRnfHALiyBWU2oqe
	hx/A/dcL5WEEmYk83cqQEOWVgP2f9VBxafse7J6jvxl87riH56tKcpMHz8mpIGs3MXV1W9MJX86qD
	z+A9eDkQBXH7pyt23KkZ/NQsrKUM92G6TO2B3QYml9Miah3HAZ+dtHjmRGmP8y26f/20=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXSZS-004EgK-Q6; Mon, 13 Jan 2025 23:06:06 +0100
Date: Mon, 13 Jan 2025 23:06:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/5] tsnep: Add PHY loopback selftests
Message-ID: <543fd272-4727-4f13-bec5-9a61bc460066@lunn.ch>
References: <20250110144828.4943-1-gerhard@engleder-embedded.com>
 <20250110144828.4943-6-gerhard@engleder-embedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110144828.4943-6-gerhard@engleder-embedded.com>

> +static bool set_speed(struct tsnep_adapter *adapter, int speed)
> +{
> +	struct ethtool_link_ksettings cmd;
> +	int retval;
> +
> +	retval = tsnep_ethtool_ops.get_link_ksettings(adapter->netdev, &cmd);
> +	if (retval)
> +		return false;

Why go via tsnep_ethtool_ops. Since this is all internal to the
driver, you know how this callback is implemented.

	Andrew

