Return-Path: <netdev+bounces-42106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF767CD1EA
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 03:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D18B21003
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 01:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D5B15BF;
	Wed, 18 Oct 2023 01:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IfY1yEGx"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F37440F
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 01:42:05 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F139F7
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 18:42:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53ebf429b4fso5007581a12.1
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 18:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697593321; x=1698198121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+p3zAg2hk+LlovhYL960eGIcLbSht6mtod7PgLUjGSE=;
        b=IfY1yEGxkC3VDJ1YyD5S2SnX+P3GeESKoryOeBIQNA2H0BrI7/KK1YmG0+kmT1mJRB
         YJZHIMeS+I2FRLIKgINY9fBXlqB7ymPLTMOqOEB2J3mX9+ijfwABRikLTh2Sx6/m7Ekh
         84guw0DFtkzLgTHXaoTg88pKHs9HOp4LDLc7+Mmc9FJrkdSrX3nchkOpKSOp20n2WAhr
         AwMWe0vfpf/XXauPX1+AYYcNAN4RMChJMEememojso7lSwnVrU0qjjxOCQEodRTTIFVt
         sIdd9KxgeIWAfhQqxWQyp6Tl0XFGcpwCniGsAvlOqO/Vqp+cjvKPuAxXyGKtm/m+UPJq
         O56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697593321; x=1698198121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+p3zAg2hk+LlovhYL960eGIcLbSht6mtod7PgLUjGSE=;
        b=tX8rAf3fzAZIHXkght/FI66RQ2aPQgufz7MrdnHzWghUYQ4mTDJ/ZH9YAAMmU8LHqi
         K0baMM4JZYz95B99/2ISamk4DCXlFxkhcdYKqSusCkjxvBgxHmlvCtDIiSO4vUECWduH
         T2j3qXlB1ZAnuYT6P7aDHU29AfmPLGdaXJGicb7jxQ+GJGOis9g/NiaedPOjAjm14iwS
         LMiNWD6CcMSoaxCJqFQMCTocIYR8EILdetnN5UwMf1cUnhP8bJedQSiLsvZHtR6x5MoM
         OiIFyvXdv66NvEM6oBqP0hIloAwuMNFVhXher+yNbSFZcfIhO5odN7T18iBSVY5MB432
         WnSw==
X-Gm-Message-State: AOJu0YxEABGs9PY36GucCnAxOROpVJbe7dBZVp98KSxxPRNlsCQM9NRn
	wb4SqN9dwlQcZQHR0wWNiCNwGT+hgV5++hrXCHLyi18D61GFM4Bg
X-Google-Smtp-Source: AGHT+IECIx0aP7SLihXcMO/tJq5VBdv249VFmANTC37EUoBdtrnTGm7mGZx54HVx6wKVRrWUtE3nlK3WDVsljMIpHuw=
X-Received: by 2002:a05:6402:274b:b0:53d:e0cf:cb95 with SMTP id
 z11-20020a056402274b00b0053de0cfcb95mr3582614edd.21.1697593321529; Tue, 17
 Oct 2023 18:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZS1/qtr0dZJ35VII@debian.debian> <20231017200207.GA5770@breakpoint.cc>
In-Reply-To: <20231017200207.GA5770@breakpoint.cc>
From: Yan Zhai <yan@cloudflare.com>
Date: Tue, 17 Oct 2023 20:41:50 -0500
Message-ID: <CAO3-Pbod3qc7rdg0bN0z5TjeoxO-SAADEwPZm6jcT42Gya8s=g@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] ipv6: avoid atomic fragment on GSO packets
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 3:02=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Yan Zhai <yan@cloudflare.com> wrote:
> > Refactor __ip6_finish_output code to separate GSO and non-GSO packet
> > processing. It mirrors __ip_finish_output logic now. Add an extra check
> > in GSO handling to avoid atomic fragments. Lastly, drop dst_allfrag
> > check, which is no longer true since commit 9d289715eb5c ("ipv6: stop
> > sending PTB packets for MTU < 1280").
>
>
> > -     if ((skb->len > mtu && !skb_is_gso(skb)) ||
> > -         dst_allfrag(skb_dst(skb)) ||
>
> My preference is to first remove dst_allfrag, i.e. do this in
> a separate change.

You mean completely removing all dst_allfrag references and related
stuff such like IP cork flags/socket flags? I was debating, it might
be cleaner that way but it does not fit so well with the subject of
this patch. I can open a new patchset to clean that up separately. For
this one, I guess I can keep dst_allfrag for now and come back with a
V3. Does that sound good to you?

Yan

