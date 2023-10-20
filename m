Return-Path: <netdev+bounces-43110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E417D1709
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 22:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48482826B3
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 20:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EEA208BC;
	Fri, 20 Oct 2023 20:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIiHakhO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B76249F7
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 20:32:50 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74B0D67
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:32:48 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7789cb322deso77688885a.3
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697833968; x=1698438768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ze+9vEbBaAmApFoGNAt0D5iyQ2EJCaEFko34Jgj/wwk=;
        b=BIiHakhOP4UEd+1x1Q6Y6bqqHsDsVNCQjk6Ly1xHJV0a3ahfWO/a/RrYbMSDD3oodb
         OiNwySu9NXlU30wkgg50vxzXXKdpAitkeIUJ9dCBK5vwTjH4iK1uYMoogMASX+yK7MSE
         PhFFloyCdSecoxZjNqiZfZ+hzkkYkAUbGNUMH6nn6ltwnqAQl8qlF5oE2GZkY4Zau2Ac
         MKFNReZQBg+GcR0nnILe+2xKmrYBigvD5tui040op+t3YdQHMawd4msPtKjrVdsVMZwo
         Avi+tDKS29sPWWlzIy6Z9VlIERFDLi8bRrthjVy0RkbWRq5Q1Z5WvuuFYHtj6jtBAZf9
         diMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697833968; x=1698438768;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ze+9vEbBaAmApFoGNAt0D5iyQ2EJCaEFko34Jgj/wwk=;
        b=ty0+c2w+BHWri0p9n0pB/Di9np/g6P40Oqv8RW+vG/mQq+Ci8JTjOVJwZztzOKqpo3
         CWZgc/km/qBtG2iRdEyZSS/avOsGyA5LDSUiz+UUWMhOckp/EipVZc9/+TFxgvfxJviX
         Vf5m6RfL2RZkrGcNIhG4hjbQ2gP/HJB+Nm9qy6xSzwJR75UnqpNOVp8EquF5P2ltUmcI
         tGc5rb/wO5Ahe/GHd13Z576dibtUVuXoSExlqV4UBHecUkQXvjw2kVm9HzfqCcFZaHEC
         f2+KX4LXx7E6VIz8k8xrm2MXKt0nWBuULo4eaOfR9kTHYWuS3WcjpLHfx1sCl7dymvjo
         aLAQ==
X-Gm-Message-State: AOJu0YxfuKdI3mbpCapiN5YdNAjh6W05/GF0D7ncXveCiKUKfN+t9PQy
	2+TwvhfnYi1XQvLYsL/GYnY=
X-Google-Smtp-Source: AGHT+IHXsB3+aWtXQRKGzhsz/XZz/ZyahkADRSJEOUas1FGjUcY+DpA80MroXI6+2R9uphblaGluvw==
X-Received: by 2002:a05:620a:2a0b:b0:778:b12b:2dff with SMTP id o11-20020a05620a2a0b00b00778b12b2dffmr1599207qkp.50.1697833967994;
        Fri, 20 Oct 2023 13:32:47 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a141500b0076f12fcb0easm879715qkj.2.2023.10.20.13.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 13:32:47 -0700 (PDT)
Date: Fri, 20 Oct 2023 16:32:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <6532e3ef661da_2945ca294fe@willemb.c.googlers.com.notmuch>
In-Reply-To: <20231020201254.732527-1-edumazet@google.com>
References: <20231020201254.732527-1-edumazet@google.com>
Subject: Re: [PATCH net-next] net_sched: sch_fq: fastpath needs to take care
 of sk->sk_pacing_status
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Eric Dumazet wrote:
> If packets of a TCP flows take the fast path, we need to make sure
> sk->sk_pacing_status is set to SK_PACING_FQ otherwise TCP might
> fallback to internal pacing, which is not optimal.
> 
> Fixes: 076433bd78d7 ("net_sched: sch_fq: add fast path for mostly idle qdisc")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

