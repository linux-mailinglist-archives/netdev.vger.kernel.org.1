Return-Path: <netdev+bounces-185834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D385A9BD3A
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 05:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800199A20C9
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 03:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29744183CB0;
	Fri, 25 Apr 2025 03:30:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22D183CA6;
	Fri, 25 Apr 2025 03:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745551812; cv=none; b=S7lS+hPokgvtg/R5xijSnBa8of4wKvZRTUBinyZDPxGM0qqoxRk/IhrM6sEWdh9pSQxGx/Xgf45r4k2GgnicDDCHv/CDzN35o3XDqGqUlwUUq7YdRvgMw3NxY1AwMudewvTA5vNF9tmme7ilC1ANcSRY824knNQ3dEa1kZeM4j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745551812; c=relaxed/simple;
	bh=gOf56mihxMyOdd5gu5wMRopNR9Mnpk5+9hN62Q4a5uA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tifWOYuYVWfUH9DktOMwxKHu2Rx800yFw/KcrOg5lciTZpPMrtC0q8ngqUdoNrlEvQetb2/qTz3qsnbXaVfp/RNoptGbtsBJrXS+i/nfiedImXQ9t9ptuMSsPeOckC9hG3Cbgst4ouWNYzoiRwhaD1hdYuTsF2KvlfCR4wBDsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.214.249])
	by smtp.qiye.163.com (Hmail) with ESMTP id 131231831;
	Fri, 25 Apr 2025 11:30:05 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: dlan@gentoo.org
Cc: andre.przywara@arm.com,
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
	wens@csie.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: a527: add EMAC0 to Radxa A5E board
Date: Fri, 25 Apr 2025 11:30:01 +0800
Message-Id: <20250425033001.50236-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>
References: <20250423-01-sun55i-emac0-v1-4-46ee4c855e0a@gentoo.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZH09DVk9JQkxJSU1NSE5IS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKT1VJT0JZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSktLVU
	pCS0tZBg++
X-HM-Tid: 0a966afecd6603a2kunm131231831
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhA6TQw5ITJWTj9KAUwvEEgt
	CAkwCStVSlVKTE9OTk5KQ0tMSkpIVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpPVUlPQllXWQgBWUFKT0xONwY+

Hi,

> On Radxa A5E board, the EMAC0 connect to an external YT8531C PHY,
> which features a 25MHz crystal, and using PH8 pin as PHY reset.
> 
> Tested on A5E board with schematic V1.20.

Although the schematic says it is YT8531C, the PHY on the V1.20 board
is Maxio MAE0621A. The article of cnx-software also mentioned this:
https://www.cnx-software.com/2025/01/04/radxa-cubie-a5e-allwinner-a527-t527-sbc-with-hdmi-2-0-dual-gbe-wifi-6-bluetooth-5-4/

Thanks,
Chukun

--
2.25.1


