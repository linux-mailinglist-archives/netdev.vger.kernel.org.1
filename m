Return-Path: <netdev+bounces-14466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A532741C87
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 01:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2ED280D15
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 23:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEDC11C8E;
	Wed, 28 Jun 2023 23:38:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422D011C8D
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 23:38:20 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1682C132
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 16:38:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b7f68f1c9eso830455ad.2
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 16:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1687995498; x=1690587498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wdihvrzaNzfkenF/sT5C6HaVtdcbKpLpvWCmR3w9p0=;
        b=AsRVJ8IvduiV3hj/peoMROOMcxLoCRGsThOGogkB8unacNnc96346xlk0LfcZTuqOl
         HZt/LX2UMrVakHKcdRIOKv0k0ap/5JxZI9PttM4ZRrLJQ6Oo/YiEVwZmp85U1MmijiQ4
         1tRAL2AJO/O/Ts3oOW/iTgiN9bSJ5VIHAph2o3v8AlpEYS9f7Meu540rGvbvREwMDz/A
         S5ILo/hrC/hlK03wY0TEvZNE6hczHyjS0xVELsuOohRDycTImBD0zk1ZkTwe+264Gg3l
         1Xob3wVr14kg9hvLHGD15mFjqEWlcnEjCPwRmqX5nOIXcMhISEeUXqb0cT8b6LVE7ugj
         gFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687995498; x=1690587498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wdihvrzaNzfkenF/sT5C6HaVtdcbKpLpvWCmR3w9p0=;
        b=fqUwO7dJ0JTGc6kUbQPHsoAGpJir0AfEufTjF3Fe7nGXfdMB52kqIwP+LDVGau9gGC
         myDtzNyVflO9w/9ugKml3WpgFQMsorDs+pI6KpTqmowQfAVAZlfi2s9NqrlCJcLr0hcd
         YT9Nhi63Qqi39frh5IDzMWhtB7bb1AMONIUS+bYiiSqNPS3tIRR3DAuoL4lFX267+8eF
         Cg6H58YFJb5LTGWSpDUAhfPUoKOAgfX61n0oH5LLjqS0Spa/pcV11hxKXfJNLBxE20BH
         Zf9nElDN3z9njDNfATgR5ALY/zOduM0ANVl8OYGCgWO60+YHKTH0DOhmx81PPL2nslXJ
         UiZA==
X-Gm-Message-State: AC+VfDwxgL5rDlYvDC1/BZf5lEPEcba8EykVtafPWDuBGfyZg2tk9RE5
	InVLEGb+Z6vg7Iw3sgzOOaIuQVqA5P+Tsps+Nrs1jw==
X-Google-Smtp-Source: ACHHUZ48Dkps2meH2qyUxoU3vKeZ5BuidUQqoyF256KGS/g4J4f71FauKLYAqwrtRCQro0Nr5WdTrQ==
X-Received: by 2002:a17:902:c951:b0:1b5:219a:cbbd with SMTP id i17-20020a170902c95100b001b5219acbbdmr16867272pla.3.1687995498414;
        Wed, 28 Jun 2023 16:38:18 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902a51200b001b7fb1a8200sm6437196plq.258.2023.06.28.16.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 16:38:17 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 2/5] fix fallthrough warnings
Date: Wed, 28 Jun 2023 16:38:10 -0700
Message-Id: <20230628233813.6564-3-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230628233813.6564-1-stephen@networkplumber.org>
References: <20230628233813.6564-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In lib/utils.c comment for fallthrough was in wrong place
and one was missing in xfrm_state.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/xfrm_state.c | 1 +
 lib/utils.c     | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ip/xfrm_state.c b/ip/xfrm_state.c
index a7b3d0e14156..9be65b2f8461 100644
--- a/ip/xfrm_state.c
+++ b/ip/xfrm_state.c
@@ -660,6 +660,7 @@ static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
 		case XFRM_MODE_BEET:
 			if (req.xsinfo.id.proto == IPPROTO_ESP)
 				break;
+			/* fallthrough */
 		default:
 			fprintf(stderr, "MODE value is invalid with XFRM-PROTO value \"%s\"\n",
 				strxf_xfrmproto(req.xsinfo.id.proto));
diff --git a/lib/utils.c b/lib/utils.c
index 01f3a5f7e4ea..b1f273054906 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -985,9 +985,8 @@ const char *rt_addr_n2a_r(int af, int len,
 			return inet_ntop(AF_INET6, &sa->sin6.sin6_addr,
 					 buf, buflen);
 		}
-
-		/* fallthrough */
 	}
+		/* fallthrough */
 	default:
 		return "???";
 	}
-- 
2.39.2


