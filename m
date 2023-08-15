Return-Path: <netdev+bounces-27737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7556B77D0A1
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47941C20DC7
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB7A156F7;
	Tue, 15 Aug 2023 17:07:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9421313ADE
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 17:07:08 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876011737
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 10:07:07 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a7f74134e7so2130231b6e.1
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 10:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692119227; x=1692724027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8DAFOOIcSljHTXBuhFKE9ilY2RRxTr9UnwnQAwhcxs=;
        b=bgco/6HvDrxHLAxYnqRVcNVzgTeDbevphltliVqw7JrBfs+OveKP47B7H8t2GloLJN
         osE9pvJ/2ARDoosTxubJWBk5XSOtPX8I+Y05+74h6FbVKt+EhEsQUkHA3NpJCHI10txf
         fL4cuwpckVlf+7A5dL8HK3q8713wlE1sFL1uSFzV3knf0Rgbh5P+YwHPy4D6d5ginM69
         iqUA/n7Xtqvcvkn9yVPE3MASZfNURqjMwwlORXtzeWh4qMf8tYRS5w5MH+3hZxa7UfRe
         PMJk4BUWFM0dO4/vI+H53GSe5wF5uaxKl7QxhAXYMbKN2lH/FTQZ7n4W6BG//kycv6n7
         sB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692119227; x=1692724027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q8DAFOOIcSljHTXBuhFKE9ilY2RRxTr9UnwnQAwhcxs=;
        b=YKXP36W2mMRgNu4hj/P94THuoISMUp1/XIHbRg9TUtn5rmyfiv437rVL2pLZWNh+4k
         6Z3c2jXT361jEcGeQ/WSYuMaff71Tdl+gfEzpK9cFKZzu2Nbx0TeEwQR4E1lmshw/xpn
         k+DwpQX/WThe7NHMEgaUAiarenX4W9J57En52FgNDlvWys+jLjguApMMjelifztRcK8Z
         uINXQqdfCrwCmBuJ6Riv006BwpbRpoopY7kNNzQYWo+OQ2QbwPV//c3Qi7LNe5rld6xQ
         VKcss5u4307LhqjzlpjMkS3GJPc53Yq34CWWoNeeZtWvalJ7gVk+rgOf5C9oZel6qpZc
         v8nA==
X-Gm-Message-State: AOJu0Yygf4vEIWZZCwZjcI6fZjsk46ykjYwy6eHLiuFDXYzUtjnUhl0F
	DLLwcpxMTnEWmrlr0mS2AX5LGnu6Wx9FzptnxAs=
X-Google-Smtp-Source: AGHT+IHnxfKaz4/z0LPlkCYGJZKWeeRD77MprHGOGe8Sveb/9jTXX9eD5jvnZQgrYSwLowGcgXpOUg4d0UKnBdtms4Y=
X-Received: by 2002:a05:6358:2789:b0:134:ce45:b782 with SMTP id
 l9-20020a056358278900b00134ce45b782mr12404429rwb.21.1692119226668; Tue, 15
 Aug 2023 10:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230811223938.997986-1-ziweixiao@google.com> <20230814192231.12e0c290@kernel.org>
In-Reply-To: <20230814192231.12e0c290@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 15 Aug 2023 13:06:29 -0400
Message-ID: <CAF=yD-JcWUhi3o==cQj5ByYosH0bQBxsyCk7fUAzMDXRX_fa9w@mail.gmail.com>
Subject: Re: [PATCH net-next] gve: add header split support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ziwei Xiao <ziweixiao@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 10:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 11 Aug 2023 15:39:38 -0700 Ziwei Xiao wrote:
> > - Add header-split and strict-header-split ethtool priv flags. These
> >   flags control header-split behavior. It can be turned on/off and it
> >   can be set to 'strict' which will cause the driver to drop all the
> >   packets that don't have a proper header split.
> > - Add max-rx-buffer-size priv flag to allow user to switch the packet
> >   buffer size between max and default(e.g. 4K <-> 2K).
> > - Add reconfigure rx rings to support the header split and
> >   max-rx-buffer-size enable/disable switch.

The bulleted list is an indication that maybe this patch is combining
too much in a single commit.

> Someone on your team needs to participate upstream or you need
> to get your patches reviewed from someone upstream-savvy before
> posting.
>
> Anyone participating in netdev reviews would have told you that
> private flags are unlikely to fly upstream.
>
> One part of an organization participating upstream while another
> has no upstream understanding and throws code over the wall is
> a common anti-pattern, and I intend to stop it.

The one point I want to raise about private flags is that ethtool
currently lacks an alternative for header-split.

That probably requires a non-driver patch to add as a new ethtool feature.

I had not given much thought on the two modes of header-split seen
here until now: strict or not. We'll have to figure out whether both
are really needed, especially if turning into ethtool ABI.

