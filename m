Return-Path: <netdev+bounces-51197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5D47F9844
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 05:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6723E280C31
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 04:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5244B5382;
	Mon, 27 Nov 2023 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDXp0T+m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0566D7
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 20:24:09 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a0f49b31868so61169866b.3
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 20:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701059048; x=1701663848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEXMJLszQDhGfzr5kIVFv32is+ER6kmRxjkrydSVUsU=;
        b=YDXp0T+mETbmKhVRcnrOuO/kH3hF0d5rhOrKpXgHZz89/p6pM1K/jDYC8+/89ZQAr3
         eVY1pfcn0+AlI1llyc+fm/NThRj0DS7i7PYnGUDynxoBounlEV9RlAvVxF60yxcwlVJe
         7MkGTmt11c46fT29s0Z0lw3ha/Nh72KBW2LW5bIxENTXUHOrvVploprbNTOOCRwzot9g
         kDm9m5IxngGgS0Z9eznHbulYklBnmweaI/NN2EWjnItSM30GO3/8bt7E3XE9QioWon4Q
         ysPZ3ZSGv8Tzaeag64m7GgjvUL0daR8mmqwa6ZFDIT/ST6T+zcJdTJsCgE7IV3xfdJCy
         JyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701059048; x=1701663848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEXMJLszQDhGfzr5kIVFv32is+ER6kmRxjkrydSVUsU=;
        b=DY5duur1kSXOQSTlHDHzMkxAdJZXeDfHBU7ixuFOpsgUem4+bAbEJS8nIQ7jyuuEhq
         6Ny6TnHW4FmVIslPLDKJpCeV5ZLCyxFare0VEKhzjft3HHoNQ7xM03poi97SoCgwGGFX
         0WvcqpOimMMl1KDIg0ocR5glhPYTeR60loMfTFFSLjeISU/vsqPOVvJBxmVqOuJrC9Gk
         U66+CVXyUKd4YkEHpjJZ01e9MPioEK3INsQcBduY9paWyp354oA2zDaDkHWU1JeR70Ht
         /z9VYNyuNKH0Oguvp8mIlR/HG0dyh/TzO7wb6IX7jRyfiZPwXDLtE/ASi8DzydVDa0gu
         AiPg==
X-Gm-Message-State: AOJu0YwUmlu0RLALaa9gTlOwbp7kC+52tXJPQKJJkAWCuYBTx4KerwIw
	YHZtMA1sSBtNxzfm2EMjU6P8TifFU9/xZs+7bv8=
X-Google-Smtp-Source: AGHT+IG/zt2iYN62fPrr7sJIYjIfIwWYOBb+ZJ9f7sa30hes5ZUQtO+6rMiz/gP/aDOHh0BWfZHEgafTpBi9gVuqFSQ=
X-Received: by 2002:a17:906:2da:b0:a01:9e72:9579 with SMTP id
 26-20020a17090602da00b00a019e729579mr7688634ejk.60.1701059047934; Sun, 26 Nov
 2023 20:24:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124073439.52626-1-liangchen.linux@gmail.com>
 <20231124073439.52626-4-liangchen.linux@gmail.com> <d26decd3-7235-c4ce-f083-16a52d15ff1c@huawei.com>
In-Reply-To: <d26decd3-7235-c4ce-f083-16a52d15ff1c@huawei.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 27 Nov 2023 12:23:55 +0800
Message-ID: <CAKhg4tKtsDgaNkmcH8RXVTVq_c2-SOxZTsTDTw_KH5FZ+sZuBQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] skbuff: Optimization of SKB coalescing
 for page pool
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	netdev@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 8:16=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/24 15:34, Liang Chen wrote:
>
> ...
>
> > --- a/include/net/page_pool/helpers.h
> > +++ b/include/net/page_pool/helpers.h
> > @@ -402,4 +402,26 @@ static inline void page_pool_nid_changed(struct pa=
ge_pool *pool, int new_nid)
> >               page_pool_update_nid(pool, new_nid);
> >  }
> >
> > +static inline bool page_pool_is_pp_page(struct page *page)
> > +{
>
> We have a page->pp_magic checking in napi_pp_put_page() in skbuff.c alrea=
dy,
> it seems better to move it to skbuff.c or skbuff.h and use it for
> napi_pp_put_page() too, as we seem to have chosen to demux the page_pool
> owned page and non-page_pool owned page handling in the skbuff core.
>
> If we move it to skbuff.c or skbuff.h, we might need a better prefix than
> page_pool_* too.
>

How about keeping the 'page_pool_is_pp_page' function in 'helper.h'
and letting 'skbbuff.c' use it? It seems like the function's logic is
better suited to be internal to the page pool, and it might be needed
outside of 'skbuff.c' in the future.

