Return-Path: <netdev+bounces-119667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5479568A6
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE761C217A0
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7606166311;
	Mon, 19 Aug 2024 10:36:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA8D165F08;
	Mon, 19 Aug 2024 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063790; cv=none; b=OAqpfrtpJFdHFeVpAW9Ke0NtXtTvQqNN7xLiC31GKopasmmam8ITEX0atU0rDpXpv7a8NkLuaJt/heKf+EpQ76HOAvGnbo3EoBby+XHxgCNgTY5Z5jrM2RQCdXxaIVhPbCQDqeEIKDlPjq9GWdom8nffGHxGyocrN+VnnrcgMqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063790; c=relaxed/simple;
	bh=OEOJaU7FO+Y3om1CTtTxGIm1Pr1idfRNUVs2YVE405k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFjmOIGQPAgh66FoRDNyZ6kq3rUt5Vc37CZD4fCX0CZ5oCfjXkl89zo6ytL7r+BfWuPkfl99KjhG1ssASRTtMak2+iW/ZFW4NLxmYCw70ywv4l8Ia0ZvxhrP0ase5vy5ME+z3vDim0L8AIsFs2zPVPYFaeGMOO2hd61j8gyJMC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso804006a12.2;
        Mon, 19 Aug 2024 03:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724063787; x=1724668587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIllBuSyEfMYpqtUTp/ty9HKFNwz5pVEQovT7QC2n1M=;
        b=ctLn6D6Ksw/uGg6gqnSBaiX5YOjC0LnK1YSYTtA84l3x4xh2omqAc0y9AjAumaq+jD
         j9qq5iFk41BVtchskstGLbdmxmQQkn7oRazAN8UvlotUcGRfJPgAx1MUBdddkZ1+Ks1Y
         4xMYuxZbb3oagSoQRJ5aJTESbcqUVXXK5BnBqXVlkVBONddpPz/EvJZqADopao5PKA0e
         8auvcReHaVgMMDilCzB72x00HjNgCagDZnttkwZ49w0ozwm8Uhq0gIFc1xhYv9lhT2Fi
         c31K643UBnLha5kllrmLJkiOrHQaN6OjgfzpsPxfD36LbA3K60vRKe4Z/upNFPyqK/v4
         HKnA==
X-Forwarded-Encrypted: i=1; AJvYcCUNK6z0GBC6lJuEEGAzXVYXx11CZ6e0DpV2b3HEyv6xsCVgd7lxiTKRaaC3zZzNxHb3poJ+7GBx7YhwvRsv/jPz6a8TM4OxvHoph+DB
X-Gm-Message-State: AOJu0Ywkq/8u9/qdyM1fZ9m5o+bWy2CzjaQuaC3KpiX3ctJfvD/eF9oA
	qE3b3rS3xO36+1dz0hx5cQHllfP9YO8jh8v/9wGBm1onDFzS8oKy
X-Google-Smtp-Source: AGHT+IHNs+WvvRiv/kxSskJxChJQ4RbPLbS5oaL9O53qO4OHT+Ph+G5OZQe5ULvCi/ycevmxlGq0BA==
X-Received: by 2002:a05:6402:3585:b0:5bf:38:f676 with SMTP id 4fb4d7f45d1cf-5bf0038f848mr1076055a12.1.1724063786984;
        Mon, 19 Aug 2024 03:36:26 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbdfbb29sm5413055a12.48.2024.08.19.03.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 03:36:26 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/3] netconsole: pr_err() when netpoll_setup fails
Date: Mon, 19 Aug 2024 03:36:12 -0700
Message-ID: <20240819103616.2260006-3-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240819103616.2260006-1-leitao@debian.org>
References: <20240819103616.2260006-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netpoll_setup() can fail in several ways, some of which print an error
message, while others simply return without any message. For example,
__netpoll_setup() returns in a few places without printing anything.

To address this issue, modify the code to print an error message on
netconsole if the target is not enabled. This will help us identify and
troubleshoot netcnsole issues related to netpoll setup failures
more easily.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 72384c1ecc5c..9b5f605fe87a 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -414,8 +414,10 @@ static ssize_t enabled_store(struct config_item *item,
 		netpoll_print_options(&nt->np);
 
 		ret = netpoll_setup(&nt->np);
-		if (ret)
+		if (ret) {
+			pr_err("Not enabling netconsole. Netpoll setup failed\n");
 			goto out_unlock;
+		}
 
 		nt->enabled = true;
 		pr_info("network logging started\n");
-- 
2.43.5


