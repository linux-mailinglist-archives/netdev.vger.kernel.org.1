Return-Path: <netdev+bounces-43982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407A57D5BAA
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 21:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFB65B20FC0
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 19:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFF93D96C;
	Tue, 24 Oct 2023 19:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEYs3Gcg"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0454E3D382
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 19:40:20 +0000 (UTC)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC0F10DD
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:40:17 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-357c8dbac0eso11511565ab.2
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698176416; x=1698781216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G//uZtGBOL4/v3OESmEgRsB4CqBYA+qMh3xoRKxy/6M=;
        b=WEYs3GcgR9VPOtG6IBCEokAJxLht+PkhnK8S+RzbmJytAr9OOylp+is09TH3CXmKxq
         tZrOrEP2heFCGTxRyc8KmpMUfxxn3kGYgTNZQx0eWjhC2V9SlMsLb9m0tI3Cy6JtEJJE
         Prylv1Tw6FuRmArro5zkfv2Ruhb4DsZgcM3QtgGEcnub1XExmcekSs+lcShMi8PYyYZZ
         doScgtYmUmIFVRIki3AdGqhs2K4OmDukX0mHkbxkCVD+23Xv+3G8VfkyP3w95a+Yx+7q
         5xEVlA1xu/37MOe04m3EZLwLVbNlprlG3W800JvQpvAeq9sqzmbjh/+HhYh1b6EoH+3l
         QGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698176416; x=1698781216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G//uZtGBOL4/v3OESmEgRsB4CqBYA+qMh3xoRKxy/6M=;
        b=wn/4qzmaU1wO6HdJN8zyh3g+s5KaGHJWOwnblDM7XU+5fssbz7cNvOeynOg5RIlcMt
         jaDDpM6Ykmn2UVmguBZ/QlYShcGK1rpPTjEQ+U0XBfkqi4OVcL5Uzrp59/+ssDFUMg3Q
         4VAWM6crImzaevk+7a69IKh+lDhsGkMJyaJwfGzud+asmiqEUaPqY14qxb9WulLP8mHK
         V5sLH4FeKhcH7KWPUqLFVheU4z0emy3KZxGlCSyBhL47RLC/fgdfcMpuwRLMkw2QOKeB
         cUZMSA6c91YJs9FjZtWrr5cNhtTMg/Oe7WUN1BA/mVPrPWvn+XhGU9UtYvlqcaWi1zR7
         uJsQ==
X-Gm-Message-State: AOJu0YxCpzxLvZaqRQlSwIbyKOZmHNY4SCw+eSozvvNhTRNxfgSI0MLw
	eetFXoz34UVAxAr/3b6vN9ewqARsNiY=
X-Google-Smtp-Source: AGHT+IHDKrDvsd1zzc0Opx0pM4Kg7ZbrygAWUCezyHWalw4PtaYO48iIySIYo+Uhj48R7LjzdKwFag==
X-Received: by 2002:a05:6e02:1ba8:b0:351:1d53:c789 with SMTP id n8-20020a056e021ba800b003511d53c789mr18012299ili.8.1698176416353;
        Tue, 24 Oct 2023 12:40:16 -0700 (PDT)
Received: from localhost.localdomain ([64.77.246.98])
        by smtp.gmail.com with ESMTPSA id s7-20020a056e02216700b00357ca1ed25esm2294486ilv.80.2023.10.24.12.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 12:40:15 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	jbohac@suse.cz,
	benoit.boissinot@ens-lyon.org,
	davem@davemloft.net,
	hideaki.yoshifuji@miraclelinux.com,
	dsahern@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH resend 3/4] Documentation: networking: explain what happens if temp_valid_lft is too small
Date: Tue, 24 Oct 2023 13:40:03 -0600
Message-ID: <20231024194010.99995-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024194010.99995-1-alexhenrie24@gmail.com>
References: <20230829054623.104293-1-alexhenrie24@gmail.com>
 <20231024194010.99995-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index a66054d0763a..f200382858da 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2471,7 +2471,9 @@ use_tempaddr - INTEGER
 		* -1 (for point-to-point devices and loopback devices)
 
 temp_valid_lft - INTEGER
-	valid lifetime (in seconds) for temporary addresses.
+	valid lifetime (in seconds) for temporary addresses. If less than the
+	minimum required lifetime (typically 5 seconds), temporary addresses
+	will not be created.
 
 	Default: 172800 (2 days)
 
-- 
2.42.0


