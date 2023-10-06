Return-Path: <netdev+bounces-38617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B697BBAE6
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35B71C209A9
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0199B26E13;
	Fri,  6 Oct 2023 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xjq91hMU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B631CA9A
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 14:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E078AC433C8;
	Fri,  6 Oct 2023 14:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696604137;
	bh=escjTaAkihSGCwsnxPhJNWcVLi3MOtJXB2WfVZLU/AI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xjq91hMUaSUj8yHtoYoNfxZsXwJMtqvlTupffCdR2YqZrTI02mHmFywx6WT36rqAR
	 XrYQ8/ALEPGkvO0a61fV+WztHkKKKl+zgJrQxl7eIWRNgTE5c7XvFB/QQXK5jt0QYM
	 nf075SJZMFtTd4ckmPb9JIU+0EifqUWsTni/VUCtI2wT5a0NEGIPm993UgSnbD+Dzg
	 z9lfKhDs5GWxmz0AbJjzYDxDaMdW4ERn/eeRZPcH3Qr2QwXlBwAXN4otiY4K4TJ/DK
	 uEDxEvs+/GxE+LHO3vPhhAiTXbqmENV3cFz4on9f3Ry1BnyTQ7EcskuZQr5UUDa0c5
	 1XFU4+/wjFSAg==
Date: Fri, 6 Oct 2023 07:55:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 netdev@vger.kernel.org, vadim.fedorenko@linux.dev, corbet@lwn.net,
 davem@davemloft.net, pabeni@redhat.com, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v3 2/5] dpll: spec: add support for pin-dpll
 signal phase offset/adjust
Message-ID: <20231006075536.3b21582e@kernel.org>
In-Reply-To: <ZR/9yCVakCrDbBww@nanopsycho>
References: <20231006114101.1608796-1-arkadiusz.kubalewski@intel.com>
	<20231006114101.1608796-3-arkadiusz.kubalewski@intel.com>
	<ZR/9yCVakCrDbBww@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Oct 2023 14:30:00 +0200 Jiri Pirko wrote:
> >+version: 2  
> 
> I'm confused. Didn't you say you'll remove this? If not, my question
> from v1 still stands.

Perhaps we should dis-allow setting version in non-genetlink-legacy
specs? I thought it may be a useful thing to someone, at some point,
but so far the scoreboard is: legit uses: 0, confused uses: 1 :S

Thoughts?

