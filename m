Return-Path: <netdev+bounces-24349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CECF76FE5E
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 12:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E4C2825AC
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0098CAD33;
	Fri,  4 Aug 2023 10:24:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F6DA946
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:24:21 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B642118;
	Fri,  4 Aug 2023 03:24:19 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b974031aeaso29675181fa.0;
        Fri, 04 Aug 2023 03:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691144657; x=1691749457;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+5Eyds8AZOTIj7eaREkCJcNrdRKcn3mEpCyJAFE/k2o=;
        b=W2LLr/3DA539SuI2hMrjowb+HwvAs5rNWNx98+bCzT/02iOuwPjKE4M07arYKgcsi7
         k0cYuPim2XRMEfvnCUIZPNOfxFNLbuuPR6KX0N/pX3wCMhCGA+4wlA7JjGQxM3GJT87j
         hXOUSBVxIQHbFWyjoaIYlEJ7gFifMCKyhWNz3AZ+OINpPDJpX8BKxP2aFJYeBzQG3J8T
         uDAi+NB46aFh52jvTgGC6xc/t367BHSOSFqbRrzRcz2fWJqA4CIHvipC9sK2CfV02iyn
         mV4X3gL1dE2k/CyEDYZ4APJp9p6eecQXRwRGcq1ukLj7LTH+zKbGZKNc8KJqGHWJw/K1
         PVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691144657; x=1691749457;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5Eyds8AZOTIj7eaREkCJcNrdRKcn3mEpCyJAFE/k2o=;
        b=R6hhlLM1p/sbySym6MV4xoeQIJJ76Y0JLw1jAvryTOJRfdOn+2ceNZ9OUbS8IyJX50
         uMfQBGpatOZtrA6AUoCHxKZvvmktJyMvdGH7vsPkjLGQIB8t/+jc2FTzSGce3PAlM7XD
         uaXkHLSoHBlt/PmioA5YacoVunu6gYCN0OT/8eDDhcHaoeLPdlAWuRl1M12NgKr8AXs5
         51/1MJTr6S1ShNCOOQN/DaFUF7LZvZaiIKuav5y2BjUFdAyAlKM3BItw4R+Xch2I/f/l
         iRGqBow5YDR7FXKPAFckXF8XjBs9wBN+WIS8i9TbM5AOQg0r5nTm0d8x6uRZAvG/CohO
         FfIQ==
X-Gm-Message-State: AOJu0Yy2NXWxoitoH8PFQsQgsVNim/NqpoO7MW2vfvmpWPamp82K4AfY
	X7q4AjTs8pPHZbINIO/9WiY=
X-Google-Smtp-Source: AGHT+IHO1gQu885p8yGW8WtJQSum+ZZNaqje43m9tQFcfdVHopqpLFBIWr7JgK1jWKtK1ZoU2wtEXg==
X-Received: by 2002:a2e:9819:0:b0:2b8:36d4:7b0a with SMTP id a25-20020a2e9819000000b002b836d47b0amr1408664ljj.29.1691144657060;
        Fri, 04 Aug 2023 03:24:17 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id u21-20020a2e8555000000b002b6ece2456csm389393ljj.121.2023.08.04.03.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 03:24:16 -0700 (PDT)
Message-ID: <f46c3c30-77f9-b4fa-74fc-314b042ab82d@gmail.com>
Date: Fri, 4 Aug 2023 12:24:15 +0200
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
Content-Language: en-US
In-Reply-To: <CACna6rxpzDWE5-gnmpgMgfzPmmHvEGTZk4GJvJ8jLSMazh2bVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2.08.2023 00:10, Rafał Miłecki wrote:
> Reverting that extra commit from v5.4.238 allows me to run Linux for
> hours again (currently 3 devices x 6 hours and counting). So I need in
> total 10+1 reverts from 5.4 branch to get a stable kernel.

I switched back to OpenWrt's kernel 5.4 and applied all those reverts I
found. Nothing. I was still getting hangs / lockups + reboots.

After more bisecting and I found out it's because OpenWrt backported
commit ad9b10d1eaad ("mtd: core: introduce of support for dynamic
partitions"):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ad9b10d1eaada169bd764abcab58f08538877e26

It didn't make any sense to me. That patch does nothing on my device and
its code is only executed when booting.

It makes even less sense to me. Why such changes that should not affect
anything actually break stability for BCM53573?

I narrowed above patch even furher. It's actually enough to apply below
diff to break kernel stability:

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index f69c5b94e..f10dd3af1 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -590,6 +590,25 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
  	return 0;
  }

+static void mtd_check_of_node(struct mtd_info *mtd)
+{
+	struct device_node *partitions, *parent_dn;
+	struct mtd_info *parent;
+
+	/* Check if MTD already has a device node */
+	if (dev_of_node(&mtd->dev))
+		return;
+
+	/* Check if a partitions node exist */
+	parent = mtd_get_master(mtd);
+	parent_dn = dev_of_node(&parent->dev);
+	pr_info("[%s] mtd->name:%s parent_dn:%pOF\n", __func__, mtd->name, parent_dn);
+	if (!parent_dn)
+		return;
+
+	of_node_put(parent_dn);
+}
+
  /**
   *	add_mtd_device - register an MTD device
   *	@mtd: pointer to new MTD device info structure
@@ -673,6 +692,7 @@ int add_mtd_device(struct mtd_info *mtd)
  	mtd->dev.devt = MTD_DEVT(i);
  	dev_set_name(&mtd->dev, "mtd%d", i);
  	dev_set_drvdata(&mtd->dev, mtd);
+	mtd_check_of_node(mtd);
  	of_node_get(mtd_get_of_node(mtd));
  	error = device_register(&mtd->dev);
  	if (error) {


