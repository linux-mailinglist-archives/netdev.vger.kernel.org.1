Return-Path: <netdev+bounces-57190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCA8812541
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0E51C20AA9
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8637F9;
	Thu, 14 Dec 2023 02:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUzNkWj+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD69B7
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 18:27:01 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1e7971db2aso882252866b.3
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 18:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702520820; x=1703125620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BY8e/SFb9V+otPXNlhB6x6Lcjib+XLpc12tNaO8DAF0=;
        b=gUzNkWj+RBqu0hLEcGaEg5L0njfcNRKa5Uqsw1jc4tj3eVgyXJfV8reCdx+0Fj/omT
         J96RnWoax537R0VXnqcy6qy8Eth1zOcgpHcnmo3jCTUwoPuSCG0wr5WCBjXmruN1eFrV
         KAk3/73NrRRYfPXlLSuOjepgRGCvDDv2RE+6AVuaIj8a28+XZO6rxvh/JuAREzHkamCF
         26kMT2+em7lmEBrah2Vo1agpJamD9Bfm2ISuDKhhU8l7WgvTnOOcKZCa2Aq0TxcSYlNc
         GwmX8y3c/wbibfwtBEl0S6uP1eWcNfJRx77LArWEiXL3RKbmsYARHXPHkIH7bxzKUD9k
         7trQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702520820; x=1703125620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BY8e/SFb9V+otPXNlhB6x6Lcjib+XLpc12tNaO8DAF0=;
        b=krys+hawPjlDOSaqxoXqugcPKnbA7d/hv3nIWAzw6SQnLLla/MswwGFIYodkxvfKWw
         xdHUIbd8FsF1PmysCXjxtPGa1sCmivZkIpOKqvjp6wQbWM0+L1WroWfqfS0DVfmMFoQa
         WCLloy+TEZ75rM/h635GCh2U67xF+T3kJDXro8fSyi+Fye7LHNykHzJxGevpI5hwgUIo
         vWpfYJ+unEXodDwhJrtdxcF+B4RjYHQkw807pMMIkSjV3t8qLGlidlmXG5b5G53xLRzF
         7KLJj4/Y9vrbYjjJWh0sQSJSbzhkw7ubxPAv1rYZJ1rqXfhfedLBSPhK32fBAYAOeA3r
         gN2w==
X-Gm-Message-State: AOJu0Ywf3DA7Y+lePQFftEFe9JWCPYOV1At0nt1oPMPmCKGC5wxu8K8N
	ghffgTQdAacJ/Nk7jAZidsw4/NJMCjWa/BCoo3w=
X-Google-Smtp-Source: AGHT+IGHHIsnPQqjhXQ00nnF8wggHPKBNluUlTFo1aEq1VBHfAT0cBgC3Kp8krR0AYST0kQbsonBLQ1GFS4lvJk8gKk=
X-Received: by 2002:a17:907:9058:b0:9e7:3af8:1fcd with SMTP id
 az24-20020a170907905800b009e73af81fcdmr3683212ejc.76.1702520819802; Wed, 13
 Dec 2023 18:26:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211035243.15774-1-liangchen.linux@gmail.com>
 <20231211035243.15774-5-liangchen.linux@gmail.com> <CAC_iWjJX3ixPevJAVpszx7nVMb99EtmEeeQcoqxd0GWocK0zkw@mail.gmail.com>
 <20231211121409.5cfaebd5@kernel.org> <CAC_iWjK=Frw_4kp-X+c4bN7e19ygqsg78aiiV2qJc59o7Gx8jA@mail.gmail.com>
In-Reply-To: <CAC_iWjK=Frw_4kp-X+c4bN7e19ygqsg78aiiV2qJc59o7Gx8jA@mail.gmail.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Thu, 14 Dec 2023 10:26:47 +0800
Message-ID: <CAKhg4tJDgaVeMp437q1BHuE3aZo2NU4JnOhaQEXepJuQhPnTZQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 4/4] skbuff: Optimization of SKB coalescing
 for page pool
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, hawk@kernel.org, linyunsheng@huawei.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, jasowang@redhat.com, 
	almasrymina@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 3:10=E2=80=AFPM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Jakub,
