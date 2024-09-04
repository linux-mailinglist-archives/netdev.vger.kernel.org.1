Return-Path: <netdev+bounces-125047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5F596BBCA
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE0F2827D9
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C8F1D014F;
	Wed,  4 Sep 2024 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XGdwRk8w"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F481917E3
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452196; cv=none; b=IEF2pfXOD5qv8F6idxRxY4VS2pUGGp/4Wj+WErrFes5Xrzn0HC0cOlfQ3Ky3WBBghIoj7f0yEbc0K7G2165ceiMVPH2kHrAE7YHEYpcbTTEHXHIvK1IV8PhHDgT0vbTYW2ogfvSoA2WZFYMoPq7b/QK1DIOEBbLboTC0sXUuwrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452196; c=relaxed/simple;
	bh=LteeI9+VtxZdxdZZvmjD4ATbaq7K8NkY22FVoMqoYqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kv0WSuEM6TlY6gT+vAi8E9k9SRi1Iup3kYTVJ9FwR+H8uHHkmv4ldHoCW80xqiyIj+4585VBspufJ89TnSJsO+qa0VMJlXnifAlnmyqsos++WEQnfTjgr7vm4mV8OPfFIYwrZPVwNr9bD6upG5MlC7cIkNU3dydN1FRteEHLP7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XGdwRk8w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=osAGMErYOvKMvVIU3g+m1IzBiMtRy6NwcTXgDijjYyc=; b=XGdwRk8wPKjf2wNTw6ezvCB6ml
	eULVJScy/DHAfKlEda7IUJX+ppsjreuNWhSwzSf4ZtEOQ8Czy2p3L2y94e5mX8fqiaZL1/c4PzuH5
	v6XJAqvgrsffn5BUFLXCW6NT1+HxEj+ebgbdOMYO6vJoyNTA5bj7zhSaAwDyyqLPigY0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1slovo-006YEv-PN; Wed, 04 Sep 2024 14:16:16 +0200
Date: Wed, 4 Sep 2024 14:16:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: lan743x: Use NSEC_PER_SEC macro
Message-ID: <03dd432b-ee79-4d82-b8b8-83e04053acea@lunn.ch>
References: <20240902071841.3519866-1-ruanjinjie@huawei.com>
 <aa679b67-6580-4426-9edb-d0f5365ae3e9@lunn.ch>
 <5cfbde6c-0e6e-6c1f-c872-23fd00494b77@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cfbde6c-0e6e-6c1f-c872-23fd00494b77@huawei.com>

> > And the next question is, why is the driver checking this? It would
> > make more sense that the PTP core checked this before calling
> > ptp->info->settime64()
> 
> There are 2 places call ptp->info->settime64(), it may make more sense
> to check timespec64_valid() here and remove these check internal like
> lan743x_ptp.c?
> 
> drivers/net/phy/micrel.c:4721:          ptp->settime64(ptp, &ts);
> drivers/ptp/ptp_clock.c:103:    return  ptp->info->settime64(ptp->info, tp);

Yes, please extend the core.

	Andrew

