Return-Path: <netdev+bounces-23963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C80F76E531
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 12:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D5E1C20C1D
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF6515AD7;
	Thu,  3 Aug 2023 10:04:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E9A1548F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 10:04:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4269EFC
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 03:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691057079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McoNTIMuK5zMDVano2/oBxpTU9klATcskOJG6KujI/k=;
	b=c8a4QYpygJhnsC9AUDRuOl2PuIn+HIh3GJkhy5B6bw4D6Yn6mnbqqK/5aARD1rGsjrBwRK
	KLj8h7UEwfLybik2Lvg/N+xkoS0rXXyOYV52ONy9L0HIJYCOFFcN//f/in0HqsmQPnTHvN
	dwufCVxPYW6p9UdN5+brmhls9twaBqs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-M-8lCp_1Ng6pPzIkcd6IsQ-1; Thu, 03 Aug 2023 06:04:37 -0400
X-MC-Unique: M-8lCp_1Ng6pPzIkcd6IsQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40fed04ea2aso867411cf.0
        for <netdev@vger.kernel.org>; Thu, 03 Aug 2023 03:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057077; x=1691661877;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=McoNTIMuK5zMDVano2/oBxpTU9klATcskOJG6KujI/k=;
        b=OScb2mTBlyzrR6xOVquCp0RVQpAtjRyg2rZ/sU/JLDpk8iVnR3l6XxjTRXvZ1vbRTd
         XyGWcSGXrN/Wh8cGgmqlHf4hVqFR9hj1fOtiEA0TwtpCKK91qZMXTdZDAxaqYy5PiU9Z
         CcYVMhA82v9liFMKgR9xGnGv1qrHUYWmFioO90Ww6CirPRTDxM9S+9z4gY8nDU7cvMep
         rNKtmxCaUeny7hFqVRQHp1iLnOvJ/I+k+DFPQTiTZr85n+zlTTCO/MDiDbvpp0+poR0x
         CmUeaqTAs32nonGJZWLAup0WntLJQjQoktlRzNmbb5FO4NvNnFH06sQ4NPj9tvdgnC2O
         iMnA==
X-Gm-Message-State: ABy/qLaNVDiknIax54EqYVKRzqlsy4D9fE7llKkE2UhxMSLxwmv0cUBn
	J6FYXwUOePMMAZWJ7hfJvpsKaTwdNx36L5cCqTveOF3/MezeefWaOrX76QRaaABralMbDGnDLFJ
	FS+5DJpSHaqrBPx0F
X-Received: by 2002:a05:622a:1aa5:b0:40c:8ba5:33e0 with SMTP id s37-20020a05622a1aa500b0040c8ba533e0mr19691153qtc.3.1691057077032;
        Thu, 03 Aug 2023 03:04:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGgowyf6XhafmTFhwd4kIxj/a9sk7muDM9IwOhYJ5Cfu4506FYfrrjqry1ZVBPlzqgd92Dqag==
X-Received: by 2002:a05:622a:1aa5:b0:40c:8ba5:33e0 with SMTP id s37-20020a05622a1aa500b0040c8ba533e0mr19691138qtc.3.1691057076756;
        Thu, 03 Aug 2023 03:04:36 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-226.dyn.eolo.it. [146.241.226.226])
        by smtp.gmail.com with ESMTPSA id q5-20020ac87345000000b004069782c943sm6061394qtp.40.2023.08.03.03.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 03:04:36 -0700 (PDT)
Message-ID: <c90e655ed51d8a0e21e529573ebb46040de91663.camel@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH v3 net-next 00/10] Improve the taprio
 qdisc's relationship with its children
From: Paolo Abeni <pabeni@redhat.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, Pedro Tammela <pctammela@mojatatu.com>, 
 Richard Cochran <richardcochran@gmail.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, linux-kernel@vger.kernel.org,  Eric Dumazet
 <edumazet@google.com>, intel-wired-lan@lists.osuosl.org, Maxim Georgiev
 <glipus@gmail.com>,  Cong Wang <xiyou.wangcong@gmail.com>, Peilin Ye
 <yepeilin.cs@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Zhengchao Shao
 <shaozhengchao@huawei.com>, "David S. Miller" <davem@davemloft.net>
Date: Thu, 03 Aug 2023 12:04:32 +0200
In-Reply-To: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
References: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Tue, 2023-08-01 at 21:24 +0300, Vladimir Oltean wrote:
> Changes in v3:
> Fix ptp_mock compilation as module, fix small mistakes in selftests.
>=20
> Changes in v2:
> It was requested to add test cases for the taprio software and offload mo=
des.
> Those are patches 08 and 09.
>=20
> That implies adding taprio offload support to netdevsim, which is patch 0=
7.
>=20
> In turn, that implies adding a PHC driver for netdevsim, which is patch 0=
6.
>=20
> v1 at:
> https://lore.kernel.org/lkml/20230531173928.1942027-1-vladimir.oltean@nxp=
.com/
>=20
> Original message:
>=20
> Prompted by Vinicius' request to consolidate some child Qdisc
> dereferences in taprio:
> https://lore.kernel.org/netdev/87edmxv7x2.fsf@intel.com/
>=20
> I remembered that I had left some unfinished work in this Qdisc, namely
> commit af7b29b1deaa ("Revert "net/sched: taprio: make qdisc_leaf() see
> the per-netdev-queue pfifo child qdiscs"").
>=20
> This patch set represents another stab at, essentially, what's in the
> title. Not only does taprio not properly detect when it's grafted as a
> non-root qdisc, but it also returns incorrect per-class stats.
> Eventually, Vinicius' request is addressed too, although in a different
> form than the one he requested (which was purely cosmetic).
>=20
> Review from people more experienced with Qdiscs than me would be
> appreciated. I tried my best to explain what I consider to be problems.
> I am deliberately targeting net-next because the changes are too
> invasive for net - they were reverted from stable once already.

The series LGTM, modulo the minor comments from Kurt on patch 6/10. I
agree they can be handled with follow-up patches.

Keeping it a little longer on PW: it would be great if someone from the
tc crew could have a look!

Thanks!

Paolo


