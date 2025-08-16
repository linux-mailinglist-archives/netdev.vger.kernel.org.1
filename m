Return-Path: <netdev+bounces-214310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C2DB28F1D
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 17:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B6F1CC4D93
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 15:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113152F39DF;
	Sat, 16 Aug 2025 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="auYojMp6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7B81DE3A7;
	Sat, 16 Aug 2025 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357658; cv=none; b=GGr3nOdxjm+zNriuxzJiEokfFun5tSxtmvWX+7Snfy1AsgxqRwvmpdcPQwZ0/J1Xx8FRuB/ZREmbquxi5ybS//hCGx2Anq90cWB4Ptj/LWHwbFwTqybHbHH/jlG2oHZkERjSFo+TgORqZk5ijHOJW89j+7T1DWptG/krEo4E2Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357658; c=relaxed/simple;
	bh=RBIyDtnznFHzqlQIF1q+gcJw4wQW/dS5qTzOPwt1XYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFP1qday64ohXzQy6w37jT0MJKOMvPuaCn/TNeDmBcbmrknv6FC6wTdeYMWDa+m0k9LDmdywvb2oOLW3iKj0UMMG2RTQQHiYKnpwI0hKD/zomWRwvSuzxO+BxfSyfhvQNdnDXDVaUrgDjs23Dei4CUqRq7pqqAW2KOmgkIdEGcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=auYojMp6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=shQDX71uKhVljkmiU89xwZumPoU80TwEyr56tSmwUfU=; b=auYojMp6+dMcsrLevaeyCizdDk
	LONQLs50qaqdKV1kqcFcSEI8r271ye35AfBxJbl2ZqX01I0SI9BgrHwDtmBliNRSaVmzlhnqLxR45
	Q5U5E0MnKlAxC+43FyIVsAgn96ECQk6ximiPQiQ0BHzk8MAjSPDKRhGEET39l+Kq8WfQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1unIi5-004uZe-6l; Sat, 16 Aug 2025 17:20:45 +0200
Date: Sat, 16 Aug 2025 17:20:45 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next v3 0/3] net: dsa: yt921x: Add support for Motorcomm
 YT921x
Message-ID: <1ceb8a8f-140a-4b54-be2a-df9ac2c219b6@lunn.ch>
References: <20250816052323.360788-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250816052323.360788-1-mmyangfl@gmail.com>

On Sat, Aug 16, 2025 at 01:23:18PM +0800, David Yang wrote:
> Motorcomm YT921x is a series of ethernet switches developed by Shanghai
> Motorcomm Electronic Technology, including:
> 
>   - YT9215S / YT9215RB / YT9215SC: 5 GbE phys
>   - YT9213NB / YT9214NB: 2 GbE phys
>   - YT9218N / YT9218MB: 8 GbE phys
> 
> and up to 2 serdes interfaces.
> 
> This patch adds basic support for a working DSA switch.
> 
> v2: https://lore.kernel.org/r/20250814065032.3766988-1-mmyangfl@gmail.com
>   - fix words in dt binding
>   - add support for lag and mst

Please don't add new features between revisions. Reviewers spend time
reviewing the code. They assume just the issues raised will be
address, and the rest of the code remains unchanged. It then means
they just need to check the issues raised have been addressed. By
adding new features, they back to the beginning, having to review all
the code again, because you potentially added new issues.

LAG and MST should of been implemented as patches on top of the basic
driver. They can then be reviewed as small increments.

Please put yourself in our position. How would you review this code?
That would make it easy for you to review it?

	Andrew

