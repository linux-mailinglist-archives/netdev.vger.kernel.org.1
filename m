Return-Path: <netdev+bounces-276827-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cbFwE2IY12lXKwgAu9opvQ
	(envelope-from <netdev+bounces-276827-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:09:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C18DA3C5F14
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 05:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED02C3038170
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 03:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA1F36215B;
	Thu,  9 Apr 2026 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvZDOg8x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAA62D8771
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704062; cv=none; b=Yb+LlIND1qFv3tCIHGvcGADFNCHGTdxG4i0Nt6rBEZVdoOTQM+zFiUgy55xa7ecOK8bfhW515KIwEKoT3uRnD3iebP1OW6FTJrjIfbvzvU30o9mQy5op1PJN1S0tMlbyvw98/tRd20qTrM4hkMGQBmAiE+ad9ZmakxxLaJ4keQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704062; c=relaxed/simple;
	bh=V4EWE4vaWr5fMS7gKJrRs+ClFeHCguu0D1SUYnOReAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqm5raHdVZ1D8Wn47ZDv0E1nzOz+fyGVLxMNXqv60Z4LYWzcAD1Uo5QDp4RiFIG8W1b98CJbv7eSx4IEsPJ1FLK7uXaq77Vv0a6F8oLqsN6qZAUhS1HSX/p4Op5Fjgl+6DNgy1LZns5Af9biJ16xXfT8xMd3KR7VMiNsnCtFLC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvZDOg8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9556C19421;
	Thu,  9 Apr 2026 03:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775704062;
	bh=V4EWE4vaWr5fMS7gKJrRs+ClFeHCguu0D1SUYnOReAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OvZDOg8xR6c+6IuMy3ajNXpYwhozYNVlapds29l6XqdQsE+yfHdiZtGsQjVyR/g2c
	 x/aW1O6ULwRispYWbw5BrJGrAmPwMpinPkDVQ4onANEEUZt5z2XrRPLeJbhIk4JWUA
	 mQBcp5GSgT4bJQHMtoQ9KT2krel1Q2GB23+X8aSNrmrVdqVorcl2W953bsgvb2jBo2
	 Teqz9m53mGtg/LArQnznAk2MwgCUY/+M9T4QW5RXx54Xs50vXLrK7KTZ+cfHsHKx9H
	 lNcgHtqQcCv7bVPhUwqsi9JfOzqD+BLJ5XapmsJiL53AQlPhXAOTExo+EzAZWdVShT
	 Wr4x4Ei+zhbNQ==
Date: Wed, 8 Apr 2026 20:07:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH net 0/9][pull request] Intel Wired LAN Driver Updates
 2026-04-06 (idpf, ice, ixgbe, ixgbevf, igb, e1000)
Message-ID: <20260408200740.56feb5a4@kernel.org>
In-Reply-To: <20260406213038.444732-1-anthony.l.nguyen@intel.com>
References: <20260406213038.444732-1-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-276827-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C18DA3C5F14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon,  6 Apr 2026 14:30:27 -0700 Tony Nguyen wrote:
> Emil converts to use spinlock_t for virtchnl transactions to make
> consistent use of the xn_bm_lock when accessing the free_xn_bm bitmap,
> while also avoiding nested raw/bh spinlock issue on PREEMPT_RT kernels.
> He also sets payload size before calling the async handler, to make sure
> it doesn't error out prematurely due to invalid size check for idpf.

Sashiko has a bunch of comments but they all look orthogonal

