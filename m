Return-Path: <netdev+bounces-214219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3F9B288AC
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33DE5C038E
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 23:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B812D028F;
	Fri, 15 Aug 2025 23:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vlDwZpHx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4726B77B
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 23:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755299734; cv=none; b=eS6LlXJB1ZHENNRvFFk6l2GmV8yqsN7FClp210/K/Op1jeFUrmqq10goiw+If+/hezQ5jODnIqIvuNgLI/AhnS7+TbIg9qpt91pUTomskFEiQG3K/6oKVDZ8plktkg3LDiHkrhT15nnyQdnVzU3PGKtNytS9qz4Fb5OPrRZgyCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755299734; c=relaxed/simple;
	bh=EVbCdF80LblIZxZvOuIseOifIl6jqmOAoPSgrYZhD+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdKYVDdseAyOXiUNMe75DzVKKXmIw6WtsoF0SX3Eb85eSmsr4bV8yAfbZZ5T0QKQXlzOGDW9gucbZ+idkZUlwG8UnTt5tb4j5VCbK0WiUEmkIp9wuGCR1PYvADatq66KEo4aFZAXkrfYpiXNgBiZUqGRwTOaSpTS+1W7lUDRitM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vlDwZpHx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iHRCT/2zIklqVKvAzFFnIX5IPGUnVVxm0k+0MF0HW1c=; b=vlDwZpHxWdT4k2wlZ5CarV3BQc
	IJVV2Ghki1kWZLGrviAsrSJ77Ek/14U8o4uYFoOZMrDDKfTcKWCkajgEiJNb/6OXrov9GAh+Scg60
	MjGWWv6fbGQQHDaBDYrN0msac29a9nE8EcsGAGCh+Fu9BnsvHkvu1ttWokyczZhq25Cw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1un3dt-004s2n-8S; Sat, 16 Aug 2025 01:15:25 +0200
Date: Sat, 16 Aug 2025 01:15:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] net: dsa: ks8995: Delete sysfs register
 access
Message-ID: <d109e10e-6f61-40ca-8269-648aba33f8bd@lunn.ch>
References: <20250813-ks8995-to-dsa-v1-0-75c359ede3a5@linaro.org>
 <20250813-ks8995-to-dsa-v1-3-75c359ede3a5@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813-ks8995-to-dsa-v1-3-75c359ede3a5@linaro.org>

On Wed, Aug 13, 2025 at 11:43:05PM +0200, Linus Walleij wrote:
> There is some sysfs file to read and write registers randomly
> in the ks8995 driver.

I _think_ there is some userspace code to drive the switch. Its not
what we want, but since nobody has been interested in this device, we
have not touched it. Technically, this is an ABI change, put i suspect
nobody will care.

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

