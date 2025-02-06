Return-Path: <netdev+bounces-163563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678C6A2AB4F
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF919169811
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4015A2451F4;
	Thu,  6 Feb 2025 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LQxwxN/P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F7C21CA07;
	Thu,  6 Feb 2025 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852115; cv=none; b=J9VTK37BPd2cjud5gHMZVOSn+/pdnK6wmfYNTpnQTx0QFgjvgZr01eZT3imc/D1WxB4WTA1LeOYzRO1qpdqd2yN2nOYKTFYOy2Ddq2KbSWDqhntIwC2NGtQLe2BYeYWTdcMpIF5oIvbERdxsqH1ZznKWmJVwisfxLkN6QBRDVe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852115; c=relaxed/simple;
	bh=CSWRQp2seblvfaVAJmkrjY0nnZiVCyIvjy/vN8cwJoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi/9g2t9Rjh5E591DtUoNXguVjnc2XY5hR7JelgGKctoZJwG1aOqdhssRN8GV6uR9JET5nbJw3iRa2jCZpj/497KLbEMXTRFAXhV90xheoo1UUznFLobK/3d7xpfdTEMW85pTBmzUJkvdv33xhpE4Tk20rUJ2HVleXSXeuLEmSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LQxwxN/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E833C4CEDD;
	Thu,  6 Feb 2025 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738852114;
	bh=CSWRQp2seblvfaVAJmkrjY0nnZiVCyIvjy/vN8cwJoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LQxwxN/PFL14tXLzdUyICClAfmCUUaCOe80iN56eKpkvNytvRPA0wL14jx0s1L8Lz
	 7GsSOuHzNoSLPCQloZ84Lgj4i7tKE4P4akZYf8cPby6KHS6tiTFcOyih8sa3LNRbEt
	 fkt6iGMXCyTvi5Ch4L68DydJSx5ScuQQnN6UR8rc=
Date: Thu, 6 Feb 2025 09:14:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Santosh Puranik <spuranik@nvidia.com>
Subject: Re: [PATCH net-next 1/2] usb: Add base USB MCTP definitions
Message-ID: <2025020631-trowel-oppressor-6942@gregkh>
References: <20250206-dev-mctp-usb-v1-0-81453fe26a61@codeconstruct.com.au>
 <20250206-dev-mctp-usb-v1-1-81453fe26a61@codeconstruct.com.au>
 <2025020633-antiquity-cavity-76e8@gregkh>
 <a927fbb40ce2f89c57b427d4dabe5f730a523d80.camel@codeconstruct.com.au>
 <2025020634-statute-ribbon-90a8@gregkh>
 <829b7f7688e701fd246fdac717fd3fd7efc81d65.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <829b7f7688e701fd246fdac717fd3fd7efc81d65.camel@codeconstruct.com.au>

On Thu, Feb 06, 2025 at 03:36:05PM +0800, Jeremy Kerr wrote:
> > 
> Hi Greg,
> 
> > > Can do. I have one in the actual driver, but can replicate that
> > > here if it's helpful.
> > 
> > Isn't this a usb.org spec and not a vendor-specific one?
> 
> Nope, all defined by the DMTF - so not really a vendor, but external to
> the USB-IF at least. The only mention of this under USB-IF is the class
> code allocation, along with the note:
> 
>    [0x14] This base class is defined for devices that conform to the
>    “MCTP over USB” found at the DMTF website as DSP0283. This
>    specification defines the usable set of SubClass and Protocol
>    values. Values outside of this defined spec are reserved. These
>    class codes can only be used in Interface Descriptors.

Ah, ok, then a link to the DSP0283 spec here in the .h file would be
good.

thanks,

greg k-h

