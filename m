Return-Path: <netdev+bounces-234833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C48A5C27C98
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 12:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA3664E22BB
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 11:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC6F26ED58;
	Sat,  1 Nov 2025 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cpjTaGHY"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61D51D5CF2
	for <netdev@vger.kernel.org>; Sat,  1 Nov 2025 11:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761995948; cv=none; b=pyMBC0dXeyD6bTh+tQyeCbkclFxA5OZ+Sc2pt4uwhYRN4/To1wDx9F7EPl+HNVS4ZOajGUotvSCDeYwkIQhr1LaGGfZuan60KgI4OS7w+zUxas77s490SFX51HSViz/yCCcix2JrtczhvscJDNrT9pvrEAzl9EJZm5zFeDiPoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761995948; c=relaxed/simple;
	bh=Le3ojftnvwAMSHGtZ12ti6v3tbFc6aZVtoSsbrZK5Sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UB172jrU+B+73TrXCeU6EEbTkDWFBMF6oxKmL1DI4efRWwbCVtIfFmBZBWRp0SCIDN8wWxcAS5kbKzjB3/qLfsSqw8ZHa50TOq7tW9QMf9krHLxZ5Nnhjd0rkARECMCPwXPJjVYV7TOhTSQtOGp5U4rNARKonYILYB0b6vvsST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cpjTaGHY; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9193e49a-b7e8-4a45-ab30-c7308f8e9d75@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761995941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ybok/k/EaCYbs1jQUTE3ffytqk49cuVoxPSAGtQzHbQ=;
	b=cpjTaGHY7o2jQE5u/jerXx9XdI2PXlkTRisB8iKajAYMm0GwGn0yOoY8R5DNR6zACa0Zka
	UqGye6yTsmhpENccIdneKZZVPgPR+iHVY6oWOZvQhasHgex4lqYLLCQEiFhXFooN6a3m3K
	HbD49XO+sOgUa11l1DQG4XXc3taP5Wo=
Date: Sat, 1 Nov 2025 11:18:59 +0000
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

I'm checking our software now, hopefully it will not break, but I need a
bit of time to be sure

