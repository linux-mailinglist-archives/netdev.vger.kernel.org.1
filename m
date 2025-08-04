Return-Path: <netdev+bounces-211610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58C3B1A5B4
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 17:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06F0A16B87D
	for <lists+netdev@lfdr.de>; Mon,  4 Aug 2025 15:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E21E5B9A;
	Mon,  4 Aug 2025 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="N0xbsqUb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4871FDD;
	Mon,  4 Aug 2025 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320767; cv=none; b=t26anx3C1TiPMxAxTZ8bt9v0g+WLq5+EE7hu99qwT0GCxHGeti2aaV/B5isNkRtVloa0eioLwepTcxjUSB/0AO4nMja4tRzMF95WDFB5hQ2mRv1nRnt9f0+FD0kYRNXu9R+7GsE0S+VruxFJ4IrNTV0pY/U4017EuLGjXJuWcxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320767; c=relaxed/simple;
	bh=tLmE3WXsenM+XW0MonpeN53bOJztf55lD18wPzSHs3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnMpyweZkZXEwaiOT121W8o/I2FzkvIHU9lVPXUAkDoiZHeUcHbMUmdLh0SZdxrxGAlqIs0fu5pAnSWt355Nc1IOTDfBpBrD/fUTkAnDmTUdfk4BxQoS1CGvdS1wVEFD7k1yXirb95db9ilIlWWDt3sHlCFrTWCb7noJR8q1nEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=N0xbsqUb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=f1Hted8ZhuGeXw5n90ht1JZ+BCQLIBgv7Q3px4nrAlg=; b=N0xbsqUbLIkjvuSnioPeSVBR2M
	TtsiAw5YoYlgqQMaRmaiztDoH2p8iY+84gr3Maui9Xf6hW409sL0+iRxlzOCmjmC++BCg9cPpDC75
	1QJEIz2+blGAwpzbdpBwaNx+rIHGaKbztLGPZ6Svff4WlMrwTfH8mCy3YNjA1+YspKZ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uiwy7-003isH-FR; Mon, 04 Aug 2025 17:19:19 +0200
Date: Mon, 4 Aug 2025 17:19:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Michael Walle <mwalle@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, nm@ti.com, vigneshr@ti.com
Subject: Re: [PATCH] phy: ti: gmii-sel: Force RGMII TX delay
Message-ID: <3bc6476e-7539-40aa-b499-253273357a1d@lunn.ch>
References: <20250804140652.539589-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804140652.539589-1-mwalle@kernel.org>

On Mon, Aug 04, 2025 at 04:06:52PM +0200, Michael Walle wrote:
> Some SoCs are just validated with the TX delay enabled. With commit
> ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mode for fixed
> RGMII TX delay"), the network driver will patch the delay setting on the
> fly assuming that the TX delay is fixed. In reality, the TX delay is
> configurable and just skipped in the documentation. There are
> bootloaders, which will disable the TX delay and this will lead to a
> transmit path which doesn't add any delays at all. Fix that by always
> forcing the TX delay to be enabled.

Please could you add a paragraph:

    This is safe to do, and will not break any existing boards
    supported in mainline because...

We have to be careful of regressions, and such a paragraph makes it
clear you have thought it through, and what your assumptions are. If
something does break, listing your assumptions will help finding what
went wrong.

   Andrew

