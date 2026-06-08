Return-Path: <netdev+bounces-296590-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x2HXMXHPJmq5kwIAu9opvQ
	(envelope-from <netdev+bounces-296590-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:19:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 693F8657144
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 16:19:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=ScplcYsT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296590-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296590-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6A4130205E1
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703453C343E;
	Mon,  8 Jun 2026 14:10:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670F1E5B63
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 14:10:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927822; cv=none; b=g/np1o8X22zKXShsbpAJOhk22r8wDzQvdg3uSy14EqFio557DfVj5dAI5nPLdsaWOAxth7ih/TbvdqI4Y77gBuYdOPef5uh6UeJZdIhy+0dDjFUX/prxAIyoNbcKzzv5Fal65XQfLrIZh+ChFbvPXDwqTJMpZhbhYgJDIpR39z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927822; c=relaxed/simple;
	bh=J2+ioxrPVO90b1ezOHQW4B+zaHzXbp8ltPxLg0SRULI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cdLqbvPUbxyUA571d5GB22Giyv73/NUW6vFH5/MUBcslQJK4V89P4+gGeQfBlR4+N2rc2vU9FtLff8COqj/U3iBWpiyI4XKs53BNnJhCx8Ph+pqq3+L3rzUJSESGDCmREIq2/WNB+fBvLd0mejAkIMpVMsgvnWzsJomKlaVLAoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ScplcYsT; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 09382C5147D;
	Mon,  8 Jun 2026 14:10:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EB0DE5FFB7;
	Mon,  8 Jun 2026 14:10:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80FCB106A2941;
	Mon,  8 Jun 2026 16:10:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780927816; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=pdgZHlWqI2HFfTl8KYE/+Wd6SsVdnUEgVDj0WLA3gFA=;
	b=ScplcYsTmBOtYJ4vM6txHnmM4fFgLs1hzu3tRJy0hFhXVnab7jQ3RnyOLnqjxoNCoXEZV1
	UxAtbIgaECproW6XzDkwGRFX3YBxmLgT2QBBqPI5sIyg7+qGIgsygXhK2FRAhGDfGEUQPF
	+Hy16v9km6lpOF97eMIrOKIWu7eooi0T/c43+z3KWKGzy5t2HH9eyPT6kNDGCew/gp3QDU
	px3ZJTjwCUM663ZbCbYzDIMqTPU+1dBtgR91j32drjIkM59RrfZRhdCn7UTbpmCydQ5sIo
	d+i39Xp3Z9DNWKb0yGjMoyr1F9aJtTG00Uy4voIXzjfO1qJQxqTCsXF4s3Qpeg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next v2 00/10] net: dsa: microchip: remove unnecessary
 dsa_switch_ops callbacks
Date: Mon, 08 Jun 2026 16:10:03 +0200
Message-Id: <20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12Nyw6CMBBFf4XM2jF92BJc+R+GRSmDNGJL2oagh
 H+3Ia5cnpzcczdIFB0luFYbRFpccsEXEKcK7Gj8g9D1hUEwoZkSCu1ExuMzfVDGHpXhDetrq+V
 goGzmSINbj94dPGX0tGZoixldyiG+j6OFH/7X1H/NhSND1WlJtRT80phbF0KenD/b8IJ23/cv2
 +a07bYAAAA=
X-Change-ID: 20260525-clean-ksz-3rd-5a190d7c63fa
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:tristram.ha@microchip.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296590-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 693F8657144

Hi all,

This series continues the rework of the KSZ driver initiated by two previous
series (see [1] & [2]).

The KSZ driver handles more than 20 switches split in several families.
This was previously handled through a common set of dsa_switch_ops
operations that used device-specific ksz_dev_ops callbacks. The two
previous series have split this common struct dsa_switch_ops into 5
to connect the ksz_dev_ops's implentations directly to the new
dsa_swicth ops.

This series continues in the same vein and removes the dsa_switch_ops
operations that aren't used.

On top of this on-going rework I added PTP and periodic output support for
the KSZ8463 (which was my first goal). There are still more than 20 patches
left for all this so this series will be followed by three others and if you
want to see the full picture we can check my github ([3]).

FYI, I only have a KSZ8463 so, unfortunately, I can't test other switches.

The next series is going to move out of ksz_common.c the last remaining
functions that aren't truly common to all KSZ switches. The series after
that will add PTP support for the KSZ8463 and the final one will add
periodic output support for the KSZ8463.

[1]: https://lore.kernel.org/r/20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com
[2]: https://lore.kernel.org/r/20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com
[3]: https://github.com/bastien-curutchet/linux/tree/ksz_rework

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Changes in v2:
- PATCH 4 & 5: Reduce code duplication by adding
  ksz_phylink_need_config()
- PATCH 6: Add removal of the .set_mac_eee() operation as its usage
  is gated by the .support_eee() presence.
- PATCH 7: Fix the WoL handling for non-KS9477 switches using the
  KSZ9477 operations.
- PATCH 7 & 8: Fix line wrapping to meet the 80 characters per line
  requirement
- Link to v1: https://lore.kernel.org/r/20260526-clean-ksz-3rd-v1-0-5b63e732149a@bootlin.com

---
Bastien Curutchet (Schneider Electric) (9):
      net: dsa: microchip: remove useless common cls_flower_{add/del} operations
      net: dsa: microchip: implement get_phy_flags only if needed
      net: dsa: microchip: wrap the MAC configuration checks in a function
      net: dsa: microchip: remove setup_rgmii_delay() KSZ operation
      net: dsa: microchip: implement .support_eee() only if needed
      net: dsa: microchip: implement .{get/set}_wol only if needed
      net: dsa: microchip: implement port_hsr_join for KSZ9477 only
      net: dsa: microchip: implement lan937x-specific MDIO registration
      net: dsa: microchip: implement port_teardown only if needed

Vladimir Oltean (1):
      net: dsa: microchip: remove VLAN operations for ksz8463

 drivers/net/dsa/microchip/ksz8.c         |  56 +++----
 drivers/net/dsa/microchip/ksz9477.c      | 130 ++++++++++++++-
 drivers/net/dsa/microchip/ksz9477.h      |   2 -
 drivers/net/dsa/microchip/ksz_common.c   | 274 ++++---------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  57 +------
 drivers/net/dsa/microchip/lan937x_main.c | 127 ++++++++++++--
 6 files changed, 293 insertions(+), 353 deletions(-)
---
base-commit: d4cc6e9596c431a172ddad5d7c03819c8fdf4ead
change-id: 20260525-clean-ksz-3rd-5a190d7c63fa

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


