Return-Path: <netdev+bounces-294899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VLX6G9OGIGrc4gAAu9opvQ
	(envelope-from <netdev+bounces-294899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:56:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E073063B027
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 21:56:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eMwmu5g4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294899-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294899-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ABDF302E40F
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 19:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B1F39B481;
	Wed,  3 Jun 2026 19:51:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB6F39C003;
	Wed,  3 Jun 2026 19:51:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780516286; cv=none; b=IRROoGVW+6QgHf9yKcuPuKkwrKE5pJETEFqVGYfKm94E00kxb1z9P+GHTEDSMpBUub8QSwfSnplRF4/DAX8d9sn/fpo8Nqb/A3DBAaaA4+NxvU/Ep+HFS4Rtznd11/+pIlmE98qXQQdQQILZu1+3ebSxCUQODmMKOX75vvgOYOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780516286; c=relaxed/simple;
	bh=CFThhJrSYYq7z6ju6tn57kRcJ4QgQgHpYJYWHFQ2wzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQk3K0zFlyiubpAKGbDWilkeF+U7B4G8CKM7Gx4VjNau24C94RsBlq8Gio42pkGmw3lpRIJGlRupCrZKMTyTryfFZZ1YDqLQmI2qpAzxgd6b7neeizEDXtHR4lgXiWbpu1kTj1Ze67a7eezLFrSawc4LW3RjANSec4JJQpKVIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMwmu5g4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF391F00893;
	Wed,  3 Jun 2026 19:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780516285;
	bh=w/k0IQ6XXWj4XJjKitMkJ3/nyGPhC7BOHNcOrh/8TTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eMwmu5g4Pi/zkb/CmRjmMJaEDnFhwJamLXAs7ZJlWTHAa4/nk67FKaWz34vE/qp94
	 i/XAbhX7kDGDa6KT3b0PUdNxSY743rdNOfVW4gC5svIHCbVbS/z9O3mdvrENHAyhlb
	 754DfilC2Cjd1XnK4Pb8DhqhwaRSdRO7TT26e9BYleuq/JWeALuzoyf1kOj4Wt8T/l
	 bS8UtkvSyr5kflC4pUfUJ9q/eZdV4s3qGuo/T4JWbfRZDkR/a3DDMNTuYO8IovZZVk
	 stDto86/m7YyAQJpv3MwghqhYwNz2vU7cHsrbkk7nVfIfIYoScMZ0tx7gww2g42k+D
	 BqsKcSAXUiJxw==
Date: Wed, 3 Jun 2026 20:51:20 +0100
From: Simon Horman <horms@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com,
	gakula@marvell.com, bbhushan2@marvell.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] octeontx2-pf: Fix NDC sync operation errors
Message-ID: <20260603195120.GI3766816@horms.kernel.org>
References: <1780054677-17249-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1780054677-17249-1-git-send-email-sbhatta@marvell.com>
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-294899-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,marvell.com:email,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E073063B027

On Fri, May 29, 2026 at 05:07:57PM +0530, Subbaraya Sundeep wrote:
> From: Geetha sowjanya <gakula@marvell.com>
> 
> On system reboot "rvu_nicpf 0002:03:00.0: NDC sync operation failed"
> error messages are shown, even if the operations is successful.
> This is due to wrong if error check in ndc_syc() function.
> 
> Fixes: 42c45ac1419c ("octeontx2-af: Sync NIX and NPA contexts from NDC to LLC/DRAM")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


