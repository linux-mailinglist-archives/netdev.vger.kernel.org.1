Return-Path: <netdev+bounces-165577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9517A329A2
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7309A1626BE
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E037211276;
	Wed, 12 Feb 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="pgVy6JJd"
X-Original-To: netdev@vger.kernel.org
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [80.237.132.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EE1205AD9
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.132.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373247; cv=none; b=kATaNUtqMixii6lUrMrlUh6MopJMckBip2QiaR2347cQKItHH48IV+AwbiYW596osMHYXS13cJjYgwgbUfUZomCrP3Cj/C4QL9BXSPwrvBbg5+6alqEHrid8lgNtpdBNTlnHirfY1CTddy9+7P5N4f0uigOyXwKLWreYbAPye/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373247; c=relaxed/simple;
	bh=wRs7RL/nb1La/mS0JQLX/mQ7LIOOGiK+r3WF+JHtNJ4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=FK+xhM1pWJ54k9zVpFD1sX/oBdy/qzbyKkOI9xxer0EQXlTsKvzlz83fY+2Whm/JVOHxTLG3K1Vb2dqE1InT/AZLdBzy8vG3Du73aS8WoecdsEnrgA/tU5IaG1C5RhgFTc7CNLAmCXOFCx/SFFA3KV/cLccf6MBxb9K7r01CWgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=pgVy6JJd; arc=none smtp.client-ip=80.237.132.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=birger-koblitz.de; s=he134867; h=Content-Transfer-Encoding:Content-Type:Cc:
	To:Subject:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rxrIhiZoQCId+KfYQ4i6LZzBBQcjZh8whrj8c58uS7k=; t=1739373246; x=1739805246; 
	b=pgVy6JJdB+OTIhAd8VYQ74zwhAV9Yh5R05z4vhhEmq1ucUDHvSSdgyhET1Y0C/I3JiXw7dQNuQW
	mZltnsSH8pLAF+xAxXen0FKC6PmorKCsv+8YiQGSmmHneZzs+PWfS0wOT//vLGMklpvuJ2tdchU4X
	WpCdq6vDHydJpAqmCi7zZq4IeSeUIg19w81bQE6lN3qazZhsNMcsUsCfCrnjoDm+ftT5X71PAStIQ
	S6q6WAkVvMfv3lFpUxK6zghC0JBlIduXkUHFkfkuzJYGS234NcF34zKhuTDy24vqjs4xMJwY19rbX
	ux+QvgAqrqWGdY7Wz750Ri5SOhlQ+/Osdp3Q==;
Received: from [2a00:6020:47a3:e800:53bc:9d06:1c16:3a4f]; authenticated
	by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1tiER2-004rlC-0s;
	Wed, 12 Feb 2025 16:13:56 +0100
Message-ID: <ec28ce6c-24fc-42f5-be68-4968bc78196b@birger-koblitz.de>
Date: Wed, 12 Feb 2025 16:13:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Birger Koblitz <mail@birger-koblitz.de>
Subject: [PATCH net-next] net: sfp: add quirk for 2.5G OEM BX SFP
To: netdev@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1739373246;76c6b2f4;
X-HE-SMSGID: 1tiER2-004rlC-0s

The OEM SFP-2.5G-BX10-D/U SFP module pair is meant to operate with
2500Base-X. However, in their EEPROM they incorrectly specify:
Transceiver codes   : 0x00 0x12 0x00 0x00 0x12 0x00 0x01 0x05 0x00
BR, Nominal         : 2500MBd

Use sfp_quirk_2500basex for this module to allow 2500Base-X mode anyway.
Run-tested on BananaPi R3.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
---
  drivers/net/phy/sfp.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 7dbcbf0a4ee2..9369f5297769 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -515,6 +515,8 @@ static const struct sfp_quirk sfp_quirks[] = {

  	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
  	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
  	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
  	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
  	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
-- 
2.39.5


