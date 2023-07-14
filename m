Return-Path: <netdev+bounces-17782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF0C75308F
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F2E1C214D0
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A30A4C91;
	Fri, 14 Jul 2023 04:28:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1D1C08
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 04:28:06 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8992D47
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:28:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e5da802afso1702130a12.3
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 21:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689308882; x=1691900882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qHf1bw4VEpalWptJ6sYJzbTQLUqyeRRjE32ptoAxuck=;
        b=WwQTm81PifCGhzdXHwWxFJ/ZyEy6HDXKNCuPzEZXtpDnW8q5Muu8GTMaM7bPmfc53y
         mwIjXhH1ncVmbGLd2bgQq2RnH1N/6uTOwawh+Z3XiemFY3Dz4COKat3Yce3aoPrf+qYa
         tPPdsbfW9BBefcRRqo7XNhiQx0cBf1C2WLU8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689308882; x=1691900882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qHf1bw4VEpalWptJ6sYJzbTQLUqyeRRjE32ptoAxuck=;
        b=HpLceEB8ErVJ+63sxd0Dvll6tJqw6QolrgGVvKLx0ld8JY16vX7IMkQswoMlddWCvt
         pYmwzm0OHU195XN16mBB06rG4C4Q5giU9noJVnOgcjmK/uiuU/Qt5jEHuVJI69zLMHXY
         EW4RYhBl8DvnBmo8IuWgXqQFAM+9rjrZOy8nLF03h8KCcNcnNPQqZ69FtWY98yfGEf0U
         oe7GGRqI8k+1CcycuBusb7j31BJdHkZIMxysYYLVg+RteJREqlDDytTpU79hXpL33+sK
         0Fqy36OoXUlNgbXC57tebVEs6fgceQ3EGiKd9I7jom45pJVR2tuHAKo4iVOn+odkhbDR
         ovrQ==
X-Gm-Message-State: ABy/qLb6oOLwQBEFKfZmLTeDuJZRp28v2vmXa5k842CaZ9I6Wu1gzIKz
	dYD5VWcDwCaDf8cXyV3CI2cxdwuVRUPLm2XeJ0CX5g==
X-Google-Smtp-Source: APBJJlF4bnf1g8fW6x42O1YXhzENyu6ohKCQGrFHpqkr2RllFBk2SW+06TBLxI8i3KzjCP1Xn3yYNiYaY5ZEP+xS7/Y=
X-Received: by 2002:a05:6402:60a:b0:51d:7fa6:62ca with SMTP id
 n10-20020a056402060a00b0051d7fa662camr3222649edv.14.1689308882567; Thu, 13
 Jul 2023 21:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZLA0ILTAZsIzxR6c@debian.debian> <CAF=yD-K-fra5nc-pjOV8Ng9sB2WWWeZA=s+-WN=O6+=8aZ-E6w@mail.gmail.com>
In-Reply-To: <CAF=yD-K-fra5nc-pjOV8Ng9sB2WWWeZA=s+-WN=O6+=8aZ-E6w@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Thu, 13 Jul 2023 23:27:51 -0500
Message-ID: <CAO3-Pbr8kypYNSJchh3b4KCe4e0XH038BU6YQm3i+u+EHt2iDw@mail.gmail.com>
Subject: Re: [PATCH v2 net] gso: fix dodgy bit handling for GSO_UDP_L4
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>, kernel-team@cloudflare.com, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Andrew Melnychenko <andrew@daynix.com>, 
	Jason Wang <jasowang@redhat.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 12:38=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Thu, Jul 13, 2023 at 1:28=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wro=
te:
> >
> > Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
> > packets.") checks DODGY bit for UDP, but for packets that can be fed
> > directly to the device after gso_segs reset, it actually falls through
> > to fragmentation:
> >
> > https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo2=
8KzYDg+A@mail.gmail.com/
> >
> > This change restores the expected behavior of GSO_UDP_L4 packets.
> >
> > Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 pack=
ets.")
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> for next time: places hyperlinks in the block of tags at the bottom of
> the commit as "Link: ${URL}"

Good to learn, thanks!
--
Yan

