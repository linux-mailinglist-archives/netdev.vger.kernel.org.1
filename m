Return-Path: <netdev+bounces-24462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 058FF7703DD
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C371C2185F
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70777CA75;
	Fri,  4 Aug 2023 15:04:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF5CA6E
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:04:48 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B73AC
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:04:46 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-4036bd4fff1so345591cf.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 08:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691161486; x=1691766286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k0gPH/5fLsW5OXxY6UosW9Su29KJ2LezAZusZZgYyjc=;
        b=Mrqg6W8E+MYoAwQG7E7CZDp7LrntRm3k1tvAO5pyQwBEg1x6P0QLCPpuRc0nYkKu08
         W1bSQg9L3hwfYy8OWcP20FfQAR8CgQ2hVH2wUP7QzmJWBBPG8Iwo3db8KPDmgtKYRDFs
         Y4w0MY4aV3yQIGZoigSyPmWgsxAluO/WSWDvBtWFLUzj30BWeKpKnvqGSfI3AXqBv/wx
         ta9DGkl03aKiQYHiBFU5tjEiGuhJc6VEHHeUucE2XvS8m8gWurHq/wUOW9cdzSvA3MJH
         wrpvlZA1Zb0eDpE8VBn2eiReRu6o7YlWM+towgMHS4z+Ht0S1keDPwnwRul/+rZK+zwV
         WSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691161486; x=1691766286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k0gPH/5fLsW5OXxY6UosW9Su29KJ2LezAZusZZgYyjc=;
        b=TJEvxdeHMtG7AG/zT/cFhtCWZUahPpKtX03pV9EHvaNFLE+tTE9JHQv/fuOyJwYR3Z
         Y1nQIsQb7tSV7OKtYyUtyev1jKgZSJggWgBVQOqrRdeKWRXzVf4Nykhj46kGuuapEoi1
         IwMl4lSwAZZRWQSd6KvUO70hh3fAqAWJ4rM4VREWDQud/FIVZiQDIPsi39HA+oATtt/p
         px034I+IHKJCMxRS1TCiXDL6Xl1ZWGp4QRcemUDZns/uBXpI+oA9gxMemn+tICWDyoH9
         +6P+d15T16n8ggEajmFr6wwTFnnLNqyXhvcmo8tPFH34TsdUC3dI/Lap/bs8+TKagNnL
         TPdg==
X-Gm-Message-State: AOJu0Yw9X/W+0yn2LFFbsi78Ch5RKDbT1VNCR4sO3bDLTDwZysRTYNGv
	j56MGmKK6md5i+vJyL3Jf3/QQotwj1APAtpaHFvjsw==
X-Google-Smtp-Source: AGHT+IEzENuBMs0742Mcg8ZVz683CWJmgot4aVByS9fV39OXrApvJMx70h8AljPstXbfl1Dd96MkaKAs6NVg/nc0/g8=
X-Received: by 2002:ac8:5c10:0:b0:3f8:e0a:3e66 with SMTP id
 i16-20020ac85c10000000b003f80e0a3e66mr201760qti.3.1691161485734; Fri, 04 Aug
 2023 08:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <16be6307909b25852744a67b2caf570efbb83c7f.1684502478.git.asml.silence@gmail.com>
 <ZM0QHZNKLQ9kVlJ8@zx2c4.com> <CANn89i+_DoEDcFY9SfNqQ+8bqJ0kFpt4waQ8CSvhchE4aP2Dhw@mail.gmail.com>
 <ZM0Sm6cx4Y76XLQ9@zx2c4.com>
In-Reply-To: <ZM0Sm6cx4Y76XLQ9@zx2c4.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Aug 2023 17:04:34 +0200
Message-ID: <CANn89iLTn6vv9=PvAUccpRNNw6CKcXktixusDpqxqvo+UeLviQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net/tcp: refactor tcp_inet6_sk()
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 4, 2023 at 5:02=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.com>=
 wrote:
>
> Hi Eric,
>
> On Fri, Aug 04, 2023 at 04:57:04PM +0200, Eric Dumazet wrote:
> > I think my patch fixed this issue, can you double check ?
> >
> > f5f80e32de12fad2813d37270e8364a03e6d3ef0 ipv6: remove hard coded
> > limitation on ipv6_pinfo
> >
> > I was not sure if Pavel was problematic or not, I only guessed.
>
> That appears to fix the issue indeed, thanks. As this is only in
> net-next, you may want to pick it into net for 6.5.

Sure, we will mark this patch as a stable candidate for 6.5

Thanks.

