Return-Path: <netdev+bounces-259618-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id h+owODurl2kL5QIAu9opvQ
	(envelope-from <netdev+bounces-259618-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:30:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDBE163DB6
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5368300FB5C
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D912AD3D;
	Fri, 20 Feb 2026 00:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLUqycTF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438A5C8F0
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771547446; cv=none; b=Ucx+P9HrttnvErxd4b0UxyN7JdVIn4sTFv9DIrIZ67dY9PZLmit86IFFGhKcN8DK+H1bRGWxLRYv2+L9uD0Mo+RakVs2Uu4L7Um5z+Tngx5K3cDRHNeCN1RkaA8kwp43J12T+VLK3uBgiuDXVvUeAA5daVJjbUajdQ+mYyBZuoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771547446; c=relaxed/simple;
	bh=JHQUE5GOzFNyvc1ZCVCk74Z1cDW9iwN2hrJNEY5Vb58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGZ0G9SjjpURu90a9sxmO24f44hG5D+Lz45UQnrlp5ahH44GqPFKthoPMcD/RPokf6dtcCCIbtkGf2TyJfFMG4aFmmaGTzAR21Idv7fCxQPJmEzhZL9BEZAzBRRIz530gE2fGevjd5pbEobU57M/hiz/gd46XYDyTZk2c+XFb2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLUqycTF; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-127380532eeso1598326c88.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 16:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771547444; x=1772152244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T2PIPxpQNA63NGLvP9npisU2Bb/eGAYAhx+E8CbqwmE=;
        b=WLUqycTF2HMidqTQ7nBvl7mTxp8UCExHtH6g7ygM5ga5KWtu0XmZgrzO84RcFrsJTZ
         cyfXaLLC6Mufb8SpQIycGgug1oQZUAOztsfXhMPp7ntQdnz8wVTV29MXGiq3dq+vTKUJ
         Mcn5VocdZQyrtTDtggbuD9OjZmX0LfiM5Yi4U5/Ghok5pl44SPYh21qRHW0LSOXc8F81
         1lW+XXEb+ozPYBGHdymT9DTs5E9KSl2ej/nm4oGM7q4BIXjHQn3g13z+5naGocjyDNWi
         xt9xWiLgJwf2HsPYijoxoygIj+3jkTWhNfIOq1pGiBcj7EyhekV+/CeI3TY1KD1OliTG
         UD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771547444; x=1772152244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2PIPxpQNA63NGLvP9npisU2Bb/eGAYAhx+E8CbqwmE=;
        b=PMBaISF5LWECZb0vQIcMDP2sFfT8efywoRXjzBf0XTNOsAJ3f5Biv/EGD8iUXGayVt
         yWh+poSqfULRRbOHq3kmbK6hfpnPiNmsByEnVL5t4FO5TBcPgzax2PvPR/F41wtl9UG9
         ynXW7QwZ6KSTxaPihJnyqRDBhG1Biwd4J1bXZu/VDSggIQFf84jd+Yb0VwjC3WKpwGp4
         /26mw6ogWlUgqytlWdFG9UXDuOMFvfmXmimbUHlVQJvYvMQadcJkCDYskYf1I1NTv5in
         HNqNa0gzPBJUuHaN73NAL+aiK1BsWGekRQlYZ/CiKNu+o1sG6V0Rl0cr1cTRJie9W/aq
         AjBw==
X-Forwarded-Encrypted: i=1; AJvYcCUj1VTQJy/iiUoSRM1Xf73qcp1/nND+ue0pyCQsWEI7BD+WCIH5+9/ggg5FXKkIKWq33Jgf7Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcNUog67N19WBol76GXdIn1ca62rLvvq4y7OCsbPAbj4EBoVxc
	24jK5Tz7Dk5uzAZ1s/3xp2n8RO60xsL+nhk7VHwNEGWX/kdHd7xHeKI=
X-Gm-Gg: AZuq6aI0pJ9L9wpTFnqrzF+Z4QcjpAVSnuVaIEcZXyZErEwxgiPtAHl9OwvR4RpABnK
	qraEq5BLTwMWvwG0AAiBAx3ZHzEuRXfM7p81jKSnS2dWeKkGYeQ/HGf6byJZhP4iFtqivV3xG7K
	Yttr0MSQ6Y9K+3emtbn46uj5EYvcayNdWPqwCu7xnPboe+EdnPLgeEtpjmLjM2Kc9iuqZw24fH3
	87FkGGoJ7gUNBFa+/IA7ozYAbTDq+yOqzb01sVomCR4VoFnPSjPb2nVPG+wCmI8qb6qZyPjrOBM
	bcnhlluJcVjQTYvuaXVxtglt3MpNWp3psnE3djAmOEgmEojpJmde+9S5iFs26/nIMxRR58X67rZ
	KsZOJglBRGaFggsGB8v93Nyxlc70dJZ0+qfNqScouGHMmw0buvYisoBHpojHFJ5lDGUwBAyvDPw
	2fIMaj6b4fyM+0xljMKYHLXKwIjdXu1GfqAOPEcol615yRNpa5uOxLYUMwrXn/8rtM4XQwZMFKc
	bgUAv+ar2X8zT/Tip/pOTlCGP/O
X-Received: by 2002:a05:7022:6626:b0:11b:a3a7:65cd with SMTP id a92af1059eb24-12759a1ee7emr3982672c88.12.1771547443952;
        Thu, 19 Feb 2026 16:30:43 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742c6dc70sm23197294c88.8.2026.02.19.16.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 16:30:43 -0800 (PST)
Date: Thu, 19 Feb 2026 16:30:42 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: defer __dev_set_promiscuity() to avoid
 sleeping in atomic context
Message-ID: <aZerMs_c5W81t9BV@mini-arch>
References: <20260214033859.43857-1-jiayuan.chen@linux.dev>
 <aZURjBHTHRvjP7Ee@mini-arch>
 <20260218174025.2fe593d3@kernel.org>
 <aZdddVNRy6sYiUEt@mini-arch>
 <20260219121213.5b5ab0e7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260219121213.5b5ab0e7@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259618-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,2b3391f44313b3983e91];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3EDBE163DB6
