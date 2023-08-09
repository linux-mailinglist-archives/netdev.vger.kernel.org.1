Return-Path: <netdev+bounces-25645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAB3774FEC
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 02:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FDF11C2108C
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3EE36E;
	Wed,  9 Aug 2023 00:41:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09B182
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 00:41:16 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F481995
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 17:41:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-523643207dbso242430a12.3
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 17:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691541674; x=1692146474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53bleXI1rwMamZX0JWcAtU23Wr0BIzKJAx0qsLh8yXA=;
        b=P+2/9o3rsXDweHtlRPZzhxI1iPCzdYp9atAuwlSGbuCtNsTg5F1zH06KhH1cW5Xlyy
         /Km0R6yfUAhnTFrbOCO6sdKHEZ4Y7ljRokGXJXX5dDPTduAIQ8kNl2t+P4Ah84gbtO/1
         cQc0By1FBfOsuEQhzbEWjf6w5eXtd+aEcKNLed5lFmRBL3JXeXJOyvbfNoJx0YPfxghY
         k5AI//fgNi2wlHUiN/f2psVTQBNoVGHFqbdmYKRLu9cf3e6qVMd0KVS5KH74h8v/J9uu
         rv9niSeuRyxYyNwhuLqZZNqWMQ+pPiddBL/eualB55TM9RpcrqiCml9iYLd8BA6LSUmX
         K8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691541674; x=1692146474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53bleXI1rwMamZX0JWcAtU23Wr0BIzKJAx0qsLh8yXA=;
        b=BShvF79aWT+apwvRftpoAhaQrLZ4xRaW5cD1Jb7qoMDsn7yf5E/2gOVz3xVXyo6z6K
         nLzyVb2VTeXPwWrPlDNxV5BVaoAmRyn5EZaurKlJmvXET0sDzKB8JLlIjD/htEVEO0eQ
         Me1XbfgSLUfvuVrgMDdW2N413h+thX6kM5g5aL2YDgO5wThg8bJUFRlk7uExIYkp4iJJ
         3sOjYUYqQmNG03K10kZwZ2UzeMxWYx5FrjmwZaNIEno7HF9wH+gGubplJyOxv4skg02A
         33YS8oOxk09HF3GYfzLQPN4bpnWWlNbcV8myDfHcPjvmxJScLVZPNtoga9+pArkfMHef
         B0lA==
X-Gm-Message-State: AOJu0YwEeoRfNEiM5+cI1rQhy4j1wJf1KdFrKxTUMpj52hbg76/6aeVm
	hUuHaewk3FpSYQ1ub2EJXdw5O/y+IH/ZgaPzk2h3NQ==
X-Google-Smtp-Source: AGHT+IH+o2gQmZ+g2rXKzG+WrwjtCAkrRGG17r1COP/wNQau3mqxf/ssgwfBWD/6BXEh19oUwJIUMTL6DpaCyUXau/o=
X-Received: by 2002:a17:906:218a:b0:988:6491:98e1 with SMTP id
 10-20020a170906218a00b00988649198e1mr892372eju.42.1691541674457; Tue, 08 Aug
 2023 17:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230808-net-netfilter-v1-0-efbbe4ec60af@google.com>
 <20230808-net-netfilter-v1-2-efbbe4ec60af@google.com> <20230808234001.GJ9741@breakpoint.cc>
In-Reply-To: <20230808234001.GJ9741@breakpoint.cc>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 8 Aug 2023 17:41:01 -0700
Message-ID: <CAFhGd8r5LfczABYD3YNmbwH9tJtsr5MQNi6pUMLiZY3Qywo0kw@mail.gmail.com>
Subject: Re: [PATCH 2/7] netfilter: nf_tables: refactor deprecated strncpy
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-hardening@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 8, 2023 at 4:40=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Justin Stitt <justinstitt@google.com> wrote:
> > Prefer `strscpy` over `strncpy`.
>
> Just like all other nft_*.c changes, this relies on zeroing
> the remaining buffer, so please use strscpy_pad if this is
> really needed for some reason.
I'm soon sending a v2 series that prefers `strscpy_pad` to `strscpy`
as per Florian and Kees' feedback.

It should be noted that there was a similar refactor that took place
in this tree as well [1]. Wolfram Sang opted for `strscpy` as a
replacement to `strlcpy`. I assume the zero-padding is not needed in
such instances, right?

[1]: https://lore.kernel.org/all/20220818210224.8563-1-wsa+renesas@sang-eng=
ineering.com/

Thanks.

