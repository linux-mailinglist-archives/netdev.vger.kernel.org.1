Return-Path: <netdev+bounces-296654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rSMfGwzrJmp9nAIAu9opvQ
	(envelope-from <netdev+bounces-296654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:17:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BFF65898B
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 18:17:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Xi/WSke0";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296654-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296654-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E8E230E6BDE
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 16:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472D7332EDE;
	Mon,  8 Jun 2026 16:03:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420632FA3C
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 16:03:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934616; cv=none; b=nIFS5psIYAoInpzPyqiHUg/cyS3FPny2zhIKyFjrBzmU6B97ZsAwHj5MzIY6MprfmYAI6SRy/g8wXTNb0E8pM68VA5vhXy9jdTcoJiGMr56CALMeNIQzgBfAfaVq/NQnEcAi+8pMIv1dbAYpqlwC8XXBLdfxkPK8/6fXxAfZ3oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934616; c=relaxed/simple;
	bh=oAUFrV7Dcmzu+Gtgt2bMcwfnBbwk5+eFMBwXtUsRYBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKFB6KZ8LFju0dSIr3Sr8ptMbGtVeZ7v9eMtseNKOlna2ejkV6V4iv9sCrLJY23mxZTEHTvouGmbnI2p36QlXcMfFzJjtRsjkL/O+w0kLeyREeR0HU6V1/shs/OcC7GWEk13HaGarM+rZW22d1fU1w7QzbHa+LOi0PHoyU2Nl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi/WSke0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995381F00893;
	Mon,  8 Jun 2026 16:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780934615;
	bh=bTFwLlP9Xda5SAvgZ1W/YNCfrYnOgGpX1iJxi+v1uJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xi/WSke0bT7EQ8BFzZx80hHvV4g+lTsFkERPCp9PRpM67t99R1KGFKkmaEbHYUiet
	 v8bOqqjIaz/SC9hJBLneob8UGUAg7SbRw+CZlhEw7GNlAMDM94e4sV0ZsOXvrIA9sE
	 yZRdHOvNUmnDd1aTE6ZHwovN9mRxp0AjWkLLAxf2iZ/l0174+tvLIY2+Yvohu2sKjK
	 juDxylZMmeo+NiQDFKKOwasXWswfLFpcx/OMSpJoxuni97QDMnedQDeuNuXrA4sSEC
	 5CpcLMfrwdh8xSvkJ5q41m1uy4OLpE8YatI7QLCHbXWwhLTj/6J1AuJXIDzTxShiQN
	 hVWCut513PBAA==
Date: Mon, 8 Jun 2026 09:03:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, idosch@nvidia.com,
 dsahern@kernel.org, Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH 1/3 net-next v5] ipv4: centralize devconf sysctl
 handling
Message-ID: <20260608090333.21c94721@kernel.org>
In-Reply-To: <20260607110123.5939-1-fmancera@suse.de>
References: <20260607110123.5939-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296654-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:davem@davemloft.net,m:idosch@nvidia.com,m:dsahern@kernel.org,m:nicolas.dichtel@6wind.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38BFF65898B

On Sun,  7 Jun 2026 13:01:21 +0200 Fernando Fernandez Mancera wrote:
> The logic for handling IPv4 devconf sysctls is scattered. Notification
> and cache flushes are managed in devinet_conf_proc(), while a separate
> ipv4_doint_and_flush() function and DEVINET_SYSCTL_FLUSHING_ENTRY macro
> is used for properties that solely require a cache flush.

Hi Fernando!

Do you have the necessary iproute2 patches pushed out somewhere?
I'll pull them in the CI to make sure the test works.

