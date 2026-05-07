Return-Path: <netdev+bounces-285126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALgnJd7/+2njJgAAu9opvQ
	(envelope-from <netdev+bounces-285126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:58:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 223B34E281B
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A4C8300A309
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 02:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAF62BE03C;
	Thu,  7 May 2026 02:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cbri7+/R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B123921D3E4
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 02:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778122716; cv=none; b=LyXLX8Skbkw02PezXgl0yQrww3VyrGCaBq30vGTi8vkWSd8oYnIWXKNaTIYPAXlrf938jQuSBds3CIRdVttyLx1Ql5e81vq7CAp7QEe7NT1tspmuFWOB1GnS6ZFDwbaFnAHX5+JeFCHiyrQHJZaLsXn0qtfvrZKPPQ64YeN7HoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778122716; c=relaxed/simple;
	bh=9UIIckWAkaBet6+X4R1cryCE7+hKS5+Dl6gBJSH9zeE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W0y6XrDUvYaFdCIfFsmrwRh7fOuETtuMhyz4FS5cvBhWh5JO24I7qHtgP4fVVAgYcTXYn8G9F6HqulOr88oWAGnmmkzdbPQN5UbXdkiM0lFErBhc/cUjYvrtyn8XGlgdc30xofzkNRPds7i47eRkRmel6BR0ZI3pc+zOODCSDZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cbri7+/R; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1309f4ee97fso588693c88.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 19:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778122714; x=1778727514; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fZOePm/WIEX3od4IgMSmtqRgXfakcmRFfXc30LyJmg=;
        b=Cbri7+/RjhI+0gd0NhiXOIR1GKlfDFMSwBe0D4/HfW0yu6V22g5+tUTnvJHifeTWk+
         Z851J/okK5wIp9GwBwDssMa6R8276IoHzgQG1p+fPDw3Zbxl2IIa+GuC/pe1/1Ul8xqi
         mYx5/NBUMesK3OvBDnp29spCxokTNNytzOL+pm/P22LlKHsdf9JohOBlzCZvMFF5mCRu
         Q9xj9VhBDt0v2FHJB2VCpywfY6tFpIgUBlwPwenWXzM2iKwHgLNv/KgWSGfITbz/dtlT
         93kDVDX8cO+vpeY+NcOMH/RCjCOK+t6E/46Lqd/pnDKqcdVfLpgmpmBS/IIL4vY6FalE
         cedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778122714; x=1778727514;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fZOePm/WIEX3od4IgMSmtqRgXfakcmRFfXc30LyJmg=;
        b=gWVqBJwLtMtNc6ICy/0RbrkxBTM6tYvIFkv2vQa8+SEUCqPBW/Anb1+B7OVudG/fKi
         P/mss1jP+jx0t6JORhIXy8rGI33c4pk2o7DRTgOyEpXC/9V6Fn1NH2pvOakpphwkJkLF
         zXgVw0LcvYYMmVQw3tatPpzpFmwmcfun6SycGwfBy241j4dRQ220YapukiaJyo4gUrsf
         US1AQ8rAMm1vdkiIA7qBT3fvlEUpBmMSt0H9N84NzS6kBVQDY3tnELlU9n88tAR/BUet
         qA36gW0D/vYDiohDrQUcDqlkzJ2w0qcrJh1RFz+4K1rZ8tbvK03HXq4pNT5UltxJvIax
         xQrA==
X-Gm-Message-State: AOJu0Yz7OjwbrnkzA+w2ydEr6B0u7d6JTtGdQcYLu3AobN9Jje/QX849
	GD0CtpMWNZgErpFRrqUtkTxvIwmGUNCjDajkqSGspu3Zknu7adLSM7CC
X-Gm-Gg: AeBDiev6LRVanufixIz843Ad9hYdldZXxBXhF9sySVIW1XVL/fT94ZxMLudQnARS3Fi
	ugGmCsjpmomu78IlFTXZFdMSilXG1dbf4VQVwb/z0o575JefCPb+QYS4RBbj9nk+t/SK2z9yAyR
	1YGYp55LNQZwT7QC/3x0exRwpobk5iZI+z3+T5rLs8ewoxg88S/Rg4DF5bXq9ZufRMu+QyYKa1E
	9qQOVw75jecMH70AeXFox5AFYaIe1b/tbmLRCEP6OJ8Z394kAyP6KTf5XL8AoCU2T8VHFf1IIoH
	3kY0bYhYaLEyzrdxxlfz4UU7zb/NSmMHG9G606aWfOCTt3+eRyQx3kUIsqEDorzrl19He+6Ry74
	kVFoKbjJwAEIA8Qwr+IXwkfLZWrL5o5ZAbWaU304+uYPE2fPdk7WcZk5K/vs2Ap+dLrQLRssCeY
	Qn6Mz+/fvygPByyLg161bfm8L5xVM7GjDwzfFHLyej0VOzFYvrSw==
X-Received: by 2002:a05:7022:914:b0:122:2f4:b285 with SMTP id a92af1059eb24-1319cf59324mr3296977c88.25.1778122713600;
        Wed, 06 May 2026 19:58:33 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-131f9789e3dsm6561267c88.8.2026.05.06.19.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 19:58:32 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [net-next PATCH v3 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
Date: Wed, 06 May 2026 23:58:17 -0300
Message-Id: <20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMr/+2kC/2WOXwvCIBRHv8rwOcN/Oeqp7xER6u42aWmo2GLsu
 yf2ULDHH4dz7l1QhGAholOzoADZRutdGXzXIDMqNwC2XdmIESYJZxwHUFOC+6334aVCh6lWhqu
 2NVIKVKxngN7OtXhBDhJ2MCd0LWS0Mfnwrqcyrfxb5XRTzRQTLESvJS9ct3AeHspOe+MftZXZz
 z+Q7VeZFb8jUgBjRPMj/ffXdf0ACCylBPgAAAA=
X-Change-ID: 20260323-realtek_forward-1bac3a77c664
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, 
 Yury Norov <ynorov@nvidia.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 223B34E281B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285126-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,davemloft.net:email]
X-Rspamd-Action: no action

This series introduces bridge offloading, FDB management, and VLAN support
for the Realtek rtl8365mb DSA switch driver. The primary goal is to
enable hardware frame forwarding between bridge ports, reducing CPU
overhead and providing advanced features like VLAN and FDB isolation.

Some of these patches are based on original work by Alvin Šipraga,
subsequently adapted and updated for the current net-next state.

---
I attempted to reach Alvin for review of the final version but was
unable to establish contact. Any regressions in this version are my
responsibility.

Changes in v3:
- Fixed kernel-doc warnings
- Removed unnecessary defensive checks
- Link to v2: https://patch.msgid.link/20260503-realtek_forward-v2-0-d064e220b391@gmail.com

Changes in v2:
- added patch to use ERR_PTR()
- dropped bitfield patch. Use FIELD_PREP instead. Suggested by Yury
  Norov
- tag_rtl8_4 patches were submitted on its own series (already accepted)
- dropped rtl8365mb_vlan_mc_port_{add,del}(). rtl8365mb_vlan_mc_port_set
  is now called directly from PVID methods.
- reordered methods in rtl8365mb_vlan.c
- use dsa_switch_for_each_user_port() instead of simple for in bridge
  port join/leave
- PVID check now uses dsa_switch_for_each_available_port instead of
  dsa_switch_for_each_port
- set EFID of user ports to 0 at setup(), although it is the expected
  state after reset
- STP patch was dropped and replaced by a more extensive one that
  disables all ports (including unused ones) before setting CPU and user
  ports. It also extended the CPU port isolation to include all user
  ports.
- refactored bridge, FDB, and MDB port operations into the common
  rtl83xx module, introducing new realtek_ops callbacks to abstract the
  hardware access
- Collected Reviewed-by and Suggested-by tags
- Link to v1:
  https://patch.msgid.link/20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com

To: Linus Walleij <linusw@kernel.org>
To: Alvin Šipraga <alsi@bang-olufsen.dk>
To: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Alvin Šipraga (6):
      net: dsa: realtek: rtl8365mb: prepare for multiple source files
      net: dsa: realtek: rtl8365mb: add table lookup interface
      net: dsa: realtek: rtl8365mb: add VLAN support
      net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}
      net: dsa: realtek: rtl8365mb: add FDB support
      net: dsa: realtek: rtl8365mb: add bridge port flags

Luiz Angelo Daros de Luca (2):
      net: dsa: realtek: rtl8365mb: use ERR_PTR
      net: dsa: realtek: rtl8365mb: use dsa helpers for port iteration

 drivers/net/dsa/realtek/Makefile                   |   4 +
 drivers/net/dsa/realtek/realtek.h                  |  42 ++
 drivers/net/dsa/realtek/rtl8365mb_l2.c             | 493 +++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_l2.h             |  32 +
 .../dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c}  | 548 ++++++++++++--
 drivers/net/dsa/realtek/rtl8365mb_table.c          | 214 ++++++
 drivers/net/dsa/realtek/rtl8365mb_table.h          | 131 ++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.c           | 797 +++++++++++++++++++++
 drivers/net/dsa/realtek/rtl8365mb_vlan.h           |  25 +
 drivers/net/dsa/realtek/rtl83xx.c                  | 482 +++++++++++++
 drivers/net/dsa/realtek/rtl83xx.h                  |  27 +
 11 files changed, 2727 insertions(+), 68 deletions(-)
---
base-commit: edf4bee4215a173c0534d1851d7523d827149f9e
change-id: 20260323-realtek_forward-1bac3a77c664

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>


