Return-Path: <netdev+bounces-45439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB217DCF9E
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 15:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E711C20BC6
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691661DDF5;
	Tue, 31 Oct 2023 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6xGdnp+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FBF1C69D
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 14:49:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A01EA
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698763790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wC70NjzSUr4LvW8CC2+ZDGZgQqRztYwHl/WFtd4ZzKQ=;
	b=W6xGdnp+NZrX3XnWnClDT7ZKWRYiqIFD7LgZH4OPjQbqwMtSd5aHV8iypJDmQxJAurdy+o
	KseLHRM4OZgEEx20EsUWjsk4bzuFx+Br5ORl2NjG+JsX+cAamueEyMlzf0BTWwkUnrE9Lj
	xw8byqRJtb/bV6XBcLw7zrQormqznRo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-u1PcotP4Olue4U5OfQ73Mw-1; Tue, 31 Oct 2023 10:49:49 -0400
X-MC-Unique: u1PcotP4Olue4U5OfQ73Mw-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41e1899175eso13690941cf.1
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 07:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698763789; x=1699368589;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wC70NjzSUr4LvW8CC2+ZDGZgQqRztYwHl/WFtd4ZzKQ=;
        b=sbSSBqmtteFQF40lWP4+jE5FNn7qRr9bAthTJqIg/JIsjD3HgAAPOdGPZHxW3vERuA
         UeH/hO/6lIhT/h+V8XQHjtzVVeUjRwyAMtn0Cq4aEP4vxnPWnaQcnq7mp5f6r0DrPLY4
         1mPT/uYPyPGRztBwBOdXNHLPfBFdxQNmQTxpOEYFbWGbLnbkeJywzYJB3d0Zi0ShlLE2
         uvfP+aIhGSjG0dpMNcH/DgTZxFinffLSxmYcgfAh019XQ9GdMmmL2Nq+fIJnBUFKBkB7
         KiGMr9Jr2dY6rlZ/GERB+0or3FfSzDLZxCaRSMQ1mZXmbjU/XsrwR086D662WFw5cBZ/
         ydMA==
X-Gm-Message-State: AOJu0YwPxaGayp/LJNLi6Lq+HGA479OuUqIiNcfNfWnnYwiukQUqRIZ4
	H0xe3luL4+VRC1YnR1o4F4jfBtc0gMC9lpdLgt4VlN1hosLR8DuJVymNS7srWCqmq39Haow+PKK
	3tns+mSmjX1VdKiUm
X-Received: by 2002:ac8:7f55:0:b0:412:3189:9fd6 with SMTP id g21-20020ac87f55000000b0041231899fd6mr17244327qtk.5.1698763788678;
        Tue, 31 Oct 2023 07:49:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERjLWjRB1kJMdKCpg3B7l9DrSVVOpzcHbJPKkiapAIsGI8t+/ULpCGqcZBZO9DVV9mcj7SuA==
X-Received: by 2002:ac8:7f55:0:b0:412:3189:9fd6 with SMTP id g21-20020ac87f55000000b0041231899fd6mr17244308qtk.5.1698763788353;
        Tue, 31 Oct 2023 07:49:48 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-179.dyn.eolo.it. [146.241.227.179])
        by smtp.gmail.com with ESMTPSA id jt21-20020a05622aa01500b0041b3deef647sm558815qtb.8.2023.10.31.07.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 07:49:48 -0700 (PDT)
Message-ID: <c1f3236d0a2a2f540f65815633e709accdbc197a.camel@redhat.com>
Subject: Re: [PATCH v2] selftests/net: synchronize udpgso_bench rx and tx
From: Paolo Abeni <pabeni@redhat.com>
To: Lucas Karpinski <lkarpins@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 shuah@kernel.org,  netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org
Date: Tue, 31 Oct 2023 15:49:45 +0100
In-Reply-To: <vzz3qfbfq52qja24y25lopif27sdwyvz3jmmcbx5wm6jc5l53b@fy7ym6xk4zsb>
References: 
	<6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
	 <e8a55d0518da5c1f9aba739359150cad58c03b2b.camel@redhat.com>
	 <vzz3qfbfq52qja24y25lopif27sdwyvz3jmmcbx5wm6jc5l53b@fy7ym6xk4zsb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-10-31 at 09:26 -0400, Lucas Karpinski wrote:
> > Since you wrote the same function verbatim in 3 different files, I
> > think it would be better place it in separate, new, net_helper.sh
> > file
> > and include such file from the various callers. Possibly
> > additionally
> > rename the function as wait_local_udp_port_listen.
> >=20
> Thanks, I'll move it over. I think it would be best though to leave
> udp out of the name and to just pass the protocol as an argument.

Indeed. I suggested the other option just to keep it the simpler, but
if you have time and will, please go ahead!

Cheers,

Paolo


