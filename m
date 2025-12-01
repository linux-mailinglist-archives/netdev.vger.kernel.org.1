Return-Path: <netdev+bounces-242972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9882DC979A0
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 14:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346BE3A4B11
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 13:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940F7313297;
	Mon,  1 Dec 2025 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lB/LxTc0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C6230FC12;
	Mon,  1 Dec 2025 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595519; cv=none; b=P7e1qdjrK3sncyqmpR7CC5L69ED3JQEJi01CkcK7jLuB6mL/Ux9Q5nueMOjp5rVe7U0XZvtxLFzkn/J+CLeC3juOLr1AXK/HY4Ox34xRHCYB93RpsBkBxCyc8qt6CUiTxYoPnIzFaEm2iabJDzMzqvbs3r5G7YmX2lFUmcAoT8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595519; c=relaxed/simple;
	bh=ahPIWMcjVWVVl1RY8i/lPlHL8cDieB6imBTliIQRJBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2QnliVIMRHpxB+6IKazLT6gH0hPgtPibHuSAyBhNt4sKjbloBpfLHHpF6uHN/obvew65GH0ff1DUQG/NsZEOvKcNg6Y+ShR1lOklLjKDX/sBVcER8p4RdeIOwG8zyfsL9XcGUvycEzR+UMHXb8tEuTwlV3ZGiAec2RFTGDHsGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lB/LxTc0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FJ3IEDjmgou8cyZsKbo1Wk+XVUEbBRzNau/4Bitey/g=; b=lB/LxTc0K9idxdFZed0sQ1jFLC
	CsbEkFTeYX7AasddMsaOTauDJJS2WfxviX6cw6wzWZgbTugCNwIu7Rg5hRt6/HcI4rAO9FJ+EfeJm
	qR6QzqILwi2CF/jH1cuM1YyRPajY2I14xdGNRec/fr8t4EDWi2yKdVGGkVEpgKLTTItc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vQ3ts-00FZgc-CQ; Mon, 01 Dec 2025 14:25:08 +0100
Date: Mon, 1 Dec 2025 14:25:08 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: piergiorgio.beruto@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/2] net: phy: microchip_t1s: add SQI support
 for LAN867x Rev.D0 PHYs
Message-ID: <6d283f98-a483-41b0-bc48-8601e8b3b052@lunn.ch>
References: <20251201032346.6699-1-parthiban.veerasooran@microchip.com>
 <20251201032346.6699-3-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201032346.6699-3-parthiban.veerasooran@microchip.com>

On Mon, Dec 01, 2025 at 08:53:46AM +0530, Parthiban Veerasooran wrote:
> Add support for Signal Quality Index (SQI) reporting in the
> Microchip T1S PHY driver for LAN867x Rev.D0 (OATC14-compliant) PHYs.
> 
> This patch registers the following callbacks in the microchip_t1s driver
> structure:
> 
> - .get_sqi      - returns the current SQI value
> - .get_sqi_max  - returns the maximum SQI value
> 
> This enables ethtool to report the SQI value for LAN867x Rev.D0 PHYs.
> 
> Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

