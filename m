Return-Path: <netdev+bounces-32348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B67946CE
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 01:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF4D1C20A93
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 23:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6C6125CD;
	Wed,  6 Sep 2023 23:07:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC2F11CB5
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 23:07:33 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659531BC5
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 16:07:31 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c35ee3b0d2so2639645ad.2
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 16:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694041651; x=1694646451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BB+Hxdtx5DADV02vPh1iR2xptyEn/ejXtG+GUfzw7I=;
        b=CtbJVQfAKbxouDKkZp+XrMw8D0yYXRBQOwaDpYdQqmDAz8rvbPiCuaCR2bwcQtwNWE
         oouktPrD0B7LR2Yfk0wyvjsqqQAVHqEGyMlpKA/EWtYaSnb+2qXZ4j8e1XZA5D4RG7Wx
         WaTC3pECBcg/gwETje1WMA/a0WjvRduYkw50aWk0cfrwsFbjZGjMrQvpSxHOXcZHz7l3
         BPFy2lObye78lQRhi9fIPKZCYd4riBjihShrXMhZXGxX2W4kMOgU5UksrWKDgbhydz7o
         cCtYrI/tCPRqWuDAzQQ2xe0YLaJLG/X5B+f2OVgCkxA38WRBEA3hZLCCcf3qFhn29reF
         3l6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694041651; x=1694646451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BB+Hxdtx5DADV02vPh1iR2xptyEn/ejXtG+GUfzw7I=;
        b=X7DP8jOsipdWzkucKEpuEj6m+lLLRXQp0EYfIeaCZsvc/MoyOMVdxm6b2OAt/1t9ek
         IzTfj1+VLKN2dvvCL1v1PXQocAJa6hzaesecw5/ZAuov/mx6URdCzNTz6P5LbT87PQvZ
         0Qkf4fhqMbpFn+yLQpirLkobbyijn3DQ7iNx0nrHiwzoc+vTPupiLqn03KGdPpDTz3jJ
         epOD8HxrxQur0CzAWRwqtZibcVxTlm5aJEOhvgrY4tPsEjqPIgViBHrYfwQqxEvGFt1B
         LezgRwzYnlmGD19WDTVbTApS+InnGFwnclYvI0Cpk+FhmfDB2Ihv0OmN/Nzl/wfecHqd
         Mj/g==
X-Gm-Message-State: AOJu0Yz7nacAKB3qgeK27Qf/mMo7Wtv3X/URIMOrHpWrF6InrPYlPFq4
	x0dYlXzwWEBAYCb4XwXgPqvylw==
X-Google-Smtp-Source: AGHT+IFKFy6QKaFs5Ky4izQr1Dm8yFJD4LHtH6e8e/V6LN0iG/HMkKD8N9tS5imvR+K5g8y1gQ68Pg==
X-Received: by 2002:a17:902:efd4:b0:1c0:db5a:8c78 with SMTP id ja20-20020a170902efd400b001c0db5a8c78mr13051140plb.68.1694041650900;
        Wed, 06 Sep 2023 16:07:30 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id x2-20020a170902ea8200b001bc2831e1a9sm11490868plb.90.2023.09.06.16.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 16:07:30 -0700 (PDT)
Date: Wed, 6 Sep 2023 16:07:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yuchung Cheng <ycheng@google.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, Soheil
 Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>
Subject: Re: [RFC net-next 4/4] tcp: defer regular ACK while processing
 socket backlog
Message-ID: <20230906160729.3cf829c0@hermes.local>
In-Reply-To: <CAK6E8=enK954aGeq0Rq8WDBJM8Rdp90_O=Rt_ax8bUHfStunOg@mail.gmail.com>
References: <20230906201046.463236-1-edumazet@google.com>
	<20230906201046.463236-5-edumazet@google.com>
	<CAK6E8=enK954aGeq0Rq8WDBJM8Rdp90_O=Rt_ax8bUHfStunOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 6 Sep 2023 13:31:17 -0700
Yuchung Cheng <ycheng@google.com> wrote:

> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>  
> Signed-off-by: Yuchung Cheng <ycheng@google.com>
> 
> Looks great. Any reason any workload may want to switch this feature
> off? I can't think of one...

Never underestimate the likelihood that some TCP stack or middlebox
is broken and needs more ACK's to work.

