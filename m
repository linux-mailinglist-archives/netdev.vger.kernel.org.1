Return-Path: <netdev+bounces-105337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7AA910829
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 16:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5FB283958
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 14:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224881AED58;
	Thu, 20 Jun 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zk+9xPwz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6331AED3E;
	Thu, 20 Jun 2024 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893585; cv=none; b=d35SCmRzlH+rzdmTF0uvw8C1HAS9RFbfrPmZzGaML1asg+dvuI+fofvBivXvOErYshsqfm3caTiuToBVbTBRhBfhRLVNchBy4wLO/8cAgS15BL76DoYpZDY4HLG4JzL07QG9fLW77CKZL68A2wNk/8kbiKBdi29Ox+2/U3tH+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893585; c=relaxed/simple;
	bh=XWwDe1VKpwMVqs0REBUO+hdWW/rWocQVAL5pu75G2FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZEQXHpW+nX7Va1maAgXuc3KLBCAECtXY9LYYjJKYZVR0Wtve+UxbSBIBhYJBKg145G8WFyq+oEF5ZiIQQQuCfZodBj+qniR9Sh6Tzh/7fiAYzTAL4E5oHLf4CmTYVQhH7dqUWsh/ZEphGZ92exgUdUzebfq6d5vCCH4Z+dOUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zk+9xPwz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8CdaykppxAibWd0MPPixXnfXzj9mlnXYDK/ia2iIAnQ=; b=Zk+9xPwz0MaSNdxOuHy19lSruC
	uyGFRy5AxZX09Ioc866csrMzcvdOoDRWFYbO2sHTi8knYnTmxylLfc24yvLrci/tOiYFxo1+rhnEd
	fti62bmFMHyAjHce8c3tXZxhj/pU0csJ/4VIuH55ODCIM5WcZWSM3NOp9UpD0fViW2TA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sKIjz-000a9b-K4; Thu, 20 Jun 2024 16:26:19 +0200
Date: Thu, 20 Jun 2024 16:26:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: pse-pd: Kconfig: Fix missing firmware loader
 config select
Message-ID: <51e50892-bf62-4393-9910-ab36df6d9a85@lunn.ch>
References: <20240620095751.1911278-1-kory.maincent@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620095751.1911278-1-kory.maincent@bootlin.com>

On Thu, Jun 20, 2024 at 11:57:50AM +0200, Kory Maincent wrote:
> Selecting FW_UPLOAD is not sufficient as it allows the firmware loader
> API to be built as a module alongside the pd692x0 driver built as builtin.
> Add select FW_LOADER to fix this issue.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406200632.hSChnX0g-lkp@intel.com/
> Fixes: 9a9938451890 ("net: pse-pd: Add PD692x0 PSE controller driver")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

