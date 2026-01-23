Return-Path: <netdev+bounces-252980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDcQOwTzc2ny0AAAu9opvQ
	(envelope-from <netdev+bounces-252980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 23:15:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0AE7B0F6
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 23:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC3D1300E73C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 22:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9886B1917CD;
	Fri, 23 Jan 2026 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlvkWR3L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764D63EBF38
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 22:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769206529; cv=none; b=MWidpXD0xpfScpPL40waKSfmSS/jlqeMKuoXvmZyzTxDQMrqulftD0XhaPaaNYRgZQvfuB51vP48LGzmHOQiCQY0PHjdKOkAh45QoedomMl/NSMfV9SmTtmBakyeErEsdC4eC7MMbQOdufu0hiv6mdZgmaR7MkXFMRg14bFPVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769206529; c=relaxed/simple;
	bh=kFVGmDKm+2JvZ679wMiMAGb7krDM3vgYxkj0Qiroxkc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLkag6gdLCC8UQHgd8GHm/aftx0x7vSICBdqccObEwhrqpcxzuO3T/S6KJu0IFYYwGekcBj01p3YKtOH72EjCI2CCcYNli+5gLSaYxcstby0s8i3bVPfubaiFrPKhgr+HJIGWHdo2jZFjEg9/X5pxzXfcZ8Y5iFlALzmk56Icfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlvkWR3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5617DC4CEF1;
	Fri, 23 Jan 2026 22:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769206529;
	bh=kFVGmDKm+2JvZ679wMiMAGb7krDM3vgYxkj0Qiroxkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HlvkWR3Ll9rG3sZvg8FL9EwkPwjGJr1pMsQKn08660BWtGj7pVemklbBsq0z5Wrpy
	 y6Psa2q+sp9cpTuruQxr36O7IFU/QN1keeojyIQq4GdY43fttTQQ1YWSsuCpX9RtZ6
	 qZKZqCD+Ib3gGhbcaT8PXq/yDO3T9K50z4p6iEAes9KVE2ZdGiGOPEPrheYP9BzCzf
	 NPzCTA4vDV9EPBbS1evKPuh/GI+pF8qXGFo3HjHugdEgukAPGckVFMET17UCOf8H0f
	 ohaiih2AHC7emlKyl6LdsMYBjp0KOJabstrhfEJEUAw9AY9PNulCpDi8cxMdfdnv/C
	 GyDxt5cysDFsA==
Date: Fri, 23 Jan 2026 14:15:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 alexanderduyck@fb.com, alok.a.tiwari@oracle.com, andrew+netdev@lunn.ch,
 andrew@lunn.ch, chuck.lever@oracle.com, davem@davemloft.net,
 donald.hunter@gmail.com, edumazet@google.com, gal@nvidia.com,
 horms@kernel.org, idosch@nvidia.com, jacob.e.keller@intel.com,
 kernel-team@meta.com, kory.maincent@bootlin.com, lee@trager.us,
 pabeni@redhat.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net-next 1/3] net: ethtool: Track pause storm events
Message-ID: <20260123141527.358506c6@kernel.org>
In-Reply-To: <aXPntx9wiUqbKGRN@pengutronix.de>
References: <20260122192158.428882-1-mohsin.bashr@gmail.com>
	<20260122192158.428882-2-mohsin.bashr@gmail.com>
	<aXPntx9wiUqbKGRN@pengutronix.de>
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
	TAGGED_FROM(0.00)[bounces-252980-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,fb.com,oracle.com,lunn.ch,davemloft.net,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A0AE7B0F6
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 22:27:19 +0100 Oleksij Rempel wrote:
> > +      -
> > +        name: tx-pause-storm-events
> > +        type: u64
> > +        doc: >-
> > +            TX pause storm event count. Increments each time device
> > +            detects that its pause assertion condition has been true
> > +            for too long for normal operation. As a result, the device
> > +            has temporarily disabled its own Pause TX function to
> > +            protect the network from itself.
> > +            This counter should never increment under normal overload
> > +            conditions; it indicates catastrophic failure like an OS
> > +            crash. The rate of incrementing is implementation specific.  
> 
> Hm, we already have the tx pause frame counters. So, the anomaly is
> visible to the user anyway (even if it isn't explicitly labeled as an
> anomaly).

We are trying to prove a negative here, that's why we need a new
counter. As the doc says this counter should indicate that storm
is never actually detected under normal conditions. Another thing
to keep in mind is that we're talking about metric collection at scale,
so every 1min to 5min.

> What is not visible to the user is when HW or SW disables flow control.
> Maybe that is what the counter should represent and be named? Would
> tx-pause-auto-disabled-events make sense?

According to our existing uAPI for PFC pause storm is the term of art.

> The reason I do not like tx-pause-storm-events is that the meaning is
> device specific; the user has to read the device manual to know what it
> actually means.
> 
> tx-pause-auto-disabled-events can be reused in more cases - every time
> we try to pause flow control for some reason.

TBH I feel like you may be overestimating your ability to do anything
like that in the SW here. The silicon can do this cycle-accurate, FIFO
pressure never relieved. In SW you have to poll, and if you can poll
why not just read the packets from the fifo and let the pipe move?

On the "device manual" point, pause frames as an estimate of congestion
are also quite useless device to device. You have to "read the manual".
Different devices use different pause quanta so to speak.