X-Rspamd-Action: no action

On 02/19, Jakub Kicinski wrote:
> On Thu, 19 Feb 2026 10:59:01 -0800 Stanislav Fomichev wrote:
> > On 02/18, Jakub Kicinski wrote:
> > > On Tue, 17 Feb 2026 17:10:36 -0800 Stanislav Fomichev wrote:  
> > > > > Reproducer:
> > > > > 
> > > > >   ip link add dummy0 type dummy
> > > > >   ip link add team0 type team
> > > > >   ip link set dummy0 master team0
> > > > >   ip link set team0 up
> > > > >   ip link add bridge0 type bridge vlan_filtering 1
> > > > >   ip link set bridge0 up
> > > > >   ip link set team0 master bridge0
> > > > >   ip link add macsec0 link bridge0 type macsec
> > > > >   ip link set macsec0 up   # triggers the bug    
> > > > 
> > > > Can you add it as a selftest under selftests/drivers/net/team/?  
> > > 
> > > Stan, this "fix" may work for the promisc flag but won't we have 
> > > the same problem with sync'ing the address list? Looks like team
> > > will do:
> > >  - team_set_rx_mode()
> > >    - dev_uc_sync_multiple()
> > >      - __dev_set_rx_mode(port->dev)
> > > so AFAICT we're calling ndo_set_rx_mode without holding the instance
> > > lock?  
> > 
> > Not sure I understand your trace without more details about the hierarchy.
> 
> Team on top of a ops-locked netdev 
> 
>  - team_set_rx_mode() # set_rx_mode on team
>    - dev_uc_sync_multiple()
>      - __dev_set_rx_mode(port->dev) # calls ndo_set_rx_mode on ops-locked
>                                     # netdev without holding the inst. lock
> 
> IOW this will fire:
> 
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 6285fbefe38a..77991f62bffc 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -184,6 +184,7 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  static void nsim_set_rx_mode(struct net_device *dev)
>  {
> +       netdev_assert_locked(dev);
>  }
>  
>  static int nsim_change_mtu(struct net_device *dev, int new_mtu)

Ah, you're saying in general.. Yeah, agreed, for the instance locked
devices not grabbing an instance lock for these paths looks problematic.
 
> > But you have a point, per netdevices.rst ndo_set_rx_mode is synchronized via
> > netif_addr_lock and we are breaking that with this patch.. :-(
> > (so I don't think we need an instance lock if we keep netif_addr_lock?)
> > 
> > For this particular issue, maybe we can do something similar to net_todo_list?
> > Instead of changing the promisc for !FLT under right here right now, move it
> > to the rtnl_unlock? Not sure how important the ordering is..
> 
> Not sure. Another alternative is to implement the long standing idea of
> having an async / sleeping version of ndo_set_rx_mode() orchestrated
> by the core. Because a lot of drivers need to sleep, anyway, so they
> just schedule a work from that callback.
> 
> Then we can say old ndo_set_rx_mode is under netif_addr_lock.
> ndo_set_rx_mode_async is under instance lock.

That sounds like a better plan going forward, but gonna need a bunch of
work to redo the addr lock it seems? We can start with moving promisc into
rtnl_unlock to unblock that "bridge vlan_filtering 1" and I
can look into adding an instance lock for set_rx_mode.. LMK if you prefer
me to focus on the latter and don't waste time on the former. 

