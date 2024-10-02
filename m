Return-Path: <netdev+bounces-131396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A081E98E6BB
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 01:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AD51F2376A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 23:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A7719E973;
	Wed,  2 Oct 2024 23:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uInwaWap"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C41D16419;
	Wed,  2 Oct 2024 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727911399; cv=none; b=ZIC53npQI4bAvEfWMpYVbBQ378KME5CYxMJXH58OtfL2pvWix1bvX6FvE0wbeyMZiOX/X6f+n/9bpG9cgWrpUNPpaxcLSd4wGjSzRh3K+u8xrLUa/Knhfg0Zjbln4WNBjaXTvPmFM3vmb4z9o37b9uZpWtSqc7w/754uR677Z10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727911399; c=relaxed/simple;
	bh=cAX6+M6+Khksg+tpDYfTbQIM5/Zi+NsJ8wt2YNDQVjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEVGRecOokH+voTVmhucma3qer+ZdBibiFn6ZEOfqZ2GHUheReZxP4XY8KLH3iKXWUVjrWcKX03yzD9g9ezpM2s+CMTarE6mt7oZfzn6kaeCtUDWnuRbe90m7na/bJ0vCViwB+VC4xxRP0Kqoafz5tCfsv+oEotRNmDO59ImT6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uInwaWap; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OW39lq17QrjrLGUtBE45hfd0oK6JzazGTkjD0vloGr8=; b=uInwaWapis1cvei6MQc3RYr+/3
	tV34cDGZsSW34HGkXO2lK6m0lJEffDBSwThvVDyS5hApmH+mvF77doM2UZmmPb/XZFys9dURR5fcM
	oi2AxtxFRO0j4Gq1bdrcEkMs6028jkUTtKmxLRwIA8zbmTt8fPJU5vlsB406WPh2robI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sw8gU-008u40-K8; Thu, 03 Oct 2024 01:23:06 +0200
Date: Thu, 3 Oct 2024 01:23:06 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	Parthiban.Veerasooran@microchip.com
Subject: Re: [PATCH net-next v2] net: phy: microchip_t1: Interrupt support
 for lan887x
Message-ID: <382d3da1-441a-4b1e-b395-71959bb5b056@lunn.ch>
References: <20241001144421.6661-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001144421.6661-1-divya.koppera@microchip.com>

On Tue, Oct 01, 2024 at 08:14:21PM +0530, Divya Koppera wrote:
> Add support for link up and link down interrupts in lan887x.
> 
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

