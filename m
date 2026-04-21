Return-Path: <netdev+bounces-280162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AXkBoiO52m89wEAu9opvQ
	(envelope-from <netdev+bounces-280162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:49:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AED3243C4CB
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C45D1303C925
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C703D9023;
	Tue, 21 Apr 2026 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9QXc7UI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB893D9021
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782766; cv=none; b=eR9frA4qaPInWWJgqoPOJEnbBof7gZk7xQveHvOlP6UFy4xrEC/6Ify+fBNdobDA1lqHxH4AtkN9NEs+i+QiF3STMs2dQHSxA90KXtxW8gbKV4wm9cYCTIL1iumX+zAhv4WliT+XKsmvJgxv8KX9jm2EGiK4ZJcvtuz0Wntbj14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782766; c=relaxed/simple;
	bh=FNTL5v0wIiMgaldzPZEG9U3wBQMAjOv9SCceinJse+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qB3JFKweJ8Gz2jclfAw4jeqSlpqY5t5f1zWzojcLlfLuyPp4dy2dfAIuDh3lldDg1WmeCgWdRzBL0mtWsyttrI853lyF/pEiuz9w8V0tXirJ69eiiX4QlBf6WCNOGbwDgiAJf+8LYxEwjp42PRBuBZrBfHt9l+dpZ/19AsGw0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9QXc7UI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C36C2BCB0;
	Tue, 21 Apr 2026 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776782766;
	bh=FNTL5v0wIiMgaldzPZEG9U3wBQMAjOv9SCceinJse+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l9QXc7UIQcnxcP+AhhG1U8LtqTl5UUy7loBg4mHmuUZblN9wr37bwQY/2zJtqDK3f
	 X7E6wZTowoJF+JpqYLqEFsaNj5x+hQq+JGp2+/phBZEW2fQnXNzvw2MC7prAOHmBHo
	 mJPI3jmMa9wblMwisVRl31UnY1oyjDPeYjJ7bi2rhJYFe/15MvVHXP5hVyJEzg806S
	 XvQM3O0m14/ssfwZX9kochmbRmfkf+whSGIPTAdqRfJLD3TIUy4AkglopjPiIN0qeE
	 fIHsfA4gUEie9Cxdy9ijuPDMrbKJ/VAubnB4qs0bSTbJV0jh1/r47Fp/IIi0tLGMn8
	 iC85J1eNzhqRQ==
Date: Tue, 21 Apr 2026 07:46:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 oss-drivers@corigine.com
Subject: Re: [PATCH net-next] nfp: fix swapped arguments in
 nfp_encode_basic_qdr() calls
Message-ID: <20260421074604.258b7044@kernel.org>
In-Reply-To: <20260421085124.147049-1-aleksei.kodanev@bell-sw.com>
References: <20260421085124.147049-1-aleksei.kodanev@bell-sw.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280162-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AED3243C4CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 08:51:24 +0000 Alexey Kodanev wrote:
> Fixes: 4cb584e0ee7d ("nfp: add CPP access core")

Fixes should be tagged for net, not net-next.

> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> ---
>  drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c
> index 79470f198a62..5c1edd143cee 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfpcore/nfp_target.c
> @@ -493,7 +493,7 @@ static int nfp_encode_basic(u64 *addr, int dest_island, int cpp_tgt,
>  			 * the address but we can verify if the existing
>  			 * contents will point to a valid island.
>  			 */
> -			return nfp_encode_basic_qdr(*addr, cpp_tgt, dest_island,
> +			return nfp_encode_basic_qdr(*addr, dest_island, cpp_tgt,
>  						    mode, addr40, isld1, isld0);

Please add warning prints to the error branches in
nfp_encode_basic_qdr() to help identify the source of failure.
Since this code worked and this is just a safety check there's
a high chance we'll break more than we fix with this.

