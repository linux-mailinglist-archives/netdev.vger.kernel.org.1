Return-Path: <netdev+bounces-16058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDA874B371
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 16:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9391C20FE8
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 14:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D325C8F6;
	Fri,  7 Jul 2023 14:59:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BBEC123
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 14:59:25 +0000 (UTC)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9252114
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 07:59:22 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-55b66ca1c80so1116473a12.0
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 07:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1688741961; x=1691333961;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x5aQ1yIyCTMzZvvuTorRhD9Thf1BM2qItKmtCbLp/cY=;
        b=S4XlLPL0XdTBgw7+lK0zh/JLzbEKd3xKfAHmVlR+3BozS3uBGsFTwSMhGSqqvQfaP8
         ADRZc1O0g9GtEaa4JPJPhQSWDS85URO4AAUzEUqQus+wF21bedromxs0Mo4+eHA30w+U
         MKHxFDKS55hieGAbZxtTvxPg1A00zHEDAyMkN0/14uCq+ID8PNimNqi17DuhbFr1mJT3
         y/wdyiaaLqOz7K6OXvcrub6wZHYQiDX5iyePmD2k6s3b9FungQyQ8be0qlZIG5a92u8V
         G0bdfS/G8+a2+XOgrSLiyVmDX4FGTV1V+b0y7WcggHvkInZGuFOT0RgF7jLTJbtQ5S7U
         0L1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688741961; x=1691333961;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5aQ1yIyCTMzZvvuTorRhD9Thf1BM2qItKmtCbLp/cY=;
        b=jXSsmn/n2zTc+Lql2dFCkHmA5ggVrf/ioY2Zr4NH532qDlCUGqjttmumrX6hzKS53k
         /e9CLs0GgVUHJ0amc6ptr9QtTC0cRjkHrKg8EQsOJHoaD66doWfDqLS3iQ1GBsfeE0fQ
         a5xUE3Hs6zK1P9ZqkmX+zbNYZPKfmKyNoWX5SACnJTbPIFbloiztVfOUBbAaL8EpnaGH
         3lRHJ9odKhCzFbF8zA6OBLc+8Dr5bZrEZ3QP5njQWGdzju9GHrutW/ULiFmOaFXBHPr/
         P1stgSBdCusilviXnIpRQjKtYcvTptTCsmMi30o2w82YXefDUSMisboieG7mbHh0ZGbf
         oHxg==
X-Gm-Message-State: ABy/qLb78Ijwqmr8gDE5VRO7R7TA+Qvd5p00oCuPs/DJJ1v5sZCi4BB7
	O9JrA/yCjfFfKBwSNIcSGLElowPnrUePhoBQGYQvr8/lBU8=
X-Google-Smtp-Source: APBJJlFX+pmcg7B5LGFirIvbehRAVWWpkoO0O6HaZMhfrwvrWPB/nM0rRZ+adWIMGtaRWiJ4urKFeA==
X-Received: by 2002:a05:6a20:2d8:b0:12d:1ae8:a62d with SMTP id 24-20020a056a2002d800b0012d1ae8a62dmr4039211pzb.19.1688741961290;
        Fri, 07 Jul 2023 07:59:21 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id ff5-20020a056a002f4500b006815fbe3240sm3120522pfb.11.2023.07.07.07.59.20
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 07:59:20 -0700 (PDT)
Date: Fri, 7 Jul 2023 07:59:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 217640] New: 10G SFP+ and 1G Ethernet work at 100M on
 macchiatobin
Message-ID: <20230707075919.183e6abc@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



Begin forwarded message:

Date: Thu, 06 Jul 2023 23:23:02 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 217640] New: 10G SFP+ and 1G Ethernet work at 100M on macchiatobin


https://bugzilla.kernel.org/show_bug.cgi?id=217640

            Bug ID: 217640
           Summary: 10G SFP+ and 1G Ethernet work at 100M on macchiatobin
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: alpha_one_x86@first-world.info
        Regression: No

Hi,
Since I upgrade linux kernel from 5.10.137 to 6.1.38 all my interface of
macchiatobin work at 100M (90 Mbits/sec detected by iperf)
ethtool detect the link at correct speed (10G for SFP+ and 1Gbps for ethernet)
What can be the regression?

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

