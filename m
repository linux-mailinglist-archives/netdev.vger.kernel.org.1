Return-Path: <netdev+bounces-259584-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kK+qLqRul2lSygIAu9opvQ
	(envelope-from <netdev+bounces-259584-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:12:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 286EB16241A
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 21:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA8AB301A28D
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264612FE066;
	Thu, 19 Feb 2026 20:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ij6jb5I6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0400E212F98;
	Thu, 19 Feb 2026 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771531936; cv=none; b=BfW9Q51TyPrjXyPHhJ9cJjfl1sHyQ40vkUk6wsT3KV+imqY891zy7j2AxfLVg/W7rPYqq6VheLzg/aOJx+X43uxvFyURdx7cA1omEwWG18dXdB2jHXDWwCZWi6WYbNvKIgGyEXl3fxWPPKfacbEaPNS0ada2u1pxDVKZv/EftV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771531936; c=relaxed/simple;
	bh=gg2Ry6/6IRVDRj5ymbtX2OIsJLsK17ha1MvopGvWUPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3wWQRt8/WBeHNVmuxeWB0wq2ioRuPtiCqgBrBEwtipW1i8YuhdGl4cQt2JrkxY3989i0DXSWCnHFUM0amM9xZpiBVaZLqgplXxaJqgbNsaoeG9OCoOGqf59EXcE26bc9f7VP/hztlMEhzfQNLaiNblWaS7wscjWsF+dpCuV6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ij6jb5I6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDF0C4CEF7;
	Thu, 19 Feb 2026 20:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771531935;
	bh=gg2Ry6/6IRVDRj5ymbtX2OIsJLsK17ha1MvopGvWUPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ij6jb5I60aaKZlgk9dPM7KNj8UmOjqAfDc8gLP+NklDuyRiOGIeT5+2ug1YSWlNZD
	 RbmK8YQqV+MsgalmaYIuz+iU16jbZHltCMRScp85iown66y6kno/IyzJ9mHAQdqkRU
	 H1GEuPLXos2vTCNoLr15kBviF8U5p34PjpDTOqsR+BjJ1KFrt6tqD1/FOU1R1OJuwA
	 kqWChNy+IvRJUzW4BmQgsM1XWCCj1sP8CfPK3ZtLGt+A5XA5V1XzZK1Qh1jgA/W8Y+
	 ovm0cv2+ETzwKE97oKhy0N/9hfWJZNKENv3LvkkXTDAa+EBqJ9FNw4T+/Vo9Tjreb4
	 aiJvNFBCb/Y8g==
Date: Thu, 19 Feb 2026 12:12:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, Jiayuan
 Chen <jiayuan.chen@shopee.com>,
 syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
 <sd@queasysnail.net>, Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki
 Iwashima <kuniyu@google.com>, Samiullah Khawaja <skhawaja@google.com>,
 Ahmed Zaki <ahmed.zaki@intel.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: defer __dev_set_promiscuity() to avoid
 sleeping in atomic context
Message-ID: <20260219121213.5b5ab0e7@kernel.org>
In-Reply-To: <aZdddVNRy6sYiUEt@mini-arch>
References: <20260214033859.43857-1-jiayuan.chen@linux.dev>
	<aZURjBHTHRvjP7Ee@mini-arch>
	<20260218174025.2fe593d3@kernel.org>
	<aZdddVNRy6sYiUEt@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259584-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,2b3391f44313b3983e91];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 286EB16241A
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 10:59:01 -0800 Stanislav Fomichev wrote:
> On 02/18, Jakub Kicinski wrote:
> > On Tue, 17 Feb 2026 17:10:36 -0800 Stanislav Fomichev wrote:  
> > > > Reproducer:
> > > > 
> > > >   ip link add dummy0 type dummy
> > > >   ip link add team0 type team
> > > >   ip link set dummy0 master team0
> > > >   ip link set team0 up
> > > >   ip link add bridge0 type bridge vlan_filtering 1
> > > >   ip link set bridge0 up
> > > >   ip link set team0 master bridge0
> > > >   ip link add macsec0 link bridge0 type macsec
> > > >   ip link set macsec0 up   # triggers the bug    
> > > 
> > > Can you add it as a selftest under selftests/drivers/net/team/?  
> > 
> > Stan, this "fix" may work for the promisc flag but won't we have 
> > the same problem with sync'ing the address list? Looks like team
> > will do:
> >  - team_set_rx_mode()
> >    - dev_uc_sync_multiple()
> >      - __dev_set_rx_mode(port->dev)
> > so AFAICT we're calling ndo_set_rx_mode without holding the instance
> > lock?  
> 
> Not sure I understand your trace without more details about the hierarchy.

Team on top of a ops-locked netdev 

 - team_set_rx_mode() # set_rx_mode on team
   - dev_uc_sync_multiple()
     - __dev_set_rx_mode(port->dev) # calls ndo_set_rx_mode on ops-locked
                                    # netdev without holding the inst. lock

IOW this will fire:

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 6285fbefe38a..77991f62bffc 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -184,6 +184,7 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 static void nsim_set_rx_mode(struct net_device *dev)
 {
+       netdev_assert_locked(dev);
 }
 
 static int nsim_change_mtu(struct net_device *dev, int new_mtu)

> But you have a point, per netdevices.rst ndo_set_rx_mode is synchronized via
> netif_addr_lock and we are breaking that with this patch.. :-(
> (so I don't think we need an instance lock if we keep netif_addr_lock?)
> 
> For this particular issue, maybe we can do something similar to net_todo_list?
> Instead of changing the promisc for !FLT under right here right now, move it
> to the rtnl_unlock? Not sure how important the ordering is..

Not sure. Another alternative is to implement the long standing idea of
having an async / sleeping version of ndo_set_rx_mode() orchestrated
by the core. Because a lot of drivers need to sleep, anyway, so they
just schedule a work from that callback.

Then we can say old ndo_set_rx_mode is under netif_addr_lock.
ndo_set_rx_mode_async is under instance lock.

