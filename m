Return-Path: <netdev+bounces-243329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5491EC9D32C
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 23:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EED5D349ABF
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 22:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB20C2F6931;
	Tue,  2 Dec 2025 22:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NQhZYM2D"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCA42F83A2
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714067; cv=none; b=WlpEFQHJQJVjh0jzZKiN+IEI3iNs5KiT8Xcz1+yRIvs3QOFfUv+U+Dta4Fuy8RzWi3kY78eKRl7Gzd+E64YskwMjrpFwDGQ3UxwfOE4i1RZFfhyr45e2ta3/MSx+YorDUETASzBEtQgU5rtRdnkp6dTA36WFNT6UhdDyDMr+PHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714067; c=relaxed/simple;
	bh=co00OOcTVKPepKp480uiA04vLFu/3ZRk01iz6697vtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMCQDrOPRaTOJ7zMuQ7wKuB3CTyOcso7akNoIPKcnMJE8KXzSSwXlv4r6EqTw7Tv9ZNgpBBwY7UqYAOebenJevARdgF7ZDcrt2ZhilYX0Wx9kj9+txtcZzMseDau88vykZL6beP9ZoVGmE7f+5PRx7UG32i4bbvzaHxqOUnKGBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NQhZYM2D; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <15501b84-2c35-466c-8347-c9ca406affb9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764714063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jT8YVLFAaBYQ/BQcUwKH10ymV5WOpmuHWZ7N8lCBsNE=;
	b=NQhZYM2D6sJ8rRjfJjltKUcnejEtvAJaqE6doj5pHgWhVhAA8TGaeVf8138r/9KF7S9CuC
	GMMmcdMlPTWBk29ha80XMkM7V2dgylkLI0/U6q3Z1rIoZptEGxQYXvZnPBQQtgvVzd7lx/
	Xz6W2Ykm94KVB9v2jYvO6Vhv4snRUL0=
Date: Tue, 2 Dec 2025 22:21:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 7/7] bnxt_en: Add PTP .getcrosststamp() interface
 to get device/host times
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, Somnath Kotur <somnath.kotur@broadcom.com>
References: <20251126215648.1885936-1-michael.chan@broadcom.com>
 <20251126215648.1885936-8-michael.chan@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251126215648.1885936-8-michael.chan@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 26/11/2025 21:56, Michael Chan wrote:

[...]

> +static int bnxt_ptp_getcrosststamp(struct ptp_clock_info *ptp_info,
> +				   struct system_device_crosststamp *xtstamp)
> +{
> +	struct bnxt_ptp_cfg *ptp = container_of(ptp_info, struct bnxt_ptp_cfg,
> +						ptp_info);
> +
> +	if (!(ptp->bp->fw_cap & BNXT_FW_CAP_PTP_PTM))
> +		return -EOPNOTSUPP;

to have it enabled for x86-only (as the only supported platform as of
now), additional check is needed:

if (pcie_ptm_enabled(ptp->bp->pdev) && boot_cpu_has(X86_FEATURE_ART))
	return -EOPNOTSUPP;

> +	return get_device_system_crosststamp(bnxt_phc_get_syncdevicetime,
> +					     ptp, NULL, xtstamp);
> +}
> +

