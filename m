Return-Path: <netdev+bounces-305458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4P6xNen/TGoUtQEAu9opvQ
	(envelope-from <netdev+bounces-305458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:32:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0A271BF22
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 15:32:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GCDpl3dn;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305458-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305458-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA92A30A55EF
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DB7414DD3;
	Tue,  7 Jul 2026 13:14:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606343F44DE
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 13:14:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430073; cv=none; b=vGLe2aXaP39iUKG30ZDWHNHdkHWC90AOe5YLBMhfsmrN6Xp4XS7Rne+U7G0iFmA6KakgaeFxRmfYs07qgUGwo5MdVdgAeizDQFqM6Q0MxdCGZM2kGMNAyi36gqb597Toye+qaaXDGCTYzSz4xkl883nXizqRo940LO4YWPfjjP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430073; c=relaxed/simple;
	bh=AJ1PH1Xl+0nzIKpP87Fk4UVnIeFYKA9xfQ6Aog5PeTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrVeYedsMeqIu9vhtnGMul7Ecx4ElPJ96mT49rX9J5SSgyiwWYSe5fGnVyTTxxScVxZiIijCS96en1r6G3aaJPWeu1r4MRbpjmR3B9Z4j6pkkhdTEcY6FGAXUFNqGzqG0P0KQPWMrjIocTDvXVjpDN1dGvSanizNLoyoUSTMJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCDpl3dn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1474F1F000E9;
	Tue,  7 Jul 2026 13:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783430071;
	bh=gy5f1rBuEP4haLiJZu59Q3d5AY2Hnz80qE4DOJ24g3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GCDpl3dn5MdgX4OeFnhOET9KfX0HgmUZta/LwGXG7Q4e9TmgBILIN8ZvO/XvtPIJ5
	 gcJR9BzsErQE0+3BxV28NNkoEOkc7Z27GkArLqoigSQ7wTRYlsHrhxsgpo7CWLVEGt
	 7ccVTQfYZnyYy8Bn8PMoTxmhoH1kdrpJfqAazpJjb/wb0CzvSxW1TJ6cr+jqWsPL5r
	 4jSkXNB2KGLuPWAswfVs0fpdihWEqRUEcw2Y+h+6azXv0lIrATmqlExBRA91+uvnWT
	 GqMuc89rvBUNG3upyiyvTNUiD5GVcFZqHZiS0Rm704k/1E6m98hCb3W4WQwxl7JFEn
	 0aeV25Nnoo5+Q==
Date: Tue, 7 Jul 2026 14:14:27 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-net v1] ice: use global queue index in TC to-queue
 offload
Message-ID: <20260707131427.GE1364329@horms.kernel.org>
References: <20260629091203.36482-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629091203.36482-1-michal.swiatkowski@linux.intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305458-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:michal.swiatkowski@linux.intel.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:aleksandr.loktionov@intel.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D0A271BF22

On Mon, Jun 29, 2026 at 11:12:03AM +0200, Michal Swiatkowski wrote:
> Previously index within PF was used, which caused rules to fail on any PF
> other than PF0.
> 
> Switch to global queue index by adding first RX queue id from caps.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Fixes: 143b86f346c7 ("ice: Enable RX queue selection using skbedit action")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


