Return-Path: <netdev+bounces-257724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MmqGHi+hmkzQgQAu9opvQ
	(envelope-from <netdev+bounces-257724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:24:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAC2104E5B
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C113C30164B7
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 04:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F7B2D9EE2;
	Sat,  7 Feb 2026 04:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM8Pi+k6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7691DF273;
	Sat,  7 Feb 2026 04:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770438259; cv=none; b=njb0ezCkLbwmOKekKkfgov2UK42czfDyuse+4cDqSzO9UBOQ5d85viub01SH3b5wpwNQhJ4lo3lWKum+C4uwtRx1a4B9zekYT4xhpLuVl3kp7p809Q9eEDTDZAjdRywdoYd5FiNnw1Ymvf3fKnZh/lZOZKfIL00EcZ+lgWTvP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770438259; c=relaxed/simple;
	bh=VqrxlTtl2oh2vT8sllo0Q5eg2Aasg80utLw+mVh/gp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OP/fswOjDKuncHLFLCu16n70hyKA12UD4n0Br+qmVgN94xWuQCZ45Tlmb22Nk0R2YIp6hSNH1qcWGM7gO/IRbS6rdmMyTiUO3dRnn8r11OmfukLDpxCpz+KBkNtIkTBdSFmkgl3PgnN7ul/pTXc7TTHG9KkVrRF6noOHIsJPf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QM8Pi+k6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D9EC116D0;
	Sat,  7 Feb 2026 04:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770438259;
	bh=VqrxlTtl2oh2vT8sllo0Q5eg2Aasg80utLw+mVh/gp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QM8Pi+k680yMWUC4Qm7nTww7qTpzSyOGUqJx0qNQPdSda7LagoPiKJ1q9qWq3u4mJ
	 tVBH+pTsIYDWaiIXHSohdvKgWUvS6k1mqEmRiR6248vS7zachktxgvv4Nqm8esVAke
	 risPRnmvjZ4AOJLntl/yxP+K2QOxKcsQ8jEn0jc6gMn6OLmb43z/BxiAf0JT6tBKzU
	 qA5VA1HWp+ebWG1SvCIMbe3JGB7pI+AHvkDa0y+s/v+WhCbvUh/Yx8OOHLW8lLGfJd
	 WNRWY/0D3Z6mmp4xAIPqm3cnooHBnayFGJXsTcSl4OX57vubmHls90xEyoZLfNeON/
	 Rgpv6GNmB1kzQ==
Date: Fri, 6 Feb 2026 20:24:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Boris Pismenny
 <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/9] psp: support rx rekey operation
Message-ID: <20260206202417.67b1c48b@kernel.org>
In-Reply-To: <20260204-psp-v1-1-5f034e2dfa36@gmail.com>
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
	<20260204-psp-v1-1-5f034e2dfa36@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257724-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,gmail.com,nvidia.com,lunn.ch,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBAC2104E5B
X-Rspamd-Action: no action

On Wed, 04 Feb 2026 07:20:05 -0800 Daniel Zahka wrote:
> --- a/include/net/psp/types.h
> +++ b/include/net/psp/types.h
> @@ -139,6 +139,9 @@ struct psp_assoc {
>  
>  	u32 upgrade_seq;
>  
> +	struct psp_assoc *prev;
> +
> +	bool tx_moved;
>  	struct psp_key_parsed tx;
>  	struct psp_key_parsed rx;

IIUC think tx_moved is going away in v2, but please double check 
the layout here with pahole -C psp_assoc. We the fastpath fields
in the first cacheline (or two?) The tx_moved the way it's placed
would create a hole, and hopefully for success path we don't have
to check prev at all.

