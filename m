Return-Path: <netdev+bounces-161996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E647A25043
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 23:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E217A1041
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 22:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027EA2147E0;
	Sun,  2 Feb 2025 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jakemoroni.com header.i=@jakemoroni.com header.b="TRONp/Gb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xXde9CuZ"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F753101E6;
	Sun,  2 Feb 2025 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738534241; cv=none; b=thJ2FdpGBiEot1c+RU3Tsjm2K3uK+5QfWQ/7IKNZ2DpoZPbB1bGHGUSyYxM6wLtYTqRRHlDLfQ9b7yzHotMcxuohUk8BcLXWMKrJPwqqXKbrSOdt/1Vvw+rmnahQx57YLTSPjik8dsDMeEf8MBgcQYndij537UBLEDSQKZayIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738534241; c=relaxed/simple;
	bh=QUDDt7cmWM6JdhLuzuEAEAdcnvJxWBs6SuH1hwDfD7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZNMqGGhC0UdgBWE+yjKrBxFx128ZwWQY2yBIBJo6QPl9frcXWsfSCaTjbqBTnig+QWyt17Pdoa+YOf4ih2T3EF5W8bRWcUKBTDZg16cbFwnYbMpbh1P/T2mIxJP9XGRaissDxfRyte+3k7CAb7FKszTu6UuQciv8S3eLL/F0svU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jakemoroni.com; spf=pass smtp.mailfrom=jakemoroni.com; dkim=pass (2048-bit key) header.d=jakemoroni.com header.i=@jakemoroni.com header.b=TRONp/Gb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xXde9CuZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jakemoroni.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jakemoroni.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 94DE71140102;
	Sun,  2 Feb 2025 17:10:38 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Sun, 02 Feb 2025 17:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jakemoroni.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1738534238; x=1738620638; bh=pqqdKzGSHP
	y/opA4pIlSJbFwZjddQqYW7yXI+rIj+M8=; b=TRONp/GbcBeaCQT3g+Meq9Bctq
	eQ0tHuh3e+UeczohJ7ZfBp098v9V0OjN064z3UodtUbvU2v1dWQ9aat5GS4iLk7A
	AC93cyfn9Mawhl2b4ntZrC9YxDWpJaK51JsrJ8VJBiUn8EZe4B7A7z0x1l4IGW+s
	S/qcwZQFIJSRTkoRt77106sGyevYaU2X1fVkAhDHkJTQXArJuSE8VvT2uRSsCKxs
	n4k8xIJtYIcClx/dLZeQQ7UsJfEconSWm+P9NEAfuK9Jl2doC6cWCYfMJjb510S5
	B044zz1XqGZ3nAP2JgLPuAD9FtWTtyIACcyKff9B5hb0DaLD56WNSUs2HXtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738534238; x=1738620638; bh=pqqdKzGSHPy/opA4pIlSJbFwZjddQqYW7yX
	I+rIj+M8=; b=xXde9CuZYSqklxhHugmr5d5yrLuYVOlDrcqZhDa+VjSZiga2XiK
	rWO5jmBXryc4BypCo+UOf/JJ/q37vbb+2MXakb5EfCR/37nwEO8UvnoYqaX1EAnS
	NJajc9ScT6HVXvpTfLYSxMirWfYif87Pz8JHJmdEha4A8Ml90vJXNpzEl8+RjgzF
	9Jg7yq86HVLYJAcnue2Ege4HWEsW82OqhSQcWtTwBuF3n+Xkm+uJy+WSUqefcDY0
	5RF9c/lL8lirwXoNMMr0stxymblqw4/Y9Bq5kwLnr3aq7tfa9M9s115KMLA1kdZK
	kzFxH7d5ivJh6381jXqY+6AUbg2cFtUKrsg==
