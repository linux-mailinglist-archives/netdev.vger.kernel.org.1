Return-Path: <netdev+bounces-271200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EezA4jMwmkBmQQAu9opvQ
	(envelope-from <netdev+bounces-271200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:40:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6166331A2BC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C936305CA86
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C07E391E55;
	Tue, 24 Mar 2026 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xObZ/YQ3"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D2283FEA
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373670; cv=none; b=mkjHZhutMtiix6cdlA51QwLPdJCvXkLRLJxEjojvcAmW8aKlJL08lHYd7bE+uBocx29rDhUop4YkXv9BmIWuuN/HE2sfnkGpDMEB8eiInGqpk3Uj/Cu4D3ry2dnCOlLQ4hFA+o6KF52SexCN7jtEcBvQON95MY8HFUQp3kbZyf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373670; c=relaxed/simple;
	bh=gywsNUK0xaQ5/M5DTfuh2A78fRzck1sU9Y6jpu4e2E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h81UWrNtUZXDj4SL4McfwBC4iGpQdzgOan0Qd4iWIg7h3m1FdIBpaIPEu8I3KyYJ+T6AKNGP1NjXBm0+B5csGYA1yvelHxX23KJi0oWGmsr1IE6+O1/sSe+Kp8BrRUUrJGyIjKyWOim/FI/gtExCLKxZJsM9rRsdIcendjV2pN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xObZ/YQ3; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e5a2ad16-d2ac-4fa0-be41-162227257682@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774373665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ws42Rf5aPBnDXSt/oJVoEIiUzpyDal06gBdo0Z7vkQ4=;
	b=xObZ/YQ34o/vPvH/6jC4FDj95XmRIFagmpTMrcCf/gzyFw/TCiEKEoSoqmSLpQAWsh2KrU
	kHDL34O4ivK3Wsj/rDI2CtlZKUd6JFnnctF6K4tGeqi6ZFpZs9nHIA0IftTdBlyY8WNGiZ
	amB7vZtMoTFb0N2q/7QONEZRaotwP8E=
Date: Tue, 24 Mar 2026 10:34:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/5] bpf: name the enum for BPF_FUNC_skb_adjust_room
 flags
To: Nick Hudson <nhudson@akamai.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Max Tottenham <mtottenh@akamai.com>, Anna Glasgall <aglasgal@akamai.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-2-nhudson@akamai.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260318134242.2725749-2-nhudson@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,kernel.org,iogearbox.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271200-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6166331A2BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/18/26 6:42 AM, Nick Hudson wrote:
> The existing anonymous enum for BPF_FUNC_skb_adjust_room flags is
> named to enum bpf_adj_room_flags to enable CO-RE (Compile Once -
> Run Everywhere) lookups in BPF programs.

It would be useful to demonstrate the intended CO-RE usage in a 
selftest. I suspect it is bpf_core_enum_value_exists().

There are existing tests in test_tc_tunnel.c for the earlier 
BPF_F_ADJ_ROOM_* flag additions. Please add similar tests for the new 
flags introduced in this series.


