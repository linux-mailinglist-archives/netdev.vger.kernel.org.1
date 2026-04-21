Return-Path: <netdev+bounces-280101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAWUBpht52ke8AEAu9opvQ
	(envelope-from <netdev+bounces-280101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:29:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6239A43A9F8
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7AF4300CBD7
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 12:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8F23C4553;
	Tue, 21 Apr 2026 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZhMNGBa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BB33C455C;
	Tue, 21 Apr 2026 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774490; cv=none; b=E3vCKrm2PHdUKh6pVLyQHpwLjzK3VffS9tJIV2G2reJH1Pcm5gCcWk4cMPLsYVPFLWjQry38pb0MAhHTE+zAFnNk2OzLSKWVqoUtYuM3tGJ+Tb3rCFYeHVbhAKzMiTmh3bpjILshG3THdQvMM9jB/tOsJhOaXIKtZ25voKx797w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774490; c=relaxed/simple;
	bh=SDyBzgCycOBHwfzh3Gt4icHGQgqy60beF8+fj/MrjW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgfwWK3ZdyyENzawv2ssitUFBbu91qaBo36owTkDlJV2xkAUQ/UQG6KHYZuQBsV7pnrKKyKJ/94mrsKLu6Dg4iA9f4yks9ozZdfqsVAS+RGRzYpveeieYZn0dx0KLwCDRPwAEz69P4zxNzvMi5IaW+xS6um9Ul6kxpKkOPuBwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZhMNGBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC599C2BCB0;
	Tue, 21 Apr 2026 12:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776774489;
	bh=SDyBzgCycOBHwfzh3Gt4icHGQgqy60beF8+fj/MrjW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PZhMNGBau1y7Xo5k5ig563sCBRdH5Z/+GrquuM0r/F6KWBpPr+c/XBbT0P0dBkanu
	 NQgGsgGYalFhXIQvuBoxRkAFyjqewZ+zUy6Fdg/zitAoB93lHDrNyQyqJOMEDuvumY
	 69I40orC3KBCqHniAmavNSuuHpe/26oXJ1a+V0bcHZVBNK4a8ap2v5UqiENTr86S7v
	 Q4YntHOZytfzn9c/F6anhTSWHrZp2WSc0NKcTePsWyXrJRP01x0S+GNFPO1pmc4hk8
	 Qb28vnJDdgGl0zSk0byic2fBEPBwnH8zNwxHQU/XBCXsiPjjPpK4gmF5c7d2Ikw0BM
	 gXi2bPngfz8vw==
Date: Tue, 21 Apr 2026 13:28:04 +0100
From: Lee Jones <lee@kernel.org>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] tipc: fix double-free in tipc_buf_append()
Message-ID: <20260421122804.GI3202366@google.com>
References: <20260420130524.3527420-1-lee@kernel.org>
 <GV1P189MB19886E03BDD0F407B757E5ABC62F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <20260420143309.GD3202366@google.com>
 <GV1P189MB198853F316580DDA547F4925C62F2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <20260420151040.GF3202366@google.com>
 <20260421103543.GH3202366@google.com>
 <GV1P189MB198888D44169106BFB04359BC62C2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <GV1P189MB198888D44169106BFB04359BC62C2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280101-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,carlini.com:email]
X-Rspamd-Queue-Id: 6239A43A9F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026, Tung Quang Nguyen wrote:

