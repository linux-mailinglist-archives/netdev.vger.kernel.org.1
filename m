Return-Path: <netdev+bounces-245602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C78BCD34E5
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 19:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FD64300D41E
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 18:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3EC2F2905;
	Sat, 20 Dec 2025 18:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LT/dkbNW"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493B2F1FCF
	for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766254503; cv=none; b=Pb9Z3AD14Bkdm0Y9/+dle6hUjSJcV+O5xfmOIe1RZFU+z48NA2grGV+U10DvjsFuZjGNxSB6EyyBowR3LPPlkQLBBozAkZg+7Yv4+Gi7lw2xEuwqMCnu1wd26yfYXCuoRDkvaQ90X/lN5PPvgVxH3K3CEP19Mgk+Su6oDGLaZDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766254503; c=relaxed/simple;
	bh=k+SPZdPMwWc98ktZIo7q5BY0XYgtDIzCH8/+RnB2b3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cX/v13QsM0ebCaGdDMBm3w+w5beEPJVBptAFCIglP6Ww7lQCwBPW+cpQk8TQrSTRUAIZiipn0kqvDmvkHP8ITU3K2j6MmUIXIYNvwETkYPBclyCHfdIOcZaAVlMsMhbyKWzCb5oDkEsLCtH9oRbZUb5fuA4msOpqWRJl+0tlCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LT/dkbNW; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D081D1D0006F;
	Sat, 20 Dec 2025 13:14:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 20 Dec 2025 13:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766254499; x=1766340899; bh=pfFs/8rFHEBhpLWxwjTmnncIxuLwjWkRpNF
	Oly5ZCEU=; b=LT/dkbNW72G7GKGVd/zsR+Gc7XlVKMrX1sF70nYq/4+hOp/qBsA
	b013uiYraX8QCKXaEdlHnKXHnUCB6YLDB7Zcv66XUe9PYDAcgCY2DbqWoRg00SQC
	uWDlx+GP9+4OgFcISDQVOv2bTTa68Kd+tBKswFHyfzRaXt5ghyxgf6k6wpwDo5DD
	b49jabO81A/YHs1/l+2DpGsdpIU2sHPg9iRjrsCqI9DqtuxrJq03uEHXJ0sd+mwQ
	tf4Cd1gbfHA3PPNfKUUp7PHx5VVLzBcLRvp7VIcPhwQgS6rvrXdh4EndkmGUBO2g
	VrkkLlgt2wW91lHZ01INw2dw1DlgLn0Wddw==
X-ME-Sender: <xms:oudGaR9rUaonMUwXAEH1jw7V7k54ePE2VCxSMv-Z5-J2m4SMDVZ4Nw>
    <xme:oudGafzVyZ9SrH0TkdhXFgyAxTQtekXhqr8abyqI1pn7HEHtyKk06RHhXrNnHNb03
    Nq40BzWBJbwU3LYPPVCVHDLToSnN1HgrNaV8dGLk_Ubhh5gTG0>
X-ME-Received: <xmr:oudGae7fWp-5lIM2q1T6H2y4HpOcaRvi_7xN0xnEi2GY7OPNbHhWQYUdmVbKJvBAlyaKSQ4Yy9G0O2NRaZRE7YhWDVxy9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehudekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpeevgeeguefgudeuudeuveelgefgjeeftdelgeffgfejjeduudfffefftddthedtteen
    ucffohhmrghinhepshihiihkrghllhgvrhdrrghpphhsphhothdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihgu
    ohhstghhrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghn
    ghhuihhnqdhkvghrnhgvlhesihdqlhhovhgvrdhsrghkuhhrrgdrnhgvrdhjphdprhgtph
    htthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhunhhi
    hihusehgohhoghhlvgdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:oudGaW8nsuB4Uzef-U2scoCIfnvNGwz63P6YK0zJEoWZoeRE1xZGHw>
    <xmx:oudGaTpCKevhBXdewiny6ri7VSGJY9Rhp5nETmQLaYACziIvNs3NoQ>
    <xmx:oudGaXpscgD6AJ42njQtUZzWz--Dj44MS7Bp8Z_OZIHlCdA-hRo1Tw>
    <xmx:oudGaW1a5PJMWvFkH3szaY_XKhL8IfbeIm4bC1uwTckJQMOVrj3wcw>
    <xmx:o-dGab69hGDRfP8vRH-h9KHWeUQzkHX_qbKQ8eVNZ4DfNqB8e1nkEhSV>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Dec 2025 13:14:58 -0500 (EST)
Date: Sat, 20 Dec 2025 20:14:55 +0200
From: Ido Schimmel <idosch@idosch.org>
To: David Ahern <dsahern@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	"David S. Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [BUG nexthop] refcount leak in "struct nexthop" handling
Message-ID: <aUbnn0uZ3BW997Mx@shredder>
References: <d943f806-4da6-4970-ac28-b9373b0e63ac@I-love.SAKURA.ne.jp>
 <4a682f36-44a0-42c9-a82a-25fed5024cb2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a682f36-44a0-42c9-a82a-25fed5024cb2@kernel.org>

On Sat, Dec 20, 2025 at 10:54:27AM -0700, David Ahern wrote:
> On 12/20/25 7:57 AM, Tetsuo Handa wrote:
> > syzbot is reporting refcount leak in "struct nexthop" handling
> > which manifests as a hung up with below message.
> > 
> 
> ...
> 
> > 
> > Commit ab84be7e54fc ("net: Initial nexthop code") says
> > 
> >   Nexthop notifications are sent when a nexthop is added or deleted,
> >   but NOT if the delete is due to a device event or network namespace
> >   teardown (which also involves device events).
> > 
> > which I guess that it is an intended behavior that
> > nexthop_notify(RTM_DELNEXTHOP) is not called from remove_nexthop() from
> > flush_all_nexthops() from nexthop_net_exit_rtnl() from ops_undo_list()
> >  from cleanup_net() because remove_nexthop() passes nlinfo == NULL.
> > 
> > However, like the attached reproducer demonstrates, it is inevitable that
> > a userspace process terminates and network namespace teardown automatically
> > happens without explicitly invoking RTM_DELNEXTHOP request. The kernel is
> > not currently prepared for such scenario. How to fix this problem?
> > 
> > Link: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
> 
> thanks for the report and a reproducer. I am about to go offline for a
> week, so I will not have time to take a look until the last few days of
> December. Adding Ido in case he has time between now and then.

Thanks for the detailed report. The following is derived from the C
reproducer and works for me:

ip netns add ns1
ip -n ns1 -6 nexthop add id 1 blackhole
ip -n ns1 route add blackhole 0.0.0.0/0 nhid 1
ip netns del ns1

Nexthops are flushed when the network namespace is dismantled, but the
error route that is using the nexthop does not release its reference
from the nexthop. Therefore, the nexthop is not deleted and does not
release the reference from its nexthop device (lo in this case).

The following fixes the issue for me:

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 59a6f0a9638f..7e2c17fec3fc 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2053,10 +2053,11 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 				continue;
 			}
 
-			/* Do not flush error routes if network namespace is
-			 * not being dismantled
+			/* When not flushing the entire table, skip error
+			 * routes that are not marked for deletion.
 			 */
-			if (!flush_all && fib_props[fa->fa_type].error) {
+			if (!flush_all && fib_props[fa->fa_type].error &&
+			    !(fi->fib_flags & RTNH_F_DEAD)) {
 				slen = fa->fa_slen;
 				continue;
 			}

Will post it later this week assuming I don't find problems with it.

