Return-Path: <netdev+bounces-50549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D887F6136
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 15:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19FEF2811C5
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD0C25555;
	Thu, 23 Nov 2023 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZOX9JDG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A9E24B3F
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 14:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF00C433C8;
	Thu, 23 Nov 2023 14:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700748943;
	bh=cn1OsqYFTsylZVMslrnd3ANfGwXOvdHCP4pfppPKtIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZOX9JDGnIkYV+Vag/ge9kKg8XhDt9s4msFj1lQ0o5PfSAWBP//IjfkEK/ZQGHwHH
	 lfKZINRHsxJGfAbRCiKVcwupU/t+YMQbC+4CVUO5WYBzXGzUH6LmcGrhOGrcrykSWn
	 64AutOAPxgVLUGfSDOJRoYfZJiLWqavVD5HwCSuS41AS0xk0avBgfOOQQVd/UfjWHh
	 W6pcxbfznfe/E93YY8H3scQoLwOnXHKRt4BVBZeap2TeAMbm2ZSskj7GdWHo91GhUL
	 GJktAEhjx8DOEHvTaO1tdYuvW/aP7jitz6Tui7U2MwsIj0qrdXKFX7Joxy73aAvc/E
	 lZ7xTpWO5LpkQ==
Date: Thu, 23 Nov 2023 14:15:39 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Nov 21st
Message-ID: <20231123141539.GF6339@kernel.org>
References: <20231120082805.35527339@kernel.org>
 <20231121160542.GA1136838@kernel.org>
 <20231121091106.02e51d0f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121091106.02e51d0f@kernel.org>

On Tue, Nov 21, 2023 at 09:11:06AM -0800, Jakub Kicinski wrote:
> Thanks to everyone who attended!
> 
> Notes:
> https://docs.google.com/document/d/12BUCwVjMY_wlj6truzL4U0c54db6Neft6qirfZcynbE/
> 
> I forgot to mention one thing:
> 
> The "cc_maintainers" check in patchwork has been improved, it will
> now ignore emails which we haven’t heard from in 3 years (1 year if 
> the author and missing CC emails share the domain).

Excellent, IIRC this was discussed at Netconf.
Let's see how this helps.

