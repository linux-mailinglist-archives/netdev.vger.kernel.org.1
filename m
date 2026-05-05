Return-Path: <netdev+bounces-284521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Np6Mcog+mkyKAMAu9opvQ
	(envelope-from <netdev+bounces-284521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:54:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 085824D1AEE
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BF06A3018D77
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3758648B38A;
	Tue,  5 May 2026 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYLXkfHZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8406338E5DF
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000033; cv=none; b=ASfKKx62IkuNL5nM+Rqp1s0XRHSDp/Z2JwPWZCTHEfGsQGkkdkn1Ag/CKlmHKaAQIEbQBRux4liic/OTwKtl1AGAuPc3W20KqGg1eHVALFNU0RjuCPsLVAqLjQ9K7OZSwmFy+1Yv+vVwMyxTnJ257JZTirgIwDh6v0+tO+oeJaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000033; c=relaxed/simple;
	bh=VGK4IhLQAaz4z7KHq8KXx42hoDpRWK1OJIWRKuV6dRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXtXKTMu08nZZsW5p8Y1eJpuCJGBFssbdB2hY9d0Y2TFL+ntAfekatCDY1qGSndqH0fGPmdfChq51A/b+4dIRrumhcUWA76U7tedRSIK2D/Zd7CVYuKYFtiBtxajDTJmiSARJzv/4CiRJE5Pu7aXQkzzZ5F8Z3Qg4Mbq6qlqKHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYLXkfHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5109C2BCB4;
	Tue,  5 May 2026 16:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778000032;
	bh=VGK4IhLQAaz4z7KHq8KXx42hoDpRWK1OJIWRKuV6dRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EYLXkfHZ09FJ8kOQpDmNuzWSw6Fuy9t0qASjTWpyBiitva3u9oNOr5Z6l9jMNwnkm
	 H0jvusQNHcBKPM8Qu9MPxOZZaL8ho7KO2UEplbFAnZJwCcIhHmDwU3QL1A/q5D4SEc
	 COvoDYGzLzsYOB81+nER5pTKjDQXoJFCygLMByqEEUxk/usnoXDORa/rNhQ2PYIVWJ
	 BPM4tYU/y7/OiX7mljP993/ai979km8ovvgGK4zwKddO8NtQZ2Q+aTuxAFkbSTJTiq
	 k7o3gpSgNwes5tFm9KDFlrcT0OfNJjMG8Nl4qDMwiSSXjGpEW92pZhosZT2jE+NP/d
	 7Rb/2FWp0H4lg==
Date: Tue, 5 May 2026 17:53:49 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] ixgbe: fix X550 AQ PHY identification returning
 ixgbe_phy_unknown
Message-ID: <20260505165349.GR15617@horms.kernel.org>
References: <20260430123154.132072-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430123154.132072-1-aleksandr.loktionov@intel.com>
X-Rspamd-Queue-Id: 085824D1AEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284521-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,horms.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 02:31:53PM +0200, Aleksandr Loktionov wrote:
> ixgbe_get_phy_id() reads the two MII_PHYSID registers and combines them
> into hw->phy.id with the lower 4 revision bits masked out by
> IXGBE_PHY_REVISION_MASK (0xFFFFFFF0).
> 
> Commit 5f1c3589b0f0 ("ixgbe: Correct X550 phy ID") replaced
> X550_PHY_ID (0x01540220) with X550_PHY_ID2 (0x01540223) and
> X550_PHY_ID3 (0x01540221).  These are the raw values read directly off
> hardware, but after revision-bit masking both reduce to 0x01540220.
> The switch cases in ixgbe_get_phy_type_from_id() therefore never match,
> and X550 AQ PHY devices always fall through to ixgbe_phy_unknown.  A
> wrong PHY type means the wrong ops vector is selected, resulting in
> failed PHY initialization and no link.
> 
> Restore X550_PHY_ID (0x01540220) as the match value -- the
> revision-stripped ID that the driver actually stores.  Keep X550_PHY_ID2
> and X550_PHY_ID3 as documentation of the hardware-reported values.
> 
> Fixes: 5f1c3589b0f0 ("ixgbe: Correct X550 phy ID")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


