Return-Path: <netdev+bounces-32462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBFA797B25
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 20:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99B928155F
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 18:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C1413FE3;
	Thu,  7 Sep 2023 18:05:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896B713AC3
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 18:05:18 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A791710;
	Thu,  7 Sep 2023 11:04:55 -0700 (PDT)
Date: Thu, 7 Sep 2023 12:15:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694081728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cq8rae8UZhseve8ECsfKS9IcW0y6Ca5VZnDm6gs+Jes=;
	b=MdkPSIZ/ynC2raAdMlJZvDo2L3P/3lIogpcaDXFrLH9+JudFvEqpMKSdQQNkfHsUposgoZ
	5mgUStkvFDTFQNRBbBdZf/gVnHVza23KbQtvVuNdg6adnK6afucoW2iAva9UM1D6BrUXLe
	06PyA+kdFWPCXBEacA7RvklmkkYr2F5sFrJLtocpwTyqMDARS0m3P7ldhsJcf7S2sNiR0L
	SHREku/NK+p6Cb2+Chl5DM70I1wHAJ2ErkbU94thVcOgkfC0n3My34oEWqocLqRRAbz4sh
	+7X/dvC2SM/nN8t9R6mIBP5uLk9QA2mR68GUoneVQ4vPdaSAZAcujY6C7RxpuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694081728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cq8rae8UZhseve8ECsfKS9IcW0y6Ca5VZnDm6gs+Jes=;
	b=OvnOiF36jjpXi1C6cMeCm/YLONfshth+JYHRtDt94iVOW2dW6MJz21RlxSjf38BkHlqMqE
	tnbJZ/2en32SHZBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Geethasowjanya Akula <gakula@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Hariprasad Kelam <hkelam@marvell.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"alexander.duyck@gmail.com" <alexander.duyck@gmail.com>,
	"ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
	"linyunsheng@huawei.com" <linyunsheng@huawei.com>
Subject: Re: RE: [EXT] Re: [PATCH net v2] octeontx2-pf: Fix page pool cache
 index corruption.
Message-ID: <20230907101527.45YwOJcG@linutronix.de>
References: <20230907014711.3869840-1-rkannoth@marvell.com>
 <20230907070955.0kdmjXbB@linutronix.de>
 <MWHPR1801MB19187A03AF45B0E23B534B6BD3EEA@MWHPR1801MB1918.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <MWHPR1801MB19187A03AF45B0E23B534B6BD3EEA@MWHPR1801MB1918.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-07 08:15:58 [+0000], Ratheesh Kannoth wrote:
> > From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Subject: [EXT] Re: [PATCH net v2] octeontx2-pf: Fix page pool cache ind=
ex
> > corruption.
> > >  	cq->refill_task_sched =3D false;
> > > +
> > > +	local_bh_disable();
> > > +	napi_schedule(wrk->napi);
> > > +	local_bh_enable();
> >=20
> > This is a nitpick since I haven't look how it works exactly: Is it poss=
ible that the
> > wrk->napi pointer gets overwritten by
> > otx2_napi_handler() since you cleared cq->refill_task_sched() earlier?
> I don=E2=80=99t see any issue here.  As NAPI and workqueue execution is s=
erialized (as interrupt is disabled when=20
> Workqueue is scheduled).  I don=E2=80=99t think we can move "refill_task_=
sched =3D false" after local_bh_enable().=20
> But we can move refill_task_sched =3D false as below . but I don=E2=80=99=
t see a need.=20

Right, there might be no issue I was just asking. I don't know how the
cq <-> NAPI mapping is working. If you say that there is no race/issue,
okay ;)

>  +
>  +	local_bh_disable();
>  +	napi_schedule(wrk->napi);
>   +	cq->refill_task_sched =3D false;
>  +	local_bh_enable();

Sebastian

