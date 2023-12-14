Return-Path: <netdev+bounces-57646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD60813B5C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 21:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 274152812BF
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 20:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7DC6A328;
	Thu, 14 Dec 2023 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="IEZ1FYjf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31086A03E
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 20:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50e0d1f9fe6so3562426e87.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 12:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1702584900; x=1703189700; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rKv6UWpxS9t4qwcfHANH1OST6fgGU487WAUtdgpbQMc=;
        b=IEZ1FYjfpu9FwPmTcSXSLny+DA6+omDgtb6PGS3r9cMnWq8ExTSiIgIDmVCi0CzMKc
         Es2onSLt9X+k6qjLnyKCSGraNI+rgSzfFAEW+44/RTjvoP/L30wycZTegiaXeUpA4tHv
         XMG0Ym6Y8CMxT71L3n0Mj+dja3ZCcLX7zAVFk7ikW976EGNmpVAMsiO6pz9FBgRjD2Ua
         wTnNjpBa7YLN99u84Rdz0Gkhr5GYtIfrgmn4nuZ2kgpEj6CUihtN3ouDTPZgnpoSvv/x
         bKmkv1c9qxnF1X/hvhNzTl+iEvdgwZpX7ruGezsZjNWGJzNTKHVrl/CgswfZgdmGdc0p
         XVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702584900; x=1703189700;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKv6UWpxS9t4qwcfHANH1OST6fgGU487WAUtdgpbQMc=;
        b=fjIYh57tW99e2kQaS4mlfMH+ssUPaVQrB0ZpFMOuUQHDzay4H1yp4f80DkllHqpirQ
         FC0d6KlG5DsRGM5pghfZPOPkYQ7OOtZbtfSlFGlcJfAByOLmRtehTaiDajgDlbPgWBVj
         hy0ZX6Ze+wACmL6L2kHoL+qgokxYYuGZ3vQU2SWlnPMBb/wgewSKEMauqF2d8MkyR197
         lml+OXw8Y7CGm0vMqRPmN6hKDiidzw1+yumtuRSyA98NrSmTtq1h0k8L9zdX0jQIOFDT
         dT1KpMwwhXSviFFN7X6dTyliUeOZbctr6mKoKF53Pd3pW/ApdSJbR2EEpzNZxoAFILU5
         DZ3w==
X-Gm-Message-State: AOJu0YyG+AMk9O9jiBb3iN/XOYqn9zlro4xWjs3qAlIdrMx4wmphH/Jx
	Bcd78TYnEMCdWSeihU7hOwOz4cFqjli2ZrNfR9o=
X-Google-Smtp-Source: AGHT+IG0Cl2kf5LGFVHt8mJHSLQtwSmGMPRUsrmcGGlJL0l250mopSvDWkloT958QBlKW2Lnqc5kNQ==
X-Received: by 2002:a05:6512:716:b0:50c:21c2:a278 with SMTP id b22-20020a056512071600b0050c21c2a278mr3908176lfs.17.1702584900409;
        Thu, 14 Dec 2023 12:15:00 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id dw11-20020a0565122c8b00b0050e140f84besm369519lfb.164.2023.12.14.12.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:14:59 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux@armlinux.org.uk,
	kabel@kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 0/4] net: phy: marvell10g: Firmware loading and LED support for 88X3310
Date: Thu, 14 Dec 2023 21:14:38 +0100
Message-Id: <20231214201442.660447-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

There are two boot options for a 88X3310 PHY:

1. Device loads its firmware from a dedicated serial FLASH
2. Device waits for its firmware to be downloaded over XMDIO

1/4 adds support for the second option. The device reports which mode
it is in via a register, so we only attempt to load a firmware in this
situation. Crucially, if firmware is not available in this case, the
device is not usable _at all_, so we are forced to fail the probe
entirely.

2/4 extends the power up sequence to cover cases where the device has
been hardware strapped to start powered down, in which case all
internal units will be powered down.

3/4 adds support for the LED controller in the PHY. A special DT
attribute is added to control the polarity and drive behavior of each
LED, which we document in 4/4.

Tobias Waldekranz (4):
  net: phy: marvell10g: Support firmware loading on 88X3310
  net: phy: marvell10g: Fix power-up when strapped to start powered down
  net: phy: marvell10g: Add LED support for 88X3310
  dt-bindings: net: marvell10g: Document LED polarity

 .../bindings/net/marvell,marvell10g.yaml      |  60 ++
 MAINTAINERS                                   |   1 +
 drivers/net/phy/marvell10g.c                  | 602 +++++++++++++++++-
 3 files changed, 660 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/marvell,marvell10g.yaml

-- 
2.34.1


