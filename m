Return-Path: <netdev+bounces-18750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFE4758888
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 00:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871F82817B1
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 22:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D11168BE;
	Tue, 18 Jul 2023 22:33:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A993317724
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 22:33:34 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC571BCF
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 15:33:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbd33a57b6so64655045e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 15:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689719597; x=1692311597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWsxvfQpzQNYgwAuo/YN24N7x+Xu3y1c37MMJZ8hh/Y=;
        b=PLt0DRpCK+s0cK2dWpH/V9U1IndhEc8+V18IkBkqG3JewqKGg8czNt/gLsxRzKZwId
         6IWc6errFw/cbrM5f+vIpqFNgCZfoKTXvDfHk1jI+Bd0FCtzMG7WKrlEAhN6ulIy5Rnj
         /0vAsArHQ+9PMGCrhhyXqPwS4DPscqtspup00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689719597; x=1692311597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWsxvfQpzQNYgwAuo/YN24N7x+Xu3y1c37MMJZ8hh/Y=;
        b=QcPK7iRYlD0SYWf3u5Q6/Ke27QPlQjtKqigfIzsp8E4SiM0dd28YKf5MI93p4x/fqO
         17Kqj9hf24ffRPIhJM2ECKfbOTtAQyHXErz1j5cLkrXBmdANqX4nPtQ4q/nP3/P6J9MU
         zpIduGk5XiazwY5YoIxF6JVQ13ZI3J+VPi3v8bD8ub/3vmbnZz/f1N9FR/M+s3VbpG9/
         hhkdiICv57EMGH+pRUxAfASahpKxw4o/B9vqy4Paon8eifvHcDv8yWCc3PzfVj/eykEg
         wxVqXTk9GCErkH9sqGjjZOz2Jgranwjf/CKcvUaqZm5ZbvmcmWifFrziF8ccEJO/bid3
         oNBA==
X-Gm-Message-State: ABy/qLb3PNenLr6P0LiVW9n7MkPyNnSnWWyxRlkZjMN6FhkHX2j9aB0n
	ducdcjRQRp0tod0ytZrMZ7ZR9h8YSj4UgJ5RKNDqEg==
X-Google-Smtp-Source: APBJJlE6Jh53bd2LtohbQvA7WeJ+HdQPtDH5hS98O+VH2Sl6hHAPuA8wyOYEMLqLvhpQVUr3k3HjHvZheKQXTxWPqfE=
X-Received: by 2002:adf:e4ca:0:b0:314:34da:f4d9 with SMTP id
 v10-20020adfe4ca000000b0031434daf4d9mr15931794wrm.42.1689719597239; Tue, 18
 Jul 2023 15:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWYdi00L+O30Q=Zah28QwZ_5RU-xcxLFUK2Zj08A8MrLk9jzg@mail.gmail.com>
 <e64291ac-98e0-894f-12cb-d01347aef36c@kernel.org>
In-Reply-To: <e64291ac-98e0-894f-12cb-d01347aef36c@kernel.org>
From: Ivan Babrou <ivan@cloudflare.com>
Date: Tue, 18 Jul 2023 15:33:06 -0700
Message-ID: <CABWYdi38H3umTEqTPbt8DftF2HXZ7ba6+jNphJdvubeh6PLP8w@mail.gmail.com>
Subject: Re: Stacks leading into skb:kfree_skb
To: David Ahern <dsahern@kernel.org>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 5:54=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 7/14/23 4:13 PM, Ivan Babrou wrote:
> > As requested by Jakub Kicinski and David Ahern here:
> >
> > * https://lore.kernel.org/netdev/20230713201427.2c50fc7b@kernel.org/
> >
> > I made some aggregations for the stacks we see leading into
> > skb:kfree_skb endpoint. There's a lot of data that is not easily
> > digestible, so I lightly massaged the data and added flamegraphs in
> > addition to raw stack counts. Here's the gist link:
> >
> > * https://gist.github.com/bobrik/0e57671c732d9b13ac49fed85a2b2290
>
> I see a lot of packet_rcv as the tip before kfree_skb. How many packet
> sockets do you have running on that box? Can you accumulate the total
> packet_rcv -> kfree_skb_reasons into 1 count -- regardless of remaining
> stacktrace?

Yan will respond regarding the packet sockets later in the day, he
knows this stuff better than I do.

In the meantime, here are the aggregations you requested:

* Normal: https://gist.githubusercontent.com/bobrik/0e57671c732d9b13ac49fed=
85a2b2290/raw/ae8aa1bc3b22fad6cf541afeb51aa8049d122d02/flamegraph.normal.pa=
cket_rcv.aggregated.svg
* Spike: https://gist.githubusercontent.com/bobrik/0e57671c732d9b13ac49fed8=
5a2b2290/raw/ae8aa1bc3b22fad6cf541afeb51aa8049d122d02/flamegraph.spike.pack=
et_rcv.aggregated.svg

I just realized that Github links make flamegraphs non-interactive. If
you download them and open a local copy, they should work better:

* Expand to your screen width
* Working search with highlights
* Tooltips with counts and percentages
* Working zoom

