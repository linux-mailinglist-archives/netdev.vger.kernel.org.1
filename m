Return-Path: <netdev+bounces-226028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C432B9AFCB
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 19:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0280189392D
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 17:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DCD3128B0;
	Wed, 24 Sep 2025 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uLQYU5Hv"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ED8302CB2
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733912; cv=none; b=gGPlDd2u+O4Rm2g4OfdbCGastCDWyq1aLblYkfaxCwbW+2/7WGKw65ESCNAqQn9cczohLj9gdimiXrVmzBhhjNKNYEcOTSgD2mexGH22unedzQ0nN1/cbIB3xIBHq9prrAc1V04Xl5YqO5sdTVvlIq5lCR/RSzposVBNKQKu3RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733912; c=relaxed/simple;
	bh=RIydtCqx5LdzwvRcEcB07UHP8jMi+hfdkhrI++wXeyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prKRia1f0vEYgD9BZP6HpH1v3EETeiD49640tnGwsVehhMEcD3DVfClxX0dTifVEZQoKqu3A6sfUKCOlt/n1OKX1T8a2w4iKwjVs+8F22fth+6+WITHc/7jjTTP311KP50IhV9wZY8fbAPoc/kVTw3hX9NdRrZxykNk6NBja0dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uLQYU5Hv; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d94137e3-0404-4475-b03c-a80172d6618e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758733907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIydtCqx5LdzwvRcEcB07UHP8jMi+hfdkhrI++wXeyM=;
	b=uLQYU5HveIUnwszQBaBLjkmamJ+EZATqc+FAmK5OW4BKqKX8NuPPC+jjwK/84if5ku/GS1
	wWt+GKz5ajre2wVRHmH6QcqB60+VtPcXib+V+TlX6cdoMizmvUADH7Sp+DPqD7sLoyaqNs
	Eg6EBKdF+lA+rXRjhC8sPi0tks/J3s0=
Date: Wed, 24 Sep 2025 18:11:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 0/4] convert 3 drivers to ndo_hwtstamp API
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Michael Chan <michael.chan@broadcom.com>,
 Richard Cochran <richardcochran@gmail.com>, Tariq Toukan
 <tariqt@nvidia.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Mark Bloch <mbloch@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <20250923173310.139623-1-vadim.fedorenko@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250923173310.139623-1-vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/09/2025 18:33, Vadim Fedorenko wrote:
> Convert tg3, bnxt_en and mlx5 to use ndo_hwtstamp API. These 3 drivers
> were chosen because I have access to the HW and is able to test the
> changes. Also there is a selftest provided to validated that the driver
> correctly sets up timestamp configuration, according to what is exposed
> as supported by the hardware. Selftest allows driver to fallback to some
> wider scope of RX timestamping, i.e. it allows the driver to set up
> ptpv2-event filter when ptpv2-l2-event is requested.

Jakub, I had an offlist discussion with Carolina, they have similar
patch with additional cleanup in the internal review now. And it looks
like my patch for mlx5 may be a bit out of the style. Can you please
drop patch 3/4 out of the series and apply the rest? I'm OK to let
nVidia folks to clean up mlx5 properly.

