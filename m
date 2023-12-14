Return-Path: <netdev+bounces-57353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7B0812F14
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765A3B20FF8
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE52405E1;
	Thu, 14 Dec 2023 11:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XLKrJ+1W"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1750BD
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cbM6jBRcRE07+cHX5id86O88/VmexCkPeMcQUJymDzs=; b=XLKrJ+1WG6eC9jirXyRr0KEpxO
	i8SnEygLrmIKxT4gZHemJdlBkuSBXbTzYWR7UO5/ggoKsrcB8y3SHxKgNN7uWf905S/8hkYDCRdXu
	rQxCKQMLMkNlcopS1VYUarEwiu4WeOsQJnxbp2rxuFxcagXmKd7ST0RnNJi1tC0y7lDM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rDkAP-002v6s-06; Thu, 14 Dec 2023 12:46:13 +0100
Date: Thu, 14 Dec 2023 12:46:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2 1/2] net: mdio: mdio-bcm-unimac: Delay before
 first poll
Message-ID: <66a216b7-73c6-43ee-af1e-09357a491708@lunn.ch>
References: <20231213222744.2891184-1-justin.chen@broadcom.com>
 <20231213222744.2891184-2-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213222744.2891184-2-justin.chen@broadcom.com>

On Wed, Dec 13, 2023 at 02:27:43PM -0800, Justin Chen wrote:
> With a clock interval of 400 nsec and a 64 bit transactions (32 bit
> preamble & 16 bit control & 16 bit data), it is reasonable to assume
> the mdio transaction will take 25.6 usec. Add a 30 usec delay before
> the first poll to reduce the chance of a 1000-2000 usec sleep.
> 
> Reduce the timeout from 1000ms to 100ms as it is unlikely for the bus
> to take this long.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

