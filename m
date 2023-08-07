Return-Path: <netdev+bounces-24882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EE3771F76
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6462F2812A4
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 11:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D414D303;
	Mon,  7 Aug 2023 11:10:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B3CD511
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 11:10:16 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CA2B3;
	Mon,  7 Aug 2023 04:10:15 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe426521adso6817115e87.0;
        Mon, 07 Aug 2023 04:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691406613; x=1692011413;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GwJ0VfQ+vMDvyOW9FkLQ8b9EFxXB9GwcO9Ph5XHR3Ew=;
        b=BgZ4tJyQ2yIZtYNdUTua3Huk6DdFfMcLY1/cmRqBC+FafadmrFGITpMYQuzNHpvB8b
         /EyCWXTTVFk04BYt2vOqyx6g+V5PkkYFXZOgKjuxce+12zYqCyssQZMzcPm8B0PSB4a+
         kRz5DoCYfg+bNrOdFXTCz+rSvQlh5ruH83r6Pw6zZw9iBfCdPE1zFgvNyl0mnUnGHRwK
         Wy0o1KuG/6d3/yU/LnUQQCN60HCklTq1K5eOxd9hYiixS2G9VlRadq6xTO27c0MJ668d
         r+zgrMnEE6gx8WE8svH336pClAW8wQ6bm4Wqb4d3/K6r264FSNs0JHJQminlUZCVk5Iv
         kSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406613; x=1692011413;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwJ0VfQ+vMDvyOW9FkLQ8b9EFxXB9GwcO9Ph5XHR3Ew=;
        b=bHbHDn65WKtZUCrS0H0zuIasY3SsikvNYzX+sOhPwNSzbK3RbPjneLMP+rSFlLPdBj
         9BKhoovQwCu5wjhOfpwKXC8in6Xwx5ItYICcuQGpfFSNq4j9nVCjrPkMcmWH2MMs8oIB
         un82kXWod7BMXHPg+uBVAvx8Ir4HtAAwXIJPi0q032cuaysNIjG5ktyQdl+dFe33vwds
         W0V36gBTpu2OH5JNlshLsCb+cjH7oniAExBBrhyzH/Mv234fzhI2nCEtwGdK5zFrAFq6
         i3TE5283DKiY7EG7wkYmlhQy5ilUNacUfRGHr2jAeniJWn5BHp7kMOV3aDDECxX2Ey83
         YLoA==
X-Gm-Message-State: AOJu0YzwSoWn2/wzTfr3+4XkmYoQj5ITjJTzzUy8vx+nzYfGZBS5Q4e5
	n5cwDUVCoHLl3/bsUUx5Q0g=
X-Google-Smtp-Source: AGHT+IGdJlKPNGSLi2wCWxWzcdq6Bhj1eY6HS9Agi105G0fdzX0qdgytZmZO9maDnyvykkjOlZG7pA==
X-Received: by 2002:a05:6512:3e2:b0:4fb:89b3:3374 with SMTP id n2-20020a05651203e200b004fb89b33374mr5076716lfq.54.1691406613317;
        Mon, 07 Aug 2023 04:10:13 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id f8-20020a19ae08000000b004fe7011072fsm143012lfc.58.2023.08.07.04.10.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 04:10:12 -0700 (PDT)
Message-ID: <0f9d0cd6-d344-7915-7bc1-7a090b8305d2@gmail.com>
Date: Mon, 7 Aug 2023 13:10:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM board lockups/hangs triggered by locks and mutexes
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Florian Fainelli
 <f.fainelli@gmail.com>, linux-clk@vger.kernel.org,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 Network Development <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: OpenWrt Development List <openwrt-devel@lists.openwrt.org>,
 bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
References: <CACna6rxpzDWE5-gnmpgMgfzPmmHvEGTZk4GJvJ8jLSMazh2bVA@mail.gmail.com>
 <bd5feeb3-bc44-d4d2-7708-eea9243b49a4@gmail.com>
Content-Language: en-US
In-Reply-To: <bd5feeb3-bc44-d4d2-7708-eea9243b49a4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 4.08.2023 13:07, Rafał Miłecki wrote:
> I triple checked that. Dropping a single unused function breaks kernel /
> device stability on BCM53573!
> 
> AFAIK the only thing below diff actually affects is location of symbols
> (I actually verified that by comparing System.map before and after -
> over 22'000 of relocated symbols).
> 
> Can some unfortunate location of symbols cause those hangs/lockups?

I performed another experiment. First I dropped mtd_check_of_node() to
bring kernel back to the stable state.

Then I started adding useless code to the mtdchar_unlocked_ioctl(). I
ended up adding just enough to make sure all post-mtd symbols in
System.map got the same offset as in case of backporting
mtd_check_of_node().

I started experiencing lockups/hangs again.

I repeated the same test with adding dumb code to the brcm_nvram_probe()
and verifying symbols offsets following brcm_nvram_probe one.

I believe this confirms that this problem is about offset or alignment
of some specific symbol(s). The remaining question is what symbols and
how to fix or workaround that.

Following dump change brings back lockups/hangs:

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index ee437af41..0a24dec55 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -1028,6 +1028,22 @@ static long mtdchar_unlocked_ioctl(struct file *file, u_int cmd, u_long arg)
  {
  	int ret;

+	if (!file)
+		pr_info("Missing\n");
+	WARN_ON(!file);
+	WARN_ON(cmd == 1234);
+	WARN_ON(cmd == 5678);
+	WARN_ON(cmd == 1234);
+	WARN_ON(cmd == 5678);
+	WARN_ON(cmd == 1234);
+	WARN_ON(cmd == 5678);
+	WARN_ON(cmd == 1234);
+	WARN_ON(cmd == 5678);
+	WARN_ON(cmd == 1234);
+	WARN_ON(cmd == 5678);
+	WARN_ON(cmd == 1234);
+	WARN_ON(cmd == 5678);
+
  	mutex_lock(&mtd_mutex);
  	ret = mtdchar_ioctl(file, cmd, arg);
  	mutex_unlock(&mtd_mutex);


