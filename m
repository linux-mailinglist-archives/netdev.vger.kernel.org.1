Return-Path: <netdev+bounces-32442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62699797955
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 19:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926881C20803
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CDD13AC4;
	Thu,  7 Sep 2023 17:11:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49346D22
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 17:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF73CC43395;
	Thu,  7 Sep 2023 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694106681;
	bh=WV4Py0hrKsYJ5YuvXOJr89R6yNHUMJy3lSQ0F64mriM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SfhLXvred1rxlSf8SQWcbPjbGhptNWzXi/KGC42x9ZjEjFjYMoKZDD+npIJdmleQc
	 j90ahKEPtTFIGbzbt+SOS76LPXv+lPA1cjIhQzHsSTov0bj14LntnG9H6xgVIvvF6y
	 CUgWUPO/Lgdu1c6dUxrrWzwwyKLkIC2KfhTrmygqG4LaTqr242/KNfsNAiPWiI+5sw
	 NXBbfo/J+ebojlsUkIOh8YiUAruuXrNnN7hO4l7vmwMzkx/9Jhqq0SkjrPcmdpVaGt
	 ZG0MpKy9CsIoEG8UZZKGdHvW2V6i+30Bay6vBwvhxDRg92kxm15xZzkrprI+97NxxY
	 4hLODE177TnUQ==
Date: Thu, 7 Sep 2023 10:11:19 -0700
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
Message-ID: <20230907101119.3e5a5dc0@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

