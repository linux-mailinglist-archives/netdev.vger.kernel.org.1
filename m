Return-Path: <netdev+bounces-162125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2399A25D53
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E6F1675B4
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CD2209F5B;
	Mon,  3 Feb 2025 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jakemoroni.com header.i=@jakemoroni.com header.b="qsXeo3ax";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DFkHIKxQ"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F010817993;
	Mon,  3 Feb 2025 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593551; cv=none; b=GaKYm+I08xjkUtULNANW2aZ/+ybrZ2pRTX5GELWEmryocg+q/QoZRvcNb3cEhPZBkpEMp58nCBlvrdpWgEUUfUrEwuwBw7YifVtEStsrdlHL5qDawZEwbg3tchOlKZIIKaCoHvgGGB2qxysALVAGeUqP562TA54LZmytlVtw/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593551; c=relaxed/simple;
	bh=b90PaZDxPp/ki9kXic/RjbO1DgE+6UZDZ2buzitcLGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMz7vkQLP2t2APwkn8i+TQeOYnVIdXW8qeLmY1kvt6s21Mxm/s5SAJy/kAi5S4wOckvojF6VtUi8nkS5wpGx1S4EoC1AywD7QS4IoTrM3o0mKooCHSaiFpuLFi9TgNem/+dkZ3pDdjiqhjmuXdr/8HQkYU1H5P1jRbOYT4ubuo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jakemoroni.com; spf=pass smtp.mailfrom=jakemoroni.com; dkim=pass (2048-bit key) header.d=jakemoroni.com header.i=@jakemoroni.com header.b=qsXeo3ax; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DFkHIKxQ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jakemoroni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jakemoroni.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 8CB95114011D;
	Mon,  3 Feb 2025 09:39:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 03 Feb 2025 09:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jakemoroni.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1738593548; x=
	1738679948; bh=KIDFoN5px6FR9kLVezjnk3p6g5EQ0iT1gdU0VPWNZ7w=; b=q
	sXeo3axF3f0TvErkGhkXvg53yfXXSbNT3EKmjLofRovijK3X2SE9a1hlch+/8h4a
	lsrRv8UYFO64vAc7vRrjTkIc+U8FCCiNPohDQlIogCEefnrO3DbVRMRGbpAxzo2C
	Ws+MWlbVLCMxlHgLyuKw7PySG8teNwc0EpoPY5dZac3kJl9p0WJlhVY0g6bhX8PM
	wvw2/x7OZ2QLi7N2vclxEOcs5MjPzFdIwcH4wh/sN4UWSRLQcBXx/SR5KHsiAVjO
	abd4HGUgg/eDPebCn9gBABWyV0aKOgIcJwCfcex5gUyhMaSrDTV88pdr07U/Gde0
	ugMo3CLH5w7NijNAk637w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1738593548; x=1738679948; bh=K
	IDFoN5px6FR9kLVezjnk3p6g5EQ0iT1gdU0VPWNZ7w=; b=DFkHIKxQ23trOkRdR
	1TwbWJle4CKpUpf7PQkOOKdAHjB8jOmwZGaEQbLmpmoVPwjP0bE6Wya6VlTGVTZV
	ML5b54dV5iHuYbCVe/iOLZsyflkrtsr6morqElT0BjU3p3Urdto4srgxvNcFx+0o
	YJ1H+guGJShsmYsEHombepy/C87UVx7t1dgfF6F6JfkrsdstgOmIZK2ntns616ak
	z79tDDh4BpZu9aQNldqFOtMX0XBdBXw/lPIgpk+rgnufPcLy/nllTjkauUoOHM8z
	oqIot/FR2A27rQxkk2mPjgnJxaGZvsLzc3tO2zjfOXh/D5jQdhwiiSrUEbR87muP
	+0Drg==
X-ME-Sender: <xms:CtWgZ9c3KntGTktRlyjc_av0R4nN36z8SDWJ-vrMKUUIqY6yICmGlA>
    <xme:CtWgZ7MMT5O0NlCiz_H--qmMVZzfKi2b6hrBf3yKoCB8KuAgMBYSPMKZq7ELSyeE1
    ls0yXMYjZZj7M63dQ>
X-ME-Received: <xmr:CtWgZ2iSdaTYXjvPeeAFVYI7wnvnar7E1X85RjzmlH4OF0Ue389TQGEZ1fQJAUiDHpl3orl9DN5y2GKYr4ceXmfbhXbq3ajLViyXpU5HiF9sg7QPZEPra2Ao>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeflrggtohgsucfoohhrohhnihcuoehmrghilhesjhgrkhgvmhhorhhonh
    hirdgtohhmqeenucggtffrrghtthgvrhhnpeeuieektedugeegteeftefhieekgfettdet
    veetgffgkeetueegfedvgeeljeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmrghilhesjhgrkhgvmhhorhhonhhirdgtohhmpdhnsggp
    rhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepihhruhhssh
    hkihhkhhesmhgrrhhvvghllhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthgu
    vghvsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnh
    gvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohepphgrvhgvlhdrsggvlhhouhhssegrqhhurghnthhi
    rgdrtghomhdprhgtphhtthhopegrlhgvgigrnhguvghrrdhlohhkthhiohhnohhvsegrqh
    hurghnthhirgdrtghomhdprhgtphhtthhopegumhhithhrihhirdhtrghrrghkrghnohhv
    segrqhhurghnthhirgdrtghomh
