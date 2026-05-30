Return-Path: <netdev+bounces-293297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AXxBjJSGmrI2wgAu9opvQ
	(envelope-from <netdev+bounces-293297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 04:57:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3812160B025
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 04:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D2583016526
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 02:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520F933D6C1;
	Sat, 30 May 2026 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o4H9iEWr"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71219332ED0
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 02:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780109870; cv=none; b=CLmv8uo5Ma7/TrZqLrhtXAc1iAsYOsEncT4w2vYYlpRoLlTpD0C4qjx45iEbkH6AvWJ+lGacEIWpGSoSCfglLW+Sj7+KLJfXWfeJmUlesdx2NpBNI1Qs2pWvnT7vWi7X+HMcxU4W0ouwEUsIlen/jWRJVoxptRRhIQy39YwCFSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780109870; c=relaxed/simple;
	bh=hzmV7jCw4Ve6lJJtReFG4xws5w/86mHQ3cXJgWEv2As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=marEiURS7oqG+81eW/mR1WoeCQkFBJyCVZFZCMPDY7gEdCg8x1IpaYf70C4CJhpVB7TpLPLInlZL2b7X8NLTILgiMK1aTmSoC5riUrTcckCN6odd8rSUuqclranOMcBiqcAqFl9L5mx3u82bhaB3JDoljznIm3Uz0OZsP20KjDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o4H9iEWr; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 29 May 2026 19:57:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780109866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzmV7jCw4Ve6lJJtReFG4xws5w/86mHQ3cXJgWEv2As=;
	b=o4H9iEWrQi7ekeOvZA2Y4XLn6PxJewqI+nnSfQRu743DVM97puDrZO97ojwIrq2Da8F6so
	P1MEabCrzP5yBwpyQ6uXNnsz+8WqZiTrbEznAVL/mfPUtiLhjjNbQMJsy/jhXts5swDlFE
	UsN8l0lUJrU9aKSL1NePdojWB54wPvI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	netdev@vger.kernel.org, Amery Hung <ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: MAINTAINERS: Update bpf maintainers
Message-ID: <202653023041.2jVo.martin.lau@linux.dev>
References: <20260529203909.1222164-1-martin.lau@linux.dev>
 <CAL+tcoCtph-RS2sASvPtYpiLrmLjNgxp0GfvapzWfQods4owHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL+tcoCtph-RS2sASvPtYpiLrmLjNgxp0GfvapzWfQods4owHg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293297-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3812160B025
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 09:35:47AM +0800, Jason Xing wrote:
> Maybe it's not an appropriate timing to ask this, but considering the
> further development I really want to know if you'll continue with the
> latest series around struct_ops? Or you will delegate someone to take
> over your work?

It had already been discussed in another thread [1] that you were involved
and cc'd. In short, Amery will respin it.

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20260523083001.2911931-4-kuniyu@google.com/#26971716

