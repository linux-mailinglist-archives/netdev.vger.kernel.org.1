Return-Path: <netdev+bounces-18033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F11B7544DC
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 00:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCBC2822C4
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 22:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BF51F196;
	Fri, 14 Jul 2023 22:13:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6B853AF
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 22:13:25 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A0D26A5
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 15:13:19 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbea14706eso22356595e9.2
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 15:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689372797; x=1691964797;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L5v8VFtOY2mWcmyxBNqOr6fZSWxPBCBJ3cTINEI8WBg=;
        b=uQ4aMBo0UASVqUYccVdK30s2SBfWWq+BrCGxGRaYHPcpFYdj2n5OcjhyN1prSX0wRq
         07nVEnKPvKko41wCTpZY7xSQLgZ1zFvnN3PfX6M6PBVC/ScYpe6PTDwdo3JZrbGBf1V0
         kKKH5qzfktWpPGwgHR6d4MjeWTmXm6KGyG4ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689372797; x=1691964797;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5v8VFtOY2mWcmyxBNqOr6fZSWxPBCBJ3cTINEI8WBg=;
        b=NguYsmazQ4leSlKJS0AvY2E/eFTf/KGSw/y6hni+1fJpeYaP82urRAP5ShWiIceqdn
         IHmoufsAbqXaFB1SEB/y3U6vRJFCnlQWDcxElPGpbADyZ/Gx+c/dINzcRXJOWxQqix9s
         c9Q9K4+Nl/uSHb7ra0sE5aPItFE6zEsYBKHuvhaRNlJGqUSnW/VWVz1nhQXMXUXKUaKn
         f0GRyOhBWclbbgI9XtJslC2z3ndyB8sb2B8crhC4KwmGMyhMzc6Z8TrSPtT8Zxsk6WGq
         243BW6jTjDWPdlWBTRR41a/3MkLvC3DkBdCtpTgSb+B49O9LV0gR2UABLF5t8NjfbuOI
         XiPg==
X-Gm-Message-State: ABy/qLbFt16TbYBf8PDaRbHxGoYVkdZHpqiE4tQI5Fd6d69IfZ77xgIM
	1JNZ/Q8sMcaXNzKD339OcuHRLfuw4uCV5+AL791EKlOnpqhinQMZbsc/aQ==
X-Google-Smtp-Source: APBJJlEkk+tnSdoILq0YfIepZCri3kvbgHrqj/Ppa/jYeFpBsi/aq2yoj3PziCnWCbxOJoDuq6txbaJhObTtzRmZJ70=
X-Received: by 2002:a05:600c:247:b0:3fb:b6fa:9871 with SMTP id
 7-20020a05600c024700b003fbb6fa9871mr4565416wmj.14.1689372797201; Fri, 14 Jul
 2023 15:13:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ivan Babrou <ivan@cloudflare.com>
Date: Fri, 14 Jul 2023 15:13:06 -0700
Message-ID: <CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com>
Subject: Stacks leading into skb:kfree_skb
To: Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc: kernel-team <kernel-team@cloudflare.com>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As requested by Jakub Kicinski and David Ahern here:

* https://lore.kernel.org/netdev/20230713201427.2c50fc7b@kernel.org/

I made some aggregations for the stacks we see leading into
skb:kfree_skb endpoint. There's a lot of data that is not easily
digestible, so I lightly massaged the data and added flamegraphs in
addition to raw stack counts. Here's the gist link:

* https://gist.github.com/bobrik/0e57671c732d9b13ac49fed85a2b2290

Let me know if any other format works better for you. I have perf
script output stashed just in case.

As a reminder (also mentioned in the gist), we're on v6.1, which is
the latest LTS.

I can't explain the reasons for all the network paths we have, but our
kernel / network people are CC'd if you have any questions.

