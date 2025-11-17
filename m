Return-Path: <netdev+bounces-239217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD86C65BD4
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 19:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 90825241A1
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 18:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587BC3016F9;
	Mon, 17 Nov 2025 18:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WDOYbggP"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3AA262FD0
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404590; cv=none; b=bz1RuXNlL3Oe9KxkrxapLcXTI3JC3DagH1tzUhYOeJL22BZmpELejMvsqDwAk4Nm6DhLc6I0EJv4ftyzZqVuY4HLsdQNjj4I5Ut2PV03JkXIgXKboL3d0hvl4noG8B+2Onrr95stpibgHDYDgUPFTyES29A6xm3Vm9TvmntPyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404590; c=relaxed/simple;
	bh=Y75/5lI7MOBGyhHp3TMh06ab+pJvdnTlIRKltBYZjpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJVcCoISRuUSi6Cg75vu1KpjiRHQmte2XfuNXBlxgv1By/818ibSJl14cwXacmq6lQ26/LaFVWnnBHXFphfWphDQbNdkt+40X2GtGvJBZPncMzhR0AQdxQ1Mpt+84ZKMVq0AliMisTBOmhRuRzUutFhsTSPI+17CuxHXdDgIpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WDOYbggP; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <be091ffa-aa9d-41ae-adc9-e5679cfddf7e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763404586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y75/5lI7MOBGyhHp3TMh06ab+pJvdnTlIRKltBYZjpU=;
	b=WDOYbggPuuTzt61dFThSWu1Rx7MENV+X6AeCIJJvjMrWgW9bmdZ2Efu26GU6GUmWCzoAXd
	SvI4+aI8cg5TvgeQD2hcS78O20sM6kr7z9PdIUTQG9fU6GhUMd69+SvBZg4NVB3xvMAWfx
	WukxkdleLBAw2Cr0q5rgMO1nTycxK3k=
Date: Mon, 17 Nov 2025 10:36:21 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 3/4] bpf: Save memory alloction info in
 bpf_local_storage
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, memxor@gmail.com,
 kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 kernel-team@meta.com, bpf@vger.kernel.org
References: <20251114201329.3275875-1-ameryhung@gmail.com>
 <20251114201329.3275875-4-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251114201329.3275875-4-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/14/25 12:13 PM, Amery Hung wrote:
> Save the memory allocation method used for bpf_local_storage in the
> struct explicitly so that we don't need to go through the hassle to
> find out the info. When a later patch replaces BPF memory allocator
> with kmalloc_noloc(), bpf_local_storage_free() will no longer need
> smap->storage_ma to return the memory and completely remove the
> dependency on smap in bpf_local_storage_free().

Reviewed-by: Martin KaFai Lau <martin.lau@kernel.org>


