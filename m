Return-Path: <netdev+bounces-272978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CbfLMF5yWlIyQUAu9opvQ
	(envelope-from <netdev+bounces-272978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:13:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE80353BB1
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 21:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B352130067A7
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 19:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE35737FF5B;
	Sun, 29 Mar 2026 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug2PkI59"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B986C27281D;
	Sun, 29 Mar 2026 19:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774811530; cv=none; b=DKD+hd8sZp0sbLLPsuPRLGQabmmc8Pag0KnpaaejHH0buYjVOgIUDaPevqDaS4Omuj4aiai+EBjnymWmuTYMLrymP6v46fH6/JRxXQlKhQRK+Z7jGYBDIgAcwelUgDE8RRCAnn+FZU/lPJFd45wN/iVqb/nx8sWm8gDt4fGAX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774811530; c=relaxed/simple;
	bh=o/yp8qy8Rbn8pJPvjcvzhSGLE6cgVQWLWrs+k/X0tNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNWByXR3OWMiZAG8ifNo3zwQJcVuWzjSFty9mzVgQCBsWIxxdufnpyQttDVE6IjCHzWTYtOsOoDrrgfBsokBQrq8L9ybp7bw6asr0kFrnc8TYsbCvSWdIMSGc0MSD15Nhe5ewMGJbexJkhmZvPZb62cKWdcTDWzUPIor3OOWyRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug2PkI59; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB585C116C6;
	Sun, 29 Mar 2026 19:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774811530;
	bh=o/yp8qy8Rbn8pJPvjcvzhSGLE6cgVQWLWrs+k/X0tNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ug2PkI59dzaumq1kfHe7AM8vGd6gYTu2DkprdY3/WoPS35Mcv5Ua98WvhRV9bSncQ
	 WAJivNsRgSkn2mrYpy3QHCWfJeUSNHe+xmJFI7IZC4Go08Q2kIxr6ZX6fOP0622+rT
	 vJ84hwXyDzXN9Ebq9jm/SCXzbipCMks5p+jHQJJQbj9hZQl/nSa31sZVT0AbLv8vBR
	 7sbvuaPNSm/2Xjh4UeSzUxrT0vfb2j5kmhTRRyUcE2pjbqeH9ZnJyPvRaxz0rlsTNE
	 iTvoPeScH/dyM9R9xDye2m4W+52NyHo0I57ZAT2LQzGGKNkpwnMgdopTKOUaWgCgjt
	 GUDbt17aLiEDw==
Date: Sun, 29 Mar 2026 12:12:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, John Johansen
 <john.johansen@canonical.com>, Minas Harutyunyan <hminas@synopsys.com>,
 Simon Horman <horms@kernel.org>, apparmor@lists.ubuntu.com,
 linux-usb@vger.kernel.org, stable@kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH net v3 04/11] list: Move on_list_rcu() to list.h and add
 on_list() also
Message-ID: <20260329121208.6092419d@kernel.org>
In-Reply-To: <20260326131838.634095-5-dhowells@redhat.com>
References: <20260326131838.634095-1-dhowells@redhat.com>
	<20260326131838.634095-5-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272978-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AE80353BB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 13:18:29 +0000 David Howells wrote:
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 00ea8e5fb88b..d224e7210d1b 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -381,6 +381,32 @@ static inline int list_empty(const struct list_head *head)
>  	return READ_ONCE(head->next) == head;
>  }
>  
> +/**
> + * on_list - Test whether an entry is on a list.
> + * @entry: The entry to check
> + *
> + * Test whether an entry is on a list.  Safe to use on an entry initialised
> + * with INIT_LIST_HEAD() or LIST_HEAD() or removed with things like
> + * list_del_init().  Not safe for use with list_del() or list_del_rcu().
> + */
> +static inline bool on_list(const struct list_head *entry)
> +{
> +	return !list_empty(entry);
> +}
> +
> +/**
> + * on_list_rcu - Test whether an entry is on a list (RCU-del safe).
> + * @entry: The entry to check
> + *
> + * Test whether an entry is on a list.  Safe to use on an entry initialised
> + * with INIT_LIST_HEAD() or LIST_HEAD() or removed with things like
> + * list_del_init().  Also safe for use with list_del() or list_del_rcu().
> + */
> +static inline bool on_list_rcu(const struct list_head *entry)
> +{
> +	return !list_empty(entry) && entry->prev != LIST_POISON2;
> +}

Could someone with sufficient weight to their name ack this?

The non-RCU version of on_list() does not sit well with me.
It provides no additional semantics above list_empty() and
the uninit / poison-related gotchas more obvious when typing
!list_empty(&entry->list).

I can believe the RCU version is more useful. It could probably
be used on both RCU and non-RCU entries?

Last minor nit - the list API consistently uses list_ as a prefix.
I have no better name to suggest but it's sad that on_list_rcu()
breaks that.

I think you're missing a READ_ONCE(), BTW.

