Return-Path: <netdev+bounces-246040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 237B8CDD5C3
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 07:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F68530198E8
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 06:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4187F2D5922;
	Thu, 25 Dec 2025 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="T8KUI57i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A8239567
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 06:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766643711; cv=none; b=Tj+BIrSl6YZhhIr36xxaPsOA80WP3UTyUaJTi1Esc0hASAmR/EKZ655cumxMR0BWmRzkd9+qPV+xvAsPvjFxkh5H1vW/v/gdgJZvfIzCSCv0ip4dAO/MKjwVLpxasaqi1HU3wuFbn0y/3xJEOOjyr0yK0BLh787AKrH1CZaOVho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766643711; c=relaxed/simple;
	bh=8KT393hJmDW25dxLnKFfS93ZqLgfyPqtStQUqjhJoVo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Lq2gGdU0dq0xyovEWXo9vjO0EJA4LN3NEgg6Fjf5cHDC/d6NPiZeq9bDTPiMYJG7VSXCiNLymOrR5E0m+DFMFIt5GJy/VVuzDknaOcDq0FrHwBS0yYY6/KiHX0SVSTu8DcilGFjFxLBQAT1URy3N/IyRlpE4I/g8bx0eD8jNRGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=T8KUI57i; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BA5B93FCF8
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 06:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1766643700;
	bh=qFvlMlvE9r5nhkR9r0sSoyW03M/nv0IQfYhprTVg6t0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=T8KUI57iGqDsGUcoFCQAo6S+oDPoygCA5O7rWAjLP2aV+5E1dKOChUI0RY+eEBsGE
	 2EACJEufMBGk4NqRNUP9m0ER8xrnTX7FLr4rzSZ7xPXdCqzZEg9OIUw2k+8il5Cgmw
	 Ji3PAumKb6EU+IMmGs0e0R/86UNZ1fJ1Lh9Vrc0/a/tCahAypvgMzIy2vhe5GXTT8w
	 bgFlUmoiLjl3JiCXqNtjDSKeV9WDX1KhGIQLq9hd3kZpFuGR/iSZ8DjI56ZV8t5NmI
	 7zqw1Qd0eSzl6q70n7Z6e215ceAY1pe2qUk3+UQcq0Eh69LEKIPqm5CulotE+xLeEI
	 2a9deiSpPgsg+g7KLkWz1oXreNup8VavVTeh5tgZ4s8JwB8r0oONGhaZ4+qreZcAOz
	 Ozs+XbVARtFx3zCAcyTE4yQ5s/OM3HoHcuYzpWvdeE7hCEvSCfx3VMA+S7Wef8e4UC
	 4jGu7plZTuR/MWDK2UlPR9KmGygC+2PNtRf778hJO8/zNq0MR6ikCR8cWi5U44wpVx
	 ha0FtkSIKmNmDgO19hfOlhSK4WjwVB8/iQ2O3evMz9NJFEhfyI0gJDXHT0NAOTyH8u
	 KA1unlnbRT88flZRm2G6SbchyMMuGXqsKovhaKCO7XQ0gyZkBfpFCcTTIXBxdN/yV8
	 dAJmUmHVg+RNy/p8Y03i4cGI=
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b800559710aso492567066b.3
        for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 22:21:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766643700; x=1767248500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFvlMlvE9r5nhkR9r0sSoyW03M/nv0IQfYhprTVg6t0=;
        b=q14WQ5wtKBnJfabzf1KwwiAm6La6dAmgZHKzTjaRSngZ7/6lz47VHYlR0Jy2g8F5lK
         hICTbLooi7YsBFMjIyJHvs1XVVwRP/4a97AFtPvnR9dKm77FPMOfLGU4P2MrpaKiOCh6
         vIyTd7S0GxwHMoHIofvJQfC+znFUzClHia1/zil3GnG7EY6a2/x3H0pF0JNUL+c55gF7
         dhW4as9wY5gx1uc9Jj+oXMSEkIC7rBG5shpZrhDiIAktcCnUK/oZbVwekzeE5hKSWtwV
         1AA6XYlom3DtfeMi7czIQLAOTMM4/2XPC44slENVX8V4/37L2hB9KkFEhTkkpWRxk3CB
         3H4A==
