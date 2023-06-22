Return-Path: <netdev+bounces-13180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B2673A8BD
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 21:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDA91C2118A
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D91206B5;
	Thu, 22 Jun 2023 19:02:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72AE1F923
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 19:02:12 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA631FE3
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:02:04 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40079b6fc56so37401cf.1
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687460524; x=1690052524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4j6GBW8CPe32/PBQSI1ckzLQb8w73S2ei6XzaYvDcs=;
        b=Lrt0ifuVH1LFnFqXjD9E/Bv6D1weSeqtC/YeU5AXKPOYFsMBEM79e89U0CY0V53HPu
         ZImnivVmEszSgpcrQoBJ+chtqznsdVFVzcRzKKSi0C4DE/PyDwEkBu2srVMpVw6YkCJZ
         ydm+G4+tKrs2/YBPwVenUxyoaxewDzfQcYl0W4yZSnggbwgOuPteQx1tLiCigO+tuuGW
         V7k7juGHWCkzPy58mFNJeT0JitQ9RHNctb1v5I1iOWi3QhADoM9ndg0m6Ssrc/OkgHWS
         dSEXi072/ohWYqNfrtO1IxQWkSl5fvg6iy7wktsvW3D2/C43185kzGIAEnL/t01KPztk
         xU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460524; x=1690052524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4j6GBW8CPe32/PBQSI1ckzLQb8w73S2ei6XzaYvDcs=;
        b=eTRAPsaz1cHSAYQj9rRj/8hb6p2i/EkAoRby6xz9SZ1L2zuDlO3/nFjohriKmlWyKe
         imx237A2Gqgr3G8aRVtrgnXZeOdqQcXhmjMYzQP8M7Ug8Tl4RDKK27f7TIXXrYdeHHzb
         2BhZ8kb/ldUvDNY28WCpO0TaGlgQB0e/PuhtB6L3bbCz98CIvP5JUR3Tl/bliGKWk3C3
         oMJhC7ba7ie0e98AkNh7skbE6H/xYAgzOYd8g96x00jINceHnfpApO7yNNUXm7yY7BJs
         WVX+zGsRNUIIlnACaWyEic68FDQyGNvdFIsPZ+WAAm0ITxV98j9fyHM5er3KbY1m9XjW
         nHng==
X-Gm-Message-State: AC+VfDzV6HjlAob+sFAbEcAXWtY/8kYjcVOFr06Z6C3AabBIs4pf8Mm2
	cfV669PHsfZH7mH4VeIXE/hixI7qOvFRZIdYheNaNw==
X-Google-Smtp-Source: ACHHUZ53KKV7hEw/mYkQC65Q1LGR2HU7F8fuP6k7U6TecILeF2t5h66hJ+PKoEjEtnVTCSxJmQTy1LWfOckw82uwuqE=
X-Received: by 2002:a05:622a:196:b0:3fa:45ab:22a5 with SMTP id
 s22-20020a05622a019600b003fa45ab22a5mr2216098qtw.27.1687460523597; Thu, 22
 Jun 2023 12:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230622152304.2137482-1-edumazet@google.com> <22643.1687456107@famine>
 <CANn89iJSmS_B1q=oG_e-RxtWkOuj0x0eqhsp5BeuCn-TuS0W5w@mail.gmail.com>
 <26275.1687460144@famine> <CANn89i+Vcwp9o59Fzy+epqS+YSxjrStNjBRX-5GSie_TdiMbVg@mail.gmail.com>
In-Reply-To: <CANn89i+Vcwp9o59Fzy+epqS+YSxjrStNjBRX-5GSie_TdiMbVg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jun 2023 21:01:52 +0200
Message-ID: <CANn89iL3kLondF3ETBui8ik3sJW+1NR8SZFYWqw7FY4H5gcUjw@mail.gmail.com>
Subject: Re: [PATCH net] bonding: do not assume skb mac_header is set
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot <syzkaller@googlegroups.com>, Jarod Wilson <jarod@redhat.com>, 
	Moshe Tal <moshet@nvidia.com>, Jussi Maki <joamaki@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 9:00=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>

> Ah right, I will send another patch to remove it then.
>
> I think it makes sense to keep the first patch small for backports.
>
> History of relevant patches :
>
> from 5.17
>
> 429e3d123d9a50cc9882402e40e0ac912d88cfcf bonding: Fix extraction of
> ports from the packet headers
>
> from 5.15
>
> a815bde56b15ce626caaacc952ab12501671e45d net, bonding: Refactor
> bond_xmit_hash for use with xdp_buff

If this is ok for you, I will cook this cleanup patch for net-next.

