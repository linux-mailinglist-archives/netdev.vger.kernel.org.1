Return-Path: <netdev+bounces-38656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8557BBF61
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 20:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46368282148
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 18:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85D038FB2;
	Fri,  6 Oct 2023 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1smp2O3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C4328C3
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 18:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325C1C433C8;
	Fri,  6 Oct 2023 18:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696618636;
	bh=YfL+m9ds7WTaojs/Iarhw4Oi2gSQuduYuEM7beYt9us=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n1smp2O3K/IK+HuWDTGTFZrTTI676iHfiYg4dRdb9sjrOK3xg7UGmB9vMj5I7SwDh
	 /jDPPbSFG6zEbep6uzKQ2MCeyG++xVnbCT6C8Wyz3/JQGQK1DHE6jpA3b3+L8VlFhc
	 rZY5uvxA2H56BbHXw9jbNd3IuVzf+L0Fo8SyI2Mk3p10MohbvzqABR6dHhby9yh7nf
	 CmtCxwNHjKkA0aqgtlnfieCT+zzw2zbv+4lFfKo94HsR6Ye3bAk/HxmNdv5wc/tH5R
	 Cm102627ZJoyZ2XUSjDdzs3VNwaDR4g1ZxPTcx2cLRH/WHb38nD3PNiiT4fQ5RKym2
	 qUIRWLyvCcdSA==
Date: Fri, 6 Oct 2023 11:57:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jesse.brandeburg@intel.com, sd@queasysnail.net,
 horms@verge.net.au
Subject: Re: [RFC] docs: netdev: encourage reviewers
Message-ID: <20231006115715.4f718fd7@kernel.org>
In-Reply-To: <8270f9b2-ec07-4f07-86cf-425d25829453@lunn.ch>
References: <20231006163007.3383971-1-kuba@kernel.org>
	<8270f9b2-ec07-4f07-86cf-425d25829453@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Oct 2023 20:41:19 +0200 Andrew Lunn wrote:
> We already have:
> 
> https://docs.kernel.org/process/7.AdvancedTopics.html#reviewing-patches
> 
> which has some of the same concepts. I don't think anything in the
> proposed new text is specific to netdev, unlike most of the rest of
> maintainer-netdev.rst which does reference netdev specific rules or
> concepts.
> 
> So i wounder if this even belongs in netdev? Do we actually want to
> extend the current text in "A guide to the Kernel Development
> Process", and maintainer-netdev.rst say something like:
> 
>     Reviewing other people's patches on the list is highly encouraged,
>     regardless of the level of expertise.
> 
> and cross reference to the text in section 7.2?

:) If I can't get it past you there's no chance I'll get it past docs@

Let me move some of the staff into general docs and add a reference.
The questions which came up were about use of tags and how maintainers
approach the reviews from less experienced devs, which I think is
subsystem-specific?

