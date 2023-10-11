Return-Path: <netdev+bounces-39898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E7C7C4C01
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 09:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1EB51C20F56
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 07:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5DA199C2;
	Wed, 11 Oct 2023 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NcJMEOlo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17035199CD
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 07:36:38 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E7F92
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 00:36:36 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-405459d9a96so59295e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 00:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697009794; x=1697614594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3lFWh781xYY7UBYZo3gwot3jntiLV0/xMAh/ilRLeU=;
        b=NcJMEOlogNybvoIe9WeMb1EpRh+i7MmxWQmrtilxAQQuyFwPmryBNajD/9l2U/JmyA
         OGnjn6phsD0vO5G57EkFS8qXKJLzrETodQZ0YMgeL7PFPRr601NUglRtg6vBDO4EB9HG
         6DxBvdpe1XyiWFICMeEpsf793s27URZ2L8KIpw5xz198LOWCXphjSQYT5l79paqZO/pA
         1cJuzN8DcqR2qKNHI5osvfg5HjBYjdxjInWULVwcyygmmJ81lDpN1DgSgq8cvmrNRbQF
         pQHXNngpwa3Mcwo4tKzxty2kyH9pyx6rwPm+qkpdmwmxxVAA6PC/YK3Nv3bHa5YxWuNk
         1bQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697009794; x=1697614594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3lFWh781xYY7UBYZo3gwot3jntiLV0/xMAh/ilRLeU=;
        b=jq4YuhCZTnAnVeuBrXRbXuItb8tZ4io50pGWF49dtoUsJ5XkxRruvIrkgFf/X7yEy1
         i7HRX5O8r/vAH3sH3mNoE53Qe84o7NrwxsONWd6fHfNuEB2zLNZqbhdgeuSao7C3VTl4
         zotaSyc20f8xqITNLzaYkKUJEJsPhN43K+hGN+sjsPbJqd9zxOd876XGjSk6ko9ADUOx
         USmLJHlCKazr0VxEUBRNgpfnsdwSmOn4R2B0tIrelZwIKw7W7FFJpaJMMd5s01vra1vJ
         Ls7b/BdSXYILGUSUfjOJtUEE7tkMr6XD5J5DCpULkzsidGqkhqBZWLRGRXalyh7VZEYN
         BMhg==
X-Gm-Message-State: AOJu0YwHlWG3hAIXKt7IC2mAOHgUzl8sHsD/r/GuD/2mByhCIVfkcS6/
	e/NtG0O+o0MgtRFt36nhTHV8r1ZPu42THBMrExN+uQ==
X-Google-Smtp-Source: AGHT+IHd1FC12oP8K/bhyPo57fL7dJJP0CmKIJrsD//FTJm0zEPgpb+gDmyCUoIzdC7GE18ieSCxHVGqMhnz6z6GDEA=
X-Received: by 2002:a05:600c:3b9b:b0:400:46db:1bf2 with SMTP id
 n27-20020a05600c3b9b00b0040046db1bf2mr78309wms.2.1697009794407; Wed, 11 Oct
 2023 00:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
In-Reply-To: <f3b95e47e3dbed840960548aebaa8d954372db41.1697008693.git.pabeni@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Oct 2023 09:36:21 +0200
Message-ID: <CANn89iL_nbz9Cg1LP6c8amvvGbwBMFRxmtE_b6CF8WyLGt3MnA@mail.gmail.com>
Subject: Re: [PATCH v2 net] tcp: allow again tcp_disconnect() when threads are waiting
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, 
	mptcp@lists.linux.dev, Boris Pismenny <borisp@nvidia.com>, Tom Deseyn <tdeseyn@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 9:21=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> As reported by Tom, .NET and applications build on top of it rely
> on connect(AF_UNSPEC) to async cancel pending I/O operations on TCP
> socket.
>
> The blamed commit below caused a regression, as such cancellation
> can now fail.
>
> As suggested by Eric, this change addresses the problem explicitly
> causing blocking I/O operation to terminate immediately (with an error)
> when a concurrent disconnect() is executed.
>
> Instead of tracking the number of threads blocked on a given socket,
> track the number of disconnect() issued on such socket. If such counter
> changes after a blocking operation releasing and re-acquiring the socket
> lock, error out the current operation.
>
> Fixes: 4faeee0cf8a5 ("tcp: deny tcp_disconnect() when threads are waiting=
")
> Reported-by: Tom Deseyn <tdeseyn@redhat.com>
> Closes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1886305
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

