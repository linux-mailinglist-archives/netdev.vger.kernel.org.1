Return-Path: <netdev+bounces-22461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ECFA7678F1
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 01:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9211C20CBC
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 23:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408971FB58;
	Fri, 28 Jul 2023 23:24:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358D7525C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 23:24:29 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B73C3C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 16:23:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bb84194bf3so16909885ad.3
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 16:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1690586633; x=1691191433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8TOqjVVRqRNx26u0PcBdXWcGtfkvi/7FvB90PE7z2w=;
        b=umSdSj7AAOnGzEBW6d+lpZInO5E/1oQ03UFHTBjVHv0+5Vvbd3PgwLMyI2pyRADg7p
         oz1rZH4cO541BgKmu5eziwhY81dEUFEhAk8os2eiuZsyRL/QV6a1S2OnKL0Oj8xaGWXu
         UZ6Gisr+9wFcL4mZ4eFSlcbvobzgvej8fGNlKUNWxehrJuD48k6k+KYewWraSCX7XjLv
         LJU0dez2PiYqRckVJM013lrlmGUc4Xqoo2G1l+tNRM8wgEKx3OINB9uOBLIjeGS/2YKR
         R7JZbi7vtjb+jdDJSZp4XjYNNZCD0Y72DDgsY5h6cIKboJmyFiOrEmREt4FwWKyAmC0r
         /ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690586633; x=1691191433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8TOqjVVRqRNx26u0PcBdXWcGtfkvi/7FvB90PE7z2w=;
        b=A/c2B+rjQLJFrQ5kYbqSzhUw0FiNTXe6KuuUaaPO7xpszGMVCuUDxu0BVq6Wbp21G8
         VNr7PQVSYIlYyl7e5TGsPNmekOokdl71iMe44NvrP9upu4taa+nYmJo+V1OpkIRbXlzP
         Iu19HsncMF9zpa6ptX6z+/ubDt3Ifmo4aI6fLM4f3beZK2BABup0i3GMQjekLLLnYuob
         hFE3cSKhY1YAChKGAxHpm9FJ7cD3URIKQRU3W7LlTSnpnMH8cW9IoLeFx9GCUeHozj7s
         iO6lNT40jpeaehDCR9bdpKaA+44IS88vzn+t9ndVAyH8XtYdaR0VZKYTunFBbS+6kg3H
         wKVg==
X-Gm-Message-State: ABy/qLZL7i5c3f0Xb77FodaN8WiyRoCFlqBts7eGgqI8o8voq9CxpHuI
	heSbHhk94e7AYqJhdDwVkvDmOg==
X-Google-Smtp-Source: APBJJlFqF/CjQmYlDmPG3Bjbkdy3LzJeBCpwmQs7NKuCrur0ed7ZdzTZBl2bJ5zRa7+XscVV8yWppg==
X-Received: by 2002:a17:902:b714:b0:1bb:6eeb:7a08 with SMTP id d20-20020a170902b71400b001bb6eeb7a08mr2707041pls.10.1690586632868;
        Fri, 28 Jul 2023 16:23:52 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b001b83e624eecsm4125267plj.81.2023.07.28.16.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 16:23:52 -0700 (PDT)
Date: Fri, 28 Jul 2023 16:23:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 sd@queasysnail.net
Subject: Re: [PATCH net-next v2 1/2] net: store netdevs in an xarray
Message-ID: <20230728162350.2a6d4979@hermes.local>
In-Reply-To: <20230728082745.5869bc97@kernel.org>
References: <20230726185530.2247698-1-kuba@kernel.org>
	<20230726185530.2247698-2-kuba@kernel.org>
	<20230727130824.GA2652767@unreal>
	<20230727084519.7ec951dd@kernel.org>
	<20230728045304.GC2652767@unreal>
	<20230728082745.5869bc97@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 28 Jul 2023 08:27:45 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 28 Jul 2023 07:53:04 +0300 Leon Romanovsky wrote:
> > > I'm feeding xa_alloc_cyclic() xa_limit_31b, which should take care 
> > > of that, no?    
> > 
> > And what about xa_insert() call? Is it safe?  
> 
> I think so, as in - the previous code doesn't have any checks either,
> so it'd insert the negative ifindex into the hash table. Hopefully
> nobody assigns negative values to dev->ifindex, that'd be a bug in
> itself, I reckon.
> 

Even inserting with ifindex = 0 would be a bug

