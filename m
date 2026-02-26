Return-Path: <netdev+bounces-261334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEz9N5lBoGmrhAQAu9opvQ
	(envelope-from <netdev+bounces-261334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:50:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A401A5E6F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 314D4303A8DE
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7433D2D780A;
	Thu, 26 Feb 2026 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkCO2Hm+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC3B2882D6;
	Thu, 26 Feb 2026 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110162; cv=none; b=Te36h7RrcGw2rdYb4CBBqdWuY6H910dAQNpETw7MWNnZ1XUneEDxL4GzsT0HW8aIPhBek3fzNUQ18MKHuuu0uEpZcRb9/P7fKxXZ9x9WBMqQfDfdIuTC50mHmfMHKkxxiQGZyOkajrMW7QjK7UQVYqExbDFUu8dubLA9Hqs9MVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110162; c=relaxed/simple;
	bh=n07zoaeh8FevGSI+ENoOopQ3ImbAWW4lxc85PvLmzFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8OO2kvMBLGoqTG23nhwzxrX64UpxlKLiVSQzrVN6flmWmNK8OATu6Utz9JqCQom3hQVpwioxYtaI3mze7VdOQ4z8biKSROXX0foN181D84E6WgQHmBGbm9+tShslOZZRrZyWC/fg6QGL4oyKjvJJw+5mXyIL5Cmza5OOqtshMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkCO2Hm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09828C116C6;
	Thu, 26 Feb 2026 12:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772110162;
	bh=n07zoaeh8FevGSI+ENoOopQ3ImbAWW4lxc85PvLmzFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LkCO2Hm+0w/Uh0PGM3botz+7IsCIZsHH3TGIPV+0cldkMuEiIsl+vMP48Q4XWLYdE
	 YSBHo0KcjZjQtxFiBQNV+uveAGbahKhLlf+bB5BF54/c9JhoedcBfy6ywEGbF0U8dm
	 93CXk/j/BQK8PC0pr6/hby/P4B5BmkXkaDygDYFHwsbEjsaYV1t9DCmst/q+oWIPcr
	 4h2i1Y8lfmaaoJgJtgRgehDDELE5w1E2q+u/fHj63P6zWBy/TKmXFU7RPowpgd0y5w
	 2sBUp03XWQc3gm2JAFWF7PtbXTSW7aryfVsQoHa/6O131gb2HYrq7fWrD8tZMfER8L
	 lCAao3r3MSAOw==
Date: Thu, 26 Feb 2026 12:49:17 +0000
From: Simon Horman <horms@kernel.org>
To: Cedric Jehasse <cedric.jehasse@luminex.be>
Cc: "edumazet@google.com" <edumazet@google.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"olteanv@gmail.com" <olteanv@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [net-next,v3] net: dsa: mv88e6xxx: Add partial support for TCAM
 entries
Message-ID: <aaBBTbABte38y2RA@horms.kernel.org>
References: <20260224-net-next-mv88e6xxx-tcam-v3-1-dc18887d71f2@luminex.be>
 <20260225102528.177319-2-horms@kernel.org>
 <PR3P194MB1505D8407EC0DB476D6A1CD1EA75A@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PR3P194MB1505D8407EC0DB476D6A1CD1EA75A@PR3P194MB1505.EURP194.PROD.OUTLOOK.COM>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261334-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,vger.kernel.org,gmail.com,redhat.com,armlinux.org.uk,kernel.org,davemloft.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45A401A5E6F
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 01:06:26PM +0000, Cedric Jehasse wrote:
> Hi,
> 
> >> diff --git a/drivers/net/dsa/mv88e6xxx/tcam.c b/drivers/net/dsa/mv88e6xxx/tcam.c
> >> new file mode 100644
> >> index 000000000000..ed02c8798200
> >> --- /dev/null
> >> +++ b/drivers/net/dsa/mv88e6xxx/tcam.c
> >
> >[ ... ]
> >
> >> +/* insert tcam entry in ordered list and move existing entries if necessary */
> >> +static int mv88e6xxx_tcam_insert_entry(struct mv88e6xxx_chip *chip,
> >> +                                    struct mv88e6xxx_tcam_entry *entry)
> >> +{
> >> +     struct mv88e6xxx_tcam_entry *elem;
> >> +     struct list_head *hpos;
> >> +     int err;
> >> +
> >> +     list_for_each_prev(hpos, &chip->tcam.entries) {
> >> +             u8 move_idx;
> >> +
> >> +             elem = list_entry(hpos, struct mv88e6xxx_tcam_entry, list);
> >> +             if (entry->prio >= elem->prio)
> >> +                     break;
> >> +
> >> +             move_idx = elem->hw_idx + 1;
> >> +
> >> +             err = mv88e6xxx_tcam_flush_entry(chip, move_idx);
> >> +             if (err)
> >> +                     return err;
> >> +
> >> +             err = chip->info->ops->tcam_ops->entry_add(chip, elem,
> >> +                                                        move_idx);
> >> +             if (err)
> >> +                     return err;
> >> +
> >> +             elem->hw_idx = move_idx;
> >> +     }
> >
> >If entry_add() fails after some entries have already been moved to new
> >hardware positions (with their hw_idx updated), doesn't the function
> >return without rolling back those partial moves? The software list would
> >then have some entries pointing to their new positions while the gap for
> >the new entry is only partially created, leaving the TCAM in an
> >inconsistent state for subsequent operations.
> 
> I don't think this is an issue. For entries that are successfully moved the
> hw_idx points to the new index. And for entries that haven't successfully
> moved it's still pointing to the old index. Hence the hw_idx field for every
> list entry should still point to the correct TCAM index. There will be a gap
> in the TCAM entries in the hardware, but that's not an issue.
> If moving an existing entry returns an error. The rollback moving of entries
> is as likely to return an error, and potentially leave the TCAM in an
> inconsistent state.

Thanks, for the clarification.
That makes sense to me.

