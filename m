Return-Path: <netdev+bounces-182362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068ADA888D3
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48933AFCE1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 16:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141AE27B517;
	Mon, 14 Apr 2025 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4kQL3GK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C3D19E7D1
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649100; cv=none; b=kIs1wIvziJODIApjO0ZPlw8IXlwYGrGolSWJ69cgOs2BzZBv3GLdGrgS2GnvnHkYg6SUDbR6kOzAjySmZqrqqXp/BNdtY3R+/g0BgApxOab6Kg7fL2+q+/Gid+0rZFk8KCW8Ks1AdlWHbDxP9nWG9Z7dhuTHqoyot744FCl66Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649100; c=relaxed/simple;
	bh=GbC0qgJPpOB5OUm4FzRWDHtgfc3oukpLJ8sQ2z1S4KE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SOKltiGe6fE/D96dyrXaaQwjAqHfW1eLiQHGim3akEhMCIm94VJ04Wozk+srAkPm9PUxZScmmJPQD/B2z+pfXrxXtwDfopa016sm0UiWol7CkejtAH2Ix0Nd0FGGyuemrpmvNFZGXKXUUu3iJb62OJ5cRxbdxWECwgSG7YWiZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4kQL3GK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63299C4CEEA;
	Mon, 14 Apr 2025 16:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744649099;
	bh=GbC0qgJPpOB5OUm4FzRWDHtgfc3oukpLJ8sQ2z1S4KE=;
	h=From:Date:Subject:To:Cc:From;
	b=e4kQL3GKgwGuJZ2YXSXm+d/kTLwoUBaFpDucWjkM5+gqD6Q1ShYIfudQ/WL6rBkE9
	 K721gIEDnrvMHUsJhLEAupBe7Bod/OifWXNshyqiZZX2quDn4+Exr8kI4QGR4yk//W
	 A9PZP9B7Uek5SL5IzswgWHWNQDSp5SmOvXkKiKxX0tSnJG7YHUAeaeyXkTOreboarG
	 3q2j9pjOPDtb9VWYtvCNijbIZKmKEfmeesFepVqdU3OjKImnGV9hAPwlJ/uyUMfs8W
	 015xh07q8/yUqF/GUbxzMF8Telw14Z7YJ5hmprIf9k3jY4yfAykBKmuMmPIxGhxcdi
	 vug/lKK/Q43sg==
From: Simon Horman <horms@kernel.org>
Date: Mon, 14 Apr 2025 17:44:48 +0100
Subject: [PATCH net-next] octeon_ep_vf: Remove octep_vf_wq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-octeon-wq-v1-1-23700e4bd208@kernel.org>
X-B4-Tracking: v=1; b=H4sIAH87/WcC/x3MQQqAIBBA0avErBsw00VdJVqUjTWbsVQqiO6et
 Hzw+Q8kikwJ+uqBSCcnDlLQ1BW4bZKVkJdi0EpbZRqDwWUKgteBxrd+afVkOzdD6fdInu//NYB
 QRqE7w/i+H4qVaU1lAAAA
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shinas Rasheed <srasheed@marvell.com>
Cc: Veerasenareddy Burru <vburru@marvell.com>, 
 Sathesh Edara <sedara@marvell.com>, Satananda Burla <sburla@marvell.com>, 
 "Dr. David Alan Gilbert" <linux@treblig.org>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

commit cb7dd712189f ("octeon_ep_vf: Add driver framework and device
initialization") added octep_vf_wq but it has never been used. Remove it.

Reported-by: Dr. David Alan Gilbert <linux@treblig.org>
Closes: https://lore.kernel.org/netdev/Z70bEoTKyeBau52q@gallifrey/
Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 2 --
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
index 18c922dd5fc6..5841e30dff2a 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
@@ -18,8 +18,6 @@
 #include "octep_vf_config.h"
 #include "octep_vf_main.h"
 
-struct workqueue_struct *octep_vf_wq;
-
 /* Supported Devices */
 static const struct pci_device_id octep_vf_pci_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_CAVIUM, OCTEP_PCI_DEVICE_ID_CN93_VF)},
diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
index 1a352f41f823..b9f13506f462 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.h
@@ -320,8 +320,6 @@ static inline u16 OCTEP_VF_MINOR_REV(struct octep_vf_device *oct)
 #define octep_vf_read_csr64(octep_vf_dev, reg_off)         \
 	readq((octep_vf_dev)->mmio.hw_addr + (reg_off))
 
-extern struct workqueue_struct *octep_vf_wq;
-
 int octep_vf_device_setup(struct octep_vf_device *oct);
 int octep_vf_setup_iqs(struct octep_vf_device *oct);
 void octep_vf_free_iqs(struct octep_vf_device *oct);


