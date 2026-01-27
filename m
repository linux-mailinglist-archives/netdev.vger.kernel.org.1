Return-Path: <netdev+bounces-253639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE0nIiYMeGl3ngEAu9opvQ
	(envelope-from <netdev+bounces-253639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:51:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB8A8E8C6
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E86E301DDBD
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE8A19AD5C;
	Tue, 27 Jan 2026 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsrKNcrY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081503B2BA
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 00:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769475106; cv=none; b=RTa7YU1JZnUvkOzDc+iBMDaV1ii3To4kdMDy6eZnEnZwVye14/kevxA2JlhBgA3PU3jqLj+ExPWAusx/HFlUTlvxCCjpY53mLY3d1UcWpQaP1UlH3LQo8i5JQmO2CecVYDiqAGVh554gDn5G0NqEV8tuWJOg2ad8q25Lfbi74Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769475106; c=relaxed/simple;
	bh=/NtOgl//jXPuJSMTE/EaAvxKGxzbcDqlXUmd33t1b6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlHOBJAJoEkutnXjQFjzYVeAo+9dcXWTvM4l+ucZIf+fl051hMO21l3Szxws6c4c1I7RSvHb0VlqcaKGHA18KnW/pbQqYXxNg4/FHAHqZOVCYHMxYTGkahENA1jzR1tHrMDnyE42Bkaxqcb90Ajx1TNeoP64SZUqYscAC9MOx0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsrKNcrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CEDC116C6;
	Tue, 27 Jan 2026 00:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769475105;
	bh=/NtOgl//jXPuJSMTE/EaAvxKGxzbcDqlXUmd33t1b6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qsrKNcrYztJ49G384fvcqcuUjsyoizPuJYIIv8nnqs0+tAyZTI82WG+jPhamGvMFD
	 DCClxEduYLpvjxsSkukoFdnjjSYF+JfvvcGKVzPPMVYOe6ED/vEI8EWDDZNgqS3lCc
	 JevaEQedSZNfAumwFasF1EJ3Cj2jMn5Ca6DHK0ZX1uLxje0wdXBtRv/VadplsmzohI
	 A3RyZAkFqYh9xQONrcQlzUqtrtWj3Qvm++lhrep9lNGuqa/FubpvPsQr0EDAVMfIVC
	 0XP0thotcb/9vc7XTXqFWC5BMsn4+NGrMMTqzG/ifvfPL3A7ybiafHeMhMQ2eH2NYL
	 17EbLfIjvaRtg==
Date: Mon, 26 Jan 2026 16:51:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Heiko
 Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 06/22] net: stmmac: rk: add SoC specific
 ->init() method
Message-ID: <20260126165144.25055591@kernel.org>
In-Reply-To: <aXd7aSk7KIxlQd5z@shell.armlinux.org.uk>
References: <aXdTi4ViCkhhXvFI@shell.armlinux.org.uk>
	<E1vkL28-00000005usi-30YC@rmk-PC.armlinux.org.uk>
	<aXd7aSk7KIxlQd5z@shell.armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253639-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEB8A8E8C6
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 14:34:17 +0000 Russell King (Oracle) wrote:
> On Mon, Jan 26, 2026 at 11:45:28AM +0000, Russell King (Oracle) wrote:
> > Add a SoC specific init method.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>  
> 
> I see the AI review has identified that this patch has an issue, whereas
> in the previous review, it was fine with this patch. I can't imagine what
> it's problem with this patch is

I released the reviews for you, the first one looks legit, I haven't
scanned the rest so YMMV.

> and there's no way to find out for about 9 hours (more like 19 hours
> for me because of the timezone) as the AI reviews are not accessible
> until then.

The patchwork checks are for maintainers. If someone wants to build
a public CI for contributors that'd be great. We can even provide
funds from the netdev foundation. But let us be clear that the current
setup is until now maintained primarily by me for me on the weekends.
Unless you make an effort to actually help I don't think it is in good
taste to complain.

> Makes me wonder whether it's worth continuing to submit patches to
> netdev anymore.

If you choose to continue I'd appreciate if you could follow the common
guidance:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

