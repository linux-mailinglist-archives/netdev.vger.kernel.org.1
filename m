Return-Path: <netdev+bounces-260681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP+KH208nmkrUQQAu9opvQ
	(envelope-from <netdev+bounces-260681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:03:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA3D18E406
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A05130EA85D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2727A268690;
	Wed, 25 Feb 2026 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+uEs5Ct"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5FD231A41;
	Wed, 25 Feb 2026 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977674; cv=none; b=WvPZ3wpa4vcGgAcPDXn64PXayGmEyRueFLxTtXLpIWE6lGq0ixP/gwHnktHNKUZogqXK5aG5h5+2ld2jpHEVx/A3+OBapc557IBZj13PWLiL4ej449HZx4LyNkY/9qCaWBCu58EWgJoVMVucr0vFl7vV1PFBg+Uav48IdGjyT9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977674; c=relaxed/simple;
	bh=diIyggRBunM6pAfWp7NBfWsC45RGZ/ElFCUHcJyXFD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CysRJ2m2KfNNTJvxFwwSwxbyI1VsKGeE18Udy9+7RFCpSThDWTJU+f5nlR5gWVAE9xG7olhNxxunjvMh0ahv4M9d382HXTFzgGoopGXUnquU2r12Z+juYYA/U+/QmX96owRYy5g62e+eGDsQMi9AZrY5nvBzZcc7PDmhCnDGYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+uEs5Ct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AE0C116D0;
	Wed, 25 Feb 2026 00:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771977673;
	bh=diIyggRBunM6pAfWp7NBfWsC45RGZ/ElFCUHcJyXFD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h+uEs5Cth7K1xNZGkGsweindLvyFzd30R6BXvOvsqKbe5nyJ2KHRwE1V+kbnR+vpb
	 HK24DdUn4jyTczWNSVt+SPdC7ZBQMtxdmk7s7kI2AGOAq1kVVUc9C0O3VnKteNsFNI
	 aJxOQRsNDr/xJQVtIcJphv7yPbNa4QG3ON8yPn1fmkrQ3gqLPZNtUwNi1szx8bxTJr
	 LduStCDS0caF074KkeVpzjNsVIC/kWJ9oGACYN5gzpxoN+1ZWvTT6PK13ga914Rx2t
	 Y+U8BCGtBE5Nx5km/r0bPWsIUBZFe+k98LQSBbzAY3uI/QOlX71jRE58gsK/HyTTWG
	 ddkOrTxCO9GLA==
Date: Tue, 24 Feb 2026 16:01:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gabriel Goller <g.goller@proxmox.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] docs: net: document neigh gc_interval and
 gc_stale_time sysctls
Message-ID: <20260224160112.0795dfc5@kernel.org>
In-Reply-To: <b4z6x2djckenphenqpz3sfnqa6gnahvbxwpycvoicgpbsqx3tg@jbrrvrz7g4h5>
References: <20260219162200.510325-1-g.goller@proxmox.com>
	<zevfldlqbbprujyld3v3jdl7jlifbmn7ixhrdcpyj34eepv7m4@j55q7mptwqyt>
	<20260223145809.2369117c@kernel.org>
	<b4z6x2djckenphenqpz3sfnqa6gnahvbxwpycvoicgpbsqx3tg@jbrrvrz7g4h5>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-260681-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FA3D18E406
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 10:06:41 +0100 Gabriel Goller wrote:
> On 23.02.2026 14:58, Jakub Kicinski wrote:
> > On Mon, 23 Feb 2026 11:23:29 +0100 Gabriel Goller wrote:  
> > > Superseded by:
> > > - [PATCH net-next v2] docs: net: document neigh gc_stale_time sysctl
> > >   https://lore.kernel.org/netdev/20260223101257.47563-1-g.goller@proxmox.com/
> > > 
> > > --
> > > pw-bot: superseded  
> > 
> > Where did you get the idea to send this email??  
> 
> Haha, I changed the title of the patch in the new version, so Patchwork
> didn't automatically recognize it and mark the old one as superseded.

Oh, that's nice of you! Would have been useful to mention the reason in
the email to avoid my grumbling :)

> I saw in Documentation/process/maintainer-netdev.rst that there's a way
> to manually set the state to superseded using pw-bot commands. However,
> it turns out I don't have the necessary permissions to do that :)

You should as the author, I think the issue is DKIM. Your email from the
archive fails DKIM verification, probably because headers were modified
to look like they were sent by the list? You can try to complain to
your email provider, most get it right.

