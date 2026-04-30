Return-Path: <netdev+bounces-282959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NWNNtaO82kQ5AEAu9opvQ
	(envelope-from <netdev+bounces-282959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:18:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4724A643E
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 19:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8EAA33007965
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEA844BC8E;
	Thu, 30 Apr 2026 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igtWD0ZR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B3C42B73B
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569491; cv=none; b=oA51mBPtaTxaGTU8gpykASfitZW5LJfSuNj56z0RGw0shjjREQxadFB0OPFZ2YXFb8w6chIw93C9ejXglwDNBcVlbXKyW7sMaZO0fUuCBwGS+k+CJnqgn3Rg6N6VesjrT4t0dNHm+TqP8SUD5/o1lKRyO39TdowZzjBwnVWSAJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569491; c=relaxed/simple;
	bh=0w70oLV/Hi26zqRuUt+YUcMxTFjt0fkMC/3AyJqHUYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgIYD6H6MCFJJUjZfQv2ZfEpI9LqkxJSiPlYkgyspa/mlCyJJP4bX6SQqnVwW4JuMtdw1Mm7BH0Iqx9CfWJtNZbZo3jbqrIE5IzWVR6y0QH0oTaMFWKP7CRVb4CwzDO2Rz78T90oCkJuYaGcvHMuFYuz7hOeAKokLVr1UMp5TsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igtWD0ZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAFCC2BCB3;
	Thu, 30 Apr 2026 17:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777569491;
	bh=0w70oLV/Hi26zqRuUt+YUcMxTFjt0fkMC/3AyJqHUYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=igtWD0ZRzepcIuAyMhbe7gToyqhH44s3PWoM3i6vhixkbnDfJ9r1CTQC6sJym1IEb
	 1NbyKdDv0/HdtYA5wCZOFi3vU77TKfPjsCgOFiLJa8deMIJ9VXTN1+L8SsVzM1OqnX
	 SN4JvevFRFAJFxWAKyvM4SK2joc6P/AMc43xbe8LiR6Q7431ojClE01d6UJlpCs0Om
	 Uwczgq9jVY5QxJr14H7TcXmv7pJWa67RyoFHaiwXRsYpFwYJHsSHLUYm04bM/4O38p
	 K3RTxCVpIIt7q+g2B4mkMUPiUXqZHJR0ubLWc7XUnrkfUast33DJCQ0lJAfdtLtk+U
	 M48Ac99YMdi2Q==
Date: Thu, 30 Apr 2026 18:18:07 +0100
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: mctp: test: remove skb dumps from test
 output
Message-ID: <20260430171807.GF900403@horms.kernel.org>
References: <20260429-dev-mctp-test-skb-dump-v1-1-13fd5789ef71@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-dev-mctp-test-skb-dump-v1-1-13fd5789ef71@codeconstruct.com.au>
X-Rspamd-Queue-Id: 2D4724A643E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-282959-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid,codeconstruct.com.au:email]

On Wed, Apr 29, 2026 at 04:27:31PM +0800, Jeremy Kerr wrote:
> We're currently dumping skb info in our fragment input test, which makes
> interpreting the TAP test output a bit awkward.
> 
> Remove the skb dumps.
> 
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Reviewed-by: Simon Horman <horms@kernel.org>


