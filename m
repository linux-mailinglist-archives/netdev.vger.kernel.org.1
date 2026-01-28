Return-Path: <netdev+bounces-254345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIwiIHo9emlB4wEAu9opvQ
	(envelope-from <netdev+bounces-254345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:46:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A748A618A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF5B7300AC8D
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509612F2616;
	Wed, 28 Jan 2026 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="u7Mm8CZ5"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80022F25EF;
	Wed, 28 Jan 2026 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769618796; cv=none; b=FXn9c0qLVxSDLxXEGdM0aMwitjxkt17INRaYfs9Sv0aDer339zyPGhC+iLpTg5EdlTYxj4NRIysrOhjBuHxrDpFC0XogG2iUyG79/NnpbxXdpLKswdFAII6K7FLblNYXKobTgdXPIQZQ/3gdvcI8B1AqAmJOIHQhgdHSGv438tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769618796; c=relaxed/simple;
	bh=yyoZ1sDBZV6FNchAIhxcYm41ZnVXg8dHaEZFQKQbvDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAXlUPiDwjVquebEXXSZPA9QRaZDLijlefd3PZr0IjT2TFB8iD83Z+jSASY24aFCmzEIqsZ/bHAaRLHIl+CenDDMu+MRna/zeJvK4rNNnG54H+EINXU711PmV88HYlhfHf2vFYE0h6RvR9TWUMa5zB4jzHsK3FZ9S83hP57Ng9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=u7Mm8CZ5; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+lQl+dFqNAENGsU7mYgYRTKm9IWMInogA9Kw8B4GeF4=; b=u7Mm8CZ5lnsxv0szdO12EEGsl9
	HEJsQZJ8deFgZLiKIb3pnu7X4cAV3JHH0I6B5unq14Qenpek/g787WgsRjZgtpcpV8XxKxFn8LY40
	hV7qu59dY7dZ6NHJHqjRMKVth6/zQ1BuOuujqxFATPNPfG2rK1dtVc15hdr2RRY131p9yFsUO/cSH
	oqr1eX9ixgPLEqDteD1fmhY9M1KiFlTV8u8rBwxXEzAtJwYslBX7hXkE4WaECACtfJVVnBRsagFg3
	T0KsQIaKDwDXR8BchvGwFQ5XOF/NEGCTxiFPXQ+oNilT1+Gz+SIO4PUGRPdnqKxcFwqCrWU9EBld8
	updm/u2w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vl8gL-000Iu5-4N; Wed, 28 Jan 2026 16:46:17 +0000
Date: Wed, 28 Jan 2026 08:46:10 -0800
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, pmladek@suse.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, mpdesouza@suse.com, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v5 4/4] netconsole: Use printk context for CPU
 and task information
Message-ID: <aXo9DO9OCJ0I7ID5@gmail.com>
References: <20260128-nbcon-v5-0-93b4ddbc181a@debian.org>
 <20260128-nbcon-v5-4-93b4ddbc181a@debian.org>
 <87a4xxlqz8.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a4xxlqz8.fsf@jogness.linutronix.de>
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254345-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A748A618A
X-Rspamd-Action: no action

Hello John,

On Wed, Jan 28, 2026 at 04:09:07PM +0106, John Ogness wrote:
> On 2026-01-28, Breno Leitao <leitao@debian.org> wrote:
> > Use the CPU and task name captured at printk() time from
> > nbcon_write_context instead of querying the current execution context.
> > This provides accurate information about where the message originated,
> > rather than where netconsole happens to be running.
> >
> > For CPU, use wctxt->cpu instead of raw_smp_processor_id().
> >
> > For taskname, use wctxt->comm directly which contains the task
> > name captured at printk time.
> >
> > This change ensures netconsole outputs reflect the actual context that
> > generated the log message, which is especially important when the
> > console driver runs asynchronously in a dedicated thread.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

Thank you so much for all the reviews and your support throughout this
migration. I really appreciate it!

---breno

