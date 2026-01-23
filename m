Return-Path: <netdev+bounces-252901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDLSELCsc2nOxwAAu9opvQ
	(envelope-from <netdev+bounces-252901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:15:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE14178DE3
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF0863019CA3
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AF3246797;
	Fri, 23 Jan 2026 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHosacAz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB6226863;
	Fri, 23 Jan 2026 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188523; cv=none; b=TbaxPD2yRrwdOWnlQVu07psjQv6BQ6zybsb5xlBq05IlrJmlF7JtFVRZ1nkCy+1jbpL6zIg7apjkEcd0A82+HVtDH6ilV/HJb686RgWOXPxJyG+ZbzN+P2DkBC9vQI3di0PjvUxfcLxFDPqu3GBeuoC3YX6ZtngDHWg0S50FrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188523; c=relaxed/simple;
	bh=dHTW9Fg3mhwXPZF1GmicztPgqI2sX6aYEx8/sD87Cf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZTX2jr37ZWaDx7J7FGpbGPqx0XChP+WvFea2Dm3fD4Nn4Smw5ijmevrSfRUsagP5cD/CqecBuNXmhme1pM2ZxH529YjLAu9vETyU5WfyvnJ66DwCRDG3c3Z6I2g1C1XlWQ1hMV76ctVxS4DOg3Ufc/+qMZlRNkBrvBehZn7cIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHosacAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41586C4CEF1;
	Fri, 23 Jan 2026 17:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769188523;
	bh=dHTW9Fg3mhwXPZF1GmicztPgqI2sX6aYEx8/sD87Cf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHosacAz6uufrn158kr4z2qJNpqpR7k0gXSm2zQh87Fw+WSOLNCMu9R22VR6gH7bj
	 ch1h3EN/YkJWJisP0Nn2pI15Eujf1aFRYK31FbZrZD8zWm+0q//7bI2vyBrb3S9+Rv
	 iKC2RoY/E6oHaOgi/ie/cHVWBc4i5e5SohqexE3X62aHrBlkPPXtmMLo2gmG7fS7NA
	 OL+v9+dgxnX0Pyp8NE92wy7UxG2jPq0F+tDZjTgprplqQls0YxT6OauJW6WGCiYKAF
	 LggnxUMFXjHipB3TBqawTOemZB1xsRhyhTyO6tI/dHdC+mXMpWJC7t8EObwnPjRZpi
	 3rDxz69sTghgw==
Date: Fri, 23 Jan 2026 17:15:19 +0000
From: Simon Horman <horms@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: remove obsolete file entry in NETWORKING
 DRIVERS
Message-ID: <aXOsp3T2BC5Gxzaj@horms.kernel.org>
References: <20260122074609.151058-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122074609.151058-1-lukas.bulwahn@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-252901-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE14178DE3
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 08:46:09AM +0100, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit d8f87aa5fa0a ("net: remove HIPPI support and RoadRunner HIPPI
> driver") removes the hippidevice header file, but misses that there is
> still a file entry in MAINTAINERS referring to it.
> 
> Remove the obsolete file entry in NETWORKING DRIVERS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Thanks Lukas,

I agree this is the case.

But unfortunately our CI seems to be confused about which
tree to test it against. So could you resubmit targeting net-next
like this?

Subject: [PATCH v2 net-next] ...

And note under the scissors, below your Signed-off-by, why the change since
v1: targeting net-next.  b4 can help with this.

Feel free to also add:

Reviewed-by: Simon Horman <horms@kernel.org>

-- 
pw-bot: changes-requested

