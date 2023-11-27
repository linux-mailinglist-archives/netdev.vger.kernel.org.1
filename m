Return-Path: <netdev+bounces-51195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706427F983A
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 05:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2119B20910
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 04:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0BA46BC;
	Mon, 27 Nov 2023 04:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krmkDBPh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBDCF0
	for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 20:21:47 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a02d91ab199so510500066b.0
        for <netdev@vger.kernel.org>; Sun, 26 Nov 2023 20:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701058905; x=1701663705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsv7V/+CFL/XESr1bE2Qe/WX9Bo+trNfwMKc9YwhQsc=;
        b=krmkDBPh9ihJhi8Z0MIW2qZQJDtxNg03wkUXANwkcOjq1GfwLCO7bPluvXMEfMvuCP
         tHZdErPr9VGdkV0il9sSYA2toVpmJ3rCCddCsSdEHvHIh+dE0DZxe9GQZAq5TOsV8hAj
         nUZhMECRzy2GiozXibyyaJXFpJGHZCvzPCRZRQvheGPBMcIKXLgV6P5tW5cDmZoC4UZ9
         JsZjwPs1E1vzoMmA9scZEQBdUde4IqPbh1iMkmQ1ILsC96B9+FdX7shXqNW1VliuZrjl
         H14ykZu1HQ9sNAQDyVpmmu3Uarfa69Nq/lUOvAy1O4w4bSvMVvrKkaVxaW8kTGFd1gGn
         IOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701058905; x=1701663705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsv7V/+CFL/XESr1bE2Qe/WX9Bo+trNfwMKc9YwhQsc=;
        b=Anid6ZIQ4UWyI4pVWWybUt3MyPLKVG8wuD677KDKWYVTuZz/aIVYnT3cUtQ9oFRf8I
         oUP25TMmp0OMsCdNA4YfVXDqYjyQk5AAegpvYIwewRJzprpupl8xh66NziY66oWPiKDe
         j5WI3LZGdMly3nWz1sdEsnoTYlaaqYQxBEF3SduVfy7PeKKu0TIj6q2tx73cKed99+Bj
         hgR4AlWqbzRjk7AIVZekXtfIQM17xwMjqfVjjRantpIm/1wI6oOkyfm+MZQd7+qnNTql
         Bp3pRSOLbNpm72/OiH7Z0U0nMvM1wSe+YvzXoV3r7MwakurHE2m1rqt1yGV+ZeZogD1U
         c8UA==
X-Gm-Message-State: AOJu0YzvFtE14iV91hd2jETNLhyrIzamX4fq8rQGzDJeZfKafxgj8GBn
	zFjb2HIQOSaW9E8IggvJ6F794NYYTW2hYPqrgbc=
X-Google-Smtp-Source: AGHT+IG/szwsRgL8UUwXgmTwWcL7KFdHiJr+LufYok/M2MBcFRmqPQIg8QF1WLoo9gtXWATdG4HQTwbVwpWsTPvZGVs=
X-Received: by 2002:a17:906:590e:b0:a04:837e:a955 with SMTP id
 h14-20020a170906590e00b00a04837ea955mr6958384ejq.32.1701058905255; Sun, 26
 Nov 2023 20:21:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124073439.52626-1-liangchen.linux@gmail.com>
 <20231124073439.52626-2-liangchen.linux@gmail.com> <a45e4183-3ac3-2853-810a-63c7277d6318@huawei.com>
In-Reply-To: <a45e4183-3ac3-2853-810a-63c7277d6318@huawei.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 27 Nov 2023 12:21:32 +0800
Message-ID: <CAKhg4tL6TQD+xABr_hd6knQrMwfWjPm_L_SUuJ1WLaBbpss+0g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] page_pool: Rename pp_frag_count to pp_ref_count
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	netdev@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 7:53=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/11/24 15:34, Liang Chen wrote:
>
> >  static inline void page_pool_fragment_page(struct page *page, long nr)
>
> It seems page_pool_fragment_page() might not be a appropriate name too?
>
> Perhaps it might be better to grep defrag/frag to see if there is other
> function name might need changing.
>

Our understanding is that the concept of fragmenting exists before the
page is drained, and all related functions should retain their current
names. However, once the page is drained, its management shifts to
being governed by pp_ref_count, and there's no longer a need to
consider fragmentation. Therefore, all functions associated with that
lifecycle stage of a pp page will be renamed. With that in mind, the
following functions have been renamed.

page_pool_defrag_page -> page_pool_deref_page
page_pool_is_last_frag -> page_pool_is_last_ref
page_pool_put_defragged_page -> page_pool_put_derefed_page

> >  {
> > -     atomic_long_set(&page->pp_frag_count, nr);
> > +     atomic_long_set(&page->pp_ref_count, nr);
> >  }
> >
> > -static inline long page_pool_defrag_page(struct page *page, long nr)
> > +static inline long page_pool_deref_page(struct page *page, long nr)
>
> page_pool_defrag_page() related function is called by mlx5 driver directl=
y,
> we need to change it to use the new function too.
>

Yeah, that change is right at the start of the patch.

> I assume that deref is short for dereference? According to:
>
> https://stackoverflow.com/questions/4955198/what-does-dereferencing-a-poi=
nter-mean-in-c-c
>
> 'dereferencing means accessing the value from a certain memory location
> against which that pointer is pointing'.
>
> So I am not sure if 'deref' is the right word here as I am not a native
> english speaker, But it seems 'unref' is more appropriate here if we mirr=
or
> the napi_frag_unref() function name?

That sounds better to me as well. Thanks!

