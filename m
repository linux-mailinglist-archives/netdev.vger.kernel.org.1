Return-Path: <netdev+bounces-28941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2EB781325
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 20:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D992F28250E
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4631B7E5;
	Fri, 18 Aug 2023 18:57:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7619B1BB23
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 18:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFADC433C8;
	Fri, 18 Aug 2023 18:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692385033;
	bh=dmotTUBvB7CUFjLCtFY0R8RrgsJW1Rsf5697zp0LqBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIA0g2G4hGoYBMV5p7sHZmVI8t5aHjGKZu51BlKH6TwmMcdb82DZNOhzT+dpsBZOp
	 htY7DwFgakpLUt3OrgQ7zlLQaPoJegkmtFJiIaMFneiq7lq/WrrvQs/maLceBp66z9
	 EgnO5j6wvrpdSXrEvC2pQEdfXhxEe2VKh+tNeuPDEBcYV1kASwP84/eUYENMJT6+Zw
	 L1fDpm53/vlBE0FR2M20hAI9/HkaxK+wOyiC1OgzrqxCXb3Juw2fTXMXlhiUcU1ZYy
	 0dVPrZD1dvnNPyorpmaSeIccaf3zIE1liAclulpscw415y91cJPPDo5whszkLUL0YZ
	 /Q1h6v/trX9aw==
Date: Fri, 18 Aug 2023 21:57:06 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, opendmb@gmail.com, florian.fainelli@broadcom.com,
	pgynther@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v3 1/2] net: bgmac: Fix return value check for
 fixed_phy_register()
Message-ID: <20230818185706.GJ22185@unreal>
References: <20230818051221.3634844-1-ruanjinjie@huawei.com>
 <20230818051221.3634844-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818051221.3634844-2-ruanjinjie@huawei.com>

On Fri, Aug 18, 2023 at 01:12:20PM +0800, Ruan Jinjie wrote:
> The fixed_phy_register() function returns error pointers and never
> returns NULL. Update the checks accordingly.
> 
> Fixes: c25b23b8a387 ("bgmac: register fixed PHY for ARM BCM470X / BCM5301X chipsets")
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v3:
> - Split the err code update code into another patch set as suggested.
> v2:
> - Remove redundant NULL check and fix the return value.
> - Update the commit title and message.
> - Add the fix tag.
> ---
>  drivers/net/ethernet/broadcom/bgmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

