Return-Path: <netdev+bounces-210240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D9EB12789
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 01:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90A64E700D
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9064925FA0A;
	Fri, 25 Jul 2025 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a1pmWihm"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB0724169E
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753486673; cv=none; b=X+CEabc40fXYGg0rvw0Qb4oywU1Cc/lqlwNlTxfsmUhWUtKRN1k+FG6ybLUY1cLt5cHzRH8vzPAqqqh4QFzxKJqGzu9icqofnlObQMUtufIQZrxTJGMSzX0ThOXfTpQ4fJdrhIT6mZz3SzeD07jlvkiPRWtaLqsohevPSJaV818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753486673; c=relaxed/simple;
	bh=N0TfL4gpC1ZuIaRu5nGKRxW2BDTknFjgsfOBolgax5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hF/GNhhQeOZw0QFLW18wVmfQSvNqZ8Wy6/A1+E+jtN9/U+vChyd3IXGzSctoik3Hfqu47sK3Sr0jiuB6mGzgbo5tjkb6gf9g92FedX/xUZcgtwj0qULPLDPKH+wEifjtDW4OFZ5OnsYI/caWrc6UjXh/SoGqpXvqkdbTvaNF9jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a1pmWihm; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <41b23698-b577-4dcc-ae43-6a7d5294dd9c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753486669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N0TfL4gpC1ZuIaRu5nGKRxW2BDTknFjgsfOBolgax5k=;
	b=a1pmWihmzf0vA+EkA2KUQzQ3CC3MUAvdYeBOjbLwoGDQ+G7wJRV0LEMx+oXcMS7zaMOdgk
	g6wvxjJslE6FTBgtwFcUEjeIJEujfokJlJHBWBAWtU6bN83Fw5luSNiqZ10TFVliUdTqsP
	PL7GePBMii0J7oaZs/OFBAbwYGjeQHA=
Date: Fri, 25 Jul 2025 16:37:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 4/4] bpf, btf: Enforce destructor kfunc type
 with CFI
Content-Language: en-GB
To: Sami Tolvanen <samitolvanen@google.com>, bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250725214401.1475224-6-samitolvanen@google.com>
 <20250725214401.1475224-10-samitolvanen@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250725214401.1475224-10-samitolvanen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/25/25 2:44 PM, Sami Tolvanen wrote:
> Ensure that registered destructor kfuncs have the same type
> as btf_dtor_kfunc_t to avoid a kernel panic on systems with
> CONFIG_CFI_CLANG enabled.
>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


