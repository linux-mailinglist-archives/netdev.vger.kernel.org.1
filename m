Return-Path: <netdev+bounces-29644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D07F7843AA
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 16:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3E3281129
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 14:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDE61CA1B;
	Tue, 22 Aug 2023 14:13:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A10A7F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 14:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D17B9C433C7;
	Tue, 22 Aug 2023 14:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692713632;
	bh=qSVZxItR//vIO7mz/Yu7lmVbQ1T01x1pm5HG2QxTKHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvU0SJKU3wPCEMFhb/WPzwnOtXRHVJSWqadVCrsHGSXfYyMzxq1iSkYfUSzAGtUu8
	 mN4ETipG12soYpJr02bkjP7LcR7VtQFU9H3Q16P83a66gKDuymo/iakha6tew5wDr1
	 EquTVm5dJ1v5hIakVR3MYsGDZUsErzZmwdK0IFZB9D2z7yWqqtiTIL0Rc2/eDcOMK9
	 Py58CpY1Jfhyx6h7g5VF1gZLrr7l1HX9WU25QqriTNuPM+TKTViztwyZPhBcyGFGJ8
	 4qz/dvCImBCinrIDfC1K6CmwDLp6HJ1Almh86jg+WUpkO/h7qLSjGWPwClhx0/WdGo
	 KxhPhlSM6Tg7Q==
Date: Tue, 22 Aug 2023 17:13:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 iwl-next 1/9] ice: use ice_pf_src_tmr_owned where
 available
Message-ID: <20230822141348.GH6029@unreal>
References: <20230817141746.18726-1-karol.kolacinski@intel.com>
 <20230817141746.18726-2-karol.kolacinski@intel.com>
 <20230819115249.GP22185@unreal>
 <20230822070211.GH2711035@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230822070211.GH2711035@kernel.org>

On Tue, Aug 22, 2023 at 09:02:11AM +0200, Simon Horman wrote:
> On Sat, Aug 19, 2023 at 02:52:49PM +0300, Leon Romanovsky wrote:
> > On Thu, Aug 17, 2023 at 04:17:38PM +0200, Karol Kolacinski wrote:
> > > The ice_pf_src_tmr_owned() macro exists to check the function capability
> > > bit indicating if the current function owns the PTP hardware clock.
> > 
> > This is first patch in the series, but I can't find mentioned macro.
> > My net-next is based on 5b0a1414e0b0 ("Merge branch 'smc-features'")
> > ➜  kernel git:(net-next) git grep ice_pf_src_tmr_owned
> > shows nothing.
> > 
> > On which branch is it based?
> 
> Hi Leon,
> 
> My assumption is that it is based on the dev-queue branch of
> https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git

So should netdev readers review it or wait till Intel folks perform
first pass on it?

Thanks

