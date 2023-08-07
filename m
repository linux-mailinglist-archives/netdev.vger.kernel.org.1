Return-Path: <netdev+bounces-24951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED597724B6
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 14:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC7E1C20A21
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 12:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202C3FC0D;
	Mon,  7 Aug 2023 12:49:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14430DDD9
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 12:49:49 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D5510FD
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 05:49:48 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9cbaee7a9so72137601fa.0
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 05:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691412586; x=1692017386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nnvJW6I5V9I/I41OmMmbtDLZL9AwZFrl3+KOmmBOXC0=;
        b=FfBptFFKigJCGVyGCoAJzw+Wl90hIRTBE9RsP7qfyjDwJoSIf4Aw4/FdkpEj/ArGIF
         2gVU/oZlWFiBTaWPcVse/q2E8Xu7ChuqWvLnpt5y+kOj0XUzMicNJ0VZP+TPXBIocJt/
         Jv3BP6+EIpzKI9haop0fWQNb8Yq73md0EAPsp+8VH/KEpNTvlJxwKJVlDG53dOlgXhBh
         xsNsjYke59nYizM8u/sbfT5ns15jreT5LBQ7hYUYv6Hf8Plx8DQNZKnBPNMSy8C2SkvT
         VrPvkGF36/0ImYNDRGmCPLy4DT2sCPWxRlPMjnJGGoveCuZKWtw0/370eBE/E1cMqhqL
         v/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691412586; x=1692017386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nnvJW6I5V9I/I41OmMmbtDLZL9AwZFrl3+KOmmBOXC0=;
        b=fhqRiPxsY4wH9sCEj7vBUz0fVnqu6Dl5sx7JUPuveYfERGHaqeo21Z+xXRInIBUUuV
         P2zZ4cPnXemWhfnaDNjtTOMGo5hOnVaGr+NzR1jxhXGSaWG5K9np3gLM5Fl/ipwJct+r
         ObCSCJYsG8tz0ypqUoe1t2rfIbur+0XY9yTgfFB+hYQu9Nf1mbRS5jD7sVlIgfoPcjl8
         ibT1li0pHhnAtTTzg2RD2vyqJLiSrckYdZbP6WV9d0zr31XexUU1te2+AlCZVbzoLFFJ
         z+vh0KDoSxeD6aJuFqYS0nIuV36ZoSeoOUYUUnHlDzYCkA8IuSVqdg6LQWH2sa9cXvy1
         cTIw==
X-Gm-Message-State: AOJu0YxTabKYvjnDIB7Pyb8vCYYOM5GOQSAKxk15qPOLmgBjcgxoHwIA
	yXlRhnF4FjgolwPEIt428NvnmSC7zznHMs7DQKE=
X-Google-Smtp-Source: AGHT+IGRBJtEFOyDwoo6E7kxgYMGJZfOc1kFY4uKr4hjxTdrEeV+SDtXfSIMypJXnJC/TkBn7GREgQc80/fCsu3DxQ4=
X-Received: by 2002:a2e:7d02:0:b0:2b9:4324:b0a7 with SMTP id
 y2-20020a2e7d02000000b002b94324b0a7mr7012503ljc.51.1691412586226; Mon, 07 Aug
 2023 05:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230802070454.22534-1-liangchen.linux@gmail.com>
 <222b7508-ee46-1e7d-d024-436b0373aaea@intel.com> <CAKhg4tJen5JQp-cpvdmdzy1RYJL_=a0bk6TYs0ud0G1rn1ebsg@mail.gmail.com>
 <5f9f6107-3617-dca7-0551-51fc54861298@intel.com>
In-Reply-To: <5f9f6107-3617-dca7-0551-51fc54861298@intel.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 7 Aug 2023 20:49:34 +0800
Message-ID: <CAKhg4t+SRCXMiuJGMYNw+=xDMW84NtpmKuGw=4L+dkTqX7E7oQ@mail.gmail.com>
Subject: Re: [PATCH net-next] xdp: Fixing skb->pp_recycle flag in generic XDP handling
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, ilias.apalodimas@linaro.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 3, 2023 at 11:17=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Liang Chen <liangchen.linux@gmail.com>
> Date: Thu, 3 Aug 2023 16:25:49 +0800
>
> > On Thu, Aug 3, 2023 at 1:11=E2=80=AFAM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Liang Chen <liangchen.linux@gmail.com>
> >> Date: Wed,  2 Aug 2023 15:04:54 +0800
> >>
> >>> In the generic XDP processing flow, if an skb with a page pool page
> >>> (skb->pp_recycle =3D=3D 1) fails to meet XDP packet requirements, it =
will
> >>> undergo head expansion and linearization of fragment data. As a resul=
t,
> >>> skb->head points to a reallocated buffer without any fragments. At th=
is
> >>> point, the skb will not contain any page pool pages. However, the
> >>> skb->pp_recycle flag is still set to 1, which is inconsistent with th=
e
> >>> actual situation. Although it doesn't seem to cause much real harm at=
 the
> >>
> >> This means it must be handled in the function which replaces the head,
> >> i.e. pskb_expand_head(). Your change only suppresses one symptom of th=
e
> >> issue.
> >>
> >
> > I attempted to do so. But after pskb_expand_head, there may still be
> > skb frags with pp pages left. It is after skb_linearize those frags
> > are removed.
>
> Ah, right.
> Then you need to handle that in __pskb_pull_tail(). Check at the end of
> the function whether the skb still has any frags, and if not, clear
> skb->pp_recycle.
>
> The most correct fix would be to do that in both pskb_expand_head() and
> __pskb_pull_tail(): iterate over the frags and check if any page still
> belongs to a page_pool. Then page_pool_return_skb_page() wouldn't hit
> false-branch after the skb was re-layout.
>

Yeah, I agree. netif_receive_generic_xdp may not be the only place the
flag can get wrong. To make the pp_recycle flag strictly reflect the
state of page pool usages, the check should be put in both functions.
But, since it's merely an indication that the skb is 'page pool
aware,' and considering that the performance impact we observed
doesn't affect the native XDP path, addressing this issue doesn't seem
worthwhile based on the feedback I've received.


Thanks,
Liang

> [...]
>
> Thanks,
> Olek

