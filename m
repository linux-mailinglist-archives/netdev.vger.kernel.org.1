Return-Path: <netdev+bounces-24890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA69F772001
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 13:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EA41C20839
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 11:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E3BD307;
	Mon,  7 Aug 2023 11:13:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A7CD50B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 11:13:05 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882961FD0
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 04:12:23 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bba9539a23so9296595ad.1
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 04:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691406712; x=1692011512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubpyp4SIhGXjO6/VTKiZvWjlRzyN8ANvKHVN5xSGnIw=;
        b=G6tJn+16QVti2qtu2hqYljseIE/XGpe1Yhsul4LFU6R/aCDAM7lceOlES83Z0B/Pue
         2irlih/PCzGRhADqlmxdT4ZmTPg/rDw2XT4QeZKx/Tui9xhVWAtyJogqiocaYi2mPJVJ
         JfsH0RSoKbpVavaYBWWtyo/mJh8W+H0WFTE4SVefHn6UoqHLIS8l90Z//i2iVib88cLh
         SO8x9HJ9eijOF2Obr6A8OaZNG3N0xetNtsejNB5r0CVLeObeV8ZzJa8r4m2G8/H610tO
         JRFiieD8eIQL4G+uzuFBv5AMDY6TbkMqFwB+fegzuV4xQGReerwz1d1NP8JNZHZ17Zsd
         g+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691406712; x=1692011512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubpyp4SIhGXjO6/VTKiZvWjlRzyN8ANvKHVN5xSGnIw=;
        b=UGjVSTAPLBI4pxTW4tkQR7QdZNbqpLNLewyvgigw3gxrLGgOigere9FXVePBcRRLhf
         79TcwOjX99L23ZS3kwPq60ZRHkR1nMBPfcBWjAhw5XIAa+4nM4kG3kVwdLS5NrMzC1UV
         /g9fogeI6Q7BYfINugoPHe/l2TzNy4JG3cUvaBbxV5IHjuMhrib3kTMmLOixqhmeVRnQ
         Zqv+uJ+qx2wKBoN1KRAZtDG3eCVEk9iMYRC9uvYaxS7J530wFF1UXyJWb4mH9QUqZ8bR
         XTqzgu/EKUQM5vNyaiz36RAzPV6JZ1snFeYVVJXPDCk+hvk60ynNmy++pGgQgVjwc6ra
         Muew==
X-Gm-Message-State: ABy/qLbsdKFWHx41hOJ1xHuKaxFMq4jm6tZGmYGGWSwmJ3WY4UAv22IA
	eBtFuqbBNk1g+IpnHfHWsVNzoQ==
X-Google-Smtp-Source: APBJJlGAdl0ewhYUg6UhJdRJKXIwq0U3XoR/AJshcbF16xE0A4mgQC4Umc8PgwnpC/Hq6tl8ikCZEw==
X-Received: by 2002:a17:902:ea04:b0:1b8:17e8:547e with SMTP id s4-20020a170902ea0400b001b817e8547emr32460173plg.1.1691406712196;
        Mon, 07 Aug 2023 04:11:52 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:11:51 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: akpm@linux-foundation.org,
	david@fromorbit.com,
	tkhai@ya.ru,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	djwong@kernel.org,
	brauner@kernel.org,
	paulmck@kernel.org,
	tytso@mit.edu,
	steven.price@arm.com,
	cel@kernel.org,
	senozhatsky@chromium.org,
	yujie.liu@intel.com,
	gregkh@linuxfoundation.org,
	muchun.song@linux.dev,
	simon.horman@corigine.com,
	dlemoal@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-erofs@lists.ozlabs.org,
	linux-f2fs-devel@lists.sourceforge.net,
	cluster-devel@redhat.com,
	linux-nfs@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	dm-devel@redhat.com,
	linux-raid@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 09/48] erofs: dynamically allocate the erofs-shrinker
Date: Mon,  7 Aug 2023 19:08:57 +0800
Message-Id: <20230807110936.21819-10-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use new APIs to dynamically allocate the erofs-shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/erofs/utils.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index cc6fb9e98899..6e1a828e6ca3 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -270,19 +270,25 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 	return freed;
 }
 
-static struct shrinker erofs_shrinker_info = {
-	.scan_objects = erofs_shrink_scan,
-	.count_objects = erofs_shrink_count,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *erofs_shrinker_info;
 
 int __init erofs_init_shrinker(void)
 {
-	return register_shrinker(&erofs_shrinker_info, "erofs-shrinker");
+	erofs_shrinker_info = shrinker_alloc(0, "erofs-shrinker");
+	if (!erofs_shrinker_info)
+		return -ENOMEM;
+
+	erofs_shrinker_info->count_objects = erofs_shrink_count;
+	erofs_shrinker_info->scan_objects = erofs_shrink_scan;
+	erofs_shrinker_info->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(erofs_shrinker_info);
+
+	return 0;
 }
 
 void erofs_exit_shrinker(void)
 {
-	unregister_shrinker(&erofs_shrinker_info);
+	shrinker_free(erofs_shrinker_info);
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
-- 
2.30.2


