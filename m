Return-Path: <netdev+bounces-36988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E377B2D70
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 10:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 541CA282B99
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 08:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76885C2DB;
	Fri, 29 Sep 2023 08:04:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2235C2D7
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 08:04:21 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739771A7
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 01:04:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9b29186e20aso1114870066b.2
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 01:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1695974659; x=1696579459; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=3BtaexmYkjplHFsMDid295szgBs8UBajcfrSgOPKauc=;
        b=IVP9t89Nf76gDoh7u+xZh07O4jTFUwkY2WQSrtrT4JrNyeQtCcPoiHSyTJO/wUlCzL
         slP8mQ5blwFjSvpKqJEAUmjL/FU6q+5TgCBI1Fp5vFEQAHY+WVjMMbbXOlMr80QFpPxy
         q+9pfs8cUTA++ou50tavq4h1E6MUNEUNylYbiKioFn0ZsRahmkFcZFwdp/tS4CNuw8UE
         kh3r6DTwc+BXzDkeoiLIsATcwwUCYbFsXlHRXG1TMoO2dzDaZp+rrPwUqcQCnnwDGXFv
         esalcC9l8EnnSKSU0CEdiPQ8vv+/qdzXKoyHnEY+XpEzucngtf/bbIsoGvtcON9EcYzq
         AXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695974659; x=1696579459;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BtaexmYkjplHFsMDid295szgBs8UBajcfrSgOPKauc=;
        b=HVkF1btDhFQ7nAePXBVngvjUdA386SGlUN+bnRNoq5P0dwoVHfA6+/T1Han8R1SmA9
         EryjS3eBbS/V02/ZOYkBgb2jlKh65wimrLzlg0XQbv56a8hBOfpMScB9d2JRAeKdNIj5
         X+B2cfWLP9/IleL+OYNpJ+on3jMav1tHsa/q88qAznFtD9cUsGgGbXlEzv7IOfTrTvRi
         ykX5ilNTg73N0snIyU71KbN2TtCMB3KmMunMfWjYx0mf0Ru3dugUYmtG71uHDCO1w0mg
         Yjb5fq4rLSAoDarLFxxZZ+RWmtOAUrD9uw6bMryFaX6k69f8HWz3ofxfKzHVKVS3P2FL
         4tiw==
X-Gm-Message-State: AOJu0YwB6UoWxvWj+nJpyNQAZEuAAEuI3Q/PQ1mi+RXib/NKCAE2G9b/
	a+EttOqPpd32afBp5B37Bg6V/A==
X-Google-Smtp-Source: AGHT+IHxRPKLDiFlVladtRrAPh0tbXcK+zBdKj2xQlR2G4AeFCg5MSNU/8Zt/FN1IsWIizJP09+/qQ==
X-Received: by 2002:a17:906:3116:b0:9ae:3c6c:6ecd with SMTP id 22-20020a170906311600b009ae3c6c6ecdmr3369888ejx.19.1695974658919;
        Fri, 29 Sep 2023 01:04:18 -0700 (PDT)
Received: from cloudflare.com (79.184.153.47.ipv4.supernova.orange.pl. [79.184.153.47])
        by smtp.gmail.com with ESMTPSA id kg28-20020a17090776fc00b0099b921de301sm12049940ejc.159.2023.09.29.01.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 01:04:18 -0700 (PDT)
References: <20230926035300.135096-1-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, edumazet@google.com
Subject: Re: [PATCH bpf v3 0/3] bpf, sockmap complete fixes for avail bytes
Date: Fri, 29 Sep 2023 10:02:55 +0200
In-reply-to: <20230926035300.135096-1-john.fastabend@gmail.com>
Message-ID: <87fs2xflrw.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 08:52 PM -07, John Fastabend wrote:
> With e5c6de5fa0258 ("bpf, sockmap: Incorrectly handling copied_seq") we
> started fixing the available bytes accounting by moving copied_seq to
> where the user actually reads the bytes.
>
> However we missed handling MSG_PEEK correctly and we need to ensure
> that we don't kfree_skb() a skb off the receive_queue when the
> copied_seq number is not incremented by user reads for some time.
>
> v2: drop seq var in tcp_read_skb its no longer necessary per Jakub's
>     suggestion

Credit goes to Simon Horman.

> v3: drop tcp_sock as well its also not used anymore. sorry for the extra
>     noise there.
>
> John Fastabend (3):
>   bpf: tcp_read_skb needs to pop skb regardless of seq
>   bpf: sockmap, do not inc copied_seq when PEEK flag set
>   bpf: sockmap, add tests for MSG_F_PEEK
>
>  net/ipv4/tcp.c                                | 10 +---
>  net/ipv4/tcp_bpf.c                            |  4 +-
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 52 +++++++++++++++++++
>  3 files changed, 57 insertions(+), 9 deletions(-)

For the series:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

