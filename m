Return-Path: <netdev+bounces-174612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3E8A5F88E
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 15:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F9317FD9A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 14:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B7C267F76;
	Thu, 13 Mar 2025 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cUsGaxx+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D4267396
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 14:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876545; cv=none; b=iawTp1tvXCVN4/02hcfwAj+iC6mf5STIzzY9Ma1xyvhWOVEtVkQUlLbvg4TM3bKqnZ3FIjkfu1Emgn2A0rOv/VAVg3y8cCrRRNlCR2+7kyqAMgK17QnSTYsLrscRYIs9RYphoHdl7JlNuFIYLbswqmT/4Tbnw7SnvSrQDo/5Boc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876545; c=relaxed/simple;
	bh=1jqFFeO9lgFj24ofuGKpEuvKwRsULatosF91dVtfF5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBlZJYc+i0ZWWRtuemLqpbLJJ6vtt/olmlHk/f4NYXFC9PIbFb8m4I15NlG9iC9LLYSMQlnqmbJmLA2WSNqWy22CcsSfUdF4yRKQSLajIuQfhu4X9LNqp/sOK+guSgh1qwBvn46MH+eS+EVsVj5madw1HmZbc/FUmMOSCK1YIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cUsGaxx+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=9yw6oLAqDZ9sojnviBf/3pRmuoojClDvJOSVbVetjj0=; b=cU
	sGaxx+mjNJerCLRH/fwqQgsUU4Qw0bAhsf+1w7vQu76Ly2xisPl7qz45lEdZYdeEXto8j9C3ADgIK
	ykne03NcAOh87WQeNq16AEZiPb/YTVTk4Y5dmLmColVrz8KB8AbqzgzWbAIzJwOOZii5eopmN4t7d
	c9c7Gqs5qePUN1c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tsjes-00513d-UF; Thu, 13 Mar 2025 15:35:38 +0100
Date: Thu, 13 Mar 2025 15:35:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Tobias Waldekranz <tobias@waldekranz.com>, netdev@vger.kernel.org,
	Lev Olshvang <lev_o@rad.com>
Subject: Re: [PATCH net 04/13] net: dsa: mv88e6xxx: allow SPEED_200 for 6320
 family on supported ports
Message-ID: <1d24b3cb-e7c4-4378-a71d-c2adc02eeffc@lunn.ch>
References: <20250313134146.27087-1-kabel@kernel.org>
 <20250313134146.27087-5-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250313134146.27087-5-kabel@kernel.org>

On Thu, Mar 13, 2025 at 02:41:37PM +0100, Marek Behún wrote:
> The 6320 family supports the ALT_SPEED bit on ports 2, 5 and 6. Allow
> this speed by implementing 6320 family specific .port_set_speed_duplex()
> method.
> 
> Fixes: 96a2b40c7bd3 ("net: dsa: mv88e6xxx: add port's MAC speed setter")

net-next please, unless you have a system which really requires this,
is broken otherwise.

	Andrew