>
> On Mon, 11 Dec 2023 at 22:14, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon, 11 Dec 2023 09:46:55 +0200 Ilias Apalodimas wrote:
> > > As I said in the past the patch look correct. I don't like the fact
> > > that more pp internals creep into the default network stack, but
> > > perhaps this is fine with the bigger adoption?
> > > Jakub any thoughts/objections?
> >
> > Now that you asked... the helper does seem to be in sort of
> > a in-between state of being skb specific.
> >
> > What worries me is that this:
> >
> > +/**
> > + * skb_pp_frag_ref() - Increase fragment reference count of a page
> > + * @page:      page of the fragment on which to increase a reference
> > + *
> > + * Increase fragment reference count (pp_ref_count) on a page, but if =
it is
> > + * not a page pool page, fallback to increase a reference(_refcount) o=
n a
> > + * normal page.
> > + */
> > +static void skb_pp_frag_ref(struct page *page)
> > +{
> > +       struct page *head_page =3D compound_head(page);
> > +
> > +       if (likely(is_pp_page(head_page)))
> > +               page_pool_ref_page(head_page);
> > +       else
> > +               page_ref_inc(head_page);
> > +}
> >
> > doesn't even document that the caller must make sure that the skb
> > which owns this page is marked for pp recycling. The caller added
> > by this patch does that, but we should indicate somewhere that doing
> > skb_pp_frag_ref() for frag in a non-pp-recycling skb is not correct.
>
> Correct
>
> >
> > We can either lean in the direction of making it less skb specific,
> > put the code in page_pool.c / helpers.h and make it clear that the
> > caller has to be careful.
> > Or we make it more skb specific, take a skb pointer as arg, and also
> > look at its recycling marking..
> > or just improve the kdoc.
>
> I've mentioned this in the past, but I generally try to prevent people
> from shooting themselves in the foot when creating APIs. Unless
> there's a proven performance hit, I'd move the pp_recycle checking in
> skb_pp_frag_ref().
>

/**
 * skb_pp_frag_ref() - Increase fragment references of a page pool aware sk=
b
 * @skb:    page pool aware skb
 *
 * Increase the fragment reference count (pp_ref_count) of a skb. This is
 * intended to gain fragment references only for page pool aware skbs,
 * i.e. when skb->pp_recycle is true, and not for fragments in a
 * non-pp-recycling skb. It has a fallback to increase references on normal
 * pages, as page pool aware skbs may also have normal page fragments.
 */

Sure. Below is a snippet of the implementation for skb_pp_frag_ref,
which takes an skb as its argument. The loop that iterates through the
frags has been moved inside the function to avoid checking
skb->pp_recycle each time a frag reference is taken(though there would
be some optimization from the compiler). If there is no objection, it
will be included in v10. Thanks!

static int skb_pp_frag_ref(struct sk_buff *skb)
{
    struct skb_shared_info *shinfo;
    struct page *head_page;
    int i;

    if (!skb->pp_recycle)
        return -EINVAL;

    shinfo =3D skb_shinfo(skb);

    for (i =3D 0; i < shinfo->nr_frags; i++){
        head_page =3D compound_head(skb_frag_page(&shinfo->frags[i]));
        if (likely(is_pp_page(head_page)))
            page_pool_ref_page(head_page);
        else
            page_ref_inc(head_page);
    }
    return 0;
}

/* if the skb is not cloned this does nothing
 * since we set nr_frags to 0.
 */
if (skb_pp_frag_ref(from)) {
    for (i =3D 0; i < from_shinfo->nr_frags; i++)
        __skb_frag_ref(&from_shinfo->frags[i]);
}

> Thanks
> /Ilias
>
> /Ilias

