Return-Path: <netdev+bounces-292904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jb6NHiLfGGrZoQgAu9opvQ
	(envelope-from <netdev+bounces-292904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:34:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F23BA5FBB7C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 02:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85723303980E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC403033CB;
	Fri, 29 May 2026 00:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlqgaF7o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9738B1D555
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 00:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780014877; cv=none; b=ff8Y1nOZ3EFdDiKoWpjn7Oj649unmTfoSlMQRGNDUn72lUFgWQly+d4iBmk7WhpovWC5Ui3Ic2TvnuwwT9T7XNLPRJXyPhcD1L+Zi2TPVpqN2wW6xUoI04Wny3MY1orsmWEoFJ9b7tk0P+40/qtxMUctbDWrpn1mnjNhWsXwJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780014877; c=relaxed/simple;
	bh=3AGvvGJWGE5/1vSsufGlFRVtFH4MMFnTgZHt6bDZxNo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tb93hO6eiYYQsaDLbR4QjtCIiOiyT0DfLlrVytft/0K+RdywQMoyLpx8b7kwPlCVvbWoLmyVTFAXZ3jVpuj3E7B5sy1NMHJp+HSF80DapSnMynuKmmsvHkqdUq/S28JfbpN/l+Gedemu9/jVMZMgs/UBBvXfB7snuRsK8rCnN84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlqgaF7o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE39E1F000E9;
	Fri, 29 May 2026 00:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780014876;
	bh=DpRa+QjLl/oFskbQacV31ahCuLQUaaTVZrmLFhF6WN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WlqgaF7oIelH7Z2mkPReysbCx58NmZeJiQ1KGHExktBIoGSYHyHm396BJGlVvCWLa
	 +kTBIrryZzb1vp2XbKxcgUnMqVqlrLwxZB8b9zDp9aKJ/dDy8tE00lVfzNOk148UL7
	 byHAqp2my3LoOSmNF/uATQ1TocTyRo7hpIlMUwrybCr1IskYF/NqBtujf+51paXdic
	 j1LJlgG1bJAlgB52zpj3ZT1PADGLgyqc9DNXeKo0i27iKtAT2dGDSMTWDjVC77Ni8T
	 pQ0qmU7y2qkde20jFbeuQI5EEEBumGbL/kD61jebpHV1pDPh6UFYsiI4gkgNrkJyj9
	 tnrrujZjRKHKQ==
Date: Thu, 28 May 2026 17:34:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] doc/netlink: rt-link: fix binary attributes
 marked as strings
Message-ID: <20260528173435.368d8267@kernel.org>
In-Reply-To: <20260526230321.594068-1-one-d-wide@protonmail.com>
References: <20260526230321.594068-1-one-d-wide@protonmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292904-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[protonmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F23BA5FBB7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 23:04:56 +0000 Remy D. Farley wrote:
> These link-attrs attributes were previously marked as strings:
> 
> - wireless - struct iw_event
> - protinfo - a nest of ifla6-attrs or linkinfo-brport-attrs
> - cost, priority - unused

>        -
>          name: cost
> -        type: string
> +        type: binary

	type: unused

is a thing, should we use it instead of binary?
IIRC it's expected to never exist in messages but to still output 
an entry into uAPI, which I think matches the situation here.

Sorry, should have looked closer at v1.

