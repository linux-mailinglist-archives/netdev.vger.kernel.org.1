Return-Path: <netdev+bounces-171688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2856BA4E268
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596A019C1703
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 15:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AF227CCDF;
	Tue,  4 Mar 2025 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J+z8GQ6K"
X-Original-To: netdev@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14AC27D763
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100252; cv=pass; b=hcE4y73/yclj4zWnFf6ZhhgV8hrU98q6NOKUwKCeslqYyNjszmuzsl0fJrFfwsqcbaV5Wv53s4BE9MGapG8tHVISNu07LeR32eGOmX6gmvP/uAueKlYS7AGPpmaDooS60RT6lAqhOoPJlSHLK/PQc1D31UarKnmQFEy37byHcOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100252; c=relaxed/simple;
	bh=uWrqL7qwHJ1xRe81W1yZdqN0xrTeQwVstuEoqTp4vdM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IAjWTvvbm7R7eXOrQ2bXal1yxa5Lbd6cUjakwOLMvZFY2JOT7+qX95bmSiFqq9ZU1VYusDFCbYNZ8JqfFJwnqRYNEkL0z/6Wlv5j1sYAiEb5JA48369Abj2t3qsrD0gp6NjwSXn+sCHcf6ja8Zd+xyhFXoDm+MWtvPIE6poPtSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J+z8GQ6K; arc=none smtp.client-ip=209.85.208.46; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 0CC6140D0C8A
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:57:29 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=J+z8GQ6K
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dzh0LBYzFxyK
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:56:16 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 15FB24272B; Tue,  4 Mar 2025 17:56:01 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J+z8GQ6K
X-Envelope-From: <linux-kernel+bounces-541662-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J+z8GQ6K
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 40F73420C7
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:02:44 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 85DA12DCE3
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:02:43 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E2147A31F1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207D20E6FA;
	Mon,  3 Mar 2025 12:02:23 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C318192B84
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003341; cv=none; b=gQSie/oRrXv1N6xLEHL47Fg4AQHrpTKgYgpCdwlMnS/E681vQRE+L7sQv9zAwnQKW+4eZekOFLU2yEMQdBzHwgqS9cD6A3yBfv4hNQqLHwuppkKJYdaYNRs7RwcDpySdlQYXri1Ohkw7yR7XLqsIihvi6gpN7dU6+WuYDPTiHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003341; c=relaxed/simple;
	bh=uWrqL7qwHJ1xRe81W1yZdqN0xrTeQwVstuEoqTp4vdM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f2j8NZJRH65zf9HH2hZ2WELM7ObcSLq0LXQesLYxRVech2bsdiTqdLReCz7eguPmlv3y6Dc3//aslQHj+p7xvQQgu36jTNNCww11AG+cgZFtl3UQCc4qc20U4v9i0Ux2+m9rcWTlyKSIm+EBDfZ0ZIxOxMumQyKw4jD67VUnNKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J+z8GQ6K; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e4ebc78da5so5512220a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 04:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741003336; x=1741608136; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FvjfazhXAUkX+q9ADQWctMmDsHuSAcb7Kglrffn5CF8=;
        b=J+z8GQ6KzwxpWwpV3YGxkzqQikDOY63gQurQH/Y/cL8OWNZA0azkubadKmtksdtqYc
         xU+gyI2iFllMV41ktZAsoFx6JyWM+JIlRLkVcyVsSNcwrfCqYXqikeJpr7XPutD6LMLW
         HENRTHMLZF48To0S3r/rpJLovnqUzJLhiJzyv6140a+OaqK+E9lX9/2tEmys/W9gYAYX
         wqFYDqbDkKSqk5stsLKfLF8p+o25nsxJxkcq6OBfHKa6Wc5jXQZnnjTJnjlhfK0XgbAG
         jY9JcMXhq9BB2LjMMI7FUIrkqpnSVpHfR0L7z6q/GJICdSX24UnNlUG49pN+M7GrYq4p
         o2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741003336; x=1741608136;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvjfazhXAUkX+q9ADQWctMmDsHuSAcb7Kglrffn5CF8=;
        b=pyk4N3bUfp3gysCeAToB6B/yxsERcYaGW65Aj1Q3n/mVQtYYgMC3ABE71MA+pukY1y
         DeZZZnS7IN2KMbm8dS5Ed5TEZLczc+7J67L6W8wlJr+0amuoD1ghzaBxdzRtZWUQazOk
         Kgbj+bMNfkSBJxfKW59D8DPsA4QWNomCDvdrfsdXAIphRbD5Slv9p0q9VnhqKmDhz73Q
         uQtxqduYj69fG9eSqLGqKjHm7S9hO8NOHknomIDUvNsTguq+SJsNWLKzeb1Pffhxri4m
         xeGmWN62hRd5yUdlQaWt7CJsK3InmhmzeAKMiYoM7kYH8/0yvnDbAzk8L+CcqSnV46Sy
         +8Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVxDb6yf+7unuGilLTQ2A3Q2uvSGjwCaCTUFexwuEMif6J04Z8GfV0JRdeRjfDAgUBORUVDtmUHgoVfkhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIXBIH2KmrWWU98ZBFeM8dvPmEdkB5ea8rHiMOpAIJShlVPJHp
	u2gdftZXmavKYBYHQ6pmmLCueGf7fa4zkTSO0T4VNTazw5N1oGo5YkeXig8P0EnVSuzqhfK7K2c
	m
