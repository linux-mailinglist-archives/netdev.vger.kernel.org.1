Return-Path: <netdev+bounces-15960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C0274AA04
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 06:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA8A28165E
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 04:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE1613078;
	Fri,  7 Jul 2023 04:42:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B9BEA0
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 04:42:58 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513DC1BF0
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 21:42:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3110ab7110aso1439152f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 21:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1688704975; x=1691296975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kI0JfG+2wXbxf1pqPY+7DglyNjX5vnvsMEBj9nCkTfg=;
        b=xdr4df1nrlrnwJ/IzEHovIByEoZcLDulB+wFb9fmhb1SFw5YlUI67MoVQtik8grWaU
         dtoDjWQhI7rHhpIQ/aELZJ/srTEYk3iflwkuszmsCjHyC5kU1q67uqUak47nmn06Hmco
         aYLOKY1fGiiw6j0s6cqse7vvzhvpNjhG/9asU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688704975; x=1691296975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kI0JfG+2wXbxf1pqPY+7DglyNjX5vnvsMEBj9nCkTfg=;
        b=ZjHzV6JbVF3GahTQ5LHMVVyrsNNUA/870oFwF0OPgFiqF9KWoZK48gO9hwFO2oMwRd
         tA38ebj/GUUSfch9soI+GJG0EtKkR/K4Zu55ngbrJFis8ty++1DNwbD1JOXvjVJcyXI7
         iFlAH2H59nnFSgS49RM6MXBOF2pwK22edDUp6iPsMKT69dm3RM3p+D1KM2Cx6bf7hm8k
         isonwy23ARltMRfGtcebJweKE2gNeBFhaZpQOgvMgTY7RfzaxaRa3MVCV4NDf9rjae5b
         g/DtyGuQwYXsjajT5+a2fKJN7u1Zfkai4bxURHTEme1byAOXAkWNW3vhyzI2EATYHRml
         0QLA==
X-Gm-Message-State: ABy/qLZhd3aqLJC6szuzTdw85iFqgdk45MOCyEEtVBqakTMO5BQKYdPF
	3eLK5zoP3CClh4652jWk9WRa148MTUPkoVVcZuv+OQ==
X-Google-Smtp-Source: APBJJlF82yoElBEn+sVtWYeqOosGQMBJuWFaWZdcBAjc3tOYYkbwFWLXggng6BqvzZwHzRW/YKlMx46V1JWIqOPc4i8=
X-Received: by 2002:a5d:4e46:0:b0:313:f1c8:a963 with SMTP id
 r6-20020a5d4e46000000b00313f1c8a963mr3242664wrt.2.1688704974750; Thu, 06 Jul
 2023 21:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706172237.28341-1-ivan@cloudflare.com> <20230706191710.5f071724@kernel.org>
In-Reply-To: <20230706191710.5f071724@kernel.org>
From: Ivan Babrou <ivan@cloudflare.com>
Date: Thu, 6 Jul 2023 21:42:43 -0700
Message-ID: <CABWYdi2H2Z2ugB_0m7Fo=dkfP_TbGqak8mfhL-m5FWMRe+UZpg@mail.gmail.com>
Subject: Re: [PATCH] udp6: add a missing call into udp_fail_queue_rcv_skb tracepoint
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, 
	Satoru Moriya <satoru.moriya@hds.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 7:17=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu,  6 Jul 2023 10:22:36 -0700 Ivan Babrou wrote:
> > The tracepoint has existed for 12 years, but it only covered udp
> > over the legacy IPv4 protocol. Having it enabled for udp6 removes
> > the unnecessary difference in error visibility.
> >
> > Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> > Fixes: 296f7ea75b45 ("udp: add tracepoints for queueing skb to rcvbuf")
>
> Doesn't build when IPv6=3Dm, you need to export the tp?

Thank you, I just sent v2 with the fix:

* https://lore.kernel.org/netdev/20230707043923.35578-1-ivan@cloudflare.com=
/

