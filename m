Return-Path: <netdev+bounces-280578-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL48ABOI6WnccQIAu9opvQ
	(envelope-from <netdev+bounces-280578-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:46:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2C744C59E
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E7213055837
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 02:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EFA3BADBD;
	Thu, 23 Apr 2026 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epxMGkaK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344363A7F61;
	Thu, 23 Apr 2026 02:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776912278; cv=none; b=CaVrTLGVyyVdu6ISwZCONw8aaho7/DKR2vRWdPBosnWghmjQosL2IfKr4XnQalLnnkAjOMCczlw45naGAINfjGTTxZ6Gme+yilK45+v34aZOWmnK+Qg2Mvvl6G0s0GzEIhXWf0047PTnU2BM7Y25bTlJFzgAwt+Qe53chzd9ewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776912278; c=relaxed/simple;
	bh=X6TikhqBuKL3LHIiQZRafoGq2I9En0G3QhQRU26UtH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=chWr0JfMDg/Ukd2Zy4Q1GrKEKVWZFL798jGLdWrR3gcmoH2jWTQMHUF9XQeP3hQnylJkDAT/QMG5q1rjKmJP4HvWuTCPV2RchJ90Eg4z4iSfI8dCCR39Oxc7hroE9GAUc3SOFQ49x9ekkGhzEqBXm+I7LQFq+pJmYC//NIE4Plw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epxMGkaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47767C19425;
	Thu, 23 Apr 2026 02:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776912277;
	bh=X6TikhqBuKL3LHIiQZRafoGq2I9En0G3QhQRU26UtH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=epxMGkaKD1KnvCAr2uEOuBEj+WyuNFq0Wu9fnVwxD/v8fyI7XMVuBUG9Ly/lrBw7C
	 t45vL0AL1p0dYdWBbH2eL+/+BzkR73njaBnWpJ/YsO7YTqZgRu3bYD3nlGIt1UbQ0K
	 n9mlmbo/vUIJiFA33OaDnsli6H2kSA8tdp2DsPeAVRDZmwh3MvR7mZRdgG4JB0JZc5
	 gEBLEDJ5ynMTgW6DUl6H8RzCJlx79EyhuFwqA5JPyciMDmzrEQJ5k4XwEzjjhpjdAx
	 Ws60RlIc+WjvpC6bqnDitefmygd1EICWH9XAr4RWb3MdASv9izrLmjqyQdOi2VcVc9
	 Rjl7GPzjzaEXw==
Date: Wed, 22 Apr 2026 19:44:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Palmer <daniel@0x0f.com>
Cc: David Laight <david.laight.linux@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet
 drivers
Message-ID: <20260422194436.7e1e6ce0@kernel.org>
In-Reply-To: <CAFr9PXnuyb0jTAhRgJGRmdzUMxP-0HrHHHN3YpQnOn8-nBBC1g@mail.gmail.com>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch>
	<CAFr9PXn1ixyhD42OswoyGZ=W-O-oZygUGpRNm2dcAuYBNgtmQw@mail.gmail.com>
	<20260422101316.0efdcf24@pumpkin>
	<CAFr9PXnuyb0jTAhRgJGRmdzUMxP-0HrHHHN3YpQnOn8-nBBC1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280578-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F2C744C59E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 18:33:15 +0900 Daniel Palmer wrote:
> Seriously though, I think we should have something to mark stuff in
> MAINTAINERS and elsewhere that is in the kernel but only because a few
> people are having fun with it.

IMHO that's not a great use of upstream maintainers' time.
We support loadable modules, perfect fit for retro computing
and drivers which aren't up to the standards.

