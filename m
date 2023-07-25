Return-Path: <netdev+bounces-21104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51206762771
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 01:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0164C281B53
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 23:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F24727730;
	Tue, 25 Jul 2023 23:35:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AA48462
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 23:35:24 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD2D2125
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:35:23 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55c79a5564cso2609247a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690328122; x=1690932922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IGwj85fHRecLytFaGyTYqu/ejgCMxvOPzZqFMwTxEcA=;
        b=KfB2U5WeI52KBJmmdFsM/Ui/u5bBT+VfG3ilLH8fgt3usGD5fViOzvdL7DEMBzmXoA
         pcTBlUUsta3Mz3wXukZRvCBqnolUJqLj5CeFz1pmBh4f73T/KoOa8CfqC0JCZEU9ktfq
         zFagCO7NrMGbqROiJ+ZwUYmG5DccFwkKgf8NFzKvRf7ifw/ifXKg3nDjW9SmHsOd1pgr
         IZnWKoqc+mXFoYuK8c7pCO/urUtc1kyIM7m2F4ez11u7cTppCaRJT1KhCxHBw2UHMeSB
         f2X8gJj/m+g/WsfeFGSaPJEdz6nBx6xn0k6iNAghCdOmM57BCUzQyy27eIcyAniEZFuc
         VNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690328122; x=1690932922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IGwj85fHRecLytFaGyTYqu/ejgCMxvOPzZqFMwTxEcA=;
        b=kBDIH4M6MMYxesASwER3VuFSJ9752Qt1bPHP8CbA/leK+UOV1kOdAyxLOmJTdd0pbm
         C+x578/DplbCLiTsffSRnnmqMN7WTe+8Go0FJxliytjD0CtWsYLYQK2MzSvxmI30+dZ6
         Xbaj7uYM/6LtVD25ewyTtPKcUCIk5HHpXQzOIXlMk2XWnxcEKpE/P1Ns3aivF9fiY4uS
         7WosKUVRlLvHavAhRgkGcnktCRWssJJaJ3ZKn3i/IrYXxSUs/pF7/tDlPLtCOONQ9nlF
         Wu1sI0lPE+YyG5YplIMuZG4qL2ERz1e9D5LXoA0GaNTheclXFgtM8cTPyYo4hTnQu7rO
         casQ==
X-Gm-Message-State: ABy/qLauVfMWBDir/p62ngKyp/5Vyu5kcJerswkRmxkeshiP9xCpRVCP
	VAyIf6CwN2Rny4d6gZA+N+Wt4WF6NWzI795z4MuYS/Kd8bPFqBg9Wc6j/WhcEbA0zN5MN6WfXxU
	Y8VsYq45av/whcIdsvxeqKvHIM8VZoWkWeukZSqVSC+6OMJ16wBXhhQ==
X-Google-Smtp-Source: APBJJlG54qUnzSb7EGNXlz3j2lXDsmQAuIR0VJK/FthrK9AeONy91XGSInyQsco3Ztgiw//sCy6SJ1M=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:7b0f:0:b0:560:63a2:d39e with SMTP id
 w15-20020a637b0f000000b0056063a2d39emr3285pgc.0.1690328122438; Tue, 25 Jul
 2023 16:35:22 -0700 (PDT)
Date: Tue, 25 Jul 2023 16:35:15 -0700
In-Reply-To: <20230725233517.2614868-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230725233517.2614868-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230725233517.2614868-3-sdf@google.com>
Subject: [PATCH net-next 2/4] ynl: mark max/mask as private for kdoc
From: Stanislav Fomichev <sdf@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simon mentioned in another thread that it makes kdoc happy
and Jakub confirms that commit e27cb89a22ad ("scripts: kernel-doc: support
private / public marking for enums") actually added the needed
support.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/net/ynl/ynl-gen-c.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 71c5e79e877f..0112722fcc37 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2124,6 +2124,8 @@ _C_KW = {
                 cw.p(entry.c_name + suffix)
 
             if const.get('render-max', False):
+                cw.nl()
+                cw.p('/* private: */')
                 cw.nl()
                 if const['type'] == 'flags':
                     max_name = c_upper(name_pfx + 'mask')
-- 
2.41.0.487.g6d72f3e995-goog


