Return-Path: <netdev+bounces-25694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0639D775318
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E8E1C210EA
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 06:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A328F812;
	Wed,  9 Aug 2023 06:46:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B737F3
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 06:46:11 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07E81FC3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:46:10 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bbf8cb694aso54725915ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 23:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691563570; x=1692168370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xL6vGo5bXMDxRG+LHqV49NTd3nhDX1oc22/bW2Ke5h0=;
        b=eCzwSkXQODz8V5TGJcB5D1jXI7mmcRLACDGsVuAP2sbzymVKJfrV8GN7Bxyfralmh8
         7eJnKw9QVjmW5ZpOAI2cwX5nOzNtx/9mNDJ/kcRCqLAzUBV750h+CEnEGuLHwKPML3IS
         QPPi5WyuDb7V/sU+Zz3Yu17ZuR/8HC4osQWIolOtnRWAFKIGTeVegAOKFmtfduauHMX4
         CrGnTtucmt6hcsvYzCHeCMbmMkQN+o8jq28S+hqxDjKLPJ6VnXZ2l3EvedhWaIlwH+7V
         ucI0VsRc6Q3CouQv7x/4/5f9k2dGNChruLaHlkFHpa8q8cheyNGQK6VQ1XPYxdNktjlM
         d+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563570; x=1692168370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xL6vGo5bXMDxRG+LHqV49NTd3nhDX1oc22/bW2Ke5h0=;
        b=MpDCbrNNoo8zgQpS/x/B9h6lL1mfbVPVELvBPACy+ENJAdL3Kw2ekapKgZKVlo5wVM
         Zy3TqCqNjGOaMBjJz0Ym83wNRvwl+njo1ERRL/Zaj4kO7b7pHH5xO8OjYItZn9sprosG
         81JsCBREkHQjRg6GrIGVDf/u+OJIQm0LMhzVxK+0dsZj/x9B9hiqxbj5wDeZdM3C/GFg
         SH29Fxtlu5xMQOGT/MwiFPhIGONHrsKL7n1wgksnWWyJcNwo+VmtQizMTDxGQZD6BFgq
         xFnWRqE5ipPOXZ0o7MtNe6xS7bdrqSyeh/t8x1JLyhhZuJ3PagtUD31wWXCItCkrb37l
         FrwQ==
X-Gm-Message-State: AOJu0YzqEhsetnBIFFRiEyUHTtDvaHune3J6DeLOk8o776KjSGUhBtgx
	1ecIOtSpR6TWbJc/sYxFT5debggHKuxEFw==
X-Google-Smtp-Source: AGHT+IETlVNLN0pjI6TRKlYarO0H4T7LASvBN785c3pQ4G4BthMSAY4jm0L4H42ka1S8QZ4bWq6ivA==
X-Received: by 2002:a17:902:e993:b0:1bc:667b:63c6 with SMTP id f19-20020a170902e99300b001bc667b63c6mr1869932plb.41.1691563570183;
        Tue, 08 Aug 2023 23:46:10 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001b801044466sm10213852plg.114.2023.08.08.23.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 23:46:09 -0700 (PDT)
Date: Wed, 9 Aug 2023 14:46:06 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net v2 06/17] selftests: forwarding: Add a helper to skip
 test when using veth pairs
Message-ID: <ZNM2LoLpnUaJiYkx@Laptop-X1>
References: <20230808141503.4060661-1-idosch@nvidia.com>
 <20230808141503.4060661-7-idosch@nvidia.com>
 <ZNLyDT5X2GYQfqQR@Laptop-X1>
 <ZNMogU0whoFeerho@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNMogU0whoFeerho@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 08:47:45AM +0300, Ido Schimmel wrote:
> On Wed, Aug 09, 2023 at 09:55:25AM +0800, Hangbin Liu wrote:
> > On Tue, Aug 08, 2023 at 05:14:52PM +0300, Ido Schimmel wrote:
> > > A handful of tests require physical loopbacks to be used instead of veth
> > > pairs. Add a helper that these tests will invoke in order to be skipped
> > > when executed with veth pairs.
> > 
> > Hi Ido,
> > 
> > How to create physical loopbacks?
> 
> It's the same concept as veth. Take two physical ports and connect them
> with a cable.

With a cable.. Thanks, haha!

Hangbin

