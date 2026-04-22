Return-Path: <netdev+bounces-280284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEKQCKQq6Gm3GAIAu9opvQ
	(envelope-from <netdev+bounces-280284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:55:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E7B441333
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DADA30098AC
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 01:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB9C2D2483;
	Wed, 22 Apr 2026 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tRBhKfDw"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA741FB1
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776822944; cv=none; b=D7AoTSMEq9DU8DvhPHkFbI7XOIFDbrynAaRD6w0UJSKN2+HTR3qJ2H2PkvGelBtB9p/qKMloEvV3lV1mWSCp7e7f9DAxYhBWxNecxpPmBBmFrOQm6VigZGnelVfDGkuqzezhCcuTsm79d6jLonEbpn2D3HTQaLQtOBBSzdnAMN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776822944; c=relaxed/simple;
	bh=FsPj7/rcEceeVIbL/Lon/HzNlRrgPw9fr2OEh/b8gD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJYF9ZQ2AY0cGxT9lIDaYTyV7ipzHqaZHOXQe8J4gAgIbHpL7VPw3ei0QGtZ8NmnTwL/qm38iEjAtmNiIt+2Hu6h+/BmAiMhpoQ9lliownd1yznLJNuaZtu2CGFL1s4nWAlIl80/AgmiFiC2Pw8pcDkhKwW0nvt5HBsXeK1ng6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tRBhKfDw; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6eeac9ec-76f6-43ae-a943-942d1d5da1d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776822941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FsPj7/rcEceeVIbL/Lon/HzNlRrgPw9fr2OEh/b8gD0=;
	b=tRBhKfDw62rsBxeomp4gyZqvJv1RoYf0TgmkeC0a2vMdOSuVuzBZN8zxboWWCm2TnqCe+V
	je1b2WlLGWK9F1hL7rEwEwt/0Ijb2b20JDWrrTHfd+YF8mxOGwziPDjEmERzQroGFrAK3l
	Vk/FQk8Kwr2Hu3DBx+HXSplYMRoYlHE=
Date: Wed, 22 Apr 2026 09:55:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v1] net: validate skb->napi_id in RX tracepoints
To: Kohei Enju <kohei@enjuk.jp>
Cc: netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20260420105427.162816-1-kohei@enjuk.jp>
 <b943ec1e-417c-4157-ab19-b34aa6d63688@linux.dev> <aeYTImGIRuOf72mi@x1>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <aeYTImGIRuOf72mi@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-280284-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B6E7B441333
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/20/26 7:54 PM, Kohei Enju wrote:
> On 04/20 19:27, Jiayuan Chen wrote:
>> On 4/20/26 6:54 PM, Kohei Enju wrote:
>>> Since commit 2bd82484bb4c ("xps: fix xps for stacked devices"),
>>> skb->napi_id shares storage with sender_cpu. RX tracepoints using
>>> net_dev_rx_verbose_template read skb->napi_id directly and can therefore
>>> report sender_cpu values as if they were NAPI IDs.
>>>
>>> For example, on the loopback path this can report 1 as napi_id, where 1
>> So I think veth_forward_skb->__netif_rx could be affected as well?
> Yes. Just in case, I've confirmed the same behavior in the veth path.
> The mentioned loopback path is just a single example of possibly
> affected paths.
>
> Thanks,
> Kohei
>

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


