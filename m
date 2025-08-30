Return-Path: <netdev+bounces-218461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB28B3C8F2
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 09:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42ED53B4FAC
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 07:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A99E2820A4;
	Sat, 30 Aug 2025 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="dct/rQSw"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F61863E;
	Sat, 30 Aug 2025 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756540519; cv=none; b=YJ32JgF47CHyX+VaEWTzdabIoHpao4HVhqPcb/FMM38W0DWEQQBnfGHxS5gfN7izNamdPlR6iwdMc7UdsNavVsRBptsSo2Yezlom+7PFLt7V7peimmuqToUqGg9Nc7upwau0LDAQk5bRsEdt5o7613w1wDIDe1h/adbFPImyqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756540519; c=relaxed/simple;
	bh=T8ihf112g9u2f1A9yPNf17Zec+yVLlF4arukt8xeoQs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=CYijnCqx8InDvGhy8g/+Fk438/TaYk+0kZNYWIX+dYSdx599NxX019tVJ9ziDNMjDT/Kv1PAB8lfneZx0wed1elcgDNCmuQQ8/RjrpIwsIKsi3gJkEGW2ZW8Bn3/5ZFmtif9CJVqQdRh53pjMaQbEmtyekv6UltLc2nOQoziUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=dct/rQSw; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756540205;
	bh=yaTeFtLRO5tvXwPuK3rKpMfJKgvbP8eLKfJv8XhYE/E=;
	h=From:To:Cc:Subject:Date;
	b=dct/rQSwlt79RFPAMIP52jgvAGu7jjpYGGxPv8iR5+/sT9io8wdEWpN2TaXrYWv3Q
	 1E3E4WHmXw2f9IUn77RMsoVofn9RtDAPLLMx2z4kyxgDv+KlnR5uvGrx6lDpePS7tN
	 feWrlfdCuY55wQBJsp23ad+jawqEFXh2nudJ9GuA=
Received: from localhost.localdomain ([112.94.77.11])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id C8218037; Sat, 30 Aug 2025 15:50:02 +0800
X-QQ-mid: xmsmtpt1756540202trj8vozal
Message-ID: <tencent_C4014DA405A96C2E1E7FEFCC050BA56D5B08@qq.com>
X-QQ-XMAILINFO: OTdDBJCpIhk9YryqmrHQtsEp+/lwYhUS9DFHYK/IsJuP7YXgWWHRrpoAOKMZIm
	 yxUQWHU3sc+dLmQ1g+hxGaYVmbwe6UPze307lhPbC7iQQm3JbrcVjmGxsSObXmCcvdnURNVxFEgp
	 5G7JRNEDaGjXYJw8dlfLip3AFBBNvDS+17czoeX5u/eK3In2ae/eYV8G50N35SOknKUI4sEvHvYE
	 y3HXAQ8fxqj4gnhRoeDgzAq/tlHdWWD4CN5B2X66KdOEsLCEWUB2PyXawpOiA21Ex4f4m8Yd01Eu
	 MrD6hpq4xvEbqh4vdMSCn5V4X9t6ClFo3NCgW++GjdkCJn49IUe7XGhhGFhD2rfE9sSjlb5i8rQi
	 EH0IIbeXpAluFzaFOdvO4spbXdS4KWxXYADOuTYQnDURp4qzqBVNywgLv6Kq3WlRXsA0qXGPnuoB
	 6eP8FQhvjNq8v+v5sMv7vlGGXgKF0S3WmlUPkXUcKyVLS2bc/vQS3KASTooeeOtNwbsPf2yKcSHI
	 H71GXsIPkEjP0KaRfYqhpLHnCKPYu4sTO7K/O3Bc1oXdCuxVDQhADNvqOf1HcguvjN4ZL0JB5HoV
	 c+sLW+SToDy5zBA3VBRbziQpb09FQdplg7ReC6lrr0apO0yBZ/n/2vUPXlnu1rHRC9tI66GuFHFs
	 3azBMM5LENOgA8R9OzFbkN9OO8s5SfKoZrwKb4G4EJUQJRmoiWB8/0OROnPzMpLPNfHfpjtQJRdo
	 0MJlARI6QP2d/HoUJznZ6H2kg6twkyKHRXbuSAEyApPZ72I8vr3OHJqOGDmC1fvMH0xO/+vj9HW0
	 9kdadXktzkpT+GtlCb5fWmQCcsBjJdyUkWKVAG6TRkWx3PRarIQmUrCvrFQkTIX1tHpVZLAUwscg
	 LBBzULMczLxBOrsTQU8Z9BWvG0KSRd/izEPPfrx5iUCzrd55FWJQyTKVz85k/fNJYPFHRFnEp/Qn
	 Abvrw4L2twZZgpT2oHF6n0c9W+Ms5W7RgQrPS9mommQJEUCGPhdBN/7FVO7K0uamndjs8g/Y+kjr
	 yG320g2HdvsamQiwOvz09Ij6Gtk7jy76sd8rMc0ESpSg4p0u0L0QUQ51wnGmc=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Conley Lee <conleylee@foxmail.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	wens@csie.org,
	mripard@kernel.org
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conley Lee <conleylee@foxmail.com>
Subject: [PATCH 2/2] net: ethernet: sun4i-emac: enable dma rx in sun4i
Date: Sat, 30 Aug 2025 15:50:00 +0800
X-OQ-MSGID: <20250830075000.2665991-1-conleylee@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current sun4i-emac driver supports receiving data packets using DMA,
but this feature is not enabled in the device tree (dts) configuration.
This patch enables the DMA receive option in the dts file.

Signed-off-by: Conley Lee <conleylee@foxmail.com>
---
 arch/arm/boot/dts/allwinner/sun4i-a10.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/sun4i-a10.dtsi b/arch/arm/boot/dts/allwinner/sun4i-a10.dtsi
index 51a6464aa..b20ef5841 100644
--- a/arch/arm/boot/dts/allwinner/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun4i-a10.dtsi
@@ -317,6 +317,8 @@ emac: ethernet@1c0b000 {
 			allwinner,sram = <&emac_sram 1>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&emac_pins>;
+			dmas = <&dma SUN4I_DMA_DEDICATED 7>;
+			dma-names = "rx";
 			status = "disabled";
 		};
 
-- 
2.25.1



