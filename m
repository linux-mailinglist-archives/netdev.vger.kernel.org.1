Return-Path: <netdev+bounces-26573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0B0778354
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 00:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE0A1C20E54
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 22:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CD024183;
	Thu, 10 Aug 2023 22:00:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5614622F02
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 22:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C7DC433C8;
	Thu, 10 Aug 2023 22:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691704855;
	bh=s5QIG+X19estRlbIsKWn9bmkPv61euAyFKFlJLfA9uA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YmW+gMTn+RNUvBFT+Vxz6ayGWIm7w8UdC/fGyXCmtPb2ORtcqxu3CVWLSib/XFoiT
	 +b79K5P5RkyvSfakLAbmiDgwqPs5bjBVCn90e2Lg4hSJlmqDIZh2Hm0FMwGoUvOoJs
	 2m1nw2CJqyULtvqdgft3Fmj5v+QHCnov9Y+dWcP/awKQj4/jPkdPum2FmysCV2Hytd
	 XPLKEc/z/48d3fYkc9XXV70vdjOA2kb69sFq3UaeKfsG0RjF6YA23BMjm2Z0TAinza
	 i68lPdEiioUMvSAjNNUPgWbcSr0GpeR86tviPqfqdRRSE5mL/+cMrtKvBLSpApbumS
	 r4hkpAc+TSLpg==
Date: Thu, 10 Aug 2023 15:00:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, xieyongji@bytedance.com,
 jasowang@redhat.com, david.marchand@redhat.com, lulu@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Message-ID: <20230810150054.7baf34b7@kernel.org>
In-Reply-To: <20230810174021-mutt-send-email-mst@kernel.org>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
	<20230810150347-mutt-send-email-mst@kernel.org>
	<20230810142949.074c9430@kernel.org>
	<20230810174021-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 17:42:11 -0400 Michael S. Tsirkin wrote:
> > Directly into the stack? I thought VDUSE is vDPA in user space,
> > meaning to get to the kernel the packet has to first go thru 
> > a virtio-net instance.  
> 
> yes. is that a sufficient filter in your opinion?

Yes, the ability to create the device feels stronger than CAP_NET_RAW,
and a bit tangential to CAP_NET_ADMIN. But I don't have much practical
experience with virt so no strong opinion, perhaps it does make sense
for someone's deployment? Dunno..

