Return-Path: <netdev+bounces-257892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMc7Oe9XiWlQ7AQAu9opvQ
	(envelope-from <netdev+bounces-257892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 04:43:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C53810B728
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 04:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD3EA30053E8
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 03:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588DB2D3733;
	Mon,  9 Feb 2026 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTpUy08U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFF2C08C8
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770608481; cv=none; b=dpcWvmWunQs0+uCoqUydR8c2JjbdLzDtgR+hHcW9T9tSrlrYqu8vXx0e2086Wb52l7OxGm5/Gxw+UoNNEdTn5oqMXIDwMNV7rI5aOmP7DdOldC1B9bMckr9WI8GD+0ShGfFwAIPvGQFW+CCIKZpPRXQl9c9Mt0AQVb1SCOwx0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770608481; c=relaxed/simple;
	bh=3AJceAjOgUXyJt5KSDzfLBLeEOi889Uss6+UnHvlaSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOEgKnTkyuGYUOvnfYZHVQvxZWcsatpNJlM8W1Zb67iVGtpBi6wVoP13F8HC6CifIE4mt+ojMLHbOka0z9IILPIv6rwh1FHDVYwhLXFdZ/T9/K9lZEm1zAD4oA/qYUrK0dg7AMx9Wcut8XFkusF5fhVEq0qPX/1YcIYrOApnqNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTpUy08U; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-502a26e8711so23120881cf.1
        for <netdev@vger.kernel.org>; Sun, 08 Feb 2026 19:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770608480; x=1771213280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TmldnmLhL9SqYkNgbH+pg//X2nCE1O776WGQ3GQgbFQ=;
        b=lTpUy08UM8WbXVy3nm02LX0xxYWLb0uUqcGK1/vQydm69MHXYEXzFhQZZJXWrCTe5a
         g2D6/xi1eM/n0geA2xEEpCHESx4HEYlGSbrK9aex2nCjxxvdOEsbz1in27b16u6fELo+
         4yMp8b0m1jx1MBY9JNUrq9yhK9p6gwLcvIN0OIG+wfZ5P3mgPZtsBGxEnC/jpExvwj5E
         b2DfNO7eqPS9kxFVc2g9OjfYw5g+3Wtbdmvp6+YU941QFbx7ljOhlwyb+H00r2pCLwc6
         5onOHgZJQ2B9wWrrty0k4NFb0ZRbAYK49WrMPRwLqQ085L5rQYfXDxvuc+6zI0zTZl73
         OtDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770608480; x=1771213280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmldnmLhL9SqYkNgbH+pg//X2nCE1O776WGQ3GQgbFQ=;
        b=qf3bkDj0Y4aW5/cLumJx1ujYtC9OnUZzqWqvUDO3gKEZuEBUQ+O2OlCGX814hV44R+
         ByZEYM24LpDq3/kh/ZJctX1Hs29t/TQCBeQf2XGjA5oTdYvLlKmR/jZd903KMFQNKmnp
         w0jJnG9D9JCAtkbq6oOdsgBRGXgIUhHStgUlCYIO1aSMNtiOPuhKUHuuff4s+hJroHBo
         Dxs8M98rWqzBi0MWxj3DBx7tfdlvycjQHWfzgTB5bM4rFFwYVYSm/vT/9sOx9lFUkZgj
         KAdnLeOkJL7FCfrDpUWeetxOlMaELXRZcFRyFGEfgmgCzQWxZX3Tu4Ov1ckUja/m/Kfx
         H27g==
X-Gm-Message-State: AOJu0YypGBM5d1D3rOxd2nIb944BcpfQSbIMOrRJtdlF9NBZN2wGGfjd
	qoRUoaRPaYLYo9v4Jr9MWMkDgmH9baSN9/8WGK1K0/OgzpJP1onsNqHy
X-Gm-Gg: AZuq6aIi3nvXWVWiRREmuF+jxgzfqGLF6ORPUCrch87Qgsl2LVDKFg3A7VpgmF7Zwom
	tGR/oVYv8OP4EE+FAKkD9fpdoct8fpn72uByGR82Hir0xwUIzDBOwTlgsWE+8wnN1gMT4pWjHov
	o4obZVNH0x+aKtYcSm2NWXWUtXH4WvmQ2M4mFqCY6LC5uDsbeb9mFHX30MOUJTAwPxaNPKYpwQq
	uEjrhr1N3gvV/3fxwPhruwTEba+eVOhDO9rev+oZsOpBfB41YyJrEpcALvCP1qO/moO4CFhi8aa
	F+CxKua9GvHRzPyGMuaMAHUhcXfcCGAMRgrjnmAFcV5ocG8CllGkfs+/FnWQunbPlCL4T+LNpBb
	zSkXcU0eoYoSMCNn9+ELqHJcxIo1S/mE/2Yo7TgKRQxyqB/HvqiwYMygnLmGilGSeOTLnW/EF4m
	JnlIkCYZRObyy/oL+fPL7iU3/H3pUzT5fytvRqXQumJwh9iNSKTQ2p
X-Received: by 2002:a05:622a:1386:b0:506:217e:b0e5 with SMTP id d75a77b69052e-50639675655mr130106381cf.0.1770608479777;
        Sun, 08 Feb 2026 19:41:19 -0800 (PST)
Received: from P5510 (h69-131-24-92.cntcnh.broadband.dynamic.tds.net. [69.131.24.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5063913ba7asm66837111cf.3.2026.02.08.19.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 19:41:19 -0800 (PST)
Date: Sun, 8 Feb 2026 22:41:08 -0500
From: Jie Zhang <jzhang918@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, jie.zhang@analog.com, horms@kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: fix oops when split header is enabled
Message-ID: <aYlXVIqHfdOfcAAl@P5510>
References: <20260206195643.11333-1-jie.zhang@analog.com>
 <aYZPUx2WrIkPmvIU@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYZPUx2WrIkPmvIU@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257892-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,analog.com,kernel.org,intel.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,bootlin.com,nxp.com,synopsys.com,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jzhang918@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Queue-Id: 4C53810B728
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 08:30:11PM +0000, Russell King (Oracle) wrote:
> On Fri, Feb 06, 2026 at 02:56:38PM -0500, Jie Zhang wrote:
> > For GMAC4, when split header is enabled, in some rare cases, the
> > hardware does not fill buf2 of the first descriptor with payload.
> > Thus we cannot assume buf2 is always fully filled if it is not
> > the last descriptor. Otherwise, the length of buf2 of the second
> > descriptor will be calculated wrong and cause an oops:
> > 
> > Unable to handle kernel paging request at virtual address ffff00019246bfc0
> > ...
> > x2 : 0000000000000040 x1 : ffff00019246bfc0 x0 : ffff00009246c000
> > Call trace:
> >  dcache_inval_poc+0x28/0x58 (P)
> >  dma_direct_sync_single_for_cpu+0x38/0x6c
> >  __dma_sync_single_for_cpu+0x34/0x6c
> >  stmmac_napi_poll_rx+0x8f0/0xb60
> >  __napi_poll.constprop.0+0x30/0x144
> >  net_rx_action+0x160/0x274
> >  handle_softirqs+0x1b8/0x1fc
> > ...
> > 
> > To fix this, the PL bit-field in RDES3 register is used for all
> > descriptors, whether it is the last descriptor or not.
> > 
> > Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Signed-off-by: Jie Zhang <jie.zhang@analog.com>
> > ---
> > v2:
> > 1. Update for the latest net HEAD
> > 2. Reduce crash dump message in commit message
> > 3. Add Fixes tag
> > v1 link: https://lore.kernel.org/all/20251202025421.4560-1-jie.zhang@analog.com/
> 
> I was trying to work out whether this was a re-post of a patch that had
> already been merged and it was the result of someone inappropriately
> re-posting old patches, or whether it was something to take seriously.
> 
> That is because of this in the patch:
> 
> > +	/* Not GMAC4 and not last descriptor */
> > +	if (!priv->plat->has_gmac4 && (status & rx_not_ls))
> 
> Commit 26ab9830beab ("net: stmmac: replace has_xxxx with core_type"):
> 
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 99022620457a..151c81c560c8 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> ...
> +       enum dwmac_core_type core_type;
> ...
> -       int has_gmac4;
> 
> So, has_gmac4 no longer exists, and hasn't done since October last
> year.
> 
> Thus, it seems your patch has been generated against an old kernel.
> As you are submitting for netdev, it is a good idea to ensure that
> patches apply to the net-next tree and/or net tree depending on
> which one you are targetting, and have been tested against that
> tree.
> 
Thanks. This is a new version of the patch I sent last year. I tested
the original version again the net tree. But I forgot to test the new
version again. I just test it now on the latest net tree with other
patches for our board. But Ethernet stops working. I'm trying to figure
out what causes this new issue. After that I will send out a new version
of this patch.

Jie

