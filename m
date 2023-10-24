Return-Path: <netdev+bounces-44038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E287D5E7D
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1FE32817CE
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A37138DCC;
	Tue, 24 Oct 2023 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+jo1aO2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14812D61E
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9D3C433C8;
	Tue, 24 Oct 2023 22:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698187913;
	bh=sAHTaHWdIYTckfjIJcqmmU93uvyMmFpt0UIE+yQf30Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W+jo1aO2VWGSfr5m/H+ng1Ovtf0gyR5opEBnSpQDM872mjEVcqR6T6uxuAxECRrfN
	 JYnWjTFb18gnVSSbi1p8eELmJw+Wbwj+ekG7ryGp2aGJWTfd4U2jz4pnM3CDN4xE+w
	 vRXHho4L2UfJ2LqOHBbbKNiEIN9iOF+GfCwj4uFTefVPqZ41jnqt7Q7dopvpbwzA6B
	 DdG2XJDl4lYJjiHSw6fwCJbmRXysDn1mCPBuC+uk9C+PImNSV14vrEY70Tl8s6TkVy
	 Rs0t4ULlSMdG+VihzFKWSEJ94PRZFwH4vGI+Iu2xn8VEfxJwfAmBEamSc8URlLFZ4r
	 EnErUSTpuNlHg==
Date: Tue, 24 Oct 2023 15:51:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v6 00/10] Introduce queue and NAPI support in
 netdev-genl (Was: Introduce NAPI queues support)
Message-ID: <20231024155152.1c186257@kernel.org>
In-Reply-To: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
References: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 18:33:19 -0700 Amritha Nambiar wrote:
> The queue parameters exposed are:
> - queue index
> - queue type
> - ifindex
> - NAPI id associated with the queue
> 
> Additional rx and tx queue parameters can be exposed in follow up
> patches by stashing them in netdev queue structures. XDP queue type
> can also be supported in future.
> 
> The NAPI fields exposed are:
> - NAPI id
> - NAPI device ifindex
> - Interrupt number associated with the NAPI instance
> - PID for the NAPI thread

Please repost with my nitpicks addressed whenever you're ready.
The series seems to be in a pretty good shape to me.

