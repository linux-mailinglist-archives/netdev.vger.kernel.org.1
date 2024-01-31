Return-Path: <netdev+bounces-67660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9290F8447C4
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 20:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44D1C1F2356A
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 19:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A1717C8B;
	Wed, 31 Jan 2024 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZ5a1aAU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21CE37143
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706728013; cv=none; b=NXcaCQHm1nB811FQDKoaFzUxmUFrhcQOY8zHcitadwgxRm28ufPWcTFefswzTLRcFQquT+ak5/GGXpwC8P6UxjGw89PLo2orAXhAJBduiAVHVmsy55kBekIMMmLCEEGae/WS9Xe9lC3iMIHhVbYzh+4ivHIaATrPpHEsMPZnelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706728013; c=relaxed/simple;
	bh=jR/s2oa0Po5BoTe2bIZqIC5axwRStRI8eosb65KN1S8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHNxaG6wk6rlbV1IcwE+Wh7st8gxhITcs1mxvOeIzdoqHkBJKkpKB2Rn4tX+1PWZ+jyVqEEqwNZcRK++J9PaKCfvkoxRR/jckX+8c/255aJt3Dz+dhi3lD6xBK7t2gqz4Ja4MFIDNoIbl/IqY62N8tQ10Gb438pLVngLJ9jDPdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZ5a1aAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B81C433C7;
	Wed, 31 Jan 2024 19:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706728013;
	bh=jR/s2oa0Po5BoTe2bIZqIC5axwRStRI8eosb65KN1S8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eZ5a1aAUEhyFxtrT6gVspxZiAtKbSvA1XLwKio7Hek8skTTyJHM9o245fO0nl7vqx
	 T+UEJKCEnoShELMO10SMHF2U5l/Y9SvUBp5VZOW9M/hiF1u41ae74j456OiWdY1keQ
	 Ljavcs8O7xFcY5hSUXU5LGoWupg8ZS78xjsEk1ieDuq8PgcIIBhafTZ/kdYU0m9Q7s
	 u4O7h7lRv8fetHH1FlN8+Czh+aK+63fYM2HLtoXqRlKKclMDDowaYU5pu5HZkAvM9B
	 WTK/51klxTdgeg95sZpIzEtHvefBS8fstGd2T8OtmmoedDyKMdF71tr0PXMEZ+K5kS
	 yXzxqpjnEtmsA==
Date: Wed, 31 Jan 2024 11:06:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: William Tu <witu@nvidia.com>
Cc: bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
 saeedm@nvidia.com
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <20240131110649.100bfe98@kernel.org>
In-Reply-To: <748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
References: <20240125045624.68689-1-witu@nvidia.com>
	<20240125223617.7298-1-witu@nvidia.com>
	<20240130170702.0d80e432@kernel.org>
	<748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 10:47:29 -0800 William Tu wrote:
> > Do you only need this API to configure representors?  
> 
> Thanks for taking a look. Yes, for our use case we only need this API.

I'm not sure how to interpret that, I think you answered a different
question :) To avoid any misunderstandings here - let me rephrase a
bit: are you only going to use this API to configure representors? 
Is any other netdev functionality going to use shared pools (i.e. other
than RDMA)?

