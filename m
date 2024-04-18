Return-Path: <netdev+bounces-89072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116C68A95BB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 11:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F78281AAD
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239B415AAC0;
	Thu, 18 Apr 2024 09:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="c5rlRLvM";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="EJRlq9/s"
X-Original-To: netdev@vger.kernel.org
Received: from e3i51.smtp2go.com (e3i51.smtp2go.com [158.120.84.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A55215B129
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431545; cv=none; b=VB8zAUr6ZCmuwqY+d9YJmHewklaDJwpsl5eSTYCk/vWfVZM9ZsClbSw9h05FL0ctUycIVJY/Yiwnys0kl6xvip5yfKLMhVnjxrFZxwtk+gcintcYBkaN5CfhjrLW21dd/pOc6im/z/X+oJBQTPzCDkKWlPTWlomD06Ps4O22NSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431545; c=relaxed/simple;
	bh=wCjv6Xzm1cjaoi/YRo8jMzIxyS8oq6XhXdIspfSmHM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B57nZDRzo4j9A/gR9gEGx5/ZnQdbqSWCRXcKvExtpaiYkTAP8MKXEPkBbdJn/YuBJG39rRaDuVmjTf8fJm8HIeL436A8LJTMZ5EgB3gAYLqsP59to+Yaohuf3sn3GXJcR8IWVh9wN6qERrS1KcnXPgQQhqaDn2rGhK1gqt8UIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=c5rlRLvM; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=EJRlq9/s; arc=none smtp.client-ip=158.120.84.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rxNoQ-wSS1uD-29;
	Thu, 18 Apr 2024 09:12:10 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Thu, 18 Apr 2024 11:12:09 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v2 0/1] dt-bindings: net: snps,dwmac: remove tx-sched-sp
Date: Thu, 18 Apr 2024 11:11:47 +0200
Message-Id: <20240418091148.1968155-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Apr 2024 09:12:09.0319 (UTC) FILETIME=[7DC3A770:01DA9170]
X-smtpcorp-track: 1rxNoQwSS1ID29.mDeruQBEWwV3T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1713431532; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=SBklWFLQQtr8jhC7pbpaMUNxe5f++YTA1y6M3WTcp0U=;
 b=c5rlRLvMdsYU/sdLPNUpI+HTINXBLyvGvUj9RjkQBa/YW8mBIEej68idIswtfFtbcvEoe
 PhV+CSYKFF3dR65v8iao3AX5CRUeTVqdwJfGaQV28gWhqWGXovsplCUq0EV8rXFDPW3Scf/
 AnGouh08n9a7eDUGrkeRgu81y5AT/bAQoPtc6vUYRr1or70jdebWV+Ava719SrKT2uWmsyP
 Hav8MCbN/t6rGc7Tuh32ZTbT3LlHJzuuP4ahNQXf2y9SBk3P4r4EoWZI9qgR8uWiuvFQJmE
 vTWjhebAQ86SBIfrwOV7Y0t7fa2EvinMTD1m2QTvOuFh9dK6wz7dg80N1NoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1713431532; h=from : subject : to
 : message-id : date; bh=SBklWFLQQtr8jhC7pbpaMUNxe5f++YTA1y6M3WTcp0U=;
 b=EJRlq9/sdF5hg/75qNnkbIWori14p/twESBSfFyGSETluX1kx7rKcxH9bQWGQ4nZ2vqmh
 65jjjHKsQthZYLWmI4heW5cl5LJjZi3vOUyUlYibR8aikfFHGV8ZSWQGiz41CcNChsw35EO
 VN32leuKgBanmDlvrQrT7QX0whWY8gfwJAZ297tbUTfQqRh+8IaBSnTCERwehHY7bxw5YDx
 U1rjxRTmMsIAR/oXgzaAkqYdL75PJFAzWSfuOJbkM4zkvgNzsZ2H8u8dVgwY+YkCOaBk5iq
 k39Yddc6xICE54roXpmIJponQm0na3L26P837aJab/7gog9e7/R5UqEzZOHA==

Strict priority for the tx scheduler is by default in Linux driver, so the
tx-sched-sp property was removed in commit aed6864035b1 ("net: stmmac:
platform: Delete a redundant condition branch").

This property is still in use in the following DT (and it will be removed
in a separate patch series):

- arch/arm64/boot/dts/freescale/imx8mp-beacon-som.dtsi
- arch/arm64/boot/dts/freescale/imx8mp-evk.dts
- arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
- arch/arm64/boot/dts/qcom/sa8540p-ride.dts
- arch/arm64/boot/dts/qcom/sa8775p-ride.dts

There is no problem if that property is still used in the DTs above,
since, as seen above, it is a default property of the driver.

Flavio Suligoi (1):
  dt-bindings: net: snps,dwmac: remove tx-sched-sp property

 .../devicetree/bindings/net/snps,dwmac.yaml        | 14 --------------
 1 file changed, 14 deletions(-)

-- 
2.34.1


