Return-Path: <netdev+bounces-180873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF091A82C43
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F6F3BD88E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57808265CD1;
	Wed,  9 Apr 2025 16:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OdbbvZs0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5JPBKXOx"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5033925EF89
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744215365; cv=none; b=KAt3JB+KnAdhJU1JyxhGWSkUeUO5V0jWHJAdZnIUr+XnfqplREgGf96DwGK5iWAALE79Tc6hbAYBjOSeuMZzeatDH2ljvyOymcDQo6REjAkBnrclRa9ojx6XNeYCYX235sQQGdiXaCFmClxK2k437VI3rpS9cIlmA2xW16Adbsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744215365; c=relaxed/simple;
	bh=VIi+YlCkI3z0HYCkxQs89wwgYPN5hVjIw7Cma631Hfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTBIj/TDP+G6S0l1Ke33/BXJT47xdaBVsJDxjkoI2vAS9JDmKeE4fzfw0EaeZZZN06ET8c300OpWKP26PaRsOFqk6uiVW0mzOdjBi+v7urQN45NXCRA+dKXVG5ILm8IPQfs+I1jJI+VWbRPYj8Z9+CKltrPmjf+COogOb+zooko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OdbbvZs0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5JPBKXOx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 9 Apr 2025 18:15:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744215360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KhF/SyB8TS1klwHHCHleCoeFO5TPQWip+5TUuN+HrdQ=;
	b=OdbbvZs0YIUJjQS5VTzyHwpQau13G4ty2UZc3s8cuTuljxAvu289uEEIrsuO453BRWyWp0
	jPBU42Rgk9G1FUJHNieRfDajsmCdX2EKPa0IGH7QDqX+AaYOk5be0GteuR0Icgswxbtamr
	5Bq8SAOsdy+7x+1GMViVgkPo7B+CDjvm6Lh41reGSr45g70sFn3i+L0pmztpa6kyU9ODVj
	bUw8Zpf3DbbsTS0FdZCn4a+DP/AdhE13TFBuLG/fw9fzSVc5AXQc5KOc1D0e/J6LLRK9St
	oHQDlt0jODBqB9I7xPwrZux1BwLJIvzYu5O0X8FMsiKmT3zW3vK91iOqyrjNig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744215360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KhF/SyB8TS1klwHHCHleCoeFO5TPQWip+5TUuN+HrdQ=;
	b=5JPBKXOx+9DSnPddkoUmUONMPqkHALuOSZsMdsC2KsiWPHCFamzrG21gTqPF4epyYyC1JA
	J50seKSNo+01D0DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Joe Damato <jdamato@fastly.com>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Yunsheng Lin <linyunsheng@huawei.com>
Subject: Re: [PATCH net-next v3 0/4] page_pool: Convert stats to u64_stats_t.
Message-ID: <20250409161558.8a8WSoml@linutronix.de>
References: <20250408105922.1135150-1-bigeasy@linutronix.de>
 <20250408185636.4adc61fb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250408185636.4adc61fb@kernel.org>

On 2025-04-08 18:56:36 [-0700], Jakub Kicinski wrote:
> On Tue,  8 Apr 2025 12:59:17 +0200 Sebastian Andrzej Siewior wrote:
> > I don't know if it is ensured that only *one* update can happen because
> > the stats are per-CPU and per NAPI device. But there will be now a
> > warning on 32bit if this is really attempted in preemptible context.
> 
> I think recycling may happen in preemptible context, and from BH.
> Have you tried to test?

Let me try to find something for testing. My mlx box has no ethernet
cable plugged.
Yunsheng mentioned also something that there might be more than one
writer this might ask for different approach.

> The net.core.skb_defer_max sysctl may mask it for TCP traffic.

Sebastian

