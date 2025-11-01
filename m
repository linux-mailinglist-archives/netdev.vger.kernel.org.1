Return-Path: <netdev+bounces-234880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E66C2889E
	for <lists+netdev@lfdr.de>; Sun, 02 Nov 2025 00:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F00B3BA821
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 23:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7332749D5;
	Sat,  1 Nov 2025 23:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RHuSWSc3"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B30B652
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 23:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762040766; cv=none; b=jLIlG5/yOAqlZnW+08ZupUWO4FOHBcLfEsI5dk/Hw5qjIz/A5QIvng/ZSaIha9cVz/oR+YdbartX0UbqWaOz+pBg88zcujHsntSuDAeUoZejSsUGrTo+YDHXSWxcwQdOpEs9lhL8XXtrlbI9NNgW2yN6J2EnYiS3cErj546AY70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762040766; c=relaxed/simple;
	bh=Yvs2o/RonLEgsoi6EVRu+y7OQbcWjLrx+Ri55ASa2MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DqXg5kbJTu2MmyUJrnxqRtoriEdmdtYsg7WmXV22BHt/VcRv4U9Fz5lKesWg/PcGjRMObHjxVeN50if228a03hKGlxhub7Hd7aO/SduHSFOluUC6uKhkPXriztnQOhmnc+m78GTLljELbYSpokvEsSD9hFdGLgzSVizYk0nFuDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RHuSWSc3; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <aef3b850-5f38-4c28-a018-3b0006dc2f08@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762040749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gp05nF2bm7DxwtWiDo5A01YXCWCugMy1BJspzvJrD7o=;
	b=RHuSWSc3m+5sY89Fw3fLMpdHc0mm0+AoDWOOawhKS5Smp17/gJv42O+T2xnVGmwmgFf+Ku
	gPYf91XMYKQFQHNRU+bxGX0/42Y1h4cEytPJhtejeq1U5k4N5af+h5brbBK+7+PVmU4bqE
	4HXlKy31O8ZOojePPyx+wG7YW4qxEuo=
Date: Sat, 1 Nov 2025 23:45:00 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: ocp: Add newline to sysfs attribute output
To: Jakub Kicinski <kuba@kernel.org>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, richardcochran@gmail.com,
 jonathan.lemon@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251030124519.1828058-1-zhongqiu.han@oss.qualcomm.com>
 <20251031165903.4b94aa66@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251031165903.4b94aa66@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 31/10/2025 23:59, Jakub Kicinski wrote:
> On Thu, 30 Oct 2025 20:45:19 +0800 Zhongqiu Han wrote:
>> Append a newline character to the sysfs_emit() output in ptp_ocp_tty_show.
>> This aligns with common kernel conventions and improves readability for
>> userspace tools that expect newline-terminated values.
> 
> Vadim? Is the backward compat here a concern?

Well, unfortunately, this patch breaks software we use:

openat(AT_FDCWD, "/dev/ttyS4\n", O_RDWR|O_NONBLOCK) = -1 ENOENT (No such 
file or directory)
newfstatat(AT_FDCWD, "/etc/localtime", {st_mode=S_IFREG|0644, 
st_size=114, ...}, 0) = 0
write(2, "23:40:33 \33[31mERROR\33[0m ", 2423:40:33 ERROR ) = 24
write(2, "Could not open sa5x device\n", 27Could not open sa5x device

So it looks like uAPI change, which is already used...

