Return-Path: <netdev+bounces-46953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F3F7E7547
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 00:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891D2B210E8
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 23:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B938538FAD;
	Thu,  9 Nov 2023 23:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlG6uUvk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FBC38FB1
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 23:48:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C743868
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 15:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699573735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3SxbBnBy8wcp+DFoAqPelvZA1LQU0OFFn4SXuqEY8lc=;
	b=RlG6uUvk26rvei/FG57xJR51mvz7nCz0GcH2Gt5wkq8vOjx89DDHr3JcxmUoL2Gd0B6gJn
	YUtUJX4TFGfdgvXQYMhtWnpRLBTxmZatrcVJWLj+NkPtEZ42RR/DnnCufX+Wkioc+BEu3m
	AcM1JjepUYTB+rhhkbxBCkI+a741eJM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-qtwMR2UuMSqnZxAge3gGUA-1; Thu, 09 Nov 2023 18:48:53 -0500
X-MC-Unique: qtwMR2UuMSqnZxAge3gGUA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9d25d0788b8so112633166b.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 15:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699573732; x=1700178532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SxbBnBy8wcp+DFoAqPelvZA1LQU0OFFn4SXuqEY8lc=;
        b=RwRdp4akKlTWvv6P0bFKtnaK9wcPeR2TLNIXoNPpUhsvGQWp4oUp13icjHtWQ+8jRP
         a1ov8yKppT8UGtnaH+ZbNr3N+7umzRnznQWB7uWuiJ5BG5TLdHOBU9fpgH9gbDiCjFz1
         nrqQggfe4t9wgm4g97DA2bDnmgbVhc2FXjbPduiR4hRkLe2yjvnTsj3YQ/OlGGJHTiMb
         gi/1NStp7riukh12MDIYHfOlH8tTWlOPGLwXdPqVKSVB5m6NTAunvsqE0FrboQMaQH6b
         ehzJh1x7D2qnxZUeZ+aE+7aF2kG99EaTJdaS8rn2UEgU1f5DjfxXGXXkZBUXJ2E818GH
         Z6Tw==
X-Gm-Message-State: AOJu0YxSp21KsmzF4TXR1FtjT4qVVkcvcji1aFYpSXffSO/m9mP9gReb
	vYAt22OTHAEsCHijqF+gC+JOSi9+KvGdSMfPZgLkmBjb/S8GcUz1CrNHNY9ejbyF1GajMHroTQO
	hHCyjZTF7ClZVb9K/
X-Received: by 2002:a17:907:25c4:b0:9e1:1996:f3d6 with SMTP id ae4-20020a17090725c400b009e11996f3d6mr6251179ejc.76.1699573732744;
        Thu, 09 Nov 2023 15:48:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKFgKEEunbjt3marXxbZibLU1JXnSLXyCS7/ojjJiN6MLuJ2Aa5uQPqet3dxVKkQKsLVJ/dA==
X-Received: by 2002:a17:907:25c4:b0:9e1:1996:f3d6 with SMTP id ae4-20020a17090725c400b009e11996f3d6mr6251167ejc.76.1699573732476;
        Thu, 09 Nov 2023 15:48:52 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f4:2044:be5a:328c:4b98:1420])
        by smtp.gmail.com with ESMTPSA id j17-20020a170906255100b009737b8d47b6sm3126661ejb.203.2023.11.09.15.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 15:48:51 -0800 (PST)
Date: Thu, 9 Nov 2023 18:48:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, yi.l.liu@intel.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231109183407-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
 <20231107082343-mutt-send-email-mst@kernel.org>
 <20231107141237.GO4488@nvidia.com>
 <20231107092551-mutt-send-email-mst@kernel.org>
 <20231107155217.GQ4488@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107155217.GQ4488@nvidia.com>

On Tue, Nov 07, 2023 at 11:52:17AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 07, 2023 at 09:30:21AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Nov 07, 2023 at 10:12:37AM -0400, Jason Gunthorpe wrote:
> > > Big company's should take the responsibility to train and provide
> > > skill development for their own staff.
> > 
> > That would result in a beautiful cathedral of a patch. I know this is
> > how some companies work. We are doing more of a bazaar thing here,
> > though. In a bunch of subsystems it seems that you don't get the
> > necessary skills until you have been publically shouted at by
> > maintainers - better to start early ;). Not a nice environment for
> > novices, for sure.
> 
> In my view the "shouting from maintainers" is harmful to the people
> buidling skills and it is an unkind thing to dump employees into that
> kind of situation.
> 
> They should have help to establish the basic level of competence where
> they may do the wrong thing, but all the process and presentation of
> the wrong thing is top notch. You get a much better reception.
> 
> Jason

What - like e.g. mechanically fixing checkpatch warnings without
understanding? I actually very much dislike it when people take a bad
patch and just polish the presentation
- it is easier for me if I can judge patch quality quickly from the
presentation. Matter of taste I guess.

-- 
MST


