Return-Path: <netdev+bounces-62178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F6D82611F
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 19:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDA82829DC
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 18:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B94882F;
	Sat,  6 Jan 2024 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7nHDsFz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21897E549
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 18:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d51ba18e1bso1293185ad.0
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 10:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704566826; x=1705171626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVy7dVOt2MZzo693tvxRWZ2nbQZrKJSDO+jmgHD9SY0=;
        b=Y7nHDsFzz/HTr7E/OJ4Vz2HoFX3kY2TtX4m5hetfj6KDXcY7HLWWoJLNvO05PdBJMG
         SiM1aO/3tJ6Zt2dHdg2/jhUrJLJm/Ee70GJ9cGZiJLUL1WziQelAPHu+jqMVng0lxWH6
         eOm27b/x+laS3J++HelQbkSFpdPSy0TBmLBX/OmSanRuDgXNyU7c3TkUOlWKqjQQ8YQR
         YXNu3lUPSAPAF0Yy1bW1318qfh7fLabGAza3CDjQpi6BSbeuoWgaQ1CT+jAXuf4al0yW
         +bTPxMMnPtUN4M9ZybqMUEQY3MNxdo5r1tJttCxzYn4MdsbA352hVrVqzKyF4vWhg5Bt
         fqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704566826; x=1705171626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVy7dVOt2MZzo693tvxRWZ2nbQZrKJSDO+jmgHD9SY0=;
        b=bZvaYGEBVEpqVtgTiY8hUJ9hHF97BUrLUscHGcHm76PADkWoQXYuQG+yqArJUixZvw
         mPx706KTPs7bek/5dKbCtSulBAmYhcy13eWLG2Z3+WPmzBrFNTrAvOE0QgomFaVnAdtl
         huH/KQKSrPU5soPxI3FbTuPdtijY1oHTr04n9G1OuxkQ1iYzoO5rvSNo/JtTxyxCGue4
         kHTPF1IIxH+3P9hx7ko+NPo4WrD9U0q5UeA+1qGxTE6x1QtO3YfjpAbliMauUYUryFnE
         ZQiOs6DA8o9bvg7Rygwcg6BO5p+gAYuWayVZcHsftB8yhtRTjIQR08+3OxPFeqk4ejlv
         r/lw==
X-Gm-Message-State: AOJu0YyYGKeKJRtK9RuYZK+LYSxDwmBk2wpvWm4ZnKHa1mGH6fD6dd8y
	/v5cQqLlVg7eCsN2kWBJTOSf3EfBreSATA==
X-Google-Smtp-Source: AGHT+IF+sDH2v987ovwl4ZVQAW6HiUw2OB+aS+8UyUX34VvQRuXNUcIyE/wYBM/3VVpqFUOV+sdspQ==
X-Received: by 2002:a17:902:e742:b0:1d4:5939:51fd with SMTP id p2-20020a170902e74200b001d4593951fdmr1737347plf.97.1704566825861;
        Sat, 06 Jan 2024 10:47:05 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id u23-20020a17090ae01700b0028bdc7e5a15sm3363915pjy.53.2024.01.06.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 10:47:05 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com,
	ansuelsmth@gmail.com
Subject: [RFC net-next 0/2] net: dsa: realtek: fix LED support for rtl8366rb
Date: Sat,  6 Jan 2024 15:40:45 -0300
Message-ID: <20240106184651.3665-1-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rtl8366rb switch family has 4 LED groups, with one LED from each
group for each of its 6 ports. LEDs in this family can be controlled
manually using a bitmap or triggered by hardware. It's important to note
that hardware triggers are configured at the LED group level, meaning
all LEDs in the same group share the same hardware triggers settings.

The first part of this series involves dropping most of the existing
code, as, except for disabling the LEDs, it was not working as expected.
If not disabled, the LEDs will retain their default settings after a
switch reset, which may be sufficient for many devices.

The second part introduces the LED driver to control the switch LEDs
from sysfs or device-tree. This driver still allows the LEDs to retain
their default settings, but it will shift to the software-based OS LED
triggers if any configuration is changed. Subsequently, the LEDs will
operate as normal LEDs until the switch undergoes another reset.

Netdev LED trigger supports offloading to hardware triggers.
Unfortunately, this isn't possible with the current LED API for this
switch family. When the hardware trigger is enabled, it applies to all
LEDs in the LED group while the LED API decides to offload based on only
the state of a single LED. To avoid inconsistency between LEDs,
offloading would need to check if all LEDs in the group share the same
compatible settings and atomically enable offload for all LEDs.

This patch series has a minor conflict with the other realtek
refacatoring series at the priv->ds access.

-       dsa_switch_for_each_port(dp, priv->ds) {
+       dsa_switch_for_each_port(dp, &priv->ds) {



