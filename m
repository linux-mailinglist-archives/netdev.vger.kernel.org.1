Return-Path: <netdev+bounces-43006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291E97D0FD1
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 14:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E0228255F
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C0712E7B;
	Fri, 20 Oct 2023 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAFH2oBm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF3B10A25;
	Fri, 20 Oct 2023 12:45:31 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99559D41;
	Fri, 20 Oct 2023 05:45:30 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-777719639adso42389485a.3;
        Fri, 20 Oct 2023 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697805930; x=1698410730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D1iwvLTq2T841qY10LF8GOUyS20mcZ4CoMQTfhMBIOU=;
        b=SAFH2oBmou1eVPCymNGM/FljWHknAPbBlF6oRnWDkG9lpwGIyBi7IprxlGp05v3Ekl
         zRvza4H1l4QtD4xHOE+o2sz42mlXjnTRGLB7i3hWT3x0YBxYbA1VjDcrrrArpcB14OWS
         ltmgOe3gPVjK9JWfvZ+uGBktD3pCtecpjWTJZv2xKyW9Ftz3tycUIseM1fwPGWy5ekwM
         W0cDRZWwmioPBCwD5sZ6bSItgSgUuaA22JxBDEZ1zeW+13jyFSlXG62PUrccm3MfD5F2
         HiwZyN4lnSQtygFapC7gzd7ayOdLLqwn/GV0fvXZiVwbb4uWQCyJvXI9UtZ61d1ALETL
         gQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697805930; x=1698410730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1iwvLTq2T841qY10LF8GOUyS20mcZ4CoMQTfhMBIOU=;
        b=fJyGoLuUDHzdGWw9xmR5Czqw1v3UPgHZdYxphYG7DC+sOB9a6OErHWHnVyEILR4XcF
         aM5Ugqt+lA1uOoBdVaL5c9cb+xOukX5KdpdKrEjPpqhunpm6fB+uC5ipRD+d5h7PPUTA
         z6uZKbYGP+gfqFBIelxCrXXFhVlrWSHsl7+6NQZuPUnyck5vbcvB0fMJFnYRVL+fROkT
         vc8M0tpkaZ1+WBjccNtJmfTodMvumQ/Vo6w20M8dh7ux8sZBscnJ05OrD4UJSMNxmw6Z
         6QgafAwbZx1VCK02hKYu92WhFooylwjnzhACrCaDtSSO7vYOwBRg7ld2m1qtp/O/uiBL
         mUfg==
X-Gm-Message-State: AOJu0YzKoJofwlnN2+YIs3Atv6SELpdZTex+y+JdYjwZ+P2Y7oEvU9wp
	LBwgm7mfCpNUeVRlmDNM9fU=
X-Google-Smtp-Source: AGHT+IEJkzCDPpptDXF5Wq66CNuBmxbL9vD1ANrVpxErbMdo6XBa9bwUqjstTvGGeqJ7Hbco+Mgvlg==
X-Received: by 2002:a05:620a:1097:b0:774:1795:4a89 with SMTP id g23-20020a05620a109700b0077417954a89mr1471961qkk.71.1697805929638;
        Fri, 20 Oct 2023 05:45:29 -0700 (PDT)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id c3-20020a05620a0ce300b00770f3e5618esm573928qkj.101.2023.10.20.05.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 05:45:29 -0700 (PDT)
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Ian Kent <raven@themaw.net>,
	Sven Joachim <svenjoac@gmx.de>,
	Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>,
	Sumitra Sharma <sumitraartsy@gmail.com>,
	Ricardo Lopes <ricardoapl.dev@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Manish Chopra <manishc@marvell.com>,
	Coiby Xu <coiby.xu@gmail.com>
Subject: [PATCH 0/2] staging: qlge: Remove qlge
Date: Fri, 20 Oct 2023 08:44:55 -0400
Message-ID: <20231020124457.312449-1-benjamin.poirier@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the qlge driver from staging. The TODO file is first updated to
reflect the current status, in case the removal is later reverted.

Benjamin Poirier (2):
  staging: qlge: Update TODO
  staging: qlge: Retire the driver

 .../networking/device_drivers/index.rst       |    1 -
 .../device_drivers/qlogic/index.rst           |   18 -
 .../networking/device_drivers/qlogic/qlge.rst |  118 -
 MAINTAINERS                                   |    9 -
 arch/parisc/configs/generic-64bit_defconfig   |    1 -
 drivers/staging/Kconfig                       |    2 -
 drivers/staging/Makefile                      |    1 -
 drivers/staging/qlge/Kconfig                  |   11 -
 drivers/staging/qlge/Makefile                 |    8 -
 drivers/staging/qlge/TODO                     |   33 -
 drivers/staging/qlge/qlge.h                   | 2293 --------
 drivers/staging/qlge/qlge_dbg.c               | 1311 -----
 drivers/staging/qlge/qlge_devlink.c           |  167 -
 drivers/staging/qlge/qlge_devlink.h           |    9 -
 drivers/staging/qlge/qlge_ethtool.c           |  746 ---
 drivers/staging/qlge/qlge_main.c              | 4845 -----------------
 drivers/staging/qlge/qlge_mpi.c               | 1273 -----
 17 files changed, 10846 deletions(-)
 delete mode 100644 Documentation/networking/device_drivers/qlogic/index.rst
 delete mode 100644 Documentation/networking/device_drivers/qlogic/qlge.rst
 delete mode 100644 drivers/staging/qlge/Kconfig
 delete mode 100644 drivers/staging/qlge/Makefile
 delete mode 100644 drivers/staging/qlge/TODO
 delete mode 100644 drivers/staging/qlge/qlge.h
 delete mode 100644 drivers/staging/qlge/qlge_dbg.c
 delete mode 100644 drivers/staging/qlge/qlge_devlink.c
 delete mode 100644 drivers/staging/qlge/qlge_devlink.h
 delete mode 100644 drivers/staging/qlge/qlge_ethtool.c
 delete mode 100644 drivers/staging/qlge/qlge_main.c
 delete mode 100644 drivers/staging/qlge/qlge_mpi.c

-- 
2.42.0


