Return-Path: <netdev+bounces-48260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB47EDD10
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 09:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00251F23D1D
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA5FD2E4;
	Thu, 16 Nov 2023 08:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ba1PJ5xS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D7CDA
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 00:44:19 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so9447a12.0
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 00:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700124257; x=1700729057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15Ckw1RtaRbBRvnRVWh1ML35SM8E8zgJILg29jp+Kk8=;
        b=Ba1PJ5xST+5KadfEw0wJqatM9FQU51DTPhKxQiGpsd+JUsP3bAAkvIykt51SrqpHgw
         mLyMv+vBW6hiFlhmXZUOuv10NPzKiz2OrTWdYHvlNOlrOB9pfxrfU//i0ysbxPLClaNy
         8m8aVTK3SFXA/coHCmXKYpk0GVD1z5RrkeqspUjYDxyTl6TCjfmjuB0qRug22b90luVm
         q2Hp6rDBPmUpUYUCEDBKR7XcrWWwYPoTqWWrfTe0BLl64RteN0VqDm4RoZ+toC7DeTYA
         BPUf0wxU0U2EwAQXCulAnpXmpm3kjarTXPTkz/tAynHRbaZ6L/hUcFNZLo57PH0dhiFr
         Qr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700124257; x=1700729057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15Ckw1RtaRbBRvnRVWh1ML35SM8E8zgJILg29jp+Kk8=;
        b=A77QZQN6PSGQNchEtHgXrVCGgPG5NjQT/25RM+4j+lBuSXSlsKu3Jo1NQBpBLfUEmh
         qSxDhwGMeyY1eoLTPQ+MEjZ+gYqZt0Dj+c2Ip3clHniA59X6paelAiDBoCt313UCAkL7
         x/KHOrs34Iv1y9NFVP8OgjFfU5nkGUMeBJzoLuThuVMwVMIQhhCAYusfUJIFQWKO0s9o
         /oAYTepfy2HArh51ee+xhnp9vjkY5FR2i/eXUyIIyUv+rjDePDyxfsmbA0tgiPmUXSFU
         0+qV2YkM8HYtoj+OlxDL76r+rsNnfNrHkg3aUvNT8aBEBDpLWZO8A4OsUrItCwwiA6jq
         ciUg==
X-Gm-Message-State: AOJu0Yzh/35GkgzH2l62vWQWDaRyuV7PN//H4ZgIlPwpQqr9ysax80PV
	+i3a9/ivgd68uHcdFgYIrwxVtDE80X1uGxcVkM558g==
X-Google-Smtp-Source: AGHT+IGVPb2NZqiKSwpNNjNi9eEikFGWD/JhfnBt7Ryi+ZjxJ3E2ljCxv4wI4vNKiW8ZBbdf1eIjFLQm7FM8SiR1Xc0=
X-Received: by 2002:aa7:c592:0:b0:545:2921:d217 with SMTP id
 g18-20020aa7c592000000b005452921d217mr81119edq.6.1700124257443; Thu, 16 Nov
 2023 00:44:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116022213.28795-1-duminjie@vivo.com>
In-Reply-To: <20231116022213.28795-1-duminjie@vivo.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Nov 2023 09:44:03 +0100
Message-ID: <CANn89i+B2gNO7-Mnai59Tpn44tomfLN1m9NnSEMq-qkt7AyyRw@mail.gmail.com>
Subject: Re: [PATCH v2] net/tcp: use kfree_sensitive() instend of kfree() in
 two functions
To: Minjie Du <duminjie@vivo.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:NETWORKING [TCP]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 3:22=E2=80=AFAM Minjie Du <duminjie@vivo.com> wrote=
:
>
> key might contain private information, so use kfree_sensitive to free it.
> In tcp_time_wait_init() and tcp_md5_twsk_free_rcu() use kfree_sensitive()=
.
>
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>

You have not addressed my prior feedback.

3) You forgot tcp_time_wait_init(), tcp_md5_do_del(), tcp_md5_key_copy(),
    tcp_md5_do_add(), tcp_clear_md5_list().

