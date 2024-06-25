Return-Path: <netdev+bounces-106473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B009168AC
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10A51C20ED1
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6161509A2;
	Tue, 25 Jun 2024 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="svdNGmah"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC4944F;
	Tue, 25 Jun 2024 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321464; cv=none; b=ka4g6sClljN5/gpMMHIzQ6C2mX3SddxnQBnUcUYd6vA8UUeQiXXOA8qafEg9f3J3s8g1QviV0xfEafpDQ1eh6zgFC60yz0B1BPbNtNrqU8do8m9GOd6/PnbiMUI/ARCge810Yk+rZl7y1dG+cTXqkDbliyVhhqKMs4b0hZoQEC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321464; c=relaxed/simple;
	bh=Km2O/8LEvjsKIhT+KosloJovi64FFNemp1kSS0ub1Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB3+7uMei/ATWqU5i67+kt9hSQEd5r5PKOwJi6K61jzle9/fB9xwZuOaQI8PqCBHBLfwCMGU72I6wrAYxmKp8SeNbQXWpixeoMc82+HnwGAWN7BbL/FIeGn/EtXMvDzGhLEH8NtlJZiUBMgg5jvjZnbzw/fcuLjFhOjQoarn8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=svdNGmah; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=O20xE0qt6orNwM9/ylWMLJ/0tfLwysXXVys/n8Q5dH4=; b=svdNGmahuVQH037pNuX8Wh6w1U
	nOJ7Zkt2yjJ7LgNVXHBxZEGdwFUpYhdjMIyh8bQg86VgWp1/sTlbTIiCrBb21DyJq/NSP3W4y2i4B
	Z3nTufFV53GTmu9F+RTUEAvVHlKDKhl5Y+b7z425wI2E0kpCKp1kWNNrdINYMfPF8FHg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sM639-000wQl-MT; Tue, 25 Jun 2024 15:17:31 +0200
Date: Tue, 25 Jun 2024 15:17:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Joakim Zhang <qiangqing.zhang@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, kernel@dh-electronics.com
Subject: Re: [net-next,PATCH] dt-bindings: net: realtek,rtl82xx: Document
 known PHY IDs as compatible strings
Message-ID: <de304f76-d697-4c35-858d-fdd747b1bea3@lunn.ch>
References: <20240623194225.76667-1-marex@denx.de>
 <cc539292-0b76-46b8-99b3-508b7bc7d94d@lunn.ch>
 <085b1167-ed94-4527-af0f-dc7df2f2c354@denx.de>
 <bad5be97-d2fa-4bd4-9d89-ddf8d9c72ec0@lunn.ch>
 <246afe9f-3021-4d59-904c-ae657c3be9b9@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <246afe9f-3021-4d59-904c-ae657c3be9b9@denx.de>

> git grep ethernet-phy-id0000.8201 on current next-20240624 says no.
> 
> > We could add it, if it is
> > needed to keep the DT validation tools are happy. But we should also
> > be deprecating this compatible, replacing it with one allocated from
> > realteks range.
> 
> I think we should drop from the bindings after all, I will prepare a V2 like
> that, OK ?

Yes, please drop it.

     Andrew

