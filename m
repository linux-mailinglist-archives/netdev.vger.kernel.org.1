Return-Path: <netdev+bounces-108457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CED923E48
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF9C1F22988
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E216B390;
	Tue,  2 Jul 2024 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Wj8FFfI1"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216D158871;
	Tue,  2 Jul 2024 13:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925251; cv=none; b=HgcvR+GZCwxwGg+/eT07ry6N9FVFu/sm7Q9o7PGQA/zhi4VmGUy8OkojZGZ0tVq57yaSrR/UBmaCCASoGNOiGiNSlKb1S72cqM5waQUErlW3hZABYNzx7Skrm5Q2y3wcLz0HJjVoKyZpNxd4v8JXV1VU3bOr4j6EVLdho0ElNW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925251; c=relaxed/simple;
	bh=RvmxtaLFdGmoMeX5gcNao/MxA1wPjlmJYp+uXmtLNyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ar+EAgj3SOCM+vDQB+Q6Ves95M5jFTKkeJD+ToyHWN/pPbv4ITDgmMoBIOUPJjTNsXcafxWpSS7HmvLduwqZvyHOa4F2xa6NOH6p2ZPYKUjgdjZRUuq/HqJtj3cgEUTUnnyP1LVqWzkUkFRFxUeuNZN0zv3FOiec08GlLckc5Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Wj8FFfI1; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 81880E000F;
	Tue,  2 Jul 2024 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719925246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oy9E7qoNPRI7001TLEist7NPC81uUt9cNPWX2cJ1Ft0=;
	b=Wj8FFfI1Om7ejfiiaOpF3dw3OLu3/ddogiz6e+B6gnvMviz0+00XxkxKEsofgVzY+1TVPg
	oDACI7Kq/5+6UcJ+wuO8u94ib1E1zfqnHAvB13xOVNTcSbBypTKHLrK6owyRMhvjDzltoi
	dnZpuDArsl5FTamSs55tStUGkArgh6zG1FkmahhMB5JtgR8AzElcD1CZGyymac2XozwlSU
	MlTU1IP+/OIhNEALRQlMj5gtJgUrwMA5LqVN+oD9AsKC/YLVC5cWb/s8BP6C8d0tsJGDzx
	2i19nLikAt38+6jjefyaOJIoFOXO2ufCwvawXfcf/3+Uu4pahVzFefOWCRnoFQ==
From: Romain Gantois <romain.gantois@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net-next 1/6] net: phy: dp83869: Disable autonegotiation in
 RGMII/1000Base-X mode
Date: Tue, 02 Jul 2024 15:01:31 +0200
Message-ID: <3633322.R56niFO833@fw-rgant>
In-Reply-To: <ZoPTPH3YQYMMe4YZ@shell.armlinux.org.uk>
References:
 <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
 <2614671.Lt9SDvczpP@fw-rgant> <ZoPTPH3YQYMMe4YZ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-GND-Sasl: romain.gantois@bootlin.com

On mardi 2 juillet 2024 12:15:24 UTC+2 Russell King (Oracle) wrote:
> On Tue, Jul 02, 2024 at 11:42:04AM +0200, Romain Gantois wrote:
...
> So, just because the PHY documentation states that speed is not
> negotiated, that doesn't mean that negotiation is not supported.
> IEEE 802.3 *requires* AN be implemented.

Got it. Thanks for clarifying, I'll remove this patch from v2 and see
if I can get this autoneg to work.

Best Regards,

-- 
Romain Gantois, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com




