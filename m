Return-Path: <netdev+bounces-85242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3ED899E35
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 15:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4292836E3
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605C716D4E0;
	Fri,  5 Apr 2024 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aieFgJ4A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F116078C;
	Fri,  5 Apr 2024 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323423; cv=none; b=fSkdEAikCVo5jlBwfAhnbpL2x5Gs9dV20RqJRC4IXmkWgFgoe9G+p2CCNoTTNCxTzXLq0x+nc1djpKM3WhQibq2EI83K78AIaGUzTpixnJrnLSW7BvUVZdEDWX9y8ba4EYGNSuKG1oNZr3OSSsVnhYUQZ5O01WmQr7J5vM1yxoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323423; c=relaxed/simple;
	bh=TsyTbKLsCoanqUlDnD9/XzJ/RF7X9X8PhkChbcH//pU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WNOonMLqeP/Rk5s5nd7IrOwdSViFS9byXFplqOXxQqrT+TSR75gss6tS4iGvY1u/1l1S7i3Vw6ZPNm012XAb/A2JnRjOKLiZmxA1+gwfevbc7rzKIz4dRxkMCmhpwIndf9mQq+3aYPdfWVGh0Lu0dUmy/ypF+UAC7hw9iWh62FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aieFgJ4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE41C433C7;
	Fri,  5 Apr 2024 13:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712323422;
	bh=TsyTbKLsCoanqUlDnD9/XzJ/RF7X9X8PhkChbcH//pU=;
	h=From:To:Cc:Subject:Date:From;
	b=aieFgJ4ADP8kJvJ/64bJ+gAd3zXlZyAh/vEo+wiF/DyN91mKlnh+vzW6A76IujFsX
	 a5plKs1pLRB0YgGTWdRhcmbMUjuoJ6fcBTOK2ACOA4nPm8lE4a7CncVus3picOvJbP
	 CcIV4I82lsIPu+ucNLBwKheM/YoZgXaJAiGtliiaJSpx/jJlhZoG/ARcmZWrBA81S7
	 LcJ+wl4snnoHXEjKcIYoZpM4ThKNBx/1e6ifdAM59J6Xyf8iy31sz5UyRtAAEMeWip
	 YOg+2voLyd1aAqxgnFVmZwhPb/LIU6UGhiRAuzJOwu3WHPJlVHn78h3bSZFlMvt/T4
	 PtDRVBfF+Y5+w==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Cc: puranjay12@gmail.com,
	puranjay@kernel.org
Subject: [PATCH bpf] MAINTAINERS: Update email address for Puranjay Mohan
Date: Fri,  5 Apr 2024 13:23:37 +0000
Message-Id: <20240405132337.71950-1-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I would like to use the kernel.org address for kernel development from
now on.

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 59c9a841bf71..b6930c2f68f4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -496,6 +496,7 @@ Praveen BP <praveenbp@ti.com>
 Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com> <pradeepc@codeaurora.org>
 Prasad Sodagudi <quic_psodagud@quicinc.com> <psodagud@codeaurora.org>
 Punit Agrawal <punitagrawal@gmail.com> <punit.agrawal@arm.com>
+Puranjay Mohan <puranjay@kernel.org> <puranjay12@gmail.com>
 Qais Yousef <qyousef@layalina.io> <qais.yousef@imgtec.com>
 Qais Yousef <qyousef@layalina.io> <qais.yousef@arm.com>
 Quentin Monnet <qmo@kernel.org> <quentin.monnet@netronome.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 6a233e1a3cf2..e2350c031578 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -553,7 +553,7 @@ F:	Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
 F:	drivers/input/misc/adxl34x.c
 
 ADXL355 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
-M:	Puranjay Mohan <puranjay12@gmail.com>
+M:	Puranjay Mohan <puranjay@kernel.org>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/accel/adi,adxl355.yaml
@@ -3714,7 +3714,7 @@ F:	drivers/iio/imu/bmi323/
 
 BPF JIT for ARM
 M:	Russell King <linux@armlinux.org.uk>
-M:	Puranjay Mohan <puranjay12@gmail.com>
+M:	Puranjay Mohan <puranjay@kernel.org>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	arch/arm/net/
@@ -21921,7 +21921,7 @@ F:	include/linux/soc/ti/ti_sci_inta_msi.h
 F:	include/linux/soc/ti/ti_sci_protocol.h
 
 TEXAS INSTRUMENTS' TMP117 TEMPERATURE SENSOR DRIVER
-M:	Puranjay Mohan <puranjay12@gmail.com>
+M:	Puranjay Mohan <puranjay@kernel.org>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
-- 
2.40.1


