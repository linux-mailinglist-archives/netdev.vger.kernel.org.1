Return-Path: <netdev+bounces-160269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC39A191AA
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773AC3A3634
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABE7212B37;
	Wed, 22 Jan 2025 12:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmmQX8kJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8588211A31;
	Wed, 22 Jan 2025 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737549893; cv=none; b=nvh77iOs16flfPm3GIyR7l1c/JISFJsHK84z4qmHlFeK1walOhUZxNjw09Pdy0NXxrvuCIHCUh23UJ7LTcRVRvGxvpfuHn4xMJzNXmr23a1/E291D6puYZd5fdl9IbL496rtUfk7JeowgXY8IqSEmEwrE+ysAQ7bq4QRAAYGChk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737549893; c=relaxed/simple;
	bh=mYxble0FKSzz/PM6/HiudFNcDeaSAlhim+xaZQ+0ZeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8Fp9Aw4ZLvqgSwTNTrvyxtqliFAjLSSvN73v7Z0sH/B3cMqQ/TWWiPxaTyeP6NI3snMPdCbSmV4KZinyVRwcIBx3RpDQ8ryGvz502W6BmV+az7ND0ZMOCUXAxUqJEFjabzmUQMdEJr6/4pqf57DbhZnRGUz6x4C/YeHkRW7c2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmmQX8kJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1153C4CED6;
	Wed, 22 Jan 2025 12:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737549893;
	bh=mYxble0FKSzz/PM6/HiudFNcDeaSAlhim+xaZQ+0ZeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VmmQX8kJ2POQjGKy5HhUu7vCm1c1mGZPoHagUpfhprWla72zHwOspYhnZbWWdVH+A
	 PnInCWRCeQV0VQ2sLyMu+hdQbBNBwqYC3fIfm2/SHNl7ndwbPHKxxsLuBBAygns1FZ
	 Ge4I9v+0tki+NzKNRhmhVtCEdF764hVlm6RFSOIDTZXU5CwkRB/5jXvMb+GQQ0gDDV
	 flZET4E8+ycAm49GjMoujLJbiMUOqg9MTIqFgFZ1hqGQ1Awh0VtDPhQao8qzv9hlhL
	 peb2qVmItF01N/uTQYsjBI2Pb4pPiFShDjnQiJKKlBbuc/JH99eRiZzex0/SXzu5iv
	 /YRSSgPSstnjg==
Date: Wed, 22 Jan 2025 12:44:49 +0000
From: Simon Horman <horms@kernel.org>
To: Yeking@red54.com
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: the appletalk subsystem no longer uses
 ndo_do_ioctl
Message-ID: <20250122124449.GC390877@kernel.org>
References: <tencent_D0DC3D8CD6217FA0CFAFEDE53F27810DB408@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_D0DC3D8CD6217FA0CFAFEDE53F27810DB408@qq.com>

On Tue, Jan 21, 2025 at 03:38:47PM +0000, Yeking@Red54.com wrote:
> From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> 
> ndo_do_ioctl is no longer used by the appletalk subsystem after commit
> 45bd1c5ba758 ("net: appletalk: Drop aarp_send_probe_phase1()").
> 
> Fixes: 45bd1c5ba758 ("net: appletalk: Drop aarp_send_probe_phase1()")
> Signed-off-by: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> ---
> V1 -> V2: Add Fixes tag

FWIIW, I don't think a documentation change qualifies as a fix, and thus
should not have a Fixes tag. And as a documentation change, with no runtime
effect, I'm ambivalent regarding this being net or net-next material.

In any case, the change looks correct to me.

Reviewed-by: Simon Horman <horms@kernel.org>

