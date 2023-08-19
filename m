Return-Path: <netdev+bounces-29138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E333781B4A
	for <lists+netdev@lfdr.de>; Sun, 20 Aug 2023 00:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308EE28109E
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 22:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C54FA94D;
	Sat, 19 Aug 2023 22:40:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA9C367
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 22:40:14 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CA71FB86B;
	Sat, 19 Aug 2023 11:28:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6887c3aac15so1860233b3a.2;
        Sat, 19 Aug 2023 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692469685; x=1693074485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV81kcD9vzqzEmQhBftWFfOiwm9XqB0HTp7lUGKFHuQ=;
        b=VYLM6eGJKRGVhn2Ekxvmmk/IxAN5ZqHbANxjoPuznd3ND4PNVXNbtT8ZOexZ9dcdIs
         l5NK7l8KaLF2I0LZ/oFlo9HP3KbdO4MBVwxU5SQk/yrGHsXxm1VJsqpYd2fDYj1RRidV
         grAW5a+GIMdE6PwljrNcNYrfPGEWa+vFYXr9sn0v8TJVb8xakHlcH433M5AjsyFRHXap
         bg+ZoGJHqoPiuUwhTaWfgEC2wNNvS1mAJdEaj5Wo8Z+nOd42uZFqykKZFoaOGoD1XBYy
         /txmBbFuxzLT/FYePrjUEIbnN1jyALIGgAvaKnCFUsuHThsANFW6qGDkwFf9LTAWBpQz
         BXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692469685; x=1693074485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lV81kcD9vzqzEmQhBftWFfOiwm9XqB0HTp7lUGKFHuQ=;
        b=lKQiys9uf2G2N3it4N1FeMtnZpm2nf5QlqoSc3Nnrs48HPRIbopxp9H6iD2Dxos4D3
         UexDA7tG4o/4mIPJplpclPtj+I46QHDeMCiUBURLuxuXdS/6Qgg8S3BJC3oOPEIeMHlL
         7gqYVshupMyvgRlB6CAkElABr+hgAiQZ18L7bnicOPED1dZw5yRy+oznxDONREoEG+VO
         GBiLUDYszP+UW380E/XLLi8V94J7xD+ly9m38FDWAT/nbZvXi/JKL6QxuIC7LKQrAR2b
         jGmmfgWppT6BxjXahBGWGgnTLme+ADSfRGrrBqdPjfgh4UQRwT6xvgShmA+o2sscap7+
         y3pg==
X-Gm-Message-State: AOJu0YzeYyrfJE5iKRFl0heaJoR5JPYr8rqFM9it8IwjK5Sv5Xfn8hVA
	MNNgklYjOK9OM4OI42+/jtE=
X-Google-Smtp-Source: AGHT+IEmPsxqkWPlrcjuJvptns5x3p1VIrYcf/FJ+r5YwMaev10rG6h9Gg+q8okY9eKsmQQudhk9FA==
X-Received: by 2002:a05:6a20:548f:b0:143:4382:f836 with SMTP id i15-20020a056a20548f00b001434382f836mr3155486pzk.14.1692469684798;
        Sat, 19 Aug 2023 11:28:04 -0700 (PDT)
Received: from DESKTOP-7B1REV8.localdomain ([2001:569:5755:c600:f49d:4018:e752:1f22])
        by smtp.gmail.com with ESMTPSA id e4-20020aa78c44000000b00682af93093dsm3464266pfd.45.2023.08.19.11.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 11:28:04 -0700 (PDT)
From: Qingjie Xing <xqjcool@gmail.com>
To: edumazet@google.com
Cc: davem@davemloft.net,
	dhowells@redhat.com,
	fw@strlen.de,
	johannes@sipsolutions.net,
	keescook@chromium.org,
	kuba@kernel.org,
	kuniyu@amazon.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	pctammela@mojatatu.com,
	xqjcool@gmail.com
Subject: Re: [PATCH] netlink: Fix the netlink socket malfunction due to concurrency
Date: Sat, 19 Aug 2023 11:24:36 -0700
Message-Id: <20230819182436.2369-1-xqjcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANn89iJCDYteM_1SQ-h2=htUAE4FqrBAak0kHt_Z990XYZThzQ@mail.gmail.com>
References: <CANn89iJCDYteM_1SQ-h2=htUAE4FqrBAak0kHt_Z990XYZThzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This piece of code has been present since the Linux code v2.6.12 was
incorporated into Git management.
I believe this modification could potentially address the concurrent issue
we've been discussing.
In netlink_rcv_wake(), as described in [2], the socket's receive queue is
empty, indicated by sk_rmem_alloc being 0. At this point, concurrent
netlink_attachskb() calls netlink_overrun(). In this critical state, the
sk_rmem_alloc of the socket will not instantly transition from 0 to a
value greater than sk_rcvbuf.

