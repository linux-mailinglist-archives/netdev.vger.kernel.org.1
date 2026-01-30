Return-Path: <netdev+bounces-255074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKLzOJJzfGmAMwIAu9opvQ
	(envelope-from <netdev+bounces-255074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:02:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E82B8AEC
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 10:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD848300D45D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 09:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D09314D3D;
	Fri, 30 Jan 2026 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nY/WOovL"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9B327210;
	Fri, 30 Jan 2026 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769763703; cv=none; b=hOxX5FW4CWI+eAcyCSz6PmeirDZkjzH3prSGfJ07KRcW+Lr90I6RF3zpmJiM8eZ03GRfkFGuJ80zlx56r77BfRNFnunBdK8fbtR0O71WtlAPu14cAgJUY2WanaKajspm6MQgKLk8ndgCKH37JzTeOxrimhn3G0QbMNeYKHw714k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769763703; c=relaxed/simple;
	bh=SGn6rcjYmhqxxcVgKcE5FUgMgb0AGIyJmqyFW//I6dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcx3g0XUqnOw3WWbUe2kVLcPmTfOQlognuFvQ7gHYan4SiEHq5MLLcYwbGa8f1KtYlW+2XGfWRN04lb0V0CPb+RrKHFAeL1ksQnqggd1wedF4XQqD4qNMDbLB5kSugpuLlt3UPwB2Bt48/ruUKDxSA4Kqi1vYibivI6urM1KKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nY/WOovL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dg1aAyK0fD1irzZQrfqcf/pxsLPYajOmV9tpjiRFf7c=; b=nY/WOovLAZBdvNGpSKTZUwZ+1S
	cjDtG43+YSkjT/IwA1Jn2gdEY2XAIhsbGgBeSej8AwGXuOWBDxOpJLSl9KXNvfSES9UhSUtXU3ZHn
	oypoUahFG6LubCKx+S/l/wcqV8vNAZgZHyS+oRMKKRkfOTfMcwRLRadbMl6rPLHdbPegODpBwaKBy
	twWDlnzkxLZV+ID2K5vCxsdODRrfZvmIsXaFChhu/567DE+SrnQnHr7AJvDh7Ot192145v4aDinzk
	Ah9wnn5rhSEEuv4k6nIIc5qBz5sUnJY45eyv76qh+Jh1CWgi1zquYynZJL8GZuto2x1/g0TaF/O3h
	+RGVAldg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vlkNS-001bOC-CF; Fri, 30 Jan 2026 09:01:18 +0000
Date: Fri, 30 Jan 2026 01:01:11 -0800
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>, pmladek@suse.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, pmladek@suse.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, mpdesouza@suse.com, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v5 1/4] printk: Add execution context (task
 name/CPU) to printk_info
Message-ID: <aXxy7usBz1-TTkVB@gmail.com>
References: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
 <20260128-nbcon-v5-1-93b4ddbc181a@debian.org>
 <87ikcllrxz.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikcllrxz.fsf@jogness.linutronix.de>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255074-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,suse.com,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,meta.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 46E82B8AEC
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 03:48:16PM +0106, John Ogness wrote:
> On 2026-01-28, Breno Leitao <leitao@debian.org> wrote:
> > Extend struct printk_info to include the task name, pid, and CPU
> > number where printk messages originate. This information is captured
> > at vprintk_store() time and propagated through printk_message to
> > nbcon_write_context, making it available to nbcon console drivers.
> >
> > This is useful for consoles like netconsole that want to include
> > execution context in their output, allowing correlation of messages
> > with specific tasks and CPUs regardless of where the console driver
> > actually runs.
> >
> > The feature is controlled by CONFIG_PRINTK_EXECUTION_CTX, which is
> > automatically selected by CONFIG_NETCONSOLE_DYNAMIC. When disabled,
> > the helper functions compile to no-ops with no overhead.
> >
> > Suggested-by: John Ogness <john.ogness@linutronix.de>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thank you for the review. To confirm, it is acceptable to queue this for
the next netdev version, isn't it?

