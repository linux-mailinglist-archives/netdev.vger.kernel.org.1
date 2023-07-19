Return-Path: <netdev+bounces-19282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD6275A228
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 00:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0117D1C2120D
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 22:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE1422F0E;
	Wed, 19 Jul 2023 22:44:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD51BB38
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 22:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9368C433C8;
	Wed, 19 Jul 2023 22:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689806692;
	bh=2kssSoc8dmR1sBmCByV1ZSZfvwhCK6jKAmlLg5+pibk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=G4xNc01RJGdlK38iEGLFe9NyBvZCxecAZGdvz5PbaMvn2fAQ1nTgCd/PWa4CACq1d
	 Pl9qJEES/APfEruQmdUkMFZ6e/95NI6m/6qDZGg4mu58D8N9q6LtuOrOjvvV/KZBOE
	 tStMW0xrD5EMy1zivJAXU3IY+0w+G+Kx6aSezzPiKZw6oikEDuPaRKI8s+G13wTiMU
	 BH06NuO7TsxZ0P7pmnUPFitOO3nu9XGNR8bIoo3OG/faCcd//sJ3V93EDh94RV9un8
	 7az8DT9gsxBygK+ki2dbzonGNTMw+KHq81K3ebGwnkcEsrHtQ/tyW2BvLeOs2j7wf6
	 f/+m+0egtL/jQ==
Date: Wed, 19 Jul 2023 15:34:33 -0700
From: Kees Cook <kees@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Breno Leitao <leitao@debian.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_v1_net_1/2=5D_af=5Funix=3A_Fix?= =?US-ASCII?Q?_fortify=5Fpanic=28=29_in_unix=5Fbind=5Fbsd=28=29=2E?=
User-Agent: K-9 Mail for Android
In-Reply-To: <64b8631b8f1b0_286a73294cc@willemb.c.googlers.com.notmuch>
References: <20230719185322.44255-1-kuniyu@amazon.com> <20230719185322.44255-2-kuniyu@amazon.com> <64b8631b8f1b0_286a73294cc@willemb.c.googlers.com.notmuch>
Message-ID: <3DADE655-EE51-4DB0-8CEC-C3791AB12129@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 19, 2023 3:26:35 PM PDT, Willem de Bruijn <willemdebruijn=2Ekernel@=
gmail=2Ecom> wrote:
>Kuniyuki Iwashima wrote:
>The extensive comments are really helpful to understand what's
>going on=2E
>
>An alternative would be to just cast sunaddr to a struct
>sockaddr_storage *ss and use that both here and in unix_mkname_bsd?
>It's not immediately trivial that the caller has always actually
>allocated one of those=2E But the rest becomes self documenting=2E

I would much prefer the internal APIs actually passed around the true sock=
addr_storage pointer=2E This is what I did recently for NFS, for example:
https://git=2Ekernel=2Eorg/linus/cf0d7e7f4520

-Kees


--=20
Kees Cook

