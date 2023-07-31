Return-Path: <netdev+bounces-22898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E001E769D5A
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2EA1C20C9B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784B719BCF;
	Mon, 31 Jul 2023 16:57:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8F119BB2
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 16:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62617C433C7;
	Mon, 31 Jul 2023 16:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690822666;
	bh=CJH6rKKIQr+O1cYpO7ZYWDb48ZY566W3boLynIIqKYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oAjk5oBbFA0YD99m5bx9ijqbjkAM5uqQZu9Fo4LE5wcTVR7ZIKPt2gxsFrJN4NyXs
	 qqYxCLMrz4Rio85rguR6tSn+PRcrecOqVEPqwiAul0us6kUlI5hJdsgXcTikzt1wxg
	 /0Vc7iudwLs0e6UJwAx90P+K1MMS5c5W29aftLVLNelk8QZ65qk2hsJPNP6KuyyxB2
	 8lcCn5CXGnKGSklZVdJtou7GCNdPPWt2J/jLSb2j3C8VXCfh4zicE99kP+OD6ktOQh
	 Ux/eJt//bHuD0acrtYLbo/jV3m7Fvlv76mUXG+HLaMTjdU1TuibMrCDYL645sOZan8
	 atuF81qH8luqA==
Date: Mon, 31 Jul 2023 09:57:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 08/11] devlink: introduce set of macros and
 use it for split ops definitions
Message-ID: <20230731095745.60a965b8@kernel.org>
In-Reply-To: <ZMenYPE5zrA2myAm@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
	<20230720121829.566974-9-jiri@resnulli.us>
	<20230725103816.2be372b2@kernel.org>
	<ZMenYPE5zrA2myAm@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 14:21:52 +0200 Jiri Pirko wrote:
> >If you want to use split ops extensively please use the nlspec
> >and generate the table automatically. Integrating closer with
> >the spec will have many benefits.  
> 
> Yeah, I was thinging about it, it just didn't seem necessary. Okay, will
> check that out.
> 
> Btw, does that mean that any split-ops usage would require generated
> code? If yes, could you please document that somewhere, probably near
> the struct?

I wrote it somewhere, probably the commit messages for the split ops.
The tools are not 100% ready for partial generation I don't want to
force everyone to do code gen. But the homegrown macros in every family
are a no go.

