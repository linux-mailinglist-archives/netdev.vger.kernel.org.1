Return-Path: <netdev+bounces-38306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1B37BA285
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 17:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C27B1281822
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3905330D07;
	Thu,  5 Oct 2023 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dxu22BPf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B97B200AE
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 15:40:06 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E52B34418
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 08:40:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-27758be8a07so875537a91.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 08:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696520404; x=1697125204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yf+AiQkBJuLFlOTFx5Each8LtFYadlmD+9qdSbBgp1k=;
        b=Dxu22BPf/VhJQLxWqoW+yqBqTBZL5FMXiwlhCiEMuENQTbip8WnpvlRwRwJLtn1w8l
         culwvpxpaKPkx0wIV5ymkUnsdHrphYixm7+OTHc7ZDrDA1sPVWHsKgoy17Pv57BZ7UNb
         q0Vh+chub7cRWCl31jNc//DJNrW2n89QuNYQu1qyphgcyNsH7rfr8fCud6kBelLBUOgq
         tlgE4AJNAxoBliDsqG7HEj5mAG4XypYrWkEEYYkIiL3Iipg9cE9LZTetJbfUw6CUlXpv
         kxZfYWtau2NCMK9tOV8BlSHKxZB5JXwG7G+DiszMs2EtuEGHwDmvSJUvjQR6mkdAtqtY
         BaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696520404; x=1697125204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yf+AiQkBJuLFlOTFx5Each8LtFYadlmD+9qdSbBgp1k=;
        b=Gqfnoaz3C4jIgrzYH8V1wxO95g3mDqgnclRqzdBfIX26exmtfh6lus1KIvlebLQkbq
         zWJ/zUThBnzNutzYSDl4eeOfPSOvk0mpSstLag6DG3swE+tFEBKl4FCiRHN3tsYc6tZ5
         tX4dyEZjw+lHfusJdaCXI7pz8ExzyrTxqQt/2CTW2OD7T1ClpZUmP9Oy3RcjYasWfUdZ
         29Smm6q+JBB084GQOYkNEbPBUz0A3VAFZQlblxPpcsqz5vST9O1W/KkG9ZDOscwEOsss
         8y1Odll16SO6llFelPba1pMwQKH92L/velV7FkwC0BCZD/kQzEoW7GG3GoF95T+9UKWh
         8gVw==
X-Gm-Message-State: AOJu0YxQRX4C7oxESB3oF/oOOtlWzFMtzIPgCXgmQaz04+yS/LoHXYXY
	nHN7hg1GktQwmcqL03Rl3hLtzFGv02dVSNZ6qFM=
X-Google-Smtp-Source: AGHT+IGR23NeeHBp/H0Nd93mf0n6/TrD8pVQM3G+ZeE4+PSLkP5OUBwS4Uk/S9BMUCFUdkV+ExijdXyuGs1Iln6iuDY=
X-Received: by 2002:a17:90a:4926:b0:273:6b28:9e30 with SMTP id
 c35-20020a17090a492600b002736b289e30mr5393867pjh.41.1696520403842; Thu, 05
 Oct 2023 08:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927082918.197030-1-k.kahurani@gmail.com> <20231004114758.44944e5d@kernel.org>
In-Reply-To: <20231004114758.44944e5d@kernel.org>
From: David Kahurani <k.kahurani@gmail.com>
Date: Thu, 5 Oct 2023 18:39:51 +0300
Message-ID: <CAAZOf27_Cy8jaJBnjKV7YgyaKO2WohYrxcftV5BdOdm66g_Apw@mail.gmail.com>
Subject: Re: [PATCH] net/xen-netback: Break build if netback slots > max_skbs
 + 1
To: Jakub Kicinski <kuba@kernel.org>, Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org, netdev@vger.kernel.org, wei.liu@kernel.org, 
	paul@xen.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This change was suggested by Juergen and looked okay and straightforward to=
 me.

On Wed, Oct 4, 2023 at 9:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 27 Sep 2023 11:29:18 +0300 David Kahurani wrote:
> > If XEN_NETBK_LEGACY_SLOTS_MAX and MAX_SKB_FRAGS have a difference of
> > more than 1, with MAX_SKB_FRAGS being the lesser value, it opens up a
> > path for null-dereference. It was also noted that some distributions
> > were modifying upstream behaviour in that direction which necessitates
> > this patch.
>
> MAX_SKB_FRAGS can now be set via Kconfig, this allows us to create
> larger super-packets. Can XEN_NETBK_LEGACY_SLOTS_MAX be made relative
> to MAX_SKB_FRAGS, or does the number have to match between guest and
> host?

Historically, netback driver allows for a maximum of 18 fragments.
With recent changes, it also relies on the assumption that the
difference between MAX_SKB_FRAGS and XEN_NETBK_LEGACY_SLOTS_MAX is one
and MAX_SKB_FRAGS is the lesser value.

Now, look at Ubuntu kernel for instance( a change has been made and,
presumably, with good reason so we have reason to assume that the
change will persist in future releases).

/* To allow 64K frame to be packed as single skb without frag_list we
 * require 64K/PAGE_SIZE pages plus 1 additional page to allow for
 * buffers which do not start on a page boundary.
 *
 * Since GRO uses frags we allocate at least 16 regardless of page
 * size.
 */
#if (65536/PAGE_SIZE + 1) < 16
#define MAX_SKB_FRAGS 16UL
#else
#define MAX_SKB_FRAGS (65536/PAGE_SIZE + 1)
#endif

So, MAX_SKB_FRAGS can sometimes be 16. This is exactly what we're
trying to avoid with this patch. I host running with this change is
vulnerable to attack by the guest(though, this will only happen when
PAGE_SIZE > 4096).

Option #2 would be to add a Kconfig dependency for the driver
> to make sure high MAX_SKB_FRAGS is incompatible with it.

netback doesn't support larger super-packets. At least as of now. The
maximum number of fragments in a packet is 18. Any packets with the
number of fragments above that value from the guest are dropped. I
would assume that support for super-packets is probably something that
should be worked on or maybe even is already being worked on. However,
this is not the issue we are trying to fix in this patch.

>
> Breaking the build will make build bots very sad.

This patch build should not break build for upstream. It will only
break for those patching upstream behaviour. My intent is not to break
build bots but to alert someone building that netback doesn't work
with the particular MAX_SKB_FRAGS value. Seeing as they have modified
upstream behaviour, then, they might as well take a look at the issue
and make a decision themselves. Seeing as this issue will hit the
distros before it goes downstream, I don't think it should be a
problem for users.

>
> We'll also need a Fixes tag, I presume this is a fix?

Yeah, I guess that would be needed too.

> --
> pw-bot: cr

