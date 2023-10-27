Return-Path: <netdev+bounces-44665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8097D9067
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 09:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A426AB20DA8
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 07:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6196CF9C4;
	Fri, 27 Oct 2023 07:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0zUDdv7j"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3B31118C
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 07:55:19 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D9A10A
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 00:55:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53f647c84d4so10192a12.0
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 00:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698393317; x=1698998117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGYHT9Nra4593u53fEOaMbHJCKjgvXJqCWRtxH3Qt10=;
        b=0zUDdv7jrt67HaqGUlt/7iPPzTyR4mN0BmfAu5yNbepY++rLMa5HM7LFaq8HONtfjW
         ljYtoxLPcbRKEBnDu4amjJZ3gjl2auY7MODTYDDMfoiPzeRpQCf7ZpiMC8p7i/6v7cC+
         mKx1Zvuo6ltYQxhLo2fJQKOinJPLHGR4zFSRngusg6mmHxboG0fMBicMNeWEQXBIJrd6
         mWGshkTCqzBOsf3nDiYdsephvjzIRy+1LEGQiXfW4RIU9Yy9V9Hl1B5dRhwHiSWWAAVd
         G8WKkd7XawIYlZ6Wbs7+azMVwhNxSMlWJgfaBW2Tmw26yH28r07ubzuwbUVq5VeIUJi8
         k24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393317; x=1698998117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGYHT9Nra4593u53fEOaMbHJCKjgvXJqCWRtxH3Qt10=;
        b=R/51RwVWyqlyJmqHA47Bn5uEi7wN0n+a6z6gNnKu4JUg7LTfsoY/6lrGiF62B0AalC
         YTxBWeYgBheJ0q35zUV25i+Qg0QIfT0yCsHFbau8482WgNe8pQmV1Pg+Sd22tqmpV8Ol
         4qKKO7ZU9+dgtnwoxw9shugSqT9rZd4RT4wL1cXY+IAkFlIYEaS+i+AFO3/5/LeGJ/FN
         wKfZY+dJ1yfDrdGVX/584zjVZ5nKIvnAfxpdJhXGeK3nAgTIqH3BJ74x7x5CTmRMuoxL
         tO1ycXZx3EX6NcA6tdYK1Aja2RgXukmFFv028gL3a9lpWbVdnsMSsZcTEY93rA1fD8Yj
         ecfg==
X-Gm-Message-State: AOJu0Yw/zEC//YjIL+1cXPs7C3W9xY85VoV+Jub1s45gWf6N3iokCtIm
	Vw9KZNCMZg8FNKp3Va+kfyQH+equPcznITShZVqPVA==
X-Google-Smtp-Source: AGHT+IGBdHxCYjAJDZJs4A0m/qb7bb49HsRy93RBIXtbcpAwXQk9vO6nwfImVtcYieozgRUsuY0jZn0w83b0oKlYxkg=
X-Received: by 2002:a05:6402:f15:b0:542:a2a7:75a1 with SMTP id
 i21-20020a0564020f1500b00542a2a775a1mr67870eda.0.1698393316637; Fri, 27 Oct
 2023 00:55:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026081959.3477034-1-lixiaoyan@google.com>
 <20231026081959.3477034-4-lixiaoyan@google.com> <20231026072003.65dc5774@kernel.org>
 <CADjXwjjSjw-GxtiBFT_o+mdQT5hSOTH9nDNvEQHV1z4cdqX07A@mail.gmail.com> <20231026182315.227fcd89@kernel.org>
In-Reply-To: <20231026182315.227fcd89@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 27 Oct 2023 09:55:03 +0200
Message-ID: <CANn89iJsY=ORcYiCAp-2AJKYbgWQS3ygOpYwzY+_vb6ojz3Gxw@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 3/6] net-smnp: reorganize SNMP fast path variables
To: Jakub Kicinski <kuba@kernel.org>
Cc: Coco Li <lixiaoyan@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Jonathan Corbet <corbet@lwn.net>, David Ahern <dsahern@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 3:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 26 Oct 2023 16:52:35 -0700 Coco Li wrote:
> > I have no objections to moving the enums outside, but that seems a bit
> > tangential to the purpose of this patch series.
>
> My thinking is - we assume we can reshuffle this enum, because nobody
> uses the enum values directly. If someone does, tho, we would be
> breaking binary compatibility.
>
> Moving it out of include/uapi/ would break the build for anyone trying
> to refer to the enum, That gives us quicker signal that we may have
> broken someone's code.

Note that we already in the past shuffled values without anyone objecting..=
.

We probably can move the enums out of uapi, I suggest we remove this
patch from the series
and do that in the next cycle, I think other reorgs are more important.