X-Forwarded-Encrypted: i=1; AJvYcCUKSB/f+eWEQRO+Gd5vcKmwKv0OY4PmWFxbIt3RYZmBOoA3DvEwq8mPMcsWMrfo5bthqFBaeY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAFnuR2B92lDvfxYx2V/38nwi/ln1UuRYhlEwDinjhzGHiDa2P
	ejS4UJyPE2GPgKabGoMgso4eQQnm1neCeqXFrSiXG55MNLJivJ1tZQ6HxyxiTROgM4K7r9ia8AG
	PFvTPQUDUVYRsD0WsV22luDnMJVJ2MJVglutyT92n1L7OWCAhHRMv9G1oQw2I8eWnMPGjJvPDRQ
	==
X-Gm-Gg: AY/fxX77x+2ZYz+/cgz41vCXRJWJhawr2ZE+M/oZNPX9EEt2WP9LdFdguhKE4ES9pd7
	zI7ROhQgkQCrdLDcRJQz+GdwQsgN0TqZpwgIIuQOItZCZpbrRXA6c4jSFukVSURjGK3Eutzt0Rs
	wuhvQOUutgZMNo2SFOAliyhlgFwkpMHWgXC7BGSx4WAWL4XY617/+7nYLDLCJjRdGM39nEKENI8
	6crAfce00jy6C2eDSjr/GmaIBzpqDunx4PlKu+rnfFdXfIWzX0c8WObNy/3xdT+GZS1LoYo9xfc
	mytn0m1ESj5rmifn6IyPv3PKJ9ITlSgifEIJqbepnM9zjarIh3bdYoDiXDnkdh7/R1aXTyYC7e2
	t3Cb5CQr1l3DDk8iF9703DsdH
X-Received: by 2002:a17:907:6d23:b0:b72:77c7:d8ad with SMTP id a640c23a62f3a-b8037058bbbmr1942385366b.35.1766643700219;
        Wed, 24 Dec 2025 22:21:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERMBDdSDta5JlQnNeKU7jeU/Kta6vNL1BTLPRsSG/es4jU3kG1aOPKcbTpD7JAz7NhxyeNTQ==
X-Received: by 2002:a17:907:6d23:b0:b72:77c7:d8ad with SMTP id a640c23a62f3a-b8037058bbbmr1942383466b.35.1766643699778;
        Wed, 24 Dec 2025 22:21:39 -0800 (PST)
