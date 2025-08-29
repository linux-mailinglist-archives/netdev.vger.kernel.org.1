Return-Path: <netdev+bounces-218356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1DAB3C260
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 20:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687A0205F73
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C8C340D81;
	Fri, 29 Aug 2025 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KA3788Ke"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EAA1401B
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756491741; cv=none; b=NhQJhaCsl25ts49JFcbLO8qIHIr2QP95f/raToUkdfz/QFDqtK3U4t5idETdOmwILSXI9Ag/W9R/M5gmHLCHsRngPUFqeQxI7WQq25jNHRcjKiPU1Ztt40cse2G/4uVg2lqBZnvf2XAtRxLMvNhWu2Qz1hzzhAJ4BNyUlsptfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756491741; c=relaxed/simple;
	bh=f/o3yyuAdpIS6fumQMRpWedhDk0OWbhdvg4/SpRnWJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mRunHrmg6yjrgaAXD9Kj7RjxuvICjoO45KSB9KmWMWW8kguJS8JE9wOB1H+HhD7L0S2tL45o6jnfH4DP1TDCzciybzvBtQYFT2LZFHoTFS5W5+94+SEAalqHPKJfwmDB4WGKQd75oERgCcA/YpmJOKsv8/u/vZAGbqn1+giySe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KA3788Ke; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <afdc16b0-fd53-4d4c-b322-09d1a0d8cb86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756491726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XnZvhtXoRglRMKZgokPOJEDrhVDhrptaz8Qku4BP0U=;
	b=KA3788Ke7GaG33hXsu9TCaS5uBwows913gtMyiGnb+ND8INwYGg1BIIMpvHmXo068yjlW/
	kqOB7JLO1Jufq+jccj0IRnxz+7K2/A2BOhk5M/EhkapDHfUZ/TOb3sQfxrK//tGVClrb3q
	Op4UvO04tb3RQOkuvZNq6suywE62Hn4=
Date: Fri, 29 Aug 2025 11:21:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v1 0/7] Add kfunc bpf_xdp_pull_data
To: Nimrod Oren <noren@nvidia.com>, Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 kuba@kernel.org, martin.lau@kernel.org, mohsin.bashr@gmail.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 maciej.fijalkowski@intel.com, kernel-team@meta.com,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <20250825193918.3445531-1-ameryhung@gmail.com>
 <7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <7695218f-2193-47f8-82ac-fc843a3a56b0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/28/25 6:39 AM, Nimrod Oren wrote:
> I'm currently working on a series that converts the xdp_native program
> to use dynptr for accessing header data. If accepted, it should provide
> better performance, since dynptr can access without copying the data.

The bpf_xdp_adjust_tail is aware of xdp_buff_has_frags. Is there a reason that 
bpf_xdp_adjust_head cannot handle frags also?

