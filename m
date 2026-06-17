Return-Path: <netdev+bounces-300273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nJVMJVAxM2oa+QUAu9opvQ
	(envelope-from <netdev+bounces-300273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 01:44:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD26569CD2E
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 01:44:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HRUTaPcC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300273-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300273-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4486C303789D
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 23:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEACD388E61;
	Wed, 17 Jun 2026 23:44:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1736C0D6;
	Wed, 17 Jun 2026 23:44:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781739853; cv=none; b=BLLCWdmSDsAQpoTE8cqA9ZS3395DnNx/uS6CSNn4tOtlByN0PbKIg7Zqi00nCOO3eq5joEV8pn/WI2Rs+8nTM31h6dswe9YflXWrnbwKWOfW7NsreO2UZxlE6/A7SfCiAl+wbpr1kVM/O2LLCEhLWdR84R1enhCnBYc2d/WnKwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781739853; c=relaxed/simple;
	bh=n+8cwEaVXErqF6WzIqE9szcvsqiSOD+DxUKRBL1NBno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hmfa7IWJ0buIWul3J8NVNF9EvfgOrO520oenWqkIHI1yLL1O1Zp3eExgGkq7hXf0zXTflXYjx5k9S8XBRo06F1H9AIUUBsG+QnhPZ+MN2u4EPw5b/LTLtsDAMfxAJrOIRttXeH/oBuYyI/c156swJLY8fAil+GfMDk6HfZRfxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRUTaPcC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00541F000E9;
	Wed, 17 Jun 2026 23:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781739852;
	bh=qK7KTJY6sxQ3+gp4VQ4GNluoj9voS4ivxAftG1ha/mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HRUTaPcCTQFXCUPAdzU+/hSYORtUOy9oojwpIUGiida4rjYe7LxBJOrlop/QcEUkU
	 kZ0oWHvvm+zHCHkZA2KDxly+0WT3Ym2gU4IcMpT9C+QFK8pCgglSzPgrmeWVHlLr1u
	 4x8XFRo+0r4mSeQcnBzU6Z+alelYfXK4+84hRb1jRwmy500nUqBMgHm27EwLwmp/n+
	 tqTphNTgWa5UePVdzDz7hafFIJBOZ5tN9EM9U5v6S1ddr3rBotJxSFwe1dD8COkrjf
	 TubvoNzGpizE2JUconbMp8QyWwCcmbf6rH4rI7XZZnLga5vFdCPO8bxPBK6jnSxCMs
	 PbsVOnHaGE0JA==
Date: Wed, 17 Jun 2026 16:44:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Ziran Zhang
 <zhangcoder@yeah.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rocker: Fix memory leak in ofdpa_port_fdb()
Message-ID: <20260617164411.2a8a260e@kernel.org>
In-Reply-To: <61892bd4-7368-4cd8-b360-0267e5c47156@lunn.ch>
References: <20260616013245.7098-1-zhangcoder@yeah.net>
	<1446e974-0df0-4956-b2af-7a9403da3c8d@intel.com>
	<61892bd4-7368-4cd8-b360-0267e5c47156@lunn.ch>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300273-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:jiri@resnulli.us,m:jacob.e.keller@intel.com,m:zhangcoder@yeah.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,yeah.net,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD26569CD2E

On Wed, 17 Jun 2026 11:26:46 +0200 Andrew Lunn wrote:
> On Tue, Jun 16, 2026 at 04:29:59PM -0700, Jacob Keller wrote:
> > On 6/15/2026 6:32 PM, Ziran Zhang wrote:  
> > > In ofdpa_port_fdb(), the hash_del() only unlinks the node from
> > > hash table, but does not free it.
> > > 
> > > Fix this by adding kfree(found) after the !found == removing check,
> > > where the pointer value is no longer needed.
> > > 
> > > Found by Coccinelle kfree script.
> 
> Is rocker actually used any more? I'm not too sure of the history, but
> was it not added as a way to develop the early switchdev code? There
> was a qemu implementation of the 'hardware'?
> 
> Is it still useful? Should we actually just remove the driver?

I think it came up before but I don't remember the conclusion :S
We should either add rocker to NIPA or delete it. Jiri, WDYT?

