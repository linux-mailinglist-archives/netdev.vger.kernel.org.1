Return-Path: <netdev+bounces-47384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8687E9F30
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 15:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D1CBB20955
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 14:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F401920B3B;
	Mon, 13 Nov 2023 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxJ35U9+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2D20B3D
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 14:52:01 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680A019F
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 06:51:56 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-543923af573so7007634a12.0
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 06:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699887115; x=1700491915; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nTvRuDI9BOasudtu0gVcjNrp1zN5CwZUulqYbjdj11E=;
        b=cxJ35U9+JotGw3t380QrNP6wCONGzk0dbjRx4zsiiqI+BF23zHVcS+7jve3ehc0UNo
         RusGGCZsvT/1hKCUDuHpJFXCJCrfLuk6IqzMvaMhG/2hQE75u5jwwH2YCe7Jax9PL2i6
         43TZeVjbhqpfE1JD9TSWDO+aO1t9M9m3LyRJ2a3njUgnAE7Aca3S0vkhKl1Z8hdwbSAa
         ifQPd0oh/tOALwiVVJg0CaCS8LFMVdE5HL2mJkCZyH2EdgYnAwfE8T2ygtn0NNkGifLi
         udKEu1PdlYYcp7arubMlxD87tymS7hyIxPEGoq2Ov/zapQmfsw3CiQppoErMuBLJuIwx
         X7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699887115; x=1700491915;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTvRuDI9BOasudtu0gVcjNrp1zN5CwZUulqYbjdj11E=;
        b=nVUEeimLy/KKba6aXqCk30sjP1o5ycm1RnOivYqCGY4qnlZEMSGtMSlShwfk89A4Gh
         neA51CUQe8iSjPvtzYAvTYvWWwNeNgA4sEsafU3da27Kz5/8++e4/QIbZtqq8PqqXuP8
         9iQLhwmBqO0BruFCpKSZDsm6Og5prJplZJ73PFtaYbNUa1MBBwtygDu8ucyRQrC6d9z0
         Xk4Ez/C6L+iOj4cNvFtyEJYh/XHkHVrUlmc7sT9LBoItktjUFquZBjsQcul3mrT12vHJ
         pvHE8u2Wf5BMGb1ayVkjgBgRQeSlQUtVD12GQIf+U/DPwSagjf4nDPieGbvs4iqvbBzd
         RYdw==
X-Gm-Message-State: AOJu0YzCnxCEB0K+0VbmnCDxGjotQQMt3WrI6urKuFPo58HsjVSc8iC/
	VCkSyq/kCHhpOqFrT/3mrAc=
X-Google-Smtp-Source: AGHT+IFvwprtirbG/c02UrP5m5Owzq5JjhW68OthFc10HE/OeK4jyisHrmgFETXImzViK466Ynb2Aw==
X-Received: by 2002:a05:6402:793:b0:540:ef06:23d7 with SMTP id d19-20020a056402079300b00540ef0623d7mr5705833edy.1.1699887114586;
        Mon, 13 Nov 2023 06:51:54 -0800 (PST)
Received: from localhost (srv28160.blue.kundencontroller.de. [81.7.10.216])
        by smtp.gmail.com with ESMTPSA id bx23-20020a0564020b5700b00533dad8a9c5sm3825810edb.38.2023.11.13.06.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 06:51:54 -0800 (PST)
Date: Mon, 13 Nov 2023 16:51:39 +0200
From: Maxim Mikityanskiy <maxtram95@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Chittim, Madhu" <madhu.chittim@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	xuejun.zhang@intel.com, sridhar.samudrala@intel.com
Subject: Re: [PATCH net] net: sched: fix warn on htb offloaded class creation
Message-ID: <ZVI3-w5dsLIhqHav@mail.gmail.com>
References: <ff51f20f596b01c6d12633e984881be555660ede.1698334391.git.pabeni@redhat.com>
 <ZTvBoQHfu23ynWf-@mail.gmail.com>
 <131da9645be5ef6ea584da27ecde795c52dfbb00.camel@redhat.com>
 <ZUEQzsKiIlgtbN-S@mail.gmail.com>
 <5d873c14-9d17-4c48-8e11-951b99270b75@intel.com>
 <ZU4PBY1g_-N7cd8A@mail.gmail.com>
 <63b9b3f40d0476ada2972ea8f6058b3613520ba8.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63b9b3f40d0476ada2972ea8f6058b3613520ba8.camel@redhat.com>
X-Spam-Level: **

On Sun, 12 Nov 2023 at 09:48:19 +0100, Paolo Abeni wrote:
> On Fri, 2023-11-10 at 13:07 +0200, Maxim Mikityanskiy wrote:
> > On Thu, 09 Nov 2023 at 13:54:17 -0800, Chittim, Madhu wrote:
> > > We would like to enable Tx rate limiting using htb offload on all the
> > > existing queues.
> > 
> > I don't seem to understand how you see it possible with HTB.
> 
> I must admit I feel sorry for not being able to join any of the
> upcoming conferences, but to me it looks like there is some
> communication gap that could be filled by in-person discussion.
> 
> Specifically the above to me sounds contradictory to what you stated
> here:
> 
> https://lore.kernel.org/netdev/ZUEQzsKiIlgtbN-S@mail.gmail.com/
> 
> """
> > Can HTB actually configure H/W shaping on
> > real_num_tx_queues?
> 
> It will be on real_num_tx_queues, but after it's increased to add new
> HTB queues. The original queues [0, N) are used for direct traffic,
> same as the non-offloaded HTB's direct_queue (it's not shaped).
> """

Sorry if that was confusing, there is actually no contradition, let me
rephrase. Queues number [0, orig_real_num_tx_queues) are direct, they
are not shaped, they correspond to HTB's unclassified traffic. Queues
number [orig_real_num_tx_queues, real_num_tx_queues) correspond to HTB
classes and are shaped. Here orig_real_num_tx_queues is how many queues
the netdev had before HTB offload was attached. It's basically the
standard set of queues, and HTB creates a new queue per class. Let me
know if that helps.

> > What is your goal? 
> 
> We are looking for clean interface to configure individually min/max
> shaping on each TX queue for a given netdev (actually virtual
> function).

Have you tried tc mqprio? If you set `mode channel` and create queue
groups with only one queue each, you can set min_rate and max_rate for
each group (==queue), and it works with the existing set of queues.

> Jiri's suggested to use TC:
> 
> https://lore.kernel.org/netdev/ZOTVkXWCLY88YfjV@nanopsycho/
> 
> which IMHO makes sense as far as there is an existing interface (qdisc)
> providing the required features (almost) out-of-the-box. It looks like
> it's not the case.
> 
> If a non trivial configuration and/or significant implementation are
> required, IMHO other options could be better...
> 
> > If you need shaping for the whole netdev, maybe HTB
> > is not needed, and it's enough to attach a catchall filter with the
> > police action? Or use /sys/class/net/eth0/queues/tx-*/tx_maxrate
> > per-queue?
> 
> ... specifically this latter one (it will require implementing in-
> kernel support for 'max_rate', but should quite straight-forward).
> 
> It would be great to converge on some agreement on the way forward,
> thanks!
> 
> Paolo
> 

