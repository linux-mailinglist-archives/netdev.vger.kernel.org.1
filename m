Return-Path: <netdev+bounces-300910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6sv9BlpcOGrhbQcAu9opvQ
	(envelope-from <netdev+bounces-300910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 23:49:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CE66ABA6A
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 23:49:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QCGfnKu+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300910-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300910-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02C7A3009CCD
	for <lists+netdev@lfdr.de>; Sun, 21 Jun 2026 21:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A33272803;
	Sun, 21 Jun 2026 21:49:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CE1234994;
	Sun, 21 Jun 2026 21:49:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078551; cv=none; b=lv1KqXg1ar03hxwCfYaFQNZRcY8NRwkMIiZXZ37dIIqJTe96dhyq4zcIIYjICeST0uB0BZ9QTwLx5mM/vy1pw20vQY8kdwvxvInVpkZlwvA1GL4MAocyuPNDdDqfo68tnzZZGuYkCs7FHpKUOoPR3TK68k4dueyPBUrHccx78cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078551; c=relaxed/simple;
	bh=WIddReOZChlERcVaOaVvebYBg3ZsadYURfVxRnWYHY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZWaaL9qWMJdBPRIUruR2V7zSZ2CkCd5t7d2e10G1xmKv1ZTzkOneXzQqQ6DNzTAS0eToDP+tY1D/368iMuLIxuha5j4s3FLHOefRrdyrW3oBz4lCCrsdbGuHQ5mDpLEUSPmmPTBTBFtBZ1S72bqDBCzM8d6/UWi8M1GWV8S8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCGfnKu+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E021F000E9;
	Sun, 21 Jun 2026 21:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782078549;
	bh=UC/wlLNOwM17JvX56rcj33cHQNR9C3l/TAkqUHzdQvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QCGfnKu+1DSb6/coD3QRvS7fBFRzexCbIM7QE2zttcatDjoVJWsO1krXKITsQar6N
	 Ph78OcvY2NggsO5vgW3xJl/n2pzfNsMD2bw6vSiIVoyZtiSoVP44Q9AQttAc1VXfHI
	 nA+jJ/vYOqywIv2loRaLhHsqxHFRlAJIjK3SSDBCQyv0z/ZDANka9bI5NcsV0T2tC8
	 vrsaAfMaD5SdN6jabcQjriR5anGBIxQi+z7wmQPTvFoy2uldtLZr+WrhQVP0hi1GQc
	 pv5St5H9uA89QCFcIr9DFbWSzx+4/C7Kp56/l4plmSTnbzHzjkCFblaY3S52OI7RU8
	 pRlni6UV1Hx1Q==
Date: Sun, 21 Jun 2026 14:49:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
 <bbhushan2@marvell.com>, <rkannoth@marvell.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [net PATCH v3] octeontx2-af: Validate NIX maximum LFs correctly
Message-ID: <20260621144908.1826b8ed@kernel.org>
In-Reply-To: <1781710853-23420-1-git-send-email-sbhatta@marvell.com>
References: <1781710853-23420-1-git-send-email-sbhatta@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300910-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:gakula@marvell.com,m:bbhushan2@marvell.com,m:rkannoth@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89CE66ABA6A

On Wed, 17 Jun 2026 21:10:53 +0530 Subbaraya Sundeep wrote:
> NIX maximum number of LFs can be set via devlink command
> but that can be done before assigning any LFs to a PF/VF.
> The condition used to check whether any LFs are assigned is
> incorrect. This patch fixes that condition.

Does not apply, please rebase & repost.
-- 
pw-bot: cr

