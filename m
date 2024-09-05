Return-Path: <netdev+bounces-125588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9225C96DC9F
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258E6286712
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E7939FC5;
	Thu,  5 Sep 2024 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DVTJtwRB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E223B7344C;
	Thu,  5 Sep 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547939; cv=none; b=J4+8to7X5wAAbyIHGgs9Hf5+e1FPGkVtsFXKazWbXxaxI/MUcGXavT7P74tCFWqk8tcPzN5NN10Ss9H5tBitZMyKbe5sZZvfgIyaQFDapms7yL2UX1naNr5iXNdiVgxNawiXtg6DFpyH3ra/gtlaMbeiDYwmFyAQSzRKtUS3xXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547939; c=relaxed/simple;
	bh=8w6ipHJrQ4jetzjl0LvdLZKucKs7uEIh5LDKUWDSEeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RiotTnpStsNN3kOJUfMPOwMVm7IN0f8vGKvNw0bGb1YGLOZlqyOmp7z4/LyZLDsLpzzRiakCb5Oo9XcuWH+cLGfjike0O4FODu45oCxuWso/HFzBBbP5+X0stl06PXgmlGh7AxXlpQ16PAEO1S/+hx3R0dyNe/1n0eocLtVjoHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DVTJtwRB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AUX3c7zgOLHrrQH+Cs+O5d0xClcd4mrXpmxdwBSLSdw=; b=DVTJtwRBIjan8cQg+IiTds3o5m
	KPD+82eqvHgozI/+OyH8sKzchN95kATdSSlD0WONVTBcg76cA2VKGXqKqv9EEVLSwjO9BPWWJXMA+
	VXZwH8TTMVqNYhoHlnYGcb6UYUYM43zS7uMG0zVWMfyE3OOjGdPDtDzVqNiyMK9FE1Y0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1smDq9-006gwm-Rf; Thu, 05 Sep 2024 16:52:05 +0200
Date: Thu, 5 Sep 2024 16:52:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Dahl <ada@thorsis.com>
Cc: netdev@vger.kernel.org, Calvin Johnson <calvin.johnson@oss.nxp.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: mdiobus: Debug print fwnode handle instead of
 raw pointer
Message-ID: <710a17b0-576a-4b5b-89e8-35cc76681e8b@lunn.ch>
References: <20240905143248.203153-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905143248.203153-1-ada@thorsis.com>

On Thu, Sep 05, 2024 at 04:32:47PM +0200, Alexander Dahl wrote:
> Was slightly misleading before, because printed is pointer to fwnode,
> not to phy device, as placement in message suggested.  Include header
> for dev_dbg() declaration while at it.
> 
> Output before:
> 
>     [  +0.001247] mdio_bus f802c000.ethernet-ffffffff: registered phy 2612f00a fwnode at address 3
> 
> Output after:
> 
>     [  +0.001229] mdio_bus f802c000.ethernet-ffffffff: registered phy fwnode /ahb/apb/ethernet@f802c000/ethernet-phy@3 at address 3
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

The patch itself looks good. But i think this should be for net-next,
not net. '2612f00a' is not particularly useful, but i don't think it
causes problems for anybody as required by the Stable rules.

So the Subject should be [PATCH net-next]

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

