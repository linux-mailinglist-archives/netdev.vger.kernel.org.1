Return-Path: <netdev+bounces-280362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK6WHLOU6Gl9MgIAu9opvQ
	(envelope-from <netdev+bounces-280362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 11:28:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8504D443F8C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 11:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B076E3087127
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A973C196B;
	Wed, 22 Apr 2026 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owu0TQUo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CE23C1404
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849792; cv=none; b=dWc+3unUS8BFQ+jUkFFfnW9DTS3GS7swShJh7sVBAyHC3w5BEFcQ0XTH77VmegHEaZqVvr0ajDGLBQiV1hr6iIPM2NbtPqUtWqZR+1r2lLRPv3yBUz8y4s6vdXgE+czphCrTzCzb75fldI5Isv5Lgi0u+wvPQ1l0ZBbKxp/x9uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849792; c=relaxed/simple;
	bh=XerutDaAcW0btmmeOuC4Eva0WgGOO5eVODMGY3HSDMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgz0mTi85C95Fh0Fr7rqiOHSC8z7W0IAVlMcwHm5jkiyNFhSyQP+5cMdMBmJi3H4Lo5rtdFbEFg1/q7yu97H/TA/E0JxcGp5kjcE/Wprx874ci6TnPvALGbNaI984fbZjg5pr6NSMqLbtDTyRurVmCaLrNam33UI1Ro6gxbf80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owu0TQUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE710C19425;
	Wed, 22 Apr 2026 09:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776849791;
	bh=XerutDaAcW0btmmeOuC4Eva0WgGOO5eVODMGY3HSDMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=owu0TQUoNVErs5GzfLecNJ43KCX9ulthbobzjhl5QYehkT2olw/msGTe6QU64kVU3
	 /xDr0zCQ+6o810al2r/nPfdOmrkeQv+gYb5bGymZqcHjTk1xtCS78vDeIaPCtcFWzv
	 YRn+z9FwAx5nEJ3wvvtddesb34x71XbULMt5xIBTslnW5FnizQ+YhPq0gc3n0WRBpq
	 OWh0tAvOAWVz71jZJd3P8Q62PrYEe/XzySHeorrl+wo15yfk4scTcEOdjZl0dy32CT
	 VM9OSAtpGGrfzljQ3ZW/fdsDqE4HptSam3lz/646EsPUh663yIxYft5QiC/PxzOEyP
	 GHhG2hTbJc78Q==
Date: Wed, 22 Apr 2026 10:23:04 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Petr Oros <poros@redhat.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>,
	Timothy Miskell <timothy.miskell@intel.com>
Subject: Re: [PATCH net 0/4] Intel Wired LAN Driver Updates 2026-04-20 (ice)
Message-ID: <20260422092304.GJ651125@horms.kernel.org>
References: <20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-v1-0-bc2240f42251@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-jk-iwl-net-2026-04-20-ptp-e825c-phy-interrupt-fixes-v1-0-bc2240f42251@intel.com>
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
	TAGGED_FROM(0.00)[bounces-280362-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 8504D443F8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 05:51:24PM -0700, Jacob Keller wrote:
> Since this is a set of related fixes for just the ice driver, Jake provides
> the following description for the series:

Thanks for the excellent cover letter and patch descriptions.

Reviewed-by: Simon Horman <horms@kernel.org>

For completeness:

* I have looked over the AI generated review of patch 2/4 by Sashiko.
  You may wish to too. But I do not believe that feedback warrants
  holding up this series. Actually, I am skeptical those issues
  should be addressed at all.

* I have also looked over the AI generated review based on Chris Mason's
  review prompts which is available at https://netdev-ai.bots.linux.dev
  (if only it had a name!). It flags an potentially incorrect Fixes tag in
  patch 4/4. However, the cover letter for the patch explains the
  choice of Fixes tag, effectively rebutting the analysis generated by AI
  (I guess it didn't take the commit message sufficiently into account.)

