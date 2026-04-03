Return-Path: <netdev+bounces-275037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCG/KlG8z2mj0AYAu9opvQ
	(envelope-from <netdev+bounces-275037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:10:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0F6394579
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 15:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E14DA301DDAA
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 13:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBDF38C43A;
	Fri,  3 Apr 2026 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLlUuMOO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2834C37F8BC
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775221839; cv=none; b=teRcYpBVuJVBNJBcq77wwcblM2F/Fb1RLPpqYCQ9+dgTmut0oIGp45VCNXtLrsSByuCGZERvnKoAgnzO5oC+Ju6a3g/v76Vpe3Q3VQHCJXnI76JIs0vvn5I2dmLmgHFBuqFalx1mRvLT9u4YpbWyT3LEcavlOz5Mx0qJ6/qBHrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775221839; c=relaxed/simple;
	bh=kX1ZLLnNrXtxT9XzO6HLHCPmLKJ95wUEtz1Qqso24CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Buvs23GEqQ5DlIyrWUaUpt9sfcRPRWs1QvFRT74bhtZE0GJRS0S5KTf1r3w5XINA1W/GP/Tfj2F6aNebKw6eYgRBt9cXajmjhezWFkak3jVgOxvVLZBSc6wtX0D5bVyeV45NITKtMG6Y0Raqi6+q9IWe9Pm43KJzuEPiQovwM9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLlUuMOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823C9C4CEF7;
	Fri,  3 Apr 2026 13:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775221838;
	bh=kX1ZLLnNrXtxT9XzO6HLHCPmLKJ95wUEtz1Qqso24CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLlUuMOOV6xftx9qURwiD5IAf7HeNUpZcBNuEiOaMkoWTNmYMEK+7Ok06z38rm3wQ
	 jbYJNii/Rw2Zse/9LSTlTHr31pr5VLDC0keE+9s9j/U6xGUZDC65O3cEZ9wJfEYgib
	 8qo+3aHSKfWrlKNhBOJyhpoHLksSSQsO4kg28htTHOVedCupqLuLmflTe7aDKlbjeH
	 6qsX+yf1guAiGGA1QsDuEZiJYEyB6pmbl+PUAHcZNRKgARhScgI/H+zXF/K7eSJGCN
	 IHMJ8Tw+SZQ5q1Qz2Jee2c7PXOQhZAehfuiuqbtfftHqNCpPY2HKUf/nADvgwvoLNH
	 l6n7VpcwLE0ng==
Date: Fri, 3 Apr 2026 14:10:35 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next] ixgbe: use ktime_get_real_ns() in
 ixgbe_ptp_reset()
Message-ID: <20260403131035.GA113102@horms.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-5-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327073046.134085-5-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275037-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Rspamd-Queue-Id: 1A0F6394579
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 08:30:39AM +0100, Aleksandr Loktionov wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
> ktime_get_real_ns() in ixgbe_ptp_reset().  Using the combined helper
> avoids the unnecessary intermediate ktime_t variable and makes the
> intent clearer.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FWIIW, this pattern also seems to exist in e1000e, ixgbe and igb (twice).

