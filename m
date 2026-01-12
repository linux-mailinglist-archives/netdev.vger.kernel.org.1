Return-Path: <netdev+bounces-249037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90232D13057
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B7F530021C6
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C1A34FF4D;
	Mon, 12 Jan 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WO9meBC6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04EF1D555;
	Mon, 12 Jan 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227088; cv=none; b=a/b++PN/wMD7rGjG87limPbjsLWR0iWbwTFgOHy5qd2a1sgXgL2kRovzOLsjuEga+HgCmbC0NLhu/U5MvIlGniaiRdFkovH+x4xr4m5RV13m9e9UvVfEiSe0Qtr1F52MRBq5v7EeW3ABZsXd0/Gyq4P25Jn7nUwzXqORk2DgW1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227088; c=relaxed/simple;
	bh=7lrWSdDUtbzutpJ8Bd+iY4IwWHoB70kZ4hUO7fm6+20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssCaPDCH2hUTYm6k59my2A1SroEr63QH9fHV6pVXvh+A0o/8lwY+oZJxycxe+KyQNvRgnQQkEdsFI11sXichtAbpFsPzzvrKNKbe44jdhk8J7vFwL/5CRfzSr0y7ACpSKgqIoNyNT7KwZaibozPEeYyBA8wAzKuxubdkS2+oBTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WO9meBC6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cPfe4+F1jIR6NngD7tHxvuqFjI5b1NGNvcVIx0XSAp0=; b=WO9meBC6JFVYzT9n+3xSr0vVLT
	zxcw1xSA/aMOBUhxNeM8GjHtiNSaNVSX0rpDYdJMmqBMI0BTS91OZb+2lWuHStidjEEgbkTIMA3qQ
	hmAmx3UgHROZE/SbnGgy995EQ1RlxddrCDCWonGcHwpe0LDIObLo+KpPtSrdIEGyKbGE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vfIdb-002UCA-HD; Mon, 12 Jan 2026 15:11:19 +0100
Date: Mon, 12 Jan 2026 15:11:19 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/2] net: airoha: npu: Add the capability to
 read firmware names from dts
Message-ID: <81f98b9a-3905-4bd9-80ee-348facefeab9@lunn.ch>
References: <20260112-airoha-npu-firmware-name-v1-0-d0b148b6710f@kernel.org>
 <20260112-airoha-npu-firmware-name-v1-2-d0b148b6710f@kernel.org>
 <f57867a0-a57d-4572-b0ed-b2adb41d9689@lunn.ch>
 <aWT4vcBzG6UnaqOF@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWT4vcBzG6UnaqOF@lore-desk>

> > Why cannot this scheme be extended with another compatible?
> 
> yes, that is another possibility I was thinking of but then I found
> "firwmare-name" property was quite a common approach.
> Something like:

Having two different ways of doing the same thing in one driver just
add unneeded complexity. Please just key of the compatible like all
other devices this driver supports.

    Andrew

---
pw-bot: cr

