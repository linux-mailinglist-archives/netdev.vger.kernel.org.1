Return-Path: <netdev+bounces-178369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265FCA76C47
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10EC16B2E7
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830EA213E77;
	Mon, 31 Mar 2025 16:53:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69B52E630;
	Mon, 31 Mar 2025 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743440003; cv=none; b=ZXDGEd3nvuPn9XRyb9YT7K1J2b9OU7oRCD+BgGOlddXzE7Z6B45O3UnTwnTxzNas/00D2r1po3c6qQPCsISFCqKaMqAeqSOE+KfymiWiNhZcqe0zJNaxhCDUsLqotlPlfJ4jwEwFSR+3HLEzDQaNlGvlFFAbJs+fgB/w2fMIYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743440003; c=relaxed/simple;
	bh=uirsi74QMRbhTLgK3RPciSRM0kf+D7K0c6QkNNYUlww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UptlIVMnfq1QXGYTMS5zuYwWbICMUlYtTAmK9TRslT/aoCsagIIApkjiCZ2Y9rvVWSApmx7g5Ol+OIZ5VnVwKOh+TEVxYsutzAI1jYcg1dejfm7/iYsWcl4R++Xp1zuS91nPNVpzT3OynkFZcXw3t5YVh4JMIdcDUFybh3RSOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac41514a734so773716666b.2;
        Mon, 31 Mar 2025 09:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743440000; x=1744044800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8kiN7eLFUJac7lbxd3vfgS9gP5HfsbkmZxnPYONZp0=;
        b=WkvmaKl9ulGX2Zb2x9kLn5HQg+Craaa+dUnarGaq/LvqaC087Wkykcc4R3b+n1xTP8
         2152CF7KwvWWx88VS0yq2Vy5BcGU0dYZ2PBfs4iPxpDwrS3biLbYWI9uYrzzHWpk7UEb
         pxOxTDQS2LwtzBrBJNxxYQ4iMR7v/ldI+2/xkygtX/X/U9nCV9o01cLIqEXn4SQIisAa
         be9jojHUzELDPMagAhxBM3exmXIVLmzrSaMdxDD/995jpC4FmdZghqyjyZ10S68miqss
         5GiVTxIVdtKYHNd/1UpH/ufd/V7ZJbEWrKSqeudg0cnuNmYaFeSsU9LewXPR0UzSU57W
         +zEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5GGbNNWDLFCgEfIUkA2vz6DKSX949Oia/FsebUbu8ll1o1+8RK8JhgJFWHIV0v8KmuHJ2uKdm@vger.kernel.org, AJvYcCXdBPHDooctdlXiGv7to7V4ObnTAB3ZDh9PrO5fO717C7bbCbq6t53TMYXzB/aBgvCT7qC32c4dY2GRyiw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo4r5YhGStiN7pMjWMvNoiXbKFRC6ACMnIyQZirG2/88S4izCj
	6tODHkacsJCdg5Zf5s6n7pqBn4Wk+4P3b6P527mGNPCiqjKtRxmd
X-Gm-Gg: ASbGncv/AmCEoBw1Q4VUo8brat51OOUFyzlmHitIeS3sfLMeCTnjvmvnil+pcrtCLxh
	zoJFVIppi25GMWB2RvVPJzn/380vnTsrFvk5pZW+w0AZkrtxjZA4PR7yEMwRMMUfcvVZh9Cneij
	tMyZEqCiU1raAoLU3ZW1k88a9O51609PQM05Loe2S2nSZoXuwFF8OTuF9+WZDePNebwXoZYF+41
	c68dKFBcAG25SwUK3thjHZrMhOtp/v7sNA0verA76V/2h3b+g1BcVoWe49NPeAtI5cVeFCf+afZ
	nkPPcYCDObVdkZSqq8GLCv7gOVvxfxeMU07LhjY5yeox/ys=
X-Google-Smtp-Source: AGHT+IE9922MjUJICjoSdt3gXr1RrTL9yHFwi15eZ1VjaW34j4d0GksH32LkpPOC7971G4TdagihHg==
X-Received: by 2002:a17:907:2d29:b0:ac2:a447:770b with SMTP id a640c23a62f3a-ac7389e6bfcmr859276166b.21.1743439999694;
        Mon, 31 Mar 2025 09:53:19 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac719223e1esm648292366b.7.2025.03.31.09.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 09:53:19 -0700 (PDT)
