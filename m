Return-Path: <netdev+bounces-253687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAtbJgM0eGlRowEAu9opvQ
	(envelope-from <netdev+bounces-253687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:41:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DA28FB06
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11C733023DBE
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AC73093C4;
	Tue, 27 Jan 2026 03:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoCeYUGL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B311DFE22
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769485256; cv=none; b=O0C8yZ2fNAr63NdOMZooOHw7QTrgFStbWMExDZ4nTkHQzx8drC09Bj2OygXLHZEGRfYVi27h60G0NB+ISX1eFd6EK58qs6uJxdnVM4vb/aMMsPgwFXUO7MCQ+rpeXKeJ4LTmHdvQBMt/zhKeLb/y/ceFY4JgUtcjn9rOTeDKaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769485256; c=relaxed/simple;
	bh=SgIK6ZAnwPzLj+u2xM4wEQwVXQdC+Unq7P5ZEg3Ma78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KI+lDjLNKCiWSPgoHanvlwcu5QN8TyLzvcacl6ZXh8FWdVEA7eoaKkowheP6Metq8HqMSYeeamtcmSCCj3i09Q3PetzR3NwsvErhD9KrGWM1HTNd2vgqsEt0qWH8LPTA13L86yY3lHb3QpRX8ZBz78314X6jQa9V+MBm5U8FqXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoCeYUGL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43483C116C6;
	Tue, 27 Jan 2026 03:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769485255;
	bh=SgIK6ZAnwPzLj+u2xM4wEQwVXQdC+Unq7P5ZEg3Ma78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AoCeYUGLCt4litSTKl1mDx+2aoWFNrZBfkOmLJ8gCCwsNVQFCmS9W6qdo6w7syLXY
	 V5UAY2V32ssf56ghxxHni/OFyS+URcjhoPuU8sjdtu6ZW/rrHaSryDN2lRBSQ5sd7N
	 vzkmfCe8YgMDD8OZkQQCpq0WMYrHbJBnFqDwIeA0lObBuFR1fdQa2VUeo+xBw+da9G
	 k58BnuWRLICYwDRAnn9oSYbIZkeEQBtjgDLhxV7u/kkpXYXf5RoVkYRYiONfLc3Z66
	 L82ChN4DZpl/oEAsSyd8E7bPdr7ZGB2dtS6/oh7jMJiNaw4LqEIAVD1XuxeFRz8ZTq
	 KZI70BguJG4dQ==
Date: Mon, 26 Jan 2026 19:40:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] declance: Remove IRQF_ONESHOT
Message-ID: <20260126194054.79e6f56d@kernel.org>
In-Reply-To: <20260123110616.416384-1-bigeasy@linutronix.de>
References: <20260123110616.416384-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253687-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 10DA28FB06
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 12:06:16 +0100 Sebastian Andrzej Siewior wrote:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> 
> Remove IRQF_ONESHOT to irqflags.
> 
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> 
> lance_dma_merr_int() does nothing but a printk() which means if it is a
> level interrupt then once it fires it remains asserted and that printk()
> takes over the machine.
> I guess it never fires and is just left over debug.

have you seen 0fabe1021f8bc9cffdede4ddad0dd04d43c5166c ?
Sounds like it may have been a hack local to MIPS.
On a quick read indeed your changes seems fine but it would give us
certain warm and fuzzies to have the commit message refer to and 
reason about the patch that introduced the flag..
-- 
pw-bot: cr

