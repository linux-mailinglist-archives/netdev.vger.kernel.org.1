Return-Path: <netdev+bounces-28916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 303AC78128A
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41C52824CB
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863431AA94;
	Fri, 18 Aug 2023 18:04:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612B71AA8F
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:04:07 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31402D70
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:04:05 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76d8f2be749so46211385a.3
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692381845; x=1692986645;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYGpS759och7VUpsgdllApLARwC1DkpvFdNrbZRq9rQ=;
        b=BuKbbpaLiVk5dd51KTf/URupXS+kyUP8Mu+FIPqCEa0Hyhj8lCpU4yeWrrM9etws4/
         V+CUHV9tqkfpoYPUEMdOC20X4TkP1A/5/R63sHzpVx1f3a+htta92JdszJEaTSxQDIU/
         nk3gHVsO/R5nFPOtZQqRKHSM/ZR7UxP9OuZ9CsYuZLv0Uw6wXETytJ2509XT17aLj0Lm
         vf06lBqf9vOCHIXTyZM1WHFS/iTUrZ+Oau6fnKzECC9n/DGviauZJWFj3lDvjXvsJXN/
         fL51Uctsk4tSnx7Q8IX2ByHqHsADYGgVvVWBj4uMnqFSUR5Cwu5gj5TVWkA7xjkEt8bI
         OEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692381845; x=1692986645;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rYGpS759och7VUpsgdllApLARwC1DkpvFdNrbZRq9rQ=;
        b=af6O3S98kItbacjSgPgLr1RxD+CJcP/Ib/yOcBRZ890AA4OOPQ0u44F+HbRnOoASLB
         vyzhRy56ck2Ta2y7D35qv0VxPFtfnFtKLZpKKJjhjVH+HdR2sXaJOnmLCEBr18UvJnBB
         rn0N5gWQxgp3Krt9Nnpf8atj9ZSx0DWpfjrpWMG5zaNuj206Lc54A6rpfICAtNsBAIq+
         nrIYm1qy41T8ciUN+YKZ7dBD+5EArRn4WO7vM1khif630se/TbopI/DEn+LxV9AvNSPU
         LbH5nqUQXzqevB9s7s8wHCQe8yf2giexpVELRUcALgxZSKXUd1oDAr3R49Hc4aMzxYMq
         qvYQ==
X-Gm-Message-State: AOJu0Yz5tqU3E21OfjO03mS/aI38icMv5ilm3cX5LZiH9GOZ/kycC5XH
	7ML2eiUFIbmIHkMdwz0YB7A=
X-Google-Smtp-Source: AGHT+IE6H7PXPPzIEJitgRGAtd8nP6v6N4ciQSc6cZ+kJEOsoZh5CQHg7vzve3/dy9wHfZy89fBq9w==
X-Received: by 2002:a05:620a:bd6:b0:76d:2725:f36f with SMTP id s22-20020a05620a0bd600b0076d2725f36fmr4188823qki.71.1692381844725;
        Fri, 18 Aug 2023 11:04:04 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id c4-20020ae9e204000000b00768283dcb63sm674047qkc.123.2023.08.18.11.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:04:04 -0700 (PDT)
Date: Fri, 18 Aug 2023 14:04:03 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Soheil Hassas Yeganeh <soheil@google.com>
Message-ID: <64dfb293d1052_2d6e1129458@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230818174145.199194-1-edumazet@google.com>
References: <20230818174145.199194-1-edumazet@google.com>
Subject: Re: [PATCH net-next] net: selectively purge error queue in IP_RECVERR
 / IPV6_RECVERR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eric Dumazet wrote:
> Setting IP_RECVERR and IPV6_RECVERR options to zero currently
> purges the socket error queue, which was probably not expected
> for zerocopy and tx_timestamp users.
> 
> I discovered this issue while preparing commit 6b5f43ea0815
> ("inet: move inet->recverr to inet->inet_flags"), I presume this
> change does not need to be backported to stable kernels.
> 
> Add skb_errqueue_purge() helper to purge error messages only.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Soheil Hassas Yeganeh <soheil@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

