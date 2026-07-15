Return-Path: <netdev+bounces-307735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Pu9VNLRyV2rZOAEAu9opvQ
	(envelope-from <netdev+bounces-307735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:44:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A80275DAD7
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:44:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HhxOnmWg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307735-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307735-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BA5E306BBDE
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AFD448D18;
	Wed, 15 Jul 2026 11:43:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C444839C;
	Wed, 15 Jul 2026 11:43:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115801; cv=none; b=tQ045K0xdfnEb36TxIoBpDFIpu8UR4f9DwGXQ3CHVqQolF1dNJhQa+eTR5ATr+84kiyrNO/ajaBFy8a35hQ6ddNEEB1DxMAoLC8P+4eFOfhNpdGZi6m++d/PTjRCNDQnf06GgUsTDQW63BYhHHET8fz3ZHn9zFVIVIVymkt8E8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115801; c=relaxed/simple;
	bh=Jll5RMiLa0jMPTumfYjgdT9QstnUZJXFMv94INS7X+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrr3v/ASEqOPgyiQWycOgl5vQ76UNeYgbL1azvvcVs3GfKdstuROngxV8W94zOFDs1U2unRBs5k1ymAZoJXb7evchpOgXj4W75EThNBBDGS0nJx2m2npdcQePJ4Xfk65Nhf087VjSGvtONACUNqOk2ijyz84cRbAv2S+SlU8Sbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhxOnmWg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE0F1F000E9;
	Wed, 15 Jul 2026 11:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784115800;
	bh=t+OH7SBSWK76BJsPef8/MG+FlPYEbBchqAwFQ+qb2kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HhxOnmWgty1SHYCdDYii19fi1SAf2k5mYi40APByHJf50pa2CJjVL6oTTRHK0JRBL
	 TMwwj6j8hllZVF5G3tsbDrziojYi2/KO4U1tqz9J0hwl+PxeKcnhIAP2nPqJJRwwd5
	 b4/Q9R6psbPHv/NVekWnDRkqto3oRHbBS4vTbf3Ckwxl6tUbXmgG9m+h+sXxRTR5nJ
	 /NlDJvIBt08BdTi9LxRvcylCm7rtx1ZQLxHIW2r4eD+zs9GHlyWnkFrpQkaQOxWbk2
	 qRja2wDSukEXYyCKqCDLBrLd1HFV3QH4qHiUtYJxr6jmqblYZX8MNZlW1gQkO0GNWZ
	 AwVoExg0hot1g==
Date: Wed, 15 Jul 2026 12:43:15 +0100
From: Simon Horman <horms@kernel.org>
To: xuanqiang.luo@linux.dev
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>, netdev@vger.kernel.org,
	linux-afs@lists.infradead.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v1] rxrpc: fix io_thread race in
 rxrpc_wake_up_io_thread()
Message-ID: <20260715114315.GO1364329@horms.kernel.org>
References: <20260708093534.53486-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708093534.53486-1-xuanqiang.luo@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307735-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xuanqiang.luo@linux.dev,m:dhowells@redhat.com,m:marc.dionne@auristor.com,m:netdev@vger.kernel.org,m:linux-afs@lists.infradead.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:luoxuanqiang@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A80275DAD7

On Wed, Jul 08, 2026 at 05:35:34PM +0800, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> rxrpc_wake_up_io_thread() checks local->io_thread before waking it, but
> then reloads the pointer for wake_up_process().
> 
> local->io_thread is cleared with WRITE_ONCE() when the I/O thread exits, so
> the second load can see NULL even if the first load did not.
> 
> Take a READ_ONCE() snapshot and use it for both the NULL check and the
> wake_up_process() call, as rxrpc_encap_rcv() already does.
> 
> Fixes: 5800b1cf3fd8 ("rxrpc: Allow CHALLENGEs to the passed to the app for a RESPONSE")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


