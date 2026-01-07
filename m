Return-Path: <netdev+bounces-247829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEEECFF20D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF262302FCB8
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC68834DCC5;
	Wed,  7 Jan 2026 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jEg5emR3"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C2633AD9B
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805247; cv=none; b=OCSMW6Z5wn4jBZ6edlHtFTISz4pv8wjjansAPzmnwD03c167SA3QG6N9m2LEXgSsZMTP5ABZ76vOYnDae51Ewf6rcRA48tfYFdoHoZg+hzR3tD8rhczgykaqVX7jcTFmAKh8wYVYdqFtG93u1kfCl+BWvi+RfUiqtyfI3DHFkhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805247; c=relaxed/simple;
	bh=0GnXj28vFmi1gaCcdKHHWTljBMuhe869/l/g32wuwDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a55kKHSK7HzyK2Rtm4b4V2uTESmTdr3PABB6RHwBK2SlT/zmxKATor2HRLV8+vKWCKVxstpPISBg8opoNlihhn/skDBXQl2qIHd7TdaLIfTP84XCicpD7PnvZAPNk3SRkPCZw+sDkWa4fJS262hzwF0vUirczH5LjH3fZG17Qwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jEg5emR3; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8ee7ba7f-d75d-48b9-86c4-225ffa85545d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767805237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2s5I1T3fLXF8YULxyt/IwVgjMom0x6i4nAXhmRxkUA=;
	b=jEg5emR3EYrcHM4EXq9lyO+MvRVwGUfN5bqgmjKRRH8mgaY3s8/q1tLIFrWOjuvKa4jAIX
	nV5cx2cL+pS35bto1ELlRKKJe4OQwxYhNIudButUQrIDYC/Lei06vP7nlnbRSdbvUkOYpi
	XfqwA/8NNQsflxdw06ilrttnU4D0Gpw=
Date: Wed, 7 Jan 2026 17:00:32 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: usb: introduce usbnet_mii_ioctl helper
 function
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, netdev@vger.kernel.org
References: <20260107065749.21800-1-enelsonmoore@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260107065749.21800-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 07/01/2026 06:57, Ethan Nelson-Moore wrote:
> Many USB network drivers use identical code to pass ioctl
> requests on to the MII layer. Reduce code duplication by
> refactoring this code into a helper function.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

For new patches it is useful to run scripts/get_maintainer.pl on the
patch file to figure out maintainers to put into CC for the review.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

