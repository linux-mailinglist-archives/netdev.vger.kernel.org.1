Return-Path: <netdev+bounces-249539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 519A8D1ABA4
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA1FD3047101
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 17:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF103921D1;
	Tue, 13 Jan 2026 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UlNA/ulJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148FC2EBB8C
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768326452; cv=none; b=IDk3Ra/dvVOL8jvl4kYOmjX1oMDXSRxRfInECfR6EvZyTbzvRG4g2ol1zk16mixCitNct6crvs4UGTQjhqLJiWaJAdY3h5mXfAJpYc4cDKNYEafbejB9E1yeYmde9WTGjVGrufw1LJxbXzOJUCbPSBrjpDnVskzcEN2k2L5Aae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768326452; c=relaxed/simple;
	bh=RH9nwLZfwqDtoGRjdzJMCotUZ0i2h75iTckvMVVSMKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nb/ZfoU/sKl8oyRmH33LbFa2A8UZSQF1hroAvrx8pKM025faVaGG3ldk7zNBVPSoQtNUChsuet5ukpukH1AwzcvdnJ+FOvtiobi+v/op5Sf81b4pAn0WRDygECjCF1/5rSDSjqlSm+Os9dKpa+U5iqDLTeKj+UEgdvrsLjN8QMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UlNA/ulJ; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c5a1f45f-542e-4280-a601-ae96f2d1cac4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768326439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T4vksd3pjNJfhy1H7Erqq68uqNFlEYJUmzKTqs9bkQc=;
	b=UlNA/ulJrL/RNvg+RqqwV5HLpmx3p2CRs+wXc6gNRYi/A2xeVk3Ev9X2DIHgddijRuPQ4u
	EG80mydp+xTY4axuT0wqlAXEaCr1A3WFNZ4oh1OAVEzyaWDFbbannuFAKSKLi59NukSQj2
	TfN2mXehSyP5yrp9HHY43Haprripdz0=
Date: Tue, 13 Jan 2026 17:47:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 2/3] dpll: add dpll_device op to set working
 mode
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Petr Oros
 <poros@redhat.com>, linux-kernel@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>
References: <20260113121636.71565-1-ivecera@redhat.com>
 <20260113121636.71565-3-ivecera@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260113121636.71565-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/01/2026 12:16, Ivan Vecera wrote:
> Currently, userspace can retrieve the DPLL working mode but cannot
> configure it. This prevents changing the device operation, such as
> switching from manual to automatic mode and vice versa.
> 
> Add a new callback .mode_set() to struct dpll_device_ops. Extend
> the netlink policy and device-set command handling to process
> the DPLL_A_MODE attribute.  Update the netlink YAML specification
> to include the mode attribute in the device-set operation.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
> v2:
> * fixed bitmap size in dpll_mode_set()

[...]

> +static int
> +dpll_mode_set(struct dpll_device *dpll, struct nlattr *a,
> +	      struct netlink_ext_ack *extack)
> +{
> +	const struct dpll_device_ops *ops = dpll_device_ops(dpll);
> +	enum dpll_mode mode = nla_get_u32(a), old_mode;
> +	DECLARE_BITMAP(modes, DPLL_MODE_MAX + 1) = { 0 };

this one breaks reverse xmas tree order.

with this fixed:
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