> >Subject: Re: [PATCH 1/1] tipc: fix double-free in tipc_buf_append()
> >
> >On Mon, 20 Apr 2026, Lee Jones wrote:
> >
> >> On Mon, 20 Apr 2026, Tung Quang Nguyen wrote:
> >>
> >> > >> Subject: [PATCH 1/1] tipc: fix double-free in tipc_buf_append()
> >> > >> >
> >> > >> >The tipc_msg_validate() function can potentially reallocate the
> >> > >> >skb it is validating, freeing the old one.  In
> >> > >> >tipc_buf_append(), it was being called with a pointer to a local
> >> > >> >variable which was a copy of the
> >> > >caller's skb pointer.
> >> > >> >
> >> > >> >If the skb was reallocated and validation subsequently failed,
> >> > >> >the error handling path would free the original skb pointer,
> >> > >> >which had already been freed, leading to double-free.
> >> > >> >
> >> > >> >Fix this by passing the caller's skb pointer-pointer directly to
> >> > >> >tipc_msg_validate(), ensuring any modification is reflected correctly.
> >> > >> >The local skb pointer is then updated from the (possibly
> >> > >> >modified) caller's pointer.
> >> > >> >
> >> > >> >Fixes: d618d09a68e4 ("tipc: enforce valid ratio between skb
> >> > >> >truesize and
> >> > >> >contents")
> >> > >> >Assisted-by: Gemini:gemini-3.1-pro-preview
> >> > >> >Signed-off-by: Lee Jones <lee@kernel.org>
> >> > >> >---
> >> > >> > net/tipc/msg.c | 3 ++-
> >> > >> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >> > >> >
> >> > >> >diff --git a/net/tipc/msg.c b/net/tipc/msg.c index
> >> > >> >76284fc538eb..9f4f612ee027
> >> > >> >100644
> >> > >> >--- a/net/tipc/msg.c
> >> > >> >+++ b/net/tipc/msg.c
> >> > >> >@@ -177,8 +177,9 @@ int tipc_buf_append(struct sk_buff
> >> > >> >**headbuf, struct sk_buff **buf)
> >> > >> >
> >> > >> > 	if (fragid == LAST_FRAGMENT) {
> >> > >> > 		TIPC_SKB_CB(head)->validated = 0;
> >> > >> >-		if (unlikely(!tipc_msg_validate(&head)))
> >> > >> >+		if (unlikely(!tipc_msg_validate(headbuf)))
> >> > >> > 			goto err;
> >> > >> >+		head = *headbuf;
> >> > >> This is a known issue and was reported via
> >> > >> https://patchwork.kernel.org/project/netdevbpf/patch/202603302053
> >> > >> 13.24 33372-1-nicholas@carlini.com/ The author did not respond to
> >> > >> my comment.
> >> > >> Can you improve the fix by applying my patch?
> >> > >
> >> > >I'd be happy to make any required changes.
> >> > >
> >> > >However, is this approach superior to simply passing a reference?
> >> > >
> >> > >v1 appears to be simpler, easier to read and avoids the explanation.
> >> > >
> >> > As I explained, your fix adds extra overhead to normal path while the error
> >path is corner case and it rarely happens.
> >> > Whatever approach is applied, we need to add explanation to understand
> >more easily the logic and hidden trick in tipc_msg_validate().
> >>
> >> Very well.  I have made the recommended changes.
> >>
> >> The patch is currently in my build-test environment.
> >>
> >> I will post v2, when everything has been satisfied.
> >
> >Okay, I genuinely tried to apply your patch.  It builds just fine, but Gemini (the
> >AI I use to pre-review patches before submission) has some doubts that this is
> >the correct approach:
> >
> >> @@ -177,8 +177,20 @@ int tipc_buf_append(struct sk_buff **headbuf,
> >> struct sk_buff **buf)
> >>
> >>       if (fragid == LAST_FRAGMENT) {
> >>               TIPC_SKB_CB(head)->validated = 0;
> >> -             if (unlikely(!tipc_msg_validate(&head)))
> >> +
> >> +             /* If the reassembled skb has been freed in
> >> +              * tipc_msg_validate() because of an invalid truesize,
> >> +              * then head will point to a newly allocated reassembled
> >> +              * skb, while *headbuf points to freed reassembled skb.
> >> +              * In such cases, correct *headbuf for freeing the newly
> >> +              * allocated reassembled skb later.
> >> +              *
> >> +              * Note: It's done this way instead of passing &head          // I added
> >this part to give
> >> +              * to avoid slowing down the happy path since this failure    // the
> >reviewer some additoinal
> >> +              * is a rare event.                                           // context
> >> +              */
> >> +             if (unlikely(!tipc_msg_validate(headbuf))) {
> You did NOT apply my patch correctly. I did not suggest passing headbuf to tipc_msg_validate().

Ah, you're right.  I missed that line change.

Let me revisit.  Bear with.

> My patch is very simple:
> +               if (unlikely(!tipc_msg_validate(&head))) {
> +                       /* reassembled skb has been freed in
> +                        * tipc_msg_validate() because of invalid truesize.
> +                        * head now points to newly-allocated reassembled skb
> +                        * while *headbuf points to freed reassembled skb.
> +                        * So, correct *headbuf for freeing newly-allocated
> +                        * reassembled skb later.
> +                        */
> +                       if (head != *headbuf)
> +                               *headbuf = head;
> +
>                         goto err;
> +               }

-- 
Lee Jones [李琼斯]