X-ME-Sender: <xms:Xe2fZz1B1SLdKzYcBrWmslu_Cy8owdh6epTu3rcIHJHwF9APy5BsLA>
    <xme:Xe2fZyGxm7_mPTdyE2-Zj33MDQfTia5mrbXGzzt7wMMcfDMOLnLzJY4v53b_CPlej
    C2kqjhMVCGTpIwGOQ>
X-ME-Received: <xmr:Xe2fZz5pOlZjNl9i6ffD9Ik2X5MoRPLcyPGHXpU6HrTVC6Cc-VHZvPscAHlKGt5FrXBpDm5T0CvHHsYkgikY7qaj_gvIl0u_8T8OfEjoN4dSwiPwn3ROBDWr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpeflrggtohgsucfoohhrohhnihcuoehmrghilhesjhgrkhgvmhhorhhonhhird
    gtohhmqeenucggtffrrghtthgvrhhnpeehgeefveelhedvtedvveejhfellefgueetvdeh
    heduieelffejtefgtdevtedttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmrghilhesjhgrkhgvmhhorhhonhhirdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehirhhushhskhhikh
    hhsehmrghrvhgvlhhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvhes
    lhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpd
    hrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrth
    drtghomhdprhgtphhtthhopehmrghilhesjhgrkhgvmhhorhhonhhirdgtohhmpdhrtghp
    thhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Xe2fZ43vdz9VIAqYxAEc7IUB3mfsKhsAb2dK1hdjCcT7sQPLBAhXeA>
    <xmx:Xe2fZ2FxiR-zFL1LZhPKrVLbTVA6vAZBQgYQgM5JtOT7-b2LpQvURA>
    <xmx:Xe2fZ58ItQ0uz1536wGVCIKCFzUZao-yHrDuWSAb5QJ3-eXcU22V5A>
    <xmx:Xe2fZzkXBcNUCGu_wu6--1ZknVtdoWpDbs3V7SEqCqFvdqORTHEVtQ>
    <xmx:Xu2fZ5ANTJZLV0XmItBNXcU3IS_l7I-IF6Yn-u0AZyw9l7G-PvAxWMFR>
Feedback-ID: i17014242:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 17:10:37 -0500 (EST)
From: Jacob Moroni <mail@jakemoroni.com>
To: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jacob Moroni <mail@jakemoroni.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: atlantic: fix warning during hot unplug
Date: Sun,  2 Feb 2025 17:09:21 -0500
Message-ID: <20250202220921.13384-2-mail@jakemoroni.com>
X-Mailer: git-send-email 2.43.0
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

Signed-off-by: Jacob Moroni <mail@jakemoroni.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index fe0e3e2a8117..e2ae95a01947 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -1428,7 +1428,7 @@ void aq_nic_deinit(struct aq_nic_s *self, bool link_down)
 	unsigned int i = 0U;
 
 	if (!self)
-		goto err_exit;
+		return;
 
 	for (i = 0U; i < self->aq_vecs; i++) {
 		aq_vec = self->aq_vec[i];
@@ -1441,13 +1441,14 @@ void aq_nic_deinit(struct aq_nic_s *self, bool link_down)
 	aq_ptp_ring_free(self);
 	aq_ptp_free(self);
 
-	if (likely(self->aq_fw_ops->deinit) && link_down) {
-		mutex_lock(&self->fwreq_mutex);
-		self->aq_fw_ops->deinit(self->aq_hw);
-		mutex_unlock(&self->fwreq_mutex);
+	/* May be invoked during hot unplug. */
+	if (pci_device_is_present(self->pdev)) {
+		if (likely(self->aq_fw_ops->deinit) && link_down) {
+			mutex_lock(&self->fwreq_mutex);
+			self->aq_fw_ops->deinit(self->aq_hw);
+			mutex_unlock(&self->fwreq_mutex);
+		}
 	}
-
-err_exit:;
 }
 
 void aq_nic_free_vectors(struct aq_nic_s *self)
-- 
2.43.0


