Return-Path: <netdev+bounces-178279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2258A76521
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 13:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF4FA188B14D
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 11:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CD11C5D7D;
	Mon, 31 Mar 2025 11:45:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CFD1BEF77;
	Mon, 31 Mar 2025 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421543; cv=none; b=WJryaOHO9Y8f+2iParmhcDAtkDJRh8tKSnOTy+CQdY71K1bamsjTdMe7/Hp78q1EDii1dSURxWlsyB+uy2BaLWQzzSO3Dj4b2UxEHTeddISP0v5UwTLEiQ3n5rEVKROIt85Vxux6vD+5IFA5R4yCjN/wmm1Bgx06Inc+NgIFLsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421543; c=relaxed/simple;
	bh=YjNj7isjZpaoY8aE2SSd4iBQGLVI1ommFerJ/LMFluU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QM4Rbp4CCESu1bgkXf8YMv0itzVJwpUGxf5+eelJD24v4cfYJhpGgWSZ36a/Em1g5V/UrmsFIrRDZmlh/lYPZDvzFHjFqLykNAR11/ADOi6p8p4a8Y1UOEG9UuxRFec54/4JXTg9CMzd+9aYUwjXL0OgPyuhWUlSoz2j2LGbwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abbb12bea54so885859766b.0;
        Mon, 31 Mar 2025 04:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743421540; x=1744026340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHaecyGu9k64BRqziBdIUjaEI9K4+K7PFPpeWvnnAAY=;
        b=iDbsSm4VsZz8KG59mWFnsApPVSYbryXaOVy1GeWGvScfHB9DaTEvyXBS74tcbHr6Gr
         1AuCIWSpSgM/neE9VQe8+YzQDQYeqMpBy01/iKPFP6De50Itjwium+t6QcD4z+JvDjro
         DY/UiBKzxr2yQgrWFkoVE7Rrn1BVqBx6SWLGO2nHbOxNpDngvYn8yI3vlv9q1FQgN427
         G8y6sk847Qsqgn/byYI2qevLxCyLQymB0pYnck8Bzc+Ppk7DAdkbmViXopGwGOg0U8+z
         wx12TmY1o54WL0xH60wWYYMvP9ih9vNERoCvKb3TuoH6XYdp/xXTp0/Xg/aTCsX2gLR9
         TITA==
X-Forwarded-Encrypted: i=1; AJvYcCU7maDtqbYXbM391mhySrBbp377A2iWHPs4jwXNGYYG/JxPVFvEW7Z9ltwG4AgWi+Z0Sh/o0jEWmKjoRi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzEX/vnfbKNwnYxPOGiL6lAu9rD14jc119F1MQwBlciy1/6Xk
	Am9R4dhC8qTvg2N7MH2JhPfMuIj54H47hFA7cVpFxVv4nqDfYMaq
X-Gm-Gg: ASbGncuEOJgwIShMGz75t9N1u4RWDPMMDx3iaympnIw/MqnhN5ZDzl6cWlB27559W5H
	9ALOTdeGLywOU5C0BSCLzNojc03MyKYrueEpr/o2wEB+QExWHlw6GTmUKYEWfQ2vil9EqcwIrUe
	7PbPSUC3dRZzq6PKyDZDHqkvXLIX6FBJvcN9+ivmGcjoDZaYd3Jjh3+x61vHXMfkygY2YiMDzBT
	etMZMZz5f02r2kU8BaeZhATv26GMLDqOoxDZv1i3aj4CYqgwKGrPompu4YtXV3nss0u0bO0G2KF
	QfHmHy7gd+xmXzOGFE4mkaCakIZIuVl0+BLc
X-Google-Smtp-Source: AGHT+IGBfH/XydCwbmLY8AYbkte/eSWnT9LoOEEI5ZVy6jIgtM7/Z/Y3vkPvuqLZQ9NNC9XMQl/grg==
X-Received: by 2002:a17:906:7313:b0:ac6:d7d2:3221 with SMTP id a640c23a62f3a-ac738ae929bmr714290066b.24.1743421539939;
        Mon, 31 Mar 2025 04:45:39 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71927b143sm617996766b.58.2025.03.31.04.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 04:45:39 -0700 (PDT)
Date: Mon, 31 Mar 2025 04:45:37 -0700
From: Breno Leitao <leitao@debian.org>
To: Stanislav Fomichev <sdf@fomichev.me>, kuniyu@amazon.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch, Taehee Yoo <ap420073@gmail.com>
Subject: Re: [PATCH net] bnxt_en: bring back rtnl lock in bnxt_shutdown
Message-ID: <Z+qAYXmGY08pQKKb@gmail.com>
References: <20250328174216.3513079-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328174216.3513079-1-sdf@fomichev.me>

Hello Stanislav,

On Fri, Mar 28, 2025 at 10:42:16AM -0700, Stanislav Fomichev wrote:
> Taehee reports missing rtnl from bnxt_shutdown path:
> 
> inetdev_event (./include/linux/inetdevice.h:256 net/ipv4/devinet.c:1585)
> notifier_call_chain (kernel/notifier.c:85)
> __dev_close_many (net/core/dev.c:1732 (discriminator 3))
> kernel/locking/mutex.c:713 kernel/locking/mutex.c:732)
> dev_close_many (net/core/dev.c:1786)
> netif_close (./include/linux/list.h:124 ./include/linux/list.h:215
> bnxt_shutdown (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16707) bnxt_en
> pci_device_shutdown (drivers/pci/pci-driver.c:511)
> device_shutdown (drivers/base/core.c:4820)
> kernel_restart (kernel/reboot.c:271 kernel/reboot.c:285)

I've got this issue as well.

> 
> Bring back the rtnl lock.
> 
> Link: https://lore.kernel.org/netdev/CAMArcTV4P8PFsc6O2tSgzRno050DzafgqkLA2b7t=Fv_SY=brw@mail.gmail.com/
> Fixes: 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
> Reported-by: Taehee Yoo <ap420073@gmail.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Tested-by: Breno Leitao <leitao@debian.org>

> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 934ba9425857..1a70605fad38 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -16698,6 +16698,7 @@ static void bnxt_shutdown(struct pci_dev *pdev)
>  	if (!dev)
>  		return;
>  
> +	rtnl_lock();
>  	netdev_lock(dev);

can't we leverage the `struct net_device->lock` for the shutdown.
Basically we have the lock the single device we are turning it down.

I am wondering if we really need the big RTNL lock. This is my
understanding of what is happening:

pci_device_shutdown() is called for a single device
 - netdev_lock(dev)
 - netif_close(dev);
    - dev_close_many(&single, true);
      - __dev_close_many()
        - ASSERT_RTNL();

Basically we ware only closing one device, and the net_device->lock
is already held. Shouldn't it be enough?

Can we do something like this (from my naive point of view):

	 static void __dev_close_many(struct list_head *head)
	  {
		  struct net_device *dev;

	-         ASSERT_RTNL();
		  might_sleep();

		  list_for_each_entry(dev, head, close_list) {
	+	  	ASSERT_RTNL_NET(dev);
			...
		  }

Thanks
--breno

