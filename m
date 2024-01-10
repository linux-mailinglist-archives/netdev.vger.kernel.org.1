Return-Path: <netdev+bounces-62915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B97829CC9
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 15:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E387EB20E11
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 14:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5536A4B5CA;
	Wed, 10 Jan 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uz/J4XOQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF553DBB3
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 14:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E692C433F1;
	Wed, 10 Jan 2024 14:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704898136;
	bh=rk8Axf3USLU3Fv123qBGVF2rmis5ZkbTHP+p1ccbdbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uz/J4XOQRkwtsJLsPbAR3gWMW+mRhGrolzqaV97J7mwgzO6q4B61MGGX0690R521h
	 N8dCCzc+AOByaBeQ6pjd53zpuy/g1VwEcFz5IDokHP8cPHIALQjJGVl5/AbiddM+9g
	 zBKXR1TzLjOkuZ2cuKlJFgug9T1MjytXsfhvoSwA0czNnZVn21XYEJxnb+4bDmoVv5
	 ZmpXOrsazwxGHIm6KW65jd71rtwrsJvt+1i7X2GUVvWYsf3UXD9HiH+YaDyCneLpji
	 9QIMWlATC9e+iZY47AtwUDhsUCCd2xgSESgv7z+n2KAwUFfcTh4B6st2q2D5d+G9q/
	 +fEiXVRXD0wgg==
Date: Wed, 10 Jan 2024 14:48:51 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, John Crispin <john@phrozen.org>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH net 1/7] MAINTAINERS: eth: mtk: move John to CREDITS
Message-ID: <20240110144851.GC9296@kernel.org>
References: <20240109164517.3063131-1-kuba@kernel.org>
 <20240109164517.3063131-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109164517.3063131-2-kuba@kernel.org>

On Tue, Jan 09, 2024 at 08:45:11AM -0800, Jakub Kicinski wrote:
> John is still active in other bits of the kernel but not much
> on the MediaTek ethernet switch side. Our scripts report:
> 
> Subsystem MEDIATEK ETHERNET DRIVER
>   Changes 81 / 384 (21%)
>   Last activity: 2023-12-21
>   Felix Fietkau <nbd@nbd.name>:
>     Author c6d96df9fa2c 2023-05-02 00:00:00 42
>     Tags c6d96df9fa2c 2023-05-02 00:00:00 48
>   John Crispin <john@phrozen.org>:
>   Sean Wang <sean.wang@mediatek.com>:
>     Author 880c2d4b2fdf 2019-06-03 00:00:00 5
>     Tags a5d75538295b 2020-04-07 00:00:00 7
>   Mark Lee <Mark-MC.Lee@mediatek.com>:
>     Author 8d66a8183d0c 2019-11-14 00:00:00 4
>     Tags 8d66a8183d0c 2019-11-14 00:00:00 4
>   Lorenzo Bianconi <lorenzo@kernel.org>:
>     Author 7cb8cd4daacf 2023-12-21 00:00:00 98
>     Tags 7cb8cd4daacf 2023-12-21 00:00:00 112
>   Top reviewers:
>     [18]: horms@kernel.org
>     [15]: leonro@nvidia.com
>     [8]: rmk+kernel@armlinux.org.uk
>   INACTIVE MAINTAINER John Crispin <john@phrozen.org>
> 
> Signed-off-by: John Crispin <john@phrozen.org>

I am curious, did John sign off on this?

> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Other than the above, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

