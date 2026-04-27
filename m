Return-Path: <netdev+bounces-281530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH+uDsHp72m+HgEAu9opvQ
	(envelope-from <netdev+bounces-281530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:57:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD35F47BA70
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D4273032CDC
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 22:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064D93AC0F1;
	Mon, 27 Apr 2026 22:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8gJm4GS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B37308F1D
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 22:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777330622; cv=none; b=CRSBtlpTsul1fIDQdCT8rRYrCsHD7oiyWtbmVTIQXByummvUFpTIzb/YWEjNi+fZCmP1EnHsX4hatCd4+6f9G0x3UqH5svN4q0BMRFVGztvwGVWxqpfaYSQ9uKgSKlj1JuquBrlQGIZA0ZkYloTCgnhYAvtrilj4j6iDoRkqVrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777330622; c=relaxed/simple;
	bh=mJlFckTn3CEfwCBeg1MgUufdZ+fSAoKpR5pi4tvRdSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdhktuRxrZQCJ0x7bBa+BRJq4yDzqnLurv0X3E2EG1IdrgYdeGRbFvURvLZ2QFyEMbtaS71DW6grsTK4jxs7WE2lOHJee3LKWIvIzIiVuYfIEO4AtEZemYo3DISYhPGz7Nccp8KTJIS9cnbw59YO7wcDQJbm8c9m9L8a2vRfuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8gJm4GS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD41C19425;
	Mon, 27 Apr 2026 22:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777330622;
	bh=mJlFckTn3CEfwCBeg1MgUufdZ+fSAoKpR5pi4tvRdSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B8gJm4GSmzyu5vRTgGMDCTYugCQyh62FPDhNhLbeey3qYahx1Ueo/KHSjr6vT1xb7
	 MLtM3b79YORjcCFqHBGuFv2TQ8lojYKuNuxBG0CutUdVSKFgsZzBVmd0lPDX3FL0KV
	 okxpxzeTRFeTheY5aRrqitoSlZGO0Ei/w3V4Mdj9uYX2gcw4ZJz5Kk/rXa99kW/5H1
	 GRJqDA9yh0SW+0ASycQ4VvwB2q38Q06j/CEIyYgv58JLqZxZPNWwp8VYtcu1Yn4yil
	 Cq7IubFX/Xmfhey6gtA8iD7iI4+R2qx7qiriYftzh3Dhc6zQhZ7m0vn//rz0Ucgf3j
	 7ZJxKWyVKRimw==
Date: Mon, 27 Apr 2026 15:57:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 milena.olech@intel.com, willemdebruijn.kernel@gmail.com, andrew@lunn.ch,
 vadim.fedorenko@linux.dev, horms@kernel.org
Subject: Re: [PATCH v4 net-next 0/3] Implement PTP support in netdevsim
Message-ID: <20260427155701.6b535f7e@kernel.org>
In-Reply-To: <20260427164727.15418-1-maciek@machnikowski.net>
References: <20260427164727.15418-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BD35F47BA70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,lunn.ch,linux.dev,kernel.org];
	TAGGED_FROM(0.00)[bounces-281530-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 18:47:24 +0200 Maciek Machnikowski wrote:
> This patchset adds support to the PTP HW timestamping emulation in the
> netdevsim. It uses existing binding between netdevsim and ptp_mock
> driver to generate transmit and receive timestamps.
> 
> It also adds the selftest to verify the hw timestamping functionality
> running over netdevsim.

net-next wasn't open yet, when you posted.
Please resubmit in a couple of days.

BTW the patches don't seem to apply.
-- 
pw-bot: defer

