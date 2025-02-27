Return-Path: <netdev+bounces-170247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BBEA47F64
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEFE162595
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F29E22DFB3;
	Thu, 27 Feb 2025 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Z5AnLMX5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1672206AC;
	Thu, 27 Feb 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663443; cv=none; b=pSAlMFmfowp7JnZtyBrao5zCKIsgs30871kGJxnxprbV22/CEUkCvycTLrh809/fIvQYF3t/3wjYYvjD5c9ToR8ctX4CXsUr/2Pk5T8X6CjY/tP8TZzbYCCDADykkhkJ082eP8fq2T9CZQ/LY+d36u6E6Ldbnq1EcPOPzJkMm9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663443; c=relaxed/simple;
	bh=fFvxLnSIoH2cP+vL1AfiNmxf3lNhBBcyQcN1t/EZV3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayc73WTZnatMvVFUj9+JWuCc0PLEucPVtv4rBYxrI5t/xX+gqWw+nrGabnvJk0ilp4+2moWXDfc7KalN1xAUSTPIB8d6s+npgfZdpKojmRDQiDB3iZctRyv8WUDF7RXHgjSsUWIPbI+D0Ck4Cy1wPbe69cGVsJOjmhqy/qj/l0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Z5AnLMX5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iQu2082//gPU290pxdRRy926EyxDVgpmL3flACSXtlI=; b=Z5AnLMX512TdofIv8P0FEi7upk
	WfrSa5FsVMlOGD0enN7fyIZqg2ig1i2IskNE4c1WFVlkLNH65YmauKm9yA2/bw/T4jZT8ra8zog2k
	JYEGNYg3dbRbHZq7aMbANwkIYlPVdPorm0iS/1+vn8sPNgMJY5FYK3+2Kbt8nSWh8NkE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tne4a-000bSx-NT; Thu, 27 Feb 2025 14:37:08 +0100
Date: Thu, 27 Feb 2025 14:37:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
	Jose Abreu <joabreu@synopsys.com>, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Rob Herring <robh@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	David Wu <david.wu@rock-chips.com>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: Add support for rk3562 dwmac
Message-ID: <5fd4bc39-bf2c-42d5-bbd0-2787b2839833@lunn.ch>
References: <20250227110652.2342729-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227110652.2342729-1-kever.yang@rock-chips.com>

On Thu, Feb 27, 2025 at 07:06:50PM +0800, Kever Yang wrote:
> Add a rockchip,rk3562-gmac compatible for supporting the 2 gmac
> devices on the rk3562.
> rk3562 only has 4 clocks availabl for gmac module.

available

	Andrew

