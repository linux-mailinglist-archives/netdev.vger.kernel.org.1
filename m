Return-Path: <netdev+bounces-299408-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9H3TBmDjL2oUIgUAu9opvQ
	(envelope-from <netdev+bounces-299408-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:34:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6503D685C29
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 13:34:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=gufDbY83;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299408-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299408-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDC94302712C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C023E3C49;
	Mon, 15 Jun 2026 11:34:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D86379964;
	Mon, 15 Jun 2026 11:34:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781523292; cv=none; b=TnuHDKtX5//7ZHYsH5lXvAjuDePYlw0iDltKvyF4xGOSnz99xfm6iYL05aLbmW+n5abEU3MFXngqqIhsAOMLtSrZCc4UyH6d9dQdovAuDp1q+IjRYsUnnWs/tDaXCH9WEsrA9yqxtngNrZd9xJuxRuylZ2nKdHu9mLapW5tWi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781523292; c=relaxed/simple;
	bh=CCf4Lsv/KZfmAydYSbK56SSDoxFvAX4Rmljmcxd+XOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zkz+4WGr5l/NVuVkRVZ3pfuF8H6zJweuJPrVQpH51M+dg/2siO87xGlz7YvikmimBmj5XI9hVej/MdTSEVJI0IO1OXwMQ4bmQm2ysTPTXjM7G4Zfdlfqb6IltYNlaAfIIRkGZXwnH+OWXr6FLsU8NawBQ1OPwZsnlzGg+QPfMfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gufDbY83; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MMpI+QUdBgNaQ8BRTEv9IJWFS9jCGGOTP7odTlRuEhQ=; b=gufDbY83IvZnXSgYcf0E2czW+P
	CEHXRHE/R+8xbQ1jf1Iu0LJiZgU9qGwj0ylp88KWzAIeMmghE3WpStZyz6k6yDgezmybSvbC/WTiO
	lbFJjzl3O9y0PsPG1v8oWpQFze/3TCz1SmCW4b2beVpPBm3ehXfC2db2vHPGsDEDlMOA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wZ5aT-007n2z-9k; Mon, 15 Jun 2026 13:34:41 +0200
Date: Mon, 15 Jun 2026 13:34:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: mmyangfl@gmail.com, olteanv@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	de.ge@motor-comm.com
Subject: Re: [RESEND PATCH v1] net: dsa: motorcomm: add yt92xx dsa driver
Message-ID: <3f7bf73b-c8dc-451d-981f-5e5343291960@lunn.ch>
References: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615111235.3544282-1-kyle.switch@motor-comm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299408-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kyle.switch@motor-comm.com,m:mmyangfl@gmail.com,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ming.xu@motor-comm.com,m:xiaolin.xu@motor-comm.com,m:jianmin.wang@motor-comm.com,m:de.ge@motor-comm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,motor-comm.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6503D685C29

On Mon, Jun 15, 2026 at 07:12:35PM +0800, Kyle Switch wrote:
> Add yt92xx dsa driver supports yt921x and yt922x switch series.
> To support more switch series in the future (e.g., yt923x), the most common configurations are abstracted into switch operation interfaces, due to yt921x and yt922x share similar register layouts and operational logic.
> 
> - Merge drivers/net/dsa/yt921x.c and the new yt922x support into a
>   unified yt92xx.c driver.
> 
> - Add support for yt922x, which can operate with either 4 bytes or
>   8 bytes DSA tag.
> 
> - Not change yt921x behaviour but use common switch apis

A 35K line patch is way too big. Please break this up into lots of
small patches, each with good commit messages, which are obviously
correct.

    Andrew

---
pw-bot: cr

