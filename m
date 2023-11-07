Return-Path: <netdev+bounces-46442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DF47E3FFF
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 14:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A5E2810AA
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 13:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967FC30CEC;
	Tue,  7 Nov 2023 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X61D1l0C"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543D30CE2
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 13:23:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC21D77
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 05:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699363421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6FU32l39lKCSdZhSytwDwo2S8vBHIikXujdpUSbPKo8=;
	b=X61D1l0CR8EBysMqV0fKkD5c/GPANhC8L38HBFQrFg0C4BX1Xkb2+CbTZkgKWH2WmLjp+s
	lIDPOoo6gCYnKhoD/PHhAmObmE89zSBH/c6wdqAUNuQsuHVuJAlzope1Vt8YmSW3vrQ4zT
	WdqDMLNeQtorAVf7Km1kCwRP/xyRVEg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-vpqI20_IORqpHI9YiouMZg-1; Tue, 07 Nov 2023 08:23:39 -0500
X-MC-Unique: vpqI20_IORqpHI9YiouMZg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4083865e0b7so33789655e9.3
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 05:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363418; x=1699968218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FU32l39lKCSdZhSytwDwo2S8vBHIikXujdpUSbPKo8=;
        b=sVAYlWkZCEC0CVh+3GGiEtuFvoNel8XSp/Sn7zBxUgDtFaqAXhHF002m/Y2UmrF98O
         LXEhuPUn6F0102Vv3An6rGzH+VodN+N0W8bVKU9b6V0lIOT5Z31cEekJn/ISfKTEwO5I
         mgbRJBq2lpcNoRoAoRE7n/iKP/wPD6G7tTgNCmkDKXQ9MmNgntTaMvKeIs7FUi8tWIDT
         9LmUjcJ4kKH4wppuUM8xO1DL6sWiavhaDpyxwrX82abhVMozivTCBOpe6wuGaZlr3/IF
         QozTPqKxzrJMz0VNtBNx1E6AFkZdNIOmTp6U43myTrP+fy3ZA2/U+YkNVGIbvcKmCE98
         WfTA==
X-Gm-Message-State: AOJu0YwgxmxWnGyThdswAjy1+nbXOpYeETHGKtIbhnJwmsjCvLjpFa0l
	sXwZ4gkiYLY6MRtqYuWIl7XX6UwP/9NPvnDWGNTNvC84jA0TeLLiDaOESXn4odSdcg4w/4qEXDa
	Pqk3DKkYofw64Uton
X-Received: by 2002:a5d:64af:0:b0:32f:aaff:96dd with SMTP id m15-20020a5d64af000000b0032faaff96ddmr11425183wrp.4.1699363417949;
        Tue, 07 Nov 2023 05:23:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkb/2QIpst9kXo1JNieCe98S9IH2A6ymDLslfoNXCzUG50rRwswfRq4amhWEX0BKprIvqrcA==
X-Received: by 2002:a5d:64af:0:b0:32f:aaff:96dd with SMTP id m15-20020a5d64af000000b0032faaff96ddmr11425155wrp.4.1699363417297;
        Tue, 07 Nov 2023 05:23:37 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
        by smtp.gmail.com with ESMTPSA id o3-20020a056000010300b0032da4f70756sm2391885wrx.5.2023.11.07.05.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:23:36 -0800 (PST)
Date: Tue, 7 Nov 2023 08:23:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107082214-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103171641.1703146-1-lulu@redhat.com>

On Sat, Nov 04, 2023 at 01:16:33AM +0800, Cindy Lu wrote:
> Test passed in the physical device (vp_vdpa), but  there are still some problems in the emulated device (vdpa_sim_net), 

I'm not sure there's even value in bothering with iommufd for the
simulator. Just find a way to disable it and fail gracefully.

-- 
MST


