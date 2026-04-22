Return-Path: <netdev+bounces-280511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGyrFZD76GlNSgIAu9opvQ
	(envelope-from <netdev+bounces-280511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:47:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4504F448D49
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75E433001865
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EA92D23A4;
	Wed, 22 Apr 2026 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSL703Ul"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF0223707
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876425; cv=none; b=EwjYLO8swn1STnGn9goiTettUwHjGsOfN+umrXnCJcPXRatfdZlOVqP0oMT3Id/GrMQy+qvzjXCOZswt/gH0oeWdnLLpeCoDUFr2cKRa6XD6SFHqTte5ZvnHpEX4BbJh9S1z435XHGvWGiLIB+o1BiRoIpZx9vd8LvlLDcxrfA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876425; c=relaxed/simple;
	bh=I8t8RTkMnBk+PgfRd8qWXKGoXCX45BEPArwzNaPdUEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJXz45cBe+yw067pO3YDxdCVEJzM+XTJwnwWIUZC7hTith8HyOYIrVr1utKQjQuUwQ2YR1X/98nW9ppRppdT0qgEWUzQRYRHvW8GB6NzooMgRpXAO6JH915zujrxEPkAfls8P9iPh+lUzxZOxRCz3i9w1mKBvNDewyeakcU7qFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSL703Ul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FDBC19425;
	Wed, 22 Apr 2026 16:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876425;
	bh=I8t8RTkMnBk+PgfRd8qWXKGoXCX45BEPArwzNaPdUEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSL703Ul2+Tt5SG3MlOUok3KwhVze8aPcd3RcX44dFVCbrvu26z6JNRLHD5EBcAxX
	 kPMoIyOh85Cb4fRr2/21W4lMSVr2M+1Wsf9GAZpmfSA/asx6V7/XlO007Ov2lwUPOi
	 penS2jrrKVKxLoXhuQYoAlwH5lmYZKYRiSiAp1l+4o9SKf8bLF1vCvl/iY3hU7JCdu
	 DmWImt1Ndaf87G6jJJ2GXWvHXvdNTZa2CPi1LtHVIgy8YKI9RgYHM06D19nrhxQzGa
	 8UPbT8bC96AKuIIXZ9QAS757e4QdivycUe3c8H1P080Id6o1ESsMz3j9kWC/S3IUMX
	 7TQcHzYJB50dw==
Date: Wed, 22 Apr 2026 17:46:59 +0100
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: Re: [PATCH iwl-net v1] igc: set tx buffer type for SMD frames
Message-ID: <20260422164659.GP651125@horms.kernel.org>
References: <20260417193223.291093-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417193223.291093-1-kohei@enjuk.jp>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280511-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[enjuk.jp:email,sashiko.dev:url]
X-Rspamd-Queue-Id: 4504F448D49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 18, 2026 at 04:31:47AM +0900, Kohei Enju wrote:
> Sashiko pointed out that igc_fpe_init_smd_frame() initializes
> igc_tx_buffer fields for an SMD skb, but does not set the buffer type:
> https://sashiko.dev/#/patchset/20260415025226.114115-1-kohei%40enjuk.jp
> 
> Since igc_tx_buffer entries are reused, a stale XDP or XSK type can
> remain and make TX completion use the wrong cleanup path.
> 
> Set the buffer type to IGC_TX_BUFFER_TYPE_SKB.
> 
> Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
> Signed-off-by: Kohei Enju <kohei@enjuk.jp>

Reviewed-by: Simon Horman <horms@kernel.org>


