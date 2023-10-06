Return-Path: <netdev+bounces-38698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563467BC2B5
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 01:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10710281D5B
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8E845F55;
	Fri,  6 Oct 2023 23:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ZKC/Ywn3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52095405CC
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 23:00:14 +0000 (UTC)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014B493
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 16:00:12 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a22eaafd72so33048657b3.3
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 16:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696633212; x=1697238012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gabx83mkdkAF+mntRr9mKGx7YG9alnvDTRI9TE3DSrE=;
        b=ZKC/Ywn3goS0IsxnqeN0kYkj+JSdlJVnkGLHuGshm/p5xd4Sm4wrbAAWymT1oQphG6
         ShKYs81kYz/qwZxHKxKkRuS/U/ZB1dcslgXcIx/Leertw3KShr5sh78vhDsgBTly+KDA
         pQHK6QTO8p++uxP32awCPOo4tDskXuYMLPSvRPhlSAMKrvRJ4a7dVSDv9Vx7hYSU9PWA
         /jS+x2mSdKojsEStsezd17EW9Y8o9KFwp45tPULtFVOmyht92oIVy4B5oMnxKpgQW2Qx
         wJvZT74NfvCT1aIN5souSgcqyCoD140fQuvMS9vc/4yuGHtLsLdM+7YI/4DMGee1FajR
         cCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696633212; x=1697238012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gabx83mkdkAF+mntRr9mKGx7YG9alnvDTRI9TE3DSrE=;
        b=A8smMwFye5voXkEkYk2RzcM+/2aAxVTPNwhior8mwope/K443xMr9AtgJrS6Tnu4cy
         YcGkUfPPaQnLXGGwEKVbkJaQU9qv+472t6YhzI/jxvNaFhtMb/DtAa/E16tGGx9iN7aO
         5Zv3Wh1EkJSDjeHXuCuzpeuajgpEC/A9G6kOq87gpxWZVaV0F0bvjxBByM8+6U+x+ATD
         B+RwgXzOnN/cgh//hkMDW369hjBvXXwSwO8Jl21rF5uuy84CLC2guRKLnSbYaOYhh9kh
         uphH5EPLeqhEbJ3S3OY0UhBX9lwiMFWMmKxIl0DqC0Zrw7zpEMCI/QiXmwLTokqV52pF
         oyEQ==
X-Gm-Message-State: AOJu0YwA4NN49ogO0L+jAX8yEVArjb1j5JQn2iGDH/EKcU3r7UV35EEQ
	3mSj0Hyj4RHls13ub0gAiWhBGPNqipxFSOXHV9fsKg==
X-Google-Smtp-Source: AGHT+IFPauGVVInsQlk/S1sIrEh3Yy2/zWuiweTLijPBbGPzSAPyZBOwL1i3e4C7jLLjk0FUQdRB4NLwDFcxZL6RVFk=
X-Received: by 2002:a25:2603:0:b0:d80:2525:9f1 with SMTP id
 m3-20020a252603000000b00d80252509f1mr9162391ybm.43.1696633211797; Fri, 06 Oct
 2023 16:00:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231005184228.467845-1-victor@mojatatu.com> <ZSAEp+tr1oXHOy/C@nanopsycho>
 <CAM0EoM=HDgawk5W70OxJThVsNvpyQ3npi_6Lai=nsk14SDM_xQ@mail.gmail.com>
 <ZSA60cyLDVw13cLi@nanopsycho> <CAM0EoMn1rNX=A3Gd81cZrnutpuch-ZDsSgXdG72uPQ=N2fGoAg@mail.gmail.com>
 <20231006152516.5ff2aeca@kernel.org>
In-Reply-To: <20231006152516.5ff2aeca@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 6 Oct 2023 19:00:00 -0400
Message-ID: <CAM0EoM=LMQu5ae53WEE5Giz3z4u87rP+R4skEmUKD5dRFh5q7w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/3] net/sched: Introduce tc block ports
 tracking and use
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	mleitner@redhat.com, vladbu@nvidia.com, simon.horman@corigine.com, 
	pctammela@mojatatu.com, netdev@vger.kernel.org, kernel@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 6:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 6 Oct 2023 15:06:45 -0400 Jamal Hadi Salim wrote:
> > > I don't understand the need for configuration less here. You don't ha=
ve
> > > it for the rest of the actions. Why this is special?
>
> +1, FWIW

We dont have any rule that says all actions MUST have parameters ;->
There is nothing speacial about any action that doesnt have a
parameter.

> > It is not needed really. Think of an L2 switch - the broadcast action
> > is to send to all ports but self.
>
> We do have an implementation of an L2 switch already, what's the use
> case which necessitates this new action / functionality?

It is not an L2 switch - the L2 example switch was what came to mind
of something that does a broadcast (it doesnt depend on MAC addresses
for example). Could have called it a hub. Ex: you could match on many
different header fields or skb metadata, then first modify the packet
using NAT, etc and then "blockcast" it.

cheers,
jamal

