Return-Path: <netdev+bounces-299527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Cw/ZIGckMGonOwUAu9opvQ
	(envelope-from <netdev+bounces-299527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:12:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 144D96882B6
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:12:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DxmLKqCQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299527-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299527-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 36E9830C8974
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6576D408033;
	Mon, 15 Jun 2026 16:07:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7128D408020
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 16:07:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539639; cv=none; b=khJfb0frPEHaUdx85vRq8Z+S/BmYN41XGvb7R0aNz0xujVrpkf5daKZK7ulWzlcU2vNqyWD7QuzJ05E6UimodwH9/y8V+/r5LEdnzb7DZTfhZVF2jbxf7FOuBV2OxuLFJffPuBnxEr9M05w2b9ET+bDPikxJ0MrLstNN1F24nJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539639; c=relaxed/simple;
	bh=ARVJgllKDAfCGQcqC79U5S6w/TGFl61Cpk3aif7gY7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FM/dbCTODzpmS1tsutwYfhwfdEYpPTruvFYxNPFjVQGz2yIQnsHPQEXmfT1yPcXX6rwhQvlabTx+X7fzWrDZORduUc41gKR5krHExMJr0USarhbbUydOJnKaRgqjH3lRX1OEAQN3XbX7OkOSD9JjMaSCRZ8gMQKKVOQdJukDMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxmLKqCQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CD01F000E9;
	Mon, 15 Jun 2026 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781539638;
	bh=qqlI/1HrvbOTcVtHla0mZN8srz7IMjrDYh+TSI8WFoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DxmLKqCQL2qZSLhRKyH6YVy0X0JzGZQ0dSDy3si70S6INgM8//NeveOLZb2JHcAG9
	 0eMpw+EaiimzOyK1eMo7Ij/9CCZf63Non8FOx154yjZ5nIFFyYEdetz2ntezeJIXb0
	 qdMPTtX/ZpGj0aVs+JyL+tzVFNKxmtthAETb82CjQY5oHLmnr8VcnRVX5bAs5rsuJe
	 qOgRBDoLHxQ1yuWYZyP70I4jd3zpyoD6TXSuXsFVtUfO9m0qCt//snYICqArJ7jbo/
	 mK6QPPwL7QLQ6JD1XxsfX7FteKH5dXW4686xeshK17IbXRBV9py8kEcAmmvgFTdaEq
	 HGLP1zi2gIhXQ==
Date: Mon, 15 Jun 2026 09:07:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, horms@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v5 0/3] net: libwx: improve VF ethtool support
Message-ID: <20260615090717.39977005@kernel.org>
In-Reply-To: <20260615104849.60444-1-mengyuanlou@net-swift.com>
References: <20260615104849.60444-1-mengyuanlou@net-swift.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mengyuanlou@net-swift.com,m:netdev@vger.kernel.org,m:jiawenwu@trustnetic.com,m:duanqiangwen@net-swift.com,m:horms@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-299527-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 144D96882B6

On Mon, 15 Jun 2026 18:48:46 +0800 Mengyuan Lou wrote:
> This series improves ethtool support for Wangxun VF drivers
> (ngbevf and txgbevf) in libwx.

net-next is closed, please repost after the merge window
-- 
pw-bot: cr

