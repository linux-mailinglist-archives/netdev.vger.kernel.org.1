Return-Path: <netdev+bounces-279516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHBuK9it42lTJwEAu9opvQ
	(envelope-from <netdev+bounces-279516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 18:14:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F894218BE
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 18:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21F7C3030D70
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 16:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D9D2BDC1C;
	Sat, 18 Apr 2026 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="plAamBTv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22CA937
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776528499; cv=none; b=Er73Cro4ubp94m2tfhs91PWHn3dIPf+GPlY4aa2qpDoGNNn3mpyCX97izO+wdTL9NYHXNFvlu+rIQ1o46kwwTwC5OP7JBNVmvc4rp4DnPv4H2zguQ1reVkDI7Wc8eZTgEOJGgzQA1xeFsTmaa0s+tYjaIN2Q6n+iNWzjS/dK2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776528499; c=relaxed/simple;
	bh=MPkfFQ41erD4o5Av0BZ/pBIQLu2DwTBZ4tj2BmidiY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZmui+SsThy2PfNS+hGJoGELobMQQqVXyx1IqMy78FIdrCZQ+nH3kC8ER5aCPS3PbNh7AZRsfiQalBHUnP2zYmAZU9Kw8VMsP7g4rTtvTza36GY/2LkQLYKtghBvWzbI6mnmmJ2jx8VPguwnncGjCWMZMifIGuPoeZOUVTZgh0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=plAamBTv; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35d9f68d011so1087067a91.2
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776528498; x=1777133298; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RRAoYfWcqRWUrhyLRC2uhFHt0uJW5uJfqHxy06rQkIE=;
        b=plAamBTv3EUS4T1ddZJpd84JMCWJ08/samG1wsj3HsoqJsahPF2rADi7YIbWBlkkok
         PuBXpWZH89w1mD4dHgncGaEnff8aVcRdGeK43v+4CSdNl0JTsSjdKDhMdcdXM7CDasgv
         mFJqk4b9SDs9UcX5kivs2i79IYN0fYypifOwfgef0RG8gO3rtzeN2tGqCRwi6EpwZP50
         yIv0lgPDjbUAmu+d30X/Ht6C2xEAKq6diwr2SrkHejB5Lx0mCpJKV/P086xpZautx1GI
         OOM37IeTIy2EVTUmL96FOeeIaueeO0Uh7m2HFpzPHsskllskULQN0eXKzWdV2nndl1KP
         ZLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776528498; x=1777133298;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRAoYfWcqRWUrhyLRC2uhFHt0uJW5uJfqHxy06rQkIE=;
        b=h9Q5GXuxHHyet3mQ7eti7zDwB+CYjga10K7uqMgmHpcFyitYeVt7PSoY5bNlOpwNE1
         bivne/XgG6jcPZAwI/a9rxEHGPMHneKiGwVA7DX5vd5VV4XRcuORSBlPDhoayiIxcv8h
         8KR6CWyvtNNh/oXBHiEUEVVhqOQNEJvtHoeMXN6PYFI6Z/sIyeO4sjA5jhQV97e2Ff5n
         Ygc7NmoLebVFs4m60vE/iWDY6966yOAsqJueUWNQXXDxOD1PNyQxI7yHw3eP6+bOC9lK
         NbvLZO4PDsQJthLKtquaPJSNeXU9lKbzdIg8VeR62MNZoZ43BxALUINdfZInGVXq43/s
         YBmg==
X-Forwarded-Encrypted: i=1; AFNElJ8nqsPWDJW9oYcf4aaLHAnrstck4+IfJ11OAKRAQ5j+DXebBUfF8H9MPCUT0IHz5XhW+qOvMYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqnIxpGdp/iVVf3s1GyH52CALYIPfGimaTxYGr3C+RN4DV04dW
	p2yo3fz7OXB3p53L1iwsgXHB+tTUwMxNMTfsKAaivG1Q05Q4Wd03lOwe
X-Gm-Gg: AeBDiesGYlrYdHZwIePuSt8ZYZlags7Wu4LZ6Na08HJT5ih2fu7T/YVNgV2eS9NWCpc
	DkxrS9rGJgVReuun7C/ShjurPUDjwuhjBaQ7RrrEIIylpWCMyhdjs0rFkkfBGTDDEPtQIowdOzn
	jKJeNMdc5uOOQ3hidgqv3FcNrS9qJq5VlX/piZRQ1z0r72XqzSh4lauITPlqem862I/00hJ10Za
	CHWb9lKuWHob3V7JHsMNcl5y5mBTDf/nryiKUGMxCC8FgYilD0o5WdO0qT65V5I7m9rwWl/A/uE
	PV5IXj3PHBRIYnqON5F0TsQecAVbfV756jz6J8KGrp0nKkMmzSF7RI9zo2bnCj36lAd/kpHP7Wt
	8xduqdYRJNOJaQCLXYcnYeeHX3k6k0229D0Uvenq/3aIs//5a2gFaCah2Xk/Z48+x+WJua9lasB
	DGxmoo9TLzRi4F0O0ijjYWkx+x27UDewv9xS4DNQlzgmnRdlw743hURnmPjOCPXdM=
X-Received: by 2002:a17:90b:2892:b0:35e:5ae3:2993 with SMTP id 98e67ed59e1d1-36140462ae6mr7188466a91.15.1776528498064;
        Sat, 18 Apr 2026 09:08:18 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fa69951sm2737067a91.1.2026.04.18.09.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:08:16 -0700 (PDT)
Date: Sun, 19 Apr 2026 00:08:10 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] vxlan: fix NULL vn6_sock dereference in
 vxlan_igmp_join() and vxlan_igmp_leave()