X-Gm-Gg: ASbGncu3n8jDa5K1BtKhemkaY2JrpoG3jhLsxe4iOfym3UOj3Ap0NmLUIkeGZ7FxJ/r
	4Z8mkDSbsymLqK3GZoIgnY0KpbGnSFpdJLp5FugS2ZEmrBQnxTTyo61NrENoBXGsJ5dM9TZRZJ7
	G67hXxC1lNktlQc4oz6euXEkoCBk/DmrDSsv1zr3cKeN1jomAUpVfEmr8c7MjIiXmiPC1YvQ22Y
	+GC8Cg5fQCu3rjBNs8nXibzYq6GaJKyzM2xYU7juqM+u4nYx/Wy5Hr8IbgpaQ2AFv9uUFDj3Gpr
	P3Kqr2/AkEizKgHIllq7Ewys5eLgaWSuuutcIamfpipsR5WFKQ==
X-Google-Smtp-Source: AGHT+IEVLpvwi6O6OBs0WN+GyOzE3jpuGJmps4EUiNQjjGbXYoZLIY4WBBNb3SuJAGnkmtz62ElidA==
X-Received: by 2002:a05:6402:5190:b0:5db:f26d:fff1 with SMTP id 4fb4d7f45d1cf-5e4d6b62c36mr13405841a12.21.1741003336577;
        Mon, 03 Mar 2025 04:02:16 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e4c2f408cdsm6696931a12.0.2025.03.03.04.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 04:02:16 -0800 (PST)
Date: Mon, 3 Mar 2025 15:02:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: Prevent use after free in
 netif_napi_set_irq_locked()
Message-ID: <5a9c53a4-5487-4b8c-9ffa-d8e5343aaaaf@stanley.mountain>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dzh0LBYzFxyK
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704982.18867@ci8zwC5lRflqM7vipDfoVg
X-ITU-MailScanner-SpamCheck: not spam

The cpu_rmap_put() will call kfree() when the last reference is dropped
so it could result in a use after free when we dereference the same
pointer the next line.  Move the cpu_rmap_put() after the dereference.

Fixes: bd7c00605ee0 ("net: move aRFS rmap management and CPU affinity to core")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9189c4a048d7..c102349e04ee 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7072,8 +7072,8 @@ void netif_napi_set_irq_locked(struct napi_struct *napi, int irq)
 put_rmap:
 #ifdef CONFIG_RFS_ACCEL
 	if (napi->dev->rx_cpu_rmap_auto) {
-		cpu_rmap_put(napi->dev->rx_cpu_rmap);
 		napi->dev->rx_cpu_rmap->obj[napi->napi_rmap_idx] = NULL;
+		cpu_rmap_put(napi->dev->rx_cpu_rmap);
 		napi->napi_rmap_idx = -1;
 	}
 #endif
-- 
2.47.2



