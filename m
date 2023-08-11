Return-Path: <netdev+bounces-26605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D6377854C
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 04:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22CB01C20DE3
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 02:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7B67F1;
	Fri, 11 Aug 2023 02:19:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE94A2D
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 02:19:51 +0000 (UTC)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3352D55
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 19:19:50 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-791c27bb91dso991898241.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 19:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691720389; x=1692325189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhSgfyHqn5+CZv2RiR3OdGWwEDtgbbqbNvBOrUw9xvk=;
        b=6NAYIYih3S0lTqiEhyq/71QbC+cEFBxi2jm9a9M4bkmx2FtJqwVQJskNN5qF9wMLiZ
         BchdMSjdr3WV3NjwR31JP4/ZtiS+Xx5TntH9kCrp4Ud0IFKCdSZIFWcqpazGaUgrMR7J
         yfDFfdO4HXTAyzrB+zWZX8KlaZdOtjcp50PGBZdXKYf9Rf59IJEm6bLU+cKRJ/I3rDhe
         tEasqmVSXVmu0bSmpF4cbn816PTA6CWvOS1peMQzxyR1zFIYTpNGJHUe3DH3WazxgaSJ
         bdWq5CDPxuqVh9E8SaQKyMUPTxubVftY2VeQJELBpy74SGQATtBIrOZJzyBfrtL7DCjE
         lQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691720389; x=1692325189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BhSgfyHqn5+CZv2RiR3OdGWwEDtgbbqbNvBOrUw9xvk=;
        b=O0Q10PD+t6EBzH6d7x1fUV9HsfcAycDRylPK0qiILJvFmOAaJY6+keTyqiQAIMDcM+
         mrl96JXIWCGePFhYecy5BiymrxDcNYpoMU5ZIWOArTXluacbCw4i57VpTdgQ08fJPEBD
         SVjEAULS5Afy/tmpRLvnviQ5TTpFY1gWD0KxbwiNCfX6cftmtJ34xWxcvk2dT+lDADgY
         7doMPaHW/sd5rNqKxWfPa9qWNEceAyWjbn529Di6BTKCubintbn8qLk5cZ8YbFIw4WFe
         x2AsQXVLXZs2zY9n0ImhwWu3iHOVW1/3+0QPOm6P7IrcBgS0UUcOX8s+QM45+3aL8L6T
         5U8g==
X-Gm-Message-State: AOJu0YzApNOazgmQipmmV11U9DKvHicepMIoFOl8S+E6wnbc1p84BPfg
	aCLk6NYO+4LsbT2TmsDr48n12DmbyRQ6U0nkTUOEvA==
X-Google-Smtp-Source: AGHT+IFGlBGQlkugoX7n1IuiQz0by2M3WsIkqkjLaVB0lnZ4q7MSgvdAT/b3DDrMPYNFmc8BRx4hNjG7m6xM2QQE49Y=
X-Received: by 2002:a05:6102:404:b0:446:ea0e:f8a3 with SMTP id
 d4-20020a056102040400b00446ea0ef8a3mr2263539vsq.15.1691720388966; Thu, 10 Aug
 2023 19:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810015751.3297321-1-almasrymina@google.com>
 <20230810015751.3297321-2-almasrymina@google.com> <97bf5b80-ca0c-638b-9b5d-1cae70f3df58@intel.com>
In-Reply-To: <97bf5b80-ca0c-638b-9b5d-1cae70f3df58@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Aug 2023 19:19:38 -0700
Message-ID: <CAHS8izNVvenUve=k56vdacfhs6fjYs92BWf8Ry2qTx+0jgLqYQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/11] net: add netdev netlink api to bind dma-buf
 to a net device
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc: netdev@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Hari Ramakrishnan <rharix@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Andy Lutomirski <luto@kernel.org>, stephen@networkplumber.org, 
	sdf@google.com, Amritha Nambiar <amritha.nambiar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 9:09=E2=80=AFAM Samudrala, Sridhar
<sridhar.samudrala@intel.com> wrote:
>
>
>
> On 8/9/2023 6:57 PM, Mina Almasry wrote:
> > API takes the dma-buf fd as input, and binds it to the netdevice. The
> > user can specify the rx queue to bind the dma-buf to. The user should b=
e
> > able to bind the same dma-buf to multiple queues, but that is left as
> > a (minor) TODO in this iteration.
>
> To support binding dma-buf fd to multiple queues, can we extend/change
> this interface to bind dma-buf fd to a napi_id? Amritha is currently
> working on a patchset that exposes napi_id's and their association with
> the queues.
>
> https://lore.kernel.org/netdev/169059098829.3736.381753570945338022.stgit=
@anambiarhost.jf.intel.com/
>

Thank you Sridhar,

I think honestly implementing multiple rx queue binding is trivial,
even without the napi_id association. The user should be able to call
the bind-rx API multiple times with the same dma-buf to bind to
multiple queues, or I can convert the queue-idx to a multi-attr
netlink attribute to let the user specify multiple rx queues in 1
call.

Without doing some homework it's not immediately obvious to me that
coupling the dma-buf binding with the napi_id is necessary or
advantageous. Is there a reason coupling those is better?

It seems like napi_id can also refer to TX queues, and binding a
dma-buf with a TX queue doesn't make much sense to me. For TX we need
to couple the dma-buf with the netdev that's sending the dma-buf data,
but not a specific TX queue on the netdev, I think.

--=20
Thanks,
Mina

