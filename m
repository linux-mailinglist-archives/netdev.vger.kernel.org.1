Return-Path: <netdev+bounces-26455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A032777DEB
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B51D1C214DF
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F6C20F8C;
	Thu, 10 Aug 2023 16:15:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2BA1E1D2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCA8C433C8;
	Thu, 10 Aug 2023 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691684100;
	bh=/lBl0wsV33c7Tn0UD0/ryROAGzBH7brEzpd9DgxC6OI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=te3Z3nv3xnMJfI5luRxoMzgQuOA8Wv8MWqg98TCAyZKr6FPdtzHCtfhsUAbxCBCGZ
	 cb66JdlW+9ZA2TJPEZd2Y5SDDtslk/ILxqNm9+A5DNX5vMo2mZxft+zEYIzXfSiSqb
	 2iWcJQPjHbz/ljqyFJ4iKBSrgutc6B/ezmdcb9d0daUWHXtNYRzIeHj40rI2I4qkMR
	 clG2HGFp5vF6mkCpXGTdw+3cFmOCgbvl1OkUYd6oUvefug7uaHEtVZoDAlKB2gz4Om
	 xuyg6tGFA6OrrivMUcRvGklJegF2ShcnRJ5GPszZXK6pa8w86P4L/TAMrYKWWvz8pQ
	 0L2MIyBmAUr8Q==
Date: Thu, 10 Aug 2023 09:14:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, johannes@sipsolutions.net
Subject: Re: [PATCH net-next 00/10] genetlink: provide struct genl_info to
 dumps
Message-ID: <20230810091459.09d825ac@kernel.org>
In-Reply-To: <ZNSgOt91RerMMhXV@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
	<ZNSgOt91RerMMhXV@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 10:30:50 +0200 Jiri Pirko wrote:
> >In the future we may add a new version of dump which takes
> >struct genl_info *info as the second argument, instead of  
> 
> That would be very nice. I'm dreaming about that for quite some time :)

We can probably do it fairly easily for the auto-generated families.
I didn't want to do it now tho, because it'll conflict with your
devlink work and DPLL (assuming that one is actually close to ready).

