Return-Path: <netdev+bounces-261852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBlEFwunoWmivQQAu9opvQ
	(envelope-from <netdev+bounces-261852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:15:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DEE1B8976
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 15:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C13EC3116769
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 14:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BB941B34C;
	Fri, 27 Feb 2026 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TrKmP4+H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F1E41324F;
	Fri, 27 Feb 2026 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201210; cv=none; b=WdDhw4MT11FWguYqcwHGmA/Rlbv7Nns748gEKXa69Bvjm/SeYSTUDRAVdZ/Ws1WnMF1RuIs9erDxCQQPdloi+U3m0Fy6sCf+hgq5kK8UvK8C+Qk+HLXSasP0CFBYH9VpokEh9mp1G6CjG7hs7uMBvswc9CZngX+SNXJyoImZ4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201210; c=relaxed/simple;
	bh=Vn3aRo531dJx0BiAlHeRomvGbaw1cOR5sF+snDwWCVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdT7n+rfuKoAI1taN+ByNa+3VdMjlNfGtTN/qBmgqkCfbP6c77zjla1kD4XHWj+zrguPq4R2CByNQp9lgQLsk0ZJiWNRheY1uaCGdrM7blrT7WtXuVv9Tl+0fNuAsZU90uAk1axkT4H4iWzKw4CHLZ9IV1tXPaB+dEc7CYJNgIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TrKmP4+H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aUW8WsNlN6RUKYnZdsksSUh/+vmL7az/u2gCuS73QjQ=; b=TrKmP4+HMXYYSa9HOsgnA1Eo+R
	Dj4fYaL3OJJOyCSMVJd0tb5fzbE95eHdv1RVNVqdEVB8uJ9B0lOPY+RxqeHff+hzzq248sasITqPD
	aJdpcpnR1Aox6IaPTnvwdavfBc7xZgLdfcF8cwGFf92hbMoB0GvS72yIUooyvx5AA3nE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vvyUF-0094fO-IH; Fri, 27 Feb 2026 15:06:35 +0100
Date: Fri, 27 Feb 2026 15:06:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: cedric.jehasse@luminex.be, netdev@vger.kernel.org, olteanv@gmail.com,
	edumazet@google.com, davem@davemloft.net, pabeni@redhat.com,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [net-next,v4] net: dsa: mv88e6xxx: Add partial support for TCAM
 entries
Message-ID: <f6885957-998c-4793-93a0-d3cf957ba702@lunn.ch>
References: <20260225-net-next-mv88e6xxx-tcam-v4-1-117f600e41d7@luminex.be>
 <20260227035537.2630823-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227035537.2630823-1-kuba@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[luminex.be,vger.kernel.org,gmail.com,google.com,davemloft.net,redhat.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-261852-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 94DEE1B8976
X-Rspamd-Action: no action

> > +/* insert tcam entry in ordered list and move existing entries if necessary */
> > +static int mv88e6xxx_tcam_insert_entry(struct mv88e6xxx_chip *chip,
> > +				       struct mv88e6xxx_tcam_entry *entry)
> > +{
> > +	struct mv88e6xxx_tcam_entry *elem;
> > +	struct list_head *hpos;
> > +	int err;
> > +
> > +	list_for_each_prev(hpos, &chip->tcam.entries) {
> > +		u8 move_idx;
> > +
> > +		elem = list_entry(hpos, struct mv88e6xxx_tcam_entry, list);
> > +		if (entry->prio >= elem->prio)
> > +			break;
> > +
> > +		move_idx = elem->hw_idx + 1;
> > +
> > +		err = mv88e6xxx_tcam_flush_entry(chip, move_idx);
> > +		if (err)
> > +			return err;
> > +
> > +		err = chip->info->ops->tcam_ops->entry_add(chip, elem,
> > +							   move_idx);
> > +		if (err)
> > +			return err;
> > +
> > +		elem->hw_idx = move_idx;
> > +	}
> 
> If entry_add() fails after some entries have already been moved to new
> hardware positions with their hw_idx updated, doesn't the function return
> without rolling back those partial moves?
> 
> The software list would then have some entries pointing to their new
> positions while the gap for the new entry is only partially created.
> This could leave the TCAM in an inconsistent state for subsequent
> operations.
> 
> Is there error handling to ensure the TCAM state remains consistent when
> insertion partially succeeds?

Can we get replies to previous versions of the patch series included
into the context that the AI is using to perform reviews? This has
been explained once as being safe.

     Andrew

