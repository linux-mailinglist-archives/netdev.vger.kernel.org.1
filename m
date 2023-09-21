Return-Path: <netdev+bounces-35583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A67BF7A9CEA
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE66AB2137A
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD22112B6D;
	Thu, 21 Sep 2023 19:23:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BEC9CA4C
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 19:23:50 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536E8D8AB8
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:09:11 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-414ba610766so73291cf.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695323350; x=1695928150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLlJX9huq9ej0iAVLAlYlRkGYLAh3a+BqLGjUG3BDUo=;
        b=gCwpbrpBnjCkHBljVLlGxCiWkWTVNtBSPV5VAb4PvGI0wTP+FzNG5/5rlRqC7DGYpP
         K2u62JW4+rzn8B5xgUrxbiQqz7lc0tCRJ6dKspc8RbRc+C1NJakVwfT6gNPnB08ybSYn
         +TLEhhvBgZ2JHcje25VDiNg8OQXf1nP5qo9I4wQKFXbfU8UqHH4CnunyEy7qwUoSUFhT
         CA8QzHunt3xwPX67pd9DED3sK8OOboRag0sSTj2XnYeIKGGs3EwXmnS80mmUvytKo2Az
         nlB3WVKseGQWKOs7pKcZz37g3sBt0kqkyXhy5tPHvwhW6didaGgqLqXKjkbIAenneVSg
         FEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323350; x=1695928150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLlJX9huq9ej0iAVLAlYlRkGYLAh3a+BqLGjUG3BDUo=;
        b=eAXZJvJcPWBCUnsBw67M6hjabwKK301EIxN9Yi+Xm9aELVhptgwGLaWslDwN0JNYjf
         uV82+1SQmZ8eNQdn7ECiOPMd0zGQ/EJFX02aGBIGEd3+h/flsnDOCyBGmpPVrGZ+WzUf
         AKvxPb8XE5BOrbpwckyzaShwJVravdfxOOWoDbiPAQsue5mflTmauYbQ8j9FohVxD5ts
         VpgwgPc1FIazBj3TWCiuMixtBKSF6Bj1cJoPyrwD3qhlEzylnClVTP9Y9/TS5OdNsPJ0
         Ip8+MGozpAzhb5wru+Y2cF0CxrDXJJjjmEGFtE15+I+fSjth+x5qPvpoG8MGtT/eRCub
         ZAew==
X-Gm-Message-State: AOJu0Yx9Wp6uxiQBvYiCH8V2Wp+PFxEilVAuzlCyq/cJIuT+DotQ+Sq0
	+w0jCmn6aNfJ1tdHLXhd+c85RiV0T7E5McnW4dwVBg==
X-Google-Smtp-Source: AGHT+IFaC8NIJjQt0QoTmTynybk6RbTtja9Lkkg5vf8GHyAoht+PdhqbPUUlFvAA29EGIPq5KyWh7IwVg+3+0xP7sCA=
X-Received: by 2002:a05:622a:24b:b0:410:9855:ac6 with SMTP id
 c11-20020a05622a024b00b0041098550ac6mr333593qtx.14.1695323349892; Thu, 21 Sep
 2023 12:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921190429.1970766-1-i.maximets@ovn.org>
In-Reply-To: <20230921190429.1970766-1-i.maximets@ovn.org>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Sep 2023 21:08:58 +0200
Message-ID: <CANn89iJeAFBKF=5=VjO4pZWT0-o5GrTZhZvDD4OGBt5U27P+LA@mail.gmail.com>
Subject: Re: [PATCH net-next] openvswitch: reduce stack usage in do_execute_actions
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, Eelco Chaudron <echaudro@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 9:03=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org> =
wrote:
>
> do_execute_actions() function can be called recursively multiple
> times while executing actions that require pipeline forking or
> recirculations.  It may also be re-entered multiple times if the packet
> leaves openvswitch module and re-enters it through a different port.
>
> Currently, there is a 256-byte array allocated on stack in this
> function that is supposed to hold NSH header.  Compilers tend to
> pre-allocate that space right at the beginning of the function:
>
>      a88:       48 81 ec b0 01 00 00    sub    $0x1b0,%rsp
>
> NSH is not a very common protocol, but the space is allocated on every
> recursive call or re-entry multiplying the wasted stack space.
>
> Move the stack allocation to push_nsh() function that is only used
> if NSH actions are actually present.  push_nsh() is also a simple
> function without a possibility for re-entry, so the stack is returned
> right away.
>
> With this change the preallocated space is reduced by 256 B per call:
>
>      b18:       48 81 ec b0 00 00 00    sub    $0xb0,%rsp
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  net/openvswitch/actions.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 5f8094acd056..80cc5c512d7b 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -312,10 +312,16 @@ static int push_eth(struct sk_buff *skb, struct sw_=
flow_key *key,
>  }
>
>  static int push_nsh(struct sk_buff *skb, struct sw_flow_key *key,
> -                   const struct nshhdr *nh)
> +                   const struct nlattr *a)

Presumably this function should be inlined. (one caller only)

I would add noinline_for_stack to make sure the compiler will not play
games with this attempt.

>  {
> +       u8 buffer[NSH_HDR_MAX_LEN];
> +       struct nshhdr *nh =3D (struct nshhdr *)buffer;
>         int err;
>
> +       err =3D nsh_hdr_from_nlattr(a, nh, NSH_HDR_MAX_LEN);
> +       if (err)
> +               return err;
> +
>         err =3D nsh_push(skb, nh);
>         if (err)
>                 return err;
> @@ -1439,17 +1445,9 @@ static int do_execute_actions(struct datapath *dp,=
 struct sk_buff *skb,
>                         err =3D pop_eth(skb, key);
>                         break;
>
> -               case OVS_ACTION_ATTR_PUSH_NSH: {
> -                       u8 buffer[NSH_HDR_MAX_LEN];
> -                       struct nshhdr *nh =3D (struct nshhdr *)buffer;
> -
> -                       err =3D nsh_hdr_from_nlattr(nla_data(a), nh,
> -                                                 NSH_HDR_MAX_LEN);
> -                       if (unlikely(err))
> -                               break;
> -                       err =3D push_nsh(skb, key, nh);
> +               case OVS_ACTION_ATTR_PUSH_NSH:
> +                       err =3D push_nsh(skb, key, nla_data(a));
>                         break;
> -               }
>
>                 case OVS_ACTION_ATTR_POP_NSH:
>                         err =3D pop_nsh(skb, key);
> --
> 2.41.0
>

