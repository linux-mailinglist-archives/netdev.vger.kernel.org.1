Return-Path: <netdev+bounces-185950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7936EA9C487
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 12:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A26597A636B
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5267521CA05;
	Fri, 25 Apr 2025 10:00:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4758A1EA7CA;
	Fri, 25 Apr 2025 10:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745575220; cv=none; b=mgE4PsuRplBNfkuSu7t7Og9elb54h38bA0gmbfeiOjcgANrWArEuC6KBpH3EaaiBmc7IwuxCwbc/8iTOtcYE0SMKrnhgfR+sK5qPf6RCupjF2a35s22Omuc/extT0ZtKLzTe6OoqZo54R8Zjz8dIyzpa1AdpN5dvfHq/jduDqic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745575220; c=relaxed/simple;
	bh=y+hgsSoW5escKGuyH+qvE+QoIRRp1etqeugtEPrXybU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rD4jSEwbgvVEvA7y6oFN+a2bA5F57cyY1eOrsG+UnB/K1GtdINcKGoYGTJsZI4Bu9cryvQyVX04XArYV/goZlKfiY5KuVsTqRFSVdkterEd3KWnufANJdFGo1aZ7SqrIOef/xMJAXFbw0GVXu0WoGE9rPPoffe8uSSTpxkxjdXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.249])
	by smtp.qiye.163.com (Hmail) with ESMTP id 131fd5406;
	Fri, 25 Apr 2025 18:00:10 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: dlan@gentoo.org
Cc: amadeus@jmu.edu.cn,
	andre.przywara@arm.com,
	andrew+netdev@lunn.ch,
	conor+dt@kernel.org,
	davem@davemloft.net,
	devicetree@vger.kernel.org,
	edumazet@google.com,
	jernej.skrabec@gmail.com,
	krzk+dt@kernel.org,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	mripard@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	samuel@sholland.org,
	wens@csie.org
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E board
Date: Fri, 25 Apr 2025 18:00:05 +0800
Message-Id: <20250425100005.103807-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250425074621-GYC50408@gentoo>
References: <20250425074621-GYC50408@gentoo>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaHx4aVh9JHx5KTE8dHUsYH1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VJT0JZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSEJVSktLVU
	pCS0tZBg++
X-HM-Tid: 0a966c63efae03a2kunm131fd5406
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MSI6Cgw*PzIBET0LPjIcFiM5
	PhBPCQNVSlVKTE9OTkxOSUpJSkJLVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpPVUlPQllXWQgBWUFKQktJNwY+

Hi,

> > > On Radxa A5E board, the EMAC0 connect to an external YT8531C PHY,
> > > which features a 25MHz crystal, and using PH8 pin as PHY reset.
> > >
> > > Tested on A5E board with schematic V1.20.
> >
> > Although the schematic says it is YT8531C, the PHY on the V1.20 board
> > is Maxio MAE0621A. The article of cnx-software also mentioned this:
>
> IMO, then the schematic should be updated, I could definitely adjust
> the commit message to reflect this change, but don't know if further
> action need to take, like writing a new phy driver, I guess a fallback
> to generic phy just works?

The schematic on the radxa website is still V1.10. [1]
So how did you test it on the A5E board? Both PHYs
on the board (V1.20) are Maxio MAE0621A.

dmesg should show the PHY driver used:
dwmac-sun8i ... eth0: PHY [stmmac-0:01] driver [YT8531 Gigabit Ethernet] (irq=POLL)

[1] https://radxa.com/products/cubie/a5e/#downloads

Thanks,
Chukun

--
2.25.1


