Return-Path: <netdev+bounces-176931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB10A6CB53
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 16:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A0C3AEF92
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE51F9A83;
	Sat, 22 Mar 2025 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aIUSs4tg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C02E3384;
	Sat, 22 Mar 2025 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742658753; cv=none; b=mXBB1vKpNteuaZH3TaUVGemcXZp0ExMGgbc5XTfHxVOCa+560crUfZMMdThskYEpdeSRU+PVEAu85g9GEYBTKHzgx5MduuSYAjoaWFK3WiRo6WnFPik/Aq9OKPrS5xAotYYBE4SGOokSFfVntTW0sWwRGvW13o21Uz00CgNP+rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742658753; c=relaxed/simple;
	bh=bSQA7OCHuKOu9w7NgL8B6dKiZ0vHaoBru/cr6bfmSVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTdvV54iEuK9vprR1IGmOdz6uw2o2maBR1EFbYgP+NjbI7D5uIDaSPlZbCVq6AVQ2TKE0embwKxXIA7kNOR9tUcRE64+MEjt78YmddN9YG4q+9KdhbfOLXZwHyjipYqj9Qu36RDymbNqnMAa4EOfNFmvCo7SZEmpHPH6r/rXs/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aIUSs4tg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vsZRsUkxremmctRBef6hb3E9OkHUEePV9lVqZZeM+b4=; b=aIUSs4tgPFN0/I+Ax0Sm3sKGFs
	WEVD7Br9JVlNIFttZGw7VZBMIKislwLITPjTh6xaPqS+Gce7Vg17W5kDGfKPvB7l9jwHmYmmnfRCc
	EvjuIwFCm3WDKNS36W2iq0HzkuIqBOHTNkFzbrCU25eG/w7Pk5HHtLfbqVcGfS/NLW0M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tw197-006jfV-C9; Sat, 22 Mar 2025 16:52:25 +0100
Date: Sat, 22 Mar 2025 16:52:25 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Klein <michael@fossekall.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next v4 3/3] net: phy: realtek: Add support for PHY LEDs on
 RTL8211E
Message-ID: <cc7452bd-4cf9-40b3-9382-563bc1ed12da@lunn.ch>
References: <20250317200532.93620-1-michael@fossekall.de>
 <20250317200532.93620-4-michael@fossekall.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317200532.93620-4-michael@fossekall.de>

On Mon, Mar 17, 2025 at 09:05:32PM +0100, Michael Klein wrote:
> Like the RTL8211F, the RTL8211E PHY supports up to three LEDs.
> Add netdev trigger support for them, too.
> 
> Signed-off-by: Michael Klein <michael@fossekall.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

