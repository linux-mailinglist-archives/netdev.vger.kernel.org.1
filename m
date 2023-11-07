Return-Path: <netdev+bounces-46476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A48297E4687
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 18:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3565DB20BAE
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 17:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86869328BA;
	Tue,  7 Nov 2023 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCs6Ksqe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689F0168BC
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 17:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A155CC433C7;
	Tue,  7 Nov 2023 17:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699376570;
	bh=QZ1z+vd2Ki15Htt0z+L7XbvTzj8iKvqYoySqly1vFz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dCs6Ksqed8kvADL8jZeNtcnFX66LqYatqEvbrXFgVVQe1cgKlFEXOiqnl95O28TRh
	 yZ1GIRTz1v9iPw/NZX6TLLDLMPT9I1VXWLKEuz2nHiyRNpdh9lBJEyHReA5BLsVhdG
	 W8RyGoXLx/2sdMk3qc4f0sK9tRkdUaBHjmTqcXblitcP8Cf8TCr1wM2Bg3rxkdvALm
	 Mc9TI6tDcblXJohWtzuF8UAyYPVvE/5i/7PBb5Z39LnogtxxiOIiTdEaih5G/zgOS8
	 gyQY7IrZYhcw6Jg2H8jyWEE3eVU7Ds+3Wmd2ZQOfNWVVshWNEAAsstaREOs9hiha6l
	 Sl4y/BS2jWdFg==
Date: Tue, 7 Nov 2023 09:02:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Cindy Lu <lulu@redhat.com>,
 jasowang@redhat.com, yi.l.liu@intel.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107090249.7e488896@kernel.org>
In-Reply-To: <20231107082343-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
	<20231107022847-mutt-send-email-mst@kernel.org>
	<20231107124902.GJ4488@nvidia.com>
	<20231107082343-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Nov 2023 08:28:32 -0500 Michael S. Tsirkin wrote:
> I am always trying to convince people to post RFCs early
> instead of working for months behind closed doors only
> to be told to rewrite everything in Rust.
> 
> Why does it have to be internal to a specific company?
> I see Yi Liu from Intel is helping Cindy get it into shape
> and that's classic open source ethos.

+1, FWIW.

