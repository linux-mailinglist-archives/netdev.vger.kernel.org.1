Return-Path: <netdev+bounces-15076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC99F745817
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 11:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5211C208E3
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 09:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D76820F0;
	Mon,  3 Jul 2023 09:09:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9DE1C2F
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 09:09:54 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2F4AB
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 02:09:52 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b69f1570b2so68734011fa.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 02:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688375391; x=1690967391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaJj7heHtLc3csjGZPKRGoaKN/ldtSkR2Am+/LMrzfI=;
        b=C79caJR6HOrEnvvqrKjqSXIKrgGhI8ZEE6YXXGejhe02ulNbkanRQh+L61/46oOvg8
         qXGqJ0HTvfkbcnnpI9FVXOHqg5CDR0azfLeIuSKhhgkSt5L15uS+pQ8H3ck+a6rrVmdb
         SBv2hmVIMr3oRp4I3Jpv8K4CQwrA6GB1EPv3Bgndae5OlQNzm3wvVdlLfifaji0Bd6YP
         5JfukkIq+P+QlnIfZSLfyaeP1UmBA4EfzTlhpMbG11fJSGE7iyTQAUOTVUkWukKJEi3w
         SaEtbA8JWA2O6H8q76n/eUDXKY0O4vwXCiL2B3ZwjCU0YS3hqOGiU82h72v2Vb76NrMX
         lwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688375391; x=1690967391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaJj7heHtLc3csjGZPKRGoaKN/ldtSkR2Am+/LMrzfI=;
        b=Hi7gRQ0XQuU5QR9yNbq5nSzHWUgyBA2n1lhJPotWceEYHwQOBGSYIjEAGD90zOBIiT
         BYWC6mCQzOwreFbg2nZyJKIArZoH7sfha6WxddlXYz84lmHMp+5SiDp9ZX3Y1Keiqepk
         nTvEnIqIAR1tW6xlx+LScpufX2B1ZWkRvZ6pz88pKvXF2B5jZGlF6l/q/r0nxhk2e48m
         6MT/sGAoverR7MPEiUUmmriTYTbhW3SX5Cxp4WzbyDOftuJ1rUIJJG0lquRRF9u7hlFR
         SAqsC2yOZrBsw2rPe3s18CsC6QTsNZvAzMuDY/OHO8vAMmW2On2rCrJ0jg0JnPEIlPUB
         OZxg==
X-Gm-Message-State: ABy/qLb1afrsjWu1kWZdd9jkLI608wOFpqOWFdqc9cUU1D/yRckh9rPK
	ibov8dqQcBSHr61LaAZERIsWsot4GcNRPrkdJlw=
X-Google-Smtp-Source: APBJJlFYTvroMEGEUV24hV8S0bkFbVDLfutSEqxYk45AZnP+t7WdF8G+lTZ81XfYRA4C5Oc5vyyvY8M4gznSD0FydyY=
X-Received: by 2002:a2e:6e18:0:b0:2b6:dc3a:a99f with SMTP id
 j24-20020a2e6e18000000b002b6dc3aa99fmr3825225ljc.17.1688375390647; Mon, 03
 Jul 2023 02:09:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628121150.47778-1-liangchen.linux@gmail.com>
 <5b81338a-f784-d73e-170c-d12af38692cb@huawei.com> <CAKhg4tJkprS+dFcpLALP_e1kpHJ-DwabOMFaXxsPx+7O0c-geQ@mail.gmail.com>
 <CAKhg4t+RUeoTv_OnD5nMAXWeATqRC+tcyzbnz_jXBQGzd90rpQ@mail.gmail.com> <c04ee7cd-63a2-e35b-515c-726c10072f0e@huawei.com>
