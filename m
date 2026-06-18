Return-Path: <netdev+bounces-300456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XLMMHvv5M2oHKAYAu9opvQ
	(envelope-from <netdev+bounces-300456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 16:00:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CF76A0C1F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 16:00:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WuCrV+XL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300456-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300456-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C63A300E3C7
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 14:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B6A3FC5C1;
	Thu, 18 Jun 2026 14:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63C3FBED2;
	Thu, 18 Jun 2026 14:00:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791222; cv=none; b=du3sEEBewobVekBebzvYfk9rlsHITlpRlNteNkqSgyjOx9zFXl2m0S60NwJkTyPoyNuXtLuWsbeH+yRtXKtB9T800DjtSGn1qlvBwvA48oPuQBJa+ufsypEtKSjX52uWpSZBw2WAHwPFst0DWWlQvMhvvmiXv25q/ZjfRnH86QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791222; c=relaxed/simple;
	bh=NjVlpOXm6RHQOlL3ulASs3AfzNZ46gmqIVkXc7lQutk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVXUWZAEaARZm+J2ffbNk2HIlVG5fyMHO1TN5XEAxbWGJXVF1vYjGQChAjKBCKuE5HlllVhbH41v94AZd12cCXD+0Id6f+jWIt6/VLuULVb3IJMugnw8RRXlAPV/xNkve9WV/Epb0N2r34Q6Y3Q8LoPZG+Eg6uE4XyW6Ngk8Pmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuCrV+XL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999171F00A3A;
	Thu, 18 Jun 2026 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781791219;
	bh=usXAkm81oxURlLo9g3M0MwCRraiXK0GggTZdNWsk98s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WuCrV+XLsoH8gca7hc6PBW0571b/7hxn6jLHzTNqu6VmqnHJ4i9KAAHbkCl9ycpB3
	 FPMW0fp77uLtetC8tEoixHehWwfUMXERhYQCLBITlXQCtKB7/LNrYFQ9ThKj4X3gtT
	 oDDZXiuVZOj9455lDVNEGenAxzy6+fY0ww6PxtnC7srqiOCa+zkzxH2wgfAcLBdcsW
	 FBVDT1fx9AoDT56qncfQfLLP447tTQNo8tgONbMqxRAmZ0ViqkdxGB0FBiYkr4T92c
	 wK2Q+GUFwimH7W6XLvwOQNNz1u3pNDDhmfoIN5m+1TN5oiIj3lKsMHnkklvCaP6/D5
	 M+leZ4/nhJlIQ==
Date: Thu, 18 Jun 2026 15:00:15 +0100
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, sgoutham@marvell.com
Subject: Re: [PATCH net] octeontx2-af: npc: cn20k: fix NPC defrag
Message-ID: <20260618140015.GP827683@horms.kernel.org>
References: <20260617102149.1309913-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617102149.1309913-1-rkannoth@marvell.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300456-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:email,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86CF76A0C1F

On Wed, Jun 17, 2026 at 03:51:49PM +0530, Ratheesh Kannoth wrote:
> npc_defrag_alloc_free_slots() always passed NPC_MCAM_KEY_X2 into
> __npc_subbank_alloc(), which must match sb->key_type, so defrag never
> allocated replacement slots on X4 banks. Pass the subbank key type for
> bank 0, and only extend the search into bank 1 for X2 (X4 MCAM indices
> are confined to b0b..b0t).
> 
> Fixes: 645c6e3c1999 ("octeontx2-af: npc: cn20k: virtual index support")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


