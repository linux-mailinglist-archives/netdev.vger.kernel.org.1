Return-Path: <netdev+bounces-227816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A4ABB7ECD
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 20:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF91C3B926E
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531CE27C864;
	Fri,  3 Oct 2025 18:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RaD85swx"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E584C1EA7DF
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517433; cv=none; b=ZAgVBm+aFqg0tX6fLLBNRLz+HJacMbt+/9VLs94vvKxiT4EOrkg0ICiynfDjHtbKdJe+KBzQrD3bkEiX/YZrC99IBXB6Qf0v7nCgsdgQSSEEfBIBi9RaDzZuzEPbdABXsBHaj6bJzsnZYMP1vbP2TjYOdBFUcpepMjaxOIokiTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517433; c=relaxed/simple;
	bh=8zIsYsgDfEZa7I7tB/V6cpcUz49D8RFg9UQvHpQHhwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMkdpUslQdIJvPO5+USmAVLQfFmPb1TMQxNKKYegA94DmwqXTjL+Y88X1+eWYqPqfqt1iO8ysLH9AvZ7g7irSuMl4OdguYBIrMyFGrs2P5eU/d2SYqSJhsZXYPgaWWc2i/fSUHeBAwSE/FZ/69hMtxBoE3NsEnxV7wVA85BT/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RaD85swx; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <44ca44bb-a641-4d70-ad7a-96a3187706a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759517427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikaIhTGzbrKsi7o6KZMKmzN4UHLKbNVk29IQZ87Klwk=;
	b=RaD85swxavEjzWRZp1Lm++6G4PW8INLvYeWw/XceNrVyuy0OFLV72PSMpCyAta75dU3kUu
	P0KJA6MDGs2/4NcEJKjZZrjWB8VQZQAkLu4f+YK8FKY3qiV5bW8si5ErPk9EarwaHKruh+
	MZPLo6Ot/bk0U6mz/le0y6gWm9DqTvs=
Date: Fri, 3 Oct 2025 11:50:23 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: Fix metadata_dst leak
 __bpf_redirect_neigh_v{4,6}
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Yusuke Suzuki <yusuke.suzuki@isovalent.com>,
 Julian Wiedmann <jwi@isovalent.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Jordan Rife <jrife@google.com>
References: <20251003073418.291171-1-daniel@iogearbox.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20251003073418.291171-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/3/25 12:34 AM, Daniel Borkmann wrote:
> Cilium has a BPF egress gateway feature which forces outgoing K8s Pod
> traffic to pass through dedicated egress gateways which then SNAT the
> traffic in order to interact with stable IPs outside the cluster.
> 
> The traffic is directed to the gateway via vxlan tunnel in collect md
> mode. A recent BPF change utilized the bpf_redirect_neigh() helper to
> forward packets after the arrival and decap on vxlan, which turned out
> over time that the kmalloc-256 slab usage in kernel was ever-increasing.
> 
> The issue was that vxlan allocates the metadata_dst object and attaches
> it through a fake dst entry to the skb. The latter was never released
> though given bpf_redirect_neigh() was merely setting the new dst entry
> via skb_dst_set() without dropping an existing one first.

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>

