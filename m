Return-Path: <netdev+bounces-214694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 480FDB2AE3F
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC2A18993E5
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA12334718;
	Mon, 18 Aug 2025 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3CrrFbAq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846B2765DF;
	Mon, 18 Aug 2025 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755534785; cv=none; b=lO2RYFwhFFW/lCY/opS7kxPXLGftEImZ13fHJJgW7a8q9/N1fLfNOL+fqu5uOL5rG3//iaCr91mkKHBh9GWV1vawvqq2H/ciQrHy5e0BHb++flWF4VGS+k2LCiJ2ehAvnE8F9gXcAnQ0aZ1onwNRtIl5ojfLc+hWTXMNGH8TaiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755534785; c=relaxed/simple;
	bh=LpDYJwQml6K7ScmsiUmXWa8XK8rlN0MtmCaLhB2epLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YX/VJUrcQrtMUnz30VpARwYiS35VWmgw2ENZ/MMjfOAa5K3BfRqp+lMF0VGnkWFVCTo7O6WyWaV3K4SPf2POAozw8ELLW87yNCAq2ZC417xoYFXftd3z/f8l4CE4VolYafYPBBTuyr1I1qoA+TWQerL4nwCeVbv74KAVUHadYCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3CrrFbAq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uL98pD1sQoXBkFIUFFARl4rYL5BwKpcWigS1+Rd6l34=; b=3CrrFbAqxFm95zZxWx/KmSHeZv
	daOW2p1YkZ6rqAw8WOfU/qms7I6+gqF3UsbRuN4sRshGQXkxYGyBH6C8p8XoI06NkQsNPfGxeerpk
	dwF287SNLYdgDQs0ITk8dS6KtcwLFopigXwi/OHnXwNp5YMP9vwFCMXr/qO3gKqDaG9g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uo2n6-00558J-5G; Mon, 18 Aug 2025 18:33:00 +0200
Date: Mon, 18 Aug 2025 18:33:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yuichiro Tsuji <yuichtsu@amazon.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	syzbot+20537064367a0f98d597@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: usb: asix_devices: Fix PHY address mask in MDIO bus
 initialization
Message-ID: <d6587783-6aa4-4e13-ae09-b5daa14c5859@lunn.ch>
References: <20250818084541.1958-1-yuichtsu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818084541.1958-1-yuichtsu@amazon.com>

On Mon, Aug 18, 2025 at 05:45:07PM +0900, Yuichiro Tsuji wrote:
> Syzbot reported shift-out-of-bounds exception on MDIO bus initialization.
> 
> The PHY address should be masked to 5 bits (0-31). Without this
> mask, invalid PHY addresses could be used, potentially causing issues
> with MDIO bus operations.
> 
> Fix this by masking the PHY address with 0x1f (31 decimal) to ensure
> it stays within the valid range.
> 
> Fixes: 4faff70959d5 ("net: usb: asix_devices: add phy_mask for ax88772 mdio bus")
> Reported-by: syzbot+20537064367a0f98d597@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=20537064367a0f98d597
> Tested-by: syzbot+20537064367a0f98d597@syzkaller.appspotmail.com
> Signed-off-by: Yuichiro Tsuji <yuichtsu@amazon.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

