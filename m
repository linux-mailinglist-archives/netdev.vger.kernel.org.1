Return-Path: <netdev+bounces-254945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFNeIgXue2kMJgIAu9opvQ
	(envelope-from <netdev+bounces-254945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:32:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE88FB5B5A
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 00:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72053300D45F
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 23:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99EB3168E6;
	Thu, 29 Jan 2026 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfdOJO5o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B4B26FD97
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769729538; cv=none; b=eKBAMNu9MTSNLSVhAhNvtzECX92pmiAMkEtTk2Cv0E7UcprZ4rXiZ/kHADvEn0qAF5uwqzd9G9oUr/3h21xu29Md6mdsr6oEoKhUVuJUoo0l+yFrLtJNEUCRupg1yx7PDRPBOjtYrEOh3qz9GyARUEU+0HmbSmpNcnXTYIEtk88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769729538; c=relaxed/simple;
	bh=FByEisqMcDtTYdL2kCgZzmV1b1q75GMXJ3pU5XQZqHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkupJNEiI7jRmk4+8Bm+ccXwqxhg1be8Zql9NAukvDrlk/b8kkDrfjeSrLR2zgYzwBFf81WeWqQev+ywp9i4u94BgIhqZOpmg79ffOrvnbZ5uCOWXPWHcIQCc1QE4vYBRMldbSTN9unOX0eQw8nlnxM6RB2nFNEAy2S72OVh+G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfdOJO5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24406C16AAE;
	Thu, 29 Jan 2026 23:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769729538;
	bh=FByEisqMcDtTYdL2kCgZzmV1b1q75GMXJ3pU5XQZqHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BfdOJO5oa764lNo2+u6TA41VFkdfTSfd0/PX/+PjalQCrR/MT9b/AEbfZG7BwNTXD
	 eP2LKaPQRIWApNqto+2I8iKCY++TVnWIk0S6EwIQZ1CB9jwba5/tmr1lbLvuz/edBv
	 lVSy6uYpMXpYJHEQiN9Bm+/edr+jENfUYRjayAsQHt8FvunYwWSA/Hw+6OeD71JJHD
	 IIj5bDLxTHA8EgZFOfU5J3kSw7ot2R4xyqOJXONbihvJlCWN+tL8gLpUrv9B0eSPQh
	 FCUF2fVIOsZ36woSeiBqxqxgNqoLDx1gDZ5A5i9D4RW0GxiaLCKMdIXT3+KFN1WcLM
	 gP2hPvk+S4V6A==
Date: Thu, 29 Jan 2026 15:32:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Sune <marcdevel@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
 netdev@vger.kernel.org, dborkman@kernel.org, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v2 0/4] discard ARP/NDP b/mcast/null announce
 (poison)
Message-ID: <20260129153217.35d29be1@kernel.org>
In-Reply-To: <CA+3n-To=jD3z+PuRN6WbNf8QYeRErcOzk-W+Lovv3x31NHH22w@mail.gmail.com>
References: <cover.1769464405.git.marcdevel@gmail.com>
	<20260128202406.69c1eef1@kernel.org>
	<CA+3n-To=jD3z+PuRN6WbNf8QYeRErcOzk-W+Lovv3x31NHH22w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254945-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,kernel.org,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE88FB5B5A
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 19:39:59 +0100 Marc Sune wrote:
> > > This patchset only modifies the behaviour of the neighbouring subsystem
> > > when processing network packets. Static entries can still be added with
> > > mcast/bcast/null MACs.  
> >
> > Not a very strong opinion but my intuition would be to target
> > this to net-next. I read it as an improvement to RFC compliance
> > more than a solution.  
> 
> The main driver for this patchset is to remove the attack vectors
> described in Note 1 and Note 2 of Patch 1/4 (in the cover letter of
> RFC v1), not so much being RFC compliant. They are arguably low risk,
> but I would think there is value in having them on all stable
> versions. I originally targeted net and didn't add Fixes as I think
> these sanity checks have never been there.
> 
> Let me know if you prefer v3 to target net-next instead.

Nobody else chiming in to disagree with me so if it's your word against
mine I do prefer net-next :)

No matter what we do an unsecured L2 is not defensible by making tweaks
at the endpoint in the IP protocol stack.

