Return-Path: <netdev+bounces-134867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7CC99B698
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 20:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37074283010
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 18:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C06B84E04;
	Sat, 12 Oct 2024 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wYMiyIvC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7EA2110E;
	Sat, 12 Oct 2024 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728757759; cv=none; b=SYIEzPV538NiMmLEpymiLpaoz5w7s7lRH9IqJm1mwKr2SU3y0OGMLmPHmFKG0Dmsb0FvdWtJp02mNgDKGXu60Z0uMhku2h/OZhwfUw+EM4Z+/0SPq1dBAcX24LiMfmdokEKSwddRLwE3dnlsKQtlKQZSMA37RJDT1SAROOcEOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728757759; c=relaxed/simple;
	bh=Qg8+YlMWVycQQ0N7V4mJ6bWJn6wFCTzfiXzJsajCrM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeIfz9AFzSrVhRZhzrQCB4r9VyircOseZpjGfp5JK1kpa3SatLNLTtbFiFn1ptYXmNXVFeF2gtlKrnq4rkZ3QbVFba/wb4gJ9Q5AgyPPXNpvg4AYckuSA9rOgGvkAXvNGbr2d22ACB7PD6pgCpCY+JLXRB3lFafIdUoBCjmGM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wYMiyIvC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JXGrwAJ4nPZdixL8Osla8TyTvVRvZyTkZ+Q5jkHPYos=; b=wYMiyIvCGjzwAv/fbxB3IFL4hV
	hmEb7g/dW9qnh3hz/neGGBuhLtpEkMxnJEuyOvqU8tnncm21lDlHV3AuvGYzs1b8Aacm6l0v4MgGw
	qMTj5qVWv+4K3x5NPBbiLiLsEp8NetfJvH5XUWl0lc/rXe/IwjuuTMzC5V0RVzH7Qxyk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1szgrP-009oRv-KA; Sat, 12 Oct 2024 20:29:03 +0200
Date: Sat, 12 Oct 2024 20:29:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jacob.e.keller@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net] net: ftgmac100: corrcet the phy interface of NC-SI mode
Message-ID: <e22bf47d-db22-4659-8246-619aafe1ba43@lunn.ch>
References: <20241011082827.2205979-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011082827.2205979-1-jacky_chou@aspeedtech.com>

On Fri, Oct 11, 2024 at 04:28:27PM +0800, Jacky Chou wrote:
> In NC-SI specification, NC-SI is using RMII, not MII.
> 
> Fixes: e24a6c874601 ("net: ftgmac100: Get link speed and duplex for NC-SI")
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/ethernet/faraday/ftgmac100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index ae0235a7a74e..85fea13b2879 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
> @@ -1913,7 +1913,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
>  			goto err_phy_connect;
>  		}
>  		err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
> -					 PHY_INTERFACE_MODE_MII);
> +					 PHY_INTERFACE_MODE_RMII);
>  		if (err) {
>  			dev_err(&pdev->dev, "Connecting PHY failed\n");
>  			goto err_phy_connect;

I'm a but confused here. Please could you expand the commit
message. When i look at the code:

		phydev = fixed_phy_register(PHY_POLL, &ncsi_phy_status, NULL);
		err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
					 PHY_INTERFACE_MODE_MII);
		if (err) {
			dev_err(&pdev->dev, "Connecting PHY failed\n");
			goto err_phy_connect;
		}

The phy being connected to is a fixed PHY. So the interface mode
should not matter, at least to the PHY, since there is no physical
PHY. Does the MAC driver get this value returned to it, e.g. as part
of ftgmac100_adjust_link, and the MAC then configures itself into the
wrong interface mode?

For a patch with a Fixes: it is good to describe the problem the user
sees.

	Andrew

