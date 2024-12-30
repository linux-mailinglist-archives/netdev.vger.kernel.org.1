Return-Path: <netdev+bounces-154544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5499FE793
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 16:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36D33A2352
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 15:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9831AB533;
	Mon, 30 Dec 2024 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GWPmMSIU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92091AB511
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735572605; cv=none; b=iYPrjZb18p1/X6+uLkvpkydDHAPKo1l46DxpLYYcpP131ppHAPcCCLTeVFs+3Itio7fSOHX2fJPCD4OojxBFMzkPPG9PZZ/UTHFfvvx83l1MN1adtbPGe4pBM5fMV+bn/xxYMtWsn8bkgmrJR3fX30j25dcV+KXkHfKSr0Nvfn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735572605; c=relaxed/simple;
	bh=le+HnG7eHKYcAdfbjRs9ozB2pniqM3T7EP+/US4t2YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RRGd06a57BvDlvdex0h5rxQXiDai8fY2Jv6r5tSDe/FEbrNl5eO75QYncoc95lCxwdgLLzocfYchGc1FVluwNdulHnKrBX0rf3az9iQQJQgEcuYA/aqOeK17jefynqywyQ4ZJD528qBzmCWefTluYRm058aHHL/pz9weUqivN7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GWPmMSIU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QWcHxL/dLXejch9Tcv0C5bnvEeegw0zbHynbBZXXA/o=; b=GWPmMSIUS2zeLvBdCmjZUajfkn
	VQF4Zjjj3kca3Gas0QWgMciPt32Lr+rxPMbmmtjsZLUf/raMxW46LxONZFJ6wsfwlUIS4qICmFtdT
	Vv/xBA+JXE0QQhPdqgMZGYC4QljtdT99rLwDI0D82fhMCbHHURQAE59hIStMSmurxE6E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tSHiF-00HZwX-Vi; Mon, 30 Dec 2024 16:29:47 +0100
Date: Mon, 30 Dec 2024 16:29:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Xin Tian <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
	jeff.johnson@oss.qualcomm.com, przemyslaw.kitszel@intel.com,
	weihg@yunsilicon.com, wanry@yunsilicon.com
Subject: Re: [PATCH v2 08/14] net-next/yunsilicon: Add ethernet interface
Message-ID: <9409fd96-6266-4d8a-b8e9-cc274777cd2c@lunn.ch>
References: <20241230101513.3836531-1-tianx@yunsilicon.com>
 <20241230101528.3836531-9-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230101528.3836531-9-tianx@yunsilicon.com>

> +static void *xsc_eth_add(struct xsc_core_device *xdev)
> +{
> +	adapter->dev = &adapter->pdev->dev;
> +	adapter->xdev = (void *)xdev;

> +	xdev->netdev = (void *)netdev;

Why have casts to void *? There are clear type here, rather than it
being a cookie passed via an abstract interface.

	Andrew

