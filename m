Return-Path: <netdev+bounces-259465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NT6B1YRl2n7uAIAu9opvQ
	(envelope-from <netdev+bounces-259465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:34:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D77115F1CD
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CA1130182BC
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69F22DF128;
	Thu, 19 Feb 2026 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z67FvafZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B516028DC4
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771508051; cv=none; b=HtgoV8syJtMsM85+vmJM56f63xeF/ypD81v3OIx0XQ5jRJEEhnfubTHBeCo7ICsQav9HQle8n2d5JwpKqMPaVl9MJoyPyc0mk+CLaXmSmQG5HOm0gE4yUO6Ams02AfrsrbWub5xe79T4rribSOcPiC0rptEKwXc/BMaMB7gWb88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771508051; c=relaxed/simple;
	bh=iU+HG8MDp5hNT0u+nkezTKQmmfgBM1v8Mi0zAUn97TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1g1tCdgRQxOoHLGNm16Ok4OryEYjO0bgY+2wevSldQGbaUazHUyylTM1hjzCa6HHqGTxeKyKzMHdiJHMR8B3qTVGUm9xLlCYvNs1HSN9yjbWR+gydHXl9+mBi5oeShkliBsYWEbHjJUwptfdAbvnW1nHPqstTRmv7Lv81kFwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z67FvafZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a95bfdb31eso3871625ad.3
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 05:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771508050; x=1772112850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e/Ue5YGipho/PBYWA4OGpeAIS/EIU3yR+b8rJcGhgT8=;
        b=Z67FvafZeKBQzhRZ2v6sihiT8rRyQ8C/EJbAzDUR8G+5+wTR7XaE9JJhEWlJmQ3SY3
         TY+SxS/gfPHAbhgjBUc6ARoqs/96JzJnaemmdtPGxIQk80dLrnlJQpCB0Q6C4sKQWlxt
         ddWqPO2cUxcIVrm+hGw/SaN6hypRrNNPKgeR6tyxKlUcVuSi1NkkBDvkicCMZXypvxLi
         p/7izO92pRfutU0dR2VZ/JXRMiPQj/ww0XKEffQDOFvXEpA/kYjntNFqoDZh3a5k1GPt
         S/jF37hibWSJ0n6h6pBWSLXeh/wo2qXZLZ6Mrwete/EqJsZ+oePQxlZYOellqynmQa6t
         SjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771508050; x=1772112850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/Ue5YGipho/PBYWA4OGpeAIS/EIU3yR+b8rJcGhgT8=;
        b=xMjdMympU4SqznW45OZ5sNQnlE8PyPu1LI3n4szEVm5wVedSm7gYtFdJy41J3ZIied
         Fs0qWxz3m/xv9Da11BzdlzTAfdFMsAG34HCxi7Myn99dkL+8QciBSH1WWLRXHXJ50Gl0
         s0Otj3I/gPg2L6fC77WMPkLeLN18sZluGhlSMIcEbyTxdlvevQy6ChWwChTqPNu9nAlY
         I62CiRM24Lckjrwg9g+Q294dbDr3qqeu0TgcMdlkY3P8PXs8ToCqEBNxT+blPSRgdVPN
         gbEhUMDO58xt54LSeZOrT4RaB3Hc0xOqIkm/hTX242gHT9FVyUkZf87nBDY8/Zp9DCX1
         lX1A==
X-Gm-Message-State: AOJu0YxgWYqHmBZFyOMlFrvlKWKwcBTN/04OwAggzJ9CjklDJNW0mXm+
	8XqXhWxX1rx0wqoSUrJuLGFAgv4VyIudAVDKTHFIhjQ8LpcgnFNMdkLl
X-Gm-Gg: AZuq6aIHSmuSYhlOw4sENCdQ7ymF1JtR2eTn5/Vawhp2s+jTrIB8c8OhH4ezRRzaSNO
	K/kGx+ViPDzdl1YZjdKmjl2URp2vWktHmFUx8Yp1DQx5vs42jbXTswHKMf5gVTHC4zD073bDiea
	OdLhe8Ge04kd8jkIzehKnAqfPjOjcXMBnLIfsgHEYw8bLiaf8ZozEY5KsRHkhtcqiz4oheLBZ1B
	Wzkvb0p3liqEa5r6BIzbPY+ieWfRvYf4XGyyS21r1KEUPrhT/KziI7eWH3UvwMJy+QXft1NBEog
	B/hBid2ne2stPaly290y64LDgDyFqhpuMox5cAGLBiLQTY10fnVOcoeYsHl/nr+ASBhlsRrmYcY
	P54rUJ1eKJaA2tX7f0XdSEmon2DubW+ZbJUmL0MJs2bQFhtRw5hxEScE+T1wKlqwdI1Q0olmht9
	rUW+dcfIUoLXSjcW89XzK3K1oSwFjHoXg3gn5Q2A==
X-Received: by 2002:a17:903:3c6d:b0:29e:76b8:41e5 with SMTP id d9443c01a7336-2ad5b0e1ea9mr25928415ad.30.1771508050029;
        Thu, 19 Feb 2026 05:34:10 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5c4csm165019335ad.53.2026.02.19.05.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 05:34:09 -0800 (PST)
Date: Thu, 19 Feb 2026 13:34:03 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Liang Li <liali@redhat.com>,
	Nikolay Aleksandrov <nikolay@nvidia.com>
Subject: Re: [PATCHv2 net] bonding: alb: fix UAF in rlb_arp_recv during bond
 up/down
Message-ID: <aZcRS0cUsAOgktMf@fedora>
References: <20260214091541.89659-1-liuhangbin@gmail.com>
 <20260217164355.7139ab53@kernel.org>
 <aZVByEOAYdR3WF4q@fedora>
 <20260218161110.14f1551a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218161110.14f1551a@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259465-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D77115F1CD
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 04:11:10PM -0800, Jakub Kicinski wrote:
> On Wed, 18 Feb 2026 04:36:24 +0000 Hangbin Liu wrote:
> > On Tue, Feb 17, 2026 at 04:43:55PM -0800, Jakub Kicinski wrote:
> > > On Sat, 14 Feb 2026 09:15:41 +0000 Hangbin Liu wrote:  
> > > > Fixes: e53665c6eaa6 ("bonding: delete migrated IP addresses from the rlb hash table")  
> > > 
> > > Ah, also AI says the issue existed already in 
> > > 3aba891dde38 ("bonding: move processing of recv handlers into
> > > handle_frame()")
> > > not the exact trapping instruction but the hash table was used from
> > > recv_probe so at least a UAF would happen.  
> > 
> > Not sure if I understand correctly. Do you mean we still able to access
> > rlb_arp_recv() after setting recv_probe to NULL?
> 
> Simply put -- wasn't there a case where rx_hashtbl was accessed after
> being freed in 3aba891dde38 already? That commit is a year and a half
> older than the commit you had under Fixes.

AFAIK, the UAF/null-ptr-deref issue for rx_hashtble is introduced by
53665c6eaa6 ("bonding: delete migrated IP addresses from the rlb hash table"),
which added rlb_purge_src_ip() in rlb_arp_recv().

In 3aba891dde38 ("bonding: move processing of recv handlers into handle_frame()")
it only let other CPU still able to access rlb_arp_recv() after we set recv_probe
to NULL. But it doesn't trigger a null-ptr-deref.

Thanks
Hangbin

