Return-Path: <netdev+bounces-187729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D192AA92CA
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 14:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D4518990E0
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 12:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936D322B8D1;
	Mon,  5 May 2025 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dq9gqMTM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7722AE7F;
	Mon,  5 May 2025 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746447323; cv=none; b=IsyDokTVT/IQQMVfnGznVm6F+7EcPDSsrJRDeDcyDDXplbxsCiCUJcTGOnk7sExlqtBy3xwTrefiA8eq/79Zg7Vaacia7kLR4huxNOVT4YV72nE70zqT6GatTcwrRhEYH88a0BRBomlov7Me02qmoYuCegpNnPZ1Ot5K1tMbi6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746447323; c=relaxed/simple;
	bh=/ZxlZzMuIp9unqNcD0XajEpNxCAOmLzEQvkD+safKWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/XuxNGvSuyXFTqdi0B7sbBUCEiZocDStBsmRLehX2e0ys/R3FJHWvfu8tZ/mOZNYDlG1g5bDI2McVG1XownjOaKiRkX1uz5J4obFXSrF9eL6/OnxxA5A3Mqc2msbDQ6FgafPqVS/hKeyT74f7/VHt7vo/RNSuTWph1CFIHuDAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=dq9gqMTM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NbulvA1d2ndRK+1/mUS5QJdpNLrzeNCoxVF106IVpuA=; b=dq9gqMTMjXBY5G9paS6dfm7P92
	SVXbVDW8brc1RsEIoIejCyXOIQdSjKv+i+i+8iOM2aW37Ua+MTzv7krWhHgTsklDHVhFpjPdrxcxZ
	rKn1bkML3TsYPLwe6xQkgNejQBuUnmJuLF08oDTNnSDemhFR3QG0XgWfPR5nLW8N7Pz8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uBuiw-00BajR-Pd; Mon, 05 May 2025 14:15:06 +0200
Date: Mon, 5 May 2025 14:15:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: netdev@vger.kernel.org, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 net-next] net: lan743x: configure interrupt
  moderation timers based on speed
Message-ID: <e2d7079b-f2d3-443d-a0e5-cb4f7a85b1e6@lunn.ch>
References: <20250505072943.123943-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505072943.123943-1-thangaraj.s@microchip.com>

On Mon, May 05, 2025 at 12:59:43PM +0530, Thangaraj Samynathan wrote:
> Configures the interrupt moderation timer value to 64us for 2.5G,
> 150us for 1G, 330us for 10/100M. Earlier this was 400us for all
> speeds. This improvess UDP TX and Bidirectional performance to
> 2.3Gbps from 1.4Gbps in 2.5G. These values are derived after
> experimenting with different values.

It would be good to also implement:

       ethtool -c|--show-coalesce devname

       ethtool -C|--coalesce devname [adaptive-rx on|off] [adaptive-tx on|off]
              [rx-usecs N] [rx-frames N] [rx-usecs-irq N] [rx-frames-irq N]
              [tx-usecs N] [tx-frames N] [tx-usecs-irq N] [tx-frames-irq N]
              [stats-block-usecs N] [pkt-rate-low N] [rx-usecs-low N]
              [rx-frames-low N] [tx-usecs-low N] [tx-frames-low N]
              [pkt-rate-high N] [rx-usecs-high N] [rx-frames-high N]
              [tx-usecs-high N] [tx-frames-high N] [sample-interval N]
              [cqe-mode-rx on|off] [cqe-mode-tx on|off] [tx-aggr-max-bytes N]
              [tx-aggr-max-frames N] [tx-aggr-time-usecs N]

so the user can configure it. Sometimes lower power is more important
than high speed.

	Andrew

