Return-Path: <netdev+bounces-44655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F487D8EFB
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EED43B20FF1
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 06:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6848F55;
	Fri, 27 Oct 2023 06:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuDqTc+s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FAB8F51
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 06:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73EE2C433C9;
	Fri, 27 Oct 2023 06:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698389664;
	bh=MJUVkF4OAlCGNmh87SHpXmYBoNo0A1s3AB3gwSpYAS8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kuDqTc+sySNlKVLzuzFg+2zpfeAkRGAY+cdUM/V2ZL7eM1MQiFH8fCQRFelxXwWji
	 cLrB7hvsyG74UpQ+Az2cLEWU2JmRCRC0wFE1BlFczVGMtTi7yFkfSu+JBA139LoM+q
	 3DeToMCbb4S5bFSXficAYGfqJb+G/6svBk/oNqxbAO/PxxKcNbfNsoAStNuMvdeZ3S
	 a+L/SuC1h6iprB+MNv3IV5YVW8MlFqAUa5uCW+gCJuwr6hBNwE5rUTI6AVYdZA8oB3
	 M1fvkRLpCE7Swhmjc75pT8KTjZE8Zh5hwIoEaZedxgFoZA81DJA812/cUC4Eo/ZAA1
	 aavx67n7PzuhQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] net: fill in MODULE_DESCRIPTION()s in
 kuba@'s modules
References: <20231026190101.1413939-1-kuba@kernel.org>
	<20231026190101.1413939-2-kuba@kernel.org>
Date: Fri, 27 Oct 2023 09:54:21 +0300
In-Reply-To: <20231026190101.1413939-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 26 Oct 2023 12:00:58 -0700")
Message-ID: <87fs1wd082.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Fill it in for the modules I maintain.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: linux-wireless@vger.kernel.org
> ---
>  drivers/net/netdevsim/netdev.c              | 1 +
>  drivers/net/wireless/mediatek/mt7601u/usb.c | 1 +
>  2 files changed, 2 insertions(+)

For wireless:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