Date: Mon, 31 Mar 2025 09:53:16 -0700
From: Breno Leitao <leitao@debian.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, kuniyu@amazon.com,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch, Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH net] bnxt_en: bring back rtnl lock in bnxt_shutdown
Message-ID: <Z+rIfMYoinNfz820@gmail.com>
References: <20250328174216.3513079-1-sdf@fomichev.me>
 <Z+qAYXmGY08pQKKb@gmail.com>
 <Z-q08YfJMq8Q76ki@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-q08YfJMq8Q76ki@mini-arch>

On Mon, Mar 31, 2025 at 08:29:53AM -0700, Stanislav Fomichev wrote:
> On 03/31, Breno Leitao wrote:
> > Hello Stanislav,
> > 
> > On Fri, Mar 28, 2025 at 10:42:16AM -0700, Stanislav Fomichev wrote:
> > > Taehee reports missing rtnl from bnxt_shutdown path:
> > > 
> > > inetdev_event (./include/linux/inetdevice.h:256 net/ipv4/devinet.c:1585)
> > > notifier_call_chain (kernel/notifier.c:85)
> > > __dev_close_many (net/core/dev.c:1732 (discriminator 3))
> > > kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
> > > dev_close_many (net/core/dev.c:1786)
> > > netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
> > > bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
> > > pci_device_shutdown (drivers/pci/pci-driver.c:511)
> > > device_shutdown (drivers/base/core.c:4820)
> > > kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)
> > 
> > I've got this issue as well.
> > 
> > > 
> > > Bring back the rtnl lock.
> > > 
> > > Link: https://lore.kernel.org/netdev/CAMArcTV4P8PFsc6O2tSgzRno050DzafgqkLA2b7t=Fv_SY=brw@mail.gmail.com/
> > > Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
> > > Reported-by: Taehee Yoo <ap420073@gmail.com>
> > > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > 
> > Tested-by: Breno Leitao <leitao@debian.org>
> > 
> > > ---
> > >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > index 934ba9425857..1a70605fad38 100644
> > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > @@ -16698,6 +16698,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
> > >  	if (!dev)
> > >  		return;
> > >  
> > > +	rtnl_lock();
> > >  	netdev_lock(dev);
> > 
> > can't we leverage the `struct net_device->lock` for the shutdown.
> > Basically we have the lock the single device we are turning it down.
> > 
> > I am wondering if we really need the big RTNL lock. This is my
> > understanding of what is happening:
> > 
> > pci_device_shutdown() is called for a single device
> >  - netdev_lock(dev)
> >  - netif_close(dev);
> >     - dev_close_many(&single, true);
> >       - __dev_close_many()
> >         - ASSERT_RTNL();
> > 
> > Basically we ware only closing one device, and the net_device->lock
> > is already held. Shouldn't it be enough?
> 
> [..]
> 
> > Can we do something like this (from my naive point of view):
> > 
> > 	 static void __dev_close_many(struct list_head *head)
> > 	  {
> > 		  struct net_device *dev;
> > 
> > 	-         ASSERT_RTNL();
> > 		  might_sleep();
> > 
> > 		  list_for_each_entry(dev, head, close_list) {
> > 	+	  	ASSERT_RTNL_NET(dev);
> > 			...
> > 		  }
> 
> - netif_close adds dev->close_list to the list (if it was up)

Right, but that list has only one net_device entry, right?

netif_close() instanciates a single list and merges it into `dev->close_list`

> - __dev_close_many walks over that list, so your new assert should
>   trigger as well

Why? Isn't the list only contain the dev that is already protected by
netdev_lock()?

> But also in general, it would be nice to keep existing
> rtnl+instance_lock scheme for now (except were we want to explicitly opt
> out, as in queue apis); we can follow up later to un-rtnl the rest.

I am just wondering if the code as-is is already safe from a locking
perspecting, and just the warning (ASSERT_RTNL) is wrong.

