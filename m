Return-Path: <netdev+bounces-278163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DnBCI0w3Wn1aQkAu9opvQ
	(envelope-from <netdev+bounces-278163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:06:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 612B63F1CE1
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9D1E301CF99
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599F43CAE96;
	Mon, 13 Apr 2026 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2kusQcj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372923C552E;
	Mon, 13 Apr 2026 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103204; cv=none; b=EsO46sJbPA0/JFccBsiwXaiPJwdUXJSGU3oVplPaRIitMoMBUicpQHKUUGmD00ZdpB3ut8nESeehI9nWRglv5Ksb1K5VehQ9eKdWRSiXAJhEgHYKiug+jGBON3osqptEe/Fz81GbY6L37QO3pkoFE5aGWyJtrsUjHrqxaIgwC68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103204; c=relaxed/simple;
	bh=EDnBIw51U5bElEU2K5WFqv1/TP+HHxyUhb90VbOx9OA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhYqgYsU/p7719uS62hNhZzS/3bAaKoP45jNRzF01NLmATTr+hm2aJoKlGguQVSYLJpuRxGLtGcUSE6lqHRFWC87+UO1l58haAaT+LkpztIyXzcqb/ql7pAxaJfc1aBc4dMPSxjEkzW2snqA8CBLeil0PKZUqFtKMtWv2m+wN50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2kusQcj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE08FC2BCB3;
	Mon, 13 Apr 2026 18:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776103204;
	bh=EDnBIw51U5bElEU2K5WFqv1/TP+HHxyUhb90VbOx9OA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E2kusQcjKHTmwpJQ1mIJNFBMHVJjiIJtQXhC1h51vnD38O5yy+1R6UrsN+AYRqDDb
	 xislPsSdoNdb1i17di0tc9udKPYhsFhi6VhxeayRWCF0I7UzLkyJqITdGQW4ilt7iZ
	 LLvcc5U5zQuz6VwrTW391xeJirUVcWXXtusR9dxDEKF2Z0y2iwSe7tsykB3t8S38K1
	 5ntWELgcSezD7DDkqsZ51/3vLYw6J6qx3vR19/IRRT1EM4DSuJQXFe25ecFba9QXsC
	 8MDJR/mXnaAtZ8Y4s+b2PLgIyMMC6mMiuJ5pkUqxS12WzzuGRTeDyNRmWWezo1ozEd
	 A1L0UB5RJje1A==
Date: Mon, 13 Apr 2026 11:00:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Tim Bird <tim.bird@sony.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] keys, dns: drop unused upayload->data
 NUL terminator
Message-ID: <20260413110002.65b7693c@kernel.org>
In-Reply-To: <adw5cvtPfx1SWQq9@linux.dev>
References: <20260409225703.158552-4-thorsten.blum@linux.dev>
	<20260412141004.22c6686c@kernel.org>
	<adwlFgKPdW4zDVb_@linux.dev>
	<20260412170508.1f33a371@kernel.org>
	<adw5cvtPfx1SWQq9@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-278163-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 612B63F1CE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 02:31:46 +0200 Thorsten Blum wrote:
> On Sun, Apr 12, 2026 at 05:05:08PM -0700, Jakub Kicinski wrote:
> > On Mon, 13 Apr 2026 01:04:54 +0200 Thorsten Blum wrote:  
> > > On Sun, Apr 12, 2026 at 02:10:04PM -0700, Jakub Kicinski wrote:  
>  [...]  
>  [...]  
>  [...]  
> > > 
> > > The point of patch 1/2 is not the removed NUL terminator itself, but to
> > > prepare for patch 2/2, which adds __counted_by() and requires ->datalen
> > > to match the number of elements in ->data.
> > > 
> > > Currently, that is not the case because ->data includes an extra NUL
> > > despite never being used as a C string. Removing the unused terminator
> > > makes the length match the allocation size and allows adding the
> > > __counted_by() annotation.
> > > 
> > > I can fold this into the __counted_by() patch if you prefer.  
> > 
> > I understand that part, but I don't get where the data from which 
> > the terminating character is removed, is used. Only other access
> > I saw was freeing it, the rest of the callback seem to looking
> > at the error, not the data..  
> 
> ->data and ->datalen are used in multiple places.  
> 
> For example, in dns_query() in net/dns_resolver/dns_query.c:
> 
> 	upayload = user_key_payload_locked(rkey);
> 	len = upayload->datalen;
> 
> 	if (_result) {
> 		ret = -ENOMEM;
> 		*_result = kmemdup_nul(upayload->data, len, GFP_KERNEL);
> 		if (!*_result)
> 			goto put;
> 	}
> 
> In cifs_set_cifscreds() in fs/smb/client/connect.c:
> 
> 	/* find first : in payload */
> 	payload = upayload->data;
> 	delim = strnchr(payload, upayload->datalen, ':');
> 

Alright, could you repost this after the merge window and CC David and
Jarkko on both patches? They supposedly maintain this.

