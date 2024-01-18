Return-Path: <netdev+bounces-64286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C928320E4
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 22:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFD9128987B
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 21:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC6B3172E;
	Thu, 18 Jan 2024 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JbIuMh21"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C4A2E84E
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613415; cv=none; b=kqQx9EF0cH948fiP+VeEWaJR9nJsNWsI/6GrkXkHme+WqC5/LxMloYGDIV3x2gcP1+4O44FI/SOu/XqisvadBHAMIFYlGD894wggs0xmpA/LBX8XSDwSPKvGGKtWQWpcm5aQ0xrmKBSfuT+cwiJt50fe6m2mMyVMIVjYSldx1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613415; c=relaxed/simple;
	bh=7WQsJ8Tf7CaGSXDKCFoa+BtJgZ4fKTlml45/gJFkPDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q53PUQSdu3JTCsUF4CQSd2cr1Q2ewghsEhawcM3XmaemQpot2amxqpgq+ynXCggpndRahJU9St3ArYe6uoZm0zR1orF6DUR3xkkVjJwx8kwMVFUMe3ghjMFI4QLNsMoQ2cHUwdZFlOU8I/cr0cOBIoKL+AgVBaW3aykF83SrrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JbIuMh21; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5c4ad938-eef4-4d6a-84e0-ffb10630fef9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705613410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UeFgCIWyJdy38ixF0n0UBEtxo16pAI1iqb5H63NyGug=;
	b=JbIuMh21/QokojpOA6zsLxr1kYY5hRrmEY+dSYTkyGAZplbtQCvoqwe2vwrbKEzIGCcV3K
	2dp2pZojWsKALftKch6Ud4USMQ94lbTn+MaUZuuhojRMem8t7ZYjZmeogkcWrr6ja920rQ
	XYAw8gQd3RtM+tYSh0xaPt3Yj6g0I5Y=
Date: Thu, 18 Jan 2024 13:30:05 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v16 03/14] bpf, net: introduce
 bpf_struct_ops_desc.
Content-Language: en-US
To: thinker.li@gmail.com
Cc: sinquersw@gmail.com, kuifeng@meta.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, ast@kernel.org, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, drosen@google.com
References: <20240118014930.1992551-1-thinker.li@gmail.com>
 <20240118014930.1992551-4-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240118014930.1992551-4-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/17/24 5:49 PM, thinker.li@gmail.com wrote:
> @@ -1750,11 +1755,6 @@ static inline int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map,
>   {
>   	return -EINVAL;
>   }
> -static inline int bpf_struct_ops_link_create(union bpf_attr *attr)
> -{
> -	return -EOPNOTSUPP;
> -}
> -

This patch is about adding bpf_struct_ops_desc. Why the 
bpf_struct_ops_link_create() is removed here?
An unrelated (and unnecessary?) changes?

