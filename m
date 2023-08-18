Return-Path: <netdev+bounces-28840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D82780FC4
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96FD1C21660
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF8D198BB;
	Fri, 18 Aug 2023 16:03:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CB8182B5
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:03:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F0C3C00
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692374595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOwivL5hPjf3enggmdWvz+d+kv6iaMBuCWFieMfJPgw=;
	b=fNCV4zB27M5465QzKUPbDoeqT48gwiRdE/4CuRC0P80s+UlrlBfmI4UeICqjxbxuvXVHvn
	B/5UqBsofBemSALqXlrM7O31ZXfU41m/uG+bfyoXlS633REw5au93yEtvOAYMmF7Rz+KTW
	wGl93rpDdmePIf6GiNBysiVS8r7CvJM=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-rnDPwnTVMAeLYsx5vNiDyw-1; Fri, 18 Aug 2023 12:03:13 -0400
X-MC-Unique: rnDPwnTVMAeLYsx5vNiDyw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1c8dc033d0aso1189872fac.1
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692374593; x=1692979393;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOwivL5hPjf3enggmdWvz+d+kv6iaMBuCWFieMfJPgw=;
        b=PCkCAQpQ635SZ1imrQO5f4GaCXGUbarnLLGXk4ySuXptLdzy+9Yztdc1sanfzPMzJR
         7amFWFL3flWXvDgIiM1tLtpyt6FohGBew1IZ3yOMdnXLWGj2ASZwTM2JJSi2xxG8EFT1
         iaN6+SOAKDroo8+5amrpFDYO/OpjfwuL7A3aG8fE3h4/ld95KPxdnhtFErLTy3nQObnf
         3CrilNAILQDrtbrljfNvIb6f8NBXsUGWCejcoU91WOjq9ZMpHs5X2lOlsU+l813bUQiN
         hSU714Um19aAucc4YAqgOM81wjVqrf6ko3DuFbOvtAUYF99lJdL/azO7IMhQQfPptEHM
         Xnuw==
X-Gm-Message-State: AOJu0YxHrmXYGuUG5+rP9zU3lbG71U/oH/DfWu6u6C6GmU+CSp81kZBP
	OuKVfs8dUZUrkoOXh5ZFJxNu0ae5AJUqq48SUWkTwWGSTa/svweF4jmKVetIcvTctT/Ip92dR4V
	3M3WDvRG859g3POuZ
X-Received: by 2002:a05:6870:968b:b0:1c0:5f7a:896f with SMTP id o11-20020a056870968b00b001c05f7a896fmr3650073oaq.8.1692374593235;
        Fri, 18 Aug 2023 09:03:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMEr5/8Kjr9l1rfUv7FPHPRFH09lyQM8bg/cbrEPzM9NzoBWYQn+zHKcGFyT/Ylt4jvRYfIw==
X-Received: by 2002:a05:6870:968b:b0:1c0:5f7a:896f with SMTP id o11-20020a056870968b00b001c05f7a896fmr3650036oaq.8.1692374592796;
        Fri, 18 Aug 2023 09:03:12 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id z7-20020a9d65c7000000b006b95e17fcc7sm974660oth.49.2023.08.18.09.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 09:03:12 -0700 (PDT)
Date: Fri, 18 Aug 2023 10:03:10 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: <kvm@vger.kernel.org>, <netdev@vger.kernel.org>, <jgg@nvidia.com>,
 <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
 <shannon.nelson@amd.com>
Subject: Re: [PATCH vfio] pds_core: Fix function header descriptions
Message-ID: <20230818100310.71be85f8.alex.williamson@redhat.com>
In-Reply-To: <20230818091705.7e4d7d0e.alex.williamson@redhat.com>
References: <20230817224212.14266-1-brett.creeley@amd.com>
	<20230818091705.7e4d7d0e.alex.williamson@redhat.com>
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

On Fri, 18 Aug 2023 09:17:05 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 17 Aug 2023 15:42:12 -0700
> Brett Creeley <brett.creeley@amd.com> wrote:
> 
> > The pds-vfio-pci series made a small interface change to
> > pds_client_register() and pds_client_unregister(), but forgot to update
> > the function header descriptions. Fix that.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202308180411.OSqJPtMz-lkp@intel.com/
> > Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> > Signed-off-by: Brett Creeley <brett.creeley@amd.com>  
> 
> I think we also want:
> 
> Fixes: b021d05e106e ("pds_core: Require callers of register/unregister to pass PF drvdata")
> 
> I'll add that on commit.  Thanks,

Applied to vfio next branch for v6.6.  Thanks,

Alex

> > ---
> >  drivers/net/ethernet/amd/pds_core/auxbus.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
> > index 63d28c0a7e08..4ebc8ad87b41 100644
> > --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
> > +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
> > @@ -8,7 +8,7 @@
> >  
> >  /**
> >   * pds_client_register - Link the client to the firmware
> > - * @pf_pdev:	ptr to the PF driver struct
> > + * @pf:		ptr to the PF driver's private data struct
> >   * @devname:	name that includes service into, e.g. pds_core.vDPA
> >   *
> >   * Return: 0 on success, or
> > @@ -48,7 +48,7 @@ EXPORT_SYMBOL_GPL(pds_client_register);
> >  
> >  /**
> >   * pds_client_unregister - Unlink the client from the firmware
> > - * @pf_pdev:	ptr to the PF driver struct
> > + * @pf:		ptr to the PF driver's private data struct
> >   * @client_id:	id returned from pds_client_register()
> >   *
> >   * Return: 0 on success, or  
> 


