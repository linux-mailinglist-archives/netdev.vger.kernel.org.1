Return-Path: <netdev+bounces-286325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNxpLAevAGqBLgEAu9opvQ
	(envelope-from <netdev+bounces-286325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:15:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5625050DC
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C1B33006F08
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D3D3ACA5D;
	Sun, 10 May 2026 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2iZehBg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D707C3ACA5F
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778429219; cv=none; b=s3p71eom2rljhP4W2fr7y+A8hTSAlt+h4ptqVldz+9Nbz3sFdCSJuBJA2F6G0U968mCl0j/Hv3SfzIJQ5zBYf6cMG1vyX7rRODcjs2p/bwP3d3diTssibg9Scm7oZDeAu+rZTnYef3xJC758s0UD+VuV1h55tofpOKk7uB5HPFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778429219; c=relaxed/simple;
	bh=QeodUXv+OtDwsOMIycmGjzYq5kxdDFaSru4hW5PrMoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEFB9F5vEuyWBWgFradvq0vvIPKj9qKa8JV5p4h6r6oPwh6BX+dAtgctHvYvP6aA7m6oFs1Wm596xEWQ0j7PD/kOHWUCL/et6yQ+33BVdZIep4Y8VNPt9ledqgfMvvzOplfXhlB7k6/we8a554XeSIwaG442/dq0B0fMqOWVfgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2iZehBg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-834f1075805so2466617b3a.2
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 09:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778429217; x=1779034017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yTcd5gvcre/eb37zFDVf2LmU/l5PjVTpXhqHCFd2PzI=;
        b=P2iZehBg+Sei9pszMJX+knJXV6SG0Rv46Dp/0HXASui0lYBfEkJ1uEsnVW/wymToqz
         YHXtlZmuxE6lbQNxACOSqMJ3i+TFw8j1gCrLr1HsMYLZ1yI6qdfoi/FSLZpPj3PkIHr/
         jDY5F4IX9zaAzuTU941sDmofuRcPqBhYDAUBsqD519J2OLb/wv/SeVz1D07lnkySFGKK
         QsX35fdBFh9OhO/OtHsPEdyx+4k4NarrDNXCSwlZ5nCZknKU6OacWqCCcQGDwIhCBxrw
         DKdwsB60NZw3AkkQHJHcfmZ9fHrkmCUecKS+BnP0BmH3JCz9l/GQIkfdp2aytnod46CN
         neCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778429217; x=1779034017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTcd5gvcre/eb37zFDVf2LmU/l5PjVTpXhqHCFd2PzI=;
        b=LDezd1A0GqSCImECRH4zyAiTWbYtRMymP+Wpaye10I/9U0acAlVbVw5G+fX64PecZy
         Z9BPyO2PdYFJhoVY7APDoJ1lvLNZJBblVRe8A9K2TIETBzuda7Z47UIVQJEQ2wphfnqo
         L9o2JVkdBZMZSr5xjlbjx8vbJ7RUB2RPUbZNh8Vf68mZmA3Ihzo075V7cTBOm0RqYOsM
         So+0bTvnz5Y86Y58nKvb0olv5rzAPnd6xE1K/118JIGdxXWzYXSkgZuOQKXkivH7Ol4O
         3kEhPoCQUGe1RrbOpMyWx1weP/2sULYdvQ7YGnA1Krlnw9tM4u6NKFXQt7/UNgnSLIvm
         BMpw==
X-Forwarded-Encrypted: i=1; AFNElJ9xd/n/9lkXst4uKQi7LnZMOHOfK2oS0f5Xxj7z+xa/y2Jt7QpspmifZAnzGYUBvfpyAput5VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyojQC3jYeJTX19ZWIJW+iCrS/nLfXsfpzCZBO8Nt0G4/V4jlTS
	Ux1IdRfFEqqBBnYyRCt3mQgj7a6e1FKTd6hnOsqkjoRggvTethWaWmTf
X-Gm-Gg: Acq92OFCo1F++y1sXE2VUvH+Qr8eTblLuWM4CLkYUrClqPxcni3aQWkoFkwuUBOuygo
	AVqWj9ydmTU++7LgPqZIDfikdCYlhlmVryLDkZutyI4YtNGu3d8z9HKd9yMWLXibS8y2P6ofyAv
	y4Tcl79WtCrGVTl2peDon2ookFA5+j83PZvAiyarWupWQ6/UNh0im9/ZY3LOTn+39+VPJ6V21E/
	OwL6AGJHNbcA2xdYGezV0wnFf0V3iHU3byyGnsgxdd09qsL8howB5YxEs/XaBaSOVjzkif3NVt7
	s1P/hInYYcPREAAQiiR102flt2EqJjYgy4eJpAFl5sZ5K8VieQ2VQ8Ez0q90pn0NYD5CWNlNhOw
	myngD5Dv9CyGqe1oRSB8BLMg3J3+n9fQMcBAQ8R2O3zDs4dgl2wnAUiGmMthgQIZ5bEpe2eT6uP
	Mz3kUCb31sp/DwbW6R1eGZhxE7JYJgAgd16xdAPbsxoNgRPtqRdkU=
X-Received: by 2002:a05:6a00:2a08:b0:83e:b47f:8994 with SMTP id d2e1a72fcca58-83eb47f9233mr3337169b3a.6.1778429216983;
        Sun, 10 May 2026 09:06:56 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbd995sm16412737b3a.43.2026.05.10.09.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 09:06:56 -0700 (PDT)
Date: Mon, 11 May 2026 00:06:50 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH net v2] net: team: fix NULL pointer dereference in
 team_xmit during mode change
