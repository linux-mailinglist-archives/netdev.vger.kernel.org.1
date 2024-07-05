Return-Path: <netdev+bounces-109507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D72F928A2C
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D85B20E64
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DA714D2BD;
	Fri,  5 Jul 2024 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU4vGT7l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1EA1459E8;
	Fri,  5 Jul 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187551; cv=none; b=XiSz6Ew3K9zSLzTpF2BPZIr+SZ+lgm3c4+TUrOG39yre49B1nMiTBKq3CBeG8gJGilwp/7OZKAVPOYswZl7J2AFbozW8OTAZPxvbS+X7lnmGd9yN517AL90/slpd4dn/Enj0+Pfav7csCekSzEFDf3gsBX9+oDdWyOwweKhoxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187551; c=relaxed/simple;
	bh=zHOmR3ohyqySYFOG1WIA+pdxn3UvOcPcAoVTb6xF9Hc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMnr63VOS4vcVSlYBki/lJDMAQnBCYtZcN7cjVTeT+j6a8JVr6cwCCRUu+8kxKmw0ANMRigbFinFcvIVbQnlOOUTgzsiq457045oqA/XjXyqoZ/aL2J6sa+iQosP2n0niLCxGPmBjYVjjUq4yqtNxff1EOVF6HTb6Ty0/fqpd9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU4vGT7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF731C116B1;
	Fri,  5 Jul 2024 13:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720187550;
	bh=zHOmR3ohyqySYFOG1WIA+pdxn3UvOcPcAoVTb6xF9Hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QU4vGT7lOvIw+z06/40oZMvb7TIYA9SpS0F54YGHyx6UuQ5+aRiAN/VdfCIiTH/DA
	 y9ukllG0RbAcJquFZmMcTYeYex4kujdAiaAtuPYMXDlAROtj/kkblotAGG3AI+W4oC
	 TEUev7z4mdRjOOz97rAitTHWbzFjIfniZ8JvvpnrFbp31fCTqZEupPWWPbGU+r67EI
	 4v6aXPwOaPa+eMqsPY/bEKReRNlt8pOpQX9Vu9ROdgA21T4KCBSSc3p7hjstwvhasc
	 ZmtRSG8Uz8Pj3hW7WSOfsa4AfAz+8cQXEIyCX5g69uYBa6xh121c33A5wdZaOYIw+F
	 gJD/keep7RJXQ==
Date: Fri, 5 Jul 2024 06:52:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn
 <andrew@lunn.ch>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 5/5] netdev_features: convert
 NETIF_F_FCOE_MTU to dev->fcoe_mtu
Message-ID: <20240705065228.2bbc69de@kernel.org>
In-Reply-To: <f5754d0a-1640-4d20-95fd-a2d74dfcc084@intel.com>
References: <20240703150342.1435976-1-aleksander.lobakin@intel.com>
	<20240703150342.1435976-6-aleksander.lobakin@intel.com>
	<20240704191646.06bb23c8@kernel.org>
	<f5754d0a-1640-4d20-95fd-a2d74dfcc084@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jul 2024 14:45:50 +0200 Alexander Lobakin wrote:
> IOW, FCOE_MTU was always hitting dev->features previously :>

Ah, missed the ALL_FCOE thing, may be worth deleting it since
it's used only twice in the tree :S

> Re rebase due to 1/5: yeah unfortunately, but that happens :D
> I'll rebase and resend on Monday.

Thanks!

