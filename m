Return-Path: <netdev+bounces-66440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FB583F206
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 00:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC041C227E1
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FAF20B30;
	Sat, 27 Jan 2024 23:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zeroconf.ee header.i=@zeroconf.ee header.b="TUI7m0H7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCD6604CD
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706398027; cv=none; b=WatYUmrIpdDMs9fktbokmp0cRYWk6rCEV187PKH3ARmFYapTxnht0rSd0ZTJbPb7WpD6WuL1t6CxFcT9m6fp6tFq+oAo+Pgj5MUREB2YSCZv89Eo4ZIvLcMiN3OXV5x2VDfZv7G4gqjs+MzA6Hej8d3oOgP10Y+SuN7HrBD8SEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706398027; c=relaxed/simple;
	bh=YTi8Tof+hUyyHd/GHvasPrRC9XQ6lN3coof8L1pVHKw=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=ejNEznfswAfp+C/ydNzJu88Bq2mLSD4F+gOSdzOJqNNTO5FEX8m3hqwLM+Oq2qKyDA6v/XqjFuf+87JbYV3dlccOBj/M8Abz00EA2OlVG6dMku/Lb35BvORDNh7QgW71zqiOcwU2pms5VKRKlaImwwuAmOiBIEcfuJhR+zruHcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zeroconf.ee; spf=pass smtp.mailfrom=zeroconf.ee; dkim=pass (2048-bit key) header.d=zeroconf.ee header.i=@zeroconf.ee header.b=TUI7m0H7; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zeroconf.ee
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zeroconf.ee
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeroconf.ee;
	s=protonmail; t=1706398016; x=1706657216;
	bh=YTi8Tof+hUyyHd/GHvasPrRC9XQ6lN3coof8L1pVHKw=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TUI7m0H7p/veOKGujQ6Z2S0pfAv3xiHxyjhvy/L+9Hf/JNR6m3XExP9udmXHmWSRe
	 j6+Gx1WmPCszc9dISASZXTUpIGoPuS8Bq7ByVd7FUAxx5BnNOanhWZJaW+LdUz6b7Y
	 V+iaaRjpwTlXVCbt/EPvB8MrJn8X/m9JTwwUCKWPXW9tkDTJuW0EewOsIz1TExp+m/
	 NpVUj1buSl8EJoR8i/FLEKxexp0ZrINNV0a6aAVSuj/pHH3QRebWclFFmvkrnlsj/H
	 jtCTeDMKIP1GrSiU2Gl7JHQiiPhUJuG9OOd4EbhIVzhJ3XEdAhUR+0Rak5NcoXJlKT
	 /bOUnBVMx7WXg==
Date: Sat, 27 Jan 2024 23:26:30 +0000
To: netdev@vger.kernel.org
From: zeroconf <zeroconf@zeroconf.ee>
Subject: 0bda:a811 RTL8811AU module
Message-ID: <56f6836e-d613-4799-9fa2-9d07506f61b6@zeroconf.ee>
Feedback-ID: 45224067:user:proton
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

RTL8811AU module exist for Linux - propose to add it into kernel as such=20
WiFi network adapter is used nowadays.
https://github.com/morrownr/8821au - this is suitable for RTL8811AU and=20
RTL8821AU Chipsets
https://github.com/aircrack-ng/rtl8812au - this is suitable for=20
RTL8812AU/21AU and RTL8814AU but actually works also with RTL8811AU as=20
the module name is 88XXau and tested with Linux Mint 21.3, which is=20
basically Ubuntu 22.04 LTS.

lsusb
0bda:a811 Realtek Semiconductor Corp. RTL8811AU 802.11a/b/g/n/ac WLAN=20
Adapter

When to search:
find /lib/modules/6.7.1-arch1-1/kernel/drivers -type f -iname *8811*
<nothing>
Same applies also to 8812, 8813, 8814.

When search 8821, then some modules exist:

find /lib/modules/6.7.1-arch1-1/kernel/drivers -type f -iname *8821*
/lib/modules/6.7.1-arch1-1/kernel/drivers/net/wireless/realtek/rtw88/rtw88_=
8821cu.ko.zst
/lib/modules/6.7.1-arch1-1/kernel/drivers/net/wireless/realtek/rtw88/rtw88_=
8821ce.ko.zst
/lib/modules/6.7.1-arch1-1/kernel/drivers/net/wireless/realtek/rtw88/rtw88_=
8821c.ko.zst
/lib/modules/6.7.1-arch1-1/kernel/drivers/net/wireless/realtek/rtw88/rtw88_=
8821cs.ko.zst
/lib/modules/6.7.1-arch1-1/kernel/drivers/net/wireless/realtek/rtlwifi/rtl8=
821ae/rtl8821ae.ko.zst

... then we don't see appropriate module, even no *au module, none of=20
them work with RTL8811AU either.


