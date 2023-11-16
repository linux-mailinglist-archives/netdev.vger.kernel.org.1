Return-Path: <netdev+bounces-48485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C5E7EE8BF
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 22:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 198F1B20A1A
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 21:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBDE3589E;
	Thu, 16 Nov 2023 21:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR3fp8Bd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC06A5
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 13:24:36 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7b9ba0c07f9so442774241.3
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 13:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700169875; x=1700774675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCXAsxp6U/sULfwvOFBpg6znTVuVny6RrJrYvo/6V34=;
        b=CR3fp8Bdsa0aWfKyRDSVA62EQoW4UBYiEKyj0Bq/HpC69dfs4nuPps6UmUagNuTI2a
         ENOPeB3tF9EJjRReSu+bhRjGVninUibE39caxRozTJP3ujRl4noc5CF1AwIhu5A+KYZN
         apBQCppS/Lil3uUuXNueSXhhUJr+nmMVV11uZRT7GuOeaSLNhHwsxNPkBFx+2VBVT7h4
         KyyeVil8N34nydKKz07ivv4sGIldeEw0SN+9Xu4mj9ne8lv6NBHe5eX73/lbOJgp2/hk
         WCc+fe8dG84sGYnk/rFn707PxDORBQ8dgeas1rdxcQEczkLtJ2EN8N5wtIQ97BADg/8Z
         sR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700169875; x=1700774675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCXAsxp6U/sULfwvOFBpg6znTVuVny6RrJrYvo/6V34=;
        b=vnWZZvyvgN/ugn9G+j2vb0ByUvJg6AL1TKfm3Q1pshuwxm/4cY5ekXVCrKP755InGq
         AohpSGQ240Li5wS1xY5SecQrj5mbu7TvHwgyhK0ry19KOzb2ZtEeYN9mU4QyLLlEB8t0
         B1CdGUYgFMNqmoWgMU0SJ/pk3xBntO0v6HOv1UNPLS1hMrS5gdeoDzshG9gT9MTIP6El
         WgXWYtrPWDCEVvg+RtoTVybaQEsRbVJ5+g4jWvkSyCA3IhYXzfbs7Vk8/g9CeofPcFQB
         W9xsVi/H0ZRb2pR1KqAToLbYfOm1FRiQ89t6IcBuItKWkElWQd83GHg1INxhxf6UDC3c
         9QLg==
X-Gm-Message-State: AOJu0YyXeVwG87r1nCnpw1KK9uDXuPXgHRoQGYP40u8fwVXhI3AiPSS7
	n1gmgaPNMm3FEZ80sn+6vasjaNVI0yL0dGMZLPM=
X-Google-Smtp-Source: AGHT+IGP5BEzA80lgMy9AYNtH5jjj43huyXF9pK9NEXqBdD+fiEvA4EHG67o2LexcospHZZjr5cAhXNYaMEBHREictc=
X-Received: by 2002:a67:c308:0:b0:462:712c:6aa6 with SMTP id
 r8-20020a67c308000000b00462712c6aa6mr2866739vsj.22.1700169874703; Thu, 16 Nov
 2023 13:24:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116085707.2475816-1-edumazet@google.com>
In-Reply-To: <20231116085707.2475816-1-edumazet@google.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 16 Nov 2023 16:23:57 -0500
Message-ID: <CAF=yD-LFT+qqctdntnEOnhpwG-1+YPt=D4-5Mm0R2A9cMmoOFw@mail.gmail.com>
Subject: Re: [PATCH net] gve: add gve_features_check()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Bailey Forrest <bcf@google.com>, Willem de Bruijn <willemb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Ziwei Xiao <ziweixiao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 3:57=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> It is suboptimal to attempt skb linearization from ndo_start_xmit()
> if a gso skb has pathological layout, or if host stack does not have
> access to the payload (TCP direct). Linearization of large skbs
> can also fail under memory pressure.
>
> We should instead have an ndo_features_check() so that we can
> fallback to GSO, which is supported even for TCP direct,
> and generally much more efficient (no payload copy).
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Bailey Forrest <bcf@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Jeroen de Borst <jeroendb@google.com>
> Cc: Praveen Kaligineedi <pkaligineedi@google.com>
> Cc: Shailend Chand <shailend@google.com>
> Cc: Ziwei Xiao <ziweixiao@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

