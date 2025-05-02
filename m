Return-Path: <netdev+bounces-187346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDF1AA67C8
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 02:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362401B63B83
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269718BEC;
	Fri,  2 May 2025 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hvH64pMB"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662F5801
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 00:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746145358; cv=none; b=T64PurPJavROa1rmaBQdAgfsVec7tlLH1WG00aMYwO048adSSXN8Pi6JQthorcbOgK29d5YZv1AAdAYcQv9G+8STcxuj85xiPv5zYOoN1u5tcsuhqv+bxJsDKwpCgXF9AJr3z3WCDU0m7m3rDaeSwQVHKHppZHlV6ytEETuxKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746145358; c=relaxed/simple;
	bh=IEhzS/vr3MjwusQk86c5ZIiz3yPn+VmO4mSf5vz93As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gltWpSOdEBWUE28YcLjpb3+4+fp1XS6Y46Fgsaz5x91d1VGRKwIIq/0gZZz4kSTDx0LMWwm7YLAz5rE1bXuZcJE7sE2SSWh/zkYhgoPKb9zt7nm/Fy8EMRQI53cBt6D28WhbuAAVfsIzrH9sDOLYHxK0uqEj7baw/k/AL+kd+XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hvH64pMB; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b395276d-81d4-4a6b-aaf2-297c78a6c33e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746145354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IEhzS/vr3MjwusQk86c5ZIiz3yPn+VmO4mSf5vz93As=;
	b=hvH64pMBQno4SJ9JLewiaMn7Ay6peDUKVjSxHmkkC8lfAni+wxErm5XLzEi/wUj68NnaVV
	Tk5CIKjE8QecnvHIwBygFm74aW0NdNrpkXOgoI2bE4MsH+TLtzF+YVSdG9nUDK3AD2buJx
	vROSGl9denWWut1pad7PzBEV0UNWeJQ=
Date: Thu, 1 May 2025 17:22:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next/net v1 5/5] selftests/bpf: Cleanup bpf qdisc
 selftests
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, xiyou.wangcong@gmail.com, kernel-team@meta.com
References: <20250501223025.569020-1-ameryhung@gmail.com>
 <20250501223025.569020-6-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250501223025.569020-6-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/1/25 3:30 PM, Amery Hung wrote:
> diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> index 65a2c561c0bb..c495da1c43db 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_common.h

There is a recent change landed in this file.

Overall the set makes sense. Thanks.

