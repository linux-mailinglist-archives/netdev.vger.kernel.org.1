Return-Path: <netdev+bounces-268127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Iw6BF3rt2mzWwEAu9opvQ
	(envelope-from <netdev+bounces-268127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:37:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86226298C7A
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 12:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83E393024101
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D5D29B789;
	Mon, 16 Mar 2026 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0yQ7JD+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF1B34F275
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 11:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660690; cv=none; b=UjZNah+h115N6VOAhkRw8JlobXsbB9R9DFt+qGua+G1L3Bg/b1VD7BN2XhdVYH1honMxP5NloulTOp4kQpcuA+DilYyy+XbHXh1C4Dg4S89KXtQ4X7E0kD5b9rU0QlW455Py/M9mUJ5W4Z0gopSYDC32mK15clZcsbfRBVBBsd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660690; c=relaxed/simple;
	bh=x41eV31hxlJisnvjCZwRk3vzucU2fR+zFSyw+lr74rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFxqLQuIm9i/OLa3M68yQMi3a03sVFv4NzWWjhRy0COlwCUI0ae288tA4syWHYaiIFPVorE0valXTB8dsG9CPSph8V7vr7Rtm2pcjUj0CTcv0pH0gxBUuwr6TubcaPv5svxIOHLOec5JnUCxg8BZX0zNJMlOs242pNGIsTYx/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0yQ7JD+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2aecc6b0861so16934375ad.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 04:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773660689; x=1774265489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nUxyvqJzviVhefD42KOA7qmDsxVaOxQooZbeSkgqO4A=;
        b=e0yQ7JD+wFYf2RhwmiPwGIx2Wpt+KWJLAOJE79ZXRtiS/hm6tnYtu6b+bMwgX7BBzS
         MNaK2kqnZfOZEU6uL+d5sU9e24PHQCCNysMBSDnd9onvtv4/b9I/6OsDBTg3YnGNL8Cw
         cTYEojYH/CGCPdls9yXymnYZ8N2q1ITA0VLMvRDs3TBpdbStBfcBoNJGWsalLawfL9+J
         vISOKjO1qM62GyNvDlcDreWy8Jz9ZOZGuAbrtEUE+Nad3ugZGG9WvxEZyEc676h4ZIA6
         /S0WX1643PCjFYQX7T0SdKfmcj4NhsA8XAdYlLTHMT65kwHz1dYxCwWrsGLXl5iSHlZk
         c6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660689; x=1774265489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUxyvqJzviVhefD42KOA7qmDsxVaOxQooZbeSkgqO4A=;
        b=W+xpwTEQEUI8qr2IOI1PMJTT1451I3viDoauXzqCJiRZNK+5j/JYuh1D1HUgUwrp56
         7/sDoxdAybJXBoRqjXDBrvKr+ubiHObspYExt1KaaQwLyLNCTvnEp0/bSf2v2HTYcXaX
         ADEwVZRIVUPaN6nWjZg1gnE0qbaCXEtR5weUM6gAE8aTwL7ScR0iSZyNrproRi5rFpNS
         y/8IrLjBwbGo5c9hnkKgqQVZYD6MxTlz04vk/+mBBnH/C51Ohp5MxmWdfQLmLqpEQg2w
         9KkPPZ3tlIe9EpNcKlXqVkAEr/k/l0EUmiNGiR0Zmjn8RJ76KQFAUMryckdLRA3Qho88
         NMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcCkryE6o8HLtYySwGa+WxmtmG4rfnG9Agmx2Jrm6c1AVqyaFAKcBJdvwvEOqHQez5PGZz/Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6DPmT3Kdeq9R91955DScoOAXrOAkhzo7hTYu5T3FAg7Vx+4RV
	DKG+0OFZPftEfQYSyzgqRO9tsaIdC+fTSRdFBM8pIX8FrBqDgjuDM+k+
X-Gm-Gg: ATEYQzwVLuV7hd1PIYwuDY+oeBHnNY03bixIuIjFdsZNij4ESmFCD5XR8sQ15jkMzyH
	Cwyw0mLFh0uhhu0tIcHuzcb4jLteS7t3a8ntlhy8OEMV3zMtoPhVd12udWiYmSgyU8HxCbPsscI
	khJpcplOTCLqx4ZspwBYtrdp+AqtPrwXu1jlyUH1EX3kPmP3AlBQSvgNGchuA6QvtbRBWwGQ12j
	8dkUWKBP+v0ILEGjL8oT4hoCtIm6YcJujp98UIfuhcxd6i3mN7D2v+90PObVyq6oeeC4IIbWyr8
	JIfXUDlbyWYMTRg5wqkkdbh6pNyRqrKs5wY5Dtb53lCq40iSZF8S1s/k42/g0n8gmlR9YQUgBYv
	6PZVTl2UczzH99cfSrAvZUOO3L+/s57vM9R5ynbCiXtEkyVVkItQDZY1rX6uC+svVxc+Lcd7Cq7
	PGAmYNJGtjJRfP3VIA1XupyctnzlKLgoJoOETRtXVHUA==
X-Received: by 2002:a17:903:1447:b0:2ae:4800:141a with SMTP id d9443c01a7336-2aecaad02c7mr133260025ad.32.1773660688800;
        Mon, 16 Mar 2026 04:31:28 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b055cb5d60sm35787965ad.30.2026.03.16.04.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 04:31:28 -0700 (PDT)
Date: Mon, 16 Mar 2026 20:31:24 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] netfilter: nf_flow_table_offload: fix heap overflow
 in flow_action_entry_next()
