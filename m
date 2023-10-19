Return-Path: <netdev+bounces-42506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB377CF02A
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 08:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A581B20DBC
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 06:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2873465C;
	Thu, 19 Oct 2023 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p382420D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0770E8F49
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15ECCC433C9;
	Thu, 19 Oct 2023 06:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697697447;
	bh=Y3hYUjPnYSdEpl04Dd6goNmE7HdP1OIA87Z6D8VoM6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p382420D05s74IJRLfvRTylYPf9zQa3pHT+Fn5897b1XY3V6fP0ZnQaLzl0cKxJwV
	 vD2liDu+NXz5BNHjYgmZ3Hi39YDpBbUFsl3xJUFanniwnSCzTa2KUuqqNRhyzblzOx
	 Z5CpnJu/xRZcxVDKZxpaog0+sgRnLfeXtdsAx/5/zy/0U/UnCGiieKVxRd64U4pyHt
	 BU38Cbg6QRF1ER48IKV0vhUMSPtAi/KENwClVG+W9am8wzuBupF+NOJRYulQXOEGyQ
	 QHBKSfH4hzUPSYbdl6ZbEjGNPOSi14sY/NOO13pCa938KOSokatmJYq/LKCiaaQb/O
	 2Xpb/+n/ZYqmQ==
Date: Thu, 19 Oct 2023 09:37:23 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Patrisious Haddad <phaddad@nvidia.com>
Cc: jgg@ziepe.ca, dsahern@gmail.com, stephen@networkplumber.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linuxarm@huawei.com, linux-kernel@vger.kernel.org,
	huangjunxian6@hisilicon.com, michaelgur@nvidia.com
Subject: Re: [RFC iproute2-next 0/3] Add support to set privileged qkey
 parameter
Message-ID: <20231019063723.GJ5392@unreal>
References: <20231016063103.19872-1-phaddad@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016063103.19872-1-phaddad@nvidia.com>

On Mon, Oct 16, 2023 at 09:31:00AM +0300, Patrisious Haddad wrote:
> This patchset adds support to enable or disable privileged QKEY.
> When enabled, non-privileged users will be allowed to specify a controlled QKEY.
> The corresponding kernel commit is yet to be merged so currently there
> is no hash but the commit name is
> ("RDMA/core: Add support to set privileged qkey parameter")
> 
> All the information regarding the added parameter and its usage are included
> in the commits below and the edited man page.
> 
> Patrisious Haddad (3):
>   rdma: update uapi headers

Kernel patch was accepted https://lore.kernel.org/all/169769714759.2016184.7321591466660624597.b4-ty@kernel.org/
Please resend the series with right "rdma: update uapi headers" patch.

Thanks