Message-ID: <agCtGqWLK53TWCaS@Air.local>
References: <20260509181825.1523951-2-bestswngs@gmail.com>
 <20260510082509.1530a1a3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20260510082509.1530a1a3@kernel.org>
X-Rspamd-Queue-Id: 0A5625050DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[asu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-286325-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,body];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.641];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,asu.edu:email,Air.local:mid]
X-Rspamd-Action: no action

On 26-05-10 08:25, Jakub Kicinski wrote:
> On Sat,  9 May 2026 11:18:26 -0700 Weiming Shi wrote:
> > __team_change_mode() clears team->ops with memset() before restoring
> > safe dummy handlers via team_adjust_ops(). A concurrent team_xmit()
> > running under RCU on another CPU can read team->ops.transmit during
> > this window and call a NULL function pointer, crashing the kernel.
> > 
> > The race requires CAP_NET_ADMIN (in init_user_ns) to trigger via
> > TEAM_CMD_OPTIONS_SET, plus AF_PACKET sendto() on a team device with
> > forced carrier and no ports.
> > 
> >  BUG: kernel NULL pointer dereference, address: 0000000000000000
> >  Oops: 0010 [#1] SMP KASAN NOPTI
> >  RIP: 0010:0x0
> >  Call Trace:
> >   team_xmit (drivers/net/team/team_core.c:1853)
> >   dev_hard_start_xmit (net/core/dev.c:3904)
> >   __dev_queue_xmit (net/core/dev.c:4871)
> >   packet_sendmsg (net/packet/af_packet.c:3109)
> >   __sys_sendto (net/socket.c:2265)
> > 
> > Fix this on the writer side by replacing the memset()/memcpy() with
> > per-field updates that keep transmit and receive always valid via
> > smp_store_release(), paired with smp_load_acquire() on the reader
> > side. A synchronize_net() before exit_op() drains in-flight readers
> > before tearing down mode state.
> 
> Barriers are between things. What are the release / acquire barriers
> synchronizing.

The handler function pointer against the mode_priv state it operates
on.  On setup, init() writes mode_priv, then smp_store_release()
publishes the real handler - the paired smp_load_acquire() in the
reader ensures the handler sees that state.  On teardown,
smp_store_release() publishes the dummy before synchronize_net()
drains readers, so exit_op() won't tear down state under an
in-flight reader.

> 
> > Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> > v2:
> >  - Move fix from data path (reader-side NULL fallback) to
> >    configuration path (writer-side per-field updates), as suggested
> >    by the reviewer.
> >  - Use smp_store_release()/smp_load_acquire() instead of plain
> >    stores/loads for proper ordering on weakly-ordered architectures.
> >  - Add synchronize_net() before exit_op() to drain in-flight readers
> >    and prevent use-after-free of mode private state.
> > 
> >  drivers/net/team/team_core.c | 46 ++++++++++++++++++++++++++----------
> >  1 file changed, 33 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> > index 0c87f9972..dabee3aa7 100644
> > --- a/drivers/net/team/team_core.c
> > +++ b/drivers/net/team/team_core.c
> > @@ -534,21 +534,22 @@ static void team_adjust_ops(struct team *team)
> >  
> >  	if (!team->tx_en_port_count || !team_is_mode_set(team) ||
> >  	    !team->mode->ops->transmit)
> > -		team->ops.transmit = team_dummy_transmit;
> > +		smp_store_release(&team->ops.transmit, team_dummy_transmit);
> >  	else
> > -		team->ops.transmit = team->mode->ops->transmit;
> > +		smp_store_release(&team->ops.transmit, team->mode->ops->transmit);
> >  
> >  	if (!team->rx_en_port_count || !team_is_mode_set(team) ||
> >  	    !team->mode->ops->receive)
> > -		team->ops.receive = team_dummy_receive;
> > +		smp_store_release(&team->ops.receive, team_dummy_receive);
> >  	else
> > -		team->ops.receive = team->mode->ops->receive;
> > +		smp_store_release(&team->ops.receive, team->mode->ops->receive);
> >  }
> >  
> >  /*
> > - * We can benefit from the fact that it's ensured no port is present
> > - * at the time of mode change. Therefore no packets are in fly so there's no
> > - * need to set mode operations in any special way.
> > + * team_change_mode() ensures no ports are present during mode change,
> > + * but lockless readers (AF_PACKET) can still reach team_xmit(). Use
> 
> Why is AF_PACKET relevant here??
> 

Not specific to the bug, just a reproducer detail.  Dropped.

Sending v3 with the updated changelog shortly.

> > + * smp_store_release() to publish safe dummy handlers before teardown,
> > + * and synchronize_net() to drain in-flight readers.
> >   */
> >  static int __team_change_mode(struct team *team,
> >  			      const struct team_mode *new_mode)
> > @@ -557,9 +558,23 @@ static int __team_change_mode(struct team *team,
> >  	if (team_is_mode_set(team)) {
> >  		void (*exit_op)(struct team *team) = team->ops.exit;
> >  
> > -		/* Clear ops area so no callback is called any longer */
> > -		memset(&team->ops, 0, sizeof(struct team_mode_ops));
> > -		team_adjust_ops(team);
> > +		/* Install dummy handlers for locklessly-read hot-path ops
> > +		 * first, then clear cold-path ops that are only used under
> > +		 * RTNL.
> > +		 */
> > +		smp_store_release(&team->ops.transmit, team_dummy_transmit);
> > +		smp_store_release(&team->ops.receive, team_dummy_receive);
> > +		team->ops.init = NULL;
> > +		team->ops.exit = NULL;
> > +		team->ops.port_enter = NULL;
> > +		team->ops.port_leave = NULL;
> > +		team->ops.port_change_dev_addr = NULL;
> > +		team->ops.port_tx_disabled = NULL;
> > +
> > +		/* Ensure in-flight readers using old handlers have finished
> > +		 * before tearing down mode state they may depend on.
> > +		 */
> > +		synchronize_net();
> >  
> >  		if (exit_op)
> >  			exit_op(team);
> > @@ -582,7 +597,12 @@ static int __team_change_mode(struct team *team,
> >  	}
> >  
> >  	team->mode = new_mode;
> > -	memcpy(&team->ops, new_mode->ops, sizeof(struct team_mode_ops));
> > +	team->ops.init = new_mode->ops->init;
> > +	team->ops.exit = new_mode->ops->exit;
> > +	team->ops.port_enter = new_mode->ops->port_enter;
> > +	team->ops.port_leave = new_mode->ops->port_leave;
> > +	team->ops.port_change_dev_addr = new_mode->ops->port_change_dev_addr;
> > +	team->ops.port_tx_disabled = new_mode->ops->port_tx_disabled;
> >  	team_adjust_ops(team);
> >  
> >  	return 0;
> > @@ -743,7 +763,7 @@ static rx_handler_result_t team_handle_frame(struct sk_buff **pskb)
> >  		/* allow exact match delivery for disabled ports */
> >  		res = RX_HANDLER_EXACT;
> >  	} else {
> > -		res = team->ops.receive(team, port, skb);
> > +		res = smp_load_acquire(&team->ops.receive)(team, port, skb);
> >  	}
> >  	if (res == RX_HANDLER_ANOTHER) {
> >  		struct team_pcpu_stats *pcpu_stats;
> > @@ -1845,7 +1865,7 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
> >  
> >  	tx_success = team_queue_override_transmit(team, skb);
> >  	if (!tx_success)
> > -		tx_success = team->ops.transmit(team, skb);
> > +		tx_success = smp_load_acquire(&team->ops.transmit)(team, skb);
> >  	if (tx_success) {
> >  		struct team_pcpu_stats *pcpu_stats;
> >  
> -- 
> pw-bot: cr

