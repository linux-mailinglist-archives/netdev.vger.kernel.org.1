Return-Path: <netdev+bounces-258098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIQVDTtEi2mfRwAAu9opvQ
	(envelope-from <netdev+bounces-258098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:44:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9407611C059
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DE983035ABA
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD8F3803C2;
	Tue, 10 Feb 2026 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjt1UIej"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA65F36D507;
	Tue, 10 Feb 2026 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734548; cv=none; b=XzHQPaiB5Wd1UDXrqoPfZOYUlUF05Nb8Cax1/wf3Mn9DA70M/eqrX0C48QXd9RcU6G/ZsEs8zhvwd0/LRvW2cfXgWWKws5lXk8fBq/K0PZdSmw15BuKJzArVSe/04o+Ufd+mjNu8gXH+q0Ed5GEi3ZwxJhX+fkS7jyqypSCJxcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734548; c=relaxed/simple;
	bh=yM/bjYfFNzPrVO4q9VIT94RYW50ufxq/T9tLZnoCdoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebycIADKmThK2y/qJNyI6RtlEHd7KiiH1yutP2YzPu64LQKr7HvfPntR7NezVaUxQ54Ml9XXOoP+Ou8pY3rUBJv+XgVv2g/CtOIXWrq5vaphdRFDW7ljJ5AiKOw0xa+86QueD5Uc8KwN8nYsWSpCdNtUAshE42yL9eEVL0P2VTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjt1UIej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037FDC116C6;
	Tue, 10 Feb 2026 14:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770734548;
	bh=yM/bjYfFNzPrVO4q9VIT94RYW50ufxq/T9tLZnoCdoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jjt1UIejBrQqV3lkIc8M8d1nfyWEUPXVU4TadpTPwUANdLCWhrutXdNXFDLzSty5I
	 Fp16bU4jVICTxlH8mVmHiAiziX8mAdLxbbAYw5IA8k3SKii8EnB1gw/V0jvwt+IaX2
	 9IZv881xv+5ctao/wIHMnlKTxkrFE6TH4c0o53F09/HgHMxZR+Np5CRzkkH6Ahpqde
	 zE2c5043DZXKs2dOlwYV6M1Z+9L5TQu8aypwwNcVasrjpqNmoVjwQ8uzazPKDzikxR
	 qO1seRRxo+1Z8mNmkL+BYQ653+EZGc77QkwQDnRcTx1jNmaAiYWnqo8TRzGro/jC+P
	 1dqwJkH9VPlJg==
Date: Tue, 10 Feb 2026 08:42:27 -0600
From: Rob Herring <robh@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Teresa Remmet <t.remmet@phytec.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, upstream@lists.phytec.de,
	Yannic Moog <y.moog@phytec.de>, Benjamin Hahn <b.hahn@phytec.de>,
	Yashwanth Varakala <y.varakala@phytec.de>,
	Jan Remmet <j.remmet@phytec.de>
Subject: Re: [PATCH 0/2] net: phy: dp83867: add numeric impedance DT property
Message-ID: <20260210144227.GA2675838-robh@kernel.org>
References: <20260129-wip-t-remmet-phytec-de-bspimx95-132_upstream-v1-0-8deccd658d16@phytec.de>
 <b7b8f855-bf38-41ba-96c4-1bdc3a1c2cc8@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7b8f855-bf38-41ba-96c4-1bdc3a1c2cc8@ti.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-258098-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[phytec.de,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,lists.phytec.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9407611C059
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:31:29AM -0600, Andrew Davis wrote:
> On 1/29/26 8:13 AM, Teresa Remmet wrote:
> > Introduce a new way to set the output impedance over device tree.
> > So far it is possible to pass the value either over an nvmem
> > cell or to set the min and max booleans over device tree.
> > 
> 
> We have a similar issue in our networking driver, we can either get
> the MAC address though a NVMEM cell, or when that is unavailable use
> fallback to using a hardcoded value in DT.
> 
> I wonder if it would make sense to add a new type of NVMEM cell that
> encodes the content of the cell in DT itself..

I don't think DT should be providing fake nvmem...

The firmware/bootloader could read nvmem and always populate the DT MAC 
address property.

Or Linux can provide a single API that reads from different sources.

Rob

