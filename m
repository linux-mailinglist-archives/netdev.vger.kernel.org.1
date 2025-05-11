Return-Path: <netdev+bounces-189549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E364AB2974
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 18:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E696C1885F6F
	for <lists+netdev@lfdr.de>; Sun, 11 May 2025 16:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E7D25A648;
	Sun, 11 May 2025 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="gdm7Ftz1"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCE42566F4;
	Sun, 11 May 2025 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746979600; cv=none; b=hAfIadLkboGPKt6uFLPpPu+Q2HaRVvmExpBG70WlnUUTW9B+VQpXtiAqmGifkiL+L3pjiE+TFC19ke0IfVbX64B0Oa4BIA2ITL/hzulXwJ/SBgUht0eodil998uP3jPLWj7NTduSjpgfljZvExi75+wfjV2QyzV0BRseY1RODus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746979600; c=relaxed/simple;
	bh=7jcXa1duGB4RLgLwkFP/05XRZV0fBz4a7PjTgDhagIQ=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=sQNtXRudMd9DMIJ3IdFm1CT2wcKqFiwf0zs0YvOqBGosfxtjqi+/NKbsFvzGft6gIWhVhyvmr94V351Oxd+dRW0wUQU+WXcFZ98DBFTLgwNt2/PkG5hrCBb2Gu17dEzCU45LK8aox9YTc4ui6+1HVjHNnv4esgqdpMC0/Hwf5N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=gdm7Ftz1; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1746979584; x=1747584384; i=frank-w@public-files.de;
	bh=7jcXa1duGB4RLgLwkFP/05XRZV0fBz4a7PjTgDhagIQ=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gdm7Ftz1w0u8z5QRFsnmx9AkK+ztIEv1syuJamnLPXKg/UjwnePHm2lzQlbNv70q
	 MT80DfyqpF2aMWdI85fR0EJhS6KQW/yIG9oJoNELcGTRHfjkwcIoDtZQoHfj68Ekt
	 JeVCjzqLP78rm+/1MwrpRIkwOpNOntvDd8gbA0nU88rZE6RfuGvPG6Q0rpKU6SGlz
	 MgZQ6bHiedEQ00L4rSwSvrtAhozCYEaSHPzTw5SLpljHl5L3gYr0agrx9Jwx6GEC5
	 jl4a7Sop7hpxcOgV9+ZwrH9RD1rU2N10y1b75QzArrFLeXf0Wj7gw+oxh8LNTqXEt
	 fFG7BanYwLRZ3ry6Gw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [194.15.84.99] ([194.15.84.99]) by
 trinity-msg-rest-gmx-gmx-live-74d694d854-wjlx8 (via HTTP); Sun, 11 May 2025
 16:06:24 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-9fe03bba-54ab-4395-b6ae-4cf1d91e1b72-1746979584333@trinity-msg-rest-gmx-gmx-live-74d694d854-wjlx8>
From: Frank Wunderlich <frank-w@public-files.de>
To: linux@fw-web.de, andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: arinc.unal@arinc9.com, Landen.Chao@mediatek.com, dqfext@gmail.com,
 sean.wang@mediatek.com, daniel@makrotopia.org, lorenzo@kernel.org,
 nbd@nbd.name, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Aw: [PATCH v1 00/14] further mt7988 devicetree work
Content-Type: text/plain; charset=UTF-8
Date: Sun, 11 May 2025 16:06:24 +0000
In-Reply-To: <20250511141942.10284-1-linux@fw-web.de>
References: <20250511141942.10284-1-linux@fw-web.de>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:P12+K2uFVSHcFESudIJQAhZEXoN0/qrWcaFHgGWi5rtrJDP3lhLhp0PRD15yk4yAD+Qei
 GdAejadAzkqN4wLdsaLo+PeZgfCS7PfzDC2C7cBTmAFLM+4PX1k4Aiz7OxMcszIjwJshP9SP22HU
 had3NWgewgnIyNelCik44jSVjhqrps9IdeI5NujdDhVrzIJejURMOXEpTIM1Ap9FTWB+ZtwvHB0V
 FU0bkw+3BFGfuEyt5jyEWZLTiAQ6KLjxGPShaF+KvPjOsCtWlN3uA8EaCXdE57Uc/+SDjQH+3YR5
 RnBmETZbhYJYzaro2rI2HK33ZiXcf7dUeYQTdLgsXyIyl+em7IfbDl0gqW24uV7DLU=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SixuLMgmyWM=;wNTrUbF3xMJPnUgIaLZ/oGRbd1P
 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

sorry for splitted series and duplicate part 9

my mail provider responded with "5.7.1 Command rejected" at part 9 and i had to use another one.

regards Frank

