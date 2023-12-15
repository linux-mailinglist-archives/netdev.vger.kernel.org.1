Return-Path: <netdev+bounces-57984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2E1814AE0
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 15:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFAF61C237BB
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A74F1C29;
	Fri, 15 Dec 2023 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="EoGF6Y5c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA0B3A8C3
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5e3b9c14e46so6206187b3.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 06:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702651379; x=1703256179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXQLHdrE09LIcbHHrRw3NxIRpL1RXbK4rug1WTmsabE=;
        b=EoGF6Y5c6KgyJpoNuOD3sE300Eg2cFvxFILIEDtMMADWbT8oMH1uSYjtsAqhBmnO9k
         Vi+N3lNcdRG5M8LRJK2GFvelbk1EF5M7xxgavqOhpnfx2lKdIcb1ZmgOqCveLaDB/E/7
         CI1eXkDnxwPAX+t3D1JGeUEqh2uexcusXGrsN4V6D1AeRovYamf6K39xipH1TfyFGpMu
         JthcPFcMKYldAD+X83UedFAE26wQzbkIBW6przeI6EvY0DyZh+EW8p+0rfwKdInLCzDV
         tz3YBwnb375h/W9TG2o/K9MNAoAmYEREZgHRZpyN7f/QhANAO0rqBAiQ1TWNLvkZ8bka
         +5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702651379; x=1703256179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXQLHdrE09LIcbHHrRw3NxIRpL1RXbK4rug1WTmsabE=;
        b=OWtcYPSZk9QDdF8JCUYZlcpywM4LwGUbz4KyElbF6p/kgFwK8gsgVgCqkFmDaE9WEw
         O4W+sDD20StplvUF0xylLC971cN4QGNrj/+IWRCoka1gCcsTEx3cYXjmNsAnmk7H3c38
         us7Nu1mzhVRHbQAgBcpcGSgIzW7UI8VL0gV+TZbFA+oqqN361mBnLJkyqa53fm9XCZ+z
         1lxqj1vYkNSHnJSvXG1uzerLyZoNk79MtLvkcuRmdP6bi5ifcvcoxrsWzNO2poH2K77L
         ZpEr48dMHbN7BKHJs169+4qcXDqtuD3/h8+utZ91CPOmpMIStBGK8HxREb+nBtcCzvHr
         S47w==
X-Gm-Message-State: AOJu0Ywcig2pp+NDqF7GhGfbVzFYIgt/GAE02VaHxt7sP3Zq5EZujKso
	DztWedb/1fAFfnSuMuXRkcB9iCF5+PVd5/TWQc42rg==
X-Google-Smtp-Source: AGHT+IE+doyRFarhU99rwfwgXBUcU0wvZctB5cOTtzjWWKxR2RHWTE4sRyuRC8MwUWNfCkN4eh/X/EWmmlj5rSsKe6c=
X-Received: by 2002:a81:c80b:0:b0:5df:5d59:7939 with SMTP id
 n11-20020a81c80b000000b005df5d597939mr8173745ywi.12.1702651378907; Fri, 15
 Dec 2023 06:42:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205205030.3119672-1-victor@mojatatu.com> <20231205205030.3119672-3-victor@mojatatu.com>
 <20231211182534.09392034@kernel.org> <CAM0EoMkYq+qqO6pwMy_G58_+PCT6A6EGtpPJXPkvQ1=aVvY=Sw@mail.gmail.com>
 <CANn89i+-G0gTF=Vmr5NprYizdqXqpoQC5OvnXbc-7dA47tcdyQ@mail.gmail.com>
 <CAAFAkD8X-EXt4K+9Jp4P_f607zd=HxB6WCEF_4BGcCm_hSbv_A@mail.gmail.com>
 <CAM0EoMk9cA0qCGNa181QkGjRHr=4oZhvfMGEWoTRS-kHXFWt7g@mail.gmail.com>
 <20231213130807.503e1332@kernel.org> <CAM0EoM=+zoLNc2JihS4Xyz77YciKCywXdtr8N3cDuwYRxc8TcQ@mail.gmail.com>
 <fecd5da8-4657-3454-b64d-d3f07b071a5d@gmail.com>
