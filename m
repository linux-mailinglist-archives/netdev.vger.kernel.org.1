Return-Path: <netdev+bounces-22666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 293947689F7
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 04:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D093E2810E3
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 02:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03E962F;
	Mon, 31 Jul 2023 02:25:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5978629
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 02:25:00 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DF3E4E
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 19:24:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-268299d5d9fso2196982a91.1
        for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 19:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690770299; x=1691375099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WJGbTzBWWyLthYKvFHYFfDGIjVylpKt1feyDxG3xoY=;
        b=JZM+YnxhF57V3REfJ6Q/phNRJvycZOWrLWuMsmptcUSrCEPjSweMC7uEC+ywDAtrfl
         PDF8Hz92PvsHUwdwED7I/shUd9wzE1IVDfo/OejXYkuVTBmgoQUgP4dXKjJLkyKXVWNz
         3PRGEMdAJfTI5F4129d2cFvj+yAjts1Kgpk+aBnXWWW7idT0BjfbHfqDdS5o+wJpheDz
         YliKkxuP2WdVOo+nC/ijKbaN1PJb4hMTOMMv/6Myqq1kQPIYnbBSjiNPtKXhqgCdb8Qx
         TzWvTIMX3+TvdsI/yNUUQg1MZzegFgAZk71OG3n1ijx2ZpFnhK0a4Lzh2appZehDaITk
         4veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690770299; x=1691375099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WJGbTzBWWyLthYKvFHYFfDGIjVylpKt1feyDxG3xoY=;
        b=YzRuaDNlj46VKJuXIyevTN7JzozEmv77gDFPdx/S2xfIhe8JODWdHariMTaEqErbsG
         VdiW/d00+kVe1Oh9LWIKEFd57BbyCqpz2esWgl20/wzIpQyXkqOc/4pw3JAZ0ffEB6pU
         ZwwF7fVK1xn/tM9FEZtR3ZscuWuv17BmJqhmzeZ7SBJhbsfEUHpzTjcqMgtT3wwcwvnJ
         2SYtDYd1TN8YJsYowlRTgkpB7+97jNCCnz1OQZQwl0yBsQ/ol70Ud0AIdYIA2rq29Ne9
         xC209xfil5ESvVMrCJHIg7L6sHW0wcSWjpZpi6EAfz6jGNnoU7A5CBeRpnqxLTU/oQcR
         FZwA==
X-Gm-Message-State: ABy/qLYfh1+61SD301tYlgs+RfAasSmEqMyBM72IA/jPf+AJ9VHp2N4s
	32vpQ8GLxhdO1bnPlJxN1bmu+C1iNTTYvfIWVS7h
X-Google-Smtp-Source: APBJJlEJ65CGI2+MsoymADeLmpN7lv9jLT77xSzuwL8zvJnrlqrMOy2zRhM179uVohKj3PjVe5q6QspU/YR0YoUXmWs=
X-Received: by 2002:a17:90a:74cc:b0:268:3b8b:140d with SMTP id
 p12-20020a17090a74cc00b002683b8b140dmr6635192pjl.35.1690770299166; Sun, 30
 Jul 2023 19:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230705114505.63274-1-maxime.coquelin@redhat.com>
In-Reply-To: <20230705114505.63274-1-maxime.coquelin@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Mon, 31 Jul 2023 10:24:47 +0800
Message-ID: <CACycT3tVOKVvhTab7cbjFJsVk3vnWwqyaZ6pGvKmxO8jADj65Q@mail.gmail.com>
Subject: Re: [PATCH] vduse: Use proper spinlock for IRQ injection
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	David Marchand <david.marchand@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	virtualization <virtualization@lists.linux-foundation.org>, Netdev <netdev@vger.kernel.org>, 
	xuanzhuo@linux.alibaba.com, Eugenio Perez Martin <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 7:45=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> The IRQ injection work used spin_lock_irq() to protect the
> scheduling of the softirq, but spin_lock_bh() should be
> used.
>
> With spin_lock_irq(), we noticed delay of more than 6
> seconds between the time a NAPI polling work is scheduled
> and the time it is executed.
>
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Cc: xieyongji@bytedance.com
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji

