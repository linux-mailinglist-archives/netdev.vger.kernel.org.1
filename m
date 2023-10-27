Return-Path: <netdev+bounces-44790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8F37D9D71
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 17:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2445E2820DB
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 15:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67F4381C1;
	Fri, 27 Oct 2023 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="GJAsLf53"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEB3381CD
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 15:50:49 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CECCE
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:50:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc1e1e74beso8161525ad.1
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1698421848; x=1699026648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwJo6wJzU0SRc3WR8d3+c2RWNH/91YoR9PnRGDnedsU=;
        b=GJAsLf5323OcGUXTUpXomLB53bu+ZPWY/LDZTjf5n6toRvEpfxvXKajDHtkLrt7HBJ
         CwrWukz7vxjrj7PM3uz16KDbl54xJUGX4CymeplgBWBadt5MImi/papQbvw0PDebKBYw
         I8/5YJBj4/41fwFTgZpS4DpjNwZwEG90yl92BeivZsDchT3+BdxzRVu3BJPJOf4b7IuW
         oujpKE8+gC472ZYsXkj9Dng/OGFpzVCXjHhMdkFCjQIhtsHMMZJVgKjRweJS6pGfC25K
         phczsww1fx4IjY6mwPiodn3B8CxMBLHSyTL4reJR2OsuCipZlPu5un9YPe/6e7lf/dij
         eczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698421848; x=1699026648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwJo6wJzU0SRc3WR8d3+c2RWNH/91YoR9PnRGDnedsU=;
        b=qELBqWDXFqzkjCSQoWGILCVGmJJEk+AO1Qlcafe2xirrT2EtLdFIuAFem9KSDdfoKw
         PDaUWrL6p4w0386oo2cS1VirTiJ7wqxMAp/CorXT4vS1bzB/8FyhDqeJzVptZTXnvJLG
         r+rhWzgJwAbkF9xeKqnElYI5ZWwTSzpJVPTeSI/gpEbswCf14/xuPRDlzq9qM7Ypswkk
         9hsO0MHMrEWd4jCGiQGx3L0v/Sz3G1JFW4d9uq0BWYDJvFswH8vHGu8w15g6P90NWb/x
         4xZaCyandGGOzQz5cUzXgU7MmJJGF0AWu+y03PHenQ1OKnQNTvn1zRLrnWKsJTUKqEeX
         wTSg==
X-Gm-Message-State: AOJu0YzqYCdJVIH8o9bMixwJTvdc6/fPdyu8OmYlsNY19rdJb5vnAo1W
	0wcZhJhFHXghlwJROlxxl9zWOw3X5SB2/17lPy1xjh0S
X-Google-Smtp-Source: AGHT+IE0NPwMYxK7S7+eqeGaCM1umvx3j6NaeCmeyetzzFvTH1TuC8GApd+gRqIsToQQ7ILLxGDrsg==
X-Received: by 2002:a17:902:fa8d:b0:1c5:cbfb:c166 with SMTP id lc13-20020a170902fa8d00b001c5cbfbc166mr2705691plb.37.1698421848358;
        Fri, 27 Oct 2023 08:50:48 -0700 (PDT)
Received: from localhost.localdomain (S0106e0553d2d6601.vc.shawcable.net. [24.86.212.220])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f54f00b001c726147a45sm1730224plf.190.2023.10.27.08.50.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Oct 2023 08:50:47 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	vinicius.gomes@intel.com,
	stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: [PATCH net-next 1/3] net: sched: Fill in MODULE_DESCRIPTION for act_gate
Date: Fri, 27 Oct 2023 08:50:43 -0700
Message-Id: <20231027155045.46291-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027155045.46291-1-victor@mojatatu.com>
References: <20231027155045.46291-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().

Gate is the only TC action that is lacking such description.
Fill MODULE_DESCRIPTION for Gate TC ACTION.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com> 
---
 net/sched/act_gate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index c9a811f4c7ee..393b78729216 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -677,4 +677,5 @@ static void __exit gate_cleanup_module(void)
 
 module_init(gate_init_module);
 module_exit(gate_cleanup_module);
+MODULE_DESCRIPTION("TC gate action");
 MODULE_LICENSE("GPL v2");
-- 
2.25.1


