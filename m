Return-Path: <netdev+bounces-301805-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7VVLH7VxPGpXoAgAu9opvQ
	(envelope-from <netdev+bounces-301805-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:09:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E466C1F0F
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 02:09:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MpSBA7rI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301805-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301805-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9B47303EC30
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 00:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6777080D;
	Thu, 25 Jun 2026 00:09:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FA61EA65;
	Thu, 25 Jun 2026 00:09:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346160; cv=none; b=BZaOwR17/B2luf/Jq3/XJk851aI5dpRgeYYG8nfsDaeW8VGZ+IdOdqG8c48cL4/S+unfLG0rJakCErf5YeWE7Ae/0l2Ji5g5CspSZc2VWOJbAPDQdx58/9mw4wxQZGzVQ8/vsuqSbOknOO56i9kkc0HpEOa8e9AHAdPnjy7V9BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346160; c=relaxed/simple;
	bh=EQz2XCBwRS8uLK6XBV7zSGPH2BY3UI9xhwr0H8YcNTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMCZTrzu8Hg9/Mg77ZjOFBIKJegHqJmOjGFXXHz3Z9/wn03GXs+Za4OaC90mUzKUsXh568ziZwEG2NJ/bWxc+6YBMRToxvBXy2s8vaV91geS7cK9SjT93d3j4V1epfCocwds5NKJmkyXpbxdgZi0Gr7WKMt033BbY3VK8WY3VI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpSBA7rI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78491F000E9;
	Thu, 25 Jun 2026 00:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782346159;
	bh=EQz2XCBwRS8uLK6XBV7zSGPH2BY3UI9xhwr0H8YcNTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MpSBA7rI/ESXhoj9CFf1wpUgC6YJUA7qMDqhbRyBPAuDBK9Ia03yaI2I6ew/dbqJu
	 sss2bjJYZ3xFjU7SUn10PhUlBSTCkC3jZ+5d8+XWPcf0b0mTJ8YetSCIuQnV/4JhP8
	 P8IplKPYma/WqSQ3oTuKqFKsjQsjK4+ixeCCY7rVMaojpukWcsBA3hX2ffZ6pqF/TX
	 TQdn+BW6ED5QjuxjNwGZqtBFZ9TseAmoE+282nKTfiTlpipVnSkH6rqv9FJiNDXNaS
	 va5qPjm+KN3jX0XhZ+Py1CCPxU6lBx38jGoqyzWCGEln8G9SIirWiLNhXKj8/UXz2q
	 l6X96M/sVO7kA==
Date: Wed, 24 Jun 2026 17:09:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jack Wu via B4 Relay <devnull+jackbb_wu.compal.com@kernel.org>
Cc: jackbb_wu@compal.com, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>,
 Shi-Wei Yeh <shi-wei.yeh@mediatek.com>, Minano Tseng
 <Minano.tseng@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/7] net: wwan: t9xx: Add MediaTek T9XX WWAN driver
Message-ID: <20260624170917.09967c74@kernel.org>
In-Reply-To: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
References: <20260624-t9xx_driver_v1-v3-0-73ff03f60c48@compal.com>
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
	TAGGED_FROM(0.00)[bounces-301805-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:devnull+jackbb_wu.compal.com@kernel.org,m:jackbb_wu@compal.com,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:wen-zhi.huang@mediatek.com,m:shi-wei.yeh@mediatek.com,m:Minano.tseng@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-doc@vger.kernel.org,m:devnull@kernel.org,m:ryazanovsa@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[compal.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,redhat.com,mediatek.com,collabora.com,kernel.org,lwn.net,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,jackbb_wu.compal.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18E466C1F0F

On Wed, 24 Jun 2026 18:04:06 +0800 Jack Wu via B4 Relay wrote:
> T9XX is the PCIe host device driver for MediaTek's
> t900 modem. The driver uses the WWAN framework
> infrastructure to create the following control ports
> and network interfaces for data transactions.

Replying after a long delay and then immediately posting a new version
of patches is very bad. Don't bother replying and just put the comments
you had in the changelog of the new posting. Otherwise the discussion
may get split.

