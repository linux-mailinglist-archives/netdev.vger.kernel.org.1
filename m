Return-Path: <netdev+bounces-44397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644187D7CF5
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 08:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C35B2B21227
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 06:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6325D2CA9;
	Thu, 26 Oct 2023 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L09sFBce"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F55256C
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 06:42:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE237AC
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698302558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YcSdpoUqOf2Z9R33aI1lokYDTHT4EyidLQqYg+ty5Po=;
	b=L09sFBcerO05jLJd8uhSxIhYebyT59RL1WbHQUzSjKqW30ZKpvcbgSXfV3eyMhyqV8x/k+
	d4fqCdYRgkbgw+/3UkQ5mLTeuGawG6AYdI2lyBuNok2kklz8y1D45uKm3D0jAaFpfEhhyB
	F0UhOScyWAuPJWGsLlgh8WgUYWv9R9Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-d_7ni1F1MpaiO4yQ3WOxbA-1; Thu, 26 Oct 2023 02:42:36 -0400
X-MC-Unique: d_7ni1F1MpaiO4yQ3WOxbA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32d9cd6eb0bso287974f8f.0
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 23:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698302555; x=1698907355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YcSdpoUqOf2Z9R33aI1lokYDTHT4EyidLQqYg+ty5Po=;
        b=wKCAZi/s7k2aH/3kAcHR5X/c7VAxzZNeYHDAlgxAjXQAjdTaavHJQcCIA0Kk/ZxoAw
         tofYOKQXERtNopDMK9GkuEsRmW4gf9OrlipElP9+kPxo2yWN4oTLs+JStc1AbAZh7q0z
         u+Yf3AlAm73tpNtR2ErZ4d2KmoUhXQc70+dz/QWYPJZ1itoqH5WRyjPPuziUNTG5/drT
         2Q6pEl1E8gIczzjQmvB32HAdh7KWQK+2w6OF3jH1cDy9n+g2Ornq8nST9XPz5KCn+TtF
         ygA/jHR1wqWvHzI/H17qV+ipMO55Mne9PipHMuIavOy0rxxhbdGSPjrV+EwuwZu6D4IN
         nJjg==
X-Gm-Message-State: AOJu0YzpAOBQe5LkdYPZRjOMJInkB813bCqtdTOf5+Q980WBOzz60Tdo
	j4KBE/vMHZEoSsjp2tdweBfVVYmiX1NXXRDjAM87/e5E86EWSEGjfjzAHnaFv4bDnusqd4Y/h/s
	t6THOzosMWEMtexOK
X-Received: by 2002:adf:f346:0:b0:32d:b55c:41fa with SMTP id e6-20020adff346000000b0032db55c41famr11780962wrp.28.1698302555141;
        Wed, 25 Oct 2023 23:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyERIAjDqKu0DYcUvMGZ5OQyQV1lKAaWBiouUmORp6s90/5p5CWf/xBYBrtM78ZcOrPN+XpQ==
X-Received: by 2002:adf:f346:0:b0:32d:b55c:41fa with SMTP id e6-20020adff346000000b0032db55c41famr11780951wrp.28.1698302554847;
        Wed, 25 Oct 2023 23:42:34 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:3c98:7fa5:a31:81ed:a5e2])
        by smtp.gmail.com with ESMTPSA id e16-20020adfef10000000b0032d8354fb43sm13637693wro.76.2023.10.25.23.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 23:42:34 -0700 (PDT)
Date: Thu, 26 Oct 2023 02:42:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
Message-ID: <20231026024147-mutt-send-email-mst@kernel.org>
References: <20230923170540.1447301-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230923170540.1447301-1-lulu@redhat.com>

On Sun, Sep 24, 2023 at 01:05:33AM +0800, Cindy Lu wrote:
> Hi All
> Really apologize for the delay, this is the draft RFC for
> iommufd support for vdpa, This code provides the basic function 
> for iommufd support 
> 
> The code was tested and passed in device vdpa_sim_net
> The qemu code is
> https://gitlab.com/lulu6/gitlabqemutmp/-/tree/iommufdRFC
> The kernel code is
> https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC
> 
> ToDo
> 1. this code is out of date and needs to clean and rebase on the latest code 
> 2. this code has some workaround, I Skip the check for
> iommu_group and CACHE_COHERENCY, also some misc issues like need to add
> mutex for iommfd operations 
> 3. only test in emulated device, other modes not tested yet
> 
> After addressed these problems I will send out a new version for RFC. I will
> provide the code in 3 weeks

What's the status here?

-- 
MST


