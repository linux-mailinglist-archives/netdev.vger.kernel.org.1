Return-Path: <netdev+bounces-259635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGO4IJC0l2lq6gIAu9opvQ
	(envelope-from <netdev+bounces-259635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 02:10:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E182F164170
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 02:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9454E3010157
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26D31ADFE4;
	Fri, 20 Feb 2026 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY9TgB6v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF80922339;
	Fri, 20 Feb 2026 01:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771549837; cv=none; b=ghbiMDFq1u8t2ZZxzTGK5IKqiMHdtnls8i427TDI7LXiC4Pty2b0loCyhp33oC/iccoY1HACloXH6pOiNayNu2c/dFObntPBrOl21lYLyA0wkOsjG8PU6yDINfONOYKUSOqHOsKckJb5LFdkXoTSgsrw3ZFiHvl8HaRpgcEZH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771549837; c=relaxed/simple;
	bh=+cEYdrPqt3aW/iPpEkJXXtYoHFmzqnGk/4pzswcfIJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lA1o2H2rqkc4vLlA7bFb8t7IswLQkSWMBgpnBPYkH9XKgOc5iCbgtbKK85Ogv+II/Qs1r7wAHZQ9XpoETaxlrmbbZw+j1K9or6S9MLVMdrEfFsgD+IQWgbj4rVaubtNTeCbDgxYMHFUlay+zlXDGjMLBRkHvBCsiSiDpysv7Rtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY9TgB6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919EFC4CEF7;
	Fri, 20 Feb 2026 01:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771549837;
	bh=+cEYdrPqt3aW/iPpEkJXXtYoHFmzqnGk/4pzswcfIJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dY9TgB6vmBr/nvL9t3TCHS4MFjL3WYqUBjfGNoxLRZWGQYl9T6IW0jh/fY6AlbY+U
	 1ZW1p3cEVnNceWrx1K8piKLKn5YIX9mid+SGZvywUZg8ZWoAJDtDxYyuaajo/wxOfX
	 IB+TMjEja5lqAWz5ATR2TludqI5tgfOANVc0Jr/yG7NaQ7v/RTk7CBNbImoEMMUDTi
	 Vfj9/woTXerfpzUogE8dmoCZ+45+IAl7Wcj8RtGpmrCkC+SnyEpp7yXFk/LS7y+2JR
	 /raFhq5eNOY8e/6yS1dGxBOOW9hYAKhROx1oNSxm/GRWgnNUlcwoPEmbODuzHCDrP+
	 s4kPRBoDXsgBg==
Date: Thu, 19 Feb 2026 17:10:35 -0800
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
Message-ID: <20260219171035.2a9c10d9@kernel.org>
In-Reply-To: <aZerMs_c5W81t9BV@mini-arch>
References: <20260214033859.43857-1-jiayuan.chen@linux.dev>
	<aZURjBHTHRvjP7Ee@mini-arch>
	<20260218174025.2fe593d3@kernel.org>
	<aZdddVNRy6sYiUEt@mini-arch>
	<20260219121213.5b5ab0e7@kernel.org>
	<aZerMs_c5W81t9BV@mini-arch>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259635-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E182F164170
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 16:30:42 -0800 Stanislav Fomichev wrote:
> > > But you have a point, per netdevices.rst ndo_set_rx_mode is synchronized via
> > > netif_addr_lock and we are breaking that with this patch.. :-(
> > > (so I don't think we need an instance lock if we keep netif_addr_lock?)
> > > 
> > > For this particular issue, maybe we can do something similar to net_todo_list?
> > > Instead of changing the promisc for !FLT under right here right now, move it
> > > to the rtnl_unlock? Not sure how important the ordering is..  
> > 
> > Not sure. Another alternative is to implement the long standing idea of
> > having an async / sleeping version of ndo_set_rx_mode() orchestrated
> > by the core. Because a lot of drivers need to sleep, anyway, so they
> > just schedule a work from that callback.
> > 
> > Then we can say old ndo_set_rx_mode is under netif_addr_lock.
> > ndo_set_rx_mode_async is under instance lock.  
> 
> That sounds like a better plan going forward, but gonna need a bunch of
> work to redo the addr lock it seems? We can start with moving promisc into
> rtnl_unlock to unblock that "bridge vlan_filtering 1" and I
> can look into adding an instance lock for set_rx_mode.. LMK if you prefer
> me to focus on the latter and don't waste time on the former. 

I'd jump directly to the latter.
Former adds its own trickiness and IIUC the latter will deprecate it.