Message-ID: <abfqDMSC0cTGuvp0@v4bel>
References: <aaxe-uH2Qr6qM4E9@v4bel>
 <aax2yZtJce0d19gd@strlen.de>
 <abfhRFfZ1LOgWEsf@strlen.de>
 <abfoTBGLhav-iPQb@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abfoTBGLhav-iPQb@v4bel>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268127-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[netfilter.org,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86226298C7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 08:23:56PM +0900, Hyunwoo Kim wrote:
> On Mon, Mar 16, 2026 at 11:53:56AM +0100, Florian Westphal wrote:
> > Florian Westphal <fw@strlen.de> wrote:
> > > Hyunwoo Kim <imv4bel@gmail.com> wrote:
> > > > flow_action_entry_next() increments num_entries and returns a pointer
> > > > into the flow_action_entry array without any bounds checking.  The array
> > > > is allocated with a fixed size of NF_FLOW_RULE_ACTION_MAX (16) entries,
> > > > but certain combinations of IPv6 + SNAT + DNAT + double VLAN (QinQ)
> > > > require 17 or more entries, causing a slab-out-of-bounds write in the
> > > > kmalloc-4k slab.
> > > > 
> > > > The maximum possible entry count is:
> > > >   tunnel(2) + eth(4) + VLAN(4) + IPv6_NAT(10) + redirect(1) = 21
> > > > 
> > > > Increase NF_FLOW_RULE_ACTION_MAX to 24 (with headroom) to cover the
> > > >  
> > > > -#define NF_FLOW_RULE_ACTION_MAX	16
> > > > +#define NF_FLOW_RULE_ACTION_MAX	24
> > > 
> > > This fix looks rather fragile.
> > > 
> > > What guarantees that this stays right-sized?
> > > 
> > > Can you add a BUILD_BUG_ON or if needed, run-time check?
> > 
> > Ping.  I'm not even sure if there is a bug to begin with, see Pablos
> 
> Sorry for the late reply.
> 
> To clarify, I triggered the overflow using a dummy device that accepts
> TC_SETUP_FT, as I don't have real offload-capable hardware. The 17 entry
> scenario requires double VLAN (QinQ) + IPv6 + SNAT + DNAT simultaneously,
> which is unlikely in real-world deployments, so it is hypothetical.
> 
> > response.  How did you conclude there is a missing bounds check and that
> > this increase is the best fix?
> > 
> > Normally there should be a check that prevents such a configuration.
> > If thats missing, please add one instead of increasing this define.
> 
> So, should I send a v2 with a bounds check, or drop this patch?

+ Since this is not a real-world environment, it seems better not to apply 
the patch.

