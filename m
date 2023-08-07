Return-Path: <netdev+bounces-25150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A21F77312A
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C291C1C20953
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D41174FE;
	Mon,  7 Aug 2023 21:25:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFBB174DF
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF8DC433C7;
	Mon,  7 Aug 2023 21:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691443501;
	bh=+FYo2DwDk8INex7fJWh2qszXosFc40/Un31WZbKy/GM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bcTW4SA6mIgaRX8m+K9PvCf0DcqYWxbda6M2ZE8LqC2un6Rsqpf91ozIcDCbMrwri
	 P4ZScYQ8kXN9oYXpUqlndA/CLbFZn+GT6dABSAUrjI5neqYD/YCO/7RifYNFRfxrz0
	 Z8WROuYhxJ2+mirSWVEzKTOSceRbhYOhpn6NLhlecD7ORazcDZVheqQpegFlgJZiNj
	 3vJLCajSK0O12k9+M3uUWjHXcwUrs/vH4ElG0u0VQ3g+8cMUWeG67BGjJmea/oQcnn
	 PpQeXI1tZQmR7xYNdf5LWcfc5+FOgfyixy8M163kVuQghhv8ySgMi5w1+35RSn8w0G
	 C8+Jupwgvs+UQ==
Date: Mon, 7 Aug 2023 14:24:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: aelior@marvell.com, davem@davemloft.net, edumazet@google.com,
 manishc@marvell.com, netdev@vger.kernel.org, pabeni@redhat.com,
 skalluru@marvell.com, drc@linux.vnet.ibm.com, abdhalee@in.ibm.com,
 simon.horman@corigine.com
Subject: Re: [PATCH v4] bnx2x: Fix error recovering in switch configuration
Message-ID: <20230807142459.5950f237@kernel.org>
In-Reply-To: <7b4904f5-ceb1-9409-dd79-e96abfe35382@linux.vnet.ibm.com>
References: <20220916195114.2474829-1-thinhtr@linux.vnet.ibm.com>
	<20230728211133.2240873-1-thinhtr@linux.vnet.ibm.com>
	<20230731174716.0898ff62@kernel.org>
	<7b4904f5-ceb1-9409-dd79-e96abfe35382@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Aug 2023 16:08:50 -0500 Thinh Tran wrote:
> > Could you split the change into two patches - one factoring out the
> > code into bnx2x_stop_nic() and the other adding the nic_stopped
> > variable? First one should be pure code refactoring with no functional
> > changes. That'd make the reviewing process easier.  
> 
> Sorry, I misunderstood comments in the reviewing of v3 asking to factor 
> the code.
> Should I keep the changes I made, or should I summit a new patch with 
> factored code?

I am not sure what you're asking.

In v5 I'm hoping to see 3 patches (as a single series!)
patch 1 - factor out the disabling into a helper
patch 2 - introduce the bp->nic_stopped checking
patch 3 - changes to bnx2x_tx_timeout()

