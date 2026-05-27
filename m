Return-Path: <netdev+bounces-292025-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMvJGOxBFmrnjwcAu9opvQ
	(envelope-from <netdev+bounces-292025-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:59:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4B55DE193
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A5030056F2
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8940929AAF3;
	Wed, 27 May 2026 00:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWUh/cI8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCF15C14F;
	Wed, 27 May 2026 00:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843561; cv=none; b=jEkvGC8iXFHrOKzWiwyQ1wlhogB+7+oc/YIQcUjsbZw/I4VvW6yqpB+FWh+e1qop65JGNMfWmrHUOpPs52Y1XqtEwlzebMpyELxLXZP6aLpyEwOomsAKIaRt31pUzpP5uzbne7jEEgCGm7C9N+moiviRzXGrhV78kVeZoJYPfns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843561; c=relaxed/simple;
	bh=k9ab6G32k95vDo4ObTyDY7pnJF3uh3gGyuANik0eYKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuDBkJ2MzS3Xa6t+iNk08CEEBEpsNNvoVU9QOFvKjOaOtNHRhKqdVmF2LVDCKze/cnu75Z71/BL7W1CEwxI0riCSbsZpJEEaM+NeHn011+q0gQx9lfNX/3xekinijUom3kYpWszAK/NsJlh8LGmvXwUjjhc71RijgojQnHTW8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWUh/cI8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CE01F000E9;
	Wed, 27 May 2026 00:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779843560;
	bh=TYit9wEjI/z76WLsn7smknCgNatfhJCM1ND91bSyqVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VWUh/cI8pSri9IhaHGdmrY9ujZl9ULA+2s4qCexgeQKsj32HcfEmuMSVNtfZmw/ha
	 CqVN4p/0+l9epUel9NgX/4G62QCypzFhEyez28aFzMhoATzHet5KdJ4CJ10CLxRqdi
	 TS5nQUAfb8eqbNwCQ09LRpYSXzoPtWB0nlxqw3+f4AX6Ci3k11UhBdqepyxWdMlx+D
	 hQsJIl/s5P6nCxJTnsVPHEqpLP+VInXWQ3iROIjF+sPwUnod0vovM4pOowcYYR/pJ2
	 zrhbDmUx97jIsmPXhbsKrSCI75X5K1x7sMGWGbhqjAl8j1I/uAoPvdNaVj87ye0L33
	 pYU4OS8ZPPCgw==
Date: Tue, 26 May 2026 17:59:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Wozniak <petr.wozniak@gmail.com>
Cc: netdev@vger.kernel.org, maxime.chevallier@bootlin.com, bjorn@mork.no,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, jan@3e8.eu
Subject: Re: [PATCH net-next v7] net: phy: sfp: probe for RollBall
 I2C-to-MDIO bridge in mdio-i2c
Message-ID: <20260526175918.472aa0f3@kernel.org>
In-Reply-To: <20260523151859.1665-1-petr.wozniak@gmail.com>
References: <20260523151859.1665-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292025-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,bootlin.com,mork.no,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,lists.infradead.org,3e8.eu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DE4B55DE193
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 23 May 2026 17:18:59 +0200 Petr Wozniak wrote:
> Subject: [PATCH net-next v7] net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c

Still does not apply on net-next:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
-- 
pw-bot: cr

