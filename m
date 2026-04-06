Return-Path: <netdev+bounces-275610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF+rBHbA02kalgcAu9opvQ
	(envelope-from <netdev+bounces-275610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:17:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67ECD3A3D81
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA67D30063AA
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CFF37EFE8;
	Mon,  6 Apr 2026 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rChbnzIw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE091253359;
	Mon,  6 Apr 2026 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775484935; cv=none; b=mFcgtl9xJXmoh/I38XxDDUkUL2GGZMxN71lQCDXQeHqO8BSMgeQCblHtahg8YIB1Kvxnb+G8HKwElZR8z+wNM7WsyDV5vib7GpovHmU6LNsWp9gf0f6QqwcIH0C8LP+oVDHUleueCanDfLGiVQJRQ3ojwm3uPlObBmKGBz8NbEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775484935; c=relaxed/simple;
	bh=9A8ZPtYQexORtGmGqDgRPu12WtZXoegIphLK3agmEyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbPVMDn0i0jENbe8mSknvpfhajHThrYfVpymnizKzaDpbYvsMdM05n6vZEkL6tUrySY/MmredfW3yozXJL9d15ksgTF/n3AGc+KYrLb5JM7zPtGKHTy8HpeoYqP4LoQ3pMFNFBqot9SlFUeU7W9qXotne9YGobzTCsv6vv71mNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rChbnzIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF2BC2BCAF;
	Mon,  6 Apr 2026 14:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775484935;
	bh=9A8ZPtYQexORtGmGqDgRPu12WtZXoegIphLK3agmEyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rChbnzIwGlNroE42Rm4I7DX9ojMi9U1MDqRUtewbYZmWPVnmXULFZJF7y0/sjOEkm
	 Yx4y0PnfdxGYg5jhYf7GlvXnw0stNZn+MIdBDrlQ2IZvO8/HGYGL39HA78sgoobFZY
	 vEYLeYdnaRpqp9s3l89/w0H9FMlkhO7wtQ/bORXHpi31fIigUomed5bS12i5mVTyqN
	 DhfJoaMIxY+7Vt7MgeYi4lGhyKLREqFe/ZmfIvu0HIcoayxgUJwui+36rd0aLp8i4/
	 gZzfVkE/SN3FXTuIdAzBjt2NDzTgnODS+VBud17zN4ZXeHeH+jVmQmFaWZefxuCB6I
	 yU2tONii3+MFQ==
Date: Mon, 6 Apr 2026 15:15:31 +0100
From: Simon Horman <horms@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, razor@blackwall.org,
	idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, bestswngs@gmail.com
Subject: Re: [PATCH net v2] bridge: cfm: reject invalid CCM interval at
 configuration time
Message-ID: <20260406141531.GE395680@kernel.org>
References: <20260405000324.548623-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405000324.548623-1-xmei5@asu.edu>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,blackwall.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-275610-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:email]
X-Rspamd-Queue-Id: 67ECD3A3D81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 05:03:24PM -0700, Xiang Mei wrote:
> ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
> the configured exp_interval converted by interval_to_us(). When
> exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
> interval_to_us() returns 0, causing the worker to fire immediately in
> a tight loop that allocates skbs until OOM.
> 
> Fix this by validating exp_interval at configuration time:
> 
>  - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to [1, 7] in the
>    netlink policy so userspace cannot set an invalid value.
> 
>  - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
>    not yet been configured (defaults to 0 from kzalloc).
> 
> Fixes: a806ad8ee2aa ("bridge: cfm: Kernel space implementation of CFM. CCM frame TX added.")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
> v2: Move validation out of the datapath and into configuration

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

...

