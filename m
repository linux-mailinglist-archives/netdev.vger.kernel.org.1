Return-Path: <netdev+bounces-281543-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AB3rGpXw72nYMgEAu9opvQ
	(envelope-from <netdev+bounces-281543-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:26:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABF747BD17
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4055B300A320
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FFE3B3BE4;
	Mon, 27 Apr 2026 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGLrQA1z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2F8264A97;
	Mon, 27 Apr 2026 23:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777332369; cv=none; b=Iq/iNaei9qDvuT8+e1ZGR51xnTkbRWb+XNY/8QWMJwt2WkNJYGyF7/gamWuj8uV3lpy0Yzky0eQP23+Q4//60JMqDpIasZKHIaYi78pGaCkiYMEY9cnHXPL0lCRiqfgrc3WM6gcBydADIFTr12DHK+nTViPT3bQBVE7Yncp4M6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777332369; c=relaxed/simple;
	bh=NCjVlyMEkbMZCsORLvwsyvrNExMeYxUE9LRyioSGo+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6E4S6SAG9Z855VeCyzqS8qJoB58kXKjJmhGFiXNsaBTcEziLrF2RWbKRqi4gQQsekIcnBvgk0xCjfNaWcRBJROuaHBmjjiiJectjI+MHt10+VkSqhSqCX9JdnO7bGH59KUQskIJyrIQsDJyz5UE4baDWCTA7zrXkOgv61WSHsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGLrQA1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44570C19425;
	Mon, 27 Apr 2026 23:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777332368;
	bh=NCjVlyMEkbMZCsORLvwsyvrNExMeYxUE9LRyioSGo+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nGLrQA1zuhEAknR9FBh4E81srj7ewPenQqRFkRuBfWZrRXrivEBMNUnkJ1Q84+64h
	 bQmdGGl9XAXG3AELJEuqIgJTOd2WiBkl9/dbjZYXEUlOxenDUhCWkNPo6th6VAw0LP
	 1L9mK51zk6dfq4Djvxs3Ce1eRDHSCEMcHwGWeKDhyO2r8daBYv5+cTNaVKPaLGUxBE
	 nuNords68Zvy4lO7lcEeC4QnTiNAL2yj71k9Z6Z04en6xIlIy1dWlr33XqeP4L/zo/
	 jZKAcoaPs62R0lTkKZbng7mm+dFVrMUxiA818k6f5wFeXJK/7MYRcog/GR1X7t6PeX
	 hHsa/go+PPJ/w==
Date: Mon, 27 Apr 2026 16:26:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 daniel@makrotopia.org, vladimir.oltean@nxp.com, michael@fossekall.de,
 ih@simonwunderlich.de, rmk+kernel@armlinux.org.uk, marek.vasut@mailbox.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: replace magic number with
 register bit macros
Message-ID: <20260427162607.6df44090@kernel.org>
In-Reply-To: <20260426222359.3443278-1-olek2@wp.pl>
References: <20260426222359.3443278-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1ABF747BD17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281543-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,makrotopia.org,nxp.com,fossekall.de,simonwunderlich.de,mailbox.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 00:23:44 +0200 Aleksander Jan Bajkowski wrote:
> Replace magic number with register bit macros. The description of the
> RTL8211B interrupt register is obtained from the datasheet.

net-next wasn't open yet, when you posted.
Please resubmit in a couple of days.
-- 
pw-bot: defer

