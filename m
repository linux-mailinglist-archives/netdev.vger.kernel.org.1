Return-Path: <netdev+bounces-37298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF4E7B492A
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 20:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7636F281947
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 18:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AAF944D;
	Sun,  1 Oct 2023 18:32:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC012C9C
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 18:32:42 +0000 (UTC)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B87BC;
	Sun,  1 Oct 2023 11:32:41 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-493545b4eaeso6032640e0c.0;
        Sun, 01 Oct 2023 11:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696185160; x=1696789960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DcVEQGg6qZGoqogLhWFLoEzZgtq6V1bFW3xrc404XE=;
        b=OKxXp+aI7bPaxFYMXep40QANYDKg6/WFOnMg0/gdFwSGXj9ffMH8aF5BHsnP/xEyea
         qzgNY0WcIygcGFqxZkUDjCUs0/AaawfgetL3QjBJcwKNYuzNuGsvmXg2oUcx2RqS855M
         zGHLS43AoY51uti/SrX75+r9vd3Jo9VM6OWDhT5No2Ivb1GSH3w7dAevgHIt15D6R0uF
         mSPFhbmuMXriyQR3miSFUEoK7v2KpxNt+gwnbdrB47nQIYisb0z0PywjzqbV/5d3ZZWD
         L0ILnwBz+0lBtS1gj8GbZbUH76NBlcpUuLOlF5FGS9Io7rYiG7qD0ldO60O4tmW7ahrf
         CZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696185160; x=1696789960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DcVEQGg6qZGoqogLhWFLoEzZgtq6V1bFW3xrc404XE=;
        b=HYpOu2DiVdobF/8GJ7zfIXGONMxYAjTsoUCOi/Av3ecEgSUj7YKhLwAgIU4sJTo5IA
         Qp8VH5Dx4QvN7Ag1tjNFUQLXLfsEBjwp3EYE84FAgfwpP8cTGHaCdxZJS3ehJdfTDCgk
         tA+W1UNmi47JY0QFx6UYGn0j8bWuEsew7rBL+u3MgMWvdmhSp7u7eamskW7T5mqKxSi9
         Vc3budir+ZKPpWomneisgz+omTOqD02tzyB5V5xaBFqWTE2OAy2bT2yNHGye3+8VU510
         FGsGRCCj8aSfRE8L1Vih8/PP1jr1jIiKgs8QsVc0mmddVMLMNfknHKaL8Q/ANxzVLiRU
         708Q==
X-Gm-Message-State: AOJu0Yx0ymqiXgRjG4rrJ1i86o34BoS1JWSvVFe6sc1KXJru9vz1PDTy
	L09FjWsCwI53EHYpvx10xEWACUZu8hReOgi7qmA=
X-Google-Smtp-Source: AGHT+IE7sQ1E4Yn1wNIFWeDN+ChHGUkM2dJfGTpw+ft86RC4xEqlaY10no/i3ARlEyUs2Bj2BDNWWV5dW3BB5SrDQkQ=
X-Received: by 2002:a1f:4c44:0:b0:49a:317c:ba5e with SMTP id
 z65-20020a1f4c44000000b0049a317cba5emr5791830vka.8.1696185159992; Sun, 01 Oct
 2023 11:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926182625.72475-1-dg573847474@gmail.com>
In-Reply-To: <20230926182625.72475-1-dg573847474@gmail.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sun, 1 Oct 2023 11:32:28 -0700
Message-ID: <CAM_iQpUbDR1S6hY6gPhjXrnWCQHGjQZ6JcB27zbauzdBhP76RA@mail.gmail.com>
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 26, 2023 at 11:27=E2=80=AFAM Chengfeng Ye <dg573847474@gmail.co=
m> wrote:
>
> I find tcf_gate_act() acquires &gact->tcf_lock without disable
> bh explicitly, as gact->tcf_lock is acquired inside timer under
> softirq context, if tcf_gate_act() is not called with bh disable
> by default or under softirq context(which I am not sure as I cannot
> find corresponding documentation), then it could be the following
> deadlocks.

Did you find this during code review or did you see a real
lockdep splat? If the latter, please include the full lockdep log.

Thanks.

