Return-Path: <netdev+bounces-240681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDCCC77BD1
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 08:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26A684E773A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 07:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80376302CAE;
	Fri, 21 Nov 2025 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="hllJApSx"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5421EFF9B;
	Fri, 21 Nov 2025 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763711153; cv=none; b=fo3zQx8otnqoxydS3KppR5ewPqbhwPS6OZ5ROD5TdHI1gp4I1mBTCDg0GSFHY32fguW5zfY/Q/vSWoPCWBf6NIafgatRMeM4wteBzKKzhRu0oQFV3Rvn0yqOS+M6hRJeYjhp/HeJ3xdMxwlU5PDzYGgm85vJzgVbZQRjCyulIVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763711153; c=relaxed/simple;
	bh=orO6GbPq1C/6CXM5oUU3QXO3Xa0g8Ar2CCQjnRW1Eno=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PIT+1aGQbo069AQ2VwRjA81helvpD3I26P+aiKLqQ93fRXJvaDuuRTETDAeNFSz9H8fvymJ/1he8VpFhJITeFlhqyA5v53YfUvbKdE8EjVI8NTFPMFva0YEmUCLF9AA3yJphoqRnZyov8D3ODR349ac7oJkhrJyA4QqApcHgSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=hllJApSx; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id ED76DA18B5;
	Fri, 21 Nov 2025 08:45:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=F5UBsjUgvUjevHHWIREtTg9CBzRHf4z+tuy4FrCQ/wM=; b=
	hllJApSxbzIsh112d02KGZtxoGQD9u0JDaz6IUAc1XtEpoiiAbkozVsA0I6rEAAC
	vnkvxbrnIQJV4Nl7OWLI9u8cNV0e8ypFpSICG1pIC+DfhTwQxY1rK3mjoMrWZQva
	z1Vfk+/QdL/wK0e/epClXxBtS2CBvkq4NLf/tyVzhn+zSOI2QaFYyLUTeU8RNfWd
	QLCiWKOuAp6HXNb8jpctJGdl2pfE1FjQhPWdF05/o35Hk5pOFK2tuwnziLnNxV3Y
	K1mJa+sbJ/8st9qeUdiFwI7hESHAcPx/hzkK0Jy2UiFRPeIOf5mqLSa1J6KJwN+H
	FCQ8D+qmLK/wDcoCbdqJ2SBb4Cp7ls02E0evY748wCRi3O7kkhEtygNK1YHZqMtO
	YPqBmxilzLfTOTt78q8FvR7GPLgxdz0cDvu55HGMO5UDYO/A69/SF9jxZJBSCztl
	U9owMRLA80FFXDEdeZMprSfxvAathRyPaFUHls5XRiVEatTV+EGqEUt+en9n4ipG
	ldalv5sEBRyXiOwj3Hq0v/5RsJjunMuluesdnlyqL1+aeSIjCw5uPLptyc3DirTn
	bxMbqMXvJaxzKuIFpCpngTwRV5hotmVPySgVgvdnunG9KcQ73V2luKcWtxtZeqje
	UpeTr+ZjqjE7SkG200LrOVwPCAR0IwWLUgplHxBW+r8=
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Buday Csaba <buday.csaba@prolan.hu>
Subject: [PATCH net-next 1/1] net: mdio: eliminate kdoc warnings in mdio_device.c and mdio_bus.c
Date: Fri, 21 Nov 2025 08:45:42 +0100
Message-ID: <b0313adbbb1232b6fd8d44c7eb8601aaac61818f.1763711078.git.buday.csaba@prolan.hu>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1763711144;VERSION=8002;MC=1832544888;ID=105936;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155F60756A

Fix all warnings reported by scripts/kernel-doc in
mdio_device.c and mdio_bus.c

Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
---
 drivers/net/phy/mdio_bus.c    | 56 ++++++++++++++++++++++++++++++-----
 drivers/net/phy/mdio_device.c |  6 ++++
 2 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index ef041ad66..a00dc7451 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -339,7 +339,7 @@ EXPORT_SYMBOL_GPL(mdio_bus_class);
  * mdio_find_bus - Given the name of a mdiobus, find the mii_bus.
  * @mdio_name: The name of a mdiobus.
  *
- * Returns a reference to the mii_bus, or NULL if none found.  The
+ * Returns: a reference to the mii_bus, or NULL if none found. The
  * embedded struct device will have its reference count incremented,
  * and this must be put_deviced'ed once the bus is finished with.
  */
@@ -357,7 +357,7 @@ EXPORT_SYMBOL(mdio_find_bus);
  * of_mdio_find_bus - Given an mii_bus node, find the mii_bus.
  * @mdio_bus_np: Pointer to the mii_bus.
  *
