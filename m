Return-Path: <netdev+bounces-264597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJFoM7YbqmnALQEAu9opvQ
	(envelope-from <netdev+bounces-264597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:11:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3503D219B64
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 01:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25043300A38C
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 00:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CC4238C3B;
	Fri,  6 Mar 2026 00:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO9iA5gq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB922A7F0
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 00:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755870; cv=none; b=N6OuimKNQHDnPXY5UkPVZ9joVqzK8HeoEU2Q2hPRkTnhD7FSLsGBKMHeHft8MHPLNKmzDDRijYEpr/394vP3vJxrjlGki25GKIBzwv/J5I0cCaWbq6g8NtDy5qg1x+IjtxYrfNvnk2oTsVqcs7s86PFVUiNKa+oj68jPCJY3WJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755870; c=relaxed/simple;
	bh=+Itjemvwqd2IB+YSuAlR65c/VwN4MbTci4h558Q0Dfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lW6lilP76i4MNQoqC5pXiagcIlWfDgk+AnzILKGz8MRxwOQp0NEhV+JiMQUpg7fk+2+nv46HVpBhTPNa0LzDPSQHDb913N/iOA7CAyGcYj5mB6X+iFI5Moq4b28iUWtf2nOQY66s9IsXMXTg2tfcrCeiAHZw4KYoKSw0+FusPM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DO9iA5gq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae505619baso30179925ad.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 16:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772755869; x=1773360669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8L3iu+vCjUlAr7CshFxSYhYRBNBbOmOF2/IXNTTj8c=;
        b=DO9iA5gqfQW6XO0BnG8t5aIOAjCIrwbgPwOTAUyzmiSx/CwFE6jUMUzabawCYAE7oR
         4QdVZsHflSveDbXtYrzzdRZkADNZzdIBHnnT5nW9QdKT1K7dxEtJ5NT1xxq+IzDntu+1
         Kj27IsIW8FyXXMkAHm3joO18NRk05+ZpGMegFBorr8FPWmJXDJUQxbmBbo7ZavT8FEOs
         G+d/gNMB1Ns/8AnyUZWSGsDlbPQoBbgzzfd7/5MGdLhCyk/Y6sM9pEFXjzi5uAXCH7iB
         iHGniRXviD78kGirLL236CSiCPvOvJMYT1aU4jTyc92ZHZ/tHzaS9wSxzqS+M+DAQyqh
         6t1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772755869; x=1773360669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8L3iu+vCjUlAr7CshFxSYhYRBNBbOmOF2/IXNTTj8c=;
        b=eo+7NSvEXvF5QqLzqjlsjNox+rEWewXyi7E+4L4wRpGMG7pE9SaqOZeR70wub07RJA
         Te/h6OdcxxcfNSFs+byZq/F0svHTVYmI27rY6G5gMrMaCH1btIiWK7JwK3MGvmVV6Luc
         aGK2VEsbyzt4N6UYTpPmFcg9EM+XtGOc1r/7Kzvpfgrt5LiiIgpUDmQ8CrDP5k47wBlB
         PvtT0kQUuGk6ryLtDPo/3KcPnzdEvKyEHsHhdmWbkaAozETdOs4uwIK7gT/i89ukrM3T
         87n+lhTBx19e/zpB0dk0wChe6llwDaJAkhfTzeJvXRgSrptoQSEwsfqpMxfQF15iBiCg
         Dg3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4djTkCOe1cUz4UPOd8XEy0JnoX/1P3kUIoHgzggPza+xVPT+8YHGzvLEAA5cDnEMADPiejHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh94D0F8iW81z+hTisgNiAEJYqh1nZJkXXRTfjgkZic3rluIMd
	M84srJRQwnCZuIp84l34ZiCQM7xmMx11guvQEizR00+jwQIGGzTnI2qy
X-Gm-Gg: ATEYQzyZZa7yt+JiW7cTG996xtZBYzhAFh0L53O4V+E51vFEyDYvONkrMaLIpj9Y9hP
	rTnRS2y7jrRJ/Y80Zl7peL6JHOQtUKZGOi7lwVmzWfTc9ZNXSX+jRMJ4aOmD+epdLAkYMHSolpR
	IEvYwvAjWoJSBRCM60kli3CAluQ9Orhj30MELxs4ErEwhI7hASxl8PITUt5qFpzDr2ZfZUHsowF
	Ss9PH0nGRVVWxEv7pzpvcb8bCrECsHm7tNJvmBWqPpWaNz/XcZL51eFOiEFH8btundoKX8Bk23n
	lNz6XEuUOT8h2whhFRjRRBZwCUx5e1XzgWcKC/0wZcNg7zcx1z9jtqPYHpuvVqFLSENQGRpVRMV
	s4QDNr/zUPwaFKsjUwWtLVnUh9FdivTxKpj3t1EeDWYBuXMtqSvqO1RgZozziST7oZvIniE2B7V
	JDchXXs6la6vkZiSReHu/Mycqcnz4y/YwYwHuo1IxZLg==
X-Received: by 2002:a17:902:f54e:b0:29e:9387:f2b0 with SMTP id d9443c01a7336-2ae824fcc81mr3274145ad.39.1772755868545;
        Thu, 05 Mar 2026 16:11:08 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae5276097asm163202645ad.34.2026.03.05.16.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 16:11:08 -0800 (PST)
Date: Fri, 6 Mar 2026 09:11:04 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, Julia.Lawall@inria.fr,
	linux@treblig.org, nate.karstens@garmin.com, netdev@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net v2] strparser: Fix race condition in strp_done()
