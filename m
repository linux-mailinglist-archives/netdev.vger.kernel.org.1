Return-Path: <netdev+bounces-270774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C/5K0e8wWm/UwQAu9opvQ
	(envelope-from <netdev+bounces-270774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:18:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 240D22FE2C8
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 23:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 159B0300CCA1
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A44345729;
	Mon, 23 Mar 2026 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d67HOB/S"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0632B3815C5;
	Mon, 23 Mar 2026 22:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774304325; cv=none; b=JvChuysRX9JFqvzLtFvkoiL3O5vQdXXxDXJ8yBArSMaNJhYdkf1b6/ljjY+YB/xkUxx7de5ZsPBtOY+DHUByoVYaCFTCTo9m1GXtjZwYD5YUoBABjUhHep4SEcq/UOFqSw//aQcVsTBV/7cQ/DX82OuQAw2s65Zw9wN/NHQJSHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774304325; c=relaxed/simple;
	bh=TXAN6qfhEdDp+ymhStLlsAYy1NChaJbLVrt+YTIiESE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owI8uo6iuAa3tBmeuyGK3QRveJSr6h6ih9yBwAifvnokROS6A/WCml5zRVR0Tp2RBRaCBRcWFMg2tS7TDZXWu11vrQ9Enf/8Fs6eOzu6uiAI0R+C6JFrGcRt9dJ26WQpMmZ92fnch+Kd6oKaQLgkybPUoQQ7+Qny6ipxAPGPAN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d67HOB/S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h0qLw3uDMbiv6CTLU/5iNVz59YvSWpc0zZbRwGEV7Go=; b=d67HOB/SxyxpTUYFegtDu3Tg8V
	wqccElf0pB/Y825QhxFOKUVQDVTr1gB1bPhaEIF7me2OC1XJQ5+l7qg42Sts9MEVk+0FDGSLkAXxI
	yS4KIf+HpF9OwYKzwJWvcl/Xztx6OiQe2mAs/yasodlOQoxAxnj2+3JQ/5jLPgTutaQU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w4nbc-00D0FP-BH; Mon, 23 Mar 2026 23:18:40 +0100
Date: Mon, 23 Mar 2026 23:18:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	fujita.tomonori@gmail.com, hkallweit1@gmail.com, tmgross@umich.edu,
	ojeda@kernel.org, dakr@kernel.org
Subject: Re: [PATCH 1/4] rust: phy: add read-only device field accessors
Message-ID: <ec1ecea4-2744-4bf2-9003-d13ae7ca8543@lunn.ch>
References: <20260323201925.8405-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323201925.8405-1-iprintercanon@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270774-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,umich.edu,kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 240D22FE2C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:19:22PM +0300, Artem Lytkin wrote:
> Add getter methods for commonly needed PHY device fields:

Hi Artem

Please always include a patch [0/X] which explains the big picture of
the patchset. It will also be used as part of the git merge commit
message.

Please set the Subject line correctly:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

These patches are for net-next.

Every new API needs a user. Please submit this code together with a
PHY driver which actually uses them.

    Andrew

---
pw-bot: cr

