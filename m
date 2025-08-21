Return-Path: <netdev+bounces-215611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9029EB2F878
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6598A6048E7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C26531AF1F;
	Thu, 21 Aug 2025 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WY/wwDUW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681B131AF13;
	Thu, 21 Aug 2025 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780080; cv=none; b=ikKln9V7GkLkfgKnTG3PRKDGyLJaCIUxiDvseGyuqlb6WoGgwqtnjp7mLwReddUsJ5PI+TK4GmL7abuixS38fWbamQJvsM0GAU+wQZya+IpurCmtsbRm3rZ64UXRfzvjMjPGmQf3pdkNZpU98MLhvaPAalv8qGlpvskh9gU8NFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780080; c=relaxed/simple;
	bh=5SntXcT3EX6iRj3qRaCgNZss4u35RUFrPDY1w3CY6gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CE/L5aSsSMhC/4MzAHMn7onftJQNJT0NgVEsAAiuRiI4kaSLbrvLfkLtWuMEXPDonwnlEpYylvqrB255C/lMpGGvBbF7LjSymWTkk7//AzxY9OKfWsLx7jQkxFSvQoL7MZecPZJnhdFk0BAMb+TQdxkBRiJkDeYQbLjjq0Me7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WY/wwDUW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jYiM3Qw38rzuBVo6SaPYD/cuw6C9KtVM8CdKHhDfty0=; b=WY/wwDUWzp4h7zINiTrJz700Um
	p3pkz2fXL/JslUBJLYn2wfRTAaSuJDF9/AKKecZDL8s40kz0MoyCJ5SoX/GdDFJBmgV8Q1ZiZtEQs
	Li02meBLdBk8GxQGiRwkWJH80PVISjD2chohLLuRvxGLK3qAU5g4nYooZqIzGa17MT0Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1up4bN-005Ryv-TY; Thu, 21 Aug 2025 14:41:09 +0200
Date: Thu, 21 Aug 2025 14:41:09 +0200
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
Subject: Re: [net-next v5 3/3] net: dsa: yt921x: Add support for Motorcomm
 YT921x
Message-ID: <02baf961-b82d-4819-8791-229f7735a1a7@lunn.ch>
References: <20250820075420.1601068-1-mmyangfl@gmail.com>
 <20250820075420.1601068-4-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820075420.1601068-4-mmyangfl@gmail.com>

> +#define should_unreachable() \
> +	pr_err("%s: !!unreachable %d, please report a bug!\n", \
> +	       __func__, __LINE__)
> +#define consume_retval(res) do { \
> +	if (unlikely(res)) \
> +		pr_err("%s: %i\n", __func__, (res)); \
> +} while (0)
> +

> +static int
> +yt921x_vid_del(struct yt921x_priv *priv, int port, u16 vid)
> +{
> +	struct yt921x_port *pp = &priv->ports[port];
> +	u32 mask;
> +	u32 ctrl;
> +	u32 val;
> +	int res;

...

> +
> +	if (pp->vids_cnt <= 0)
> +		should_unreachable();
> +	else
> +		pp->vids_cnt--;
> +	return 0;

Have you seen other drivers do this? If you are doing something which
other drivers don't do, it is probably wrong.

What you are more likely to see is WARN_ON(pp->vids_cnt <= 0); You
then get a stack trace, to help debug what happened. Kernel developers
know what WARN_ON() does, so it is easy to
understand. should_unreachable() is unique, it is unclear what it
does, making it harder to understand and review.

> +static void
> +yt921x_dsa_port_bridge_leave(struct dsa_switch *ds, int port,
> +			     struct dsa_bridge bridge)
> +{
> +	struct yt921x_priv *priv = to_yt921x_priv(ds);
> +	struct device *dev = to_device(priv);
> +	u16 ports_mask;
> +	int res;
> +
> +	ports_mask = dsa_bridge_ports(ds, bridge.dev);
> +
> +	dev_dbg(dev, "%s: port %d, mask 0x%x\n", __func__, port, ports_mask);
> +
> +	ports_mask |= priv->cpu_ports_mask;
> +
> +	yt921x_smi_acquire(priv);
> +	res = yt921x_bridge_force(priv, ports_mask);
> +	yt921x_smi_release(priv);
> +
> +	consume_retval(res);
> +}

And this is the same. Every driver you look at would just have the if
statement, not a macro.

In order to make drivers easy to maintain, easier to review, easy to
debug, they should all look similar.

	Andrew

