Return-Path: <netdev+bounces-17378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD4E751667
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 04:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06D4281B14
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B736A;
	Thu, 13 Jul 2023 02:43:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93E97C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 02:43:46 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B47E7E
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:43:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fba1288bbdso365609e87.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689216223; x=1691808223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZbsg7ZRrrqBObmRQBVORF/Ql/2GsFEmO5ssSII3RHc=;
        b=RUpLiH+NZ5kW+xt5BZgJW/XlZMe5ZDORblGpIddVoU/ndInI3cAp4cXSNnFk99OF+M
         FX+dvM2WvqMDl+DahMoBnRwn2luRoxsY52IcPWv4pRbOUmvg+hZUnq55Z0F2zjJXjzac
         8DOMUMrGDiHr9oQv5jaCcNZUGSCeUq/RTEN5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689216223; x=1691808223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZbsg7ZRrrqBObmRQBVORF/Ql/2GsFEmO5ssSII3RHc=;
        b=CyCc+AYZcs8qJwsH+ErCTZmLRBvTOC+jbzkmBW+xRH5+ueEWYxlL9hb14OLJFsy1O5
         LA9TPwwDN8fqEk/I3sroVZ/D4p624Bp2FMWI0U1apV+R5JOAuQEO9JYYrL+FI77nxwU2
         Oxa28gg22MH6HMxNoktt/4qhjQlLLXp6PKff19UtQ7AcoW1oYNlgQVkQRK0wnkTzYUVL
         NiNW5QWpssSwpnoUGpEy4xqYQXMDZ3pKU+dClsaxFTq8IYQjucGfEEzPL7AsoxLviHBj
         l1gEXpZJRzQCcnrNzROab11ECTSv3jVkv3fKUB8X5bh85g2KtwCGfZGE8Bae3HvWzhuD
         bAFQ==
X-Gm-Message-State: ABy/qLYS8RCnhnYWkpO6BVRrfe7bWnDyasvNECe2Ta/zG9o06FxMMBr2
	qZSViHFQDQqRjykWGgkfpX/bXdZ/hGtGpw4wKjDQ0P1TO8Ke0LJWR+s=
X-Google-Smtp-Source: APBJJlHzJTiOMDWKfml2hr3byYUAUNS3gAF4xGhcgSFBniRgKe3QbH2vHjtMZUo0Oakz6OyMyNC4x4zguuMI5FrLksQ=
X-Received: by 2002:a19:700e:0:b0:4fa:e7e5:66e0 with SMTP id
 h14-20020a19700e000000b004fae7e566e0mr42962lfc.48.1689216223539; Wed, 12 Jul
 2023 19:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711043453.64095-1-ivan@cloudflare.com> <20230711193612.22c9bc04@kernel.org>
 <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com> <20230712104210.3b86b779@kernel.org>
In-Reply-To: <20230712104210.3b86b779@kernel.org>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 12 Jul 2023 21:43:32 -0500
Message-ID: <CAO3-PbqtdX+xioiQfOCxVovKVYUgXkrmsfw+1wTYoJiAq=2=ng@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for tcp_listen_queue_drop
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ivan Babrou <ivan@cloudflare.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 12:42=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 12 Jul 2023 11:42:26 -0500 Yan Zhai wrote:
> >   The issue with kfree_skb is not that it fires too frequently (not in
> > the 6.x kernel now). Rather, it is unable to locate the socket info
> > when a SYN is dropped due to the accept queue being full. The sk is
> > stolen upon inet lookup, e.g. in tcp_v4_rcv. This makes it unable to
> > tell in kfree_skb which socket a SYN skb is targeting (when TPROXY or
> > socket lookup are used). A tracepoint with sk information will be more
> > useful to monitor accurately which service/socket is involved.
>
> No doubt that kfree_skb isn't going to solve all our needs, but I'd
> really like you to clean up the unnecessary callers on your systems
> first, before adding further tracepoints. That way we'll have a clear
> picture of which points can be solved by kfree_skb and where we need
> further work.

Those are not unnecessary calls, e.g. a lot of those kfree_skb come
from iptables drops, tcp validation, ttl expires, etc. On a moderately
loaded server, it is called at a rate of ~10k/sec, which isn't
terribly awful given that we absorb millions of attack packets at each
data center. We used to have many consume skb noises at this trace
point with older versions of kernels, but those have gone ever since
the better separation between consume and drop.

That said, accessing sk information is still the critical piece to
address our use case. Is there any other possible way that we can get
this information at the accept queue overflow time?

--
Yan

