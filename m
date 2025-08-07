Return-Path: <netdev+bounces-212093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FFEB1DD62
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 21:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736611716B6
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F39273D79;
	Thu,  7 Aug 2025 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jdBvcNXr"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986752222DA
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593808; cv=none; b=byHFhQrjUkKU4OJGztZ9IjGAuTQ+r0O+cy1tEMyzZUZpFDA5VoSPqpoR+xcAcsDA8sgtgHqyfLBKHj5jMh70LY6BOqymZG8i2ZSTl2WERIoaS2WAl3QegkSNKOOGjXebh30riJzZnJ4+K3Gn+COhzaWeE7c+kkbYJhglGCF4ckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593808; c=relaxed/simple;
	bh=c76/hHoP/RBPhhRMBt/Due3sbEDvxQkMXI6SupRPytE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVWbnHs4xdSGTbJt5VESfTC9A4Cd1KRf9hbl+BHs6eyUduAAGmQL7dgpv0wR3kyp1ebtiGOmbxxVkCVA/wnf7n5tP/TQ4Mz2WPHGIhnLWbnj9jBlY668RqtJUKOH1EjU3oN0ff+kAYycw+9K0Z5tGjLNYnUK1FqRRfy1icsBzEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jdBvcNXr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 2EC50201BC69; Thu,  7 Aug 2025 12:10:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2EC50201BC69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1754593806;
	bh=/4gUKl8+lJjjJ6U4OO1ti/JUseeSyM0QIqkqGQWHPKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdBvcNXruqeGB6NQhACTUgDsQ9VvKTJiQc4JtaGGtbIm0/ds51mBAtAFtZ3+oUhK2
	 RmwTYIXvSmeLlSQJ5HKLWvUBRTe/uQ27msgCNncujd13JGBNz9nyIeG4ouD7grAkkl
	 iMqaqaA9H8VQqgtHbk8rWD8O1s6n71RUOcM5v3vA=
Date: Thu, 7 Aug 2025 12:10:06 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dsahern@gmail.com, netdev@vger.kernel.org, haiyangz@microsoft.com,
	shradhagupta@linux.microsoft.com, ssengar@microsoft.com,
	dipayanroy@microsoft.com, ernis@microsoft.com
Subject: Re: [PATCH iproute2-next v2] iproute2: Add 'netshaper' command to
 'ip link' for netdev shaping
Message-ID: <20250807191006.GA15844@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1753867316-7828-1-git-send-email-ernis@linux.microsoft.com>
 <20250805110331.348499c9@hermes.local>
 <20250807180740.GA31890@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807180740.GA31890@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Aug 07, 2025 at 11:07:40AM -0700, Erni Sri Satya Vennela wrote:
 > 
> > > +			NEXT_ARG();
> > > +			if (get_unsigned(&speed_mbps, *argv, 10)) {
> > > +				fprintf(stderr, "Invalid speed value\n");
> > > +				return -1;
> > > +			}
> > 
> > Could you change this code to use the get_rate() in lib/utils_math.c
> > That routine handles wide variety of suffixes.
> > 
> > > +			/*Convert Mbps to Bps*/
> > 
There is a typo in this above comment. It should be "Convert Mbps to bps"

> > Won't need this if you use get_rate() or get_rate64
> 
> Okay I'll make the changes accordingly.

Looks like get_rate64 or get_rate returns the rate in Bytes per second.
But netshaper supports rate in bits per second.

I will use get_rate64 and multiply the result by 8 to get bps which
also avoids using an extra speed_mbps variable.
> > 
> > > +			speed_bps = (((__u64)speed_mbps) * 1000000);
> > > +		} else if (matches(*argv, "handle") == 0) {
> > > +			handle_present = true;
 

