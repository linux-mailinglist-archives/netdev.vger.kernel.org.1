Return-Path: <netdev+bounces-117208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2470194D192
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562611C210B0
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BBF194ADB;
	Fri,  9 Aug 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="10F/luVh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766CA195FEF
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211360; cv=none; b=h+aDiFM/Xs9XeVTDNsYRu7JOXkwGYn7U9BOF8u3PDa4SfutYINKdb7kIweR4IMX3Rkz4Cam2zNq3lAEBINdY+vrnvwulAgZcXhtb2Qe7rpjlNC8KOwoSGSJrjy9YuH6YzRxZAzw3IkHSPUCcyJ215OCCdL7gh+T93dYSxRRamUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211360; c=relaxed/simple;
	bh=C422Vlg2Ggms22Pek+y8qWJrqslYDFZjo4wPT4ceHRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ubxihM6LvSyY50sQHaeE3XIhzmX/VdRPCzhXrJs8zLK0pyfTY1h6Cjk/2f1Mxjmlordj/d9OJWNPm2w05+zFw+yWAs/eF9ZSBCQbtibyyHivE5dQA4e6pqm3QCSWRCxh6w/K5txLR9hCJfpzS/KhhLJRR8ZlPYFWM0/FITCOYgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=10F/luVh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AzzkjnDe986K0j1kDCc416xp+XmHkIOY5Pcs4nwgUkE=; b=10F/luVhx6SJf4ieht72zJpGaQ
	7CahP/+mzezeRyOYnw2Tq3E7UTKPTy6FbxdkN/t4I/18JczKIt9vx8r3uZ3ksghOHd2xJh43dMtXm
	RX81ZTrsigoapZhq75lc6HgsvHxuyPc8f3uDly0Zz5ut9WDx0NzSeiSRsxyzCH2HthCQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1scPzT-004NiN-Bf; Fri, 09 Aug 2024 15:49:11 +0200
Date: Fri, 9 Aug 2024 15:49:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: On KCM maintenance
Message-ID: <8633eade-5124-4334-900c-d0ee9620e9e8@lunn.ch>
References: <c99751b0-ce71-4a27-99c3-097b62078179@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c99751b0-ce71-4a27-99c3-097b62078179@yandex.ru>

On Fri, Aug 09, 2024 at 08:13:11AM +0300, Dmitry Antipov wrote:
> Recently I've posted a tiny pretend-to-be-a-fix for KCM sockets, see
> https://lore.kernel.org/netdev/20240801130833.680962-1-dmantipov@yandex.ru/T/#u,
> and now I have a question about the subsystem's maintenance status. Since net/kcm
> is not even listed in MAINTAINERS, it would be interesting to know whether the
> subsystem in subject is actually alive and worth any further development efforts.

Are you using it? If you are, you can keep developing it, maybe
eventually becomes the Maintainer of it.

	Andrew

