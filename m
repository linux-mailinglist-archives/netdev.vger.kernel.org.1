Return-Path: <netdev+bounces-287116-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP6KLpwcA2pD0gEAu9opvQ
	(envelope-from <netdev+bounces-287116-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:27:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAEF520161
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 14:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF449301E558
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34F03A4504;
	Tue, 12 May 2026 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UTTxliGM"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779733655C4
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588823; cv=none; b=ZEqE+QbvLX/5R1r1kzytphoYOneVTuveUNoAy4XTxP1in5te56VbVwa06/ur6Axvr2fxBBkLFYQB9vOJZB7kg18F62VIOosG5/k0DUR01WVE2/hzf6FexGfyrY65Ygk7Uwl8bfkg6eTgQWoQudZDsIVkGE1Z8Q1Qguv1gMfNlKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588823; c=relaxed/simple;
	bh=/NfK4Aqzck1yzQ4qWf4oC+XhPwcrbIHGTghnw8amPdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cuqt6VrfpWrd7bkUqygTOyVgMuNkkzVCQ5fLa6W9gErx/AlwmM4jbuEPnmN2w9bPXmcwrqsLltN8YMCQqZ9iBgp9QhdPqHx5QiPhyUIu3BGuJhm93wQpNAmtyN1O+943AwGb3eQTDH7E8hPz7aJuh9GB5r17jXOq8TtXYg6qP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UTTxliGM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hANMXvjbHOerJR0ZrunIvwIsoJyrpZgeEWu1V0dqpFI=; b=UTTxliGMsTSNwi4gtmFVZRRtCg
	ORyBnl6uSUagSFNHxDD+2sGKKDAM62HLqamg9TrhLICNSDKZ1msIdIpM7sCYVtd9I4b1nn8Q/C9jt
	1Jgkqg2GN0/uM4tBC2kZb3U2X7tbqyfLslXDc1780eQW4I3z4gLyw7990HqpDbLekQ/s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wMmCG-002Xfa-SV; Tue, 12 May 2026 14:26:48 +0200
Date: Tue, 12 May 2026 14:26:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Zhao Dongdong <winter91@foxmail.com>
Cc: davem@davemloft.net, hkallweit1@gmail.com, kuba@kernel.org,
	netdev@vger.kernel.org, Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: Re: [PATCH] net: mdiobus: add mdio_c45_bad_oui_list for
 mdiobus_prevent_c45_scan
Message-ID: <031a1fce-259b-4b1b-95ed-2917a6b81659@lunn.ch>
References: <tencent_F7CCFD2243D4A5BBFDEDEEB978E0E6479405@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F7CCFD2243D4A5BBFDEDEEB978E0E6479405@qq.com>
X-Rspamd-Queue-Id: EEAEF520161
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287116-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[foxmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,kernel.org,vger.kernel.org,kylinos.cn];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 04:25:21PM +0800, Zhao Dongdong wrote:
> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
> 
> Added the mdio_c45_bad_oui_list to facilitate adding more PHYs that
> do not support C45 scanning.
> 
> Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>

Please make this is patch series which adds the PHY you have which is
also broken.

    Andrew

---
pw-bot: cr

