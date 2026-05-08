Return-Path: <netdev+bounces-285719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKqZNVed/WmwgQAAu9opvQ
	(envelope-from <netdev+bounces-285719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 10:22:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BE14F3A7A
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 10:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A5491300C7DC
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 08:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2B6379EEF;
	Fri,  8 May 2026 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="d1CCSWpL"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C61B37646C;
	Fri,  8 May 2026 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228522; cv=none; b=OF+QDPfPGOkX3voOrW67fh2kgqtvUTpPMVHFVT28k3oTvW0pMIiT50OHs08Q6adHtri9xkwk56ClBYxrIvwYw/zgYCsKBYEF/+m1YAqGsuH2c+JF7CBBag//HpWJCEG3Hq+Kx77mAkvxi1NMfSfDoPtuIoktuyPu/TRkkaXipXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228522; c=relaxed/simple;
	bh=W/3i5IgROieDGTw4duXJbvG0nVeExFifY5xRF4Pt1xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5FKfATmqWjl5RGsVjrRf+ARA/BmHNC9hq11tl1pDPFDnW7a7u5nU1Vx8YTbMZX0i66JeDjmAFLe9VtATV94Qg48cLSoTPpwCR7MKIiA21kf1zGOFUzivtlLkJrTbqzZIdcuC+Rx0Frr2Fs1PvPUbPPz7p90pHXFp6T9VRc7nGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=d1CCSWpL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W/3i5IgROieDGTw4duXJbvG0nVeExFifY5xRF4Pt1xk=; b=d1CCSWpL2zFCoyfFYTGWPExBE3
	bbQIDchyC+W1yuxArZMK/5ubbhDCdyXWoz2yjiuq4qVRUUIZcw/YLiiRDgRRD6bb5+KQ4U1YR8KT6
	69TKmP80GN9YXlvQdsHloEb6ZB+Ej8/zMLTQxI8rvqiN8XeeQ0pnX84EA1SoFDRHvLQ1zdR6G/eNp
	4cUDFt8Y3kNxILelxl0WxbMVLx9TrXNfS9+GOJo30Q3scml4LerY47w1K3hyZNmLm0PSFGVwLUWMk
	VB1600wYEY3WnmR8RDnDvyW0WjiEgG5ooM7BJ/r4lUGMIMcjE2gRWFTW3xOW05DNmZ0y4xOm4c6JM
	nMHRTQhw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLGSj-0050s6-2x;
	Fri, 08 May 2026 08:21:34 +0000
Date: Fri, 8 May 2026 01:21:28 -0700
From: Breno Leitao <leitao@debian.org>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, 
	Matt Johnston <matt@codeconstruct.com.au>, Martin Schiller <ms@dev.tdt.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 1/5] mctp: convert to getsockopt_iter
Message-ID: <af2ceIWaM4K6vDNS@gmail.com>
References: <20260507-getsock_two-v2-0-5873111d9c12@debian.org>
 <20260507-getsock_two-v2-1-5873111d9c12@debian.org>
 <9b8f8cbd-9b94-47f0-a4af-713060d9aef1@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b8f8cbd-9b94-47f0-a4af-713060d9aef1@amperemail.onmicrosoft.com>
X-Debian-User: leitao
X-Rspamd-Queue-Id: D6BE14F3A7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285719-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello Adam,

On Thu, May 07, 2026 at 04:10:36PM -0400, Adam Young wrote:
> Why is this 1/5 and where are the other 4?

The entire series was sent as one submission, and I've verified that all
recipients received the complete patchset. Did you not receive the other
patches?

You can find the full patchset here on lore:
https://lore.kernel.org/all/20260507-getsock_two-v2-0-5873111d9c12@debian.org/

