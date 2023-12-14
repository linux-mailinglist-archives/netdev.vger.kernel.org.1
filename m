Return-Path: <netdev+bounces-57552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B8A813600
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B391F2213A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6865F1DF;
	Thu, 14 Dec 2023 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SwVM9ldH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FAF12A
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:16:28 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1fb9a22b4a7so4942074fac.3
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702570588; x=1703175388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PbRjTBgX8BFxA9/J0vk+pjURu8qRhIKqhgUQ/E0mRY=;
        b=SwVM9ldHg21P9+cJX0gFq4nPXsRu9minEGm0UeA/+y/8IvCQSwIkvL9WfZA/1p4DX+
         UEVZM2zeJ8N/RTi2E+p00nbMjwnXgV6QT7MoqoZQaMlVnHbqzg2AuR89to9C03GTZc0s
         gxSMaChFqnA6SY0d5gd2wtInrCwNkFcFMQ+1Vcp4soDiqTqe4T6w+xKKSrYPlXpSWiZl
         3svAhhC0E4WURCx/BnKEubKE5i7r5LaGq69DManMw49Gk8GS+81FoPI0F7DIlKRjxkU7
         lGZokWSoKRv8+2WAWvC1+Nhx01LdOXR+Jyy/H4FiIaAFmAiDmbUyqpcC4m+aSw+62y1L
         JV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570588; x=1703175388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PbRjTBgX8BFxA9/J0vk+pjURu8qRhIKqhgUQ/E0mRY=;
        b=HtJf2dWs0HoLMDSY6PeWcyql1/McT+E4rdK3jflJmqJKCNw9SfkgWDyZ3fUFJtNYcU
         NByzO1/IBVY6/678PGeSL5tGZkrg3TeSYc5Uy6b12sxTEkIBY8wnvHDc1XH3Q+SV4+0N
         +Wf4/fa7zsa296w71u3TdWxHiQZlZJAQa2NIXe1noiPjhxqoCIUKq6Ni0Qrn+yx9rv5z
         uISdWo9gM60TDAfG2P4NXa1IqYKDR4ylczHep1ZM1EWxHvImSCUQ420r5taIwHT4kdKo
         KKUOISvNlfgfRPXxBjyF6DpP/BLd0SDSVECZrStkLGfHJ+6AKDwVs2gO8U4heynSsXrX
         6Lfw==
X-Gm-Message-State: AOJu0Yz0DwWdDcrYCZlwjjg9JfVeBoEirBa/gtyM3jW6z5Sj1EpcSEIY
	3jjd+dq/5fIsSoLMS0e+xapoVK9ku2eICuvVCBXkOQ==
X-Google-Smtp-Source: AGHT+IEcAC1aBVy2eIZ27/CHhn1kikfWBJVB4hiR/CtJKw2SKRD7W/8k6ojVqoRK6/jkhs5FG54sdSfmaw/qWQguXK8=
X-Received: by 2002:a05:6870:f10d:b0:203:5e76:1d7 with SMTP id
 k13-20020a056870f10d00b002035e7601d7mr65521oac.3.1702570588126; Thu, 14 Dec
 2023 08:16:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214104901.1318423-1-edumazet@google.com> <20231214104901.1318423-2-edumazet@google.com>
 <657b09ab4f6ef_14c73d294b9@willemb.c.googlers.com.notmuch>
In-Reply-To: <657b09ab4f6ef_14c73d294b9@willemb.c.googlers.com.notmuch>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 14 Dec 2023 11:16:11 -0500
Message-ID: <CADVnQyk4vV_Tqy6YBON6ic15x+SjHgMmrHm6eC4xry1qy1vrmQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: increase optmem_max default value
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>, Chao Wu <wwchao@google.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 8:57=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > For many years, /proc/sys/net/core/optmem_max default value
> > on a 64bit kernel has been 20 KB.
> >
> > Regular usage of TCP tx zerocopy needs a bit more.
> >
> > Google has used 128KB as the default value for 7 years without
> > any problem.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Acked-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

