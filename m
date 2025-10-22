Return-Path: <netdev+bounces-231667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADF0BFC66F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DFE6277FF
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B1F34B409;
	Wed, 22 Oct 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IDClc6YI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471E234B406;
	Wed, 22 Oct 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140504; cv=none; b=acln6VtbdcV/08++qcT0sX7O4lK+7rX62shIoqbMhBRsJ1P4DN87LC7p3JeHngA3jnX9Xf5Wp85ywbSO0zwp/Rgn8vFiROFMbSo6/0tyFhP9sRB56qoLol4hgmvm7NOUkClMPz/S6XzcIyyJ1Nd7+jttg2WEt7hKU9GgwRYhELA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140504; c=relaxed/simple;
	bh=cJ2CXIp6mToWHbQnEewt8z1K1cpi99imtgwlRgVfZxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vF4OHLK7qHgbMmVs2BAlQlUIQBoJo1x42wbIbrBTdCdclPMQI5ZWfkWQ6DtKEQfxzJYWpbR4T/3ntMAPS2OsP6d23BUcDxwQALrHlTJDeGwIAtFwNroH3cZQ26HNrDr9WojpTE8CmNMZXKB3b8LJCFOLpYEnyx5HHOMyeTIcZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IDClc6YI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PCs00lhyhbWrXa7fhzTDxXwryuxOd9gwLFu1tW+rovk=; b=IDClc6YIeFAX8fgwnqct8rslOP
	y70rq1E7sHy9ju9j/Ppo7/omqQq/uJHLjzUoZpZOS6yU7yIRLPbpy3v8bKqVit3u5XfN/QZdri5Dz
	dc6OwbhmqcJw4s7VmRyvj8vKcL7q6aav3IKgunRuGmA6Rj+/f1oWLITmx1tBxSCxyKMA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vBZ5r-00BlUq-BO; Wed, 22 Oct 2025 15:41:35 +0200
Date: Wed, 22 Oct 2025 15:41:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Heiko Stuebner <heiko@sntech.de>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: net: snps,dwmac: Sync list of Rockchip
 compatibles
Message-ID: <e2274dff-83eb-4908-834d-b77b3e2d1a60@lunn.ch>
References: <20251021224357.195015-1-heiko@sntech.de>
 <20251021224357.195015-3-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021224357.195015-3-heiko@sntech.de>

On Wed, Oct 22, 2025 at 12:43:55AM +0200, Heiko Stuebner wrote:
> A number of dwmac variants from Rockchip SoCs have turned up in the
> Rockchip-specific binding, but not in the main list in snps,dwmac.yaml
> which as the comment indicates is needed for accurate matching.
> 
> So add the missing rk3528, rk3568 and rv1126 to the main list.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

