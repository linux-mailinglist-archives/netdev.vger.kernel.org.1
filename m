Return-Path: <netdev+bounces-97608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7FD8CC50B
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 18:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112FBB21CC5
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 16:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD685141981;
	Wed, 22 May 2024 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q4LFV16n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71761411E0;
	Wed, 22 May 2024 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396276; cv=none; b=hc5cFsNwX9Gq4tJ07kWhn5YEr2RZq+qiiHzs2EcflDHG6m6UD/iwafdaxjGE+GCPn7ZKmlePQ1w7f4zlrEGN1Oz1jcN8cFdSyD0cBf8FeXMrP1Y9dPnN8RpTX5N3QGYC+YIrMSr5EnMGjvjf/6wxRwcYnriWjKiEIp47BAuuZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396276; c=relaxed/simple;
	bh=mRzXmGLEv1Sl8l3NlQK6F2G7/wyMGAx0/1jAxVbxsrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imJA4b+JlujEKhx8VzZUD/RV7s8F8i6FxCPTaInL7i8DxXc0q+udeB5P5ELWSvysL/gXydlPovJzQSaCIrLVAzxSD7QBzQrwJrGcP1LMbs4XWQl+DOY2c/k82xf1qGJasV+oNJ4UBfB9jeJZe842OjSPE+wSS0byLq+WbgCrNt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q4LFV16n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8Tfw1C5OBMTMu+sGe3XwcpMYANF6JY3ZkgMDDdPK8dI=; b=q4LFV16nCNg0Rizqr8jyU8IGeF
	AjtVn6vUasE2rVcjVzpGjksb+mOa2kwZMbL6rNU7JJjcpLXBfMmDxfdHYK8aoo0cVuGwSRc+d5w0N
	epsyLBEy/O/26r6YIZoOrJF3Yw+//6cD8xyzgTBE+WTCQdIoCKLEvFocS7Yc1Y3oK29U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s9p4g-00Fppo-EO; Wed, 22 May 2024 18:44:22 +0200
Date: Wed, 22 May 2024 18:44:22 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: smsc95xx: configure external LEDs function for
 EVB-LAN8670-USB
Message-ID: <9c19e0a1-b65c-416a-833c-1a4c3b63fa2f@lunn.ch>
References: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522140817.409936-1-Parthiban.Veerasooran@microchip.com>

On Wed, May 22, 2024 at 07:38:17PM +0530, Parthiban Veerasooran wrote:
> By default, LAN9500A configures the external LEDs to the below function.
> nSPD_LED -> Speed Indicator
> nLNKA_LED -> Link and Activity Indicator
> nFDX_LED -> Full Duplex Link Indicator
> 
> But, EVB-LAN8670-USB uses the below external LEDs function which can be
> enabled by writing 1 to the LED Select (LED_SEL) bit in the LAN9500A.
> nSPD_LED -> Speed Indicator
> nLNKA_LED -> Link Indicator
> nFDX_LED -> Activity Indicator

What else can the LEDs indicate?

> +	/* Set LED Select (LED_SEL) bit for the external LED pins functionality
> +	 * in the Microchip's EVB-LAN8670-USB 10BASE-T1S Ethernet device which

Is this a function of the USB dongle? Or a function of the PHY?

	Andrew

