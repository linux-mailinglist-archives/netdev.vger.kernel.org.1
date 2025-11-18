Return-Path: <netdev+bounces-239698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7879C6B743
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5A76B2A06A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AAE2E8B98;
	Tue, 18 Nov 2025 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MK3olLBN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6192F2D6612;
	Tue, 18 Nov 2025 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494322; cv=none; b=j4x367hAG8L+TSluebkZPsnyvNF/vJjYl4RqTdgeIKEQgozdHh+2LbQ8VLJUbZW80qouZjUbAF9NLgM+ZjI2EE/JvXIQsrX5IS+yNeUlRY6N6yt+/qrCMn5YoYtzh7QEwugBwWm131pK+YPlite3/b9zmK61oZlDwdLY2ISEVJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494322; c=relaxed/simple;
	bh=UKn6BWIiS/OjrcU/ikSxY+x13ucKZDiXLLHyTkEUy/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPiN5pmqyCwuHi2YwNQsGC205qwTpRBPD5tzegCgvikNnYB8YpoVAKUjTMhwvGWq4OxtJnrIAucSniAvQCM82JkTjw/woyiss2JLZMSZkOjhJu+qtgCuDRXh0GxSK4z2dxV8VbQ7MXeII4w+/F4iQItGT3NLDQ7kXAfcu7eDIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MK3olLBN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yWnVIJ2RhOOmy3Efjj9zwaco9pgKjYUQmNrVd85MEi8=; b=MK3olLBNIcKOirdddgVcra+loo
	NCHjRceUi1Baq259r1D3n4s8JjEVHaFPQRucEWZTLZ8y1z+ZE7TIbCL6l3RfQg6zQErBZN8GrKQnk
	ZkDT3p/552RLGILGgDZSUPJ0rBzauPwqOaYAwWhO6OBGQ/os9D7mVsuE2LZmF1HTlm6k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLRQb-00EOF9-Ok; Tue, 18 Nov 2025 20:31:49 +0100
Date: Tue, 18 Nov 2025 20:31:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Baltieri <fabio.baltieri@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r8169: add support for RTL8127ATF
Message-ID: <89298d49-d85f-4dfd-954c-f8ca9b47f386@lunn.ch>
References: <20251117191657.4106-1-fabio.baltieri@gmail.com>
 <c6beb0d4-f65e-4181-80e6-212b0a938a15@lunn.ch>
 <aRxTk9wuRiH-9X6l@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRxTk9wuRiH-9X6l@google.com>

> I see, unfortunately all I have for this NIC is the out of tree Realtek
> driver and it does not seem to implement the API for reading the module
> EEPROM data, and there's no datasheet available, so I'm afraid that
> either the Realtek folks pick this up or it's not going to happen.

Heiner is of the opinion it is not going to happen.

	Andrew

