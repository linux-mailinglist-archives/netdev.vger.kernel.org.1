Return-Path: <netdev+bounces-85784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 630C689C1E8
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 15:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CCD1F210BF
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 13:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A805C74BE5;
	Mon,  8 Apr 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOc+zb/l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842F3481A6
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582432; cv=none; b=aEXeCk4X6HnHvyVli7tMWCRDDHtponXuDHSJnHmUXcwMHho5yGiRPrs4Xpw94iKqzB5ajaPgHCLGM9rvoCdQlO87CrRC2KsCFQQ7CZTchSS35NEO+n0lICrGNnFbv5vNs1LdTdN58pqjawExaR3yJ+rf9KcB4pmcVAa+S0+0Drk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582432; c=relaxed/simple;
	bh=vNAuXIyce2JHTrNXfllg7Kn1ghlKtENtu3NyeRa0ytk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlP2hW7RSHsoqb1qZGmBWmNK3FIHNy3/fGLBBKdyeRKad0jNkn6Up6/6LdiUA8RmlrwKyghjll0Ii/r3dG8+Q3nY0G8Ibx0nkKtCgYZbRThCbMswgLv++YLp+d6gfcJtdR7OAqlFywF4mzE/1tSlzkLkRgJ8WN7ldCRfRjTyDIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOc+zb/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D48C433F1;
	Mon,  8 Apr 2024 13:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712582432;
	bh=vNAuXIyce2JHTrNXfllg7Kn1ghlKtENtu3NyeRa0ytk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOc+zb/lc9MCZdd8DXfzOoAAPkL3tLHuVhqLlEESC9W9gYgrDHvfUs2BuSsTVVd5g
	 PV8MB4xQcEtgb8AeAAqFt6xfRYKwwn9vUEWx0P8VLPn9EdeXouZK5zckGA7bWPA3fx
	 FbMlSHDRycl2nD9UPaBngKehBdu/UZ0VkeGEmZ8hqF8CaKA60c040SNtb8Q/YBAcrQ
	 O+SU9CLbwykscTVrK9QS1m9lkRQuJUlqZzWyRyzxG5r0/p8bxBgYw3VroT6TIBpEL3
	 VQ7/sGTDIB0r0pDVV+Ukwa+zGBhv33cPX2he7stLIAarD2bP0X7FpLuvLrt7g/8Jpq
	 AsyhL/jbzXEJQ==
Date: Mon, 8 Apr 2024 14:20:27 +0100
From: Simon Horman <horms@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Fei Qin <fei.qin@corigine.com>, netdev@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net-next v4 1/4] devlink: add a new info version tag
Message-ID: <20240408132027.GG26556@kernel.org>
References: <20240405081547.20676-1-louis.peens@corigine.com>
 <20240405081547.20676-2-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405081547.20676-2-louis.peens@corigine.com>

On Fri, Apr 05, 2024 at 10:15:44AM +0200, Louis Peens wrote:
> From: Fei Qin <fei.qin@corigine.com>
> 
> Add definition and documentation for the new generic
> info "board.part_number".
> 
> The new one is for part number specific use, and board.id
> is modified to match the documentation in devlink-info.
> 
> Signed-off-by: Fei Qin <fei.qin@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>

Thanks, I agree this is consistent with the review of v2 [1].
And addresses the documentation formatting problem of v3 [2].

Reviewed-by: Simon Horman <horms@kernel.org>

[1] https://lore.kernel.org/all/20240228075140.12085-2-louis.peens@corigine.com/
[2] https://lore.kernel.org/all/20240403145700.26881-2-louis.peens@corigine.com/

...

