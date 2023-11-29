Return-Path: <netdev+bounces-52169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559847FDAF2
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4BA4B2121B
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1265E3717E;
	Wed, 29 Nov 2023 15:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hs06y4qc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6D732C94
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 15:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26998C433C8;
	Wed, 29 Nov 2023 15:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701271017;
	bh=VFOZzs8o7/u72fprN/rccNPVxI+Vd0QhbjjdwfWaz6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hs06y4qcUB4rQPeU1Dhor7KcE6UNk+BeUkeaeGhp07Jo1bTzNroxL5hbdy8KrZ6y8
	 3h+G6U5Wny5B4+Yaa4hM/ugoGgmF2/A8i/HaTf1lONrcxukizTRvsgqT8ZoGE7M/+G
	 n9JZ98AdS/cNXabOTTp4F7pbv5l/hi57QBxlii1aBlRIYtJlgOQOUf80qkogD4FgB8
	 tiqb9V80VRiL5xxpJIaZruHLBDh83uH4aN0cJeg3KC4smnKV/6G7e5l6hiLWzd+LqI
	 oyPdQ/YOkTwtsuntYFe6Kh480m36GfWYI6YVjBehPCAnf0rTOi1WRkuKc/KZBznkr2
	 QHR+WY1UAOWag==
Date: Wed, 29 Nov 2023 07:16:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, corbet@lwn.net
Subject: Re: [patch net-next] docs: netlink: add NLMSG_DONE message format
 for doit actions
Message-ID: <20231129071656.6de3f298@kernel.org>
In-Reply-To: <ZWdOtzoBHiRY53y9@nanopsycho>
References: <20231128151916.780588-1-jiri@resnulli.us>
	<20231128073059.314ed76b@kernel.org>
	<ZWdOtzoBHiRY53y9@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 15:46:15 +0100 Jiri Pirko wrote:
> >> In case NLMSG_DONE message is sent as a reply to doit action, multiple
> >> kernel implementation do not send anything else than struct nlmsghdr.
> >> Add this note to the Netlink intro documentation.  
> >
> >You mean when the reply has F_MULTI set, correct?  
> 
> Well, that would be ideal. However, that flag is parallel to NLMSG_DONE.
> I see that at least drivers/connector/connector.c does not set this flag
> when sending NLMSG_DONE type.

connector is a really bad example, the doc would have to say "some
families use NLMSG_DONE as an actual message type which may have pretty
much anything attached to it". It's not worth it, sorry.
-- 
pw-bot: reject

