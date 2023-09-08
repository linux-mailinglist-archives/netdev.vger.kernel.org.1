Return-Path: <netdev+bounces-32510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FF0798107
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 05:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C391C20B43
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 03:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F6F137B;
	Fri,  8 Sep 2023 03:44:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241D8111B
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 03:44:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28373C433C8;
	Fri,  8 Sep 2023 03:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694144691;
	bh=NO6h5OcHwHsI0o1lcWAQvbgEh5BLlbaPObg41/h+1VE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ms53MSfrw40om2BbrDYkVeylRGWZ69/gSBVDp9HobzwJjjyMThAQs7FZCn07G5cwf
	 CWegrmdW/vdYNPcooCasjlFz0fxYKJNupgk9C7eleq9hsUaHMCaKoHwlhpQv0T8YUw
	 J8VUmRpyEClm7gIcX6CoJ4dSytflHEYoWUoLiqevMjxpc3MLCtkZaNqnAEzLE6psEB
	 bGTNCmW/bxL5AzHB9sBAAnd2/92+Ldh0xxk+64rGPMAz/1HMnn93KsQpyAP511lWhl
	 yE/dGaz0UhU7Y+uaFsmzIS1l1wwxuWzTkbOKRR0y6AuEh9n/tqj5IotZIHspDujHMq
	 c6ovhaxJEjmiw==
Date: Thu, 7 Sep 2023 20:44:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: <piergiorgio.beruto@gmail.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <andrew@lunn.ch>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
 <Nicolas.Ferre@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
 <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v2] ethtool: plca: fix plca enable data type while
 parsing the value
Message-ID: <20230907204450.6b9e63df@kernel.org>
In-Reply-To: <20230908140346.40680-1-Parthiban.Veerasooran@microchip.com>
References: <20230908140346.40680-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Sep 2023 19:33:46 +0530 Parthiban Veerasooran wrote:
> The ETHTOOL_A_PLCA_ENABLED data type is u8. But while parsing the
> value from the attribute, nla_get_u32() is used in the plca_update_sint()
> function instead of nla_get_u8(). So plca_cfg.enabled variable is updated
> with some garbage value instead of 0 or 1 and always enables plca even
> though plca is disabled through ethtool application. This bug has been
> fixed by parsing the values based on the attributes type in the policy.
> 
> Fixes: 8580e16c28f3 ("net/ethtool: add netlink interface for the PLCA RS")
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

One second look you need to fix the date on your system and resend.
The patch came to us with a date 24h in the future it will confuse
patchwork.

