Return-Path: <netdev+bounces-284373-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLpbJxbn+Wl1FAMAu9opvQ
	(envelope-from <netdev+bounces-284373-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:48:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA04CDE38
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A69AA301F356
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807B842B74B;
	Tue,  5 May 2026 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w2PYEaL9"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A842B75A;
	Tue,  5 May 2026 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984991; cv=none; b=mxy2E5GaR55jfkFtz/+fIIncxB+RCPAjxa5NYfMK9S667wqY1zXpML2qAx17BnY8qrxgJBbf2QOd4PEORUehsqSO8k3sifEvH20qEeitTEE9sTg+Zn/gIWZ1YnD0FLyRzS5IePcDnxRx1Vk5+YfAQFDs9a+ZvEaA2KrV05cTyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984991; c=relaxed/simple;
	bh=4JJUcxwtYOrFHVzJKTqiChj5J6VZoMXekUm3MDGptv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyvSFl3fevkbAlXBIcsPGySa2vjrXQumBpOxz/H+NlxGNxuXvS+FYpdwajfXCRfoxcjdyl5Se5F1/HN3AhGHvG4+UCdjGWy7wrnttGbEbJD40F7grudLX8eO16479mqPfDQCBdVlU2ZXwVF7NVPGxPdBqCMYuU9KWeGed09FcdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w2PYEaL9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NIy8pE8jBgSGFZN/xDRHGpTV/4Ex9tWgIJn+y/jBZ84=; b=w2PYEaL9xQU9moZKYTFC3A069k
	2dvm4XTQIaRGI+2wywno4k9ImtDaf2lHAnT/UitjZELUh161/Yj+7GXkQ5oYbjoCcO4CfWsABL1eJ
	lFMa5UMrzy5j0+H3TKB9sFJP/e+su/Bc4vPdqJOTuIoKP2z4MiuwgYmDYPIHjYV5/uzc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKF7B-001SU3-VP; Tue, 05 May 2026 14:43:05 +0200
Date: Tue, 5 May 2026 14:43:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	horms@kernel.org, pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v2] rtase: Fix flow control configuration
Message-ID: <889e8dd8-ce1e-4abd-98e5-2801ed134a7d@lunn.ch>
References: <20260505064121.31286-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505064121.31286-1-justinlai0215@realtek.com>
X-Rspamd-Queue-Id: 6DDA04CDE38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284373-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,lunn.ch:dkim,lunn.ch:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 02:41:21PM +0800, Justin Lai wrote:
> The hardware has two sets of registers controlling TX/RX flow control.
> The effective flow control state is determined by the logical OR of
> these two sets of bits.

Odd design.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
	

