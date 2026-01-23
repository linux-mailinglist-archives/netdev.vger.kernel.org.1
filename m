Return-Path: <netdev+bounces-252885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4+82L7ulc2lnxwAAu9opvQ
	(envelope-from <netdev+bounces-252885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:45:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18223789C9
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 780D13011C46
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF78E21B905;
	Fri, 23 Jan 2026 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBBQIoRz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00B201278
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186744; cv=none; b=LxKSrA9dhj86v7SsSmdlE2rkBgMPdC7mC3mzhuTI8dvbdAWxdK9plYh4Qtyl+R8UuK6+MsXrf4dsohdB6fQerteMHR3wkSoLvN97Q8XDeJJZxsOUaUYBRejBq7X88kkxubjnKIpaUzT8wL5Vs2Tdl5IK6dfHQjPERwqEq3HSIXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186744; c=relaxed/simple;
	bh=VGbNVNahKWwLXw/qQCNp/J4Iq8B/K42acEfB6yri4DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCXcIQCg0BtwmMDpMV14PVom6UD08u/GrVz/0vZ/WVLeqUUKavei83iGZJeD2xHe3UrZ+AZ2F1N0l18QelYBG1O4reO2gBfg0P/3zO5umxqH5NndnicwEtipUuIKKtiX/hZpU4X5yDYln6atnJmx/kc40wiMOHbBV6HWArQXEXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBBQIoRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292A9C19423;
	Fri, 23 Jan 2026 16:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769186744;
	bh=VGbNVNahKWwLXw/qQCNp/J4Iq8B/K42acEfB6yri4DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBBQIoRz3wwA4swVYscxFnC8Iwj9IVtAtzWeZ/uSqnmYorxr+v5xz6Ya/Kn17FhGu
	 Hjpp/otTObs82HK7Qih/ceQFz4RBp22sDJpkMcgBAb3KfAg+DnvJJEHrxkn4ZrCLl1
	 gUuNl1zLTyEZIyYlwqVuuiy0mMHo0VD9cNpZsFj3g9jzGWj6FVp6ak4r1AWtwsMzcS
	 aj/H2LUb8nE07inSzzE4MQ6Gr6rgjHtiVmSlHwAgb9BAozJEC159i4D6Ox0YqkjxEv
	 QrHdOPoTErLb86Oil0M+g53onVwmVCYtsMvInajXOBgYc8o7y8OYRb2x0CokuY+edh
	 5uB+nBOM3VBAQ==
Date: Fri, 23 Jan 2026 16:45:40 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 2/4] gro: change the BUG_ON() in
 gro_pull_from_frag0()
Message-ID: <aXOltKyRoWvUTfKf@horms.kernel.org>
References: <20260122045720.1221017-1-edumazet@google.com>
 <20260122045720.1221017-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122045720.1221017-3-edumazet@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252885-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18223789C9
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:57:17AM +0000, Eric Dumazet wrote:
> Replace the BUG_ON() which never fired with a DEBUG_NET_WARN_ON_ONCE()
> 
> $ scripts/bloat-o-meter -t vmlinux.1 vmlinux.2
> add/remove: 2/2 grow/shrink: 1/1 up/down: 370/-254 (116)
> Function                                     old     new   delta
> gro_try_pull_from_frag0                        -     196    +196
> napi_gro_frags                               771     929    +158
> __pfx_gro_try_pull_from_frag0                  -      16     +16
> __pfx_gro_pull_from_frag0                     16       -     -16
> dev_gro_receive                             1514    1464     -50
> gro_pull_from_frag0                          188       -    -188
> Total: Before=22565899, After=22566015, chg +0.00%
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Hi Eric,

Am I right in thinking that the motivation is to reduce this
check to zero-code in the case of !CONFIG_DEBUG_NET?

