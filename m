Return-Path: <netdev+bounces-280891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cM59Lzmx6mkWCgAAu9opvQ
	(envelope-from <netdev+bounces-280891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:54:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB7D458715
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A5FC300E019
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 23:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9083D904F;
	Thu, 23 Apr 2026 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQNDBdK6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B9B3D9031;
	Thu, 23 Apr 2026 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776988464; cv=none; b=mHEKQz6LZWduUYngxhbHEpCT4Wk0IoZ/hi/ZBgks84Oj+AoF/gLvRCyARomkk1n8APkk8V0TgMwVOtgAk+Cmq00ew142KOlcm1s8bpUke9H+rT3CgYuZhQkF8wsdrl6RpSpP8ViBWzqXZXeIkq05dnlwSrY2dVxLCtBRxMEq/r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776988464; c=relaxed/simple;
	bh=xSYGhA8NBdeA+BkGufctAtR0Tlmly5tAQK4jOfX9v54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CoXOoIqQcbZjUqqKADP9TgWfoKPqwzCFVlw3GgHRF6C9+q/mLcP4g9007V8wlqob4QlVYhbYxjguOIsAcRFawFYffdlYN4XvD0G6Voy8S8aSXaKJwEogeKgBU0tyC/kHHlwqPx2qWT1LzJe3ccS8qHQMpxiy7gbftane9D5t7As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQNDBdK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F02C2BCAF;
	Thu, 23 Apr 2026 23:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776988463;
	bh=xSYGhA8NBdeA+BkGufctAtR0Tlmly5tAQK4jOfX9v54=;
	h=From:To:Cc:Subject:Date:From;
	b=pQNDBdK6x9nVKRCeJ3Yow151193yyNmx5a0IInEboBhYFT14+y627VuLfWY0vJPUs
	 +qGAsC25f/HFFxGixvQqAzokQmz6jlkA+j4PN5DXHiYaq3iMbd2Wed5RKRWOOSWmdF
	 y8h/suXJxeZGVcw11z+RoFqWVW34WKKPX8Ov35ymfOC867Yy88Z3mN/z8sjn46kZJd
	 lYGl6SIX1CpoKB4xT2T0WYAG8PJcYfbvUtN00fPMkesMWtDD43NvjCaXyAZY6WOsH1
	 HvhovP8QJVz8na1RcLCFhFDAXrItazaQtiYBvtzhGpirwPJnzMHkoTY/h4B3Iuh6pZ
	 iyZoOoii1c11A==
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com
Subject: [GIT PULL] Networking deletions for 7.1
Date: Thu, 23 Apr 2026 16:54:22 -0700
Message-ID: <20260423235422.1541768-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3DB7D458715
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280891-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Hi Linus!

I've been trying to figure out how to survive the change in rate
of submissions and we're doing 3 things in parallel:
 - more/better LLM code review tools
 - email bots guiding noobs and if needed throttling submissions
 - deleting long-orphaned code (unless someone steps up immediately)

This PR is part of the 3rd point. I did move what could be built
as a module to a GH repo, in case it helps someone.
But I assume this is all basically unused code.

For the LLM reviewer part tweaking local prompts is showing its limits.
They are missing 50%+ of bugs Sashiko finds. (Sashiko is using LLM APIs
directly.) Sashiko/Gemini finds a lot of real issues but it reports
side-issues and occasional false positives. Paolo says we spend
~40% of our time checking LLM outputs, sounds about right. I hacked up
a Sashiko/Claude/semcode combo which is _much_ better in terms of
false positives. But it also misses real things Sashiko/Gemini finds.
Magic bullet I was hoping for yet to be found.

The following changes since commit 1f5ffc672165ff851063a5fd044b727ab2517ae3:

  Fix mismerge of the arm64 / timer-core interrupt handling changes (2026-04-14 23:03:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-deletions

for you to fetch changes up to 0c22ed0fadcad620277a56c0ba2867d4850d053a:

  Merge branch 'remove-a-number-of-isa-and-pcmcia-ethernet-drivers' (2026-04-23 15:57:10 -0700)

----------------------------------------------------------------
Delete some obsolete networking code

Old code like amateur radio and NFC have long been a burden
to core networking developers. syzbot loves to find bugs
in BKL-era code, and noobs try to fix them.

If we want to have a fighting chance of surviving the LLM-pocalypse
this code needs to find a dedicated owner or get deleted.
We've talked about these deletions multiple times in the past
and every time someone wanted the code to stay. It is never
very clear to me how many of those people actually use the code
vs are just nostalgic to see it go. Amateur radio did have
occasional users (or so I think) but most users switched
to user space implementations since its all super slow stuff.
Nobody stepped up to maintain the kernel code.

We were lucky enough to find someone who wants to help with NFC
so we're giving that a chance. Let's try to put the rest of
this code behind us.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

----------------------------------------------------------------
Andrew Lunn (12):
      drivers: net: 3com: 3c509: Remove this driver
      drivers: net: 3com: 3c515: Remove this driver
      drivers: net: 3com: 3c574: Remove this driver
      drivers: net: 3com: 3c589: Remove this driver
      drivers: net: amd: lance: Remove this driver
      drivers: net: amd: nmclan: Remove this driver
      drivers: net: smsc: smc9194: Remove this driver
      drivers: net: smsc: smc91c92: Remove this driver
      drivers: net: fujitsu: fmvj18x: Remove this driver
      drivers: net: 8390: AX88190: Remove this driver
      drivers: net: 8390: ultra: Remove this driver
      drivers: net: 8390: wd80x3: Remove this driver

Jakub Kicinski (6):
      caif: remove CAIF NETWORK LAYER
      net: remove ISDN subsystem and Bluetooth CMTP
      net: remove ax25 and amateur radio (hamradio) subsystem
      net: remove unused ATM protocols and legacy ATM device drivers
      Merge branch 'net-packetengines-remove-obsolete-pci-drivers'
      Merge branch 'remove-a-number-of-isa-and-pcmcia-ethernet-drivers'

Mingyu Wang (2):
      net: packetengines: remove obsolete hamachi driver
      net: packetengines: remove obsolete yellowfin driver and vendor dir

 CREDITS                                            |    5 +
 Documentation/.renames.txt                         |    6 -
 Documentation/admin-guide/kernel-parameters.txt    |   18 -
 Documentation/isdn/credits.rst                     |   73 -
 Documentation/isdn/index.rst                       |   14 -
 Documentation/isdn/interface_capi.rst              |  336 --
 Documentation/isdn/m_isdn.rst                      |    9 -
 Documentation/networking/6pack.rst                 |  191 -
 Documentation/networking/ax25.rst                  |   17 -
 Documentation/networking/caif/caif.rst             |  138 -
 Documentation/networking/caif/index.rst            |   12 -
 Documentation/networking/caif/linux_caif.rst       |  195 -
 .../networking/device_drivers/atm/fore200e.rst     |   66 -
 .../networking/device_drivers/atm/index.rst        |    2 -
 .../networking/device_drivers/atm/iphase.rst       |  193 -
 .../device_drivers/ethernet/3com/3c509.rst         |  249 -
 .../networking/device_drivers/ethernet/index.rst   |    2 -
 .../device_drivers/ethernet/smsc/smc9.rst          |   48 -
 .../networking/device_drivers/hamradio/baycom.rst  |  174 -
 .../networking/device_drivers/hamradio/index.rst   |   12 -
 .../device_drivers/hamradio/z8530drv.rst           |  686 ---
 Documentation/networking/device_drivers/index.rst  |    1 -
 Documentation/networking/index.rst                 |    3 -
 Documentation/staging/magic-number.rst             |    3 -
 Documentation/subsystem-apis.rst                   |    1 -
 .../translations/it_IT/staging/magic-number.rst    |    3 -
 .../translations/sp_SP/process/magic-number.rst    |    3 -
 .../translations/zh_CN/networking/index.rst        |    1 -
 .../translations/zh_CN/process/magic-number.rst    |    3 -
 .../translations/zh_TW/process/magic-number.rst    |    3 -
 MAINTAINERS                                        |  105 +-
 arch/alpha/configs/defconfig                       |    1 -
 arch/arm/configs/ixp4xx_defconfig                  |    4 -
 arch/arm/configs/neponset_defconfig                |    1 -
 arch/arm/configs/u8500_defconfig                   |    1 -
 arch/mips/configs/bcm47xx_defconfig                |    1 -
 arch/mips/configs/bigsur_defconfig                 |   10 -
 arch/mips/configs/db1xxx_defconfig                 |    1 -
 arch/mips/configs/gpr_defconfig                    |   24 -
 arch/mips/configs/mtx1_defconfig                   |   32 -
 arch/mips/configs/rb532_defconfig                  |    1 -
 arch/mips/configs/rm200_defconfig                  |    7 -
 arch/mips/configs/rt305x_defconfig                 |    1 -
 arch/mips/configs/xway_defconfig                   |    1 -
 arch/powerpc/configs/ppc6xx_defconfig              |   19 -
 drivers/Kconfig                                    |    2 -
 drivers/Makefile                                   |    1 -
 drivers/atm/.gitignore                             |    5 -
 drivers/atm/Kconfig                                |  300 --
 drivers/atm/Makefile                               |   29 -
 drivers/atm/adummy.c                               |  202 -
 drivers/atm/atmtcp.c                               |  513 --
 drivers/atm/eni.c                                  | 2321 --------
 drivers/atm/eni.h                                  |  136 -
 drivers/atm/fore200e.c                             | 3012 -----------
 drivers/atm/fore200e.h                             |  973 ----
 drivers/atm/he.c                                   | 2861 ----------
 drivers/atm/he.h                                   |  845 ---
 drivers/atm/idt77105.c                             |  376 --
 drivers/atm/idt77105.h                             |   92 -
 drivers/atm/idt77252.c                             | 3797 --------------
 drivers/atm/idt77252.h                             |  816 ---
 drivers/atm/idt77252_tables.h                      |  781 ---
 drivers/atm/iphase.c                               | 3283 ------------
 drivers/atm/iphase.h                               | 1452 -----
 drivers/atm/lanai.c                                | 2603 ---------
 drivers/atm/midway.h                               |  266 -
 drivers/atm/nicstar.c                              | 2759 ----------
 drivers/atm/nicstar.h                              |  759 ---
 drivers/atm/nicstarmac.c                           |  244 -
 drivers/atm/nicstarmac.copyright                   |   61 -
 drivers/atm/suni.c                                 |  391 --
 drivers/atm/suni.h                                 |  242 -
 drivers/atm/tonga.h                                |   21 -
 drivers/atm/zeprom.h                               |   35 -
 drivers/isdn/Kconfig                               |   27 -
 drivers/isdn/Makefile                              |    8 -
 drivers/isdn/capi/Kconfig                          |   32 -
 drivers/isdn/capi/Makefile                         |    6 -
 drivers/isdn/capi/capi.c                           | 1435 -----
 drivers/isdn/capi/capiutil.c                       |  677 ---
 drivers/isdn/capi/kcapi.c                          |  933 ----
 drivers/isdn/capi/kcapi.h                          |  182 -
 drivers/isdn/capi/kcapi_proc.c                     |  231 -
 drivers/isdn/hardware/Makefile                     |    6 -
 drivers/isdn/hardware/mISDN/Kconfig                |   98 -
 drivers/isdn/hardware/mISDN/Makefile               |   19 -
 drivers/isdn/hardware/mISDN/avmfritz.c             | 1164 ----
 drivers/isdn/hardware/mISDN/hfc_multi.h            | 1236 -----
 drivers/isdn/hardware/mISDN/hfc_multi_8xx.h        |  167 -
 drivers/isdn/hardware/mISDN/hfc_pci.h              |  214 -
 drivers/isdn/hardware/mISDN/hfcmulti.c             | 5540 --------------------
 drivers/isdn/hardware/mISDN/hfcpci.c               | 2360 ---------
 drivers/isdn/hardware/mISDN/hfcsusb.c              | 2157 --------
 drivers/isdn/hardware/mISDN/hfcsusb.h              |  425 --
 drivers/isdn/hardware/mISDN/iohelper.h             |   96 -
 drivers/isdn/hardware/mISDN/ipac.h                 |  393 --
 drivers/isdn/hardware/mISDN/isar.h                 |  256 -
 drivers/isdn/hardware/mISDN/isdnhdlc.c             |  617 ---
 drivers/isdn/hardware/mISDN/isdnhdlc.h             |   69 -
 drivers/isdn/hardware/mISDN/mISDNinfineon.c        | 1168 -----
 drivers/isdn/hardware/mISDN/mISDNipac.c            | 1636 ------
 drivers/isdn/hardware/mISDN/mISDNisar.c            | 1694 ------
 drivers/isdn/hardware/mISDN/netjet.c               | 1154 ----
 drivers/isdn/hardware/mISDN/netjet.h               |   44 -
 drivers/isdn/hardware/mISDN/speedfax.c             |  520 --
 drivers/isdn/hardware/mISDN/w6692.c                | 1417 -----
 drivers/isdn/hardware/mISDN/w6692.h                |  177 -
 drivers/isdn/mISDN/Kconfig                         |   48 -
 drivers/isdn/mISDN/Makefile                        |   14 -
 drivers/isdn/mISDN/clock.c                         |  197 -
 drivers/isdn/mISDN/core.c                          |  400 --
 drivers/isdn/mISDN/core.h                          |   69 -
 drivers/isdn/mISDN/dsp.h                           |  277 -
 drivers/isdn/mISDN/dsp_audio.c                     |  421 --
 drivers/isdn/mISDN/dsp_biquad.h                    |   51 -
 drivers/isdn/mISDN/dsp_blowfish.c                  |  667 ---
 drivers/isdn/mISDN/dsp_cmx.c                       | 1949 -------
 drivers/isdn/mISDN/dsp_core.c                      | 1227 -----
 drivers/isdn/mISDN/dsp_dtmf.c                      |  313 --
 drivers/isdn/mISDN/dsp_ecdis.h                     |   96 -
 drivers/isdn/mISDN/dsp_hwec.c                      |  122 -
 drivers/isdn/mISDN/dsp_hwec.h                      |   10 -
 drivers/isdn/mISDN/dsp_pipeline.c                  |  300 --
 drivers/isdn/mISDN/dsp_tones.c                     |  550 --
 drivers/isdn/mISDN/fsm.c                           |  176 -
 drivers/isdn/mISDN/fsm.h                           |   58 -
 drivers/isdn/mISDN/hwchannel.c                     |  516 --
 drivers/isdn/mISDN/l1oip.h                         |   92 -
 drivers/isdn/mISDN/l1oip_codec.c                   |  358 --
 drivers/isdn/mISDN/l1oip_core.c                    | 1505 ------
 drivers/isdn/mISDN/layer1.c                        |  415 --
 drivers/isdn/mISDN/layer1.h                        |   16 -
 drivers/isdn/mISDN/layer2.c                        | 2266 --------
 drivers/isdn/mISDN/layer2.h                        |  131 -
 drivers/isdn/mISDN/socket.c                        |  825 ---
 drivers/isdn/mISDN/stack.c                         |  654 ---
 drivers/isdn/mISDN/tei.c                           | 1416 -----
 drivers/isdn/mISDN/timerdev.c                      |  295 --
 drivers/net/Kconfig                                |    2 -
 drivers/net/Makefile                               |    2 -
 drivers/net/Space.c                                |   15 -
 drivers/net/caif/Kconfig                           |   33 -
 drivers/net/caif/Makefile                          |    8 -
 drivers/net/caif/caif_serial.c                     |  443 --
 drivers/net/caif/caif_virtio.c                     |  791 ---
 drivers/net/ethernet/3com/3c509.c                  | 1448 -----
 drivers/net/ethernet/3com/3c515.c                  | 1566 ------
 drivers/net/ethernet/3com/3c574_cs.c               | 1164 ----
 drivers/net/ethernet/3com/3c589_cs.c               |  974 ----
 drivers/net/ethernet/3com/Kconfig                  |   45 -
 drivers/net/ethernet/3com/Makefile                 |    4 -
 drivers/net/ethernet/8390/Kconfig                  |   41 -
 drivers/net/ethernet/8390/Makefile                 |    3 -
 drivers/net/ethernet/8390/axnet_cs.c               | 1707 ------
 drivers/net/ethernet/8390/smc-ultra.c              |  630 ---
 drivers/net/ethernet/8390/wd.c                     |  575 --
 drivers/net/ethernet/Kconfig                       |    2 -
 drivers/net/ethernet/Makefile                      |    2 -
 drivers/net/ethernet/amd/Kconfig                   |   21 -
 drivers/net/ethernet/amd/Makefile                  |    2 -
 drivers/net/ethernet/amd/lance.c                   | 1317 -----
 drivers/net/ethernet/amd/nmclan_cs.c               | 1508 ------
 drivers/net/ethernet/fujitsu/Kconfig               |   30 -
 drivers/net/ethernet/fujitsu/Makefile              |    6 -
 drivers/net/ethernet/fujitsu/fmvj18x_cs.c          | 1176 -----
 drivers/net/ethernet/packetengines/Kconfig         |   44 -
 drivers/net/ethernet/packetengines/Makefile        |    7 -
 drivers/net/ethernet/packetengines/hamachi.c       | 1967 -------
 drivers/net/ethernet/packetengines/yellowfin.c     | 1438 -----
 drivers/net/ethernet/smsc/Kconfig                  |   27 -
 drivers/net/ethernet/smsc/Makefile                 |    2 -
 drivers/net/ethernet/smsc/smc9194.c                | 1535 ------
 drivers/net/ethernet/smsc/smc91c92_cs.c            | 2059 --------
 drivers/net/hamradio/6pack.c                       |  912 ----
 drivers/net/hamradio/Kconfig                       |  162 -
 drivers/net/hamradio/Makefile                      |   22 -
 drivers/net/hamradio/baycom_epp.c                  | 1316 -----
 drivers/net/hamradio/baycom_par.c                  |  598 ---
 drivers/net/hamradio/baycom_ser_fdx.c              |  678 ---
 drivers/net/hamradio/baycom_ser_hdx.c              |  727 ---
 drivers/net/hamradio/bpqether.c                    |  593 ---
 drivers/net/hamradio/hdlcdrv.c                     |  747 ---
 drivers/net/hamradio/mkiss.c                       |  980 ----
 drivers/net/hamradio/scc.c                         | 2179 --------
 drivers/net/hamradio/yam.c                         | 1191 -----
 drivers/net/hamradio/z8530.h                       |  246 -
 include/linux/hdlcdrv.h                            |  276 -
 include/linux/isdn/capilli.h                       |   95 -
 include/linux/isdn/capiutil.h                      |   60 -
 include/linux/kernelcapi.h                         |   45 -
 include/linux/mISDNdsp.h                           |   40 -
 include/linux/mISDNhw.h                            |  192 -
 include/linux/mISDNif.h                            |  603 ---
 include/linux/netdevice.h                          |    5 +-
 include/linux/scc.h                                |   86 -
 include/linux/virtio_caif.h                        |   24 -
 include/linux/yam.h                                |   67 -
 include/net/Space.h                                |    5 -
 include/net/atmclip.h                              |   53 -
 include/net/ax25.h                                 |  476 +-
 include/net/caif/caif_dev.h                        |  128 -
 include/net/caif/caif_device.h                     |   55 -
 include/net/caif/caif_layer.h                      |  277 -
 include/net/caif/cfcnfg.h                          |   90 -
 include/net/caif/cfctrl.h                          |  130 -
 include/net/caif/cffrml.h                          |   21 -
 include/net/caif/cfmuxl.h                          |   20 -
 include/net/caif/cfpkt.h                           |  232 -
 include/net/caif/cfserl.h                          |   13 -
 include/net/caif/cfsrvl.h                          |   61 -
 include/net/netrom.h                               |  273 -
 include/net/rose.h                                 |  263 +-
 include/uapi/linux/baycom.h                        |   40 -
 include/uapi/linux/caif/caif_socket.h              |  195 -
 include/uapi/linux/caif/if_caif.h                  |   35 -
 include/uapi/linux/capi.h                          |  134 -
 include/uapi/linux/hdlcdrv.h                       |  111 -
 include/uapi/linux/isdn/capicmd.h                  |  117 -
 include/uapi/linux/kernelcapi.h                    |   48 -
 include/uapi/linux/netrom.h                        |   37 -
 include/uapi/linux/rose.h                          |   91 -
 include/uapi/linux/scc.h                           |  174 -
 net/Kconfig                                        |    2 -
 net/Makefile                                       |    4 -
 net/atm/Kconfig                                    |   37 -
 net/atm/Makefile                                   |    4 -
 net/atm/clip.c                                     |  960 ----
 net/atm/ioctl.c                                    |   14 -
 net/atm/lec.c                                      | 2274 --------
 net/atm/lec.h                                      |  155 -
 net/atm/lec_arpc.h                                 |   97 -
 net/atm/mpc.c                                      | 1538 ------
 net/atm/mpc.h                                      |   65 -
 net/atm/mpoa_caches.c                              |  565 --
 net/atm/mpoa_caches.h                              |   99 -
 net/atm/mpoa_proc.c                                |  307 --
 net/atm/proc.c                                     |   11 -
 net/ax25/Kconfig                                   |  108 -
 net/ax25/Makefile                                  |   12 -
 net/ax25/af_ax25.c                                 | 2089 --------
 net/ax25/ax25_addr.c                               |  303 --
 net/ax25/ax25_dev.c                                |  200 -
 net/ax25/ax25_ds_in.c                              |  298 --
 net/ax25/ax25_ds_subr.c                            |  204 -
 net/ax25/ax25_ds_timer.c                           |  235 -
 net/ax25/ax25_iface.c                              |  214 -
 net/ax25/ax25_in.c                                 |  455 --
 net/ax25/ax25_ip.c                                 |  247 -
 net/ax25/ax25_out.c                                |  398 --
 net/ax25/ax25_route.c                              |  416 --
 net/ax25/ax25_std_in.c                             |  443 --
 net/ax25/ax25_std_subr.c                           |   83 -
 net/ax25/ax25_std_timer.c                          |  175 -
 net/ax25/ax25_subr.c                               |  296 --
 net/ax25/ax25_timer.c                              |  224 -
 net/ax25/ax25_uid.c                                |  204 -
 net/ax25/sysctl_net_ax25.c                         |  181 -
 net/bluetooth/Kconfig                              |    3 -
 net/bluetooth/Makefile                             |    1 -
 net/bluetooth/cmtp/Kconfig                         |   12 -
 net/bluetooth/cmtp/Makefile                        |    8 -
 net/bluetooth/cmtp/capi.c                          |  579 --
 net/bluetooth/cmtp/cmtp.h                          |  129 -
 net/bluetooth/cmtp/core.c                          |  519 --
 net/bluetooth/cmtp/sock.c                          |  271 -
 net/bridge/br.c                                    |    7 -
 net/bridge/br_fdb.c                                |   29 -
 net/bridge/br_private.h                            |    4 -
 net/caif/Kconfig                                   |   54 -
 net/caif/Makefile                                  |   16 -
 net/caif/caif_dev.c                                |  586 ---
 net/caif/caif_socket.c                             | 1114 ----
 net/caif/caif_usb.c                                |  216 -
 net/caif/cfcnfg.c                                  |  612 ---
 net/caif/cfctrl.c                                  |  631 ---
 net/caif/cfdbgl.c                                  |   55 -
 net/caif/cfdgml.c                                  |  113 -
 net/caif/cffrml.c                                  |  204 -
 net/caif/cfmuxl.c                                  |  267 -
 net/caif/cfpkt_skbuff.c                            |  373 --
 net/caif/cfrfml.c                                  |  299 --
 net/caif/cfserl.c                                  |  192 -
 net/caif/cfsrvl.c                                  |  224 -
 net/caif/cfutill.c                                 |  104 -
 net/caif/cfveil.c                                  |  101 -
 net/caif/cfvidl.c                                  |   65 -
 net/caif/chnl_net.c                                |  531 --
 net/core/dev.c                                     |    7 -
 net/ipv4/arp.c                                     |    1 -
 net/netrom/Makefile                                |   10 -
 net/netrom/af_netrom.c                             | 1536 ------
 net/netrom/nr_dev.c                                |  178 -
 net/netrom/nr_in.c                                 |  301 --
 net/netrom/nr_loopback.c                           |   73 -
 net/netrom/nr_out.c                                |  272 -
 net/netrom/nr_route.c                              |  989 ----
 net/netrom/nr_subr.c                               |  280 -
 net/netrom/nr_timer.c                              |  249 -
 net/netrom/sysctl_net_netrom.c                     |  156 -
 net/rose/Makefile                                  |   10 -
 net/rose/af_rose.c                                 | 1687 ------
 net/rose/rose_dev.c                                |  141 -
 net/rose/rose_in.c                                 |  301 --
 net/rose/rose_link.c                               |  289 -
 net/rose/rose_loopback.c                           |  133 -
 net/rose/rose_out.c                                |  122 -
 net/rose/rose_route.c                              | 1333 -----
 net/rose/rose_subr.c                               |  556 --
 net/rose/rose_timer.c                              |  227 -
 net/rose/sysctl_net_rose.c                         |  125 -
 311 files changed, 14 insertions(+), 138161 deletions(-)
 delete mode 100644 Documentation/isdn/credits.rst
 delete mode 100644 Documentation/isdn/index.rst
 delete mode 100644 Documentation/isdn/interface_capi.rst
 delete mode 100644 Documentation/isdn/m_isdn.rst
 delete mode 100644 Documentation/networking/6pack.rst
 delete mode 100644 Documentation/networking/ax25.rst
 delete mode 100644 Documentation/networking/caif/caif.rst
 delete mode 100644 Documentation/networking/caif/index.rst
 delete mode 100644 Documentation/networking/caif/linux_caif.rst
 delete mode 100644 Documentation/networking/device_drivers/atm/fore200e.rst
 delete mode 100644 Documentation/networking/device_drivers/atm/iphase.rst
 delete mode 100644 Documentation/networking/device_drivers/ethernet/3com/3c509.rst
 delete mode 100644 Documentation/networking/device_drivers/ethernet/smsc/smc9.rst
 delete mode 100644 Documentation/networking/device_drivers/hamradio/baycom.rst
 delete mode 100644 Documentation/networking/device_drivers/hamradio/index.rst
 delete mode 100644 Documentation/networking/device_drivers/hamradio/z8530drv.rst
 delete mode 100644 drivers/atm/.gitignore
 delete mode 100644 drivers/atm/adummy.c
 delete mode 100644 drivers/atm/atmtcp.c
 delete mode 100644 drivers/atm/eni.c
 delete mode 100644 drivers/atm/eni.h
 delete mode 100644 drivers/atm/fore200e.c
 delete mode 100644 drivers/atm/fore200e.h
 delete mode 100644 drivers/atm/he.c
 delete mode 100644 drivers/atm/he.h
 delete mode 100644 drivers/atm/idt77105.c
 delete mode 100644 drivers/atm/idt77105.h
 delete mode 100644 drivers/atm/idt77252.c
 delete mode 100644 drivers/atm/idt77252.h
 delete mode 100644 drivers/atm/idt77252_tables.h
 delete mode 100644 drivers/atm/iphase.c
 delete mode 100644 drivers/atm/iphase.h
 delete mode 100644 drivers/atm/lanai.c
 delete mode 100644 drivers/atm/midway.h
 delete mode 100644 drivers/atm/nicstar.c
 delete mode 100644 drivers/atm/nicstar.h
 delete mode 100644 drivers/atm/nicstarmac.c
 delete mode 100644 drivers/atm/nicstarmac.copyright
 delete mode 100644 drivers/atm/suni.c
 delete mode 100644 drivers/atm/suni.h
 delete mode 100644 drivers/atm/tonga.h
 delete mode 100644 drivers/atm/zeprom.h
 delete mode 100644 drivers/isdn/Kconfig
 delete mode 100644 drivers/isdn/Makefile
 delete mode 100644 drivers/isdn/capi/Kconfig
 delete mode 100644 drivers/isdn/capi/Makefile
 delete mode 100644 drivers/isdn/capi/capi.c
 delete mode 100644 drivers/isdn/capi/capiutil.c
 delete mode 100644 drivers/isdn/capi/kcapi.c
 delete mode 100644 drivers/isdn/capi/kcapi.h
 delete mode 100644 drivers/isdn/capi/kcapi_proc.c
 delete mode 100644 drivers/isdn/hardware/Makefile
 delete mode 100644 drivers/isdn/hardware/mISDN/Kconfig
 delete mode 100644 drivers/isdn/hardware/mISDN/Makefile
 delete mode 100644 drivers/isdn/hardware/mISDN/avmfritz.c
 delete mode 100644 drivers/isdn/hardware/mISDN/hfc_multi.h
 delete mode 100644 drivers/isdn/hardware/mISDN/hfc_multi_8xx.h
 delete mode 100644 drivers/isdn/hardware/mISDN/hfc_pci.h
 delete mode 100644 drivers/isdn/hardware/mISDN/hfcmulti.c
 delete mode 100644 drivers/isdn/hardware/mISDN/hfcpci.c
 delete mode 100644 drivers/isdn/hardware/mISDN/hfcsusb.c
 delete mode 100644 drivers/isdn/hardware/mISDN/hfcsusb.h
 delete mode 100644 drivers/isdn/hardware/mISDN/iohelper.h
 delete mode 100644 drivers/isdn/hardware/mISDN/ipac.h
 delete mode 100644 drivers/isdn/hardware/mISDN/isar.h
 delete mode 100644 drivers/isdn/hardware/mISDN/isdnhdlc.c
 delete mode 100644 drivers/isdn/hardware/mISDN/isdnhdlc.h
 delete mode 100644 drivers/isdn/hardware/mISDN/mISDNinfineon.c
 delete mode 100644 drivers/isdn/hardware/mISDN/mISDNipac.c
 delete mode 100644 drivers/isdn/hardware/mISDN/mISDNisar.c
 delete mode 100644 drivers/isdn/hardware/mISDN/netjet.c
 delete mode 100644 drivers/isdn/hardware/mISDN/netjet.h
 delete mode 100644 drivers/isdn/hardware/mISDN/speedfax.c
 delete mode 100644 drivers/isdn/hardware/mISDN/w6692.c
 delete mode 100644 drivers/isdn/hardware/mISDN/w6692.h
 delete mode 100644 drivers/isdn/mISDN/Kconfig
 delete mode 100644 drivers/isdn/mISDN/Makefile
 delete mode 100644 drivers/isdn/mISDN/clock.c
 delete mode 100644 drivers/isdn/mISDN/core.c
 delete mode 100644 drivers/isdn/mISDN/core.h
 delete mode 100644 drivers/isdn/mISDN/dsp.h
 delete mode 100644 drivers/isdn/mISDN/dsp_audio.c
 delete mode 100644 drivers/isdn/mISDN/dsp_biquad.h
 delete mode 100644 drivers/isdn/mISDN/dsp_blowfish.c
 delete mode 100644 drivers/isdn/mISDN/dsp_cmx.c
 delete mode 100644 drivers/isdn/mISDN/dsp_core.c
 delete mode 100644 drivers/isdn/mISDN/dsp_dtmf.c
 delete mode 100644 drivers/isdn/mISDN/dsp_ecdis.h
 delete mode 100644 drivers/isdn/mISDN/dsp_hwec.c
 delete mode 100644 drivers/isdn/mISDN/dsp_hwec.h
 delete mode 100644 drivers/isdn/mISDN/dsp_pipeline.c
 delete mode 100644 drivers/isdn/mISDN/dsp_tones.c
 delete mode 100644 drivers/isdn/mISDN/fsm.c
 delete mode 100644 drivers/isdn/mISDN/fsm.h
 delete mode 100644 drivers/isdn/mISDN/hwchannel.c
 delete mode 100644 drivers/isdn/mISDN/l1oip.h
 delete mode 100644 drivers/isdn/mISDN/l1oip_codec.c
 delete mode 100644 drivers/isdn/mISDN/l1oip_core.c
 delete mode 100644 drivers/isdn/mISDN/layer1.c
 delete mode 100644 drivers/isdn/mISDN/layer1.h
 delete mode 100644 drivers/isdn/mISDN/layer2.c
 delete mode 100644 drivers/isdn/mISDN/layer2.h
 delete mode 100644 drivers/isdn/mISDN/socket.c
 delete mode 100644 drivers/isdn/mISDN/stack.c
 delete mode 100644 drivers/isdn/mISDN/tei.c
 delete mode 100644 drivers/isdn/mISDN/timerdev.c
 delete mode 100644 drivers/net/caif/Kconfig
 delete mode 100644 drivers/net/caif/Makefile
 delete mode 100644 drivers/net/caif/caif_serial.c
 delete mode 100644 drivers/net/caif/caif_virtio.c
 delete mode 100644 drivers/net/ethernet/3com/3c509.c
 delete mode 100644 drivers/net/ethernet/3com/3c515.c
 delete mode 100644 drivers/net/ethernet/3com/3c574_cs.c
 delete mode 100644 drivers/net/ethernet/3com/3c589_cs.c
 delete mode 100644 drivers/net/ethernet/8390/axnet_cs.c
 delete mode 100644 drivers/net/ethernet/8390/smc-ultra.c
 delete mode 100644 drivers/net/ethernet/8390/wd.c
 delete mode 100644 drivers/net/ethernet/amd/lance.c
 delete mode 100644 drivers/net/ethernet/amd/nmclan_cs.c
 delete mode 100644 drivers/net/ethernet/fujitsu/Kconfig
 delete mode 100644 drivers/net/ethernet/fujitsu/Makefile
 delete mode 100644 drivers/net/ethernet/fujitsu/fmvj18x_cs.c
 delete mode 100644 drivers/net/ethernet/packetengines/Kconfig
 delete mode 100644 drivers/net/ethernet/packetengines/Makefile
 delete mode 100644 drivers/net/ethernet/packetengines/hamachi.c
 delete mode 100644 drivers/net/ethernet/packetengines/yellowfin.c
 delete mode 100644 drivers/net/ethernet/smsc/smc9194.c
 delete mode 100644 drivers/net/ethernet/smsc/smc91c92_cs.c
 delete mode 100644 drivers/net/hamradio/6pack.c
 delete mode 100644 drivers/net/hamradio/Kconfig
 delete mode 100644 drivers/net/hamradio/Makefile
 delete mode 100644 drivers/net/hamradio/baycom_epp.c
 delete mode 100644 drivers/net/hamradio/baycom_par.c
 delete mode 100644 drivers/net/hamradio/baycom_ser_fdx.c
 delete mode 100644 drivers/net/hamradio/baycom_ser_hdx.c
 delete mode 100644 drivers/net/hamradio/bpqether.c
 delete mode 100644 drivers/net/hamradio/hdlcdrv.c
 delete mode 100644 drivers/net/hamradio/mkiss.c
 delete mode 100644 drivers/net/hamradio/scc.c
 delete mode 100644 drivers/net/hamradio/yam.c
 delete mode 100644 drivers/net/hamradio/z8530.h
 delete mode 100644 include/linux/hdlcdrv.h
 delete mode 100644 include/linux/isdn/capilli.h
 delete mode 100644 include/linux/isdn/capiutil.h
 delete mode 100644 include/linux/kernelcapi.h
 delete mode 100644 include/linux/mISDNdsp.h
 delete mode 100644 include/linux/mISDNhw.h
 delete mode 100644 include/linux/mISDNif.h
 delete mode 100644 include/linux/scc.h
 delete mode 100644 include/linux/virtio_caif.h
 delete mode 100644 include/linux/yam.h
 delete mode 100644 include/net/atmclip.h
 delete mode 100644 include/net/caif/caif_dev.h
 delete mode 100644 include/net/caif/caif_device.h
 delete mode 100644 include/net/caif/caif_layer.h
 delete mode 100644 include/net/caif/cfcnfg.h
 delete mode 100644 include/net/caif/cfctrl.h
 delete mode 100644 include/net/caif/cffrml.h
 delete mode 100644 include/net/caif/cfmuxl.h
 delete mode 100644 include/net/caif/cfpkt.h
 delete mode 100644 include/net/caif/cfserl.h
 delete mode 100644 include/net/caif/cfsrvl.h
 delete mode 100644 include/net/netrom.h
 delete mode 100644 include/uapi/linux/baycom.h
 delete mode 100644 include/uapi/linux/caif/caif_socket.h
 delete mode 100644 include/uapi/linux/caif/if_caif.h
 delete mode 100644 include/uapi/linux/capi.h
 delete mode 100644 include/uapi/linux/hdlcdrv.h
 delete mode 100644 include/uapi/linux/isdn/capicmd.h
 delete mode 100644 include/uapi/linux/kernelcapi.h
 delete mode 100644 include/uapi/linux/netrom.h
 delete mode 100644 include/uapi/linux/rose.h
 delete mode 100644 include/uapi/linux/scc.h
 delete mode 100644 net/atm/clip.c
 delete mode 100644 net/atm/lec.c
 delete mode 100644 net/atm/lec.h
 delete mode 100644 net/atm/lec_arpc.h
 delete mode 100644 net/atm/mpc.c
 delete mode 100644 net/atm/mpc.h
 delete mode 100644 net/atm/mpoa_caches.c
 delete mode 100644 net/atm/mpoa_caches.h
 delete mode 100644 net/atm/mpoa_proc.c
 delete mode 100644 net/ax25/Kconfig
 delete mode 100644 net/ax25/Makefile
 delete mode 100644 net/ax25/af_ax25.c
 delete mode 100644 net/ax25/ax25_addr.c
 delete mode 100644 net/ax25/ax25_dev.c
 delete mode 100644 net/ax25/ax25_ds_in.c
 delete mode 100644 net/ax25/ax25_ds_subr.c
 delete mode 100644 net/ax25/ax25_ds_timer.c
 delete mode 100644 net/ax25/ax25_iface.c
 delete mode 100644 net/ax25/ax25_in.c
 delete mode 100644 net/ax25/ax25_ip.c
 delete mode 100644 net/ax25/ax25_out.c
 delete mode 100644 net/ax25/ax25_route.c
 delete mode 100644 net/ax25/ax25_std_in.c
 delete mode 100644 net/ax25/ax25_std_subr.c
 delete mode 100644 net/ax25/ax25_std_timer.c
 delete mode 100644 net/ax25/ax25_subr.c
 delete mode 100644 net/ax25/ax25_timer.c
 delete mode 100644 net/ax25/ax25_uid.c
 delete mode 100644 net/ax25/sysctl_net_ax25.c
 delete mode 100644 net/bluetooth/cmtp/Kconfig
 delete mode 100644 net/bluetooth/cmtp/Makefile
 delete mode 100644 net/bluetooth/cmtp/capi.c
 delete mode 100644 net/bluetooth/cmtp/cmtp.h
 delete mode 100644 net/bluetooth/cmtp/core.c
 delete mode 100644 net/bluetooth/cmtp/sock.c
 delete mode 100644 net/caif/Kconfig
 delete mode 100644 net/caif/Makefile
 delete mode 100644 net/caif/caif_dev.c
 delete mode 100644 net/caif/caif_socket.c
 delete mode 100644 net/caif/caif_usb.c
 delete mode 100644 net/caif/cfcnfg.c
 delete mode 100644 net/caif/cfctrl.c
 delete mode 100644 net/caif/cfdbgl.c
 delete mode 100644 net/caif/cfdgml.c
 delete mode 100644 net/caif/cffrml.c
 delete mode 100644 net/caif/cfmuxl.c
 delete mode 100644 net/caif/cfpkt_skbuff.c
 delete mode 100644 net/caif/cfrfml.c
 delete mode 100644 net/caif/cfserl.c
 delete mode 100644 net/caif/cfsrvl.c
 delete mode 100644 net/caif/cfutill.c
 delete mode 100644 net/caif/cfveil.c
 delete mode 100644 net/caif/cfvidl.c
 delete mode 100644 net/caif/chnl_net.c
 delete mode 100644 net/netrom/Makefile
 delete mode 100644 net/netrom/af_netrom.c
 delete mode 100644 net/netrom/nr_dev.c
 delete mode 100644 net/netrom/nr_in.c
 delete mode 100644 net/netrom/nr_loopback.c
 delete mode 100644 net/netrom/nr_out.c
 delete mode 100644 net/netrom/nr_route.c
 delete mode 100644 net/netrom/nr_subr.c
 delete mode 100644 net/netrom/nr_timer.c
 delete mode 100644 net/netrom/sysctl_net_netrom.c
 delete mode 100644 net/rose/Makefile
 delete mode 100644 net/rose/af_rose.c
 delete mode 100644 net/rose/rose_dev.c
 delete mode 100644 net/rose/rose_in.c
 delete mode 100644 net/rose/rose_link.c
 delete mode 100644 net/rose/rose_loopback.c
 delete mode 100644 net/rose/rose_out.c
 delete mode 100644 net/rose/rose_route.c
 delete mode 100644 net/rose/rose_subr.c
 delete mode 100644 net/rose/rose_timer.c
 delete mode 100644 net/rose/sysctl_net_rose.c

