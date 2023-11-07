Return-Path: <netdev+bounces-46472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A557E458C
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 17:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734DE1C20B0A
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 16:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98439321BE;
	Tue,  7 Nov 2023 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyDEvhIR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE02D033
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 16:11:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E7E2D7D
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 08:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699373478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fw4FStypu9syAQ3xa9mC4mwCaAdKKxAxHhWjdd8hiZw=;
	b=SyDEvhIRXGQuQfrAnnCwSiBx4GHa1JiPLg0N3qg2GCv6cKuuqWJBKKmucPSozkNDDtqzHk
	WNNpVE6hIgxZpWDJZbAsqIgVCI2kQHF9ra6bzCQm29xCSzo7HoF0cDtnFWIF7VEfs8OR7O
	vdJBSI4/GWyJnFqi6l2ziF6NQ8z9kbU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-Drb7NiYnOTuwNyukfctwEQ-1; Tue, 07 Nov 2023 11:11:16 -0500
X-MC-Unique: Drb7NiYnOTuwNyukfctwEQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32f8371247fso2970112f8f.2
        for <netdev@vger.kernel.org>; Tue, 07 Nov 2023 08:11:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699373473; x=1699978273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw4FStypu9syAQ3xa9mC4mwCaAdKKxAxHhWjdd8hiZw=;
        b=b8k/BoZJVirteOjMvq+wNajASax6EIZFOi9YzMwafIC0DbZf9BbDUHAvqX9YZ2AvR2
         laHPk/DhK+j3TCfwqqjrS4x3WiKasxi517VZqHnuwfzp2Cen2/fTHA5t8O1j5j3UkI1V
         IZwZHJYsCs6ZLMuQqGrs/n5R4ghHHuLZbxHNPr7q0UGfA0d59J2pVY3mZyf6egbhv8M1
         g/0UUj2O2cIwKjvn1Y1zM34hCScDnmBjprGpl7uw8jB7dmLh/Z4NcFtNe1ediCVGUgTw
         09bZeHz3eqiqZeJRtBxeQPAGwjivZq97UGls8HiNXEsqN1Y0pruONqkvjoHTWH0/2sq7
         /ydA==
X-Gm-Message-State: AOJu0YzI3GJgdWntFGBv86dSqNDXpCbkMz9YtdqgcofbzfGVnbxWb1sV
	lkdaO0Xn3L1iImOVL2CbmXunL0HdmlVhW1iseAS8xK5SObQPbZlJnOdhrJUILFIVQgI6RYaXYR2
	jTTZIgeVKZd7+shQTmPP02qGY
X-Received: by 2002:a5d:4242:0:b0:32d:a910:6c2a with SMTP id s2-20020a5d4242000000b0032da9106c2amr20392843wrr.30.1699373473047;
        Tue, 07 Nov 2023 08:11:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgMckOifCcs2vvNetl9dhM/47Y7sLJxike1OKMQTMQ/IMLbHJBruMwhH1ayLRP/5336FfqBA==
X-Received: by 2002:a5d:4242:0:b0:32d:a910:6c2a with SMTP id s2-20020a5d4242000000b0032da9106c2amr20392827wrr.30.1699373472700;
        Tue, 07 Nov 2023 08:11:12 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
        by smtp.gmail.com with ESMTPSA id u3-20020adfed43000000b003140f47224csm2739390wro.15.2023.11.07.08.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 08:11:11 -0800 (PST)
Date: Tue, 7 Nov 2023 11:11:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, yi.l.liu@intel.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107105718-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
 <20231107094818-mutt-send-email-mst@kernel.org>
 <20231107154848.GP4488@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107154848.GP4488@nvidia.com>

On Tue, Nov 07, 2023 at 11:48:48AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 07, 2023 at 09:55:26AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Nov 07, 2023 at 08:49:02AM -0400, Jason Gunthorpe wrote:
> > > IMHO, this patch series needs to spend more time internally to Red Hat
> > > before it is presented to the community.
> > 
> > Just to add an example why I think this "internal review" is a bad idea
> > I seem to recall that someone internal to nvidia at some point
> > attempted to implement this already. The only output from that
> > work we have is that "it's tough" - no pointers to what's tough,
> > no code to study even as a bad path to follow.
> > And while Red Hat might be big, the virt team is rather smaller.
> 
> I don't think Nicolin got to a presentable code point.
> 
> But you can start to see the issues even in this series, like
> simulator is complicated. mlx5 is complicated. Deciding to omit those
> is one path. Come with a proposal and justification to take it out,
> not a patch with an unexplained #ifdef.

Right. Simulator I don't think we need to support, or at least
not necessarily to get this merged - it does not really
benefit from any iommufd features.


