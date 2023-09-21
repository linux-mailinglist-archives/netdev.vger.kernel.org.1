Return-Path: <netdev+bounces-35409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 700057A9633
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67191B20AB9
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F38199D1;
	Thu, 21 Sep 2023 16:59:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5800EBA43
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 16:59:32 +0000 (UTC)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2A61B1
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 09:56:57 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34fcc39fae1so3135ab.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695315411; x=1695920211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2u6FN1SftgW++v8P+zRdQ8M7vk5MQi7XZAYI++8wbU=;
        b=V1pv4OlnEYKJw6jOMNqV/cTfOLdRzlCJ8xg7qyBPLLTxjZB7517BPGBeBfnJXVWqp3
         nR720HIUq+qvCqYLj9B2NNgvLK+ZK+6WF1GATUBckObPZuNWJ2i9SgXehGSmqrYXir9z
         gFZUe+2t9VTBRF6pCmZ62DOXbNuXJnL7H2hgLnVP+abJUyMdoi3Nb1FOIsMZ8T52U9Mb
         BI+KzUW2kf5M3Pxunf11xgDtRoyBtJSeCDQmJqNgUDBRokbuB3VKZfhbbEvE350f9z2p
         9LeSxjE1+7niBFrQMaDPJWxfhOYWJr8hN9lj03+TlQf4Sh80uR5bXGJCBAfVnxhaxaS+
         qbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315411; x=1695920211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2u6FN1SftgW++v8P+zRdQ8M7vk5MQi7XZAYI++8wbU=;
        b=ffQK07peiW8/DVDZ1If++cQ4tRpTHh+AtW2GDxxsDz0vEB2wxI2exTncnHgo3Ns8ur
         HAC1DTcbUEcK9Zbt22KUadhznjzfsPbVILrSUPbqG31aAJAyJhZZQ3QDvhmjM3ukJRcx
         LzY3RA8NMwH/J289T6q6b3V4lmvZ1zuWPuN+4k5M6e0vFEAxBtquLMzHVz3N+ok8hTG+
         M3gkdBHkLuO3+bAGx9lUui5IYePnQ9Lk7H9PYuC0ss/UXSluAwx0VI5Tontu58GOjh3L
         tjsYl/J71kcPBQLiACvxFbekhVoNIz1dNOP1VzmbYa5/Cdh2oUm5gQtswLtfRzdO7rEH
         xRPA==
X-Gm-Message-State: AOJu0Yx77FOYKPO2w11JF0AK1Ec4dPGlGNucbOcqFEG4EE9kqRi06jxl
	veowcs+APIYsGgJtKovj60uTkltzzMqwmfTydJODze1v2UzdP0fmVfo=
X-Google-Smtp-Source: AGHT+IFV3vDWa7KdA0yQL7JHzFNdXvAQ2asrdok6dafCPy1rMKmY7RBvf74useO0LezTQyngHc30DzRXhMIB/7XbWKw=
X-Received: by 2002:a05:622a:290:b0:416:6784:bd60 with SMTP id
 z16-20020a05622a029000b004166784bd60mr271347qtw.21.1695314980488; Thu, 21 Sep
 2023 09:49:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918190027.613430-1-dima@arista.com>
In-Reply-To: <20230918190027.613430-1-dima@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Sep 2023 18:49:29 +0200
Message-ID: <CANn89iKp4LnpQ6fpTYc==ixqTNQgndBmOzj7w-_GN0hOfZyppQ@mail.gmail.com>
Subject: Re: [PATCH v12 net-next 00/23] net/tcp: Add TCP-AO support
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Andy Lutomirski <luto@amacapital.net>, Ard Biesheuvel <ardb@kernel.org>, 
	Bob Gilligan <gilligan@arista.com>, Dan Carpenter <error27@gmail.com>, 
	David Laight <David.Laight@aculab.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Donald Cassidy <dcassidy@redhat.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Francesco Ruggeri <fruggeri05@gmail.com>, 
	"Gaillardetz, Dominik" <dgaillar@ciena.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, Ivan Delalande <colona@arista.com>, 
	Leonard Crestez <cdleonard@gmail.com>, "Nassiri, Mohammad" <mnassiri@ciena.com>, 
	Salam Noureddine <noureddine@arista.com>, Simon Horman <simon.horman@corigine.com>, 
	"Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org, 
	Steen Hegelund <Steen.Hegelund@microchip.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 9:00=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> Hi,
>
> This is version 12 of TCP-AO support. The changes from v11 address
> Eric's review comments. The biggest change was defining a common
> (struct tcp_key) that merges tcp_ao_key with tcp_md5sig_key on TCP
> fast-path, therefore in order to help reviewing I provide
> the ranged-diff between the versions here:
>
>    https://gist.github.com/0x7f454c46/fe546b9cf323ca21acc3d0eabbd41236
>
> There's one Sparse warning introduced by tcp_sigpool_start():
> __cond_acquires() seems to currently being broken. I've described
> the reasoning for it on v9 cover letter. Also, checkpatch.pl warnings
> were addressed, but yet I've left the ones that are more personal
> preferences (i.e. 80 columns limit). Please, ping me if you have
> a strong feeling about one of them.
>
> The following changes since commit a5ea26536e89d04485aa9e1c8f60ba11dfc546=
9e:
>
>   Merge branch 'stmmac-devvm_stmmac_probe_config_dt-conversion' (2023-09-=
18 12:44:36 +0100)

Sorry for the delay, but I was looking at a bug in TCP MD5.

I will ask you to fix it, before we change everything in the stack
related to MD5 :/

I am releasing a syzbot report right now, I will CC you on it.

