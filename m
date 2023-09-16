Return-Path: <netdev+bounces-34310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1003B7A3117
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 17:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB572821C4
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 15:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776AE14291;
	Sat, 16 Sep 2023 15:30:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C3712B9A
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 15:30:42 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C646BF3
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 08:30:38 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf5c314a57so24321005ad.1
        for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 08:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694878238; x=1695483038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv0Qquu142uiS+GRCJDKBYsWUpVpcjI3BYZUmA6KsrA=;
        b=V912Ots9ULdFpKWwE17LSGQ44qUg6uAqdhVdhh5Bmt0OwJtyQNhWnRzR4kdkL7RU1P
         3YmFjjF18SnI2pUKK1Q9Sw6CsE3qvrMAPqy20QDqP/zEmE+Wt021TjhAghpyxkfwjeKX
         4O1gUIOWT3FGby+C3Y+a5JfAzeXICxImlGqPRfmc1vq60+3BJaJiJX9cXWko/FeukPwO
         qlFs2rtv1q3ul0zSATbjMsbWV8M0AzrGFQDtWmYsdktmkfXu+MTglXgCAXlrsnRGF/XY
         OsSWM4NLAPQz4yY7Cx5S1QdBbmF/PxeyS1vuSkeMOgQ7dYI0z8H/yF3cGSxKNZeloHqL
         Z3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694878238; x=1695483038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mv0Qquu142uiS+GRCJDKBYsWUpVpcjI3BYZUmA6KsrA=;
        b=qlOX79dKtfi1rjT0/Zx59QhAbxteFC16Abu7clA2v8zkw86GyZvssc5gLi+9dC6AH2
         I1G14QVXwfThlnnK0asxBRGCxZkjARUF5DLnqYCxS3ZtbqwM+rQhMLqcJ+ItJj1CkraS
         5uw8gg5DWWjlLWuvAi2C82LpQuOkmblo4gIcheEkTgTHChMDHrFXhsu1s+mQ8gEZI9va
         oIsiLZt5Tp3fRI56wsXcoKdmkKBmtilKRZthN4AbdoJ6EWOAAauV/MZM1pVSvAKpSIbN
         jVLphwmZePiU1hxJ6+0/nDJbuJa3eY1/X9eCJDMErCMyG4645qZL+EKSg8TEi8Q8Iw3t
         SElQ==
X-Gm-Message-State: AOJu0YzQCEsRTmTiq8MHn3GY05qTxtQO48ARMPY4OQu7Np98YWSC8BEa
	l11cAohst2+35tUgD5ePRbjHsTATJ58A9jX7qXY=
X-Google-Smtp-Source: AGHT+IH1TfPn9mJrm8RXKQkBKKhXLmQ7SvG5vqQb9o3PnZ8mWOzkZqCp+ZQaqScARcFU6rheKPm/3w==
X-Received: by 2002:a17:903:124e:b0:1b3:d4ed:8306 with SMTP id u14-20020a170903124e00b001b3d4ed8306mr5238726plh.19.1694878237710;
        Sat, 16 Sep 2023 08:30:37 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001b898595be7sm5387888plj.291.2023.09.16.08.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 08:30:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] github: add contributing page
Date: Sat, 16 Sep 2023 08:30:27 -0700
Message-Id: <20230916153027.9027-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is a standard way on github to redirect contributors to the
mailing list. Doing this to reduce the number of github PR's
and issues that need to be redirected.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .github/CONTRIBUTING.md | 13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 .github/CONTRIBUTING.md

diff --git a/.github/CONTRIBUTING.md b/.github/CONTRIBUTING.md
new file mode 100644
index 000000000000..ee5496a908de
--- /dev/null
+++ b/.github/CONTRIBUTING.md
@@ -0,0 +1,13 @@
+## Contributing to Iproute2
+
+Thanks for taking the time to contribute to Iproute2! Please be advised that the
+Linux network community does not use github.com for their contributions.
+Instead, we use a mailing list (netdev@vger.kernel.org) for code submissions,
+code reviews, and bug reports.
+
+Nevertheless, you can use [GitGitGadget](https://gitgitgadget.github.io/) to
+conveniently send your Pull Requests commits to our mailing list.
+
+Please read more about ["the development process"](https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/plain/README.devel)
+to learn how the Iproute2 project is managed, and how you can work with it.
+
-- 
2.39.2


