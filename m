Return-Path: <netdev+bounces-45777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D7A7DF87A
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 18:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818BC281C2C
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2C01DFC2;
	Thu,  2 Nov 2023 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCm/6n4x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0161DFC0
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 17:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913D1C433C9;
	Thu,  2 Nov 2023 17:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698945297;
	bh=YWbbEndApLhfHNI379/b3+zyDl9cbjdfnITl/KQN1mc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iCm/6n4xyxxzsy2MGw9sH3kQyN/9bdf7PypP1jrN7QxH/AkOhJk/3DWhwrlOMxtre
	 KRhaai6WIZbVuOPmGN1Ogvs5B/ugdLoZjj3IG4Mi6VBoY9lEZWdVWAYQFjkaqFzHdr
	 nQ20r/tbp6cbIiGqaOB2eUJf+u5eM+dHkbvwModKULkbxAbIdteYqvb1FRfWSmVOTl
	 RW/jcNheYpMejJv3JobO8+EO7tHwzJJy87D/eEALM+9Uy/E9bpL9TA9pdXP4k3Dgwt
	 o3TeT5HyDLb2Jv0Eyp0I2xFgsDyofaLiU90JuqT31HQ0FDX9hNFneBWScu7JND87IM
	 CJCsiBQ3RrOjw==
Date: Thu, 2 Nov 2023 10:14:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Jiri Pirko <jiri@resnulli.us>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net] netlink: fill in missing MODULE_DESCRIPTION()
Message-ID: <20231102101456.66e6419b@kernel.org>
In-Reply-To: <20231102120533.GL6174@breakpoint.cc>
References: <20231102045724.2516647-1-kuba@kernel.org>
	<ZUOP7tOSK2ysyuUc@nanopsycho>
	<20231102120533.GL6174@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Nov 2023 13:05:33 +0100 Florian Westphal wrote:
> > It's a bit odd to target -net with this, isn't it?  

I mostly wanted to make sure the build bot still works after
we sucked in all the code from Linus. There was no patches getting
posted but...

> I had planned to fill the missing descriptions for
> all netfilter via next nf.git PR as I consider those as
> bug fixes.
> 
> Thats the regression risk here?

+1 for getting it into net, no regression risk and it's low key
annoying to see all these warnings.