X-ME-Proxy: <xmx:CtWgZ28yXBR8DiE3JwlKZMte74ROGl_bSUGPUKFuHppiLIEgZ7PTQA>
    <xmx:CtWgZ5v3KH3BUy4tCKef-_lXt5bPaY7a7h6QbEeHQnc3CWNweHGwUw>
    <xmx:CtWgZ1FLsUaThf6GDhZvrH5jR8aC-BwbyTKfo1VIUd3AWUrYJANgRQ>
    <xmx:CtWgZwNpcYLQPAjXhA4RTgwMe1Qx13vUzpowNsyFNztFcnPzeXGu9g>
    <xmx:DNWgZ5Frmg-JAisxXzucESHt9RTYvdLf8wuDKuVH_7SKXw8bwua108GA>
Feedback-ID: i17014242:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 09:39:06 -0500 (EST)
From: Jacob Moroni <mail@jakemoroni.com>
To: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pavel Belous <Pavel.Belous@aquantia.com>,
	Alexander Loktionov <Alexander.Loktionov@aquantia.com>,
	Dmitrii Tarakanov <Dmitrii.Tarakanov@aquantia.com>,
	David VomLehn <vomlehn@texas.net>,
	Dmitry Bezrukov <Dmitry.Bezrukov@aquantia.com>
Cc: Jacob Moroni <mail@jakemoroni.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: atlantic: fix warning during hot unplug
Date: Mon,  3 Feb 2025 09:36:05 -0500
Message-ID: <20250203143604.24930-3-mail@jakemoroni.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203100236.GB234677@kernel.org>
References: <20250203100236.GB234677@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Firmware deinitialization performs MMIO accesses which are not
necessary if the device has already been removed. In some cases,
these accesses happen via readx_poll_timeout_atomic which ends up
timing out, resulting in a warning at hw_atl2_utils_fw.c:112:

[  104.595913] Call Trace:
[  104.595915]  <TASK>
[  104.595918]  ? show_regs+0x6c/0x80
[  104.595923]  ? __warn+0x8d/0x150
[  104.595925]  ? aq_a2_fw_deinit+0xcf/0xe0 [atlantic]
[  104.595934]  ? report_bug+0x182/0x1b0
[  104.595938]  ? handle_bug+0x6e/0xb0
[  104.595940]  ? exc_invalid_op+0x18/0x80
[  104.595942]  ? asm_exc_invalid_op+0x1b/0x20
[  104.595944]  ? aq_a2_fw_deinit+0xcf/0xe0 [atlantic]
[  104.595952]  ? aq_a2_fw_deinit+0xcf/0xe0 [atlantic]
[  104.595959]  aq_nic_deinit.part.0+0xbd/0xf0 [atlantic]
[  104.595964]  aq_nic_deinit+0x17/0x30 [atlantic]
[  104.595970]  aq_ndev_close+0x2b/0x40 [atlantic]
[  104.595975]  __dev_close_many+0xad/0x160
[  104.595978]  dev_close_many+0x99/0x170
[  104.595979]  unregister_netdevice_many_notify+0x18b/0xb20
[  104.595981]  ? __call_rcu_common+0xcd/0x700
[  104.595984]  unregister_netdevice_queue+0xc6/0x110
[  104.595986]  unregister_netdev+0x1c/0x30
[  104.595988]  aq_pci_remove+0xb1/0xc0 [atlantic]

Fix this by skipping firmware deinitialization altogether if the
PCI device is no longer present.

Tested with an AQC113 attached via Thunderbolt by performing
repeated unplug cycles while traffic was running via iperf.

Fixes: 97bde5c4f909 ("net: ethernet: aquantia: Support for NIC-specific code")
Signed-off-by: Jacob Moroni <mail@jakemoroni.com>
Reviewed-by: Igor Russkikh <irusskikh@marvell.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index fe0e3e2a8117..71e50fc65c14 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -1441,7 +1441,9 @@ void aq_nic_deinit(struct aq_nic_s *self, bool link_down)
 	aq_ptp_ring_free(self);
 	aq_ptp_free(self);
 
-	if (likely(self->aq_fw_ops->deinit) && link_down) {
+	/* May be invoked during hot unplug. */
+	if (pci_device_is_present(self->pdev) &&
+	    likely(self->aq_fw_ops->deinit) && link_down) {
 		mutex_lock(&self->fwreq_mutex);
 		self->aq_fw_ops->deinit(self->aq_hw);
 		mutex_unlock(&self->fwreq_mutex);
-- 
2.43.0


