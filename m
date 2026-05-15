Return-Path: <netdev+bounces-288332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DdJIwQ0B2outQIAu9opvQ
	(envelope-from <netdev+bounces-288332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:56:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBCC551BD2
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6448130293EA
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 14:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0B83BB138;
	Fri, 15 May 2026 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="PYaiFOsk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-74.smtpout.orange.fr [80.12.242.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D64D3BA22C
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856716; cv=none; b=qV+rBBHYgVBAghtToZChIgnnWWq2oi6+aynTheBRt3jdQVpotb/NvInT1QbOv3ROPYp95cuXCudRzmaZ3BYN5O4KPpeYX8D3PE5ysmC20CPNvl3DXdx/KE+mVIrEFQ73/Kqe+EdaZBLBRqG/zwyW2gpHt9Y8lM8caDShZFEgSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856716; c=relaxed/simple;
	bh=s9VLSmAHWj0fdoNIuqJrjoZ5YXTT4s9Ibk+lEqfY9VU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d+fcUwvPdQy9re/XNAlQFXkv9NUgCFVj2td/wAQ54g5EDgQddmD11RgFCQnglcac11U5DyIEFXtVUGVSRqHqF0vKsuCxqoXOI982FN30VTp+bnHTyUTmbydwh7qAog0XhETjeAuz67sZWUn3YS6On2X0+2DXg/n3eYq4QgxJFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=PYaiFOsk; arc=none smtp.client-ip=80.12.242.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([10.65.86.62])
	by smtp.orange.fr with ESMTP
	id NtsCwQsiFPyAeNtsCwATZS; Fri, 15 May 2026 16:50:44 +0200
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id Nts1wguySDTmsNts1wk1Vt; Fri, 15 May 2026 16:50:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1778856636;
	bh=G03VaXEuBKvCaC9Qfcc7bTAZrEJFyxVeTaTBztvmiCE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PYaiFOsk8X7wKV8yX2Rmp4t8PqDw05nfJLj8KUopevx1Ul+Y+Wu9LTuImdMQNuYNB
	 JzDVgmd8lu/WLJfoZ/gUv0rJSEC8D4GEp35So5ahHu2EaEJpauAMZ39ZkBjvI3T7vD
	 9QOS1gwvQgcBfsO3tuOCCW4iJRdDVqfjL0HAAHXroROJq5n7w+jRQXlnOSFE1WW8mH
	 iFA7ruyOOIYGUFNxyyshRoHNyGsivvyuQ7HZgKpRVAHWZfEFspIegPhuUXY05ZVrrY
	 zwFM4i/6WUYS0JzuOD3a7kgjs9InZiZHR07gy/0b5ODWOcV1xXRIbymK3UAav5MSO8
	 EAG+SEbe6pRqA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 May 2026 16:50:36 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] net: phy: micrel: Code clean-up
Date: Fri, 15 May 2026 16:50:23 +0200
Message-ID: <cover.1778856199.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECBCC551BD2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[wanadoo.fr,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[wanadoo.fr:s=t20230301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,wanadoo.fr];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288332-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[wanadoo.fr];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.jaillet@wanadoo.fr,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This serie is only some clean-up related to
drivers/net/mdio/mdio-mscc-miim.c

It depends on a patch called "[PATCH net-next] net: phy: micrel: use dev_err_probe()"
that has been sent recently.

Note that in the 2nd patch, the order of the calls in the remove
function is changed. I don't think that it matters, but I'm always
relunctent to change such things.

The patches are compile tested only.

Christophe JAILLET (3):
  net: mdio: mscc-miim: Remove some redundant code
  net: mdio: mscc-miim: Use devm_clk_get_optional_enabled()
  net: mdio: mscc-miim: Use devm_of_mdiobus_register()

 drivers/net/mdio/mdio-mscc-miim.c | 34 +++++--------------------------
 1 file changed, 5 insertions(+), 29 deletions(-)

-- 
2.54.0


