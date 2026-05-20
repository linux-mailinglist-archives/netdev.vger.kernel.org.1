Return-Path: <netdev+bounces-289690-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GJMF9MODWpyswUAu9opvQ
	(envelope-from <netdev+bounces-289690-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:30:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E81FA5868CD
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 03:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0572A300A50C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 01:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D081D7995;
	Wed, 20 May 2026 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfRix236"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F37B25F7A9;
	Wed, 20 May 2026 01:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779240656; cv=none; b=o87czEuVvWOJJoikGH6llelHi8x/J7mELUAfPgmaswWgCPEdYuCdcOM9LYQ9stAB38yyWHsbJ6h6HniO0nzUJrm1IL4YdSjkpB2lDf6hv1x9kQaAPMIrBPv0nNdLMm0mwqpHCwiXg7SUlsyLBqNWJsFSQEe8W7UTzJTONO2Dgus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779240656; c=relaxed/simple;
	bh=fdk6fldGa3mSbr3wmpg1LN6NOJOrGnIiMwQIgQRJGnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhiBK2Ud2iq76shIN2y0ajP1+oZWTe81lEjZNxeqN9vYB4v6G/V60O1CQCLHhMlFkbHYtu0YcDt729ITFOJ3e87y403g1lFS7EggwiQvQyHexA+MjbXHXqO0djBqQ7DG8CKOLF4nudPcoPZrS9cMr2CGv1Jbu9uJmKTf6EZ+Js8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfRix236; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 988D81F000E9;
	Wed, 20 May 2026 01:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779240655;
	bh=osFBENJITvMyse9cT+St7pPUGGiDreFCX5C37rs2Rmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bfRix2365VL3Uv/Po9QFUvufw9dfIe85noe+D4JG0mwnqgtaE/iGx8z9Jt9n/ovxH
	 1R4OM/XgoeE8bSl0LwBJv6OO0OSOrLoz6hockWyj1QAED7Q+mkl+w/1Ooonm7Kmskg
	 VUOppRXKh5xBtKkVZb5OFmNTeKVnhKyiNbgc6BKZjmuIrteUYpaKZqcyFSVestMXFQ
	 667debfvMWdlfCgX6+0OIrMkmMawiMK8GadbnW5M22I3D85zdWI14K0ArSYej2Ues/
	 dCUKW3j/cIKA96RXcnTbBkMAdXt3Jcgp7nItcFs13eGe//3Mz90cretTf6cd0hB/rA
	 RsFRViM70fuBg==
Date: Tue, 19 May 2026 18:30:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Thompson <davthompson@nvidia.com>
Cc: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: lan743x: permit VLAN-tagged packets up to
 configured MTU
Message-ID: <20260519183053.4ba5f3de@kernel.org>
In-Reply-To: <20260515192357.3631802-1-davthompson@nvidia.com>
References: <20260515192357.3631802-1-davthompson@nvidia.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289690-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E81FA5868CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 15 May 2026 19:23:57 +0000 David Thompson wrote:
> The driver must set the MAC_RX.FSE bit before setting MAC_RX.RXEN to allow
> VLAN-tagged frames up to the interface MTU

AFAIU this sentence indicates that the double write 
is intentional but could you make that more explicit?
Maybe mention whether this is based on experience or the AN?

It's going to be invaluable if someone ever sends a "cleanup"
to fold the writes into one..

>  	temp = lan743x_csr_read(adapter, MAC_RX);
> +	temp |= MAC_RX_FSE_;
> +	lan743x_csr_write(adapter, MAC_RX, temp);
>  	lan743x_csr_write(adapter, MAC_RX, temp | MAC_RX_RXEN_);
-- 
pw-bot: cr

