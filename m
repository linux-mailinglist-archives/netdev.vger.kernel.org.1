Return-Path: <netdev+bounces-33842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DCA7A0728
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563911F23908
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6FB22EEF;
	Thu, 14 Sep 2023 14:21:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E53241E7
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 14:21:19 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965E8D7
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:21:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6903a6f3cafso78125b3a.1
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694701278; x=1695306078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CAqXSQEHQTWNLnwvVnA0ROASg81b9+Ci5h2qImCcLMQ=;
        b=mQKAqx/WOvSFO8C2Sp15suxntFN/lHt2PIrsHnY0uIq5Puu6TWtHO0jcslqf9Jbf+A
         C4zUYBvhD3nZ17HF7eu/AgwmukaKtpqVk6U/5MhA6BaPHZpr/nHR1f49cX26F8SFuUX2
         xh66H+PRQtalKW0JrigTZ+xW2wn4ixhoYZt2DUTtqckEnddQrojmfYRSI+1v6+emTSPH
         L5NV8W12kVxe+3ZpLZMROiLdfcBHFGevNVUMIN4zCMDA+EEiq8a6nuBaEfVo3hiK3ctG
         383aXNSewpOLr+0mMuqa1pWKrxgOuEoAaeZefi3GoLcyq7RRr5rRILXPLJ4QsfKOn2u0
         ie7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694701278; x=1695306078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CAqXSQEHQTWNLnwvVnA0ROASg81b9+Ci5h2qImCcLMQ=;
        b=ZN6qZ7VU5JG3txmZ8JoWIi2fGj95/9p9h5Ou82BDwesxMd+PNrsBLvTPaP3TBPfztM
         vBBl9wxb/gLYoEdmboAYT4au5QtqilAbXTVNIIT7cCbM2bgkWiCskRuWSRt2+Mzuenns
         1JTrz+l6apY851y0/OgiEmM69EUnDqya+GyPW3ZSLXmSCecCg5QogB/QqxHXGfdHAv7x
         iYKHadbWWqffiprxPMeZkgzjb5McbSfERDmTPBiiiuCXYtne7taeXhwNcsYO+R4f4IFH
         bo3aY/sN529O5Ud3wi/MlmPztugUHCGqH9GRq76Ki2DKDHkREhPl+aYz87UvCf5fCqqy
         SI+Q==
X-Gm-Message-State: AOJu0YzpQVPCxRulj/+8h2SeCcNfA49TxNAq54/q9phQrW5pV9O76EZU
	TxH/D3WorA9rji0o/pQhM1A=
X-Google-Smtp-Source: AGHT+IFPUN2NFsrz6CPhVxNxo5jJXdIf7YMNg/kOpABtKwhm9AErXLyNaTWS3Skv/zEjPjqbaBDcIA==
X-Received: by 2002:a05:6a20:7f84:b0:13e:7439:1449 with SMTP id d4-20020a056a207f8400b0013e74391449mr5300674pzj.0.1694701277981;
        Thu, 14 Sep 2023 07:21:17 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id t12-20020aa7938c000000b0068e12e6954csm1401985pfe.36.2023.09.14.07.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 07:21:17 -0700 (PDT)
Date: Thu, 14 Sep 2023 07:21:15 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Xabier Marquiegui <reibax@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org, mlichvar@redhat.com,
	ntp-lists@mattcorallo.com, shuah@kernel.org, davem@davemloft.net,
	rrameshbabu@nvidia.com, alex.maftei@amd.com
Subject: Re: [PATCH net-next v2 1/3] ptp: Replace timestamp event queue with
 linked list
Message-ID: <ZQMW222Lu0BwkhGr@hoboy.vegasvil.org>
References: <20230912220217.2008895-1-reibax@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912220217.2008895-1-reibax@gmail.com>

On Wed, Sep 13, 2023 at 12:02:15AM +0200, Xabier Marquiegui wrote:
> This is the first of a set of patches to introduce linked lists to the
> timestamp event queue. The final goal is to be able to have multiple
> readers for the timestamp queue.
> 
> On this one we maintain the original feature set, and we just introduce
> the linked lists to the data structure.
> 
> Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
> Suggested-by: Richard Cochran <richardcochran@gmail.com>
> ---
> v2:
>   - Style changes to comform to checkpatch strict suggestions
> v1: https://lore.kernel.org/netdev/20230906104754.1324412-2-reibax@gmail.com/

Overall this is much improved.  Still as Vinicius pointed out, there
are a couple of issues to be addressed:

- open file tracking
- list handling

Thanks,
Richard

