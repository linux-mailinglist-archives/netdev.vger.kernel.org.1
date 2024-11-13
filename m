Return-Path: <netdev+bounces-144258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8E89C665B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 01:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45A51F21C7E
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 00:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE007AD5A;
	Wed, 13 Nov 2024 00:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LsdLzszk"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7809F6FB9
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 00:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459555; cv=none; b=A7/jnRxr769Xg4y7XVhYARUx2tRexQBbReVcXhFFMXhPKbfvz6NdX665hSOq4DQhYI4wL/+og5qHzsf7lcDTCLUZHdRJQKJs6bFs+MuMoiUWmsHvuTpWLZs4gn61Hzb+z4Q2ccpyINisNh8g1/3y+Mk56aeKFsu8W31y6+VvuHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459555; c=relaxed/simple;
	bh=9XX5N+TdO/BUetwj4AmO4rLoKNvezuERJXKfJcR1eLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsnJJ1z+4SgN6sOQKsHewESooVt6fMNZdQoZrlmWAqDwrS7Mu5z8MQXxapV/f4dv8HirUNXpSkNAHSxwHWq8gbQy1IiDNNhGQ84V/Kcq9FSytFl86cXXKQAnpz7jqmFKTNLezouBs3FwLfm+m8Z6CKr9HyVOaO5CpcXXJLvhawE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LsdLzszk; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <677fac6c-e66d-4fba-a89a-982888209523@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731459551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JvrHNLX9AABBSynCrSCTX1QYMPJbE/ts/ugS+jCT1/g=;
	b=LsdLzszkcmZH8TwpENa+L0H+MTI/6+NeWZ2++OvFO6YvWJL95XFTbPzVluJls1c9VKZnJz
	0nm/LjGTem+lhQxR64mbrcEkyGOZcAdTTOMoZQHIPi0zv61sfDasQlQMj0tVOnC1fm4aQS
	vRezM0OeHdf2Dh2gPme0Hg+dq6AJv3o=
Date: Tue, 12 Nov 2024 16:59:02 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 0/3] Add kernel symbol for struct_ops
 trampoline
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song
 <yonghong.song@linux.dev>, Kui-Feng Lee <thinker.li@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241112145849.3436772-1-xukuohai@huaweicloud.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241112145849.3436772-1-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/12/24 6:58 AM, Xu Kuohai wrote:
> Add kernel symbol for struct_ops trampoline.
> 
> Without kernel symbol for struct_ops trampoline, the unwinder may
> produce unexpected stacktraces. For example, the x86 ORC and FP
> unwinder stops stacktrace on a struct_ops trampoline address since
> there is no kernel symbol for the address.

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>


