Return-Path: <netdev+bounces-31753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1051178FEEE
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 16:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3993A1C20CA1
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 14:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C76C126;
	Fri,  1 Sep 2023 14:22:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17433AD41
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 14:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D72CC433C9;
	Fri,  1 Sep 2023 14:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693578168;
	bh=h1/Wzrzar7jmouGn/w0zA/gRRvOV5e0aTKvFAmaZlek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=imHaNISNraldq/FXvYhvXFmCGrFiF4lQdF6AOK77QFbEaixunDT1VOUoSxjWvi3SX
	 XUI+fFYsVQSoCZm49EebTbmvsucNQVBGbZSboPg67t1lpaedApRXkN05UULbQJOcnR
	 uLcdPlsfJw52+rWKkg3xlD1jl1JnWKtm3br42LIIFs3Xalfja+4wMmckzL28XSlWHD
	 777pehiDKlSm8Y4sdECyMXBRpToWge67x1rUK3AwahpNi1diiBuj4MbwVCnqOsFwzt
	 CBPINhiXyJR1w+1EXRtD85lqGhk7CLf8zn0V4lfauu+o7cY4ryrqG5SqESr5VenS0U
	 hxcXVYjAJ16+g==
Date: Fri, 1 Sep 2023 07:22:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, corbet@lwn.net, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, rdunlap@infradead.org,
 laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH net v3] docs: netdev: document patchwork patch states
Message-ID: <20230901072247.20f84171@kernel.org>
In-Reply-To: <ZPGjdQOfM2POGoEW@hog>
References: <20230901014131.540821-1-kuba@kernel.org>
	<ZPGjdQOfM2POGoEW@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Sep 2023 10:40:21 +0200 Sabrina Dubroca wrote:
> > v3:
> >  - clarify that patches once set to Awaiting Upstream will stay there  
> 
> mhmm, the patch looks identical to v2. Did you post the wrong version?

oops, forgot to commit, thanks for catching!