In-Reply-To: <fecd5da8-4657-3454-b64d-d3f07b071a5d@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 15 Dec 2023 09:42:47 -0500
Message-ID: <CAM0EoM=mG51sY9-9_Bm8Sb=nUmF33b=Vcf6PvuOPqhoAQgUvwg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: sched: Make tc-related drop reason
 more flexible for remaining qdiscs
To: Taehee Yoo <ap420073@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jamal Hadi Salim <hadi@mojatatu.com>, 
	Eric Dumazet <edumazet@google.com>, Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, pabeni@redhat.com, 
	daniel@iogearbox.net, dcaratti@redhat.com, netdev@vger.kernel.org, 
	kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 12:18=E2=80=AFPM Taehee Yoo <ap420073@gmail.com> wr=
ote:
>
> On 12/15/23 00:31, Jamal Hadi Salim wrote:
>
> Hi Jamal,
>
>  > On Wed, Dec 13, 2023 at 4:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.or=
g> wrote:
>  >>
>  >> On Wed, 13 Dec 2023 13:36:31 -0500 Jamal Hadi Salim wrote:
>  >>> Putting this to rest:
>  >>> Other than fq codel, the others that deal with multiple skbs due to
>  >>> gso segments. So the conclusion is: if we have a bunch in the list
>  >>> then they all suffer the same fate. So a single reason for the list =
is
>  >>> sufficient.
>  >>
>  >> Alright.
>  >>
>  >> I'm still a bit confused about the cb, tho.
>  >>
>  >> struct qdisc_skb_cb is the state struct.
>  >
>  > Per packet state within tc though, no? Once it leaves tc whatever sits
>  > in that space cant be trusted to be valid.
>  > To answer your earlier question tcf_result is not available at the
>  > qdisc level (when we call free_skb_list() but cb is and thats why we
>  > used it)
>  >
>  >> But we put the drop reason in struct tc_skb_cb.
>  >> How does that work. Qdiscs will assume they own all of
>  >> qdisc_skb_cb::data ?
>  >>
>  >
>  > Short answer, yes. Anyone can scribble over that. And multiple
>  > consumers have a food fight going on - but it is expected behavior:
>  > ebpf's skb->cb, cake, fq_codel etc - all use qdisc_skb_cb::data.
>  > Out of the 48B in skb->cb qdisc_skb_cb redefined the first 28B and
>  > left in qdisc_skb_cb::data as free-for-all space. I think,
>  > unfortunately, that is now cast in stone.
>  > Which still leaves us 20 bytes which is now being squatered by
>  > tc_skb_cb where the drop reason was placed. Shit, i just noticed this
>  > is not exclusive - seems like
>  > drivers/net/amt.c is using this space - not sure why it is even using
>  > tc space. I am wondering if we can make it use the 20B scratch pad.
>  > +Cc author Taehee Yoo - it doesnt seem to conflict but strange that it
>  > is considering qdisc_skb_cb
>
> The reason why amt considers qdisc_skb_cb is to not use CB area the TC
> is using.
> When amt driver send igmp/mld packet, it stores tunnel data in CB before
> calling dev_queue_xmit().
> Then, it uses that tunnel data from CB in the amt_dev_xmit().
> So, amt CB area should not be used by TC, this is the reason why it
> considers qdisc_skb_cb size.
> But It looks wrong, it should use tc_skb_cb instead of qdisc_skb_cb to
> fully avoid CB area of TC, right?


Yeah, that doesnt seem safe if you are storing state expecting it to
be intact afterwards - tc will definitely overwrite parts of it today.
See this:

struct qdisc_skb_cb {
        struct {
                unsigned int            pkt_len;
                u16                     slave_dev_queue_mapping;
                u16                     tc_classid;
        };
#define QDISC_CB_PRIV_LEN 20
        unsigned char           data[QDISC_CB_PRIV_LEN];
};

struct tc_skb_cb {
        struct qdisc_skb_cb qdisc_cb;

        u16 mru;
        u8 post_ct:1;
        u8 post_ct_snat:1;
        u8 post_ct_dnat:1;
        u16 zone; /* Only valid if post_ct =3D true */
};

tc_skb_cb->mru etc are writting over the area you are using.

The rule is you cant trust skb->cb content after it goes out of your "domai=
n".

cheers,
jamal

>  >
>  >> Maybe some documentation about the lifetimes of these things
>  >> would clarify things?
>  >
>  > What text do you think makes sense and where should it go?
>  >
>  > cheers,
>  > jamal

