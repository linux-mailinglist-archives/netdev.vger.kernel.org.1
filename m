Return-Path: <netdev+bounces-29371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BC9782F51
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A5F280E31
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3608C09;
	Mon, 21 Aug 2023 17:22:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1401D8C05
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:22:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361ACFD
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692638562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivazL8JAv7ckKoyhSXqt/af/Hi5kAJceHFL5yG3w5+0=;
	b=VVd50zXtaqgVKDQ4h06fykkYvawLZWkJRKRCS+N+hOa0BrlFBKtj3Udh3T1EmfW4kepy7V
	c8AFrsUdoh+QpQAEXIZak0ohbdVO4C+zTCQt7HDwDqVla0avHCjzeQv3Xl+/HW530JCMzj
	2B8f99iQnVREgUVpyssnP6yKQNgAYik=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-8KJaJtLjPBKGph7t1lPSWw-1; Mon, 21 Aug 2023 13:22:41 -0400
X-MC-Unique: 8KJaJtLjPBKGph7t1lPSWw-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-77e41268d40so380399939f.3
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 10:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692638560; x=1693243360;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivazL8JAv7ckKoyhSXqt/af/Hi5kAJceHFL5yG3w5+0=;
        b=OztmaaVyBXX88j/xLIKwMqrhpmULO+Xw5ToOMaBq9iPxRiGjEGD190vVrG/h24Yc3u
         s7fNTg9vr56R/9PU5TE/dl2na6KfH2oKX0uCC5iBcFXPjiU8jB1GuEdpAFzvMiZlXgkD
         aLnQRI4hVTPRMI+mgXzV3UsYY6B3rjed0XoNmApAU3nGKm+RhupbzMcsSsPq1UcCXDC6
         hiyiv9FPOucRqO87iDfK02OMkl0cj6FoXnvCrcnJjQbMRETO+gqye8wsH73Qb5uXqz0u
         hy+/T70mfPgIfeus6yDyVJJ5+DDDUC7MxI8Cea2z2A/VLKHZoSIUztK8LwuWFTkA+QPc
         UUQQ==
X-Gm-Message-State: AOJu0YxaPjUR0csnXdluEBU5D14i1a2WBR5xlxmRG4QMm5pGshVHMwiO
	GdVxMHc0dCT2vlSMHyecXX20VHUaC9U9RwTKIAZ3jZPCHDXgqNh7K8FL1ZsaOnRersra8h6gRiS
	hXaqb72evF6USpkL7
X-Received: by 2002:a6b:6d01:0:b0:786:2125:a034 with SMTP id a1-20020a6b6d01000000b007862125a034mr9049999iod.18.1692638560258;
        Mon, 21 Aug 2023 10:22:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+lop5wsmnU+SlGPBBWWtiFkHhFzhxLlxUJv2EeKUr0epxXAEysTNC2s8HvQtn+j8YxpixZQ==
X-Received: by 2002:a6b:6d01:0:b0:786:2125:a034 with SMTP id a1-20020a6b6d01000000b007862125a034mr9049979iod.18.1692638559974;
        Mon, 21 Aug 2023 10:22:39 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id l21-20020a02ccf5000000b004317dfe68e7sm2498718jaq.153.2023.08.21.10.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 10:22:39 -0700 (PDT)
Date: Mon, 21 Aug 2023 11:22:37 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Brett Creeley <bcreeley@amd.com>
Cc: patchwork-bot+netdevbpf@kernel.org, Yang Li
 <yang.lee@linux.alibaba.com>, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, shannon.nelson@amd.com,
 brett.creeley@amd.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] pds_core: Fix some kernel-doc comments
Message-ID: <20230821112237.105872b5.alex.williamson@redhat.com>
In-Reply-To: <ed1bd63a-a992-5aef-f4da-eb7d2bc64652@amd.com>
References: <20230821015537.116268-1-yang.lee@linux.alibaba.com>
	<169260062287.23906.5426313863970879559.git-patchwork-notify@kernel.org>
	<ed1bd63a-a992-5aef-f4da-eb7d2bc64652@amd.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 21 Aug 2023 10:05:21 -0700
Brett Creeley <bcreeley@amd.com> wrote:

> On 8/20/2023 11:50 PM, patchwork-bot+netdevbpf@kernel.org wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > Hello:
> > 
> > This patch was applied to netdev/net-next.git (main)
> > by David S. Miller <davem@davemloft.net>:
> > 
> > On Mon, 21 Aug 2023 09:55:37 +0800 you wrote:  
> >> Fix some kernel-doc comments to silence the warnings:
> >>
> >> drivers/net/ethernet/amd/pds_core/auxbus.c:18: warning: Function parameter or member 'pf' not described in 'pds_client_register'
> >> drivers/net/ethernet/amd/pds_core/auxbus.c:18: warning: Excess function parameter 'pf_pdev' description in 'pds_client_register'
> >> drivers/net/ethernet/amd/pds_core/auxbus.c:58: warning: Function parameter or member 'pf' not described in 'pds_client_unregister'
> >> drivers/net/ethernet/amd/pds_core/auxbus.c:58: warning: Excess function parameter 'pf_pdev' description in 'pds_client_unregister'
> >>
> >> [...]  
> > 
> > Here is the summary with links:
> >    - [net-next] pds_core: Fix some kernel-doc comments
> >      https://git.kernel.org/netdev/net-next/c/cb39c35783f2
> > 
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> > 
> >   
> 
> FYI - there might be some conflicts here as this was already fixed on 
> Alex Williamson's vfio next branch. I don't fully understand how all 
> things get merged into v6.6, so I just wanted to update here.
> 
> On vfio's next branch this was fixed by: 06d220f13b1f ("pds_core: Fix 
> function header descriptions"). It also has a pre-requisite patch that 
> actually introduced the warning: b021d05e106e ("pds_core: Require 
> callers of register/unregister to pass PF drvdata").

Right, the issue was introduced by:

https://lore.kernel.org/all/20230807205755.29579-4-brett.creeley@amd.com/

which exists in the vfio next branch as:

b021d05e106e ("pds_core: Require callers of register/unregister to pass PF drvdata")

The problem doesn't actually exist in the stand alone net-next branch,
so I felt confident in taking Brett's fix from here:

https://lore.kernel.org/all/20230817224212.14266-1-brett.creeley@amd.com/

which is currently in the vfio next branch:

06d220f13b1f ("pds_core: Fix function header descriptions")

Additionally this includes proper attributes and fixes tags.

I'm sure Linus can fixup the conflict, but a preferable solution might
be to drop the patch from Yang Li from net-next.  Thanks,

Alex


