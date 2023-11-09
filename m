Return-Path: <netdev+bounces-46901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F01F7E7015
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 18:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F13280F94
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AE5208D5;
	Thu,  9 Nov 2023 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rym9sDWV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2DC22329
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 17:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73749C433C8;
	Thu,  9 Nov 2023 17:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699550680;
	bh=4AC7xT8UfVmqEObBWK/O+N39jg5BZfkGx+4KZmKJrHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rym9sDWVnkkWjGGZyy+H39XZaTrYcXcpoiZg9wuG/szqZ8cZw275MzN9jE7soVGBY
	 65//GD6PRHsGfXQ9Kxyt35HscJt8xkXqQTE/bFBn2ltjgV6ZyDhmL1Lpi2iIDr7MIr
	 mK5gj688SwvNy42ngYM9Sjp9yO/AdJP81gD/iERBSmUgl57sH95yhH3Bkcz4zoxttD
	 PZ6ipcTClSB9G4R1l0EZVLsOXA1Ye1PFYkRiJxKmYcnoLYTG/G1H7uP829tlfYSXlF
	 3S0yt2OXYjg6JplCT1szHCo+CycIOKkcSs3iHbHGL+DdX7iZaXO8MJhacKf/xIxVhL
	 obWueYElGUBkw==
Date: Thu, 9 Nov 2023 12:24:37 -0500
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH iwl-net] ice: Restore fix disabling RX VLAN filtering
Message-ID: <20231109172437.GA568506@kernel.org>
References: <20231107135138.10692-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107135138.10692-1-marcin.szycik@linux.intel.com>

On Tue, Nov 07, 2023 at 02:51:38PM +0100, Marcin Szycik wrote:
> Fix setting dis_rx_filtering depending on whether port vlan is being
> turned on or off. This was originally fixed in commit c793f8ea15e3 ("ice:
> Fix disabling Rx VLAN filtering with port VLAN enabled"), but while
> refactoring ice_vf_vsi_init_vlan_ops(), the fix has been lost. Restore the
> fix along with the original comment from that change.
> 
> Also delete duplicate lines in ice_port_vlan_on().
> 
> Fixes: 2946204b3fa8 ("ice: implement bridge port vlan")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


