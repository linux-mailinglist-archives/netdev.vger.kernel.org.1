Return-Path: <netdev+bounces-290959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIqxNtjrEGr+fQYAu9opvQ
	(envelope-from <netdev+bounces-290959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:50:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AE45BB9AF
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8BA43003706
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D1C372EE6;
	Fri, 22 May 2026 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyAjJqr3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9244352F87;
	Fri, 22 May 2026 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779493839; cv=none; b=dJs9sHyUW6G6+yuUGo9p7dpjFDWlw8XSkc/53kg4kpu8AHroj0B7FH8+vQZCDrPw0GXPJ/Q20m/F8MYlXs3xpW86DixcmN3M4aZDmKTpV8N890QZlzsghjwBxzfl449ZV7Kh2h/Xne5nqgpqbZVLhkc/erOPVlM9hcOan9genpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779493839; c=relaxed/simple;
	bh=x0neuyNjVdBBIBj+4aYuSp52lxht/Wk2DxF5980rX8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tiCm0Z2qy8QLx0vVI1PceWLIWfth4LD6JidXampbO57nBiZ/hqQ+XqAZRr+vmeS/S12hcMURHSxzmGsMTkPSnuMUef+FDbMuP5xsA2+GnhIq9aToQzooVGqyACHvyX0IDYqYNntKa1s7JBP+TlAbubeo+GP5jwHKQ/A7YdW0VaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyAjJqr3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1481F000E9;
	Fri, 22 May 2026 23:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779493838;
	bh=vApJxRBBvTfVYz8tQF58+4PyhKD5aHUKjXyzvgGZ/Tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FyAjJqr3z4JgjlP+R5TIeGhhnyriQDWRQmUMTNp3B9lq2+Ta26PtwqfPCC8/VvjOQ
	 F+ywr3l7u/1eLdUWMjQid608/vXaN7K/BHqGfixpdeobfx8KOqo2R7SVxOC5rOIKV2
	 7oj+D5FZzsRH8q1qkvXW2GhC4Kz+2FhgS3RMpVJVLiT/YVMc1pbgvs+G5mKgCPMh61
	 XFoKBg9/PW+jBk66C4zbBrF3wUz22JH06OvGwuX/m7md558t96uDMRfRM0+dprelJd
	 e68FAKzyF4PcGCWbDvjQBbzlMNw1jnJW7PB2crLGZ7Z6wxyMdn/BsmdBwySrEq0ari
	 +xwan0KEQVSYg==
Date: Fri, 22 May 2026 16:50:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Martin Karsten <mkarsten@uwaterloo.ca>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, Joe Damato <joe@dama.to>, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, =?UTF-8?B?Qmrvv71y?=
 =?UTF-8?B?biBU77+9cGVs?= <bjorn@kernel.org>, Frederik Deweerdt
 <fdeweerdt@fastly.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: napi: Skip last poll when arming gro
 timer in busy poll
Message-ID: <20260522165037.4327dd4f@kernel.org>
In-Reply-To: <c75646e0-8a1c-4301-b6e8-fa2faf21563f@redhat.com>
References: <20260518181337.886459-1-mkarsten@uwaterloo.ca>
	<780d21ed-4ab3-478c-a932-6feb7aa6d7b4@redhat.com>
	<b785b518-3a76-4058-ab76-644df400cd0a@uwaterloo.ca>
	<c75646e0-8a1c-4301-b6e8-fa2faf21563f@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290959-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E1AE45BB9AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 21 May 2026 18:19:21 +0200 Paolo Abeni wrote:
> >> Not blocking, but I find the above slightly confusing after this
> >> refactor. Perhaps it should be re-worded?  
> > 
> > I'd be happy to reword, but I am not familiar with the internals of gro 
> > processing, so would appreciate any help I can get?
> > 
> > Should I try-and-error via subsequent patch submission(s) or can you 
> > comment on this version:
> > 
> > 		/* Use the driver poll to re-enable device interrupts. */
> > 		rc = napi->poll(napi, budget);
> > 		trace_napi_poll(napi, rc, budget);
> > 		netpoll_poll_unlock(have_poll_lock);
> > 		if (rc == budget) {
> > 			/* If napi_complete_done has not been called by the
> > 			 * driver poll, the napi needs to be rescheduled.
> > 			 * Use the opportunity to pass up completed gro skbs.  
> 
> Possibly something alike the following:
> 
> 			/* More work to do: no concurrent napi-related 	
> 			 * irq is possible and the current thread can
> 			 * pass up the pending skb batch.
> 			 */

I'd stay focused on the ownership FWIW:

		/* Unless rc == budget we no longer own the NAPI instance,
		 * IRQ may fire on another CPU, poll this NAPI and enter GRO.
		 */

(in the current location of the comment i.e. _before_ the if (rc == budget))