- * Returns a reference to the mii_bus, or NULL if none found.  The
+ * Returns: a reference to the mii_bus, or NULL if none found. The
  * embedded struct device will have its reference count incremented,
  * and this must be put once the bus is finished with.
  *
@@ -405,6 +405,8 @@ static void mdiobus_stats_acct(struct mdio_bus_stats *stats, bool op, int ret)
  * @addr: the phy address
  * @regnum: register number to read
  *
+ * Return: The register value if successful, negative error code on failure
+ *
  * Read a MDIO bus register. Caller must hold the mdio bus lock.
  *
  * NOTE: MUST NOT be called from interrupt context.
@@ -437,6 +439,8 @@ EXPORT_SYMBOL(__mdiobus_read);
  * @regnum: register number to write
  * @val: value to write to @regnum
  *
+ * Return: Zero if successful, negative error code on failure
+ *
  * Write a MDIO bus register. Caller must hold the mdio bus lock.
  *
  * NOTE: MUST NOT be called from interrupt context.
@@ -470,8 +474,11 @@ EXPORT_SYMBOL(__mdiobus_write);
  * @mask: bit mask of bits to clear
  * @set: bit mask of bits to set
  *
+ * Return: 1 if the register was modified, 0 if no change was needed,
+ *	   negative on any error condition
+ *
  * Read, modify, and if any change, write the register value back to the
- * device. Any error returns a negative number.
+ * device.
  *
  * NOTE: MUST NOT be called from interrupt context.
  */
@@ -501,6 +508,8 @@ EXPORT_SYMBOL_GPL(__mdiobus_modify_changed);
  * @devad: device address to read
  * @regnum: register number to read
  *
+ * Return: The register value if successful, negative error code on failure
+ *
  * Read a MDIO bus register. Caller must hold the mdio bus lock.
  *
  * NOTE: MUST NOT be called from interrupt context.
@@ -534,6 +543,8 @@ EXPORT_SYMBOL(__mdiobus_c45_read);
  * @regnum: register number to write
  * @val: value to write to @regnum
  *
+ * Return: Zero if successful, negative error code on failure
+ *
  * Write a MDIO bus register. Caller must hold the mdio bus lock.
  *
  * NOTE: MUST NOT be called from interrupt context.
@@ -569,6 +580,9 @@ EXPORT_SYMBOL(__mdiobus_c45_write);
  * @mask: bit mask of bits to clear
  * @set: bit mask of bits to set
  *
+ * Return: 1 if the register was modified, 0 if no change was needed,
+ *	   negative on any error condition
+ *
  * Read, modify, and if any change, write the register value back to the
  * device. Any error returns a negative number.
  *
