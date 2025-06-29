Return-Path: <netdev+bounces-202258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B564AECF6E
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 20:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD963AF3E7
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C3723504D;
	Sun, 29 Jun 2025 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KV+6TPha"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDA91A0703;
	Sun, 29 Jun 2025 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751220792; cv=none; b=eSZ4yUI8OwoR8lDHlVU9MTpl0rVxjP8ejaaRLr32eoJYLUxPLdkmfnyrk2FEc86m+036FFuNFVHjP6vUT6eYw8pXB/CXE6DI+H2tR852ExiH3ngjPoaD6tV5vf8n+W6EtQCxlMwZIgfMNPNqQ9Cw3b5MUAv5MJKmbaXgUYCvpnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751220792; c=relaxed/simple;
	bh=ZWkS0KA7ndQ8Y/S3qEk2uN9DrqaUCUYR9z+e5XRugDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nivv3HXOt7cMGCWrQ607Lv+j2/+kS0d5CUVCxX0m+b118JRNtihocFzkienzDHUCOXn8oWMRBsUGYELTr7/M88ewYQ7fCEUdKyvnncWwAYKZ5c0SyfAv0ydqrK+PfMu3X8pwiEFGB+d4IFt0KkEkQ5KzLSG3vIF/G9774jg01sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KV+6TPha; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ptXbPJv71SP8NY0z66NYyCFVayQPDTWB+g2Fc85hzaI=; b=KV+6TPhacZK+lV3Dh7OKV/IubD
	HlbPfbiO24+7R3KOJJHIU/cRQ7MiX2CBae7dCoRx2v8ai8zNuQiKjlIQYicUwANjN7EtWsrZ4dCuC
	G3+48LZf2UDBFwxM5nSZizNar6flP85iue8PihHfu718Av2XCbtJepb2W4uit/LvHvcE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uVwWU-00HIC8-Hg; Sun, 29 Jun 2025 20:13:02 +0200
Date: Sun, 29 Jun 2025 20:13:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: dsa: mv88e6xxx: Constify struct
 devlink_region_ops and struct mv88e6xxx_region
Message-ID: <8f41d167-7364-4e30-9cc9-a6594b8879b3@lunn.ch>
References: <46040062161dda211580002f950a6d60433243dc.1751200453.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46040062161dda211580002f950a6d60433243dc.1751200453.git.christophe.jaillet@wanadoo.fr>

On Sun, Jun 29, 2025 at 02:35:49PM +0200, Christophe JAILLET wrote:
> 'struct devlink_region_ops' and 'struct mv88e6xxx_region' are not modified
> in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   18076	   6496	     64	  24636	   603c	drivers/net/dsa/mv88e6xxx/devlink.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   18652	   5920	     64	  24636	   603c	drivers/net/dsa/mv88e6xxx/devlink.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

