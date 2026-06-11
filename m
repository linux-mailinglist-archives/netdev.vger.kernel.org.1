Return-Path: <netdev+bounces-298266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XmfVCAT6Kmpv0QMAu9opvQ
	(envelope-from <netdev+bounces-298266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:10:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 685C2674533
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 20:10:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ktW1M+Qv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298266-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298266-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A79631D3824
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9ED4A3411;
	Thu, 11 Jun 2026 17:56:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2EE33F59F;
	Thu, 11 Jun 2026 17:56:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200610; cv=none; b=gTR4DZVfoGPkaXFX7CT55omfOnGLFy54NAN6OYL5RAUrgxK8fPIUR6Gwb+eFrL97B+SHNvmzy7EM3sRVDlsiDZ9CFt4Sk6VDyabrxQdt4yqHBrLU+VZb7EkCx92uBY2UHuBm4B2GErHzKrRzmJ9gdhIBoGN2YGOAQuEyGLYdYwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200610; c=relaxed/simple;
	bh=U73+XwN1pPKzG7UNHdSIfIWRQgZf7M2u5bAxU53wyfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olx6wCxaCcZztdSboAhTlElV6i4ZJqHHkV21omKL3vFBO+xz5KNmiEZO/PK+JNwsMDxHFvgkXjVzU1D7gwi62oqrBSe+qz3RoviPuh97YrGEKIzI8lE4DYE/OYl8WR1DlVPm1uZ+oWC1CUXwEFHpTZItex5W/ssPaU1Udfe0BRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktW1M+Qv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418EA1F00893;
	Thu, 11 Jun 2026 17:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200605;
	bh=wTfmXsyH8Q4DXcjuPnl3bbdfG34xX8vBGuyENtZeg/k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ktW1M+QvCHltZv3FzFO3EuIqtvwoQdfocqm+mT1vT7Rnmnwgbe63AOZGOpizVCe64
	 GsyhSEgs82VUXPoNJNl4yd3iywR/OLZSJ7ULuaF1odyvHvSosnQckS8bh8kuGZxcBl
	 0g9imC5399J4k2hE2yW0jYHmBEzg30YFiRa5n4BUmPW5gF6AhxrS2KkttUpVmVdfQC
	 dnOTUF4rvrw/kbip5g9IBYsCO0bVXKrT99bd/mKDLAIz9QqUnxvfGM4csaP+YLd9W5
	 rzCDAx0qlaB3g6B+X6+waowSSIb8UcsIxynb8Bf/09XSKrzDc0bu0HrdU3E1MEpshQ
	 M8kbhKnspebfQ==
Date: Thu, 11 Jun 2026 10:56:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, oe-linux-nfc@lists.linux.dev
Subject: Re: NFC for next-20260609
Message-ID: <20260611105644.470e5989@kernel.org>
In-Reply-To: <cdc4f56d-0f46-4644-873e-24f3dfc98bc4@ixit.cz>
References: <b3084b2a-f8fa-4bba-8a92-1a14fbacb622@ixit.cz>
	<20260610084825.64763972@kernel.org>
	<cdc4f56d-0f46-4644-873e-24f3dfc98bc4@ixit.cz>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oe-linux-nfc@lists.linux.dev,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298266-lists,netdev=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 685C2674533

On Thu, 11 Jun 2026 14:14:01 +0200 David Heidelberg wrote:
> On 10/06/2026 17:48, Jakub Kicinski wrote:
> > On Tue, 9 Jun 2026 10:45:21 +0200 David Heidelberg wrote:  
> >> The following changes since commit 4549871118cf616eecdd2d939f78e3b9e1dddc48:
> >>
> >>     Linux 7.1-rc7 (2026-06-07 15:37:58 -0700)  
> > 
> > This should be based on net-next if you're sending a PR to net-next.
> > 
> > Normal flow of history is something like:
> > 
> >   net-next - x - x - ... - x - merge - x - ...
> >            \                  /     \
> >             `- x - x - x - x [PR]    ` x - ...
> > 
> > Note that net and net-next do the same dance of periodic merges,
> > and net does a periodic dance with Linus's tree, which is how
> > we get changes propagate from the tree with fixes to -next trees.
> > 
> > Problem 2 - the subject says next but the tag says "nfc pull request
> > for net:", which one is it? :)
> >      ^^^
> > 
> > Could you rebase the patches on top of net-next if that's your intended
> > target or net if you meant net?  
> 
> So the batch was intended to go into 7.2, should I target net-next or directly 
> net in this case?

Doesn't matter right now since the merge window is really close.
But looks like a mix of fixes and improvements. Having patches
that CC stable and basic code changes in one PR is a bit of 
a red flag. The fixes should should go to net, and the improvements
to net-next.

Right now probably best to respin for net-next, we don't want to
have to take the non-urgent stuff via net at this stag.e