@@ -599,6 +613,8 @@ static int __mdiobus_c45_modify_changed(struct mii_bus *bus, int addr,
  * @addr: the phy address
  * @regnum: register number to read
  *
+ * Return: The register value if successful, negative error code on failure
+ *
  * In case of nested MDIO bus access avoid lockdep false positives by
  * using mutex_lock_nested().
  *
@@ -624,6 +640,8 @@ EXPORT_SYMBOL(mdiobus_read_nested);
  * @addr: the phy address
  * @regnum: register number to read
  *
+ * Return: The register value if successful, negative error code on failure
+ *
  * NOTE: MUST NOT be called from interrupt context,
  * because the bus read/write functions may wait for an interrupt
  * to conclude the operation.
@@ -647,6 +665,8 @@ EXPORT_SYMBOL(mdiobus_read);
  * @devad: device address to read
  * @regnum: register number to read
  *
+ * Return: The register value if successful, negative error code on failure
+ *
  * NOTE: MUST NOT be called from interrupt context,
  * because the bus read/write functions may wait for an interrupt
  * to conclude the operation.
@@ -670,6 +690,8 @@ EXPORT_SYMBOL(mdiobus_c45_read);
  * @devad: device address to read
  * @regnum: register number to read
  *
+ * Return: The register value if successful, negative error code on failure
+ *
  * In case of nested MDIO bus access avoid lockdep false positives by
  * using mutex_lock_nested().
  *
@@ -697,6 +719,8 @@ EXPORT_SYMBOL(mdiobus_c45_read_nested);
  * @regnum: register number to write
  * @val: value to write to @regnum
  *
+ * Return: Zero if successful, negative error code on failure
+ *
  * In case of nested MDIO bus access avoid lockdep false positives by
  * using mutex_lock_nested().
  *
@@ -723,6 +747,8 @@ EXPORT_SYMBOL(mdiobus_write_nested);
  * @regnum: register number to write
  * @val: value to write to @regnum
  *
+ * Return: Zero if successful, negative error code on failure
+ *
  * NOTE: MUST NOT be called from interrupt context,
  * because the bus read/write functions may wait for an interrupt
  * to conclude the operation.
@@ -747,6 +773,8 @@ EXPORT_SYMBOL(mdiobus_write);
  * @regnum: register number to write
  * @val: value to write to @regnum
  *
+ * Return: Zero if successful, negative error code on failure
+ *
  * NOTE: MUST NOT be called from interrupt context,
  * because the bus read/write functions may wait for an interrupt
  * to conclude the operation.
@@ -772,6 +800,8 @@ EXPORT_SYMBOL(mdiobus_c45_write);
  * @regnum: register number to write
  * @val: value to write to @regnum
  *
+ * Return: Zero if successful, negative error code on failure
+ *
  * In case of nested MDIO bus access avoid lockdep false positives by
  * using mutex_lock_nested().
  *
@@ -800,6 +830,8 @@ EXPORT_SYMBOL(mdiobus_c45_write_nested);
  * @regnum: register number to write
  * @mask: bit mask of bits to clear
  * @set: bit mask of bits to set
+ *
+ * Return: 0 on success, negative on any error condition
  */
 int __mdiobus_modify(struct mii_bus *bus, int addr, u32 regnum, u16 mask,
 		     u16 set)
@@ -820,6 +852,8 @@ EXPORT_SYMBOL_GPL(__mdiobus_modify);
  * @regnum: register number to write
  * @mask: bit mask of bits to clear
  * @set: bit mask of bits to set
+ *
+ * Return: 0 on success, negative on any error condition
  */
 int mdiobus_modify(struct mii_bus *bus, int addr, u32 regnum, u16 mask, u16 set)
 {
@@ -842,6 +876,8 @@ EXPORT_SYMBOL_GPL(mdiobus_modify);
  * @regnum: register number to write
  * @mask: bit mask of bits to clear
  * @set: bit mask of bits to set
+ *
+ * Return: 0 on success, negative on any error condition
  */
 int mdiobus_c45_modify(struct mii_bus *bus, int addr, int devad, u32 regnum,
 		       u16 mask, u16 set)
@@ -865,6 +901,9 @@ EXPORT_SYMBOL_GPL(mdiobus_c45_modify);
  * @regnum: register number to write
  * @mask: bit mask of bits to clear
  * @set: bit mask of bits to set
+ *
+ * Return: 1 if the register was modified, 0 if no change was needed,
+ *	   negative on any error condition
  */
 int mdiobus_modify_changed(struct mii_bus *bus, int addr, u32 regnum,
 			   u16 mask, u16 set)
@@ -888,6 +927,9 @@ EXPORT_SYMBOL_GPL(mdiobus_modify_changed);
  * @regnum: register number to write
  * @mask: bit mask of bits to clear
  * @set: bit mask of bits to set
+ *
+ * Return: 1 if the register was modified, 0 if no change was needed,
+ *	   negative on any error condition
  */
 int mdiobus_c45_modify_changed(struct mii_bus *bus, int addr, int devad,
 			       u32 regnum, u16 mask, u16 set)
@@ -908,10 +950,10 @@ EXPORT_SYMBOL_GPL(mdiobus_c45_modify_changed);
  * @dev: target MDIO device
  * @drv: given MDIO driver
  *
- * Description: Given a MDIO device, and a MDIO driver, return 1 if
- *   the driver supports the device.  Otherwise, return 0. This may
- *   require calling the devices own match function, since different classes
- *   of MDIO devices have different match criteria.
+ * Return: 1 if the driver supports the device, 0 otherwise
+ *
+ * Description: This may require calling the devices own match function,
+ *   since different classes of MDIO devices have different match criteria.
  */
 static int mdio_bus_match(struct device *dev, const struct device_driver *drv)
 {
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index fd0e16dbc..6e90ed42c 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -78,6 +78,8 @@ EXPORT_SYMBOL(mdio_device_create);
 /**
  * mdio_device_register - Register the mdio device on the MDIO bus
  * @mdiodev: mdio_device structure to be added to the MDIO bus
+ *
+ * Return: Zero if successful, negative error code on failure
  */
 int mdio_device_register(struct mdio_device *mdiodev)
 {
@@ -206,6 +208,8 @@ EXPORT_SYMBOL(mdio_device_reset);
  *
  * Description: Take care of setting up the mdio_device structure
  * and calling the driver to probe the device.
+ *
+ * Return: Zero if successful, negative error code on failure
  */
 static int mdio_probe(struct device *dev)
 {
@@ -256,6 +260,8 @@ static void mdio_shutdown(struct device *dev)
 /**
  * mdio_driver_register - register an mdio_driver with the MDIO layer
  * @drv: new mdio_driver to register
+ *
+ * Return: Zero if successful, negative error code on failure
  */
 int mdio_driver_register(struct mdio_driver *drv)
 {

base-commit: e2c20036a8879476c88002730d8a27f4e3c32d4b
-- 
2.39.5



