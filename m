Return-Path: <netdev+bounces-62917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE818829D34
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 16:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5F2B25DAB
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 15:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4A04BA9B;
	Wed, 10 Jan 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk0GddLR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303F74BA9C;
	Wed, 10 Jan 2024 15:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C4CC433C7;
	Wed, 10 Jan 2024 15:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704899594;
	bh=h/wkeQzQubqlHTiNWTxVSJJKg568Kr4VZtWWQzSRtbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kk0GddLRhL37FgX4OrjYqvgc+JlY/qAp9OOILqun1IqIEwpLh0+iq6f2Duh6NzYDE
	 mn5miGZqEGcjs2ZjKsm72SDYNM5ZCcr1k21ivIHzY+IyjII8uxOQQ5zzdMRkVKSzl1
	 N/YI49QJZzvmXPGyrmOpHh6/3NOl3jxQBC4R7KHxgMc7kkaG3qpt0WIqoJSReu2adP
	 e3Yi8Rlp26pbeKvRlK+VklC4bwWibi7Dipa9/+yCKy2b9KxteoaMjY0hdkTO2QRxVc
	 tkb3777SdTdwUbwhXQ9nh+9WAV9wsOaiudHQDBticdESiWAln8juWOwQmTyzhUBu3K
	 kbaLuOQ2fiE/w==
Date: Wed, 10 Jan 2024 15:13:09 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@intel.com>
Subject: Re: [PATCH net 5/7] MAINTAINERS: Bluetooth: retire Johan (for now?)
Message-ID: <20240110151309.GD9296@kernel.org>
References: <20240109164517.3063131-1-kuba@kernel.org>
 <20240109164517.3063131-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109164517.3063131-6-kuba@kernel.org>

+ Johan Hedberg <johan.hedberg@intel.com>

On Tue, Jan 09, 2024 at 08:45:15AM -0800, Jakub Kicinski wrote:
> Johan moved to maintaining the Zephyr Bluetooth stack,
> and we haven't heard from him on the ML in 3 years
> (according to lore), and seen any tags in git in 4 years.
> Trade the MAINTAINER entry for CREDITS, we can revert
> whenever Johan comes back to Linux hacking :)
> 
> Subsystem BLUETOOTH SUBSYSTEM
>   Changes 173 / 986 (17%)
>   Last activity: 2023-12-22
>   Marcel Holtmann <marcel@holtmann.org>:
>     Author 91cb4c19118a 2022-01-27 00:00:00 52
>     Committer edcb185fa9c4 2022-05-23 00:00:00 446
>     Tags 000c2fa2c144 2023-04-23 00:00:00 523
>   Johan Hedberg <johan.hedberg@gmail.com>:

I'm not arguing that this change isn't appropriate.
But, nit picking the description above,
I do think there has been some git activity within
the last 4 years, albeit from a different email address.

The most recent Bluetooth Drivers patch I found committed by Johan is:

commit 0671c0662383eefc272e107364cba7fe229dee44
Author:     Hans de Goede <hdegoede@redhat.com>
AuthorDate: Sat Dec 5 16:02:01 2020 +0100
Commit:     Johan Hedberg <johan.hedberg@intel.com>
CommitDate: Mon Dec 7 17:01:54 2020 +0200

For reference, the most recent patched that I could
find authored by Johan for Bluetooth Drivers is:

commit 6c3711ec64fd23a9abc8aaf59a9429569a6282df
Author:     Johan Hedberg <johan.hedberg@intel.com>
AuthorDate: Sat Aug 4 23:40:26 2018 +0300
Commit:     Marcel Holtmann <marcel@holtmann.org>
CommitDate: Sat Aug 4 23:23:32 2018 +0200

>   Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>     Author d03376c18592 2023-12-22 00:00:00 241
>     Committer da9065caa594 2023-12-22 00:00:00 341
>     Tags da9065caa594 2023-12-22 00:00:00 493
>   Top reviewers:
>     [33]: alainm@chromium.org
>     [31]: mcchou@chromium.org
>     [27]: abhishekpandit@chromium.org
>   INACTIVE MAINTAINER Johan Hedberg <johan.hedberg@gmail.com>
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: Marcel Holtmann <marcel@holtmann.org>
> CC: Johan Hedberg <johan.hedberg@gmail.com>
> CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> CC: linux-bluetooth@vger.kernel.org
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 1 -
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/CREDITS b/CREDITS
> index 18ce75d81234..1228f96110c4 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -1543,6 +1543,10 @@ N: Andrew Haylett
>  E: ajh@primag.co.uk
>  D: Selection mechanism
>  
> +N: Johan Hedberg
> +E: johan.hedberg@gmail.com
> +D: Bluetooth subsystem maintainer
> +
>  N: Andre Hedrick
>  E: andre@linux-ide.org
>  E: andre@linuxdiskcert.org
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e375699ebb7..388fe7baf89a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3595,7 +3595,6 @@ F:	drivers/mtd/devices/block2mtd.c
>  
>  BLUETOOTH DRIVERS
>  M:	Marcel Holtmann <marcel@holtmann.org>
> -M:	Johan Hedberg <johan.hedberg@gmail.com>
>  M:	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>  L:	linux-bluetooth@vger.kernel.org
>  S:	Supported
> -- 
> 2.43.0
> 

