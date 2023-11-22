Return-Path: <netdev+bounces-49943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957AE7F4050
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6ED31C208E1
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 08:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B6A15AE6;
	Wed, 22 Nov 2023 08:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eu12cHh7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E364F9
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 00:38:45 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so10846a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 00:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700642324; x=1701247124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEExvhcg3Mouj3bcx+bl6Kvho4NQYN2gg37RHgg68l0=;
        b=eu12cHh7mP+cnQlOdam/64HaoRmtrAUUY69jSR0EZ0TaPlgJi+a2bsjqxsdPO1Km45
         bWNgkHA/w8dg+WD6o28Qa5SjRAdq7sGYZKfFPY75nkIMyXMNf+7RUrQAOfSsZ4ETj8Z2
         sw+SBWV6tFt/fXFxMu73/xJfjtF00M5EyEPzw8qRb+lgxNNnzfnNNX7UgIZU8HZ82N5p
         wJtVUa0WPqPz8p/8Ncwrz50NRyNNl3Km5FjzCsbA+jkvCmSGMgULk/OR1pTijrFGi0M5
         PPd37pov5OouKDQ3Qr/6wpl0kFiNK5N+vB2IYIasrupV0DRvaXid+h2BdeTU5Rpk8NkL
         P6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700642324; x=1701247124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEExvhcg3Mouj3bcx+bl6Kvho4NQYN2gg37RHgg68l0=;
        b=dxqaG+cUI5+XdROzUbK104KhuYw4uP/nLRuWz9GeALLklbGAQonuMDwEg9SnYTDLmd
         qKeq9X7h+9mPo4uA9QqJ4fCFBRs0JUaaJsp7LbLBu5ZRfc2Y5lrEJlGsiRb84zOQ/cfH
         MAQyb/Id2xgSto/2hkUFSsLM6+6BkeHdZpZQTbBBWvxhMUHphLmDOvCcgqyJ6chaD1cS
         +T9RJVhnauYIt5L16uuFfmsUoAqvssVc8yrm58MQxKt6A0iRB6aauo6KY+rE9thHHskO
         R7a7sZl1QBZEwYvYDEuyJXvMnz4mTVe6bdOifArhVAnlx2YquJQ8buMM4jHZkPueAww2
         jbhA==
X-Gm-Message-State: AOJu0YzFR1tDRbiVts27QBbOkmVw8V9xT64Pt0ch6eRbhil/Sx7TvQL1
	swQxm/F5bVLakt7AwNss3rARWHv2oXb2zWp6Q+VhtQ==
X-Google-Smtp-Source: AGHT+IE8VcGu9QZprlXtZrFsytdTCoN97pYgkzSXBVYwPsyDVhw0ZmNMz0IA1uxxzSN+oKUkJYKFeKJUJgKXacU0q4M=
X-Received: by 2002:a05:6402:1cbc:b0:547:3f1:84e0 with SMTP id
 cz28-20020a0564021cbc00b0054703f184e0mr64613edb.7.1700642323514; Wed, 22 Nov
 2023 00:38:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122034420.1158898-1-kuba@kernel.org> <20231122034420.1158898-2-kuba@kernel.org>
In-Reply-To: <20231122034420.1158898-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 09:38:29 +0100
Message-ID: <CANn89i+bykN3d8nV+x7380HdKOUTn_Gf496hU=J9KW95t84RPg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/13] net: page_pool: factor out uninit
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> We'll soon (next change in the series) need a fuller unwind path
> in page_pool_create() so create the inverse of page_pool_init().
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

