Return-Path: <netdev+bounces-246070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43972CDE163
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 21:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E736F3006AB2
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 20:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20D9267B05;
	Thu, 25 Dec 2025 20:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="UqJCFfxk"
X-Original-To: netdev@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824027EFE3
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766695076; cv=none; b=nAYMXpRgAXpEGL+iXxg7x7CqfnBy6ofqcnexugGHYTFj8gvPJlHT14uQLY+3AGnbvfW12cafYFxcbadBYpBX5tIazKHSYNpJu0mYOg7gS9rGxNzJ+ojqVB0hiIQsgnW0Qq7UcDC80ExY18kXzYitxv36Gl8OFMofJHFyYuHhbM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766695076; c=relaxed/simple;
	bh=WwlEOAr1t6ductPkmsXqGNb2jZ3SbztP5QxHrDM2z9o=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=PxY2wXsV5nQutCyjc7QAv7mvwdAF0FYih9GDYOH2rgQjcQSUvs/OfNnHdU0rGe+n8Lym99M9Yd0tpFFDjTg0/dp0h0g86vLhA7K5TCpyMox/S+Tt9bJ016YBUqLeRqw0OdRT+iS3cXGpr/LZP2wFic2SjDunHuAfUeCIJc63/2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=UqJCFfxk; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1766695070;
	bh=3xKQ5QKGOtFosXXsFS4kNKY9y6GjUouDkstUkEJnWAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UqJCFfxkHT/3QPl9ciP9O4m57VMkeTHTSCcXdNjvoocOQgxCz+TKHV6bggtXRx199
	 YSD2il3iiC5FEyiZh2Nxr7YMGAc5opFuhcoKEfIDKr0iaJLr1cHTxKLILYeSyhXDyT
	 hv3SOr2pyjE6JmQ71nXbyItWa1yOBPDtdm6nr5Ag=
Received: from 7erry.customer.ask4.lan ([31.205.230.119])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 92399661; Fri, 26 Dec 2025 04:36:35 +0800
X-QQ-mid: xmsmtpt1766694995tzuk8mnx0
Message-ID: <tencent_75EF812B305E26B0869C673DD1160866C90A@qq.com>
X-QQ-XMAILINFO: NQp/UN4soYLTTuGP/agmWdwX9ssNAYBVQ/mWH1aB2n4ElujSIood7fUZGWerUr
	 ug8+kKgzmo/WY7NQ3o1rR7pLlQYW0k0G+OwquC6BOuWyRoh+Rdq8e4EWX5+JsQpOL6AihXw6N6nF
	 Yfh9fOqgiajWcXzcpsxE2RuKLi+0GDQ2qgkBttjQTxpzCMhJMRfsoXxmWmwnYoQMBHfIDlVsNu+s
	 nhSw59yvtpickN5jjMUJ68FvAPV4K12uAZl3Udg9Y0NggaewlE9XKibDGNmfba5yqoaOuiTdwhVp
	 IxN2hCnABWY1UnBhdLwjkJheyTxW0aEYas05Ss+/TOLXsC7ukVRKnBHFnC0tnQjQ8+WipwgTJ5Sm
	 QNMUho1qQJCmXFyYtHPjQm8LNoTXK73LkVrJKz6aRbfZ2O9y8zNnKC/sa9zmJK6O11Lz8Io1yyOe
	 jrz1ID4udtrd1DwZv3JFcPd4fCyQ0b3B8pvifhNiP6+YbGZqXlFhzFOPCivc7z3kySrXtQaUZIwC
	 aMjmU2eNYV4O5s77UQcd+q6wI/8knyib7SLei79LMBERlmYr7l7FDS2CjdTzDsU7/gLxESd+/pYd
	 14Daea5R06TCPpohkBzksFkEof3NdiBz9SExAq6HgLx6o1F1RHdOFYv4XCsI0GCJbx2geTdGqLXo
	 DtVBNSMoo/rwr1vfahZ7rNN6KqAebjlE5QcVZqbBMq+AlhAVnkYPdp7HPMgE/NFGmYRXCMEujoKp
	 GRFFh+Zol4iUamstXVZBKkmFUM2YRQqNOvhK11G0m1AQLc/XrqrmQp5yqo6AtQN8iACyusklSfow
	 0ifD+A1wk06el/NQNHTjDR8Iy7PcJy21MCV4HMmt9lG1DdF88MZIRYeyLJmK/ckxNlBLGRF2olfr
	 RBsb/hoeVC0zYgnj377ovOKP3TJU8t+q+MxP9lOizBJi1OAowoBd6hLc/6CU7DfTnnNrsyMZC7zn
	 ucbxz54Fe3itDi7NzJbEc37HnzuEWwZxmjhK1gFdz+cxLfxo5N0prHGm9RALqx5K0lnz8akWpDeb
	 XFCwO4xynXaL2Ff2mQot07V65vVNmq8xBlEjVFu4rsFAMLEb0nmVBffm8gCywDdrMqToU6YA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Jerry Wu <w.7erry@foxmail.com>