Message-ID: <aeOsaucqLnj09Ron@Air.local>
References: <20260418114110.2602784-3-bestswngs@gmail.com>
 <20260418155843.GA808294@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418155843.GA808294@shredder>
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-279516-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.979];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: 23F894218BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-18 18:58, Ido Schimmel wrote:
> On Sat, Apr 18, 2026 at 04:41:12AM -0700, Weiming Shi wrote:
> > vxlan_sock_add() tolerates IPv6 socket creation failure with
> > -EAFNOSUPPORT (e.g. ipv6.disable=1), leaving vn6_sock as NULL while
> > successfully creating vn4_sock. vxlan_igmp_join() and
> > vxlan_igmp_leave() then crash when they dereference the NULL vn6_sock
> > for VNI filter entries with IPv6 multicast groups:
> > 
> >  Oops: general protection fault, probably for non-canonical address
> >       0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
> >  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> >  RIP: 0010:vxlan_igmp_join (drivers/net/vxlan/vxlan_multicast.c:40)
> >  Call Trace:
> >   vxlan_multicast_join (drivers/net/vxlan/vxlan_multicast.c:195)
> >   vxlan_open (drivers/net/vxlan/vxlan_core.c:2965)
> >   __dev_open (net/core/dev.c:1704)
> >   __dev_change_flags (net/core/dev.c:9781)
> >   do_setlink.isra.0 (net/core/rtnetlink.c:3180)
> >   rtnl_newlink (net/core/rtnetlink.c:4238)
> >   rtnetlink_rcv_msg (net/core/rtnetlink.c:6921)
> > 
> > Skip the IPv6 multicast join/leave when vn6_sock is NULL, consistent
> > with how vxlan_sock_add() tolerates missing IPv6 support.
> > 
> > Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> 
> AFAICT, this is the same patch as:
> 
> https://lore.kernel.org/netdev/20260323095544.3311285-4-bestswngs@gmail.com/
> 
> If you disagree with the feedback, then please comment there instead of
> reposting the patch.
> 
Apologies for the duplicate posting - I should have followed up on the
original.

Thanks,
Weiming Shi
> > ---
> > v2:
> >   - drop sock4 NULL checks 
> > 
> >  drivers/net/vxlan/vxlan_multicast.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/net/vxlan/vxlan_multicast.c b/drivers/net/vxlan/vxlan_multicast.c
> > index a7f2d67dc61b..e6aa5ab1c939 100644
> > --- a/drivers/net/vxlan/vxlan_multicast.c
> > +++ b/drivers/net/vxlan/vxlan_multicast.c
> > @@ -37,6 +37,9 @@ int vxlan_igmp_join(struct vxlan_dev *vxlan, union vxlan_addr *rip,
> >  	} else {
> >  		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
> >  
> > +		if (!sock6)
> > +			return 0;
> > +
> >  		sk = sock6->sock->sk;
> >  		lock_sock(sk);
> >  		ret = ipv6_stub->ipv6_sock_mc_join(sk, ifindex,
> 
> This line changed in commit 29ae61b2fe7e ("drivers: net: drop ipv6_stub
> usage and use direct function calls")
> 
> > @@ -71,6 +74,9 @@ int vxlan_igmp_leave(struct vxlan_dev *vxlan, union vxlan_addr *rip,
> >  	} else {
> >  		struct vxlan_sock *sock6 = rtnl_dereference(vxlan->vn6_sock);
> >  
> > +		if (!sock6)
> > +			return 0;
> > +
> >  		sk = sock6->sock->sk;
> >  		lock_sock(sk);
> >  		ret = ipv6_stub->ipv6_sock_mc_drop(sk, ifindex,
> > -- 
> > 2.43.0
> > 

