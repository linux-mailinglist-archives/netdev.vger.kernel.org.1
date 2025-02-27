Return-Path: <netdev+bounces-170411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA75A489ED
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 21:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E492A1668C8
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 20:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9461DDA3E;
	Thu, 27 Feb 2025 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gdaT5NOs"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705963C1F
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688382; cv=none; b=lwAtHw84fA/KAbirs7YejIubszN+2dXDdxMMKpUKz/8WCm1SAjTCCy+fVt45j4jjJFX15jT+UIV5eleWsMI/z5+vF1cLQLOTuSgugF/yLZIP0qduf5+2yd1EErFu7OzL+jxEHn+W4Gak1S+ZVb4zWNV0VD7cPQOw3LNqoQc3dEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688382; c=relaxed/simple;
	bh=4Kiaoz8/a4B77D0BEyUMCVK1pmYrQ7xhsz069exA5Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgDX4EpNyvcbjBU4b1boYg22rsuvdx5ZE/1kbK4LDdxnoIzfQoqH4WJH/LcH5L97z4AMA9ovc4/ZyzT4Xp5xdDB+imiPgcjdutuYP8HkoBj8goPE/2DGXEnVI3D5h6MVwrJJbA34MCp5kOEpdrK4VHF1TtYwlfcEXihAqznsk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gdaT5NOs; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <96dbd7df-1fa7-4caa-a52c-372d696e0f38@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740688368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPZyfCvWgiJkshdLVHHVpjhInvVRGrB2U9muS4L7rYA=;
	b=gdaT5NOsNx6vhF6HurGBbeJsiytfhlYTg2DTdVgjrlaCyyzJOhZG9MMPERFWjR6FmJmjrD
	h0xAoJTauJKoeMYcdc21fnGxU63zghrkpQz6O9s86yKoH9sgj2dZ10r37Ti9wfOYABQE9F
	Lss7denSZvxJqnFh3v1A31puS7Ossbw=
Date: Thu, 27 Feb 2025 12:32:43 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: add get_netns_cookie helper to tracing
 programs
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, ast@kernel.org,
 andrii@kernel.org, jolsa@kernel.org, bpf@vger.kernel.org,
 Network Development <netdev@vger.kernel.org>
References: <20250227182830.90863-1-mahe.tardy@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250227182830.90863-1-mahe.tardy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/27/25 10:28 AM, Mahe Tardy wrote:
> This is needed in the context of Cilium and Tetragon to retrieve netns
> cookie from hostns when traffic leaves Pod, so that we can correlate
> skb->sk's netns cookie.
> 
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
> ---
> This is a follow-up of c221d3744ad3 ("bpf: add get_netns_cookie helper
> to cgroup_skb programs") and eb62f49de7ec ("bpf: add get_netns_cookie
> helper to tc programs"), adding this helper respectively to cgroup_skb
> and tcx programs.
> 
> I looked up a patch doing a similar thing c5dbb89fc2ac ("bpf: Expose
> bpf_get_socket_cookie to tracing programs") and there was an item about
> "sleepable context". It seems it indeed concerns tracing and LSM progs
> from reading 1e6c62a88215 ("bpf: Introduce sleepable BPF programs"). Is
> this needed here?

Regarding sleepable, I think the bpf_get_netns_cookie_sock is only reading, 
should be fine.

The immediate question is whether sock_net(sk) must be non-NULL for tracing.


