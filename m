Return-Path: <netdev+bounces-239216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B77C65BAD
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 19:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 7ADE72413F
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E4C2D24BD;
	Mon, 17 Nov 2025 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UBFrOCG8"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CA5202F7E
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404345; cv=none; b=O+Z0KxCfqEdQbGr2Xxko2xT+AXGPhAp3y1vA3ly4Xkjm4QJUYBwQ4yq2QhxbcWm4xEOVSkgK7T84EFB49DxckDs63/jTVckhWz+Eq1mA45+8PeRyV5ZQY6kWxZx67CHPv3sIKW4QvPrvSs/vutR3PWLhjXlz5nSEB+pD4VnIgGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404345; c=relaxed/simple;
	bh=9Ha19C7jN7rJ27z3B60YznGAmAB6V8gFVZgovYD2sB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2CGiMLTApUBe968MK0yk6NfKDPe4tUDFgohoqLU9295exRmNb3zH6+D3orHakMFDmOAcYT3BeiUbtajmYVVFJ0+mXFi448IJHKG9VzRGdHHFl8frsGu00Ur87Q1ODS3cZtTIJ0WqTA1157fHNhATgaujh8UWXQqE1VYQUaROZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UBFrOCG8; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7ff1f67a-8684-48e9-a343-2546707eef75@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763404340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Ha19C7jN7rJ27z3B60YznGAmAB6V8gFVZgovYD2sB0=;
	b=UBFrOCG8plmnQ70N8ld9tdHYaykl34b5gbZ7sd8w8zHzL0Eils+VRqYcr3FJ9ry887D3Xp
	iazcm3I7YlpoX7Gm+Uyu/fkAg+iZA7C1XfCcV7jiE/yTiOSw55q0DIOnyiGO1fX7YzYidS
	g99F4D1L01+EHtCUbKcG5xlqdelu3p0=
Date: Mon, 17 Nov 2025 10:32:13 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Remove smap argument from
 bpf_selem_free()
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, memxor@gmail.com,
 kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 kernel-team@meta.com, bpf@vger.kernel.org
References: <20251114201329.3275875-1-ameryhung@gmail.com>
 <20251114201329.3275875-3-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251114201329.3275875-3-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/14/25 12:13 PM, Amery Hung wrote:
> Since selem already saves a pointer to smap, use it instead of an
> additional argument in bpf_selem_free(). This requires moving the
> SDATA(selem)->smap assignment from bpf_selem_link_map() to
> bpf_selem_alloc() since bpf_selem_free() may be called without the
> selem being linked to smap in bpf_local_storage_update().

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>


