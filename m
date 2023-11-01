Return-Path: <netdev+bounces-45574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB017DE685
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 20:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF362812C9
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 19:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C1119BDC;
	Wed,  1 Nov 2023 19:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tvLD5QyP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3685E125B4;
	Wed,  1 Nov 2023 19:47:03 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954209F;
	Wed,  1 Nov 2023 12:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wYk75WWjhfRsVSIrzNnwPLbfZGcI7ZKnOifzPb2PiLY=; b=tvLD5QyPRht3WABrSXs9QsyqgP
	AbCUa6QUcXE+QcecXR0Ri9H5FmW4mJfpQqR85pOJ+v3J80KphGVmNeE2GwZIaE5vMmKyf2ncclPqx
	EIOnskEg7gE6oqw6PRMGXqHrQFKsvBRmVUzdPoaQ5KZZjL7v2hgka38ahFjbgtqmq/Og=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qyHAs-000hdr-5r; Wed, 01 Nov 2023 20:46:46 +0100
Date: Wed, 1 Nov 2023 20:46:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Robert Marko <robimarko@gmail.com>
Subject: Re: [net-next PATCH v2 1/2] net: phy: aquantia: add firmware load
 support
Message-ID: <6dca432f-2a25-4e34-b44e-7cca0b045566@lunn.ch>
References: <20231101123608.11157-1-ansuelsmth@gmail.com>
 <4b536ad3-2112-4f28-90e4-586b5745be20@lunn.ch>
 <65427400.5d0a0220.41c58.0ded@mx.google.com>
 <34a0b76e-aa0e-4148-ba01-c3b4608f17f7@lunn.ch>
 <65427fd4.df0a0220.28d26.1955@mx.google.com>
 <c9dad91a-1de1-4c30-ab7f-414552702009@lunn.ch>
 <65428629.050a0220.b2431.1edc@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65428629.050a0220.b2431.1edc@mx.google.com>

> Do we have API to check this? Or I think I should just check the iram
> and dram size and see if iram_size % sizeof(u32) is zero and return
> error otherwise.

Yes, that sounds correct.

     Andrew

