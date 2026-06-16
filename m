Return-Path: <netdev+bounces-299984-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f/teG9DQMWrNqgUAu9opvQ
	(envelope-from <netdev+bounces-299984-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:40:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF53695A04
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 00:40:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EifnjJ2Z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299984-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299984-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F29B5300F7A3
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B74F3E5581;
	Tue, 16 Jun 2026 22:40:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BDE3E1682;
	Tue, 16 Jun 2026 22:40:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781649611; cv=none; b=HuVLZFIX3kW+2u/Wl8D+JOXhmVSeKw20zJGLe025ueqEhypmhMXwvKRVL8WaVbf7OeXdC7O+o9FDxovhLpJ752oRglQYTAVcahcDlshQQ2bQ6H6ZY9olOtzlKY6gDhBVm+3Tes/PG4JWAjC3tPzscox7HHG6tjEmKKilGee/cOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781649611; c=relaxed/simple;
	bh=NUYjqR6sR5srieQsMlyK4PjiDVO0qcPJpXizvfJzKzY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1mUb5lu3NR8IuKE5h3EHCs0q0X4I+fQU65W/+sQT+5IGjhyQp58kMzLoly9dTTll4HpNtqsByzC3Ajz0VvSu21dPj19Mdg4SMM/VvPxEOXKAmA81qLyVKqbtRTVI1o8IXksvOe4efmZ/2V/TSLxrjZZHBo0E6ADSIEDLfVGp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EifnjJ2Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D531F00A3E;
	Tue, 16 Jun 2026 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781649609;
	bh=3AVIqwiOf2ilwfObX2BqNzPwAgSeltapZaaNIUL0kXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EifnjJ2ZWjjRJjjxKvHYcni84M0WTOCYZ1oiC4t96p7d0RNHiwpy4l+7rZtHlKwmd
	 Yth0wIEqDD9+YXfKvja/OWljwTPZjWyKQIyWWP0GpGjXfOV/XEJLZyTaYot1tJIMSw
	 NLI63Jvv0CAhXD/9vxcPR91N7pJ4ENgqC+HqoQBc4x2XZ1tDgrY7Zbuc+Xti5XnohT
	 PVROkVKFzue0wZQvC+IDQUFXPALiu8McgPaZvf5gaOOYNppzwwPqgeRCDhcV98ofDk
	 v+HoFUAk22YoOnRPYf7GSh8OVFbEICTICP2dnjGwgBriCs3PhA8/mckAWwc4GhA6HK
	 kvajRB3/6d4Tg==
Date: Tue, 16 Jun 2026 15:40:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org,
 syzbot+1cf303af03cf30b1275a@syzkaller.appspot.com
Subject: Re: [PATCH] netdevsim: Fix deadlock in del_device_store() and
 nsim_bus_exit()
Message-ID: <20260616154008.0804ea70@kernel.org>
In-Reply-To: <20260616222644.41344-1-mokshpanicker.7@gmail.com>
References: <20260616222644.41344-1-mokshpanicker.7@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299984-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mokshpanicker.7@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:skhan@linuxfoundation.org,m:syzbot+1cf303af03cf30b1275a@syzkaller.appspot.com,m:mokshpanicker7@gmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspot.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1cf303af03cf30b1275a];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBF53695A04

On Tue, 16 Jun 2026 22:26:44 +0000 Moksh Panicker wrote:
>  	mutex_lock(&nsim_bus_dev_list_lock);
> -	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list) {
> +	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list)
>  		list_del(&nsim_bus_dev->list);
> -		nsim_bus_dev_del(nsim_bus_dev);
> -	}
>  	mutex_unlock(&nsim_bus_dev_list_lock);
> +	list_for_each_entry_safe(nsim_bus_dev, tmp, &nsim_bus_dev_list, list)
> +		nsim_bus_dev_del(nsim_bus_dev);

How could this possibly work?
-- 
pw-bot: cr

