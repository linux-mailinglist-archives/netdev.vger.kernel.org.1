Return-Path: <netdev+bounces-299712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZgRRLPOvMGr+WAUAu9opvQ
	(envelope-from <netdev+bounces-299712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:07:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3301D68B657
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:07:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lXqksULJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299712-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299712-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66DC8303FFEF
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE05038D014;
	Tue, 16 Jun 2026 02:07:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BFB37B3E4;
	Tue, 16 Jun 2026 02:07:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781575664; cv=none; b=nFudACp4dkWIpQ3tHTrxKrnUFqbt/hDaH8DRn3iDFCqh5kFJ95go2S6SJ9x/8M0Ey5XpCu0RXRV7F0xJKIAAnw9IrneF/ihmjb9bTtji3LmZ3wZrFOzlh3yhvMZn9qpLj9LhQjxlwn29z7wLKDHplC07hQKAsIeUnqla/eDme5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781575664; c=relaxed/simple;
	bh=4JZKTxT7crBfVrB16b0OPjyYkMILNzEfJCNL/U2s164=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kjdo6ootcNAq99rQXEKUAU9rbIxCs+Wv0h7yvyo1kUIJGxEiJ6Y+LSHpS2EytsVMNAeZuDG3D5WCOk08m9meuEASRvQ4rJGXCYC7kSGPbA4XqUDsA2vFtkU4g+pCewA+Km9dPBulfY2+k1/xCoSnH1TzlYXaSvHSOSh/ZKWphHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lXqksULJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307D81F000E9;
	Tue, 16 Jun 2026 02:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781575663;
	bh=4JZKTxT7crBfVrB16b0OPjyYkMILNzEfJCNL/U2s164=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lXqksULJktIqCM6T02VhI+nelZ2rfCf3toSqfnzsCyCq/lJzkQtKC0CxaR+hTlJ+U
	 HbwCaSmweB3bsmIoFQXFHp0t9c6vs81sb6e/2bYHkKv2aQDFk7FoX2YXTIv+RhhKd8
	 WMiAcUy3Dm52/b6PcbMHcPvZF1bh6+CbHH4Vp+r92HUBOEWBYK0rJKlAWHdPLptFLP
	 7PO5fE9ogQQd0ErJZ+SAhOdrT2kECeOf0zGyMw8WwU5Y9ec7gIal5h+vWB0Mg4TbIT
	 HdGBmE4WGJGhTb0uE4gWRwQPDr/w6haGdHaqwrW2sr12ajy/bDCmZX4+6zL7mUfJT6
	 b9cysonDwstDg==
Date: Mon, 15 Jun 2026 19:07:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <daniel@makrotopia.org>,
 <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v5 0/4] Add support for RTL8261C_CG
Message-ID: <20260615190742.5b9313c5@kernel.org>
In-Reply-To: <20260615090817.429-1-javen_xu@realsil.com.cn>
References: <20260615090817.429-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299712-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,realsil.com.cn,tipi-net.de,vger.kernel.org,makrotopia.org,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3301D68B657

On Mon, 15 Jun 2026 17:08:12 +0800 javen wrote:
> Add support for RTL8261C_CG and add support for loading firmware.

Looks like AI will have some comments on this series.
Not sure if all of them have already been discussed so let's revisit
this after the merge window.

