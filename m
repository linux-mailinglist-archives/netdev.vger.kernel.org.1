Return-Path: <netdev+bounces-52633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92A17FF877
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF20B20CB1
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 17:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7584058105;
	Thu, 30 Nov 2023 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXzi1eHz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5628151002
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 17:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D297AC433C7;
	Thu, 30 Nov 2023 17:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701365980;
	bh=CZqrdkZ4ENP7qgExXIa/F+1bLjJzCwWKd/rStNYLK4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qXzi1eHz/tXTGi+nFE43btAjPSUpchZUG/OlV24ZeBg4ivSjo5qc1RGo7plSB70ne
	 k9E6F2fZJcES6flH1Bx7Y8JZR181nBcwd3v8EQXeoH6pur2Gxx/dSBJB9Y6IhvIhxI
	 mQbuu8W+hyXkctRO73VOejZhQd4fuzYp7jTzF14Xx5uDJqvEPus39r8T+b3bPzAR+y
	 SKpSvoTRnOHAHzttuuz9GPpxWYDOEkpQju/82n5VkAqT3A/UyWyhf6XhY6G6abVuKJ
	 wW0UXtdV1GkBbUYOuxCjKJrg9nAjJVFviqAsyLugXsBlrjQeqZziURAE+hUoeWVLbG
	 AfoppU5G5InSQ==
Date: Thu, 30 Nov 2023 09:39:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, corbet@lwn.net
Subject: Re: [patch net-next] docs: netlink: add NLMSG_DONE message format
 for doit actions
Message-ID: <20231130093939.06a987cb@kernel.org>
In-Reply-To: <ZWiOfMs1PT14LLau@nanopsycho>
References: <20231128151916.780588-1-jiri@resnulli.us>
	<20231128073059.314ed76b@kernel.org>
	<ZWdOtzoBHiRY53y9@nanopsycho>
	<20231129071656.6de3f298@kernel.org>
	<ZWiOfMs1PT14LLau@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 14:30:36 +0100 Jiri Pirko wrote:
> >connector is a really bad example, the doc would have to say "some
> >families use NLMSG_DONE as an actual message type which may have pretty
> >much anything attached to it". It's not worth it, sorry.  
> 
> The existing documentation confuses uapi users (I have sample).
> They expect error with NLMSG_DONE.

I hate this so much.

How about we say:

  Note that some families may issue custom NLMSG_DONE messages,
  in which case the payload is implementation-specific.

