Return-Path: <netdev+bounces-18372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E2D756A09
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985321C209EE
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 17:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB9A3D74;
	Mon, 17 Jul 2023 17:21:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E3253C2
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 17:21:00 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00DDD8
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:20:59 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f14865fcc0so207e87.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689614458; x=1692206458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5iPvBISsaBrumQ812DZCnzeBLmabacVakUCCCr350o=;
        b=66V26Pr3GtHQVKLp37aN/USD1TFmfpLsb05V7VRv1sL/sypBJiHTYWwmuDQqYUEGET
         QT9vQ+HMalyORPSuWBufdqmAMjmB85ShvmkpFdCnNl1O0ZCGEUXNZmvoBLuAw7HpaB28
         KPf7KyM6eh91b0kIpjCfr/lDUv1Y9mpmKpJ+gbZTwTXYp/ti5tD8jaII92Oii19Z8TPl
         uiJ3c2LlKDTzDqGz6HW6iuS/+xAfFnk5CMQz8vERXgMVRdcusMy9m8hYqJ6jGoLpOF6e
         XQrskghKzcvxw55FOTlN/6BCl3mkzl8D6hR9JAsBdh1lvEn+rttMG12pigT9RsX/NmrW
         ChyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689614458; x=1692206458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5iPvBISsaBrumQ812DZCnzeBLmabacVakUCCCr350o=;
        b=bKW7GnhO1r5HK8t4FE7jMz64kJs92Jx5Eb87v1EqwqTcxuLjGlR6A2gI7uFSkCPAhn
         DMgf62rWi3OvYpmTchtP+yojLvGQf2aVggoCt7OzHoffLsjIeaZG7Aujt12I10DeaStE
         bh0bXLdodqQpHtNRUp9MdnPar0Tlsg21d/f8BcauiSl/8V76pbOOLYAQfSQ1Y/HNjq2E
         eN+Qt799pu2QFl4UY5LpJLORAkgCjRryulsfrtai6F3jqxbk2i+YAao8whzQ4kSlS7Vg
         1fTXlcvwHgmaPGoWstectVtvMsauCXky9aTa25FeLr7jI9Bzet9XvU72Yx5Rdn1980hY
         qmtg==
X-Gm-Message-State: ABy/qLbKveFw47B4o0xIaHVwTW7eY+Z8qOz9ybksQmuygHeYJAHfv+Ja
	xt6UyrMzITapUD06p+zQ9NKw/y3b4LtxPOXlI1DySt4cv3KOkwn8Jog=
X-Google-Smtp-Source: APBJJlEJm9/C9+pS6w/JCp3kPE1zEdxYwz8QM5ta60Qm0dWiUU82LI8wApK2WLuqCpS8UoDxygmMMbcflu39WSk/M2k=
X-Received: by 2002:ac2:559a:0:b0:4fc:d7dd:8560 with SMTP id
 v26-20020ac2559a000000b004fcd7dd8560mr241499lfg.3.1689614457606; Mon, 17 Jul
 2023 10:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717152917.751987-1-edumazet@google.com> <CACSApvYwQah8Lxs_6ogBGigTSo=eK4YAVPahdU8oWmGjrujw3w@mail.gmail.com>
 <CANn89i+Z6RiTGjzxMkd13iy-mP6OaZxo_hOuxVEr0x=+N=0nxA@mail.gmail.com>
In-Reply-To: <CANn89i+Z6RiTGjzxMkd13iy-mP6OaZxo_hOuxVEr0x=+N=0nxA@mail.gmail.com>
From: Soheil Hassas Yeganeh <soheil@google.com>
Date: Mon, 17 Jul 2023 13:20:20 -0400
Message-ID: <CACSApvbVQ8uz9Rw1DG2aBUGAuTW75skYmC4B-B=WrAx3HcLPig@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: get rid of sysctl_tcp_adv_win_scale
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 17, 2023 at 1:17=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Jul 17, 2023 at 6:52=E2=80=AFPM Soheil Hassas Yeganeh <soheil@goo=
gle.com> wrote:
> >
> >
> > Should we use PAGE_SIZE instead of 4096?
>
> Great question. I thought of using 50%, but used this formula to kind
> of document the problem.
>
> Using PAGE_SIZE would probably hurt arches with large pages, for the
> initial round trip.
>
> Given that TCP normally uses IW10, there is almost no risk of tcp collaps=
ing
> for the first RTT.

This is a very good point. No change needed then.  Thank you!

