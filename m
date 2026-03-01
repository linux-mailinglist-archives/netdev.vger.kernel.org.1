Return-Path: <netdev+bounces-262430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNkZFyN+pGl5iQUAu9opvQ
	(envelope-from <netdev+bounces-262430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 18:57:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B59621D1019
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 18:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA8453008D17
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 17:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE88337B87;
	Sun,  1 Mar 2026 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxk1FoL4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A74B33506D;
	Sun,  1 Mar 2026 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387820; cv=none; b=T4dFNYlyyiDNF1EemEqU4yhvYOf68JuXetpgF2c0IrKCqJRnn4P93upwEQK4kw2oLnmuRDUnyC1gLmpZ0dnloWX6j+KhRl4tXGlGW6H0vKnOyhEk9jCY0V5TMGx6Z2fD0C7dx0MTG7LY92jVY1ohBSXLWHbgUSLrDiQ4HJ/YMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387820; c=relaxed/simple;
	bh=cqANQIFxzkqSaJ6siL7W4biLzm/UdiW8OZDehsSUzBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KodgvNiuPACMs6noIsnsEMsgq5gX27oGSXH+j2Pk91TPbYLjrlgx0GKfaDP1PS1FB9+y4wCib9RteiQKuvaIvgu2RVcummgUUlW2aROEdqrvKmcU9aj7EbuZy8OSW0wSF2Q6R3FPCGRsYLJG6/L+z9sSl+NjRW8/CFVcPumj+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxk1FoL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895D4C116C6;
	Sun,  1 Mar 2026 17:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772387819;
	bh=cqANQIFxzkqSaJ6siL7W4biLzm/UdiW8OZDehsSUzBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mxk1FoL4TXCGfECR6lVyFMsAdc0RvnZ/+50hSH0YyKBiFP/gnRUVHxSIQHGUU4zjA
	 3LR3D9eWuAO1g7pEFS2ALKpCOnBE+P3MLpXX3Qa1lSp2iagbNDBb7tvOZVGfzSF75P
	 h7p/17X7N9uOmZfUZAwOLJEx5R/p5MOelx7cc0aNOve0hys9jX/4enIywy3bY88FWb
	 r2pNFUm8b0AfdwPzWAYp3aoJevAC6WFtHuP1cOTlbA6reQ3BVLSOwxQoC+87iUlBiv
	 jUzgq0TsCib0MrklhLwCZJ1eLWpznbGtBttLwCoBxeLvqq4Rhz5wNf7ano+dqT97e4
	 zWrjzK2FZjdbw==
Date: Sun, 1 Mar 2026 17:56:55 +0000
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
	richardcochran@gmail.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v1] ptp: ocp: Add support for Xilinx-based Adva TimeCard
 variant
Message-ID: <aaR955MXsV8B1BQw@horms.kernel.org>
References: <20260225102938.4131-1-maimon.sagi@gmail.com>
 <aaA6f5xS5yONVlmE@horms.kernel.org>
 <02670ff0-36c7-4735-aa90-4cd908cfc46c@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02670ff0-36c7-4735-aa90-4cd908cfc46c@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262430-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B59621D1019
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 01:42:31PM +0000, Vadim Fedorenko wrote:
> On 26/02/2026 12:20, Simon Horman wrote:
> > On Wed, Feb 25, 2026 at 12:29:38PM +0200, Sagi Maimon wrote:
> > > Add support for the Adva TimeCard model built on a Xilinx-based design.
> > > This patch enables detection and integration of the new hardware within
> > > the existing OCP timecard framework.
> > > 
> > > The Xilinx variant relies on the shared driver infrastructure, requiring
> > > only small, targeted additions to accommodate its specific
> > > characteristics.
> > > 
> > > Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
> > > ---
> > >   drivers/ptp/ptp_ocp.c | 318 ++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 318 insertions(+)
> > > 
> > > diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> > 
> > ...
> > 
> > > @@ -2926,6 +3168,45 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
> > >   	return ptp_ocp_init_clock(bp, r->extra);
> > >   }
> > > +/* ADVA specific board X initializers; last "resource" registered. */
> > > +static int
> > > +ptp_ocp_adva_board_x1_init(struct ptp_ocp *bp, struct ocp_resource *r)
> > > +{
> > > +	int err;
> > > +	u32 version;
> > > +
> > > +	bp->flash_start = 0x1000000;
> > > +	bp->eeprom_map = fb_eeprom_map;
> > > +	bp->sma_op = &ocp_adva_x1_sma_op;
> > > +	bp->signals_nr = 4;
> > > +	bp->freq_in_nr = 4;
> > > +
> > > +	version = ioread32(&bp->image->version);
> > > +	/* if lower 16 bits are empty, this is the fw loader. */
> > > +	if ((version & 0xffff) == 0) {
> > > +		version = version >> 16;
> > > +		bp->fw_loader = true;
> > > +	}
> > > +	bp->fw_tag = 3;
> > > +	bp->fw_version = version & 0xffff;
> > > +	bp->fw_cap = OCP_CAP_BASIC | OCP_CAP_SIGNAL | OCP_CAP_FREQ;
> > > +
> > > +	ptp_ocp_tod_init(bp);
> > > +	ptp_ocp_nmea_out_init(bp);
> > > +	ptp_ocp_signal_init(bp);
> > > +
> > > +	err = ptp_ocp_attr_group_add(bp, adva_timecard_x1_groups);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	err = ptp_ocp_set_pins(bp);
> > > +	if (err)
> > > +		return err;
> > > +	ptp_ocp_sma_init(bp);
> > > +
> > > +	return ptp_ocp_init_clock(bp, r->extra);
> > > +}
> > 
> > Hi Sagi,
> > 
> > I see similar patterns elsewhere in this driver. So I assume that I'm
> > overlooking something obvious. But it strikes me that
> > ptp_ocp_attr_group_add() and ptp_ocp_set_pins() allocate memory. Shouldn't
> > that be cleaned up if an error subsequently occurs in this function?
> > 
> > And also, shouldn't ptp_ocp_attr_group_add() relase the memory it
> > allocates if an error occurs in that function?
> 
> Well, ptp_ocp_attr_group_add() error is not critical for device init, so
> I believe it's ok to keep it and free in ptp_ocp_detach(), there is no
> leak. But I agree it goes against common code style of kernel. I'll do
> cleanup patch once I have some cycles.
> 
> Situation with ptp_ocp_set_pins() is a bit different, but still we end
> up with calling ptp_ocp_detach() in error path, which cleans up all
> allocated memory. Changing *init() code to unroll everything is actually
> a code duplication of ptp_ocp_detach() - I don't think we have to spend
> time it.

Thanks. I now see that ptp_ocp_detach() is called which handles cleaning
up these resources on error. So I agree there is no leak.

> > Lastly, the AI generated code review suggests that there may be
> > some scope for sharing code:
> > 
> >    This isn't a bug, but ptp_ocp_adva_board_x1_init() is nearly identical to
> >    ptp_ocp_adva_board_init(), differing only in flash_start (0x1000000 vs
> >    0xA00000), sma_op assignment, signals_nr (4 vs 2), freq_in_nr (4 vs 2),
> >    and the attr group passed to ptp_ocp_attr_group_add(). The version-reading
> >    logic and the entire initialization call sequence are duplicated.
> 
> That's what I also asked in my response.

Yes, sorry for missing that.

> >    Looking at the existing driver convention, each board variant (fb, art,
> >    adva) uses this same pattern with separate init functions. Would it be
> >    worth parameterizing these differences in a future cleanup?
> > 
> > ...

