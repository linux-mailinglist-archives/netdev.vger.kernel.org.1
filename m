Return-Path: <netdev+bounces-298726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xjrxAOw1LGr9NgQAu9opvQ
	(envelope-from <netdev+bounces-298726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:38:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8287267AFEC
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 18:38:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dqw1Vp1+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298726-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298726-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DEB031FA099
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82013EEAE9;
	Fri, 12 Jun 2026 16:28:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F73750C4
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 16:28:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281703; cv=none; b=j3bvJXZ7ghYmofwFZ4ghPZVORZybA8Qg4g+hJ/uSAStYcH/fI2vVGAUTQesdTXUaYzTsdFsAECX6EbinGIJJ4QQ2w7hz71RBbhuG/nhAMTU8CoTpHjLHPoRRzBuLEr9KmB/Y4ufVj6+9vnugiyo+ghLOx8n+fFxM24e+UWrhKnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281703; c=relaxed/simple;
	bh=8Lg9Bb4x4TWmemkBKnMCVb8Nt4i5MGAjBOI00+lnMKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEtgfHXOInCyCqVw8GY0HVcR65K6jt4V4tdCDlf7hJDel/QuYwxDIJku3Dhg6UaAvLffE2wbNCnq1az4Zsp0XQriqBFUXYEDT1X6JKC39W1hAVbXC0SIYUNpBbu9piXZMmyydKOVOL/4NLXoNwlG7URaHQ8XF8LEzoag6cRmI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqw1Vp1+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68BD1F000E9;
	Fri, 12 Jun 2026 16:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781281702;
	bh=xi/QvlDyoWoyjS7C1yT9gvcxhFW0VW+Wf1DoCcoSY6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dqw1Vp1+XRaqGDbwUfrTu99HhY4tldd5cJ1lzgwE/r22mX1AjHYXcfLAvO3TSbAaT
	 gVDifZa4cYkdCQirPmUp1aGV7OLmtRnAf866g8LN6L936PLOC62+ymyVhGtLJN7g7g
	 PRZozR370niAA5yYI2dH0vOuIXdp3LarEdVisBr1xreXcY7T17lYbuu9Lva4xa43kf
	 Mz+2Bhpwau1kY974qZgRJHsyRGcF8k5KxDSIwZlFZf3HqaeOAZY29Gx3ZF47OXU4Dx
	 P5DWLyB3DhOQhfNK/Q95sCN30fSn7JM/G1ZbbogSsjFL2mvDTjapceCvCvU0lUYf73
	 vfxHQEQouvkLA==
Date: Fri, 12 Jun 2026 17:28:18 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] ip_tunnel: annotate data-races around t->err_count
 and t->err_time
Message-ID: <20260612162818.GF671640@horms.kernel.org>
References: <20260611165247.2710257-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611165247.2710257-1-edumazet@google.com>
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
	TAGGED_FROM(0.00)[bounces-298726-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8287267AFEC

On Thu, Jun 11, 2026 at 04:52:47PM +0000, Eric Dumazet wrote:
> ip_tunnel_xmit() runs locklessly (dev->lltx == true).
> 
> ipgre_err() and ipip_err() also run locklessly.
> 
> We need to add READ_ONCE() and WRITE_ONCE() annotations
> around t->err_count and t->err_time.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Maybe this should have a fixes tag?

In any case, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


