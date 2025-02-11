Return-Path: <netdev+bounces-165004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB33CA2FFDE
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 02:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CD71885940
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE15A926;
	Tue, 11 Feb 2025 01:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uGI6rJK9"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929AD13AF2
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 01:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739235791; cv=none; b=qdkV8TuH3c25cgE33XCz95PWeBlepzWPP4seXi5qQa7UBYCmjaGNJ6t0HjPZ5NP6tuIx0Cf9/CJQ43gVd0nwSVE93UFxeaPRFcuNREqldW3y7QrXKkFYzf+DDamEiNOShARRKPLfp87LhH54DbBIolQL/C50u3vrsjP/UiJiZ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739235791; c=relaxed/simple;
	bh=YRkGv53NmehvbgTyVh3MND0QTMa0DIwt79CeIBVq6bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBNxuQxVyqZpsC6/q55CNwhgKmeF5K+VHQ/+umKZWAQ3dH3TVIyKtqRKiGkZWpz5Iy0lMPwFE13VKlyY7zkgYcGC7JdPiTNem0MaBMRMhiDuXqfDaEMXahjdZ4NNP4Yv41rR8WDegbZdJ/bHxjfbnJnko+Xmn5B4Dj8gUWO3edI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uGI6rJK9; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <85d1b9e5-e1c4-452d-af50-e5c3784372ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739235787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+bYkwK/w8k3PLo3KPoZlYCqyZGi7FumIVoNE1Pd0LA=;
	b=uGI6rJK97qKTF6XgJRqAbIwXBu+KccFf9K2t3eO7yCgeQ+YfdwiYIHu8LRnkZTl27SiKB4
	e5TztRwPa+KtfVZuS6fZ4P93laRJkcOIcaFW0PJeHGHVeZ1Fuxc04o4MPKxsgL5tTzSXJ3
	e/Ry52Yfp9RMaz4/9Nk+DR4HB0ftQPQ=
Date: Mon, 10 Feb 2025 17:02:59 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 01/12] bpf: add support for bpf_setsockopt()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250208103220.72294-1-kerneljasonxing@gmail.com>
 <20250208103220.72294-2-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250208103220.72294-2-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/8/25 2:32 AM, Jason Xing wrote:
> Users can write the following code to enable the bpf extension:
> int flags = SK_BPF_CB_TX_TIMESTAMPING;
> int opts = SK_BPF_CB_FLAGS;
> bpf_setsockopt(skops, SOL_SOCKET, opts, &flags, sizeof(flags));

The commit message should explain what is added/changed and why it is needed.
The above only tells how it is used, and the subject "bpf: add support for 
bpf_setsockopt()" is unclear. Add what support? Also, both get- and 
set-sockopt() are changed.

Subject: "bpf: Add networking timestamping support to bpf_get/setsockopt()"

What: The new SK_BPF_CB_FLAGS and new SK_BPF_CB_TX_TIMESTAMPING are added to 
bpf_get/setsockopt.

Why: The later patch will implement the BPF networking timestamping. The BPF 
program will use bpf_setsockopt(SK_BPF_CB_FLAGS, SK_BPF_CB_TX_TIMESTAMPING) to 
enable the BPF networking timestamping on a socket.


