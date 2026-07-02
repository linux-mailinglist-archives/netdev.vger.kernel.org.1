Return-Path: <netdev+bounces-304044-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4TtJFyAsRmpFLAsAu9opvQ
	(envelope-from <netdev+bounces-304044-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:15:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D4E6F5218
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:15:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=EBX44Ub2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304044-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304044-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B60530C74B9
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2F446AF3B;
	Thu,  2 Jul 2026 09:07:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4023C548EE;
	Thu,  2 Jul 2026 09:07:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983261; cv=none; b=Qs1P5ZMQmilyDc+5m3pcFRRnRhqeRMoHMH5WXDPhoXzDayu0J+BaG3jP9Bk1YwDtS51w2XBgv73/cquoq1l6z/aT9EQ6LXrrM/F+UZgOtMCzADCzCCBljSXwJlCajvbbMXcijzvz1VB1xJgs7Nf+9k2UzQgWCyC/nXpo7eE7Uw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983261; c=relaxed/simple;
	bh=oScd7japEOC1idJH44EGaJHkPP1XthX0ei3V7q31hFA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CeVb+KXawiuX9XSmb+4wNnB2arCdA029nTebRqRVptDPkrtBTf+YH/IeZFLUrCnTUv83tBiB+aZb8BA+1+ZkRlwfhehsCrAv2XFp7Q/pOlXVdgPtCN8emMyGpu3sOJ6tv9wG/G34bpFEApMe/eJFwA49UC1cF3Ix/2cDVWh8UXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EBX44Ub2; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 46B211A0DD4;
	Thu,  2 Jul 2026 09:07:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 120F25FF03;
	Thu,  2 Jul 2026 09:07:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD2DA104C960F;
	Thu,  2 Jul 2026 11:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782983254; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=RRvU3NLk/4mpVHffnMQIvXjqWxDkr7EvtkKewizk1/4=;
	b=EBX44Ub2oGWA4o66nt8hPWbJ/Bijm+M39Vn8fT9/KjzYlDIzhlpM32Tmi/XNSlXU1UZ/l3
	bxM+aelg3kQ/fPgRJnWV4YHaLLz5zFmJHSORAsq5uC1CBK+iaOKWamWpCeVHE/FFtzt4FT
	HsvRo7mqYX/GEmi/6cvz9yB3BGXsS0sFl8WlY9I35wPpbEAs+iL9uH2/jDkgRHOum3UgcW
	5kHOyhvCU8+wt+QIOhvcCJ4CSewccxAn1j3asu8MEc1YLYRJHENqKkjTa6WFOBsMoD+Idz
	w55I1WlmAO/FCgHcMNfnmxkN5ucfd1ok8dGhPgF7zaOC9N+Hm9bBWICuJysRfw==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH net-next 00/10] net: dsa: microchip: move non-common
 function out of ksz_common.c
Date: Thu, 02 Jul 2026 11:07:22 +0200
Message-Id: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrB0wUVP1KuJC7N86tIySBBHFu
 xtcfov3TgrwgkBddpLHJkEWTTB5RtM86hcs72SyhXWFMzVPf4zKv3BwFWc2rraNe6GtSlBqVo+
 P7M+vJ0VkxR5puK4beDXEQmkAAAA=
X-Change-ID: 20260615-clean-ksz-4th-1652867e943e
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
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
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304044-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C9D4E6F5218

Hi all,

This series continues the rework of the KSZ driver initiated by three
previous series (see [1], [2] & [3]).

The KSZ driver handles more than 20 switches split in several families.
This was previously handled through a common set of dsa_switch_ops
operations that used device-specific ksz_dev_ops callbacks. The three
previous series have split this common struct dsa_switch_ops into 5
to connect the ksz_dev_ops's implentations directly to the new
dsa_swicth ops.

This series continues in the same vein and moves out of ksz_common.c all
the functions that aren't truly common to all the families.

On top of this on-going rework I added PTP and periodic output support for
the KSZ8463 (which was my first goal). There are still more than 13 patches
left for all this so this series will be followed by two others and if you
want to see the full picture we can check my github ([4]).

FYI, I only have a KSZ8463 so, unfortunately, I can't test other switches.

The next series is going to add PTP support for the KSZ8463. The final one
will add periodic output support for the KSZ8463.

[1]: https://lore.kernel.org/r/20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com
[2]: https://lore.kernel.org/r/20260521-clean-ksz-2nd-series-v3-0-75c38971c19a@bootlin.com
[3]: https://lore.kernel.org/r/20260608-clean-ksz-3rd-v2-0-6e61b7be23c4@bootlin.com
[4]: https://github.com/bastien-curutchet/linux/tree/ksz_rework

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
Bastien Curutchet (Schneider Electric) (8):
      net: dsa: microchip: make ksz_is_port_mac_global_usable() static
      net: dsa: microchip: move ksz88xx stats handling in ksz8.c
      net: dsa: microchip: move ksz_get_gbit() and ksz_get_xmii() to ksz9477.c
      net: dsa: microchip: move KSZ9477 errata handling to ksz9477.c
      net: dsa: microchip: handle KSZ8-specific tc setup in ksz8.c
      net: dsa: microchip: move ksz9477_set_default_prio_queue_mapping() to ksz9477.c
      net: dsa: microchip: rename ksz9477_drive_strength_write()
      net: dsa: microchip: move the drive strength config out of the common section

Vladimir Oltean (2):
      net: dsa: microchip: split ksz8_change_mtu()
      net: dsa: microchip: split port_max_mtu() implementation

 drivers/net/dsa/microchip/ksz8.c         | 429 ++++++++++++++++++++--
 drivers/net/dsa/microchip/ksz9477.c      | 164 ++++++++-
 drivers/net/dsa/microchip/ksz9477.h      |   4 +-
 drivers/net/dsa/microchip/ksz_common.c   | 594 +++----------------------------
 drivers/net/dsa/microchip/ksz_common.h   |  85 ++++-
 drivers/net/dsa/microchip/lan937x_main.c |   6 +-
 6 files changed, 679 insertions(+), 603 deletions(-)
---
base-commit: 1c664ec4b9ea827b609d296921ed5bad8a40a158
change-id: 20260615-clean-ksz-4th-1652867e943e

Best regards,
-- 
Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>