To: vladimir.oltean@nxp.com
Cc: UNGLinuxDriver@microchip.com,
	alexandre.belloni@bootlin.com,
	andrew+netdev@lunn.ch,
	christophe.jaillet@wanadoo.fr,
	claudiu.manoil@nxp.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	w.7erry@foxmail.com
Subject: [PATCH net v3] net: mscc: ocelot: Fix crash when adding interface under a lag
Date: Thu, 25 Dec 2025 20:36:17 +0000
X-OQ-MSGID: <20251225203617.13034-1-w.7erry@foxmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251220210808.325isrbvmhjp3tlg@skbuf>
References: <20251220210808.325isrbvmhjp3tlg@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 15faa1f67ab4 ("lan966x: Fix crash when adding interface under a lag")
fixed a similar issue in the lan966x driver caused by a NULL pointer dereference.
The ocelot_set_aggr_pgids() function in the ocelot driver has similar logic
and is susceptible to the same crash.

This issue specifically affects the ocelot_vsc7514.c frontend, which leaves
unused ports as NULL pointers. The felix_vsc9959.c frontend is unaffected as
it uses the DSA framework which registers all ports.

Fix this by checking if the port pointer is valid before accessing it.

Fixes: 528d3f190c98 ("net: mscc: ocelot: drop the use of the "lags" array")
Signed-off-by: Jerry Wu <w.7erry@foxmail.com>
---
v3:
  - Resending the correct version that compiles properly.
  - Retained the 'bond' variable as confirmed necessary in discussion with Vladimir Oltean.
  - Added links to previous versions as requested.
  - Thanks to the reviewers for the gentle and detailed feedback and guidance.

v2: https://lore.kernel.org/netdev/20251220210808.325isrbvmhjp3tlg@skbuf/T/
  - Addressed comments from v1 regarding variable name and null checking.
  - Sent by accident as a draft.

v1: https://lore.kernel.org/lkml/20251220180113.724txltmrkxzyaql@skbuf/T/
  - Try to fix the crash in the same way as previous patch did but failed for
    - improper variable name that is shadowing the "int port" definition.
	- unnecessary and incorrect hunk for null checking.
	- improper commit commit title.

 drivers/net/ethernet/mscc/ocelot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 08bee56aea35..c345d9b17c89 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -2307,14 +2307,16 @@ static void ocelot_set_aggr_pgids(struct ocelot *ocelot)
 
 	/* Now, set PGIDs for each active LAG */
 	for (lag = 0; lag < ocelot->num_phys_ports; lag++) {
-		struct net_device *bond = ocelot->ports[lag]->bond;
+		struct ocelot_port *ocelot_port = ocelot->ports[lag];
 		int num_active_ports = 0;
+		struct net_device *bond;
 		unsigned long bond_mask;
 		u8 aggr_idx[16];
 
-		if (!bond || (visited & BIT(lag)))
+		if (!ocelot_port || !ocelot_port->bond || (visited & BIT(lag)))
 			continue;
 
+		bond = ocelot_port->bond;
 		bond_mask = ocelot_get_bond_mask(ocelot, bond);
 
 		for_each_set_bit(port, &bond_mask, ocelot->num_phys_ports) {
-- 
2.52.0