In-Reply-To: <c04ee7cd-63a2-e35b-515c-726c10072f0e@huawei.com>
From: Liang Chen <liangchen.linux@gmail.com>
Date: Mon, 3 Jul 2023 17:09:38 +0800
Message-ID: <CAKhg4tKRB7XEYd-3qY4hZgAXExMunP4+hCoji_r2EBO7jK+o_A@mail.gmail.com>
Subject: Re: [PATCH net-next] skbuff: Optimize SKB coalescing for page pool case
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: ilias.apalodimas@linaro.org, hawk@kernel.org, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 30, 2023 at 7:52=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2023/6/29 20:19, Liang Chen wrote:
> > On Thu, Jun 29, 2023 at 8:17=E2=80=AFPM Liang Chen <liangchen.linux@gma=
il.com> wrote:
> >>
> >> On Thu, Jun 29, 2023 at 2:53=E2=80=AFPM Yunsheng Lin <linyunsheng@huaw=
ei.com> wrote:
> >>>
> >>> On 2023/6/28 20:11, Liang Chen wrote:
> >>>> In order to address the issues encountered with commit 1effe8ca4e34
> >>>> ("skbuff: fix coalescing for page_pool fragment recycling"), the
> >>>> combination of the following condition was excluded from skb coalesc=
ing:
> >>>>
> >>>> from->pp_recycle =3D 1
> >>>> from->cloned =3D 1
> >>>> to->pp_recycle =3D 1
> >>>>
> >>>> However, with page pool environments, the aforementioned combination=
 can
> >>>> be quite common. In scenarios with a higher number of small packets,=
 it
> >>>> can significantly affect the success rate of coalescing. For example=
,
> >>>> when considering packets of 256 bytes size, our comparison of coales=
cing
> >>>> success rate is as follows:
> >>>
> >>> As skb_try_coalesce() only allow coaleascing when 'to' skb is not clo=
ned.
> >>>
> >>> Could you give more detailed about the testing when we have a non-clo=
ned
> >>> 'to' skb and a cloned 'from' skb? As both of them should be belong to=
 the
> >>> same flow.
> >>>
> >>> I had the below patchset trying to do something similar as this patch=
 does:
> >>> https://lore.kernel.org/all/20211009093724.10539-5-linyunsheng@huawei=
.com/
> >>>
> >>> It seems this patch is only trying to optimize a specific case for sk=
b
> >>> coalescing, So if skb coalescing between non-cloned and cloned skb is=
 a
> >>> common case, then it might worth optimizing.
> >>>
> >>
> >> Sure, Thanks for the information! The testing is just a common iperf
> >> test as below.
> >>
> >> iperf3 -c <server IP> -i 5 -f g -t 0 -l 128
> >>
> >> We observed the frequency of each combination of the pp (page pool)
> >> and clone condition when entering skb_try_coalesce. The results
> >> motivated us to propose such an optimization, as we noticed that case
> >> 11 (from pp/clone=3D1/1 and to pp/clone =3D 1/0) occurs quite often.
> >>
> >> +-------------+--------------+--------------+--------------+----------=
----+
> >> |   from/to   | pp/clone=3D0/0 | pp/clone=3D0/1 | pp/clone=3D1/0 | pp/=
clone=3D1/1 |
> >> +-------------+--------------+--------------+--------------+----------=
----+
> >> |pp/clone=3D0/0 | 0            | 1            | 2            | 3      =
      |
> >> |pp/clone=3D0/1 | 4            | 5            | 6            | 7      =
      |
> >> |pp/clone=3D1/0 | 8            | 9            | 10           | 11     =
      |
> >> |pp/clone=3D1/1 | 12           | 13           | 14           | 15     =
      |
> >> |+------------+--------------+--------------+--------------+----------=
----+
>
>
> I run the iperf test, it seems there is only one skb_clone() calling for =
each
> round, and I was using 'iperf', not 'iperf3'.
> Is there any app like tcpdump running? It seems odd that the skb from the=
 rx
> need to be cloned for a common iperf test, which app or configuration is =
causing
> the cloning?
>
> Maybe using the ftrace to see the skb_clone() calling?
> echo skb_clone > set_ftrace_filter
> echo function > current_tracer

Thanks for raising the concerns. We did some investigation into the
cause of skb cloning. The result is that in our environment (fedora 37
default network setup) NetworkMananger creates a SOCK_DGRAM socket,
which eventually leads to the additional packet_type (struct
packet_sock.prot_hook) being registered, thus the cloning. Since
__netif_receive_skb_core iterates through orig_dev->ptype_specific for
all possible skb delivery targets and increases skb->users
accordingly.

We will update the commit message to include this information to point
out that the figures are specific to our environment. But there are
many possible reasons skbs can be cloned, and improvements in this
code path can still bring benefits.

Thanks,
Liang

