Return-Path: <netdev+bounces-116472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4799994A8AC
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 15:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1291F21736
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E711E7A3B;
	Wed,  7 Aug 2024 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RvWZTelu"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F60B44366;
	Wed,  7 Aug 2024 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037740; cv=none; b=qCpcF4ci6FLXRiICA3fPjqa9rIkdZKIbRzDhme5rhoIDR+d/5WDqacVDyfSno1uG5inNUFhi+t/jowZ2QRNAJifHSvu+KNIXYIUwZHgHAfpi+2cCAmRKA0ev5wtJYd7+KMa6AIc1BPma72b/ij8iQoXDSn7yoyoe+hbDLMWArhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037740; c=relaxed/simple;
	bh=ALaWjI0nfFErCuZGtSRO0LIzfSJwcgNgqemRT5KuC2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qReqfZAhEW/Vo3inm09W3X+JWt677IFjtL2yt7SMwj2VqF08NyuZEXI38dHOzR84OEfxvwUotlQ9HtrVpNpw2OYGNr20CMwgxBh0/kqo2reo5J3O7ObYgh+CQo8pGnsGdUbD561fkqthn/mgA9jmxrBMaT9ka3My+YSXBbIcn6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RvWZTelu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3HUbB0K1F8mlWSOWbVpQk/JV4CdvrPNZEVZ4zbL0scI=; b=RvWZTeluUOfbIaD2x40Mz5k2mZ
	k0Xy0H+oDssYfwGk+nPCRKj3b9+VVcBEUMLCY9ya8BmcsAer7HyMIwLuv8UlYSM+DQOi8T/wnPTwm
	wrkSPnyfVHL7OasyimyLEfPVBZ2O89blbs0WTQi0q2OJrzdOR26FLKIYGk4B6Fak9dXM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sbgp7-004CgV-ML; Wed, 07 Aug 2024 15:35:29 +0200
Date: Wed, 7 Aug 2024 15:35:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next] net: ti: icssg_prueth: populate netdev of_node
Message-ID: <27362b48-c185-4ef4-b1fd-550ee3a7cd70@lunn.ch>
References: <20240807121215.3178964-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807121215.3178964-1-matthias.schiffer@ew.tq-group.com>

On Wed, Aug 07, 2024 at 02:12:15PM +0200, Matthias Schiffer wrote:
> Allow of_find_net_device_by_node() to find icssg_prueth ports and make
> the individual ports' of_nodes available in sysfs.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

