Return-Path: <netdev+bounces-296842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eTpqNlVwJ2oawwIAu9opvQ
	(envelope-from <netdev+bounces-296842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:45:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7129965BBD5
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:45:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BDAXstC8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296842-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296842-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89117302A7F8
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 01:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0202B346A13;
	Tue,  9 Jun 2026 01:44:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FCA33F5A8
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 01:44:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969481; cv=none; b=tmmNpiMUASnHG91OYBpPkDa+dnJJmEhywQSwPmpqhh4pfgQILkk7jc7gmoPdokeI1Vrzlo/CQbhtUVGMa1bLUzS8z4R3lMJLuS2JYlgv6RzsoTCuCONInHHYfT4XAVhKHZMLO2/BAH4rVDXZjE57xDOVHpXHCB40OYuBwoR5hDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969481; c=relaxed/simple;
	bh=so4zAyAo11zuXv4dkBAB3AdA1x58zl3QB+WyfPZ65xM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XncBTYSPATzQ6jehat52+u+/XTMJMzoVPfrQlSih9NALFTv5aUyV02WZrXz+NKzFbfyABAqNgwhXwcvrARJ4+GKT5YNEP+sTUqaTr+IDSy04jwQVSvOo6JSareCZPl0XF05ZWDVhFA6Tje4Y597dsoBlCPqS1hiIKMuY9PeeLyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDAXstC8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5161F00893;
	Tue,  9 Jun 2026 01:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780969480;
	bh=cK2LKA5UTOsu2lvMtMaEowkuUEfI/iDTHt8ieFK57hg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BDAXstC8HfsSknbEL93ubOlVvHM7liv9h5kUVQskAY4SnvYMFgT0gZnbQcx3D6DGd
	 ZiFeDFwtQ8soMu8r40Hs7g8uT1+jktbz+Nk7pCc9WdnC+uFncFRKYgNsARlcWwO0nI
	 I9i6x3WArwYixQPLXE8R/cOoAezfgQ0huhcIEI/PGHtsvA68oWUgEM5YOhqwCWDvCZ
	 JbZs9qaw5GI0U1L4qTvufEqb0LAsAHOZ1V3pjPyyF5McJi/vLblIJOK9DUxj6m5sBY
	 2dnME9qMWIU2gLbP75SV7hsL6Uw2RtYVeQ5RgcgSmRU8laZxE8kpEAfRnFPYiVy1Bj
	 NyxxuC4qISBbg==
Date: Mon, 8 Jun 2026 18:44:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 hkallweit1@gmail.com, maxime.chevallier@bootlin.com, joshwash@google.com,
 tariqt@nvidia.com, alexanderduyck@fb.com, willemb@google.com,
 jacob.e.keller@intel.com, kory.maincent@bootlin.com, sdf.kernel@gmail.com,
 jakub@cloudflare.com, nb@tipi-net.de
Subject: Re: [PATCH net-next v2 00/12] net: ethtool: let ops locked drivers
 run without rtnl_lock
Message-ID: <20260608184439.40e3502b@kernel.org>
In-Reply-To: <20260605002912.3456868-1-kuba@kernel.org>
References: <20260605002912.3456868-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,gmail.com,bootlin.com,nvidia.com,fb.com,intel.com,cloudflare.com,tipi-net.de];
	TAGGED_FROM(0.00)[bounces-296842-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:michael.chan@broadcom.com,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:joshwash@google.com,m:tariqt@nvidia.com,m:alexanderduyck@fb.com,m:willemb@google.com,m:jacob.e.keller@intel.com,m:kory.maincent@bootlin.com,m:sdf.kernel@gmail.com,m:jakub@cloudflare.com,m:nb@tipi-net.de,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[18]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7129965BBD5

On Thu,  4 Jun 2026 17:29:00 -0700 Jakub Kicinski wrote:
> With the ethtool_get_link_ksettings() situation hopefully ironed out
> the previous series (commit 6a5d837f0ce2) let's return to the main
> part of the series.

FWIW I checked Sashiko and all issues are either preexisting or
unreachable.

