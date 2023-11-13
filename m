Return-Path: <netdev+bounces-47426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089787EA29B
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 19:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70B7280E6B
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 18:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEF822EFA;
	Mon, 13 Nov 2023 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNd/lcvM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB0E22EF6
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 18:13:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13A4D57
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 10:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699899187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2508DhcVI3DQppkCAgNcx74MRsV1bJXNoE/aR6TmlQ=;
	b=dNd/lcvMUJU23ofbKSFUygwrf8ClQJ8DJ+VGMDTpaDUsBvAAoiuOuzamQz1Hj5DMswjdWJ
	1FGZlspKUOg1Qj3CEhsdxFBDHASxAD+OqCZo5X0BeNjOV2FBlbXefEz2cI4MUWW431KB2Y
	26CqX+8BzTvsLJQl1zl2hFLR1NS0Kf8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-fm8uNm6kPaGWmMSJ-DLk7A-1; Mon, 13 Nov 2023 13:13:05 -0500
X-MC-Unique: fm8uNm6kPaGWmMSJ-DLk7A-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-67445c67d5dso54268576d6.2
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 10:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699899184; x=1700503984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2508DhcVI3DQppkCAgNcx74MRsV1bJXNoE/aR6TmlQ=;
        b=Krw2h82d+2F9AEV2LkpjGEIIDe2t7KNUdwToYsr0/4oHRKFTkb6Zgm1cFyd3fzEWwu
         iCf9rQULlBVBREAoEfpu4TY4VbLgQFkNd/og/3pw10Iv0QfqrEst4BaSHE2QE/qSUrRR
         UDIMKUCwJYkPr14MYxiP2rmRivys0/jkX+0mlQHGSQuLvpuhqTj7W6+fVajIxvFCEJYN
         ovRQCiJ1WjOPC+s8kBwyumH68IyWzDSzMozHwrt9GBic5oMH/sPTeiO0u+hib1i23GNs
         cNXbrfvglP64x4INZga9yJPLqztcu+2c6QRXWBr7yAQfAY9NB0sZOxj1E5WH2ampP9t7
         dBJw==
X-Gm-Message-State: AOJu0YxPTBN3Il2bLyJ0JlKZr6LyR/0DXgXQEvnBAP4+dQRcI+EJPh2Y
	IQ0zxcgWttGtRXGRiff4cF9v6ZsQtMP2GO9Amuu/vtCqaVvmCk/IpMy8TNTIGVtlpm/ed6hnV6t
	4pmXj+wGO8aolLr1bn1ROluPz
X-Received: by 2002:ad4:5847:0:b0:670:8d2d:e5c3 with SMTP id de7-20020ad45847000000b006708d2de5c3mr8791876qvb.31.1699899184372;
        Mon, 13 Nov 2023 10:13:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH21opV4dGrG8VloFbUF/HqNp9Y/JbIXq4fIFygJ3I7LKCRN/TYR9n+7vHPLNI27Vj886IEJA==
X-Received: by 2002:ad4:5847:0:b0:670:8d2d:e5c3 with SMTP id de7-20020ad45847000000b006708d2de5c3mr8791854qvb.31.1699899184142;
        Mon, 13 Nov 2023 10:13:04 -0800 (PST)
Received: from localhost ([37.160.129.96])
        by smtp.gmail.com with ESMTPSA id t1-20020a056214154100b0064f4ac061b0sm2245081qvw.12.2023.11.13.10.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 10:13:03 -0800 (PST)
Date: Mon, 13 Nov 2023 19:12:58 +0100
From: Andrea Claudi <aclaudi@redhat.com>
To: stephen@networkplumber.org
Cc: Luca Boccassi <luca.boccassi@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] Revert "Makefile: ensure CONF_USR_DIR honours
 the libdir config"
Message-ID: <ZVJnKjhLm-MiHn6e@renaissance-vector>
References: <20231106001410.183542-1-luca.boccassi@gmail.com>
 <169989362317.31764.14802237194303164325.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169989362317.31764.14802237194303164325.git-patchwork-notify@kernel.org>

On Mon, Nov 13, 2023 at 04:40:23PM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This patch was applied to iproute2/iproute2.git (main)
> by Stephen Hemminger <stephen@networkplumber.org>:
> 
> On Mon,  6 Nov 2023 00:14:10 +0000 you wrote:
> > From: Luca Boccassi <bluca@debian.org>
> > 
> > LIBDIR in Debian and derivatives is not /usr/lib/, it's
> > /usr/lib/<architecture triplet>/, which is different, and it's the
> > wrong location where to install architecture-independent default
> > configuration files, which should always go to /usr/lib/ instead.
> > Installing these files to the per-architecture directory is not
> > the right thing, hence revert the change.
> > 
> > [...]
> 
> Here is the summary with links:
>   - [iproute2] Revert "Makefile: ensure CONF_USR_DIR honours the libdir config"
>     https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=deb66acabe44
> 
> You are awesome, thank you!
> -- 
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
> 
>

Hi Stephen, actually Luca and I agreed on a different solution, see
"[PATCH iproute2] Makefile: use /usr/share/iproute2 for config files".

I can rebase that patch on top of this one, if this is ok for you.

Regards,
Andrea


