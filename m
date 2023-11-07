Return-Path: <netdev+bounces-46449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D847E4228
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 15:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ABA6B20C0F
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776E630FBF;
	Tue,  7 Nov 2023 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHdUPKLA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B930D04
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 14:55:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183ED11C
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 06:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699368944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QiSVy1pXRSo5MmppHuXGQ+MP2WzuNcVblg0LwRCEErU=;
	b=JHdUPKLAc5Ge2OZd8F8jqUgc9GaQ3l/ik2+YD7Eh9AsOldH6pP3VEu5tgXSHWf/rfU2FB4
	huDdztQ648c+Dc5uT92fSdjmnos5H2HdwNGfEze6lGIaqI5bieVxdd2wRZRNFq8NRtD1US
	BibOFh8pVI2NyZAFCUKTT+GWbGENE8A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-50i4Fx2pMGydqgtQ1ps_Iw-1; Tue, 07 Nov 2023 09:55:32 -0500
X-MC-Unique: 50i4Fx2pMGydqgtQ1ps_Iw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-408597a1ae3so36454735e9.0
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 06:55:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699368931; x=1699973731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiSVy1pXRSo5MmppHuXGQ+MP2WzuNcVblg0LwRCEErU=;
        b=Mq0uqg7nEjT4GHK4rLNdOUXNABGKRsPaSL33Tg6cKJMXlAUlPYkG1FIC/kaOEtviun
         mp1+nqxFpAI1qpQej7TE+vW1Sb2p3a5R74yOFbxR7nAk6gHSBZaHZr1yl+10uWIRwVh1
         AR3qjkl7encXlpFQDgqFpvOwLicJ0kqI9G1aNtvIDZE7OYLHMBh6mA7rp92D1t2Y+o/b
         zCgjcUM6JLC6ewghVgXEIdt7pX6O/uVH11/IoPz+2xxNVU59h+Hc7hzF+F+c+uZ/fF67
         sFhCZzWZjM+vSKBjZpdDMTW7jgDNUFz/6gDfBZvNaubrIDKSdBc/c9nIqiGl0wLwowHf
         fAVg==
X-Gm-Message-State: AOJu0YwsjhLslDk17QN1zoLtKo9Q+SWvQGSC8+t2oJNw/ZE/gxg6VB3q
	vgnZA0XUHpdRPpL2sUb4x1l9rRZbrokWH0Wc6YZobofmIWROA/i54nvzkwAxe7yJIVbXTBF+t2u
	vAk0sdsMqcIaxSGkgdALt3QDL
X-Received: by 2002:a05:600c:4687:b0:401:bcd9:4871 with SMTP id p7-20020a05600c468700b00401bcd94871mr2498496wmo.21.1699368930994;
        Tue, 07 Nov 2023 06:55:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzbMM8W1j1GgoDZM90c2d8/HJ8vQIG2CKZzYqMIhxHMdsZxgqX9hfyV1Tq0rIL8huNSNR6FA==
X-Received: by 2002:a05:600c:4687:b0:401:bcd9:4871 with SMTP id p7-20020a05600c468700b00401bcd94871mr2498480wmo.21.1699368930620;
        Tue, 07 Nov 2023 06:55:30 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
        by smtp.gmail.com with ESMTPSA id o5-20020a056000010500b00327bf4f2f14sm2556719wrx.88.2023.11.07.06.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 06:55:29 -0800 (PST)
Date: Tue, 7 Nov 2023 09:55:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, yi.l.liu@intel.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107094818-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107124902.GJ4488@nvidia.com>

On Tue, Nov 07, 2023 at 08:49:02AM -0400, Jason Gunthorpe wrote:
> IMHO, this patch series needs to spend more time internally to Red Hat
> before it is presented to the community.

Just to add an example why I think this "internal review" is a bad idea
I seem to recall that someone internal to nvidia at some point
attempted to implement this already. The only output from that
work we have is that "it's tough" - no pointers to what's tough,
no code to study even as a bad path to follow.
And while Red Hat might be big, the virt team is rather smaller.

-- 
MST


