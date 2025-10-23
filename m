Return-Path: <netdev+bounces-232152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFE5C01E6C
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 16:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF763A5D0A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 14:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E5C307AC5;
	Thu, 23 Oct 2025 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DaByQdQY"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1322333B
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230645; cv=none; b=bEknbecOClGx24w/CqJLNL8SpmwZEf9EkQiNLfNLinFtNo6dYbJmHsPe3Jme0dn4y1iEphbh4OJtlGKtEws6bOg7iWEBZrFVgKb+RQXgP2NRGHrKChHJgsv9uKT6omk5tLogFFjhAiGf1e4rPtjMFG4iVxl+wVQNRWYNBaqJaBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230645; c=relaxed/simple;
	bh=5miEkZ1JSkp1jgmJ10ykJeedVvj7ITikApk6V9cWSJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsaZZFc2b9ybyb7WtgXDQkkKD0XTcC0s8pKG0Rxei3c0XHcriZTxUabu4gsJ7fXZcfvlOuq6aPD/aHLrMsQhdBFuHu1LT9ARyJk74UgyGicCHIGHQ6/UBV6ZqvTvU4iEnsBd4l11A3YXrdcYy4X64YNwqilhDzGHlMuPOlMRdN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DaByQdQY; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <76a998f5-2096-4981-8c71-ca114b63ecba@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761230632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R67XIWMDeD6DjUBVMjLO8VImL2MsTx/yJ1nOycwL2NA=;
	b=DaByQdQYzWh5hqkqeZExFHv7EDy/p3tjLK5KpjX5WFmRBxBZjM4V4epoNUN5RkQOszEOU3
	e+K8Uw1wQ4eEHozlHpbzE3J/NUW7MhO0JmHiKam4D9taijDGF8G+RcXMQwl+htRG4nnKdF
	7F8zHeJecYbt89EYRHadgBWAfgJi6t8=
Date: Thu, 23 Oct 2025 15:43:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 0/2] ptp/ptp_vmw: enhancements to ptp_vmw
To: Ajay Kaher <ajay.kaher@broadcom.com>, kuba@kernel.org,
 davem@davemloft.net, richardcochran@gmail.com, nick.shi@broadcom.com,
 alexey.makhalov@broadcom.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, jiashengjiangcool@gmail.com, andrew@lunn.ch,
 viswanathiyyappan@gmail.com, wei.fang@nxp.com, rmk+kernel@armlinux.org.uk,
 vladimir.oltean@nxp.com, cjubran@nvidia.com, dtatulea@nvidia.com,
 tariqt@nvidia.com
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org, florian.fainelli@broadcom.com,
 vamsi-krishna.brahmajosyula@broadcom.com, tapas.kundu@broadcom.com,
 shubham-sg.gupta@broadcom.com, karen.wang@broadcom.com,
 hari-krishna.ginka@broadcom.com
References: <20251023131048.3718441-1-ajay.kaher@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251023131048.3718441-1-ajay.kaher@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/10/2025 14:10, Ajay Kaher wrote:
> This series provides:
> 
> - implementation of PTP clock adjustments ops for ptp_vmw driver to
> adjust its time and frequency, allowing time transfer from a virtual
> machine to the underlying hypervisor.
> 
> - add a module parameter probe_hv_port that allows ptp_vmw driver to
> be loaded even when ACPI is disabled, by directly probing for the
> device using VMware hypervisor port commands.
> 
> v3:
> - [PATCH 1/2]: reverting back the changes of ptp_vmw_pclk_read()
> - [PATCH 2/2]: calling ptp_vmw_pclk_read() without cmd
> 
> v2:
> - [PATCH 2/2]: remove blank line in ptp_vmw_init()
> 
> v2 link:
> https://lore.kernel.org/lkml/20251022105128.3679902-1-ajay.kaher@broadcom.com/
> 
> v1 link:
> https://lore.kernel.org/lkml/20250821110323.974367-1-ajay.kaher@broadcom.com/
> 
> Ajay Kaher (2):
>    ptp/ptp_vmw: Implement PTP clock adjustments ops
>    ptp/ptp_vmw: load ptp_vmw driver by directly probing the device
> 
>   drivers/ptp/ptp_vmw.c | 99 +++++++++++++++++++++++++++++++++++--------
>   1 file changed, 82 insertions(+), 17 deletions(-)
> 

For the series:
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

