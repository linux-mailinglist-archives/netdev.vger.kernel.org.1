Return-Path: <netdev+bounces-40646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4A87C81F4
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 11:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6E21C20A3D
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6224E10A22;
	Fri, 13 Oct 2023 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtZvaY1a"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF83210950
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 09:25:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C8695
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 02:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697189117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fjn1YV4eLF+7JWF9dlwWrMJB0WcDm1Pdq0sVQRaGc5A=;
	b=FtZvaY1a42g9T4HQvGi00nh2G2eLlqzt616smBZWi7bYtUMn4T7yTMozLqyh5denTPZR/v
	9VoZN3DQu1vYk47LGJzRenliHV+YDBr5FUICbQNCHus6Kmnj/tAtZL0cjBgmAS3mqFM0Ef
	bLvEwmM+5k3yCboHtntpefnpq8eJXuo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-aVdq2ZwDPqK4pLk5ndPNbQ-1; Fri, 13 Oct 2023 05:25:14 -0400
X-MC-Unique: aVdq2ZwDPqK4pLk5ndPNbQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae56805c41so37058266b.0
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 02:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697189113; x=1697793913;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fjn1YV4eLF+7JWF9dlwWrMJB0WcDm1Pdq0sVQRaGc5A=;
        b=WS5QwDLSokNPP21MAWmOyYUgujEVD7uuy/+x3mha1LQoCNVb2btB0FSBcTj3pW6fbb
         iAQFs2noE2QoJKtItcRkiYnX8QnvFgKetkUdlDXhxDdqARFB+PkSm7S/ylEII5YSCj9n
         Pdv8oIQO6259kprKrpQS6hlhMt5N1LQH44xN86dKqD1lr4/Smh1Q/q7O50MwNdslyUxM
         cU7xJt2ddtFDgOn8Cqpb6GW6XZ1W//nIwthIO4F2nWHU1dBYTdKn2btYwkJl4tsIe/ps
         tcC39yPwwZ10uDvxiqP+vDGxHPJJLLtD1d4tXrGksTWZc69QI7gExH7DeTAzdzFdnBmL
         SZMQ==
X-Gm-Message-State: AOJu0Yw/sh8bnatiHPM0c+GqUmusV2cbn7vkFcLLvoQO91E1HN0cOLHd
	DaLS2yKj5awCqTp3UuqTXYvmirXWekMKhTMUZjJjQOtXGW/l+GpPvBki7UjG/ckvRSyzAnhhliL
	2+0hYTZsycw47tDzk
X-Received: by 2002:a17:906:ce:b0:9b2:bf2d:6b66 with SMTP id 14-20020a17090600ce00b009b2bf2d6b66mr18193335eji.7.1697189113495;
        Fri, 13 Oct 2023 02:25:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr+837x+kVjqot8JEkZBODUszPSIhc19ogZqkkNL0o9Wua7mSF4xzNk4myf/cU55dU3/8I2Q==
X-Received: by 2002:a17:906:ce:b0:9b2:bf2d:6b66 with SMTP id 14-20020a17090600ce00b009b2bf2d6b66mr18193324eji.7.1697189113148;
        Fri, 13 Oct 2023 02:25:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-54.dyn.eolo.it. [146.241.235.54])
        by smtp.gmail.com with ESMTPSA id t24-20020a1709066bd800b009b29668fce7sm12072519ejs.113.2023.10.13.02.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 02:25:12 -0700 (PDT)
Message-ID: <8918fc5c5d112b6cbfd0ac28345a1c33afcb09b9.camel@redhat.com>
Subject: Re: [PATCH v2 net] tcp: allow again tcp_disconnect() when threads
 are waiting
From: Paolo Abeni <pabeni@redhat.com>
To: Xin Guo <guoxin0309@gmail.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, David
 Ahern <dsahern@kernel.org>,  mptcp@lists.linux.dev, Boris Pismenny
 <borisp@nvidia.com>, Tom Deseyn <tdeseyn@redhat.com>
Date: Fri, 13 Oct 2023 11:25:11 +0200
In-Reply-To: <CAMaK5_ii38_Ze2uBmcyX8rnntEi35kXJ47yhxZvCb-ks0bMbxw@mail.gmail.com>
References: 
	<f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
	 <CANn89iL_nbz9Cg1LP6c8amvvGbwBMFRxmtE_b6CF8WyLGt3MnA@mail.gmail.com>
	 <CAMaK5_ii38_Ze2uBmcyX8rnntEi35kXJ47yhxZvCb-ks0bMbxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Fri, 2023-10-13 at 12:42 +0800, Xin Guo wrote:
> In my view, this patch is NOT so good, and it seems that trying to fix
> a problem temporarily without knowing its root cause,

First thing first, please avoid top posting when replying to the ML.

I don't follow the above statement. The root case of the problem
addressed here is stated in the commit message: the blamed commit
explicitly disables a functionality used by the user-space. We must
avoid breaking the user-space.

> because sk_wait_event function should know nothing about the other
> functions were called or not,
> but now this patch added a logic to let sk_wait_event know the
> specific tcp_dissconnect function was called by other threads or NOT,
> honestly speaking, it is NOT a good designation,

Why?

> so what is root cause about the problem which [0] commit want to fix?

The mentioned commit changelog is quite descriptive about the problem,
please read it.

> can we have a way to fix it directly instead of denying
> tcp_disconnect() when threads are waiting?

Yes, this patch.


Cheers,

Paolo


