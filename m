Return-Path: <netdev+bounces-269643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGiNFihavGlxxQIAu9opvQ
	(envelope-from <netdev+bounces-269643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:18:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFFE2D2027
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C67D4301874E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB8F38D68F;
	Thu, 19 Mar 2026 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJN6j8a0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E05346A11;
	Thu, 19 Mar 2026 20:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951525; cv=none; b=SswPWMZe3cul5HsmS/73ZZvAqpgWKfnK5a0eQrSJGS3Cbz4wchZHD6J5YQQ5aEHsgCVz0n655b/7CMnTNkGp/WJbjk/BMpQ3tF0xMfw6+2u9z4P2sw+vz3jkmCf9ieUQs5E4snUJ7NXaf9MOjwj5Z33i5QF0why76ksmpGPX20g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951525; c=relaxed/simple;
	bh=0I1Ng7l6zj58WKvgzDNU0vzTHRZxbxQBZxRvTtuZmtY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnOgX6ZFZEDGQR30Zp4sGz+LF7BqI+suJcLBcfvq3bf7iJE9u7yROmZffw1zpL8vhuU3asXYFyGHwS0RdBLUxpiAxXgEovzoNYd38NfRQLSRrns90eQPeB9b8q5kLDtbdzNLPqUUQ244jQKfNLH5uRSFoSb6Jbf1kTjsYpw2S0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJN6j8a0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCB6C19424;
	Thu, 19 Mar 2026 20:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773951525;
	bh=0I1Ng7l6zj58WKvgzDNU0vzTHRZxbxQBZxRvTtuZmtY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IJN6j8a0p13pSCjt7EPLVySd4cgX/OQnI4th0js87XmUquD8cOEOZx9D6SSpCz2Ps
	 lnk/gdYSe+aTO4hULAY0CdVawsLANI6IsrFnFDCuQYHF4VmX7NMbQKA05j8F4QxxK9
	 UDJUiP3buVr3JRiGnqzj+5lzh80+ZtRzmIW1GrPkQczPb/k4dc0rNFh7v+xMUwxFpx
	 7Klk+BLP+zupJ9ngXg0r6fUwtrZ7bGBgmdBECtSW/LkrDnuthAF2vbwAl7/KivsbO4
	 v4B0UOQgg4ZbRg0ghvoHhWWI602S24tYSfjxfyLC4zimiefixgwqrWBjpZq59Pq2vz
	 YVddfQUQXTvkA==
Date: Thu, 19 Mar 2026 13:18:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, shuah@kernel.org, matttbe@kernel.org,
 chuck.lever@oracle.com, hawk@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: page_pool: support dumping pps of a
 specific ifindex via Netlink
Message-ID: <20260319131843.65de0c2d@kernel.org>
In-Reply-To: <2e4a7b45-8029-425e-8b86-9f3031bd081e@bootlin.com>
References: <20260319035649.2396137-1-kuba@kernel.org>
	<2e4a7b45-8029-425e-8b86-9f3031bd081e@bootlin.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269643-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.906];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCFFE2D2027
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 20:56:46 +0100 Maxime Chevallier wrote:
> >  	for_each_netdev_dump(net, netdev, state->ifindex) {
> > +		/* Either the provided ifindex doesn't exist or done dumping */
> > +		if (ifindex_attr &&
> > +		    netdev->ifindex != nla_get_u32(ifindex_attr))
> > +			break;  
> 
> If the passed ifindex doesn't exist, isn't netdev NULL here ?

The for_each will give us the next netdev after or not enter the loop
at all. (the selftest in patch 2 does cover this case FWIW)

