Return-Path: <netdev+bounces-236121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B51C38AC6
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 02:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A0DF3B3A1E
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 01:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C41E5205;
	Thu,  6 Nov 2025 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwB/N2Yq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DB525771
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 01:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391642; cv=none; b=WSksA05VbsTxziYvrRtE4VAQ/r7q/ZzhzSJDrna2/BAKfnSvge7xeqgJzqq+2A+jS0CknBCDOgk7AiP3/zTYHJTYQRMbuYOvBp75ac6R2+iNjizUIcuwqM9j4v1pRlSAOnWEJElneoMMv670ejouCk+DmnQSU7de1GHzuGR/uDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391642; c=relaxed/simple;
	bh=m0I2Yh/mAozxq8fZmhFrzoa8UihMX/OIX+S4aMq9Z2I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNcFXcBmP/F/UpbtcOMw1mmdmKstSpFvao+Cnihr+I08pAnDjRZnaWvBXkrpHGEhpcZ/eeQUe26REcnH+Fi/ATKGC+o/vRJnKoDClh5j5+rhnOuIUpPtJbogmsdc71X40YeFna4LPU8kHPwWMIE6rnqu5eU8xKJishFb4hIPGI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwB/N2Yq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D529C4CEFB;
	Thu,  6 Nov 2025 01:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762391640;
	bh=m0I2Yh/mAozxq8fZmhFrzoa8UihMX/OIX+S4aMq9Z2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AwB/N2YqDOoFkpSAukUHFbISQRYzX4H6L8sSUHfdlByygluEkyi44USxc1alt/iRw
	 YgAT6xvc80a6TjtvVl09X1xxgGWIxKjzcoElQ8KZ9kGB3fRaKzW6cgDTg99/BNW8Ww
	 kVEM5Da3TihZRxUoBHD2VKEqF8Ted0TsWy7pdumlX1fwKw8l0kkdBaVK05T7YLh3bP
	 wBZ91pTY1zy9xOV1en2BtJOdq57hNnXkZHWaOe4JER45FWsmz9zLA7pLhUStT6Zbha
	 xFAwTCb/wguspXb7AIKiIBxSPk1muuk/wqBVhyo/h9161azSqmz+GxpnFe+O7ZgeX8
	 YsGHWThYLbRlg==
Date: Wed, 5 Nov 2025 17:13:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Carolina
 Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next] netlink: specs: netdev: Add missing qstats
 counters to reply
Message-ID: <20251105171359.4f14b199@kernel.org>
In-Reply-To: <20251105194010.688798-1-gal@nvidia.com>
References: <20251105194010.688798-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Nov 2025 21:40:10 +0200 Gal Pressman wrote:
> Add all qstats counter attributes (HW-GRO, HW-GSO, checksum, drops,
> etc.) to the qstats-get reply specification. The kernel already sends
> these, but they were missing from the spec.
> 
> Fixes: 92f8b1f5ca0f ("netdev: add queue stat for alloc failures")
> Fixes: 0cfe71f45f42 ("netdev: add queue stats")
> Fixes: 13c7c941e729 ("netdev: add qstat for csum complete")
> Fixes: b56035101e1c ("netdev: Add queue stats for TX stop and wake")
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Spooky how something is broken for over a year and then multiple people
send a fix within 24h! Please TAL at:
https://lore.kernel.org/all/20251104232348.1954349-2-kuba@kernel.org/
-- 
pw-bot: nap

