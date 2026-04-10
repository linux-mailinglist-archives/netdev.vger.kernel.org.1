Return-Path: <netdev+bounces-277530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F1XIvlU2WlGoggAu9opvQ
	(envelope-from <netdev+bounces-277530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:52:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7523DC1EE
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 21:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE5253047BDF
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 19:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2972735F16F;
	Fri, 10 Apr 2026 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SCZqEapQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A63803C3
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775850729; cv=none; b=tNLUmclfeONI4o2NOuCY4BbJIiAW2iHUPUS//IqVDzE62ynrN44J/9tWkMNB+CdZpSPNd6PbFaAapdgY7Wofg4xztxY1Hr9HhpzTg8IDe2MedvB5ykJWC7RPDojhrOM0+ev1Z7rEcuJNdELXiCDD678PTQ3/6HOw66K2kkfxfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775850729; c=relaxed/simple;
	bh=/acECG0t9e5CtCjKFwcO/1CVgXHyvRTGFllTwGnAnxY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dI1W3fpzT2COE5MOjEJ1zrcaKl+W1S/502P7BucUHn0aVCvESU5dss6xckeBt6J+0SdszJmqpACTXYtj//2BStdf6Z21qqDjGocHw8FCM56n5ZTjGFILOU/4dHD3/18CLww2TMbzDGlKKjOvbAZ8j4Tljz3ChkTfNklLQ59x0Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SCZqEapQ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9CB0BC5C1A6;
	Fri, 10 Apr 2026 19:52:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 23ED1603F0;
	Fri, 10 Apr 2026 19:52:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5EFA61045007B;
	Fri, 10 Apr 2026 21:51:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775850722; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=a1e5C5snqp7ity9V2CMWdtR7H1QuV/Cp6vsDR9/gMD4=;
	b=SCZqEapQCczpG+MRlBxiAU2Uf76tOO3iNgxIxyIDSyNMmqGqI1Q9oJM9Hoer9N9w4CIqWY
	q/ShAo1Ns1upP/UElp0kV9JgOt0JINEvS9VO585QxYBp4RpVeclOsC2EGrbObz4QWFoweR
	xrpdFMUh5uyDyo7VOEz/r/mbnURS9VyLKiDDbJrwhLx60az4FUAm9UocLGDutzm6CD7Som
	BrhTKS10LBCY/oxf2JTqOmrp3rwSuaygicVaYDwE2JVxSh6epujy5PS3nPD2t4bNBHmagL
	tz1nNsalTUgqIq27a3JYkxII/8XYB5hjFDxovwpRCLsd//h1Ji1njreUDIbl/Q==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next v2 00/14] net: macb: implement context swapping
Date: Fri, 10 Apr 2026 21:51:48 +0200
Message-Id: <20260410-macb-context-v2-0-af39f71d40b6@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQ6CMBBEf4Xs2Zq2AQme/A/DoV0WWSMtaSvBE
 P7dglePk3nzZoVIgSnCtVgh0MyRvctBnwrAwbgHCe5yBi31RZZSidGgFehdoiUJ20k0vZalKjv
 IkylQz8uhu4OjJFymoP018W2fhGm37ezAMfnwOZ5ndSz+n8xKSNFUjcTK2FrX+ma9Ty92Z/Qjt
 Nu2fQEX/f4DxgAAAA==
X-Change-ID: 20260401-macb-context-bd0caf20414d
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Paolo Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15.1
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277530-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EE7523DC1EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

MACB has a pretty primitive approach to buffer management. They are all
stored in `struct macb *bp`. On operations that require buffer realloc
(set_ringparam & change_mtu ATM), the only option is to close the
interface, change our global state and re-open the interface.

Two issues:
- It doesn't fly on memory pressured systems; we free our precious
  buffers and don't manage to reallocate fully, meaning our machine
  just lost its network access.
- Anecdotally, it is pretty slow because it implies a full PHY reinit.

Instead, we shall:
 - allocate a new context (including buffers) first
 - if it fails, early return without any impact to the interface
 - stop interface
 - update global state (bp, netdev, etc)
 - pass newly allocated buffer pointers to the hardware
 - start interface
 - free old context

This is what we implement here. Both .set_ringparam() and
.ndo_change_mtu() are covered by this series. In the future,
at least .set_channels() [0], XDP [1] and XSK [2] would benefit.

The change is super intrusive so conflicts will be major. Sorry!

Thanks,
Have a nice day,
Théo

[0]: https://lore.kernel.org/netdev/20260317-macb-set-channels-v4-0-1bd4f4ffcfca@bootlin.com/
[1]: https://lore.kernel.org/netdev/20260323221047.2749577-1-pvalerio@redhat.com/
[2]: https://lore.kernel.org/netdev/20260304-macb-xsk-v1-0-ba2ebe2bdaa3@bootlin.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Changes in v2:
- Patch "add subset of `struct macb` to `struct macb_context`" was
  messed up. It contained much more than what the name implied. Split
  into three commits (I caused trouble by rebase reordering).
- Fix tieoff; V1 allocated it without initialisation.
- Fix NULL pointer dereference on context in mab_get_regs() and
  macb_get_ringparam() when interface is offline.
- Patch "unify device pointer naming convention":
  - Fix build issue when CONFIG_NETCONSOLE=y.
  - Rename `struct net_device *dev` to `netdev` in macb.h.
  - Rename `struct phy_device *phy` to `phydev` in macb_main.c.
- On swap, call netdev_tx_reset_queue() to reset all DQL counters.
- At end of swap, add missing kfree(old_ctx).
- During HW disabling in swap, grab bp->lock to protect against IRQ
  handler.
- On swap, cancel the three BH features MACB has:
  bp->hresp_err_bh_work, bp->tx_lpi_work and queue->tx_error_task.
- On swap, call macb_configure_dma() which writes buffer size to
  hardware registers. This is important because the change_mtu codepath
  changes the buffer size.
- Rebase onto latest net-next/main (58dd34dbd5b0) & resolve conflicts.
- Link to v1: https://patch.msgid.link/20260401-macb-context-v1-0-9590c5ab7272@bootlin.com

---
Théo Lebrun (14):
      net: macb: unify device pointer naming convention
      net: macb: unify `struct macb *` naming convention
      net: macb: unify queue index variable naming convention and types
      net: macb: enforce reverse christmas tree (RCT) convention
      net: macb: allocate tieoff descriptor once across device lifetime
      net: macb: introduce macb_context struct for buffer management
      net: macb: avoid macb_init_rx_buffer_size() modifying state
      net: macb: make `struct macb` subset reachable from macb_context struct
      net: macb: change caps helpers signatures
      net: macb: change function signatures to take contexts
      net: macb: introduce macb_context_alloc() helper
      net: macb: re-read ISR inside IRQ handler locked section
      net: macb: use context swapping in .set_ringparam()
      net: macb: use context swapping in .ndo_change_mtu()

 drivers/net/ethernet/cadence/macb.h      |  125 ++-
 drivers/net/ethernet/cadence/macb_main.c | 1767 +++++++++++++++++-------------
 drivers/net/ethernet/cadence/macb_pci.c  |   46 +-
 drivers/net/ethernet/cadence/macb_ptp.c  |   26 +-
 4 files changed, 1126 insertions(+), 838 deletions(-)
---
base-commit: 6b6916526425235d5875df21dfa6f31fdc098599
change-id: 20260401-macb-context-bd0caf20414d

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>


