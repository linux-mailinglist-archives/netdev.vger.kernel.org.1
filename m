Return-Path: <netdev+bounces-15824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6406B74A065
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 17:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1341C20BD9
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 15:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53914A939;
	Thu,  6 Jul 2023 15:05:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4250CA928
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 15:05:43 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6E4173F
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 08:05:40 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40371070eb7so276431cf.1
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688655939; x=1691247939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msEvTjDikrgnhkRF3xJHOMkj86YrSM0qTZJUNmF80v4=;
        b=X4BDECg3HA6xRYn5CdWL0nOgUUnK1bioxo6zmKYJTvqxEdQ9U8HIOZAa/2QiMzqiXC
         xgkPTQI5EcaHvb7gM8hdCN/sMNjuacB1CVFdVGw/1MJqOehOMJiHNnj9hLWg5U535ncM
         bC/q2cccDX7zSEKUo0QrXGKfBfV62JbSEIBMggcxbxg+2nqsgeotkvzfWi4j8TdqR87Y
         9oJxlSt0M6moa98ZDo9hyIqaTzB5VbrVtnpn/y39iprMCaMXrHb292SyAsNDNmc3drPi
         JnFQA97PUbDF1Gh+Whn/PYp/9Z6mu/SeMfxTGtvekIIuLVJlTIyHpyMaj/jrBWQ2Myx9
         XbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688655939; x=1691247939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msEvTjDikrgnhkRF3xJHOMkj86YrSM0qTZJUNmF80v4=;
        b=A6ov1O39vPLEPJn080KjP2Pnk0U5Tqcr9gX8JM3+WwC4yzjfrmTMHaQiLJJKEIV70P
         Vvgo/A+dFo2zdXmwi7VAzPffKRIn/GJ2DI0Dt2TNimwEJp534rF56HJK/IGchpXtKjBt
         QeRux1tV4U+X19OKdIEdTCRN4ksRjJqoyAYErv6/HRVLWLvknAXmuGSMWFKLbV1qrz/f
         Xi+8KilwvzIatUAzKpOCFI6MF5FnJNCP0qB5MdTFsGNx+FLLQgqVzxzajoc6ha4o0aEM
         wsFNTOGveFH+vaXZezNTQ1yRREA1ixdvxil+Eu9b7SkS7y+koozDkkP70ud8uwRkqTCX
         M50g==
X-Gm-Message-State: ABy/qLZIiK+DQxHLDhvo5lzwK63ONaVAP5jI5uFRBAEt7VXRgUyeO98t
	yH7Kids1o/siTIxBzLrewj5fbI6uZH3JzI7r9BBcAg==
X-Google-Smtp-Source: APBJJlGOPYnRx4voPuHx8soGZwPPsIqGhSC2eDD71kFlff+Kq85+Ni5Sa25sG/PtaOHU+0UvpsZkC6JEc630C2fkX8Y=
X-Received: by 2002:ac8:5994:0:b0:3f8:5b2:aeed with SMTP id
 e20-20020ac85994000000b003f805b2aeedmr146287qte.21.1688655939226; Thu, 06 Jul
 2023 08:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706130800.85963-1-squirrel.prog@gmail.com>
 <CANn89iKxGVDQba1UCbpYKhNo=rZXuN2j=610DbJx0z=kWa7N3w@mail.gmail.com> <CAJfyFi3OEz2Dz9gopigkVJRa4qCToJ+ob952O_qkOFiNn08LwA@mail.gmail.com>
In-Reply-To: <CAJfyFi3OEz2Dz9gopigkVJRa4qCToJ+ob952O_qkOFiNn08LwA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Jul 2023 17:05:28 +0200
Message-ID: <CANn89iLBO7U40gNDysTD0wCPMAsgUQV3u_T1yzv1oaa=sLKyfQ@mail.gmail.com>
Subject: Re: [PATCH] gro: check returned skb of napi_frags_skb() against NULL
To: Kaiyu Zhang <squirrel.prog@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 4:35=E2=80=AFPM Kaiyu Zhang <squirrel.prog@gmail.com=
> wrote:
>
> Yes the network adapter needs to be fixed for passing invalid packets to =
GRO. And a message like "dropping impossible skb" should be indicative enou=
gh for developers to do so.
>
> And yet I propose this patch because an immediate system crash caused by =
NULL pointer access after the above warning message is a bit more difficult=
 to analyse on some test bed where developers have to restore kernel messag=
es after a reboot .
>
> Furthermore, the adapter I'm working with is capable of receiving very sm=
all packets (1 or 2 bytes). They insist this is a feature rather than a bug=
. I can, and I will check packet length before passing them to GRO, for thi=
s particular adapter. But maybe a non-crash warning in general might be hel=
pful to other developers who will face the same problem and spare them some=
 effort on debugging.

1 or 2 bytes would still be stored in an skb, right ?

GRO is already very slow, we do not want to make it even slower so
that some developers can save time.
A kernel crash would point to the NULL deref just fine.

If we continue this path, we will soon add "if (!skb) be_kind" to all
functions accepting an skb as a parameter,
then everything else...

