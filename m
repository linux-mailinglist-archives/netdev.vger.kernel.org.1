Return-Path: <netdev+bounces-80379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A797D87E8EA
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 12:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A681C2132B
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 11:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB38374E9;
	Mon, 18 Mar 2024 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceIU248m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C61C37140
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762676; cv=none; b=bxBMTuCFIZbmL452FYbF3vyqhMfqYRGZtj7y/ke80qZHoXFW2MwUQjqwi5dj2yqukSfuljghooQDTj7Jnjw1G0Qjp4CpoGYZ7f15200DMsDM8oxaAvQvRm5W+PNcuXfQJ2YByOg94zoRlZvo8YEDG2DTJCyI6volMgMq3NMi47o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762676; c=relaxed/simple;
	bh=W2TvEngorAH11D/4d2K+sna8uBmYKbVqmqFM3AoTR0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPWaBaQS14lk+ObG73G7ojDfrwr2G2ZGcS+G5n8edjuNwybNBqFvWY4c2Ln4fEK+fvIsYFG9JLEcnLZql564O7AfgOFloFrxxCFw/JGxmr6IpatBUbnYhIxgNu8EtShZcQ26TWpdpwe716gVKvx7P1gFGoHFx6nj95K9+IMO9eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceIU248m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460B9C433F1;
	Mon, 18 Mar 2024 11:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710762675;
	bh=W2TvEngorAH11D/4d2K+sna8uBmYKbVqmqFM3AoTR0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ceIU248mAgZLowUBkbXJWZZmggkHf/PPeH04CCCat/gIKHzNTQhySybiQsNmkEHYD
	 A4PbD1SC9BHnyxBd+NwY9ae5CRkNjPs6cpzlD8KweQ8q9Ec7VKE4ROZMYVWt1wPFRX
	 zGa8RcjnM09RoVLcOYh3JLH33G3aY6duFxpXyjaxQnZ2n/amem4sxm05tcGjNLfYez
	 i/MhTvxrvwQRTjklaZrUvUtq93k/FY5TYEH0t3CRrgGsvJV/fpqOtukQPnB9RrgUVh
	 o/cHDr+zaNhaMJEtv1woE+eLhewKu23f+8fdjq3UqR2nAHJv6ZbnFFLtC2LW9OkIkD
	 O1HXPLeiz5O+w==
Date: Mon, 18 Mar 2024 11:51:11 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, dev@openvswitch.org, jiri@resnulli.us,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [ovs-dev] [PATCH net-next 2/3] net: openvswitch: remove
 unnecessary linux/genetlink.h include
Message-ID: <20240318115111.GC1623@kernel.org>
References: <20240309183458.3014713-1-kuba@kernel.org>
 <20240309183458.3014713-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309183458.3014713-3-kuba@kernel.org>

On Sat, Mar 09, 2024 at 10:34:57AM -0800, Jakub Kicinski wrote:
> The only legit reason I could think of for net/genetlink.h
> and linux/genetlink.h to be separate would be if one was
> included by other headers and we wanted to keep it lightweight.
> That is not the case, net/openvswitch/meter.h includes
> linux/genetlink.h but for no apparent reason (for struct genl_family
> perhaps? it's not necessary, types of externs do not need
> to be known).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


