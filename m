Return-Path: <netdev+bounces-273400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GK/K2MRy2lCDgYAu9opvQ
	(envelope-from <netdev+bounces-273400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:12:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C049362972
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 02:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEEF53017C1D
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 00:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A70149C7B;
	Tue, 31 Mar 2026 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaY/3ZjK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42D640DFA6;
	Tue, 31 Mar 2026 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774915936; cv=none; b=sEM5HoPq9sPHiDqxaCOIibku8+xQqeVm0FvgbXSj2KSpIe3/mPV//JiSyCzezEmiKAxUw76VPnHkufLQXfl07RvewDApSiJ6Kso9NKB9d/EDa6uR0v+ricbyqE3PPZHmgD81PPW6QLUKFUNH6aMI953Zyf+AfzXZiGELiu3D2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774915936; c=relaxed/simple;
	bh=jp4GPIkcXzyuueYJbiqqPav/rW1ddSu+I1Gm/Qd/ReQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iD5nXOSU775oxFJo454mc3LTqRFrTjjapjVPzpukrHVVSLn+8m1YiFitEYXfODF7im++dp8nuBEzWVpf9Et651JvpwlTr/ajs5sTl/qwFKk53TWvGhk53dYi8ZlOl8uyHmaBH/Fc097t/6IiKr46dCL9AqIYZdbPbh7IJhHNeMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaY/3ZjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B763CC4CEF7;
	Tue, 31 Mar 2026 00:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774915936;
	bh=jp4GPIkcXzyuueYJbiqqPav/rW1ddSu+I1Gm/Qd/ReQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GaY/3ZjKypngfcURKwc7rTnaQcQZFk1Mt5fd6C6YnJkY0eOWeyX4tBuQy/qhdg5t9
	 /+b5kIsE5fA/Fq29XjrygD/HaOHuD9EfazDtMMIRmSmM0xwcCuB5dIVNTQ/mAIsNVs
	 rfteN9dcBhDDDRMGldyQ0K9DSCGVv1422zZQbfuoIi8tDWXLibCuBn245P7JHPOI1o
	 6ubW53uJL80sQfzKzzZ6mX9PwEQHiROcjLThEr29trrC7VC8r5JKpFLVslBDOUg9Op
	 dafo/+7keVpjO7DqF578ErUcJJHkIgdgMFoc+bqEsqC9LF4YefuFCNjxpb/76t+j4+
	 j7XYDRs2zUSAg==
Date: Mon, 30 Mar 2026 17:12:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, David Howells
 <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, John Johansen
 <john.johansen@canonical.com>, Minas Harutyunyan <hminas@synopsys.com>,
 Simon Horman <horms@kernel.org>, apparmor@lists.ubuntu.com,
 linux-usb@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH net v3 04/11] list: Move on_list_rcu() to list.h and add
 on_list() also
Message-ID: <20260330171214.4d95a6c3@kernel.org>
In-Reply-To: <CAHk-=wjDKfhS5TvEfrsOgBgAvFMPfAd3wT=Um2AQb4txHq5sAQ@mail.gmail.com>
References: <20260326131838.634095-1-dhowells@redhat.com>
	<20260326131838.634095-5-dhowells@redhat.com>
	<20260329121208.6092419d@kernel.org>
	<CAHk-=wiJ6gEELLviexdmSHnyjVoG7MFo8Qwhd1zxs_tCnL-=gQ@mail.gmail.com>
	<1179840.1774867765@warthog.procyon.org.uk>
	<CAHk-=wjDKfhS5TvEfrsOgBgAvFMPfAd3wT=Um2AQb4txHq5sAQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273400-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 1C049362972
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 15:14:07 -0700 Linus Torvalds wrote:
> On Mon, 30 Mar 2026 at 03:49, David Howells <dhowells@redhat.com> wrote:
> >
> > Anyway, I'll find a different way to do this, not involving checking the prev
> > pointer.  What I don't want to do is hard code "prev == LIST_POISON2" into my
> > stuff.  Anything like that really needs to be in list.h.  
> 
> So i think the proper model is:
> 
> (a) normal and good list users should never *use* this kind of "is
> this entry on a list or not".
> 
> Dammit, you should *KNOW* that already from core logic. Not with a
> flag, not with a function to ask, but from how things work. The whole
> "am I on a list or not" should not be a list issue, it should be
> obvious.

+1 FWIW, the use of the on_list_rcu() in patch 5 looks kinda shady:

@@ -654,9 +654,9 @@ void rxrpc_put_call(struct rxrpc_call *call, enum rxrpc_call_trace why)
 	if (dead) {
 		ASSERTCMP(__rxrpc_call_state(call), ==, RXRPC_CALL_COMPLETE);
 
-		if (!list_empty(&call->link)) {
+		if (on_list_rcu(&call->link)) {
 			spin_lock(&rxnet->call_lock);
-			list_del_init(&call->link);
+			list_del_rcu(&call->link);
 			spin_unlock(&rxnet->call_lock);
 		}

I haven't dug around to see if there's some higher level lock
protecting the whole op, so I didn't mention it. But I was worried
that on_list() would lead to questionable code, and the first use
didn't deliver the reassurance I was hoping for.

> (b) if the code in question really doesn't know what the ^%&%^ it did,
> and has lost sight of what it has done to a list entry, and really
> wants some kind of "did I remove this entry already" logic, I would
> encourage such uses to either re-consider, or just use the
> "__list_del_clearprev()" function when removing entries.
> 
> Because I really don't want the core list handling to cater to code
> that doesn't know what the hell it has done.


