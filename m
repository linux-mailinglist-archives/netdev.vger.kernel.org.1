Return-Path: <netdev+bounces-270403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABZUIgv6wGkwPAQAu9opvQ
	(envelope-from <netdev+bounces-270403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:30:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8C52EE441
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6BCB30541EA
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE25314D18;
	Mon, 23 Mar 2026 08:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="D5NVCqwj"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79EE370D4B;
	Mon, 23 Mar 2026 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254255; cv=none; b=sX5DyDOBHKFx7L932Te02wHywaRhjS8Sdg9pCPtFFuo8fm06w874PSzX/qfkG1l085Xf/zOMOP59ZTHvl1OtQrjnaxOfCX3f/Tp9w3I93K+V+tXOnz+d2+14LqtrOGga+MjE5oA3P+Xzf5m8ruNtq+vz7eurMlbFHmm4QnZBKcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254255; c=relaxed/simple;
	bh=gpx3mhGOm2p/7alkBZWZ7X/PV1+meODDglmJNr0lC6A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jov668E08+I8JlFfmmgtjoPAcMg2brQIEplkaNQ3bl/qxCFu7D5kYtDlrJa/E9RjtJKKTAkzUPtSpp/cisRFR7xWmaC2J8bf0F9TcV+dcrpcm/S6UwluswK+YQ7IOX3d/TPalr1IdIHATVOqXTHWnUQ5E6JhID5UA+vk6mHQUe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=D5NVCqwj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62N8NbxeE2786278, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774254217; bh=h5g3GvQL6RPW5GeTObH1nKyqwTZPKov9gdeiGIokdiw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=D5NVCqwjnMG/nqDGoKv8VqIy9FMQCqBlZLFLLGqq3E26TYy8TmNaidPkJyOxt2Bex
	 vFQ1KtMUAebfC0cPYsaZQuLowTpTlkh3ZtaCgAyDM3dJ1grBkh840Mo5H6A7cHkIHr
	 bxRG0ynOC6eVFGLIbhAVIt8x9Vi7qdgfWDmGOo6oDX0KV4+5ChkdFcRh4SFCvG3xWO
	 I2d9/sZ/W89iy2r3SuorsoFT5OVRhc8IW7J6eydxegEdSNCONEGecXVBC0mMyaBa4N
	 1SzIMZPeVlSVPCQMFxkD4uMiUtzhAK/CnOgyleEmP6zKdYNxQfjWq/0W+KnZN4UC15
	 Cr/NS1WXK/puQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62N8NbxeE2786278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 16:23:37 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Mar 2026 16:23:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Mar 2026 16:23:37 +0800
Received: from fc40.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Mon, 23 Mar 2026 16:23:37 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
        Chih Kai Hsu
	<hsu.chih.kai@realtek.com>
Subject: [PATCH net-next v3 0/2] r8152: add helper functions for PLA/USB/PHY OCP registers
Date: Mon, 23 Mar 2026 16:22:24 +0800
Message-ID: <20260323082226.2601-450-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[hsu.chih.kai@realtek.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270403-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:dkim,realtek.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DE8C52EE441
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v3:
- For patch #1, fix the issue identified by the AI review.
  In v2, ocp_byte_set_bits() was used to update the USB_LPM_CTRL register.
  However, since its function only perform a bitwise OR operaion, it fails
  to clear the old bits when updating a multi-bit field like LPM_TIMER.
  Therefore, use ocp_write_byte() to maintain the original direct-write 
  semantics.

- For patch #2, fix the line length exceeding 80 columns

v2:
For patch #2, remove variable set but not used from r8153_init(),
r8153b_init() and r8153c_init()

v1:
Add bitwise operaion functions for PLA/USB/PHY OCP registers 
to simplify the code.

Chih Kai Hsu (2):
  r8152: add helper functions for PLA/USB OCP registers
  r8152: add helper functions for PHY OCP registers

 drivers/net/usb/r8152.c | 1800 ++++++++++++++-------------------------
 1 file changed, 634 insertions(+), 1166 deletions(-)

-- 
2.34.1


