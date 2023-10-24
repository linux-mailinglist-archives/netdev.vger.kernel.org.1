Return-Path: <netdev+bounces-43751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A087D48A3
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 09:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E4F1C20AE1
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 07:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A9014A9F;
	Tue, 24 Oct 2023 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dI75M02X"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7B613AFC
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 07:35:34 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D026310D8
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 00:35:30 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9c145bb5bso94195ad.1
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 00:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698132930; x=1698737730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uyep+u71crtfaR4lFjOq7pR39SPnIQZqdddTx57In1c=;
        b=dI75M02Xv850RuqhbVJbDxjzdjdwvsqVcGYZ1YDOt55aFXeIVlhQkBrYXIAB/7iZfs
         cmR/PLwc/0xrJYA+0GzUBXAGDvscWxjF6IMht0n8kROeqyR5xXJFKrxotDtDdqLSrqbS
         cMAIxLmYsup62Hhzt+x66ADpdbII6nROUEzjXI3fR4BCUyfrxBFfdDGdmY0wNeockcq9
         PHG/EbEHbJamz+7NYPRjUSG60E07jIEPKTHA28uJBZDwzTFAOt6v1YGONOFSRLCS8++z
         7tp+NE7Ivpk+vJ2jYpKMsjZCzAeQov1X81bdn2S9ej880RkWGzpPu+eDqBOM2PSxddAz
         VNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698132930; x=1698737730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uyep+u71crtfaR4lFjOq7pR39SPnIQZqdddTx57In1c=;
        b=bWFWn5HMciz3aacytzGkCqiaJEx/mr3426hxJhH2SFZIgnMEeeUS1VrY6GPXDaVsqC
         cGCmLA0fgIzRXoFvjgZASRdf2aS2F5JGUMzfayt8zQuBLXbZePWaXs1xOdD4ngOafn/5
         gJ68EsZqR1RS2o3nZ4v6eHBQJhyUnzp3p42P4RB0te4yiO6ZVUaSyj92eTMftATYQLBp
         Bg5+d0XyGct6TGL6vgyUgM1hg7aZa9CEQzob8Q7iKcFbHilz2VpGODw4Rqgt9/Wh1yur
         VJVxqckE4mI3dPPUR8oNYI/rQPz1rusanjO1O2TuKgzu+AMeB4V8mp7djVvYFZSrBTzj
         LB9w==
X-Gm-Message-State: AOJu0Yz8Ro7Fg7uJTNMnt1rMw6P6NDT5onCq/Of4ZrGynTHnlTjr6GJi
	bw7aYGlskQ7sc6q0rp8BWFvmf5Jd2iVaCRo0fN1rdA==
X-Google-Smtp-Source: AGHT+IH2U2wjlJhZU4maQKEC7MX9MJ2lmSSUVHJxpBXDZMYoB9uPHOCxx3ZtCWo3ROSpAdvF7groh0U0QmI4cUm1ZYc=
X-Received: by 2002:a17:902:d586:b0:1c9:e48c:726d with SMTP id
 k6-20020a170902d58600b001c9e48c726dmr184955plh.4.1698132929698; Tue, 24 Oct
 2023 00:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
 <20231019120026.42215-3-wuyun.abel@bytedance.com> <69c50d431e2927ce6a6589b4d7a1ed21f0a4586c.camel@redhat.com>
In-Reply-To: <69c50d431e2927ce6a6589b4d7a1ed21f0a4586c.camel@redhat.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Tue, 24 Oct 2023 00:35:18 -0700
Message-ID: <CALvZod5EMJcxZgmvUXun29R-PrT-v=18DHpd40QLNweXz71vFw@mail.gmail.com>
Subject: Re: [PATCH net v3 3/3] sock: Ignore memcg pressure heuristics when
 raising allocated
To: Paolo Abeni <pabeni@redhat.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 12:08=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Thu, 2023-10-19 at 20:00 +0800, Abel Wu wrote:
> > Before sockets became aware of net-memcg's memory pressure since
> > commit e1aab161e013 ("socket: initial cgroup code."), the memory
> > usage would be granted to raise if below average even when under
> > protocol's pressure. This provides fairness among the sockets of
> > same protocol.
> >
> > That commit changes this because the heuristic will also be
> > effective when only memcg is under pressure which makes no sense.
> > So revert that behavior.
> >
> > After reverting, __sk_mem_raise_allocated() no longer considers
> > memcg's pressure. As memcgs are isolated from each other w.r.t.
> > memory accounting, consuming one's budget won't affect others.
> > So except the places where buffer sizes are needed to be tuned,
> > allow workloads to use the memory they are provisioned.
> >
> > Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> > Acked-by: Shakeel Butt <shakeelb@google.com>
> > Acked-by: Paolo Abeni <pabeni@redhat.com>
>
> It's totally not clear to me why you changed the target tree from net-
> next to net ?!? This is net-next material, I asked to strip the fixes
> tag exactly for that reason.
>
> Since there is agreement on this series and we are late in the cycle, I
> would avoid a re-post (we can apply the series to net-next anyway) but
> any clarification on the target tree change will be appreciated,
> thanks!
>

I didn't even notice the change in the target tree. I would say let's
keep this for net-next as there are no urgent fixes here.

