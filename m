Return-Path: <netdev+bounces-290640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNnVL1G8D2oyPQYAu9opvQ
	(envelope-from <netdev+bounces-290640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:15:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EFF5ADE91
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A480030205C5
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 02:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F542E5B02;
	Fri, 22 May 2026 02:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KsSDRojK"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44E2236F0
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779416142; cv=none; b=JsG8t2cOLV7UGRbV50llHU4+dM5wX0Ir/MGrLux/A8oubW+ckhZY6mWkR1PNqDnTS+rHIwFF0QAVNYTl9ZWyYrkASI+NnZbct41joe5EtPjZTKILZNa5VkpQSr303Ke1p//F3hWzJ9Kk/VlWxogfzsZRBcY4/LOiBNMaWoltHEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779416142; c=relaxed/simple;
	bh=fVER6ZeXBuKT1ycM4JdAgghqvGVZ+f8q3woknWLvfMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+pYNq8HrEVnAfJvL+4C1b/QkEHtHR+y0/sPRwT3fNEi3/8CsaJGUvgp1ggCR0ISndlt/ftx214M+YYDBh7EwJmd3L5cP4Qkx0fppYki1PrU39wgy4t97Z76qvDT2Vg+YBpymL1N1l1fXgvlyM0hLTb6BBNn3mp/qO9Es/IcrkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KsSDRojK; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9ac27ab1-1891-4734-9029-156a64e24c03@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779416128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fVER6ZeXBuKT1ycM4JdAgghqvGVZ+f8q3woknWLvfMQ=;
	b=KsSDRojKwiLs48+EBILo/SbPnmb9OxdTxgAFTBYwVePjqKvc1mSD84YPqqhgDfbhIlGfwm
	U4xHtoc1as21G5+9AB1O41hGCSHskiDmus1wb4eidePCNwpdr8ZqK5MJ8x1lhYfbcVaMPi
	4L6PgBxx011XvvX094PNhL/JXM4t3v0=
Date: Fri, 22 May 2026 10:15:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] selftests: net: add tests for PPPoL2TP
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Felix Maurer <fmaurer@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Petr Machata <petrm@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260514015743.37869-1-qingfang.deng@linux.dev>
 <92da057f-7e97-405c-877f-ad6a64e3553e@kernel.org>
 <0e6fa578-15b2-43c5-b5f5-a6e0a34c103b@linux.dev>
 <357a49a0-0742-47a6-bba9-6c406dbd6888@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
In-Reply-To: <357a49a0-0742-47a6-bba9-6c406dbd6888@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290640-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qingfang.deng@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,pppoe.sh:url,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 34EFF5ADE91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/5/22 9:43, Matthieu Baerts wrote:
> Hi Qingfang,
>
> On 21/05/2026 17:18, Qingfang Deng wrote:
>> Looks like pppd exited unexpectedly, but I could not locally reproduce
>> this issue.
>>
>> You can start a socat instance to listen on syslog (as done in pppoe.sh
>> test) to see what's going on.
> If it is already done in another test, and if this is not creating more
> troubles, it might be more interesting if this debug mode is always
> enabled. I would then recommend sending a patch doing that, than
> applying temp modifications only in NIPA, with a risk of causing other
> troubles. WDYT?
Sure thing.

