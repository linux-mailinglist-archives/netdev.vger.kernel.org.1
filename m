Return-Path: <netdev+bounces-227158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BABBA93DC
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 14:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FB81C179C
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 12:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8503002A7;
	Mon, 29 Sep 2025 12:53:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCFA2FE563
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 12:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759150390; cv=none; b=a1cIcoWyZhEgy3FKhlc4XSZi0x7GVav9A10i8JwOGM0tHguLaRwiZIiZk6bXXBU940zhDXw6vAomL69W4/tRKgsUEl6qiudRtrX9xwL6bkzFlTOfPXAm+i8+DtbVDPrdrpEWIEBJXzCHZC4a9umsj6jhN4CqX7mcuIoKWA0P/uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759150390; c=relaxed/simple;
	bh=rsiEXNtJrOvs0mMVLKOmB1KR2i44hKxl5+Tc3E6fUBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ccYc5AYMx7Lw1Ye/gX4UiNtT9Cfphusr90Wxnrbn48UJFNBnU05EKTPZ+eXcJnGA0pgwDxvkf0kRTXtIDvDeBp8PkJgJa0jEr4i+Rnx0NkYk5mWSLrQ7EwItdWTmT4UhsiH9rPspy6H7maaKRBF112bnGXqhjudyIy8a9VU2we0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6D2DE6028F36E;
	Mon, 29 Sep 2025 14:52:08 +0200 (CEST)
Message-ID: <def4e194-84b5-4f42-9f54-8e327ece1cf6@molgen.mpg.de>
Date: Mon, 29 Sep 2025 14:52:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next] ixgbe: fix typos and docstring
 inconsistencies
To: Alok Tiwari <alok.a.tiwari@oracle.com>
References: <20250929124427.79219-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 horms@kernel.org, intel-wired-lan@lists.osuosl.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250929124427.79219-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Alok,


Thank you for your patch.

Am 29.09.25 um 14:44 schrieb Alok Tiwari:
> Corrected function and variable name typos in comments and docstrings:
>   ixgbe_write_ee_hostif_X550 -> ixgbe_write_ee_hostif_data_X550
>   ixgbe_get_lcd_x550em -> ixgbe_get_lcd_t_x550em
>   "Determime" -> "Determine"
>   "point to hardware structure" -> "pointer to hardware structure"
>   "To turn on the LED" -> "To turn off the LED"
> 
> These changes improve readability, consistency.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

[…]

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

