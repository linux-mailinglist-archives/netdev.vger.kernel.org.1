Return-Path: <netdev+bounces-46448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 530197E41DA
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 15:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81A031C20B82
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 14:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEEC2E3E8;
	Tue,  7 Nov 2023 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Of4PASZj"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397DE2E63D
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 14:30:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CE598
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 06:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699367431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BEK4Nq2797qPXi5hUhUOD+w7Yxl1Y5y6keCDboqBnw=;
	b=Of4PASZjPYtpcx7NaEMxBZk8sa21j4tPyCox960KCw1SRFDq6fyBYirTpQwXvG56TRQ5ZO
	Rdphcb1uqHZisgU16dif/C64RhKLCAnMjCYPSnFnplKf0zuzF+G9lRODXNg3XqML5bAMWc
	4UaX0SLfU+fezPOAkyOpD9LxwxnXvVs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-kk1KB_C2OYyTwQqYDYt9ww-1; Tue, 07 Nov 2023 09:30:27 -0500
X-MC-Unique: kk1KB_C2OYyTwQqYDYt9ww-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-507b8ac8007so6212987e87.0
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 06:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699367426; x=1699972226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BEK4Nq2797qPXi5hUhUOD+w7Yxl1Y5y6keCDboqBnw=;
        b=awKfHB9G6Asd34HZCvCz2m+hSUaYKVDBlvqpPSh+BiVyM3wkirxeqygqA+8EWpwcgv
         MdhHiGw73JcZfgjo9PnjjPi72s2dz+AHp6rMf2IkLuoQK1HuJemQQhuf6Fmv6vjPJaL6
         hJlrNCujqm4dyEnMMUJwtlMQcK6/T7Uu787dDBWFfh3dwNx5mmOZSQSqVmRrk6G3R0df
         vnLy+RHg4oBXemunB2gA33sZ+HN08MUzxQBLCzpta7M936gbNknrRnY1rBUhBPHndRw5
         z+iql8kxkY1DQcNyn6dxN/DfS5rHhGf0aEGpBxoAEdG96PhSfDQFEwR4CaAtSbrRXpup
         nZJQ==
X-Gm-Message-State: AOJu0Yy2rLl929B7WnaUkGkHVGvY4ckAHhhTcTeSJ+qG+5IRLkgQgSbG
	ELWOS/pD3OgVTzZ7dTT0Kt6QrcQMPHUtpPTdkWsYhjMhRFLyRYHVvhXU1XN6DMJs24wiOeQBS6i
	nS8h0w9LFz3J8EAjb
X-Received: by 2002:ac2:488e:0:b0:500:7cab:efc3 with SMTP id x14-20020ac2488e000000b005007cabefc3mr23998199lfc.11.1699367426350;
        Tue, 07 Nov 2023 06:30:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJy8gOlznCOc9sukgGEsAedAcGzp6nnH6baVR5lODsEIZgCRdZq2T6s/WT4PvnZAwy92AFJA==
X-Received: by 2002:ac2:488e:0:b0:500:7cab:efc3 with SMTP id x14-20020ac2488e000000b005007cabefc3mr23998175lfc.11.1699367425918;
        Tue, 07 Nov 2023 06:30:25 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
        by smtp.gmail.com with ESMTPSA id a6-20020a056000100600b0031984b370f2sm2499881wrx.47.2023.11.07.06.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 06:30:25 -0800 (PST)
Date: Tue, 7 Nov 2023 09:30:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, yi.l.liu@intel.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107092551-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
 <20231107082343-mutt-send-email-mst@kernel.org>
 <20231107141237.GO4488@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107141237.GO4488@nvidia.com>

On Tue, Nov 07, 2023 at 10:12:37AM -0400, Jason Gunthorpe wrote:
> Big company's should take the responsibility to train and provide
> skill development for their own staff.

That would result in a beautiful cathedral of a patch. I know this is
how some companies work. We are doing more of a bazaar thing here,
though. In a bunch of subsystems it seems that you don't get the
necessary skills until you have been publically shouted at by
maintainers - better to start early ;). Not a nice environment for
novices, for sure.

-- 
MST


