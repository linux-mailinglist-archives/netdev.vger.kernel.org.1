Return-Path: <netdev+bounces-42779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 745947D0196
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 20:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E34B282236
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 18:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DBA32C64;
	Thu, 19 Oct 2023 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkYHGvJz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4A338DF3
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 18:32:23 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0FFAB;
	Thu, 19 Oct 2023 11:32:21 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-66d17fd450aso9626326d6.1;
        Thu, 19 Oct 2023 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697740341; x=1698345141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ft90dWBJApXtAhUm1RnQBdoBvUODZdeb3PjPbGGFMdA=;
        b=bkYHGvJzR1w2LlYExksZm51GPo79n9Xaqv6nXr1PU57UiDO5SdBHEF+DpNo5tGDo62
         /a3cV5Pu1zzyBvOPOPN93INOZPn7MOwDAhNasgMV7tcmujqS5FoHTpvO3mwXw30Oy4fN
         dQm7WuGLXttz0fMhQWOf2YoyfZ742E0JHXCFt4MPNsFKDqxh+ce6Y5InVLB757M/rzrv
         I3zagniwTpjXYOBd3/Fkfs2S0xKYGpUwNkiE3zSCS3DzbXNyfEwuWhsA+by8EhB8Mz/q
         FCoPDVf370EHq9q3PwovU0e19yxcCa3HV7dmD9vZmmB7F9KvlC3t96ygbV/gK/GIH/ZG
         Zn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697740341; x=1698345141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft90dWBJApXtAhUm1RnQBdoBvUODZdeb3PjPbGGFMdA=;
        b=EvgMH3ZRth/uoma0gEG4BqImbYemuJI8DR4hKe8AeswUiVkRBhMbRKxbkXhHF4recr
         7Try61/1E7/7gOeSgGSedHlhOd9gVqeUaqiCzaco3GP10udLhqI/y0+QAdDqFmAochE0
         MRrU9aPAOCXk0Ys17VyROpsLoKvxrgGt1+B/yMrWLR5gjf8yQvkaii8JUVB5URwu6QvK
         Xack9PYZZXr8H361DCRWj5ADwLuvD0PlH+QPQRQaflk6AAjweRl+0hK0uiBmqaBzVTqO
         jkH2lpYfVnp8o5/Rwc04d4gh/jY/q71g7vAKx21Ht3i6cd3a3qdfmrtIyAqsB+DDARmw
         mjSA==
X-Gm-Message-State: AOJu0YwTnSQ19VaTAEHAmCGpDmkldTFbF2c6sw8zET8c4tyd/gfdUhQE
	MlkToM2YhtXvwWpKuN4nrFTo6rEOV1KBLQ==
X-Google-Smtp-Source: AGHT+IFH+dVil1kyt0ldQCREh4X2dQJyQQcMik3vx+6aczWqZln1swi2uCDzNG0jVxSPxltwj1oVOA==
X-Received: by 2002:a05:6214:b68:b0:66d:5a3a:c5e6 with SMTP id ey8-20020a0562140b6800b0066d5a3ac5e6mr4934754qvb.18.1697740340752;
        Thu, 19 Oct 2023 11:32:20 -0700 (PDT)
Received: from localhost (modemcable065.128-200-24.mc.videotron.ca. [24.200.128.65])
        by smtp.gmail.com with ESMTPSA id dr9-20020a05621408e900b0066d1e20455bsm52069qvb.96.2023.10.19.11.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 11:32:20 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:32:19 -0400
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Coiby Xu <coiby.xu@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	George Cherian <george.cherian@marvell.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Eran Ben Elisha <eranbe@nvidia.com>, Aya Levin <ayal@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH net-next v2 10/11] staging: qlge: devlink health: use
 retained error fmsg API
Message-ID: <ZTF2M7VeNtisGBm7@d3>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
 <20231017105341.415466-11-przemyslaw.kitszel@intel.com>
 <20231017181543.70a75b82@kernel.org>
 <ZTE884nkvAxKy2G3@d3>
 <20231019074237.7ef255d7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019074237.7ef255d7@kernel.org>

On 2023-10-19 07:42 -0700, Jakub Kicinski wrote:
> On Thu, 19 Oct 2023 10:28:03 -0400 Benjamin Poirier wrote:
> > > Humpf. Unrelated to the set, when did qlge grow devlink support?!
> > > 
> > > Coiby, do you still use this HW?
> > > 
> > > It looks like the driver was moved to staging on account of being
> > > old and unused, and expecting that we'll delete it. Clearly that's
> > > not the case if people are adding devlink support, so should we
> > > move it back?  
> > 
> > AFAIK this was done by Coiby as an exercise in kernel programming.
> > Improving the debugging dump facilities was one of the tasks in the TODO
> > file.
> > 
> > I moved the driver to staging because it had many problems and it had
> > been abandoned by the vendor. There might be some qlge users left but is
> > that reason enough to move the driver back to drivers/net/
> > if there is no one who is interested in doing more than checkpatch
> > fixes on the driver?
> 
> Staging is usually an area for code entering the kernel, not leaving.
> We should either suffer with it under drivers/net/ or delete it,
> as you say, nobody is working on significant improvements so having 
> the driver in staging is serving no purpose.
> 
> How about we delete it completely, and if someone complains bring 
> it back under drivers/net ?

That sounds like a reasonable way forward, thank you. I'll send a patch
to do the removal.

