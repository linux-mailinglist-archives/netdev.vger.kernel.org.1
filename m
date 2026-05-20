Return-Path: <netdev+bounces-290091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEXEJqwTDmoW6AUAu9opvQ
	(envelope-from <netdev+bounces-290091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:03:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 697AD59911D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F197830028AD
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A3933F8D6;
	Wed, 20 May 2026 20:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPhXyUod"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A0C32938D
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307422; cv=none; b=av8Bqvc02AjHWpd2mXfRMYX6pfAiKow/1YCOfrx+CI2ldP0kRCGRw2vo3ERe/SGDmY7V4kPWXf9vXFd3SN1YCaRyUtth948a8JnM88vrcvI2FFx8uf0tffEco7UD4pzR01C/zBawGsps80Nf6MrSsAsXlLFZtpJhXXqso0RkeFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307422; c=relaxed/simple;
	bh=6O8DlJDohK61CG4hgxCAucH9uMKDAayqCMEEGwk25e0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QqBk74zi1/lnLs/EHXq5na3HqzCylzxkPQapmrEZ2Pq7HAoUF58vvao/st3QNrYTlBiQD/u71ENGuTXOCJ7Otk/ZDD8aAxMZoTWviAzyolyOvvkYlmNShcSwyKCvOT4fL5Ko/BioNTRHwbRd91lhHW0Tizb0lDeIZj5UAnGxmWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPhXyUod; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e5c5033f6so46583121cf.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 13:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779307420; x=1779912220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4ZnLFzKGvqiWbV7fIaQgDcCGiR/vdFl2/HUEnXBhag=;
        b=sPhXyUod8BXTN9IE1oQlJZxI0JdcLcJee9t7Hagsd2xNeGHKNm9CFhglRVLFvyhdxm
         +Bcp3+BHqs+6AIn3hIUy/xIwpCLAZmJhYM2BnAlHhBrXudT/BQZtZ+zlaqdNgbVPqqRH
         M4IbhBshd1xLo27G49YA/3t6Ux57SfgR/oqYSVfH1pYuoapvcRxZKkaVNm2W/Nvlx6eX
         qQ+Tk6WLCNUXezZR+4A7P2OObTOstunL5SlZmlWY6aGIGPFffIOvrcYayxJJyhfDQuAF
         UvrTlhomxNqMhCKrfAm05LhZiRL7xeoajMGxKt4DpVG2sgerarv7yHp3XqtR4L3iDjLh
         cDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779307420; x=1779912220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4ZnLFzKGvqiWbV7fIaQgDcCGiR/vdFl2/HUEnXBhag=;
        b=ayqkoh11Szinbjfc+UIPG8MCAjzbWG9ZYP6I7XjffF1zq+LZvek6O2FxOxanY/laJS
         KxAe+Vl0xjgvglTkdbvPfGJr0V2IbgoTQxVRp+KI9ntnXUO1nUCzMJTu/Ro3kPifcPH+
         nPN3HHobGoo7MwSvXcx3f2BMN4XIaOw2d/0XbEjKXkk1wtlfQt7l9BLXo5M1AHBoqY5E
         aTajNUfDgTcCLu4eEY0ZgoJjEK1smZ5tvdcPWHo9qY2qvP4kQejJJKISlTWXZLoA/s+J
         U6Fmk13H6OAYWyn0CmyNQqzE1v6XEKLPDPNSm0Q53a+p8/JjbupsqiwYcxPRhqi2WwXx
         RTVQ==
X-Forwarded-Encrypted: i=1; AFNElJ+JrXZyEkQTC6TX7EKjybR1/sFZPBkPKfsGhgjCQCSpDMzdGLbP9I34q1lDjLuc4ODCYVwTs8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtMKP1gSbbEQJ23qzMFtoawTg5eM/Sug6hvPP0WFZ6A28OKRC+
	FKIXdA6DdM9AcWtaQdldQnQXiv0gEVFodXayPuyMm2lly2V5RTvu8fmZ
X-Gm-Gg: Acq92OGL1NSVFopKPtj9y3aO2bGHGFGMqKrITf9kGPbJFBvAcuntxl5klESaqdyoG+W
	JCTRD4oFomXLgfqIWYPGuZZuj6fHN1EP//J8cgr1zqfmuEOza0wni0t5QIJWwoDSZ3FTHtC0AMb
	gFe4+rMJe5LFb2sRRfAFY51k57NZYBl1d7pUxsDGUjeknGcnkzDt4uP22wpeHvn8ZPuc8pyT5Nc
	DFThYdkmM/JzW2W90J/qEYp5KR24sP/9PS63Xz46FFKYFglx3gaZ61mxfTWey9hALXDF2rhIRcx
	sOwLRlMxsswSc21szVjbiUN19qI/Y9fTe7nAXV6dwhfXI/EzXwFrqWCfaMNJCP7+SrB2/1tJgap
	z4sdevuMacI0u7Qp/nyExIJ8SdKVnpge2ciKaB29Fl+Wto3BVuPaCpRq3NoKg29+OHpqeYWIsrg
	/1/pwTWHFo/pN2XibV0kVyR0OYcfH/19wb3ovlxuEy6m2ZZzFhBCZvxrDoW2Kuw1ih7ac=
X-Received: by 2002:ac8:584d:0:b0:50d:91e3:b668 with SMTP id d75a77b69052e-5165a051e3cmr328369651cf.20.1779307419743;
        Wed, 20 May 2026 13:03:39 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516514e0b91sm188849301cf.15.2026.05.20.13.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:03:39 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lee Trager <lee@trager.us>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Chengfeng Ye <dg573847474@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/3] dd LED support for fbnic
Date: Wed, 20 May 2026 16:03:34 -0400
Message-ID: <20260520200337.204431-1-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,fb.com,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,makrotopia.org,gmail.com,intel.com,trager.us,oracle.com,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-290091-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 697AD59911D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

Add support for fbnic leds in three patches.

The first patch adds the trigger support for the higher
fbnic speeds.

The second patch stors the max speed from the firmware dialog
to give the LED code a way to determine if the led needs to show
amber (not full speed) or blue (at full speed).

The third patch adds the fbnic specific code to manipulate the LEDS
as well as the /sys/class/leds support for user space access.

Mike Marciniszyn (Meta) (3):
  leds: trigger: netdev: Extend speeds up to 100G
  net: eth: fbnic: Store max_speed from firmware dialog
  net: eth: fbnic: Add led support

 drivers/leds/trigger/ledtrig-netdev.c         |  46 +++-
 drivers/net/ethernet/meta/Kconfig             |   8 +
 drivers/net/ethernet/meta/fbnic/Makefile      |   2 +
 drivers/net/ethernet/meta/fbnic/fbnic.h       |  13 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  15 ++
 .../net/ethernet/meta/fbnic/fbnic_devlink.c   |   4 +
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  59 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |   3 +
 drivers/net/ethernet/meta/fbnic/fbnic_led.c   | 228 +++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 239 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  62 +++++
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   8 +
 .../net/ethernet/meta/fbnic/fbnic_phylink.c   |   2 +
 include/linux/leds.h                          |   4 +
 15 files changed, 695 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_led.c

-- 
2.43.0


