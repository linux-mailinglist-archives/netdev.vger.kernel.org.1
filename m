Return-Path: <netdev+bounces-109898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4218992A391
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF92628326F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448F0137747;
	Mon,  8 Jul 2024 13:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b2aJVW2D"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9669DB665;
	Mon,  8 Jul 2024 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445003; cv=none; b=T4oo1+EdRv9ywOgpmHVVW44i1p22d+xglCumc1g79NuAp3WFeKhOojogMJpzlyCZ5PNq4pYLHTQGMZV4JjMxztiDvSAnI9qoGAbaQncVO1Y6ox7tc9L+hOEkYlezHyK0BAMN8FNM4tWZEijheTgDEKXe7mdxweptnBnFkTwEOKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445003; c=relaxed/simple;
	bh=aZVq7t7osR1ZmA+3Xs7k3vunUD2x459QFSfrOfDQ/kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4BTJIbrz/NwODtO/rdlh+e8Bwd2wO9iF4VYolS1d4dy1oOB6m/Gum+c4gNljaydv1/lMQfYuFZdUao4pLTkjAcYoc+htgqwtZDbws3pNE+OTfsJQ6amu9shQJ2UUqfVnZv0EHa/HZV1ltzqfKKNjonzRDhQMN4dT6Wx4UXUuYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b2aJVW2D; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=M8NMNA3zTI/hnWvr07zHKvINFSFnOGVJ2cl5kzK4BRU=; b=b2aJVW2DEDZigvmPZvv1Q8ZEwD
	JsCXDp+ofSS/P0d+HC1QSwYDtKCsL5oppPo8HxtFAqoKsE3TfYFsmilw56F5uNOeGxTPMGUTiWbzf
	szz/MuaTmuVOORDYnkhpWAnLJNQ2Tip55ANLw/ujRjrmWIPePMb2DE+xAagF3oqviptc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sQoKk-0022gl-FC; Mon, 08 Jul 2024 15:23:10 +0200
Date: Mon, 8 Jul 2024 15:23:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next v3 1/2] net: stmmac: qcom-ethqos: add support
 for 2.5G BASEX mode
Message-ID: <27f1d5b2-ad4c-4ec6-805c-4e895b5d1916@lunn.ch>
References: <20240703181500.28491-1-brgl@bgdev.pl>
 <20240703181500.28491-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703181500.28491-2-brgl@bgdev.pl>

On Wed, Jul 03, 2024 at 08:14:58PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add support for 2.5G speed in 2500BASEX mode to the QCom ethqos driver.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

