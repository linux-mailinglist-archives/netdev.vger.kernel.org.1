Return-Path: <netdev+bounces-300558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YVmJIRKVNGojcAYAu9opvQ
	(envelope-from <netdev+bounces-300558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:02:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 086316A37E2
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:02:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="NG0uX/Jb";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300558-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300558-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 591BE30136A7
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 00:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0E01D54FA;
	Fri, 19 Jun 2026 00:59:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4151C23BCE3
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 00:59:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830747; cv=none; b=kFMGAILqpTuYb6to304QZ+Vfam69rKWt7r3T2Y25hBrG9HqmuBiBN4vjuBlvQh1UfNerljinZqEqj6US4pR8qtO0xczpehcZBdkzsltEiJKUlXxB5qtJSJyIVvMOxiwQJriWv2sA525khumXmQDGhmZyR9uKYOhGMJQ+xjX1hp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830747; c=relaxed/simple;
	bh=Rjd+V97MCbLCcsgQyw06CwHPqH7WvB5NMS2aRmiXJUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JGeXat6JZXq9qG40CPRtX+DYmqyftk3dS58j2hV9h15hJlOfePz7SyAyHu90VVemIN5sP/O4L26/LrI3dSMQmaQAcpVbQiDZp+dSdM/pefIDzl6NN8N+Eg8XnnlVq+4VTZvp0XhrfW9+E0cFzNrm3z9WDCmVY2HJocezRUxHb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NG0uX/Jb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904B51F000E9;
	Fri, 19 Jun 2026 00:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830745;
	bh=9hWlDqf2WyRdwxHrN6yAbJlUjDaNZ1F+xSraQBqQXf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NG0uX/JblLyIWMXuMDOsrxkoPdxEYSo5/djD7aDhrFR6hJ4CCYGJmFJTLg7gl7NCy
	 sYyrPUnCceiTFE3+hgpPt9+/W8G/cyn2FUjiN69GqGS3S0ZimYRBAfzQ6pgNVzazvR
	 gC6bwZRtVuGPi/rUn95FEyJTjRUHEb+/EJaQtjP8OXjlgYfCudbYKw6YWnHp1K6U6z
	 5inTXTrKNEDtB4HQfS0bfbfgRI2/QXW/nYKp3yjAxtz16669i1fYaWUjHnTt46OvhY
	 ps+b66Kjv6hLl+E4zViSGGWIZmR0HEKSQp2ibV0Tetwh1MShNVDr+XvVES469kH1U4
	 E8Zh43mxMU82Q==
Date: Thu, 18 Jun 2026 17:59:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [net v2] net/sched: fix partial tx_queue_len change rollback
Message-ID: <20260618175904.4833cea7@kernel.org>
In-Reply-To: <20260615031824.314112-1-zhaochenguang@kylinos.cn>
References: <20260615031824.314112-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaochenguang@kylinos.cn,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300558-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 086316A37E2

On Mon, 15 Jun 2026 11:18:24 +0800 Chenguang Zhao wrote:
> When dev_qdisc_change_tx_queue_len() fails partway through updating
> per-tx-queue qdiscs, previously updated queues were left at the new
> size while netif_change_tx_queue_len() only restored dev->tx_queue_len.
> 
> Pass the original queue length and roll back successfully updated
> queues on failure.

I don't think it matters. Also net-next is closed.
-- 
pw-bot: reject

