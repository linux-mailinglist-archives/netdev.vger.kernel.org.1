Return-Path: <netdev+bounces-136047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C019A0173
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 08:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D911F26E2A
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 06:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFEA18E76C;
	Wed, 16 Oct 2024 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dRxy6Ruv"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D632171E70
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060282; cv=none; b=qSGQPLq1C9OwKcs8XJKxbq3Ld5xUXZPte/yXG1XcxsKqM3D+xmD0UXZkJMs1puW6FGCEnLW9dPvloT5pXPhKQ9X4tMTFBPWjPe1tZ4XHXbSe3PaHua3iCSah8h3UBXoOrEiiCVn+kVCryFlsetNn+sVJeedXo/32G1vx7AeT1Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060282; c=relaxed/simple;
	bh=3Pwhc+DbxvherrW4Dowq5MMYJHlclJPDxNBe1w+K3GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cd3Y+MixW3AUXt3XFfS6pdvU/Z1c2z/d5Z5HPexkamDfoPrEPyW/FfGUJoR7gvHTB6AHpPF553fEcUuzaEzzYIwR27CC5RmD37hZqIa2FHUrw9crF/jotemnYOj08I/7nBp4gizv02m0OQ6Xg7rqjMEGnPuN9aFScg5bI5NHHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dRxy6Ruv; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <49a87125-d5bd-4b8d-964e-0d745e9e669b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729060277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wa5Neq4UpN37LZJ4XmZdBxMgDSMOON5rKqRM3GGSbew=;
	b=dRxy6Ruv3fMfm7qrNYz89n4e101/Ia118aEYJT5KguCFSdaYKg75dzOfn21WL4UX3hC3Gt
	Nus0TyY1R6xkg3YMmzVFEi1qUARsJpzCOs3Ish4ynRoQ4XIXYrIZrcLPm/8d10QbdkrDIC
	PncmiAjG2T1fFHINMU+sG3FY8BRWJ+g=
Date: Tue, 15 Oct 2024 23:31:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com>
 <dbddb085-183e-47bf-8bc7-ec6eac4d877f@linux.dev>
 <CAL+tcoBieZ3_ZX3PRY8k7-C6Rv2g=Mr1U1NAQkQpbHYYvtWpTQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAL+tcoBieZ3_ZX3PRY8k7-C6Rv2g=Mr1U1NAQkQpbHYYvtWpTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/15/24 6:04 PM, Jason Xing wrote:
> To be honest, I considered how to disable the static key. Like you
> said, I failed to find a good chance that I can accurately disable it.

It at least needs to be disabled whenever that bpf prog got detached.

> 
>> The bpf prog may be detached also. (IF) it ends up staying with the
>> cgroup/sockops interface, it should depend on the existing static key in
>> cgroup_bpf_enabled(CGROUP_SOCK_OPS) instead of adding another one.

> Are you suggesting that we need to remove the current static key? In
> the previous thread, the reason why Willem came up with this idea is,
> I think, to avoid affect the non-bpf timestamping feature.

Take a look at cgroup_bpf_enabled(CGROUP_SOCK_OPS). There is a static key. I am 
saying to use that existing key. afaict, the newly added bpf_tstamp_control key 
is mainly an optimization. Yes, cgroup_bpf_enabled(CGROUP_SOCK_OPS) is less 
granular but it has the needed accounting to disable whenever the bpf prog got 
detached, so better just reuse the cgroup_bpf_enabled(CGROUP_SOCK_OPS).