Message-ID: <aaobmK6d_xd9ZXGj@v4bel>
References: <aZgpkyTDU3aXe_V0@v4bel>
 <aZyMejqTbkI7o_VM@krikkit>
 <aaDATohaW62X_pxk@v4bel>
 <aaYY6UiXSppOig9Q@krikkit>
 <aaY-TbPsNxo6toSr@v4bel>
 <aaoTVMhnY5FKMrem@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaoTVMhnY5FKMrem@krikkit>
X-Rspamd-Queue-Id: 3503D219B64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264597-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,inria.fr,treblig.org,garmin.com,vger.kernel.org,gmail.com];
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
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 12:35:48AM +0100, Sabrina Dubroca wrote:
> Sorry for the delay, I wanted to think about the race condition a bit
> more.
> 
> 2026-03-03, 10:50:05 +0900, Hyunwoo Kim wrote:
> > On Tue, Mar 03, 2026 at 12:10:33AM +0100, Sabrina Dubroca wrote:
> > > 2026-02-27, 06:51:10 +0900, Hyunwoo Kim wrote:
> > > > On Mon, Feb 23, 2026 at 06:20:58PM +0100, Sabrina Dubroca wrote:
> > > > > 2026-02-20, 18:29:55 +0900, Hyunwoo Kim wrote:
> > > > > "strp stopped" is not really enough, I think we'd also need to reset
> > > > > the CBs, and then grab bh_lock_sock to make sure a previously-running
> > > > > ->sk_data_ready has completed. This is what kcm does, at least.
> > > > 
> > > > It seems that this is not something that should be handled inside strp itself, 
> > > > but rather something that each caller of strp_stop() is expected to take care 
> > > > of individually. Would that be the right direction?
> > > 
> > > Agree.
> > > 
> > > > It also appears that ovpn and kcm handle this by implementing their own callback 
> > > > restoration logic.
> > > 
> > > Right. I tried to look at skmsg/psock (the other user of strp), but
> > > didn't get far enough to verify if it's handling this correctly.
> > > 
> > > > > Without that, if strp_recv runs in parallel (not from strp->work) with
> > > > > strp_done, cleaning up skb_head in strp_done seems problematic.
> > > > 
> > > > From the espintcp perspective, how about applying a patch along the following lines?
> > > 
> > > This is what I was thinking about, yes.
> > 
> > In my opinion, it might be cleaner to split the espintcp callback restoration work into 
> > a separate patch, rather than merging it into the strparser v3 patch. What do you think?
> 
> Sure. But once espintcp is fixed in that way, can the original race
> condition with strparser still occur? release_sock() will wait for any

If the espintcp callback restoration patch is applied, the strparser
race should no longer occur in espintcp.

> espintcp_data_ready()/strp_data_ready() that's already running, and a
> sk_data_ready that starts after we've changed the callbacks will not
> end up in strp_data_ready() at all so it won't restart the works that
> are being stopped by strp_done()?
> 
> It's quite reasonable to use disable*_work_sync in strp_done, but I'm
> not sure there's a bug other than espintcp not terminating itself
> correctly on the socket.

That said, the _cancel APIs in strparser still appear to carry some
structural risk, so it might still make sense to switch to the _disable
APIs for the benefit of other strp users or potential future callers.

With that in mind, perhaps the direct fix for this race could be handled
in the espintcp callback restoration patch. For the strparser patch, I
could instead adjust the commit message to reflect that it removes a
potential hazard by replacing the _cancel APIs with the _disable
variants, and resubmit it in that form.

What do you think about proceeding in that direction?


Best regards,
Hyunwoo Kim

