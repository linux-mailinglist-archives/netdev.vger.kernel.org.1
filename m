Return-Path: <netdev+bounces-269848-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIA4CooIvWkO5gIAu9opvQ
	(envelope-from <netdev+bounces-269848-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:42:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBC52D756F
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB6B63095303
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028AE374742;
	Fri, 20 Mar 2026 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INsX3Raa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0C372B4D;
	Fri, 20 Mar 2026 08:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996078; cv=none; b=PnL2nQ8/iUcc3UvARC1ApG/u5yC0A9De/h4ESjCGT/UhtuTjGjW3EA2Y5cOsnqRM/aoo77L0fJj1q9UoxFl3CmyLciDbwSmNd+173UjNuAAAA1+/kkyO3ZcyEiaan2p8AVhmDvGyJJH5sbujlDDJvkOuDcjJK21cghh3dAU4NJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996078; c=relaxed/simple;
	bh=g90O7nn50XsDORolSKBsWrsdvCLSXXNC55dyYlhTatI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uOCPMPE5K15zg3oO6+qfLxqSjbe1iyADfNbRdU86LTPFgi03gdXRUgp53+MCFsdtR8dKgwi3YIpQZaQDoR8GcTnb2pBuoztEXIGK7StK+q+Kz4W2bcs0nk3qWtfZ7joQsJbeYFbNjeH9iFUC7FlgAAMpYIZgmfFnpVAsdlMx+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INsX3Raa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B11DC4CEF7;
	Fri, 20 Mar 2026 08:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773996078;
	bh=g90O7nn50XsDORolSKBsWrsdvCLSXXNC55dyYlhTatI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=INsX3Raa6UuQBdkSKJPPW5RhopKsv3LU7PGRZr50uMqaj2nHfxcWdIUvjLhtMpYpX
	 3e/Taz5O9lc0pWNpHoNh/MZWXASooUaX8As4f/PCe8uWk22rJQ6R/L/B8TRWIpEhJU
	 zmuOffFTB4OHEbaKzQMbxxCeiv+G0s/eTPLjEfGOIPw4ASf8C/R7xFSNBKEPnaEu7C
	 2B9VNCvzJvlPLH8DKNuRm5clGTBqup1CVUnFag76gKdMrKoXdQJTgzVXKEDl0f6C1D
	 z77zj14HY4ZwuN6DzrRCsNZReM64LEjTmTtMLu4e5A8uZ3ATXF65vFugt2Vopzkv+i
	 3XJ1rPiWNcvwA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v2 net 7/8] selftests: bpf: have a separate variable for
 drop test
In-Reply-To: <20260319175538.479139-8-maciej.fijalkowski@intel.com>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-8-maciej.fijalkowski@intel.com>
Date: Fri, 20 Mar 2026 09:41:15 +0100
Message-ID: <87ikaqopuc.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.60 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269848-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[all.your.base.are.belong.to.us:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 7EBC52D756F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Currently two different XDP programs share a static variable for
> different purposes (picking where to redirect on shared umem test &
> whether to drop a packet). This can be a problem when running full test
> suite - idx can be written by shared umem test and this value can cause
> a false behavior within XDP drop half test.
>
> Introduce a dedicated variable for drop half test so that these two
> don't step on each other toes.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

