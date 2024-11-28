Return-Path: <netdev+bounces-147778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37009DBBDF
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 18:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82082831A5
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B6D1C07FC;
	Thu, 28 Nov 2024 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RRTs6szF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F6C537F8
	for <netdev@vger.kernel.org>; Thu, 28 Nov 2024 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732815677; cv=none; b=NuOgNgbI+sL1jS0o6k2i0ePxOQ6LEc/PUie3fRl9PxRK4MxCoVNFaG2plIplnngV6w+cExQMJ1OsVS8XcxHdqqokFx5Yf0vJ24X8rQYkjY28Y9it15pewJWu8PLygXv2hQlb8Puyv5VDHVVV3RpR9VnDuTrDPCgMtkTEnsvL2GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732815677; c=relaxed/simple;
	bh=PlmrfMvYsfEAe4Nu+XoFLO1Gzot4DycTNo0txOKTJe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOMQaZFKocZcHfudChQbkgUSSe2F7arLLsEj6vr6x6j3II3/zF8BXyKGZsROu0UaGkDGZA8MKl+6miCgS5Jx7Wi8czMHLp3/R87t/Z+CYK+CZSb56wReeKBp5lTG6T4XdAw4B+8c7SK0M644KfmAlJNiJ52SjH+DYI3kbvZsGug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RRTs6szF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XyyoHNqARc4URpLOFxQevc0FxLUhNc9Xb/pojDmDKOM=; b=RRTs6szFsvOUoNnRJRkz50Z0fi
	RDf/NVj/YW3h+uok9YSQcmtPkHpFj8djeYGProZb1Bh7DwYOz97JS8HdR6Hm0X9z2gjJ7E5Sm8NaX
	rEGRpCJDyY6xrZbxnDXDQC5D0tmuemUAEiO41iPSohcvtrd7Vjly+Tim6LYBPUipDUw0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tGiVr-00EixH-TK; Thu, 28 Nov 2024 18:41:11 +0100
Date: Thu, 28 Nov 2024 18:41:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] ethtool: add support for
 ETHTOOL_A_CABLE_FAULT_LENGTH_SRC and ETHTOOL_A_CABLE_RESULT_SRC
Message-ID: <9d8b7d97-75b8-4e39-91c5-dd56b157ce84@lunn.ch>
References: <20241128090111.1974482-1-o.rempel@pengutronix.de>
 <919a9842-f719-41ac-96fb-ae24d2f0798f@lunn.ch>
 <eajj4mhvqkwrl7lmsrmjy32sncanymqefhxkv4cpnjvxnf2v7o@o6vtfpu7pyym>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eajj4mhvqkwrl7lmsrmjy32sncanymqefhxkv4cpnjvxnf2v7o@o6vtfpu7pyym>

> > ETHTOOL_A_CABLE_RESULT_SRC is a new property, so only newer kernels
> > will report it. I think you need an
> > if (tb[ETHTOOL_A_CABLE_RESULT_SRC]) here, and anywhere else you look for
> > this property?
> 
> Looks like a forgotten edit of copy&pasted text

Duh! Yes, i did forget.

     Andrew

