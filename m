Return-Path: <netdev+bounces-48725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C57A7EF5AB
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB282B20D77
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9286C374D0;
	Fri, 17 Nov 2023 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRlhr0T5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CE73EA9F
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:49:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460DFC433C9;
	Fri, 17 Nov 2023 15:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700236192;
	bh=6SVY0aMH1WAIf0KAc5EHiUa86al8lOCFuBowgFikakc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRlhr0T52qHQpbiQEK3SgJjZTBrVyYsTOI5PGpBnVGi50v4Xw5BzQy+HOKDEJXehy
	 Qo4GNFDxS3ipFV8LN2HTL/2gtAZf39LJ7v1R+1oSmj+n1XWafErZ3hsuDwBe2U1zcW
	 TYOruABs6MFJayy10wtUmIahPZWoC1rGBkIbyLB95OHPp9xznRWiwYh1xbIoRJp/Uh
	 Srhb4fljM8ayVwkjnzPmBiUHjzdLCRPhJorb3jQ5pGbwOsrUdEDeW52HJy1E18zm3J
	 jFJAVwJhKICXuK7FK9vg5tJzPM0viaut89JKMuJWeso+1zoZzj1Wv1jI9kmW4O87Dg
	 FnFmJOpHxkM7Q==
Date: Fri, 17 Nov 2023 15:49:47 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Amit Cohen <amcohen@nvidia.com>, mlxsw@nvidia.com,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 03/14] devlink: Enable the use of private flags
 in post_doit operations
Message-ID: <20231117154947.GG164483@vergenet.net>
References: <cover.1700047319.git.petrm@nvidia.com>
 <63d7e04fdfaf44a33d683270d95627afbf90e932.1700047319.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d7e04fdfaf44a33d683270d95627afbf90e932.1700047319.git.petrm@nvidia.com>

On Wed, Nov 15, 2023 at 01:17:12PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Currently, private flags (e.g., 'DEVLINK_NL_FLAG_NEED_PORT') are only
> used in pre_doit operations, but a subsequent patch will need to
> conditionally lock and unlock the device lock in pre and post doit
> operations, respectively.
> 
> As a preparation, enable the use of private flags in post_doit
> operations in a similar fashion to how it is done for pre_doit
> operations.
> 
> No functional changes intended.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


