Return-Path: <netdev+bounces-166246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0317A3528B
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 01:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4E73AAB9D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 00:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C89C275407;
	Fri, 14 Feb 2025 00:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="17v1bXHY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C6523A;
	Fri, 14 Feb 2025 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739492394; cv=none; b=Q2hoJg0ikS+P//cP/5FUfVIcUXiZTIxxfQL+BQV9jXuOqJcd/013eoToJ7anZiVPP6K5x3YActs9QEQQP11f6OqWCJNpmOLDUXIyYmExEaxhYbzxHXV4yu5M6XLtypHjCXwdgnzOXuAK5L0KhOmm5FjScPnytXOyyd9H3El1rtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739492394; c=relaxed/simple;
	bh=OTYlTha7dStZWE8zP2xno+HBL4joSA9thPp3EMEd+gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSd3bS6iFO8Nwo2WbENexU7jIGDjLPHUMo+p+IPxAwv/BINQkPKvGghU4kPjG69lo+zohv6r1W9nLQZI7+OJ9CzjwC8nHpyqYubhk5W/THRittOvLbZxjW6n5x8rV6Ehu5sg0/n0RdzUOtkT6/22ijOrHaBM1Uwe+IXf5taddSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=17v1bXHY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Vy5omDl6KJ0USqAk7erLvFOD2j4+PI0gYl7PBegS6lc=; b=17v1bXHYFf54qAGZYsVxZ490bL
	yzvQWx+tpnTYiNIQLOopdRvSNKZ4Fj8sSgLvtYBja0uAxUZWAzufox+QypFXCsZG9y1uxtgMd15Ky
	GopZS/CQ721Px5en8PgJm1AxSRQW3Rb5fwXm4+RdBd3+Pr3qDKcw6Uu6IHP8QAl13K5o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tijQf-00Dtoy-OP; Fri, 14 Feb 2025 01:19:37 +0100
Date: Fri, 14 Feb 2025 01:19:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device tree
 bindings
Message-ID: <85e0dec0-5b40-427a-9417-cae0ed2aa484@lunn.ch>
References: <20250213044624.37334-1-swathi.ks@samsung.com>
 <CGME20250213044955epcas5p110d1e582c8ee02579ead73f9686819ff@epcas5p1.samsung.com>
 <20250213044624.37334-2-swathi.ks@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213044624.37334-2-swathi.ks@samsung.com>

> +  phy-mode:
> +    enum:
> +      - rgmii-id

phy-mode is normally a board property, in the .dts file, since the
board might decide to have extra long clock lines and so want
'rgmii'.

The only reason i can think of putting rgmii-id here is if the MAC
only supports 'rgmii-id', it is impossible to make it not add delays.
If that is true, a comment would be good.

	Andrew

