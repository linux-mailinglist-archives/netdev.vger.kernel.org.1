Return-Path: <netdev+bounces-23077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DF076AA4D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 09:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF251C20DE2
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 07:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268121EA97;
	Tue,  1 Aug 2023 07:51:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CF6611B
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:51:44 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE051BF3
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 00:51:41 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40a47e8e38dso161361cf.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 00:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690876300; x=1691481100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W1Bm9fAQmPCctHEmx+9krGOwdheTJeGpcAF1GiQb/8=;
        b=DtuZq5iSCkvuEd2bHHOIg0sceaYNHEbJT6Thk8u2Rq4t2dwZghPeQfyErzd4jBB/BV
         j9YqxyHg1SjCXmLu8o4iKF45r8n2s2UMl4wRKhe2KwfsOFLlQ47w3r5VvP0B3Vaxpqw9
         ShZbEyfQn4CkgZkmlLietqTe8qTJdhP+qsd8PTYdiPNbWi4T33Zyt1mNW3GMeDSIZDL5
         3Jbi9GJ/ese2TjuW5kCQUg3ZHIwyZV6er0yIZIcfs3UBaN1Wuy++KIyeeSQw7K2xYZge
         YcMvmnHgc6ONYFi4gP1UmPwYxAFW7TnghAvZWrmbM13ruqO4MMf2pH3KuVdYZU4QuTFy
         song==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690876300; x=1691481100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/W1Bm9fAQmPCctHEmx+9krGOwdheTJeGpcAF1GiQb/8=;
        b=KY7JbVfF9YBujYzGP3LuVPyCqgm+iA36ZYogmqIL4CK+rBN2MlSPP6n4in3tTl73YI
         Dx8quAn5DFQNIBSkyqgMOzdqZZo0/iF473ksixr6cTks/LnY/7vER8Wb212GLX4VezAC
         am8u2BjTSQWZ3XmTsFsJB58os0XfPqzhKoiOXNhwVIeM0mc16KlMBM9mDCz4dq4U5h66
         MvFGPhGaQteGuuomVII2y2ufjQI5m4tqlD8j2+Yc9XVonvVrGoq8kg7/ghCLwN+CKFs2
         Y1IX0+zXFllam4efJ9kcVKN0qfbaRtBeYyDseZ+pBlBg//DbS5nHPpxKUNCbTwfJ2ouh
         bfsw==
X-Gm-Message-State: ABy/qLanq0M1E+h3+Zrdx3lzr6fiaHVO59wKdoGKZLJmv4GtO+jWHEeg
	S292aSf3OWkmi5CeUyejUOuHMId41Bn96umhZ0VLwaxOg3h10GzeTm0=
X-Google-Smtp-Source: APBJJlH9G4vGeDSnD4rykuinEyoa6UwkVAZdYiFuBFX8ENckeLwnn26dcexs1ztlEjN+jP3HARaEWm+4OETQfF1RxGg=
X-Received: by 2002:a05:622a:19a4:b0:3f8:5b2:aef2 with SMTP id
 u36-20020a05622a19a400b003f805b2aef2mr649047qtc.26.1690876300384; Tue, 01 Aug
 2023 00:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801064318.34408-1-yuehaibing@huawei.com>
In-Reply-To: <20230801064318.34408-1-yuehaibing@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Aug 2023 09:51:29 +0200
Message-ID: <CANn89iJO44CiUjftDZHEjOCy5Q3-PDB12uWTkrbA5JJNXMoeDA@mail.gmail.com>
Subject: Re: [PATCH v3] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, simon.horman@corigine.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 8:45=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com> =
wrote:
>
>  skbuff: skb_under_panic: text:ffffffff88771f69 len:56 put:-4
>  head:ffff88805f86a800 data:ffff887f5f86a850 tail:0x88 end:0x2c0 dev:pim6=
reg
>

> When setup a vlan device on dev pim6reg, DAD ns packet may sent on reg_vi=
f_xmit().
> reg_vif_xmit()
>     ip6mr_cache_report()
>         skb_push(skb, -skb_network_offset(pkt));//skb_network_offset(pkt)=
 is 4
> And skb_push declared as:
>         void *skb_push(struct sk_buff *skb, unsigned int len);
>                 skb->data -=3D len;
>                 //0xffff88805f86a84c - 0xfffffffc =3D 0xffff887f5f86a850
> skb->data is set to 0xffff887f5f86a850, which is invalid mem addr, lead t=
o skb_push() fails.
>
> Fixes: 14fb64e1f449 ("[IPV6] MROUTE: Support PIM-SM (SSM).")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v3: drop unnecessary nhoff change
> v2: Use __skb_pull() and fix commit log.
> ---
>  net/ipv6/ip6mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index cc3d5ad17257..67a3b8f6e72b 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -1073,7 +1073,7 @@ static int ip6mr_cache_report(const struct mr_table=
 *mrt, struct sk_buff *pkt,
>                    And all this only to mangle msg->im6_msgtype and
>                    to set msg->im6_mbz to "mbz" :-)
>                  */
> -               skb_push(skb, -skb_network_offset(pkt));
> +               __skb_pull(skb, skb_network_offset(pkt));
>
>                 skb_push(skb, sizeof(*msg));
>                 skb_reset_transport_header(skb);

Presumably this code has never been tested :/

Reviewed-by: Eric Dumazet <edumazet@google.com>

