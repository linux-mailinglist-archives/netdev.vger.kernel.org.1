Return-Path: <netdev+bounces-290876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGZSINl8EGrdXwYAu9opvQ
	(envelope-from <netdev+bounces-290876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:57:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F5E5B73E8
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43D863008A74
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD724330B3A;
	Fri, 22 May 2026 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnB6gVsj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEF328B7EA;
	Fri, 22 May 2026 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779465325; cv=none; b=Q/W7nWpqKsEAc+/tR88dlWfnft1lHugUNnVs9uTRbF2UQOX50UmmvnBn+UmpwBD+BFmLQRbVPOU1UZc/VvKoW5nbv1/SHuhUMujnQeZLLg+dWIcilJhvrgWJZvUQXcXsK+g/GbSaIoOgM7qkNRqyhtFwasmOiwzpr5FiR8yyuLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779465325; c=relaxed/simple;
	bh=p9QC77+fOS4IepZC79FvEwiT85HKsVGqeH1ixZElQSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q14KWUOkte0qR1XzVSczeay8Zln6xCJCngTnjnKAnpRoGznNtDR5I5U0tlEdFpWGjMldUjUosY1OoqJkAQW5Ny+DnGNFsL1aQ+EiISKC7a0VNp2AdfAuGKleitZtZqMC+CFa1RaFveoTHiTic8tT8sIbyNvR2mmY+0AEiiyNCtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnB6gVsj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EB61F000E9;
	Fri, 22 May 2026 15:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779465324;
	bh=vBx+xEmgiWqiT4uPnzeTJ1AxTohv1dp7pULOGoYMnlI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QnB6gVsjkVmFDeXnIkJg2AoGPGEvdLko479fzlLgSkENzK/cO1lIg8kip6JWm28bN
	 7JJIlsYkefYbqwPmlyKZMVfyXPxdmwSyhxgipsbUhjOlU3efIcOB2bEFHpHyDav7mZ
	 1QGOhgUD5It+R5xqlPe1j5zesmfqKh/irR178zTqlTneeAovfTXjtXpVtGqiAFDgmq
	 fgrYYr7a7rSjr+szbPKFg6unWwYWB+ILWOxn0663jQAcIyUbpk1XSHYcQHp5ifI1Pe
	 Q3Y1G5o8eLXDTWhozb0ndNK7Y3xqeA+A9ferSi+Mgbv3jJzNMtK72ILYM537C2kcpU
	 2e0d8fb794D9w==
Date: Fri, 22 May 2026 08:55:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ashwin Gundarapu <linuxuser509@zohomail.in>
Cc: "anthonylnguyen" <anthony.l.nguyen@intel.com>,
 "anthony.l.nguyen@intel.com" <przemyslaw.kitszel@intel.com>, "andrewnetdev"
 <andrew+netdev@lunn.ch>, "davem" <davem@davemloft.net>, "edumazet"
 <edumazet@google.com>, "pabeni" <pabeni@redhat.com>, "intel-wired-lan"
 <intel-wired-lan@lists.osuosl.org>, "netdev" <netdev@vger.kernel.org>,
 "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: e100: remove redundant static variable
 initializations
Message-ID: <20260522085523.0432a2d5@kernel.org>
In-Reply-To: <19e4e74ff40.601fab765713.9212104302286035517@zohomail.in>
References: <19e4e74ff40.601fab765713.9212104302286035517@zohomail.in>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290876-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,checkpatch.pl:url]
X-Rspamd-Queue-Id: E0F5E5B73E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 12:22:30 +0530 Ashwin Gundarapu wrote:
> Remove '= 0' from static variables eeprom_bad_csum_allow and use_io.
> Static variables are zero-initialized by default.
> 
> Found by checkpatch.pl

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches

