Return-Path: <netdev+bounces-146863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A474B9D6597
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300341611E8
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 22:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AED18C002;
	Fri, 22 Nov 2024 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mlpBFJdU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1E18BC13;
	Fri, 22 Nov 2024 22:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732313670; cv=none; b=mH7psu/pTpoHqvnJYkWFMzhmcbtX8OFOyPiC9qmeZYdSIuZCVyb9iKH74cFWb5XqQp1CvSpgCubcL2yv3SJQxzdlmiWiNd75/oAjgb7o6YVVjXmJN6X2HF1IooKnNRn78lr7nt4rHvkIBgUwF4OYUW6FQaVCwvV+7mLoh8Avuw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732313670; c=relaxed/simple;
	bh=DTySUiF94kt6KM9h5HT6Dm3AHaTcDty/f6KtKg7DCAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ej3cDtJ5HN5GPEbkqKPuyhsL+PpgduzprUdNtuizEyCXcpXCBUk0mYLBSUSJbYivlpMvvF+WplgI6idLYGz0hANgUIXib2xgAZbGzJm7yCKGDUQh3qdm7eg++LxWTnez6mLW1d0YSFzWcSbLwNgu6VLLtdHAahgzj2NZX6VE33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mlpBFJdU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z+jLWzgwfDhFq/j4bG9u5BXkKaIk1MlvpIlrbWWVu94=; b=mlpBFJdUnMbhr2MCK3Iw2pw09k
	P8jHdc1UCDcnGwTC7joYKkr6gIrFjxc6xjUMccIez4/GUEjzDtZHQFal8LuATUBCNswBpL0OjXhCy
	hc26wVlkiUORf6QGm2gkMz3lBFtAFDCN0MBMIgEPhSXLliJpIdjcqFlV8YZWAsanlcRk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tEbuk-00EAcH-78; Fri, 22 Nov 2024 23:14:10 +0100
Date: Fri, 22 Nov 2024 23:14:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v2 00/21] net:yt6801: Add Motorcomm yt6801 PCIe
 driver
Message-ID: <78774ff4-2eba-4810-ae44-126756418103@lunn.ch>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>

On Wed, Nov 20, 2024 at 06:56:04PM +0800, Frank Sae wrote:
> This series includes adding Motorcomm YT6801 Gigabit ethernet driver
> and adding yt6801 ethernet driver entry in MAINTAINERS file.
> 
> YT6801 integrates a YT8531S phy.
> 
> v1 -> v2:
> - Split this driver into multiple patches.
> - Reorganize this driver code and remove redundant code
> - Remove PHY handling code and use phylib.
> - Remove writing ASPM config
> - Use generic power management instead of pci_driver.suspend()/resume()
> - Add Space before closing "*/"

Looking quickly through the code, i see a lot of yt_dbg(), many more
than typical. It makes it feel like you are still debugging this
driver.

Please consider removing most of them.

	Andrew

