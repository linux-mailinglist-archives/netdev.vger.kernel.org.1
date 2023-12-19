Return-Path: <netdev+bounces-58934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485D7818A32
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269E9B20E6E
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 14:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDAA1BDD8;
	Tue, 19 Dec 2023 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efn7jtUH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E511BDF8
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cc2adbcf87so13539501fa.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 06:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702996721; x=1703601521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWSAM4JsfdqzIuyAx+IdTO0qt6TDFvdTGLZtS03HYUE=;
        b=efn7jtUHS0Dt+/jVBp865jNakcxKQMXkRCmBMkEqykfv8QlK/e6AdsOVN+H/xB3ZCj
         xfLyj9xhNgqYLUeS/bB0Ynfgo/VH7ruWOWvdUIGA9SV/Y4m14J2g2Sc3yPw0+tI4SYWP
         sS3PX+RyohF/SDVwVOLQivZyMNcq7S7ZpHmM6m0sMzzo/piuswTATme1ZMhcHkgT6bKM
         qjxB4WzR4KWNMokb7mIrhGZ2SszbhCkspYaFBEEetyEXOIQTy66MlKXSAaoPY6dtZ33r
         Dbe/o7SShky0cbV7IfWTdnFRk78cNxYyisRyTVa6zwWkiKU5D/YAcg9eL7ifSx1TrhIG
         g+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702996721; x=1703601521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWSAM4JsfdqzIuyAx+IdTO0qt6TDFvdTGLZtS03HYUE=;
        b=PBoPC4wogWNx541wpaZaXvZ1sPx0i9lsYfwO9xoA4Yne8QjT3gncTudtozxcz4HRp1
         gR4cLyHaW+nR0PbNqTvg25Urw5OjMRL2o0llOdFTuKc7AgGL3h7hXKltE8HCX9P92ehS
         JDpcViXZkMS6LwexIe8aLggjNLtCGYPEGOPwUY+YkdF8i/HUM5vNDyf0FpGl2JDrNtbX
         AVDlAgGDExO1pxWGouZvG7vm7yd0DabR9hLCEIX77uiuT5zkM3iNOEqN5zlzXhW3SDe/
         qNOBYoS3NKWXc6qa3iE+3ycuEm/4m5Ze/RPGC4OaVO+bhu1NCKDOBcJOiRtouLEWnh6p
         MHlA==
X-Gm-Message-State: AOJu0YycQC//UsoW5z2oeU0SGFe/kZYJzeNeM8eTQgSjLBoiNNhqQZuc
	ATLhSdRGhTDSnH9qZb++lDtCzHaSnVbgf+u+
X-Google-Smtp-Source: AGHT+IFLhg+xtbV+M+nVmNE5s2OiGWHNhS7K/CarW1reqabeeFVHr542zmiSFHaWmp0Yx3S6kAYTiw==
X-Received: by 2002:a2e:9914:0:b0:2cc:5f22:ba34 with SMTP id v20-20020a2e9914000000b002cc5f22ba34mr5433670lji.1.1702996720413;
        Tue, 19 Dec 2023 06:38:40 -0800 (PST)
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id c6-20020a2e9d86000000b002cc68cce064sm1011014ljj.62.2023.12.19.06.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 06:38:39 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH net-next v2 2/2] net: remove SOCK_DEBUG macro
Date: Tue, 19 Dec 2023 17:38:20 +0300
Message-Id: <20231219143820.9379-2-dkirjanov@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231219143820.9379-1-dkirjanov@suse.de>
References: <20231219143820.9379-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since there are no more users of the macro let's finally
burn it

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 include/net/sock.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8b6fe164b218..7c0353fcdfaf 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -76,19 +76,6 @@
  * the other protocols.
  */
 
-/* Define this to get the SOCK_DBG debugging facility. */
-#define SOCK_DEBUGGING
-#ifdef SOCK_DEBUGGING
-#define SOCK_DEBUG(sk, msg...) do { if ((sk) && sock_flag((sk), SOCK_DBG)) \
-					printk(KERN_DEBUG msg); } while (0)
-#else
-/* Validate arguments and do nothing */
-static inline __printf(2, 3)
-void SOCK_DEBUG(const struct sock *sk, const char *msg, ...)
-{
-}
-#endif
-
 /* This is the per-socket lock.  The spinlock provides a synchronization
  * between user contexts and software interrupt processing, whereas the
  * mini-semaphore synchronizes multiple users amongst themselves.
-- 
2.35.1


