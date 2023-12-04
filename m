Return-Path: <netdev+bounces-53373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4C4802A5D
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 03:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2538FB207E3
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 02:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A56814;
	Mon,  4 Dec 2023 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+a06eaW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FFDC5
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 18:39:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c09f4bea8so6565315e9.1
        for <netdev@vger.kernel.org>; Sun, 03 Dec 2023 18:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701657590; x=1702262390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dfz0Ks2PRw0kDFC2Xm3+U40UH9uP9UDmB61v+FGJdTc=;
        b=a+a06eaWWWfjXlNdIAplZKNA4KhS4VtmECm2eIu7py0wNoP+1GiE9JrnS2KjtGBes8
         VFul+HZrOxk0yz/8qkjYzwhMmcMAWYMnwy4+YWM3kifN9pjN/9OO66OMWQKQWrtjS2bR
         LYo68QtAZAE7EjrTS+XqXB+6gVnxBd/BPugLjPpyeTYKHunfDMNtMjCuj8o4hM1MLvIX
         UeNzPwf1J7WVICsVfHJy5bT9f2sS6IsxwRDuA9+90YPhWx7FsLl0GFyEFWjdRYOb0gfW
         35170K05C2wMOyhXQU1fMj4ovgsVL8lLM9eryXktdy3403stvAl50+a0xTHW5P6dztY0
         fPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701657590; x=1702262390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dfz0Ks2PRw0kDFC2Xm3+U40UH9uP9UDmB61v+FGJdTc=;
        b=bmGflP0TW5Qc9B9tVc6i/RoLm8Bwg4ZHhkMv65YLPAFFELNwcSAuQQ88YeKbVHgynb
         MbyNnRynLfaiPqaTr+oFeV2uGefHSN9kGosdKH0xA8VDhAq9Wzt7JyAx9puTjPvVk09a
         aGfpNQU/IR6QLbG6O4CHPiqq3UxvhXbUP5m4ob6dNC0GBhOWkjFFV4WoZMhyf/KCX9tK
         8Zi81v3js25OI1CtQH+HylJsTkkCBXfIWqRznCrbQb3ZRTL970REfMtxsOaE/Pxh5dtt
         Z8pSMXp5Chf1VpGIY5rj+FUt9vm43fFljg4slsMdF2TU0OPs7OKHf8dx049LjSd4obg/
         skkw==
X-Gm-Message-State: AOJu0YxdqaO3cILHea0wfWNaGhRUUOJDlQUj2jFNwLdaMJ3Q5wqsWVWV
	0B22FG8aoqE7UQrxrPyl8IMKtCHg8VoqPn/k+pZ5u2Rjd9k=
X-Google-Smtp-Source: AGHT+IHEdjUs9NMZMqDR/WRU71LvtdSqf4Q9Mf1YHsziCYTtEORAeCqrXOcnLKk7qL8OoYrQMRBOAOKCO8G9+GgfUMs=
X-Received: by 2002:a05:600c:5488:b0:40b:5e1c:af27 with SMTP id
 iv8-20020a05600c548800b0040b5e1caf27mr2062873wmb.45.1701657589842; Sun, 03
 Dec 2023 18:39:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130115611.6632-1-liangchen.linux@gmail.com>
 <20231130115611.6632-2-liangchen.linux@gmail.com> <CAC_iWjL68n-GRN7vs_jwvzbnVy8sPh4_SP=wVDq0HkFOmSU-nQ@mail.gmail.com>
 <CAC_iWjKBE5s9iiTPKgsoDx5LSWjsSXE-7SSPSk+EVJXLC10-GQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKBE5s9iiTPKgsoDx5LSWjsSXE-7SSPSk+EVJXLC10-GQ@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 4 Dec 2023 10:39:37 +0800
Message-ID: <CAKhg4t+6wFv-sAu5jT2rTVjZt76uV3JS7rQ27qNvi+k_rxAVRQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/4] page_pool: Rename pp_frag_count to pp_ref_count
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 6:10=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> re-sending as plain-text, apologize for the noise...
>
> On Fri, 1 Dec 2023 at 11:59, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Liang,
> >
> > On Thu, 30 Nov 2023 at 13:59, Liang Chen <liangchen.linux@gmail.com> wr=
ote:
> >>
> >> To support multiple users referencing the same fragment, pp_frag_count=
 is
> >> renamed to pp_ref_count to better reflect its actual meaning based on =
the
> >> suggestion from [1].
>
> The patch does more than what the description says and those should be
> in 2 different patches.
> I am ok with pp_frag_count -> pp_ref_count, for the functions I am not
> sure the rename makes anything better.

Yeah, the description doesn't adequately convey what the patch does.
Before proceeding with splitting the patch, how about changing the
description to the following?

page_pool: transition to reference count management after page draining

To support multiple users referencing the same fragment,
'pp_frag_count' is renamed to 'pp_ref_count', transitioning pp pages
from fragment management to reference count management after draining
based on the suggestion from [1].

The idea is that the concept of fragmenting exists before the page is
drained, and all related functions retain their current names.
However, once the page is drained, its management shifts to being
governed by 'pp_ref_count'. Therefore, all functions associated with
that lifecycle stage of a pp page are renamed.





>
> Jakub, are you ok with the name changes or is it going to make bisecting =
a pain?
>
> Thanks
> /Ilias

