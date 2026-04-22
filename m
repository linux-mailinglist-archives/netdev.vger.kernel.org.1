Return-Path: <netdev+bounces-280520-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MCsAkEN6WnrTgIAu9opvQ
	(envelope-from <netdev+bounces-280520-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 20:02:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D340344980B
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 20:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90DB73036D57
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA10392C39;
	Wed, 22 Apr 2026 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ahIiLds1"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E98525A2BB;
	Wed, 22 Apr 2026 18:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880956; cv=none; b=Xh5h5yRjCoWKtG8kwnobWzvV1CgMRI/oY2pFbBDExqOfT7iT+0mHYf65qZ1sXQMbvSYzD2WiMXBJgT+nLhyY+vfuGa9m07ewBuF+gDlG1eDYygYa0ftkOFtpPIsQYK8fT72FvDx0boOWVv/kPNMZxLSf2A/5GK1TSfQflMQgrTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880956; c=relaxed/simple;
	bh=EoYmGexguo+mU8EjdSB4Iv0Ze1qn7WX/0hniW6r88XQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lTdghHQAvp3DI9aAbj/b4M47jgyRXqKs7v8yhqHneC8sKcohkBKB1T3fDezkD/uPpJkRQ3z+ZrkcHYkiCe14/WSeU7fOFXETW7OeAmHwfu0/MzeveiKZ58ajAbwjNHjtMe1WUt1M/pRP6vEdk52P3SNdQdnsr74MiD2G86usrSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ahIiLds1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6kohzOj2T0pkVfWYb516iKU/iaad/TGaoj9+cE8xOTU=; b=ahIiLds1CLn8AMCqhmIes12jz2
	bo0TZOp81xVAMZ5m68W7CJhgohKYO4HL+I+SJc4GPdbmge0QfFvtfR5wR0kiIFMd8A8s7+OftgFTK
	m4Xmt6CgQSDWtw/KY+KFuhEfhhGMmH+HLp4i+5AVG2x8a/8Ar2+hVK6WKPiefvj8SfkY=;
Received: from c-66-41-74-139.hsd1.mn.comcast.net ([66.41.74.139] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wFbu0-00H4Ba-SZ; Wed, 22 Apr 2026 20:02:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net v2 00/15] Remove a number of ISA and PCMCIA Ethernet
 drivers
Date: Wed, 22 Apr 2026 13:01:43 -0500
Message-Id: <20260422-v7-0-0-net-next-driver-removal-v1-v2-0-08a5b59784d5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAcN6WkC/5WN0Q6CMAxFf4X02ZptIhs++R+GBxxFluAgHS4Yw
 r/b8Aemtw/3Nr1ng0QcKMGt2IAphxSmKMacCvBDG1+EoRMPRplKlUZjtqhkIi2y64Idh0yMTO8
 ptyNmjaX1zvna2eelBOmZmfqwHowHyB80Eg4hLRN/D27Wx+kPhEhhVV+19ZWrO93fx0+MZz9As
 +/7Dyy6aFnVAAAA
X-Change-ID: 20260421-v7-0-0-net-next-driver-removal-v1-47c88c987b34
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
 Michael Fritscher <michael@fritscher.net>, 
 Byron Stanoszek <gandalf@winds.org>, Daniel Palmer <daniel@0x0f.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4115; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=EoYmGexguo+mU8EjdSB4Iv0Ze1qn7WX/0hniW6r88XQ=;
 b=owEBbQKS/ZANAwAIAea/DcumaUyEAcsmYgBp6Q0fsGnZHayIipZUDrEmyOtJtPOjdoBuqowtD
 OpeEwUNfGGJAjMEAAEIAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCaekNHwAKCRDmvw3LpmlM
 hA2oEACoPWqT2MKHjlxwpZSke8UxHEMpWtQQEOGYNrbfMuIlrsWkETuNUGWk3QvVUvCDjeiJ+8p
 j3wpKEu5b5skVB2HdlhE5lMQy/Odonjq+Laoc4Or/PsZIn75Ebr7MqALkP+Zg7XllB7RSR+Wydn
 DioX8a3LWHW/lrXOzXlDUSCCTxq/cI4pmCIyE3IIORhZJSrfSachcc/hl1WVOk62MJwtbqSWAtN
 ScV914jmBNh87v72bxiKJtYu/4bNclyvuWAp0+9YaYCsWXjaqjvaOvfZlpWMEM/WBbAO37dqh+K
 qzd9/q3u0jrddnqH2TpK96qHk/vm3rIaE+wAwPEYGdj0Y8qjqHdCF51cMgZ4REqzYc3nX8j+Ac7
 jWYBr/DivXQlBAlPi8se01zaFTBfMn6DNHo0YDCJtWSNnjsEtXpwa3SacxqIHF4uq7CqwraMiC0
 wJYE9RgqPrHywBNItSP6vbkS5Kk1UITRlw3mcEoQQas0i4KLf07vZxMblz0eBXEJ9JxptEEC7ii
 GbftxwjT1WCkTksdB1Vb1q4fDFACUr8E+0Y6U16fy/boWPq07eBA0hKVi+wQHqldRO3KaE3Q2ud
 SNT+QbpO+2d1fDYxCxycPZzS0/vg0XE/0Cb+6s2R+4Cf+uuF9kGTRmRTNFb7HH5SQs/tSWfw2Kh
 LzMsLAx8iO2yO6w==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280520-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D340344980B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

These old drivers have not been much of a Maintenance burden until
recently. Now there are more newbies using AI and fuzzers finding
issues, resulting in more work for Maintainers. Fixing these old
drivers make little sense, if it is not clear they have users.

These mostly ISA and PCMCIA Ethernet devices, mostly from the last
century, a couple from 2001 or 2002. It seems unlikely they are still
used. However, remove them one patch at a time so they can be brought
back if somebody still has the hardware, runs modern kernels and wants
to take up the roll of driver Maintainer.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v2:
- Drop removal of 3c59x and xirc2ps, MVME147
- Remove some documents which belong to the drivers being removed.
- Link to v1: https://lore.kernel.org/r/20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch

---
Andrew Lunn (15):
      drivers: net: 3com: 3c509: Remove this driver
      drivers: net: 3com: 3c515: Remove this driver
      drivers: net: 3com: 3c574: Remove this driver
      drivers: net: 3com: 3c589: Remove this driver
      drivers: net: amd: lance: Remove this driver
      drivers: net: amd: nmclan: Remove this driver
      drivers: net: smsc: smc9194: Remove this driver
      drivers: net: smsc: smc91c92: Remove this driver
      drivers: net: cirrus: cs89x0: Remove this driver
      drivers: net: cirrus: mac89x0: Remove this driver
      drivers: net: fujitsu: fmvj18x: Remove this driver
      drivers: net: 8390: AX88190: Remove this driver
      drivers: net: 8390: pcnet: Remove this driver
      drivers: net: 8390: ultra: Remove this driver
      drivers: net: 8390: wd80x3: Remove this driver

 .../device_drivers/ethernet/3com/3c509.rst         |  249 ---
 .../device_drivers/ethernet/cirrus/cs89x0.rst      |  647 ------
 .../device_drivers/ethernet/smsc/smc9.rst          |   48 -
 drivers/net/ethernet/3com/3c509.c                  | 1448 --------------
 drivers/net/ethernet/3com/3c515.c                  | 1566 ---------------
 drivers/net/ethernet/3com/3c574_cs.c               | 1164 -----------
 drivers/net/ethernet/3com/3c589_cs.c               |  974 ---------
 drivers/net/ethernet/3com/Kconfig                  |   45 -
 drivers/net/ethernet/3com/Makefile                 |    4 -
 drivers/net/ethernet/8390/Kconfig                  |   52 -
 drivers/net/ethernet/8390/Makefile                 |    4 -
 drivers/net/ethernet/8390/axnet_cs.c               | 1707 ----------------
 drivers/net/ethernet/8390/pcnet_cs.c               | 1717 ----------------
 drivers/net/ethernet/8390/smc-ultra.c              |  630 ------
 drivers/net/ethernet/8390/wd.c                     |  575 ------
 drivers/net/ethernet/Kconfig                       |    1 -
 drivers/net/ethernet/amd/Kconfig                   |   21 -
 drivers/net/ethernet/amd/Makefile                  |    2 -
 drivers/net/ethernet/amd/lance.c                   | 1317 -------------
 drivers/net/ethernet/amd/nmclan_cs.c               | 1508 --------------
 drivers/net/ethernet/cirrus/Kconfig                |   40 -
 drivers/net/ethernet/cirrus/Makefile               |    2 -
 drivers/net/ethernet/cirrus/cs89x0.c               | 1915 ------------------
 drivers/net/ethernet/cirrus/cs89x0.h               |  461 -----
 drivers/net/ethernet/cirrus/mac89x0.c              |  577 ------
 drivers/net/ethernet/fujitsu/Kconfig               |   30 -
 drivers/net/ethernet/fujitsu/Makefile              |    6 -
 drivers/net/ethernet/fujitsu/fmvj18x_cs.c          | 1176 -----------
 drivers/net/ethernet/smsc/Kconfig                  |   27 -
 drivers/net/ethernet/smsc/Makefile                 |    2 -
 drivers/net/ethernet/smsc/smc9194.c                | 1535 ---------------
 drivers/net/ethernet/smsc/smc91c92_cs.c            | 2059 --------------------
 32 files changed, 21509 deletions(-)
---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260421-v7-0-0-net-next-driver-removal-v1-47c88c987b34

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


