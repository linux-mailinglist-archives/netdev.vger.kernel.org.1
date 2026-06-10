Return-Path: <netdev+bounces-297369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cSO0Fty3KGofIgMAu9opvQ
	(envelope-from <netdev+bounces-297369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:03:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C313B6651BC
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:03:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Yh85YTRl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297369-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297369-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51DE63029C28
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299D9213E89;
	Wed, 10 Jun 2026 00:58:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8B1F91D6;
	Wed, 10 Jun 2026 00:58:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781053124; cv=none; b=ajsSeVLlAqFtjSYV+Q1Y+XvDfO9vcNb8GtnlSxL6rmdSd2pABFZ+/jCtbpjT2hfqqUs+Uqv/Jr03a038mwjJWZCsSHqi/3LRArp4mPrPciXl5fLXVDvobptuQ6qyDRW7CiLLCMZoPQgLZhbCtOvp2JGj40w5sitJ+hQ4CWq/4cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781053124; c=relaxed/simple;
	bh=OmoFitpYKHAIiEcivzw+3UTezocvyEIrQudTiKwQvLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fjPlY9iFe/5yP2BUz38jJXaHL5LnIh5TqQV7eG7U8GUteI8gunwzxETAMLjuI06a829CBlMsB9I6PmIJggD0lF3xI47duqF6DAYfsXiGUKXrN1mqIUlVy7SGque1o237VdxjN4ul5vbMGy8nRb6TseASHrEWTntjd7SAa+lUgqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yh85YTRl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A89B1F00893;
	Wed, 10 Jun 2026 00:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781053122;
	bh=2I5nSFx17QTOsvRQJ3lHz/Nw8uM87WWs52G6x2E43tY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yh85YTRl4/MtXnUTaFnEBfDHb/kfCjTZMXOrYx+ThffEvO9DaWhHD1gefDT4qChBr
	 hTUdN184LoGEpxrqyz4wKl9RuR+sP4O8eXxCUG7xnnGKjYLSx0/6BV5AwXCHdUaB+B
	 hVdEG2Rhb4d9nlML+CX5TvgkA0AzoA/ZvORW4Phzvf8W75fj2x/hj/A01gjNNLf6QJ
	 wbdWtTfgZ29bqf2SJOI8pluhN7W+9Aw+umAU4PxKVS0TQc1xc89xqw6g1Oe956X7M8
	 B8yr/dcDBF1LSfleuF7NOf+RtxZtU4Y8EqfJFUC0eTS8YMM+Ro6128C3FCw/vIVH5P
	 6NxoUhKQtg0Rw==
Date: Tue, 9 Jun 2026 17:58:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jay
 Vosburgh <jv@jvosburgh.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] drivers/net/bonding: User strscpy() to copy
 device name
Message-ID: <20260609175841.3ce88cf0@kernel.org>
In-Reply-To: <20260606202633.5018-14-david.laight.linux@gmail.com>
References: <20260606202633.5018-14-david.laight.linux@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297369-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:arnd@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:jv@jvosburgh.net,m:pabeni@redhat.com,m:davidlaightlinux@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C313B6651BC

On Sat,  6 Jun 2026 21:26:08 +0100 david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>

Commit message is required. Please explain why you think this patch is
needed. AFAICT it copies data between two well formed IFNAMSIZ strings.

> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
> 
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
> 
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
> 
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
> 
> Note that all the changes are only compile tested.
> 
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
> 
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
> 
>  drivers/net/bonding/bond_options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 7380cc4ee75a..c57b7d6af043 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -1525,7 +1525,7 @@ static int bond_option_primary_set(struct bonding *bond,
>  		if (strncmp(slave->dev->name, primary, IFNAMSIZ) == 0) {
>  			slave_dbg(bond->dev, slave->dev, "Setting as primary slave\n");
>  			rcu_assign_pointer(bond->primary_slave, slave);
> -			strcpy(bond->params.primary, slave->dev->name);
> +			strscpy(bond->params.primary, slave->dev->name);
>  			bond->force_primary = true;
>  			bond_select_active_slave(bond);
>  			goto out;
-- 
pw-bot: cr

