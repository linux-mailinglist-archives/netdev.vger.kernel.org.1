Return-Path: <netdev+bounces-292323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI5TOD0AF2oJ0QcAu9opvQ
	(envelope-from <netdev+bounces-292323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:31:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 897F05E5E62
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D6C930010C1
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406FF35E94F;
	Wed, 27 May 2026 14:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rta/aNap"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF661C695
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892281; cv=none; b=QQ0CFE+Dxil+JYkIJqnKtGQQg+gXzdQwmHvUz8E7mYZcWtBlKBtuW7Cf9bE046FYYHOwabam5nsSB8Wtk4kj8PUEpEKnU8xmx7MUWaTbSecxOLTHo5QCmzGrSjqpYHqe7Uow6KljO41vTHXwBUpnHT2f8O3V7g7h0jNAMRE6RqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892281; c=relaxed/simple;
	bh=O/jW0dQPgxYRjTJi0ZIpTKXRJjRBf1pQy99TEV5y6DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHPn8Ab7ih6lQfvcSHoasItaq5JqyYw/zRVtQHJDCSc6fJK+fGJemUZYwsFUX7FkYfI95fHUaZyh+Ibgg8wrrKbPvzAqcFiFjXN+rnjuMfVyIRwrNq4CBNYO0kEkS3st7Q2w7ETlqTmH3dHppMjIWEak0hLv6SzGUO+wHwPPtUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rta/aNap; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED0F1F000E9;
	Wed, 27 May 2026 14:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779892279;
	bh=xlGyOtd/3RRu7jO2WJjx9P1cEwM04b3dCmt63CbiumA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rta/aNapeX9Mk5z0WpGxJTQQ+PmUlrz242qXUU8dAZyFcWa9pqVXgpmHc+xT1VWiN
	 n3Iqy4CRCxTXvbcsqmAjSgvUVNT98uMRjzGjoayIjhlxGr5DLA/e2dDxePen/NrlZx
	 TAFCx4UxGEB+hdJp7lWAscO3I7PgIbxM3asdzNu89XlkWwrzbgA4ufkk9EFaqd1TFR
	 GwJrdvFkWjfMyXcdZuoDXTPW9DjpQ2mN15bO3mOEBp2Ler1bXUS/QUZHP0t4oAdVQk
	 cj7x+Cg5u8V0Sgb2We2cJlLOxVRRndWmbTwM5/1wonctu2AeDKnZNvVDTlWVU50qBv
	 5/Z0CNQo+cwVg==
Date: Wed, 27 May 2026 15:31:14 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH net-next v2 0/3] wangxun: improve service task
 synchronization
Message-ID: <20260527143114.GM2256768@horms.kernel.org>
References: <20260525100543.27140-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525100543.27140-1-jiawenwu@trustnetic.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292323-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:url,sashiko.dev:url,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 897F05E5E62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 06:05:40PM +0800, Jiawen Wu wrote:
> This series improves synchronization between asynchronous service work,
> device teardown, and module event handling in the Wangxun drivers.
> 
> ---
> v2:
> - Check WX_STATE_DOWN before setting WX_STATE_SERVICE_SCHED.
> 
> v1: https://lore.kernel.org/all/20260519080048.7448-1-jiawenwu@trustnetic.com

Hi Jiawen,

There are AI-generated reviews of this patch-set available at
https://netdev-ai.bots.linux.dev/ and https://sashiko.dev/

I would appreciate it if you could look over them and address any
issues that are either introduced by this patch-set, or directly
impact it.

I would not suggest expanding this patchset to address any other
pre-existing issues, but rather address them separately as appropriate.

