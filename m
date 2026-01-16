Return-Path: <netdev+bounces-250410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF43D2A82A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DDCB3003B0C
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFAE325739;
	Fri, 16 Jan 2026 03:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1QYiDqK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF21930EF85
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 03:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768532747; cv=none; b=aPN6GNWct6KKXZbmPW50W1zp7gfVCiNCpYJa6ThnSSw6Vw4l7EiWi012IwO2vl9UxYqLtJsI1sqzhe8WkjoqqhyKwMDeZT6xy92QRFCLQhHPzeLmF88CWOA14XlRLGAMW/T3AfD/6oKmGHQncpyL/AvByWk6EKfIQ5BpLTLKD8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768532747; c=relaxed/simple;
	bh=U3Aoti0YPoxifwNh7V0YYpw1gTTxaBib3ervHQ0XypE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKTQaFjh907ntmI+enmhiRhQpZffegyPO2PCuX7wm++g7rfXgpnW0pLczzwkvi2pS7f90o5ABmrdn4wX2VbYvA00iWaY5ylij0AVjobzIJTKB1LEBkLXxPTwFEZ3UY3Hucbajv7W5mSoCUcPLwW4ooJiHezU9MD6Haqjc/NS/XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1QYiDqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA59C116D0;
	Fri, 16 Jan 2026 03:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768532747;
	bh=U3Aoti0YPoxifwNh7V0YYpw1gTTxaBib3ervHQ0XypE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L1QYiDqKnDOSSq+xNu+85WqFwC8Qoq9llFdwS+6br3L3Q5qGCwSBH4tzlpuO3mq3r
	 vaEOV8686ZZIri8oA4Plxr8THRmQ6eDgQHLdKqOoGFF2BrIk6eOieq1eiChchXjgAE
	 ND1QawHZH0QXhocxN9ghOzjhfneolngOFAQMz6fg0slaJUtuiMZLk7PnFhHoZkJ7Tm
	 3wUSihRl3EyFF5DahJf+HsOKeV7ufvwsJ44HfcS9VcYQYRHdeOm7IR4w+ouPDkIUG4
	 sMH810M6wuXKRoJEovwOxYpa2C3grmqrC5EPFCP2x8zuUc7moPv5lg+OVTZ+vQQ6V+
	 +R/3912fAVxfQ==
Date: Thu, 15 Jan 2026 19:05:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Sayantan Nandy <sayantann11@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, sayantan.nandy@airoha.com, bread.hsu@airoha.com,
 kuldeep.malik@airoha.com, aniket.negi@airoha.com, rajeev.kumar@airoha.com
Subject: Re: [PATCH] net: airoha_eth: increase max mtu to 9220 for DSA jumbo
 frames
Message-ID: <20260115190546.5ede6750@kernel.org>
In-Reply-To: <aWjuM3Ov0e45QyW4@lore-desk>
References: <20260115084837.52307-1-sayantann11@gmail.com>
	<aWjuM3Ov0e45QyW4@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 14:40:03 +0100 Lorenzo Bianconi wrote:
> > The Industry standard for jumbo frame MTU is 9216 bytes. When using DSA
> > sub-system, an extra 4 byte tag is added to each frame. To allow users
> > to set the standard 9216-byte MTU via ifconfig,increase AIROHA_MAX_MTU
> > to 9220 bytes (9216+4).
> > 
> > Signed-off-by: Sayantan Nandy <sayantann11@gmail.com>  
> 
> I think the patch is fine, but here you are missing to specify this is v2
> and this patch targets net-next. Moreover, please wait 24h before reposting
> a new version of the same patch.

FWIW this is a good reminder for Sayantan for the future but it doesn't
merit a repost in itself. net-next is our default tree, and pw bot
guessed correctly.

That said I think Andrews request warrants some extra testing here so:
-- 
pw-bot: cr

