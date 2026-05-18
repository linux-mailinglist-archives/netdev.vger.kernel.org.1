Return-Path: <netdev+bounces-289192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIGJB6qYC2rXJgUAu9opvQ
	(envelope-from <netdev+bounces-289192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:54:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA34574D17
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 00:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A40BC3003635
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 22:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283973043C9;
	Mon, 18 May 2026 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUmdd0Ux"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CED2FD695;
	Mon, 18 May 2026 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779144766; cv=none; b=Eh/bbTNtiDL9RwpyuD0FBS/DDW1XfkKDUcd3hMLXYQZB+ylrpupNYOcZXDzg7yocmjDLEj9dTax9lXa1++Rx9tW5oBe+1+oSX6bVcVkc+Q19XYwdV86x3owWmrIWmpEwWuFzv7gRJzgx6Akbkmq0xWh5DqmvXZs2pRb+U09mK/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779144766; c=relaxed/simple;
	bh=jqNm7F0L0ueD2m/4Jv94ZtJyTZRWEJneJ2TmKhe3Zzw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/6ohaiJnjNVxzftymz3KNJ//FQST2NlV/idT+rwsO46C0jGBLJJgqZ1UwX6EiWjeYzt6m7I4kCO7e77L84ETQFw6YSQg6PlvI0PuytO+fGx0J8b/qvsodf3AEV70FiALH1dOqJcfuqZal8ylNlte8DU+8G8bUSbmFgiVv//oMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUmdd0Ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008A8C2BCB7;
	Mon, 18 May 2026 22:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779144765;
	bh=jqNm7F0L0ueD2m/4Jv94ZtJyTZRWEJneJ2TmKhe3Zzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cUmdd0UxbWS8kjCHTD+qPSTtS3gqWqr3AiBWIYgVHq3vXR0/ybkZzYajMd26dZncW
	 wKwTE25l3iUJYdM+iS4t5u+6w3sMYVaIK/H7lA0Y6fNEyJUnLzoPSN+F5HSrTy42Ba
	 5shSj3XrtdYwPry0Vd0dF6dgFnRiYWdChP3DB7oDKHhK66PhLUh1558Ssdw4y0+sFh
	 gjv3itWoEeKkFoITDlJau5zDaVPpobcDnq7gjlFGTWlWI7LGL4wdAvRc4EhJUyg5Uq
	 luJJutFG8+0/w1QutTlJ+P/tDt7wRylyQVBpl6bcXMJf5nt4iJPE9A52AQ+VotBnPX
	 UWvbKuro5092w==
Date: Mon, 18 May 2026 15:52:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Marek
 Vasut <marex@denx.de>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] net: dsa: microchip: Add support for
 KSZ8995XA/KS8995XA
Message-ID: <20260518155244.575afa75@kernel.org>
In-Reply-To: <CAD++jLk81ieH_d2oT_9-bcA3y2dCwT1qxnr5Y+1X9bMNT4whvg@mail.gmail.com>
References: <20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org>
	<CAD++jLk81ieH_d2oT_9-bcA3y2dCwT1qxnr5Y+1X9bMNT4whvg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289192-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,denx.de,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7AA34574D17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 16 May 2026 17:04:38 +0200 Linus Walleij wrote:
> > This series breaks with the dated attempt to polish the old
> > KS8995 driver, and instead implement support for the KS8995XA
> > in the KSZ driver, and after that delete the old KS8995 driver.  
> 
> Obviously the patch series should have "net-next" in the
> patch brackets. I am just expecting review comments and
> AI buzz so I will need to spin many versions anyway.

Looks like there some AI buzz in sashiko, but also - it doesn't 
apply on net-next.

