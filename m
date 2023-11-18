Return-Path: <netdev+bounces-48961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 293B27F032C
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 23:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6451F22462
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 22:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170041E531;
	Sat, 18 Nov 2023 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVadxAym"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D3156FD
	for <netdev@vger.kernel.org>; Sat, 18 Nov 2023 22:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F40C433C8;
	Sat, 18 Nov 2023 22:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700347847;
	bh=uQ/ZSMcPli58vrb2wZICC9Grz2rXBkOrQowxrcXgkO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AVadxAymdMxzQOCkCvQNww/5PBBPuoRgATXpsklBGLOebAkssLi332HEOy35Wec8i
	 b9cpyaf6Po7KG2unaQ/Zx1JMKN6vTOyXVrfxcbg6le6lZOXggwqJa2GZzwmBzZRBjV
	 dt7FkjEOJnbBHezfTyQBE1TN98HILGaQaW0MyjAe1jY/q/EBHZ+MEYYsdh9hyD6Osq
	 dZplJYKsGZzzesycWyKVuzxoDdTfrHBd1MD0/cBKNAueid3ty9M2e1nppWIOlvlm+v
	 9e/9xFfxbyzMAHJu3dGTKj7VMvt3slTHvgnlcTm981hek7dGv61L95i7bT9Ip8pRnK
	 +ObAfK5ZGSQqw==
Date: Sat, 18 Nov 2023 14:50:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
 <pkshih@realtek.com>, <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v11 05/13] net:ethernet:realtek:rtase:
 Implement hardware configuration function
Message-ID: <20231118145046.7bb8efca@kernel.org>
In-Reply-To: <20231115133414.1221480-6-justinlai0215@realtek.com>
References: <20231115133414.1221480-1-justinlai0215@realtek.com>
	<20231115133414.1221480-6-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Nov 2023 21:34:06 +0800 Justin Lai wrote:
> +	.ndo_vlan_rx_add_vid = rtase_vlan_rx_add_vid,
> +	.ndo_vlan_rx_kill_vid = rtase_vlan_rx_kill_vid,
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +	.ndo_poll_controller = rtase_netpoll,
> +#endif
> +	.ndo_setup_tc = rtase_setup_tc,

This patch is still way too huge. Please remove more functionality 
from the initial version of the driver. You certainly don't need VLAN
support or CBS offload to pass packets.

