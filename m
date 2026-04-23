Return-Path: <netdev+bounces-280824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCAOBpVZ6mmgyQIAu9opvQ
	(envelope-from <netdev+bounces-280824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:40:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C636455A36
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 964C1300DDE1
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54053A7F45;
	Thu, 23 Apr 2026 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFmLyd0o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8293942AA6;
	Thu, 23 Apr 2026 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965983; cv=none; b=dhvBa2CDyY1dZURzkXVCRdxg/7I+4C+VL2H3tjORU5AvTqBbBbZwonC0BIgnoXn/BBgWJw/gnwM8SKta+6zlr+rp+a1rH9jiIsoI4iNgu82yzFre8hFpGIdWAcYIVISITQATQ1QVZmArzZ6yfo0eREmcuZorJxU2cX+GptT3vKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965983; c=relaxed/simple;
	bh=X0SCZ/oCXjw4rgwANqD1FPcd/u8eufPryPTHo9PcOJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ewB8ehz5D3FCr9SBfPE5epvkLcCSzMNOt97ujC/iv+e2FGI6hunrm5X1Oqq5PzlIM/x0c9r8rfFgAKGvlTJoER0zwt5RgfnhYv81z2bfft4s017oNoIlBqUJdREy42QdwbnjZjVl8qIuw33smedaySdc+YAt/xoVFRgBJejsLx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFmLyd0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31C4C2BCAF;
	Thu, 23 Apr 2026 17:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776965983;
	bh=X0SCZ/oCXjw4rgwANqD1FPcd/u8eufPryPTHo9PcOJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aFmLyd0oYLCs8NfF9rwYa2dbg296XHl/5L63Wgl/NpYecn4DiKzABz0XlMh8nx6Hn
	 sJRy10hQlBKR6U6mU6Hr0ZeLJov0S1S6YYGLE2OyocdZyUlHXk8VW/CntUQB2dT8pY
	 /gp10q5WKNmkRS8OiqLbTMPrCSKjYL/Mg4Ne2DR8N7nojwbT2/fN/EqT597/X9tVBr
	 Lw25Ci5U3kRY6V0yfm0Aw9pTwvnffkplT0mIAfDdRmGFyFxSEabtPUO42rtNLq05iw
	 TD83TBbwEgHXR4+L3gd0Yxth9OdAC0j4UclYnpVjDLczYIWFMScPJghc0eU9BQjfx/
	 QML4NZ0gY5fGA==
Date: Thu, 23 Apr 2026 10:39:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Satish Kharat <satishkh@cisco.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 20260401-enic-sriov-v2-prep-v4-0-d5834b2ef1b9@cisco.com, Breno Leitao
 <leitao@debian.org>
Subject: Re: [PATCH net-next v5 00/10] enic: SR-IOV V2 admin channel and
 MBOX protocol
Message-ID: <20260423103941.70a56bfa@kernel.org>
In-Reply-To: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
References: <20260423-enic-sriov-v2-admin-channel-v2-v5-0-caa9f504a3dc@cisco.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280824-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C636455A36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 23 Apr 2026 09:28:01 -0700 Satish Kharat wrote:
> This series adds the admin channel infrastructure and mailbox (MBOX)
> protocol needed for V2 SR-IOV support in the enic driver.
> 
> The V2 SR-IOV design uses a direct PF-VF communication channel built on
> dedicated WQ/RQ/CQ hardware resources and an MSI-X interrupt.

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v7.1,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Apr 27th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

