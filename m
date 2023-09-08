Return-Path: <netdev+bounces-32600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0E3798A24
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 17:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E7A281B39
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53145F517;
	Fri,  8 Sep 2023 15:43:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466E46AA2
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 15:43:11 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FF91FC6
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 08:43:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c35efd4141so158265ad.0
        for <netdev@vger.kernel.org>; Fri, 08 Sep 2023 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694187790; x=1694792590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejXqpKu8kQzY2C9Hwied0dLrXN/PvCiO6ZeCOYXfoyo=;
        b=eCEdDyXxGHpTTwIs90Wj/Fy/4ROMIrK23vc6InO3ftkAW/p80gkP+d9HnxawZnDpQE
         D3HoP4mm+wrsQf5mzZ5h21jdlstAkJuEyPRU0LfeWEjzBURvdqTAli55+IAKQQYSnsAG
         NB2F5WqAapAMsgooYBd3zRhPHBkVR4L2xOsNfHfgQmTqhvDPUy+/VYzgdZGaV1xyz44M
         nF6D71OBsY4sbUpTYv5TsG0+2/zOLEWQlA430OKJOQdwkGg+cyAUKTBXAOx8gjUY80px
         vCnXVPzIGyUMUlN3l7hObOhfrMxp7QESUuYuDGLIdOlbcUp0qISnIRSzO/SoGag2rji8
         grFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694187790; x=1694792590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ejXqpKu8kQzY2C9Hwied0dLrXN/PvCiO6ZeCOYXfoyo=;
        b=ALV4DNaEMDnhI7b83bLhGuJVFWZBVkIuU+wxzq2/Znk8vVfGCgGsLa0CVOIqlepzxy
         vIz/hfGBIFFWZGwklhnsiF6npIj5mT15enRY3Q5xHWqe6JfL75N4ELaAH8UNjn0/ALCM
         juM8x+0N3cnGJC+WNd2RXJgkz151amX6MUPaITISCtNE2TpFURNfI4ktAaMavyS+tYez
         poIamqdOzavSKFZhedmLzI6IJk+FhfwODSDvM9GNsLd/vU/Rvjb5SVwOfe3G1Rw4Qp5T
         iYk3jNB6N9W3gFGt86ic/WukTS/+xbh7cG7rEIGbSf6orD+q0PVsbzei1l6lE6dpmrim
         7cNw==
X-Gm-Message-State: AOJu0Yx/473moyzO/jv8L7tB5cSyQWwFR+6dMkiFVWLDPwF36HX7UXBP
	wsYbcYLrcV18tVsYkV6L5QsC2o9MVEya/bkdlE3hVQ==
X-Google-Smtp-Source: AGHT+IGF4KgcARS3ELwU3djcOgRsJ8LUV9Z2iRMZaHkfbRj2AhZyzhZsFu8/E8c4GO03km/XfNifFFOFwPf3OCxHkGA=
X-Received: by 2002:a17:902:d2d2:b0:1c3:39f8:3e72 with SMTP id
 n18-20020a170902d2d200b001c339f83e72mr272217plc.22.1694187789585; Fri, 08 Sep
 2023 08:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230901062141.51972-1-wuyun.abel@bytedance.com> <1d935bfc-50b0-54f3-22f0-d360f8a7c1ac@bytedance.com>
In-Reply-To: <1d935bfc-50b0-54f3-22f0-d360f8a7c1ac@bytedance.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Fri, 8 Sep 2023 08:42:58 -0700
Message-ID: <CALvZod6zuPy5p6m5ins2+BQMwmEeAWiz+C5vtF7pVZdcmKNGcQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/3] sock: Be aware of memcg pressure on alloc
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosryahmed@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Yu Zhao <yuzhao@google.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	David Howells <dhowells@redhat.com>, Jason Xing <kernelxing@tencent.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 8, 2023 at 12:55=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> Friendly ping :)
>

Sorry for the delay, I will get to this over this weekend.

