Return-Path: <netdev+bounces-279361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAu6IgBa4mn65AAAu9opvQ
	(envelope-from <netdev+bounces-279361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:04:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB2141CE31
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 18:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46251308C952
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 16:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920EA32D0D4;
	Fri, 17 Apr 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uaiehw6S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700CE317165
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776441731; cv=none; b=NPRUbnZiaKBsCFnoYk5A1SdPtzJ6zaLDudeOKAMuSeN1Vfkga1Gn3xns8emLilVMiFKW8ZdzS3QYK71tZSHIQSCdQuiFlbc/uFwq972IWj0Kci9NB78MVaprjSSwPoJeLC5THWz2jF5OVJYIs3fd3XyopKP/RR5DjHg1ncZScpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776441731; c=relaxed/simple;
	bh=G97aeQhu9k9+mvxexehf0ox0XpdO5ES48kn44W4EJpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKXcKN0tBthPozjj3q3KgsqGWR7KSVmBEV3K81LdljE6/s/DSfwTyvymmNbzathvLjmjdqFkf2BheA/jkjdCBPBot1AnkuNkYxJW8j5DXxcUdzSCkCdAilPCfWxr/0MhOatrTtHVKlB4sFR6QtmA/VIB3eZNFcs7NPpt5oZbh/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uaiehw6S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF3DC2BCB4;
	Fri, 17 Apr 2026 16:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776441731;
	bh=G97aeQhu9k9+mvxexehf0ox0XpdO5ES48kn44W4EJpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uaiehw6Sl709tM6vIxFunnvZ5N5wUHuTN7pBxXEEB1ZuGWUxIyaklikzPVjNooMJ4
	 /Wd2juOGI9n1/2siOCuf/LZdMJ5KFSU1z6XaqMobMHe/TTu0D98yEjWNw/qWzhqaWy
	 mp5rfGuwE/6Fia7RzLjUmbXJBFBEjv19kdBqyVzygHTOnETHR6Hpfid7LJ/lniReHC
	 ENN9BogMUcc/aTB58z0q/44VqGPMl6pTZPUjg5VavEZuuRyfCD80sY8pR836hhuFAn
	 My3msWGzffIo7J82c2PN532dDfusgEO0Fj7mqS7b3KwwPN4H+U7NbsLYf7FiQk7fao
	 lOoMHi1ETCtsg==
Date: Fri, 17 Apr 2026 17:02:08 +0100
From: Simon Horman <horms@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v7 0/5] netem: bug fixes
Message-ID: <20260417160208.GG31784@horms.kernel.org>
References: <20260415142822.133241-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415142822.133241-1-stephen@networkplumber.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279361-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBB2141CE31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 07:27:03AM -0700, Stephen Hemminger wrote:
> These bugs were found when doing AI assisted  review of sch_netem.c
> during investigation of the packet duplication recursion problem
> addressed in Jamal's series.
> 
> The fixes cover:
> 
>  - probability gaps in the 4-state Markov loss model
>  - queue limit not accounting for reordered packets
>  - PRNG reseeded on every tc change, breaking reproducibility
>  - slot delay configuration not validated for inverted ranges
>  - slot delay arithmetic overflow for ranges above ~2.1 seconds
> 
> v7 - queue limit check Fixes: goes back further to earlier change
>    - use NL_SET_ERR_MSG_ATTR
> 
> Stephen Hemminger (5):
>   net/sched: netem: fix probability gaps in 4-state loss model
>   net/sched: netem: fix queue limit check to include reordered packets
>   net/sched: netem: only reseed PRNG when seed is explicitly provided
>   net/sched: netem: check for invalid slot range
>   net/sched: netem: fix slot delay calculation overflow

To the maintainers: I'd like to ask for more time to complete review of this.

