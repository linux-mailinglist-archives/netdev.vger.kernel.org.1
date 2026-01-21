Return-Path: <netdev+bounces-251853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNvGMmy+cGkRZgAAu9opvQ
	(envelope-from <netdev+bounces-251853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:54:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA1F56508
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 91F4D465300
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8683F23AC;
	Wed, 21 Jan 2026 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ktW/noQH"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63963E9588;
	Wed, 21 Jan 2026 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768996230; cv=none; b=KahlAg43xrvylSGepD8ORo1UC+eMKQ6ikSQplnZH0y1T2iZRsh4LdpgPDcjuhMmGRaP361Z68rH4kZ3lw2oiHqnxlgcdhAzJSsFUK8ecJsdv4/b84bVdrJ7yjLPw/IjqOKCWr5qNau1nGKHED1LP2El4KTHs5CWhKRRcVG1dYFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768996230; c=relaxed/simple;
	bh=HEfLaFhBovSzU60g9bnZoEt4yjvM6JhbLer2LP2TWs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNlxZAu1N8u68Q1q5j4D4Tjrd5r8oRwX+nMAGGng7Y4BLwD77Se4FUcAqj2I7t1geJAjSxjxRwW/1jo8T/OR4w1z0m664bZmsapbIUqDFGsGGU35g1CypzmWtcDRoqla9r1wzQbYTdwnc1WXZ8I1GEn6KCzy68oT2myuhGKAugI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ktW/noQH; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wikYFORvNaZd5anwKoaPBJiJ02QO0+0vwRfGgkV690Y=; b=ktW/noQHeEjdZZq8Xk5iELA7xV
	nXIqPL97zrJkRFxY2EwLH2itTWNX6TDLfCU87rUnpoMVxOlUCQbMZE377peYvwXFnwPvVcoMFD2ce
	dWbMEVsrHLS0I6xdvGy7JM6kpWq9jAPUcNL9pNIiWfKUD3uKfy3p5pClQ9jY7nbIN08Q6eh7qV4ZA
	esl9y2tEPKFldYC9Kqxr/SgTfC3rtLFFWgkHO1+uQNlit6G+GW8GnxH/6/Qvc+4L65l0zqnRpd4gV
	kow2nmA3yPM3IZyIYLQVqMiHB8qVeWiZ762RAjEKYqm66a5mErl4SUtAclYTKJ7XMrfBWuxZyfTqK
	zoW06n7w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1viWax-00CA3u-78; Wed, 21 Jan 2026 11:41:56 +0000
Date: Wed, 21 Jan 2026 03:41:49 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, pmladek@suse.com, 
	john.ogness@linutronix.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asantostc@gmail.com, efault@gmx.de, gustavold@gmail.com, calvin@wbinvd.org, 
	jv@jvosburgh.net, mpdesouza@suse.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 1/5] printk: Add execution context (task
 name/CPU) to printk_info
Message-ID: <aXC6MNOJidrYuSy0@gmail.com>
References: <20260120-nbcon-v2-0-b61f960587a8@debian.org>
 <20260120-nbcon-v2-1-b61f960587a8@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120-nbcon-v2-1-b61f960587a8@debian.org>
X-Debian-User: leitao
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251853-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,01.org:url,linutronix.de:email]
X-Rspamd-Queue-Id: 8FA1F56508
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 08:23:47AM -0800, Breno Leitao wrote:
> Extend struct printk_info to include the task name, pid, and CPU
> number where printk messages originate. This information is captured
> at vprintk_store() time and propagated through printk_message to
> nbcon_write_context, making it available to nbcon console drivers.
> 
> This is useful for consoles like netconsole that want to include
> execution context in their output, allowing correlation of messages
> with specific tasks and CPUs regardless of where the console driver
> actually runs.
> 
> The feature is controlled by CONFIG_PRINTK_EXECUTION_CTX, which is
> automatically selected by CONFIG_NETCONSOLE_DYNAMIC. When disabled,
> the helper functions compile to no-ops with no overhead.
> 
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  drivers/net/Kconfig               |  1 +
>  include/linux/console.h           |  8 ++++++
>  kernel/printk/internal.h          |  8 ++++++
>  kernel/printk/nbcon.c             | 15 +++++++++++
>  kernel/printk/printk.c            | 52 ++++++++++++++++++++++++++++++++++++++-
>  kernel/printk/printk_ringbuffer.h |  4 +++
>  lib/Kconfig.debug                 | 20 +++++++++++++++
>  7 files changed, 107 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index ac12eaf11755d..12e47cb27ffa5 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -341,6 +341,7 @@ config NETCONSOLE_DYNAMIC
>  	bool "Dynamic reconfiguration of logging targets"
>  	depends on NETCONSOLE && SYSFS && CONFIGFS_FS && \
>  			!(NETCONSOLE=y && CONFIGFS_FS=m)
> +	select CONSOLE_HAS_EXECUTION_CTX

This is wrong as detected by Kernel test robot.

	https://lore.kernel.org/all/202601211304.r9ecHy9L-lkp@intel.com/

On csky, CONSOLE_HAS_EXECUTION_CTX is set, but not
CONFIG_PRINTK_EXECUTION_CTX

	https://download.01.org/0day-ci/archive/20260121/202601211304.r9ecHy9L-lkp@intel.com/config

The execution context fields were not available, while
NETCONSOLE_DYNAMIC, causing a compilation error.

It needs to be:

+ select PRINTK_EXECUTION_CTX

--
pw-bot: cr

