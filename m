Return-Path: <netdev+bounces-21106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AC9762774
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 01:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E721C20F56
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383282AB23;
	Tue, 25 Jul 2023 23:35:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9328462
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 23:35:30 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB19213C
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:35:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5840614b107so27366237b3.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690328126; x=1690932926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7VDndtUhTmjZhFwzFz2FDQYmgm5v0x87/y1zJ2WzSNM=;
        b=iPm678ls4yjZB+VZaqhzezPsLnVigGxTOJ1cO84MW0QvJFaYUqn8iTSrkOt0IeXiwg
         BU7wQLMcfWg7vYoGSaN0uPvXhyv985ATbA1zXBYfvBMhy76V1afGJrCmzBbo72Bj+OT4
         VHT29N/3MJw043NA25EJSeVk2JA6pj8CTQah/B2gMzMYWRzbLKNkJPA1GaNtfHaxWtvq
         xPEJmDXyxMcHqLUMKCWB/gJI89N+MUPHbrFLLXcCxHTnNrbEEScbt7ur5EKKhMRQKI7a
         Aa7VuKu+cgO7/ed67I993Vv/Sy3yxZJ6MK4g7Fo1qonsSFSU+kSsZTo+Y4hok7CGZx5n
         RU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690328126; x=1690932926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VDndtUhTmjZhFwzFz2FDQYmgm5v0x87/y1zJ2WzSNM=;
        b=X8zGDzk7oyDhhtACQzaeXBTdwjFzU5Sopw3RrxasefMLBjI0K94k37JF4pvkGTkjZ/
         4oXmZnr4uVuxKYL5QPafDQujFVy6MZ96UqBNbipCfNV3rYcjDwTImd6g09wrsN9W/5q6
         E93cCgxJdpjfkZH54MXFFPewiz39e0DRz0C3KDSIeuNSEUy805R9Bf7hfube4L+oKSd7
         IbnEXZhjik0HRF4onxbv3Ny+M6OoB0IWwRWNS6tjURItWe8G+0NabBU12EXWwqbbDLa6
         4y7aUA0ziBVMy/Q8/kT6yhyRvjT6D8CawXfMTbYWiqAHeQVxNEai1CUERLAcDgdUKbRS
         x89g==
X-Gm-Message-State: ABy/qLb9jiN6f0+MdY/P8yFmX7dic1prjR1UsMxBN7MCYK4dFrIj7nMN
	o1R4YbF+Ug1r/fnO0RG+UkFcw/DD2SH1DoOlXPAnsoqDQKKdHgxc/BQrvxlR0589B5+ebRrgv/v
	v0rFPjaI52WsoWzP1A2BagFU/kQzkBwa7FL1XwnFwc/Hpxw5ZoerAWg==
X-Google-Smtp-Source: APBJJlEOoqTbeWvN7Fh7sHgKSUiVp2bhzEna/PzsGrrIY3s13rkSLfjnWHzv71Ly8TNokJdpNwFdVO8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:aca4:0:b0:d00:a25a:1a54 with SMTP id
 x36-20020a25aca4000000b00d00a25a1a54mr2795ybi.11.1690328126144; Tue, 25 Jul
 2023 16:35:26 -0700 (PDT)
Date: Tue, 25 Jul 2023 16:35:17 -0700
In-Reply-To: <20230725233517.2614868-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230725233517.2614868-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725233517.2614868-5-sdf@google.com>
Subject: [PATCH net-next 4/4] ynl: print xdp-zc-max-segs in the sample
From: Stanislav Fomichev <sdf@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Technically we don't have to keep extending the sample, but it
feels useful to run these tools locally to confirm everything
is working.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/net/ynl/samples/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/samples/netdev.c b/tools/net/ynl/samples/netdev.c
index d31268aa47c5..06433400dddd 100644
--- a/tools/net/ynl/samples/netdev.c
+++ b/tools/net/ynl/samples/netdev.c
@@ -38,6 +38,8 @@ static void netdev_print_device(struct netdev_dev_get_rsp *d, unsigned int op)
 			printf(" %s", netdev_xdp_act_str(1 << i));
 	}
 
+	printf(" xdp-zc-max-segs=%u", d->xdp_zc_max_segs);
+
 	name = netdev_op_str(op);
 	if (name)
 		printf(" (ntf: %s)", name);
-- 
2.41.0.487.g6d72f3e995-goog


