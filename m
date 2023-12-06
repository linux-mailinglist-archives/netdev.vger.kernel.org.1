Return-Path: <netdev+bounces-54492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 766AE807486
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 17:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2769B1F211C5
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 16:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7BD4644F;
	Wed,  6 Dec 2023 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lU+BbgYg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FEB45C07
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 16:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E08C433C8;
	Wed,  6 Dec 2023 16:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701878772;
	bh=vwrPo6C+GvGv+sbHewNPX/1/OUd6kBvQMn/2KqnHel8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lU+BbgYg2IE0aLbJlELU7tYn3OPLJbqCY4T7BZBuStoVN0LBpRlsQnG5+I5x7hdJ7
	 61+sCQj96bP+tbqn6qQngK6f317uPtNzwCfeiWzmJsyY4e1wKs1eNzgVDTDx/usYBQ
	 l9cue29SoinwLvjLL8EkW/IOpWdV6/jCiazOiWZc6vTY9tQKImjp11D0/kaZZuiIBo
	 Nc4iznv95R3E6wpMpphd9QKTLhsTjHj2xGuAKAQnNnBUgoQ0aEZicgYrJ6TkOi7E65
	 aRIBLm/fP2QN4jPf4ll6ZefyXTQ3lbMKzVPSzYGA+VAzygwcNMbUP6K7/Kj5U0OWuL
	 +t05nCyq1AIdA==
Date: Wed, 6 Dec 2023 08:06:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v5] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <20231206080611.4ba32142@kernel.org>
In-Reply-To: <ZXAoGhUnBFzQxD0f@nanopsycho>
References: <20231202123048.1059412-1-swarupkotikalapudi@gmail.com>
	<20231205191944.6738deb7@kernel.org>
	<ZXAoGhUnBFzQxD0f@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Dec 2023 08:51:54 +0100 Jiri Pirko wrote:
> My "suggested-by" is probably fine as I suggested Swarup to make the patch :)

Ah, I didn't realize, sorry :) Just mine needs to go then.

