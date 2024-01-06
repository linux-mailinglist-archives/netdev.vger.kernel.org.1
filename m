Return-Path: <netdev+bounces-62193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A81978261A6
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 22:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F3F1F21B9C
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 21:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173E0F508;
	Sat,  6 Jan 2024 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7o5UU9G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88904F9C2
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50e7b273352so596900e87.1
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 13:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704575670; x=1705180470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2uS87PAYvqfHPa3qIs13iQYjQv0tlskx3fHvEmWKBCE=;
        b=A7o5UU9Gvz3CdbVat2u1uAYwPv2GgglEwl7Zh9Z6OQR05JTijRELzDnjFb+8hTb+rd
         rQo88fZ8asVCzilP7CPsGg/jYgIYW0HySDlUdaA8K7+6/PrXuZb2uvvTZD2ZP4BEQM5T
         0u7Z4DjWaMf9fqcazBZVzBUclAfsduUritW06tzz4bpuj3GuoAJ/MMMQ6+qcMlx+vadA
         WfM65e0f58Q/FIp0kmPsWMR/NY/rRUZkxCI8o8KaLvPpBtNTanA5g6CZjPphYtU+aDKk
         jbzXURLautmizR/vlZ4BzwG982O1yUIXBHyY+vC1FvVSVHej2SFXmfP3LzE9cdYzBXtD
         hCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704575670; x=1705180470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uS87PAYvqfHPa3qIs13iQYjQv0tlskx3fHvEmWKBCE=;
        b=uBaXakNUS97EIhv0VsNDoHGB2UFsVgzVSm9Ix5+pFMKz7Fwyq/Olfjppt9IFWhIEzi
         E8peSP9nc42SkiHb7Nqu016xvsi3ns2gTL7r84gnlqUtOnD/gmBBD9QVBSya+VzGco+a
         lH9slJaUs12eD9zIEvuVSCb+OTtbxNr55RF1GC5QIQMafUEGevqyTVIkkPIk02g5+caa
         oXFvPl3xoXGCUglU8yLXRkOeQMrnR+3QTE58U2mII6Y0vDJCzXBoqhuScIzJ4YO8pqY+
         KVCf5Gr1r1v5RMo54rNFnLGl+5wET9ryZVRWQccvgyd6R7xDDekvhCUvKoa+12jx0hBg
         9TaQ==
X-Gm-Message-State: AOJu0YwJrjI1ANgH/oteSm95EgReOq0U/N42STW0KBtbtnEE363TCUPY
	cMabimQbHxa+MKea0Krt30gOvpxJBwIo/A==
X-Google-Smtp-Source: AGHT+IGoS1PGfXuvLL5f5DdPC9zPgoZAVD3h1BCXDEHWJi2TGwWYvnmXpkaFt9hbOxPa9emgdLgHRg==
X-Received: by 2002:a05:6512:110c:b0:50e:8119:fb60 with SMTP id l12-20020a056512110c00b0050e8119fb60mr518051lfg.13.1704575669974;
        Sat, 06 Jan 2024 13:14:29 -0800 (PST)
Received: from localhost.localdomain (89-109-48-156.dynamic.mts-nn.ru. [89.109.48.156])
        by smtp.gmail.com with ESMTPSA id q27-20020ac246fb000000b0050e7e5301e1sm628148lfo.183.2024.01.06.13.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 13:14:29 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Maks Mishin <maks.mishinFZ@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH] maketable: Add check for ZERO for variable sigma2
Date: Sun,  7 Jan 2024 00:14:22 +0300
Message-Id: <20240106211422.33967-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If variable `limit` == 1, then `n` == 1 and then second for-loop will
not do because of variable `sigma2` maybe ZERO.
Added check for ZERO for `sigma2` before it is used as denominator.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 netem/maketable.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/netem/maketable.c b/netem/maketable.c
index ad8620a4..56b1d0bb 100644
--- a/netem/maketable.c
+++ b/netem/maketable.c
@@ -68,6 +68,10 @@ arraystats(double *x, int limit, double *mu, double *sigma, double *rho)
 		sigma2 += ((double)x[i-1] - *mu)*((double)x[i-1] - *mu);
 
 	}
+	if (sigma2 == 0) {
+		perror("Division by zero in top/sigma2");
+		exit(3);
+	}
 	*rho = top/sigma2;
 }
 
-- 
2.34.1


