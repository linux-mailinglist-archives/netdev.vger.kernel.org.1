Return-Path: <netdev+bounces-279088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMOMN4kJ4WnoogAAu9opvQ
	(envelope-from <netdev+bounces-279088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:08:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0D14115DE
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 049E33036497
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8307B379EF6;
	Thu, 16 Apr 2026 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCQwztZ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FE42FC037
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 16:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776355718; cv=none; b=TUsN1s9MldZjxlZFcu5IyQ4d1SeKwX2ZuzwojIsEU3xHIzN1X6uXYKbScyDb+NHA+QTWW5N0q5RGiGQaGvnJXBWEoiGN9qDTf3q35yvey5ALduL1BWPTRDTVZi/ItRmTN4yUGMefbZm7k6Mhm4BiFALkwg9B4fnnNDkggCnPcSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776355718; c=relaxed/simple;
	bh=blfLhEBoi0Jo2O7QmaSG1KknkwFty/RTOwjSNlNAq2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FiTc3VlIcFKM0HltdUhfIqWnrtyRY/M1KHOYTM460WjKdKFa2PAGU20ABuU+CVwrR7yi2iVZNdS8u4T9SfG8jjovRVq4jC28OXAXmxuWT9FtfEM5qQVmXWKtT6HI0HJTbG3VHPZiwG+DFiDiI+0v9fvF73vcqGZTpKvn/89ldY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCQwztZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777B4C2BCAF;
	Thu, 16 Apr 2026 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776355718;
	bh=blfLhEBoi0Jo2O7QmaSG1KknkwFty/RTOwjSNlNAq2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lCQwztZ6rZGKQF3hDG1tpdLN32/+spbnaWx/az7G37E7GpPped5+BEE9XJEPnA2y5
	 fpTn2r+zI1yF5jnpvdLMT6LGbKCXxApZ547uyUsZFNGtT5ydINPmkfpFjhSk47NpXY
	 1AJknVDSbjv8yb7HOQwTzGBofXg9eFUw1ti09WYmOdLYfoYWd8hqr1YCYzV8trtvfL
	 5dASKr46AG33P5ttniZLBrRCQLJzDf/YJueqy8WQEqmCQD3AgGfrtLKYPs7drulcuf
	 WDq2lsU2EFjpK8zlNrmcxLV7hKSUeSVKEfHPmEp/ZJaD8KnWmGuPz77HLmoDmfNAW9
	 lSaB1mZ37GlRA==
Date: Thu, 16 Apr 2026 09:08:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next 5/6] net: stmmac: move PHY handling out of
 __stmmac_open()/release()
Message-ID: <20260416090826.1c5ca018@kernel.org>
In-Reply-To: <aeDojTdDTELfpT0X@shell.armlinux.org.uk>
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
	<5987484.DvuYhMxLoT@steina-w>
	<aeC-tc2CooYDoBok@shell.armlinux.org.uk>
	<2410317.ElGaqSPkdT@steina-w>
	<aeDSTIS9-TDSihbX@shell.armlinux.org.uk>
	<aeDojTdDTELfpT0X@shell.armlinux.org.uk>
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
	TAGGED_FROM(0.00)[bounces-279088-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ew.tq-group.com,lunn.ch,gmail.com,foss.st.com,davemloft.net,google.com,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C0D14115DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 16 Apr 2026 14:47:57 +0100 Russell King (Oracle) wrote:
> The next problem will be netdev's policy over reviews vs patches
> balance which I'm already in deficit, and I have *NO* *TIME*
> what so ever to review patches - let alone propose patches to
> fix people's problems.
> 
> So I'm going to say this plainly: if netdev wants to enforce that
> rule, then I won't be fixing people's problems.

Do you have a better proposal?
I'm under the same pressure of million stupid projects from my employer
as you are. Do y'all think that upstream maintainers have time given by
their employers to do the reviews? SMH.