Received: from localhost.localdomain ([103.155.100.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0ecb9sm1948058466b.56.2025.12.24.22.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 22:21:39 -0800 (PST)
From: Aaron Ma <aaron.ma@canonical.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] ice: Fix NULL pointer dereference in ice_vsi_set_napi_queues
Date: Thu, 25 Dec 2025 14:21:21 +0800
Message-ID: <20251225062122.736308-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add NULL pointer checks in ice_vsi_set_napi_queues() to prevent crashes
during resume from suspend when rings[q_idx]->q_vector is NULL.

Tested adaptor:
60:00.0 Ethernet controller [0200]: Intel Corporation Ethernet Controller E810-XXV for SFP [8086:159b] (rev 02)
        Subsystem: Intel Corporation Ethernet Network Adapter E810-XXV-2 [8086:4003]

SR-IOV state: both disabled and enabled can reproduce this issue.

kernel version: v6.18

Reproduce steps:
Bootup and execute suspend like systemctl suspend or rtcwake.

Log:
<1>[  231.443607] BUG: kernel NULL pointer dereference, address: 0000000000000040
<1>[  231.444052] #PF: supervisor read access in kernel mode
<1>[  231.444484] #PF: error_code(0x0000) - not-present page
<6>[  231.444913] PGD 0 P4D 0
<4>[  231.445342] Oops: Oops: 0000 [#1] SMP NOPTI
<4>[  231.446635] RIP: 0010:netif_queue_set_napi+0xa/0x170
<4>[  231.447067] Code: 31 f6 31 ff c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48 85 c9 74 0b <48> 83 79 30 00 0f 84 39 01 00 00 55 41 89 d1 49 89 f8 89 f2 48 89
<4>[  231.447513] RSP: 0018:ffffcc780fc078c0 EFLAGS: 00010202
<4>[  231.447961] RAX: ffff8b848ca30400 RBX: ffff8b848caf2028 RCX: 0000000000000010
<4>[  231.448443] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8b848dbd4000
<4>[  231.448896] RBP: ffffcc780fc078e8 R08: 0000000000000000 R09: 0000000000000000
<4>[  231.449345] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
<4>[  231.449817] R13: ffff8b848dbd4000 R14: ffff8b84833390c8 R15: 0000000000000000
<4>[  231.450265] FS:  00007c7b29e9d740(0000) GS:ffff8b8c068e2000(0000) knlGS:0000000000000000
<4>[  231.450715] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4>[  231.451179] CR2: 0000000000000040 CR3: 000000030626f004 CR4: 0000000000f72ef0
<4>[  231.451629] PKRU: 55555554
<4>[  231.452076] Call Trace:
<4>[  231.452549]  <TASK>
<4>[  231.452996]  ? ice_vsi_set_napi_queues+0x4d/0x110 [ice]
<4>[  231.453482]  ice_resume+0xfd/0x220 [ice]
<4>[  231.453977]  ? __pfx_pci_pm_resume+0x10/0x10
<4>[  231.454425]  pci_pm_resume+0x8c/0x140
<4>[  231.454872]  ? __pfx_pci_pm_resume+0x10/0x10
<4>[  231.455347]  dpm_run_callback+0x5f/0x160
<4>[  231.455796]  ? dpm_wait_for_superior+0x107/0x170
<4>[  231.456244]  device_resume+0x177/0x270
<4>[  231.456708]  dpm_resume+0x209/0x2f0
<4>[  231.457151]  dpm_resume_end+0x15/0x30
<4>[  231.457596]  suspend_devices_and_enter+0x1da/0x2b0
<4>[  231.458054]  enter_state+0x10e/0x570

Add defensive checks for both the ring pointer and its q_vector
before dereferencing, allowing the system to resume successfully even when
q_vectors are unmapped.

Fixes: 2a5dc090b92cf ("ice: move netif_queue_set_napi to rtnl-protected sections")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
V1 -> V2: add test device info.
V2 -> V3: no changes.

 drivers/net/ethernet/intel/ice/ice_lib.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 15621707fbf81..9d1178bde4495 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2779,11 +2779,13 @@ void ice_vsi_set_napi_queues(struct ice_vsi *vsi)
 
 	ASSERT_RTNL();
 	ice_for_each_rxq(vsi, q_idx)
-		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
+		if (vsi->rx_rings[q_idx] && vsi->rx_rings[q_idx]->q_vector)
+			netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_RX,
 				     &vsi->rx_rings[q_idx]->q_vector->napi);
 
 	ice_for_each_txq(vsi, q_idx)
-		netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX,
+		if (vsi->tx_rings[q_idx] && vsi->tx_rings[q_idx]->q_vector)
+			netif_queue_set_napi(netdev, q_idx, NETDEV_QUEUE_TYPE_TX,
 				     &vsi->tx_rings[q_idx]->q_vector->napi);
 	/* Also set the interrupt number for the NAPI */
 	ice_for_each_q_vector(vsi, v_idx) {
-- 
2.43.0


