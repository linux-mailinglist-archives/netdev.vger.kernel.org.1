Return-Path: <netdev+bounces-292384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN5FHG4fF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:44:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1333C5E7F40
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4B2C30C80EF
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712B143CECC;
	Wed, 27 May 2026 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="m/Ig2OFF"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B879742EEAC
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779899729; cv=none; b=CjyBPc4Hs4NMi85/+yBtGZrpDKnOVooh1V4mAF00iP5I0iLTq0CRQ4W6d4IM83sp4MXxOEe/rf5vpKSMUFYKw4l8RFz7qnvddCxct+0AxddIUB+CddlQ8w0b7oeUQkURCnmr3/OKp3mEVhDpT98k2sqq5pXHljoe13bcAXbfKLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779899729; c=relaxed/simple;
	bh=UY5I+Pzl6/USg8L6qMO92Tcqs3jp+SsNWOh+N9yw7j8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifwPx/0oR1HOf2yqAK3OlOPBaNFffwVclP4HrZOidqEXAKfmJNdP0/AFIifoAPIBOeJ6xXbzx/6KNC6GRXohCOf4T0yqBHG7FcAb2svjw+EDqdzL2UXi6KO//QGOY5CHRiBoeOCNEf1C0vrffsyZtYE50JuNzCYIUwcFnVA3Lv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=m/Ig2OFF; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779899707; x=1780504507;
	i=markus.stockhausen@gmx.de;
	bh=rnl5vWGExNIHJBdqAm7rsSLMGGUQ4ypM/MOdUPw09GA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m/Ig2OFF6NAiiNqluG+Nuw/jjV8J1y2C9GU+hBbtaIKbcyA55IejYKrseCK8wkkd
	 d/wMo0clo5Ex4PQ7bZXfh+b/KnP/np596kOuUVrVK4uxsF3/CNPu7iimtf/yONj7e
	 oacbdms7f1V0PBYtqxau0rAV07Kfj8sPBA7q/xjh6nz5WfGuVRIk0KtwPEGOxL+dN
	 hsdCyRUM3l0M7bN2hSTuVn3g/qC0bfzlzCTK7v2NJmlMZ+oavHel89cl69m9KSN7D
	 UcEpuBrREG9kLvgEISeNhnaGm76/A0tJaLyWsGCATVkbAY4790j6JR/yBjVgZmaFI
	 12OlZwDqsfRtraI3NA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1xPt8l1384-0137Jk; Wed, 27
 May 2026 18:35:07 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v2 0/4] net: mdio: realtek-rtl9300: SoC independent command runner
Date: Wed, 27 May 2026 18:34:45 +0200
Message-ID: <20260527163449.1294961-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6UUUQPdlBXKzrvVVOtZ3DHmKT7Ry1wfz+Zt0NUOR4B8/AHF7DGC
 pH3ISHto2mO0J3PAiaY1Pzc2L6nZ0ZsboVimaYVNeOhDYVkd6HjNtxdjcREW/favR+XwjcN
 inJiyZExHWDfcsyml9dNgXEZItSrugHTEq6n8F4MELcuExvypYrBCbFhB681799tiQ5lj9n
 2PalQNvSPYzWggrO4VyDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:goBjy0EgzUM=;0Ew/hcPUATCCr3DiZ+qWrnR9IbZ
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_FROM(0.00)[bounces-292384-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markus.stockhausen@gmx.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.de:email,gmx.de:mid,gmx.de:dkim]
X-Rspamd-Queue-Id: 1333C5E7F40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The Realtek Otto switch platform consist of four different series

- RTL838x aka maple   : 28 port 1G Switches
- RTL839x aka cypress : 52 port 1G Switches
- RTL930x aka longan  : 28 port 1G/2.5G/10G Switches
- RTL931x aka mango   : 56 port 1G/2.5G/10G Switches

After establishing basic groundwork for multi device support, this series=
=20
harmonizes the command handling of the MDIO driver. It is the second step
to allow easier integration of the non RTL930x SoCs into this driver.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--

v1 -> v2
 - Avoid cast in otto_emdio_bus_to_priv()
 - Implicit function dereferencing. priv->fn() instead of (*priv->fn)()
 - Add otto_emdio_read_cmd() and otto_emdio_write_cmd() to encapsulate
   the command runner. It avoids using NULL/value parameter to steer
   the function behaviour. This involves
   - Move lockdep_assert_held() from command runner into new functions.
   - Add cmd_read and cmd_write bitmasks to info structure and make use=20
     of it in the new command functions.
   - squash patch 3/5 ("Prepare command runner for reads") and patch 4/5
     ("use command runner for read_c45()") into one. There is no longer
     the need to change runner signature.
 - Describe subtle MMIO poll timeout difference of patch 1. There is no
   code change between v1/v2.  Before 100us for reads and 1000us for
   writes, now 1000us for all.
 - Add comment to runner to make clear that writing to all registers is
   no issue. This makes future reviews easier.
 - Consistently name variable cmd_data instead of cmd_regs in helpers.
   v1 used a mix of both. cmd_data aligns with signature of runner and
   its direct read/write consumers.
v1: https://lore.kernel.org/netdev/20260526174344.1186832-1-markus.stockha=
usen@gmx.de/


Markus Stockhausen (4):
  net: mdio: realtek-rtl9300: provide generic command runner
  net: mdio: realtek-rtl9300: use command runner for write_c22()
  net: mdio: realtek-rtl9300: use command runner for read_c45()
  net: mdio: realtek-rtl9300: use command runner for read_c22()

 drivers/net/mdio/mdio-realtek-rtl9300.c | 349 +++++++++++-------------
 1 file changed, 158 insertions(+), 191 deletions(-)

=2D-=20
2.54.0


