Return-Path: <netdev+bounces-86235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD1D89E248
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 20:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF48E1C21F8C
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 18:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AD9156976;
	Tue,  9 Apr 2024 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ea40nUyK"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC28C156892
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686337; cv=none; b=pCISYDw+zeaJI05gIefE9FgCvVhF4W7gmdTUxbFVroFNya7QoQSRFTxsGNgnSUOnzyrqiHbfOQCSfSvbAlq+u7TrBRq7TJoUU7YnCNml0/3/lVnZeXpg9eJVyAcAzp9eUqgLHr6GuLMSerp8PkJOxEVuH5olCuH62Qd7n8tu40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686337; c=relaxed/simple;
	bh=eExvf1Wnreqhust0esuy8i68C6xvkeXkDenKE0RpKqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qLlehOXg9+ZqG8QjmRhLymVcl2Kb3xfm9wNMr8DdjDpJXtQT26ub8wpqMVtpUnns/98UGzEq4hcy2i5bgAzAPEpobIOunVrYQu5tRfXywJAPfbXuU9RYENZ0OUfqfY6fo1suSXpHmRJhcCzFVrnTfbd/KOtJ2dVazAgjt8SGeYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ea40nUyK; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <31821bdb-01bb-4574-9f0c-fb6fb50316d9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712686332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eExvf1Wnreqhust0esuy8i68C6xvkeXkDenKE0RpKqo=;
	b=ea40nUyKTp5iR7t2T6WSh3MTCHgLMvov/0QamjEW0KTXsUA3+xn3zbSKgBgvi5cNDiDbVq
	eC+910r9aOAb4+m0fMZmSVla4O4cZBqzRJo0gQlYbTscD/wL886mqEz22Lz9h+dM5DWiFh
	rTn9br/hei+2i0nH+FgCjE43FhQsM0w=
Date: Tue, 9 Apr 2024 11:12:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/4] selftests: move bpf-offload test from bpf to
 net
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, bpf@vger.kernel.org, andrii@kernel.org, mykolal@fb.com,
 eddyz87@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20240409031549.3531084-1-kuba@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240409031549.3531084-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/8/24 8:15 PM, Jakub Kicinski wrote:
> The test_offload.py test fits in networking and bpf equally
> well. We started adding more Python tests in networking
> and some of the code in test_offload.py can be reused,
> so move it to networking. Looks like it bit rotted over
> time and some fixes are needed.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


