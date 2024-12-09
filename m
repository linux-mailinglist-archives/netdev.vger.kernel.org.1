Return-Path: <netdev+bounces-150218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041929E97E3
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11ECD161C34
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E5535968;
	Mon,  9 Dec 2024 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lJijZ8H6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F02233143
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752412; cv=none; b=J69OGwMcD1DrFFUd5ILiRZiCxk6py1ukFbSxSy5Cx2BpGmYh24Rws5oYxkd0a40XsJ84lFdAHekuxcTFVlI6uUk3xC3kN3n7Y8geXgro5kohsszEfvSfBd6b43bFTSlCxXhnujzvlmp8qpIB35kyWgmphPQc3eEBZfub2H04CgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752412; c=relaxed/simple;
	bh=NdYWu9ui2jli1j9SG00cpR62LKYqCRSMj9RHhcCfDj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TB5v9HX/FLcbv1iWmve7j9fC6FNOE7S9qFHsg+NhfzS8FU3UrLVPvsGv9yuO0PY8I/z+GrINRcJ0o7PvvW9qRKhM4j6L2va75YBkOKv5PK78zwV2L04Ch+FwGY7sdo/uQ3BeccFZaP7lUB7Wek9PhCk5+c9d1Byx74Is4U2UoXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lJijZ8H6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Df795L/8oi0yoDf9gxhYqR+JsRsVlQWIwAG4nZHxrBA=; b=lJijZ8H6Fe2Mo69+6R3crSKvdB
	GkIpkJX1Qwgk8qYtgTkkOGncyuPixfPWd0uVThYGFGCAJwU6T40UQEn8jmMiMw94Y0NzJ2kD8+NAi
	4/qouWTE2dorLncM8piqS+z2K5xElhfCUZeYj3i9Z6sSJdiw04w5MurZEXSSoPGr+Hes=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tKeCW-00Ffxx-Ja; Mon, 09 Dec 2024 14:53:28 +0100
Date: Mon, 9 Dec 2024 14:53:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tian Xin <tianx@yunsilicon.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, weihg@yunsilicon.com
Subject: Re: [PATCH 14/16] net-next/yunsilicon: add ndo_get_stats64
Message-ID: <e1b54362-7156-4515-af54-e71aabd6c198@lunn.ch>
References: <20241209071101.3392590-15-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209071101.3392590-15-tianx@yunsilicon.com>

> +	adapter->stats = kvzalloc(sizeof(*adapter->stats), GFP_KERNEL);
> +	if (unlikely(!adapter->stats))
> +		goto err_detach;
> +

Please only use unlikely() in the hot path, handling packets.

Does it really matter if you save a couple of cycles during probe?

     Andrew

