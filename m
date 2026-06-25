Return-Path: <netdev+bounces-302012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TJUFDWJOPWo21AgAu9opvQ
	(envelope-from <netdev+bounces-302012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:50:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B1E6C72D0
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:50:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Cxirriyr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302012-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302012-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FD73304F159
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C30286430;
	Thu, 25 Jun 2026 15:50:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FCC26F2BE;
	Thu, 25 Jun 2026 15:50:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782402654; cv=none; b=QpDjDT876kiCnJRxCwG8nEMt2Y8Ijoe74t9q5PHPLbRvQQq7YGXz2Q1R9mALbu5I9EHwJoIgZRJevFQd4wBaJtUEI66uI+CZhFo8Y6noRpC3k02R8DN7XmTVKGKh3GfV0ROAiIGEXcelauTxW/2v/ZE5Kxe+x0LxAInqy/9X4pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782402654; c=relaxed/simple;
	bh=Xua+NYnaSH1l9Ao5um1gafGnnKxCsTFB/0paNbk8NsM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHj7aSFGuuFz/s0NQdaNIQK2Z91S4fchQOlwOo0ATezf+90v7W684PgGc7VdP+2yX35w8OAA1ewpTxUgJygMO8usCCOmx63GbXBUEQ07KLhoE1Kc2h66/bCvsJGkQ6rImAK4QlEqswrBjv5q6k8KS6XW4xY6Q5RLcbDTiscspno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cxirriyr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE541F000E9;
	Thu, 25 Jun 2026 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782402653;
	bh=Xua+NYnaSH1l9Ao5um1gafGnnKxCsTFB/0paNbk8NsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Cxirriyrvfzx7E0buS5oxIjptsE0CR/KpFW4dqc8gyNNYUdg262XC2BJhKNKLihRI
	 OGd19d79+HUy10js8yZh/gNBHplpX61lAQVr6d5XX6G+F+nobcS8ILfzr3a+ySNK2Z
	 GFrTcshoDAzn1er3KdptdzgUCf6AhqhGDCh1FaasDOwxlYUiqLOS5nWKgVbRnA0AK2
	 DBPq6WXiHntmjC76Ej90fakYfUN8PtHl24C25eeNd5iDllr7HET2ilyrBrlzgFI6Nq
	 TixuiATHMDzL7vp5QcPX+pb2uUOPO4hzSD2KzGobmjOvYgcL+7ENGZxzIx1i+vkVjg
	 vrRexTv+avy7w==
Date: Thu, 25 Jun 2026 08:50:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 <nshettyj@marvell.com>, <rkannoth@marvell.com>
Subject: Re: [PATCH] octeontx2-af: Free BPID bitmap on setup failure
Message-ID: <20260625085052.031371ae@kernel.org>
In-Reply-To: <20260623114316.2182271-1-haoxiang_li2024@163.com>
References: <20260623114316.2182271-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302012-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nshettyj@marvell.com,m:rkannoth@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5B1E6C72D0

On Tue, 23 Jun 2026 19:43:16 +0800 Haoxiang Li wrote:
> nix_setup_bpids() allocates bp->bpids with rvu_alloc_bitmap(), which uses
> a plain kcalloc(). If any of the following devm_kcalloc() allocations for
> the BPID mapping arrays fails, the function returns without freeing the
> bitmap. Free the BPID bitmap before returning from those error paths.

Marvell, you are actively working on this driver but review none of the
patches posted by others. This is your last warning, please, you have to
start reviewing the fixes.

