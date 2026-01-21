Return-Path: <netdev+bounces-251667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EdODcAYcGkEVwAAu9opvQ
	(envelope-from <netdev+bounces-251667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:07:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1B94E4D5
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 579D2A051A5
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 00:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCD21E231E;
	Wed, 21 Jan 2026 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwdboKGp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65451D5151;
	Wed, 21 Jan 2026 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768954041; cv=none; b=kJ/hXK/rQR8vfrpRWPNft3WxQoctt9LSiMPurqdBGGIaytbZNx2xayiP0a4uU3re9tn0SLHl5zCNPPI2e9Ktu1BMBZqGMkUAFmoso5tsHHqqEMZzm+uN3CWhzlyjEQkhTAHuKrvZimrKXTwZ1RcinyGK66L6GaFAhX8GVOWPedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768954041; c=relaxed/simple;
	bh=jgmr/PE6zQhePD/bauyFTYPnYodHPE3L2TDfsSSvubg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RMO8pzerRHDifUz+UQroepDsCNRxNUAaMSeQqgKwf7gLiVQP9SaynCNYle5ICi1bCgaJtpRdDMxMxd6EUQF2SCTb4jso3u/HjB74tJDA5GdZQqRLZM46MtPremP8nVbneSWFRXLF6XpVsf4CE/SrOZOP5MIvzSsXG2eR1hixMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwdboKGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6F5C16AAE;
	Wed, 21 Jan 2026 00:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768954041;
	bh=jgmr/PE6zQhePD/bauyFTYPnYodHPE3L2TDfsSSvubg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GwdboKGpmsi9KVjAACnlI/uNZKZerIQ2nl3ZQrXQz7MTMuJcmGwP2WM+rAbIMSY7K
	 ZRDBrNlLw31UlpJHwolXBRTN9ongk3ucEF+GZP49gzpIAJf4CJazRJ1mg0lMvyGPi3
	 9lTxx+jFdTegfto7EZ5q5dBnx3LZvHGzpFr/08xEI4tBP+2B1d9fxqkdqAQTb95N4o
	 anzbxicVZm1P3YIy/oLszRouC9J+hg6dG2bczIO5OVmIySCbzg6tDh+kymvcezSf8n
	 FP+fdqds0XL03IyOsh2WHXAofI1i1Sj5BfSI6JvFP4WGdKZ1MGJvsxdShc8Y04v6aU
	 U+8RdHA1qy+ew==
Date: Tue, 20 Jan 2026 16:07:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mark Greer <mgreer@animalcreek.com>
Subject: Re: [PATCH v3] nfc: MAINTAINERS: Orphan the NFC and look for new
 maintainers
Message-ID: <20260120160719.19f9a5e8@kernel.org>
In-Reply-To: <20260118094822.10126-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260118094822.10126-2-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251667-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 0B1B94E4D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 18 Jan 2026 10:48:23 +0100 Krzysztof Kozlowski wrote:
> NFC stack in Linux is in poor shape, with several bugs being discovered
> last years via fuzzing, not much new development happening and limited
> review and testing.  It requires some more effort than drive-by reviews
> I have been offering last one or two years.
> 
> I don't have much time nor business interests to keep looking at NFC,
> so let's drop me from the maintainers to clearly indicate that more
> hands are needed.

Thanks a lot for all the review work over the years, it will be missed!

