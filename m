Return-Path: <netdev+bounces-305441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dkvfHxv4TGoyswEAu9opvQ
	(envelope-from <netdev+bounces-305441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 14:59:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 772D571B9E3
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 14:59:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cruJ+f6k;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305441-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305441-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C1B6306E712
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 12:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627913F86E0;
	Tue,  7 Jul 2026 12:55:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4D240D560
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 12:55:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783428917; cv=none; b=GnUpuHQHXcg4NXYAzrhnsmg0pOywuAzH0ELePPvU0JNIEO1Jb743A1PKZEIk7W9Oup+IElAZa/31x4SBL2ykqS0oswsQjPJAiz3q/xPGNTq2+ZHc93jG8k98eZgQg6V+0OiJWUZTeRtWphuPqTLttGCMdYaqJbqNYd7tRuTggso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783428917; c=relaxed/simple;
	bh=RvrK0eHciY43FGq0J9Bs52BHiC0uCne1sQjE8EEUj50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6LH9YaUuR7ilGvW00hIzH5MHDfXq1RjgGRJrbLmzA/aUK/krs8B97Un//KHDbIQFPhlWmsZqWDUeK90ZjhfW0uekNqjhYpIxAj1GBH1V+Aalq7w9VKwnaSyyDGpxwHXPeHaGbM5trwHIfNqXuGkodmysD2zBcZQnzu66f+BGa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cruJ+f6k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8181F000E9;
	Tue,  7 Jul 2026 12:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783428915;
	bh=YT0pA/hYKGagg+Dgj3aRE3Asay2Q+BZOYen5/SRfkgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cruJ+f6kEkxSlTR9XlGBMM9zP7/MBffL0wJrH5hEMk0CMS6shVlGU+jmvLXQu+hKY
	 FjKFjCU8t0udlJbpjCVsRNYE71PFAGOE8wtYFa3wlvd+OzMcuwKfpI5gnoJdN5zNgK
	 LWRkj5CIaMbNU4jvhYk1CPZzEPPKSvtVORE3z+DHqEnSiqUI+JhWjeAxZIebKrQbJH
	 NuaKWuKLVVusluLOEOHN29U7Bjh/RKqGDklPAec8MVFQJEGeGj79W3doZNWm8mLFqT
	 Agf1tbhOA071Zie9/UYsdlrs/tLyxPsLlqkAaK733afnn8FtOb6WyUeiBurDF8j67A
	 jITTzN450hTgQ==
Date: Tue, 7 Jul 2026 13:55:11 +0100
From: Simon Horman <horms@kernel.org>
To: Yinhao Hu <dddddd@hust.edu.cn>
Cc: David Heidelberg <david@ixit.cz>, Kees Cook <kees@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Dan Carpenter <error27@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Michael Thalmeier <michael.thalmeier@hale.at>,
	netdev@vger.kernel.org, dzm91@hust.edu.cn,
	hust-os-kernel-patches@googlegroups.com
Subject: Re: [PATCH net] nfc: pn533: hold a reference to the request skb
 during send_frame
Message-ID: <20260707125511.GD1364329@horms.kernel.org>
References: <20260626073434.3977525-1-dddddd@hust.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626073434.3977525-1-dddddd@hust.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ixit.cz,kernel.org,gmail.com,linux.intel.com,hale.at,vger.kernel.org,hust.edu.cn,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-305441-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dddddd@hust.edu.cn,m:david@ixit.cz,m:kees@kernel.org,m:krzk@kernel.org,m:error27@gmail.com,m:kuba@kernel.org,m:sameo@linux.intel.com,m:michael.thalmeier@hale.at,m:netdev@vger.kernel.org,m:dzm91@hust.edu.cn,m:hust-os-kernel-patches@googlegroups.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 772D571B9E3

On Fri, Jun 26, 2026 at 12:34:34AM -0700, Yinhao Hu wrote:
> __pn533_send_async() publishes the command and then calls
> dev->phy_ops->send_frame(). Once dev->cmd is set, an incoming frame
> can be matched to this command: the I2C threaded IRQ runs
> pn533_recv_frame(), which queues cmd_complete_work, and
> pn533_send_async_complete() frees cmd->req with consume_skb().
> 
> On the I2C transport, pn533_i2c_send_frame() still dereferences the same
> skb after i2c_master_send() returns, so a completion that races the
> send can free the skb while the transport is still using it.
> 
> The request skb is owned by the command object and may be freed by
> command completion at any time after dev->cmd is published, so the
> transport send path must not assume it stays alive. Hold a temporary
> reference to the request skb across the send_frame() call so the
> transport always sees a live skb even if completion races the send.
> Add a pn533_send_cmd_frame() helper and use it from all three send
> paths.
> 
> Fixes: 9815c7cf22da ("NFC: pn533: Separate physical layer from the core implementation")
> Signed-off-by: Yinhao Hu <dddddd@hust.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

There is an AI generated review of this patch available on sashiko.dev.
You may want to consider the issues raised there in the context
of possible follow-up. But I don't think that needs to impede the progress
of this patch.


