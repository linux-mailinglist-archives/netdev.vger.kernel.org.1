Return-Path: <netdev+bounces-52816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9DF8004AC
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9CCFB20B17
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEE312B96;
	Fri,  1 Dec 2023 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnBLBTVX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812E95953A
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 07:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B764C433C8;
	Fri,  1 Dec 2023 07:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701415301;
	bh=jbQvISy2117JavbZBqu8YwWewS/uhIc712uRynCmqyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WnBLBTVXJQgQnyDOYe36wEwPRE55U0OkVMAYBh2bjWKB2wCBBr9I5wvS+0c5f8lge
	 t009afNBKPhAMLiRR1//nN5dnWQ4dCxZuYQAGhQ9oazuD6uzK+a+AVqCOequ+xv9AD
	 TXvQ6HZBZIKwqRqewROIS3pddtf7RMbyNnd+aNOuALo0oSGki7Bx5c2KU5j1j/p6rt
	 qTCgydMOyD/tDtar/To+sZoOpAdTuxvvwsdOAChpDhLsLR5JppNsQzCHwNKKwfQ4uy
	 mM7KMyYfw+X/3yB18QH1VcaSs4m32IspBe+BIDQM7ZJDN/+6XVWVTexuBztbDXCmfG
	 rn2295VuCFJfA==
Date: Thu, 30 Nov 2023 23:21:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: Michael Chan <michael.chan@broadcom.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>, <edumazet@google.com>, <ast@kernel.org>,
 <sdf@google.com>, <lorenzo@kernel.org>, <tariqt@nvidia.com>,
 <daniel@iogearbox.net>, <anthony.l.nguyen@intel.com>,
 <lucien.xin@gmail.com>, <sridhar.samudrala@intel.com>, Andrew Gospodarek
 <gospo@broadcom.com>
Subject: Re: [net-next PATCH v10 11/11] eth: bnxt: link NAPI instances to
 queues and IRQs
Message-ID: <20231130232139.25b6cba1@kernel.org>
In-Reply-To: <d4d8769b-a96b-42c6-9d76-92174eb638a1@intel.com>
References: <170130378595.5198.158092030504280163.stgit@anambiarhost.jf.intel.com>
	<170130410439.5198.5369308046781025813.stgit@anambiarhost.jf.intel.com>
	<CACKFLi=if7dtWvvOnKPwxn-hmfzGMCMzfSacNhOQm=GvfJThQQ@mail.gmail.com>
	<d4d8769b-a96b-42c6-9d76-92174eb638a1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 12:53:50 -0800 Nambiar, Amritha wrote:
> > This will include the XDP TX rings that are internal to the driver.  I
> > think we need to exclude these XDP rings and do something like this:
> > 
> > if (i > bp->tx_nr_rings_xdp)
> >          netif_queue_set_napi(bp->dev, i - bp->tx_nr_rings_xdp,
> >                               NETDEV_QUEUE_TYPE_TX, &txr->bnapi->napi);
> 
> Okay, will wait for Jakub's response as well. I can make this change in 
> the next version (after waiting for other comments on the rest of the 
> series), but I may not be able to test this on bnxt.

No extra comments from me, thanks for taking care of the update.
-- 
pw-bot: cr

