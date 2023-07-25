Return-Path: <netdev+bounces-20947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B4761FC1
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 19:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4B01C20F1C
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F32419B;
	Tue, 25 Jul 2023 17:04:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535283C23
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 17:04:54 +0000 (UTC)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24E0E3
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:04:52 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-583e91891aeso34261027b3.1
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 10:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690304692; x=1690909492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XERQiYNhLQwx0hBirsUe65oIF9zePRWOiZqJN1BZgZY=;
        b=Z1nI7kK5m2Wb3nz2mpC8yMsGzy9bWn3hKUS+w+ROi3P/WUx8+y3aicg2rGN5CNmps+
         0X4b2UybQWOynwLXprHdvd+LwinyeHaq/LDp6tFEK0yaDyYqZePJ6t2OWUCLqq5QXa0E
         LVGCMVuXBElWCe4Z44BUcNrE8FiMGFIWt3nFBELGyn1lyIRQx9K9hWZZrJTMMSU5os1z
         UWRatRBNy4KfPC5gjo+OMIcT9g3XPprbkF6IgcYju3h0krYoxtkxowA/QTb1e4BN/6Fu
         XADpaAp1fcEMrhlGcl8Aq+BkA3HS6cztaIJIWFB7XjUa9VTe1aQbzbaR/EZVfvqtKHS8
         OTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690304692; x=1690909492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XERQiYNhLQwx0hBirsUe65oIF9zePRWOiZqJN1BZgZY=;
        b=gjKad8sNqZ9Rc+ssbjtjrHrDCswVK5kQCHG67BWEOPYsg4IJAaVuW7jjMv1l7SYeZM
         1JFUC54CxnQI2Aa8pEPulc30V18VYfq4ZwNICsQzpUUXBQNhxt2ZnLw4EWOcWdCVi2Sm
         DBaCzYyIDq6C2DKfFsAuiMj8vXC36EUzfEJqhsXkjyzdalgLs5py+n+6LiyvVVSKXGMm
         6lvv1lFDd0AXEPL2Wo5O/CFaNhzPJvPN2KWvqMuui2MZEWdwKyHXQti19far2fRgA701
         4GgllEsP3Ap2HmIpKU/2Vi3CpQ6v6GY/RRUHPKXs2rsV5pFnu6ifia+lkJIc94QvBvgO
         Sbog==
X-Gm-Message-State: ABy/qLYCZHyoL7AbPZHnGSG2h7DfhQv8Fsj4JnIfYe6zHlZt9Nw1QteO
	kv255/lIYalzjfn3Cy6APMbUU0Q4bc8Jq+6RvNhB6Q==
X-Google-Smtp-Source: APBJJlEOe37Wh/VQMi5tu8NQMtlMpLnO5Rp+5W/tFl0SXnMSzyJmjVFgxbFhEmp/OWOGqm3zYtz9LNUeCTasNpHnV0Q=
X-Received: by 2002:a0d:d884:0:b0:583:8c61:767d with SMTP id
 a126-20020a0dd884000000b005838c61767dmr12662453ywe.2.1690304691939; Tue, 25
 Jul 2023 10:04:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724151849.323497-1-jhs@mojatatu.com> <CAHk-=wiH27m7UeddwD8JPUxjxXHMs=kv8x1WrLAho=dZ8CUhyg@mail.gmail.com>
In-Reply-To: <CAHk-=wiH27m7UeddwD8JPUxjxXHMs=kv8x1WrLAho=dZ8CUhyg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 25 Jul 2023 13:04:40 -0400
Message-ID: <CAM0EoMmKa1U8nOKNnuXZ4UYB3S+eR+Xyt7VfmjSoCnR9xBBWYw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: sched: cls_u32: Fix match key mis-addressing
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	netdev@vger.kernel.org, mgcho.minic@gmail.com, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 1:49=E2=80=AFPM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> On Mon, 24 Jul 2023 at 08:19, Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > +               /* The tableid from handle and tableid from htid must m=
atch */
> >                 if (TC_U32_HTID(handle) && TC_U32_HTID(handle ^ htid)) =
{
>
> Well, I guess the comment at least talks about matching.
>
> I still do think that most people aren't going to read
>
>     "Oh, TC_U32_HTID(handle ^ htid) being non-zero means that they
> they differ in the hash table bits".
>
> because the whole trick depends on bit op details, and depends on the
> fact that TC_U32_HTID() is purely a bit masking operation.
>
> But whatever.

I will improve the text leading to this to state that the goal of
building the new handle is to come up with an "address" or "path" for
the table entry. Then the table id mismatch is understood from that
context as part of the rules for building the table entry "address".

> I would also like to see some explanation of this pattern
>
>                 handle =3D htid | TC_U32_NODE(handle);
>
> and why that "binary or" makes sense. Are the node bits in 'htid'
> guaranteed to be zero?

Per existing user space tools, yes - they are guaranteed to be zero
(per my gitchelogy of both kernel +  iproute2 since inception this has
been the behavior);

> Because if 'htid' can have node bits set, what's the logical reason
> for or'ing things together?
>

Hrm. I am not sure if this is what you are getting to: but you caught
a different bug there.
While none of existing user space tooling(I know of) sends htid with
nodeid set (i.e it is always zero) syzkaller or someone else's poc
could send a non-zero nodeid in the htid. It is not catastrophic but
user expectation will be skewed - both the handle nodeid + htid node
id would be used to derive the nodeid. It will fail from the idr
allocation if the nodeid is in use.
It feels like a second patch though -  rejecting htid with a specified
nodeid (that way expected user space behavior is maintained).

> And why is that variable called 'htid', when clearly it also has the
> bucket ID, and the comment even says we have a valid bucket id?
>

The name could be changed. I am not sure what a good name is but the
semantics are: it carries a minimum of hash table id and at most hash
table id + bucket id. This sounds lame: ht_maybe_plus_bktid ? or make
them two separate variables htid and bktid.

> So I do still find this code to be explicitly written to be confusing.
> It's literally using variable names *designed* to not make sense, and
> have other meanings.
>
> Hmm?
>
> I'm not hating the patch, but when I look at that code I just go "this
> is confusing". And I don't think it's because I'm confused. I think
> it's the code.

I dont think it was intended that way - or maybe i have been taking it
for granted given on/off staring at the code for different reasons
over the years.
If it was to be written today we should certainly have made the 3 ids
independent and really should have allowed only one (instead of two
ways) to specify the different object ids from user space. It is at
least 2 decades old, in those days maybe saving a bit of space was a
good thing.

cheers,
jamal
>                Linus

