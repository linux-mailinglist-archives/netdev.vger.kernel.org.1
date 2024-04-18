Return-Path: <netdev+bounces-89267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1DC8A9E21
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCAF1F226FB
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3146916C444;
	Thu, 18 Apr 2024 15:17:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4641715F321
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 15:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453460; cv=none; b=THdOqWsLA2vt0iN1FQBp/Ypjxd3v0ADmDWgd+hJgvtXh2lH3L6UyBI7nypd3XdUQAyVLwvAha56TmDvs4YRWTWWRR5AtIJvcgQzYoyHRowBAARO0qY/ncngP71LJMxYMSjE8zQrKwSfUM+GlJ2roUXZNf9mFnqJJJJ9Inh4Jt+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453460; c=relaxed/simple;
	bh=ZYHfuDMKfjxVlIDILH1w0LVJECEORv8Ym7vCkA2q1TM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afJQDVSSBGAQuNYzpx5c15ri7yZCVL8nqgnKAEXOjQKPWWAmRinUK9pgORCtm8QvuajzGzFOxlhfuzRnvAiwM3yIwLh1zv0v/Us832yHZMdyNu7nX/FYJ1S6cuIrS7fnQFUVX794oWOAqAeU6TemUuoTRx+feiIOE/oX4ot8rXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id EBBC361E5FE06;
	Thu, 18 Apr 2024 17:07:08 +0200 (CEST)
Message-ID: <21507396-3615-41e3-b8dd-5fbac046d5b0@molgen.mpg.de>
Date: Thu, 18 Apr 2024 17:07:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: Extend auxbus device
 naming
To: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20240418110318.67202-1-sergey.temerkhanov@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240418110318.67202-1-sergey.temerkhanov@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Sergey,


Thank you for your patch.

Am 18.04.24 um 13:03 schrieb Sergey Temerkhanov:
> Include segment/domain number in the device name to distinguish
> between PCI devices located on different root complexes in
> multi-segment configurations

Can you please paste the old and new name in the commit message?

> Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ptp.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)

[…]


Kind regards,

Paul

