Return-Path: <netdev+bounces-17665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 277E07529F6
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1183F1C21422
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF4F1F195;
	Thu, 13 Jul 2023 17:38:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C11F190
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 17:38:56 +0000 (UTC)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD7C26BC;
	Thu, 13 Jul 2023 10:38:55 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-794d1714617so352807241.0;
        Thu, 13 Jul 2023 10:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689269934; x=1691861934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lq0dSBv4S2ADFTDlFw+U8GJHF5afWm8c+OBzDmy3WMQ=;
        b=E17PYgGXc3qQL2vUcdSDLIqy2nWsal1OePYKQCrBoSXTte7R75Wak40hCV9rJEQY1w
         22RJy3gYJvXoPjjM81W1asaVJ6mAsfa7G4FdHtNMRYu3tzqKQGFb8RM0aB9yJKfn9csb
         rtrgDfS6IcPRaVqvF/1PPHd2I0mHFm1GpN7BfUXfSu8FP5DBdHUEwdopInVKkQR9gfDt
         G4NQIhLGTu/y/jwaO9FVIwuBlW9Se0Zrs48nsEiagGscRxRx7o0W5h5azEJuUDJh71mM
         vU0aO0GDT8k6wJQiPWmxstk1/Fe0PC9Oj9HZMbVJFZp2Tk8QUc8VOZDGb+KdiL+Aayjh
         Aqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689269934; x=1691861934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lq0dSBv4S2ADFTDlFw+U8GJHF5afWm8c+OBzDmy3WMQ=;
        b=EQeEk/0TQTmPCYmp6r1ELYu96Du6Yo1YUtHBEttFBzl036f4IBDfOUojbErAMYB6zU
         PHxe3E392Xki4au045ym6D4VS1jhUPYnS4x7PUhDHjMfChOeMAhuHFuFDBuhzm81iSIS
         aaWLrNACX8ByXaZ3XxD13CeiQCY79aWr5x6+X/aNLj+S/QLWCSZZ5+HnrCZ0MUAr8d7Z
         fxfsd5ByFvJnWeEXk5gE8xXWlVvj5gcwxBlpvP0K4Pl2WuDff9BLRzp4deW9isBD2+tE
         6zwJuJkSTTiNuLBIzMfJhfKUrtZmlTK5/Bzla3pywEU761IV5qqF26mzU/x+ISvIqmEW
         ZksA==
X-Gm-Message-State: ABy/qLZt33Yq/7eLYaSVpRrIvzdzYIsQIjJ1fPlGmb/pAvZNzIV4THaS
	2t30qZAy523WnH013eZKDpaoY/vjHZSJ66+VY4U=
X-Google-Smtp-Source: APBJJlGmz9kcZyA2EvGUAc88OVD93BqG1zU/89VreMl5ZkKpMae0GdzpJIxAWDGWB7CUjbz/K7CLNJAun3Rw0m5gqxs=
X-Received: by 2002:a1f:bdcc:0:b0:46e:7102:7211 with SMTP id
 n195-20020a1fbdcc000000b0046e71027211mr1618120vkf.11.1689269934311; Thu, 13
 Jul 2023 10:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZLA0ILTAZsIzxR6c@debian.debian>
In-Reply-To: <ZLA0ILTAZsIzxR6c@debian.debian>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 13 Jul 2023 13:38:18 -0400
Message-ID: <CAF=yD-K-fra5nc-pjOV8Ng9sB2WWWeZA=s+-WN=O6+=8aZ-E6w@mail.gmail.com>
Subject: Re: [PATCH v2 net] gso: fix dodgy bit handling for GSO_UDP_L4
To: Yan Zhai <yan@cloudflare.com>
Cc: "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>, kernel-team@cloudflare.com, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Andrew Melnychenko <andrew@daynix.com>, 
	Jason Wang <jasowang@redhat.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 1:28=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
> packets.") checks DODGY bit for UDP, but for packets that can be fed
> directly to the device after gso_segs reset, it actually falls through
> to fragmentation:
>
> https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28K=
zYDg+A@mail.gmail.com/
>
> This change restores the expected behavior of GSO_UDP_L4 packets.
>
> Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packet=
s.")
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

for next time: places hyperlinks in the block of tags at the bottom of
the commit as "Link: ${URL}"

