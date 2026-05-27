Return-Path: <netdev+bounces-292415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id t+RaMHkqF2oJ7wcAu9opvQ
	(envelope-from <netdev+bounces-292415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:31:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AA25E8559
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 19:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A81523021D0E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE82044BC9A;
	Wed, 27 May 2026 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="ER4Tcxwk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HB9ursVk"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A040C33A6E0
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903084; cv=none; b=g1T6Vp8bGBhlkc+gQwB+CN6yRybudMMGyY07jEvptqrXiyITugb/G+njswkHsZqWVj3TIgcs+VgW/2sV04PeWBp0oHmUVL89SkjtozrQNH+MVqnpqb0bqpNgicNv+qhGU3lM7BiTFTpzQBVHGAX/6MmBQBuvjPTGtb/QhEJYE3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903084; c=relaxed/simple;
	bh=2VeorrpPrHczu696XCdRJrT6dPA3QYLX9cgIPq74BRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0uyfKMBk2yotFixrQ18VNx15hlevhgSAUocuIuuwoF28ykmEXCOQq/QiJD+lo40Mr5KvAM+D2zi04caMvYs+qw6URGiTCtv/ekJP5vZT5eQyh391knip3rofTvkkT/vOmkfYmQxb9RThmvRBZKEUd6dtXbZsgQAjA6A6NghwUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=ER4Tcxwk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HB9ursVk; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C31D91400046;
	Wed, 27 May 2026 13:31:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 27 May 2026 13:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779903081; x=
	1779989481; bh=R5FD4RckKatd0N17KzDTKl7F8ePX1OOiptYZv8J7wU4=; b=E
	R4Tcxwk7caJCvT6ZL7M5rIpXDnGSaScjHM5+GjLm83Rw6ol66wZigYZzb96Peb7L
	nTwBRT0Xhl0myW+Lq/nMzJwYe5fu2PhIzXy++hvLkC2HvuXAbS3OcctCK9vKFbf+
	iy57n8nOWntgjtzKkByAYBW2lTVneW2SfmXYAiqWKHddhBAeKgrJIsXJUIjDmFpk
	4CuE+NP6GSOU2J5aDzuTv9ptmjWqpJyzbB4S9ncHySM+U7K1rmMa8Ll8ExSDx3ND
	4REsorR0JysdUcA8v9gNs6XqiLJivuQ83d+/DJikiIou6zYnQMNt8crca7LS00NM
	kYn1vTv3nBgZF/aLPiI7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779903081; x=1779989481; bh=R5FD4RckKatd0N17KzDTKl7F8ePX1OOiptY
	Zv8J7wU4=; b=HB9ursVk318CA9+aaIhu80xtDTy3xlSb3ZudcmO77hdDoOuEDKt
	3/X1v1Jg+6nV2qgfXSuUBa4CoV0A/JqeQ6aiN9no8aAf7s7kONiqmRZAgnOEImTL
	xjXY/zvFRG0xKc4yMYofaptqy5+Q9U/vVhT9g99dLQN4IOSkhV2nvGEhGvcEWIm1
	U6VOSMvMqFnkiWZan1r/g5x0otFcewtHwkVNZQSikIiOjXhRDqbM1kin6gi85qi8
	bELhl65g/YWgrSRnQ6S3peIeaXhqcN5YoELQ2pUvgXv7VHkURqbqJ+hWntLUfjVK
	c5bwR49Zmu+5PJEXc5+B8qSPtl9BVkPBpTw==
X-ME-Sender: <xms:aSoXan0AviJI1_yc7YYzfYOYtj2R2rkSVG76IKaj1K3_VEDrihtsZA>
    <xme:aSoXakUJC7vV2-MhyS4dOLgRU2_t9LZ1GDUpeSDcDk533RGnqJQIomGk_hnEk6fvL
    su3ylEwVDq-K7BnZMpzJM6fEkbgfC-sEH6YGe8VPfDNjHw3hl9hNeM>
X-ME-Received: <xmr:aSoXahM08ebwEoxkHHTVhOrdAEHdzp6118PuE6Gz6iD0YMLqOo5Y2vHhpk5flyqFQJzvobMRV67V6-kXe9U9N14>
X-ME-Proxy-Cause: dmFkZTEDZDUUIDQgd4rWMkRe17pf07B6uGR0EWgZ4AAdXAEHa9GXMOU3IBpK0yMEucV81T
    TcnUNg5hXpY8ggzjVA0WS0VfdwEASuyWv7BcTDfQkuUCh0Kp2saF0IToCFYGjm/ZJ7bgS/
    JhChU1ipeuxeBzJF0SncXP0J1spmHVTjS15VwZhix6JEDpWvELiuugrAu+sz6O931Skgfl
    pRaS2JXayeI5F/fn/HCEXYbzIkx6PQFtFuBgDWbARP29WWsmBinePW0BQ3pfZ/cYDgb0st
    9Rp9v9JlOln6wHcSjEY3M0/PNscT26fGXglYw9Cm5rZivaXe6saO84RjdjceF1LPtDX5MT
    pHi700mzMRbaVw4l+rAIv93bes3eNXN2+4JCSJTUQzo3bg4zWjtdlFxe9gc5Lzeu6j27OU
    2kB4/D9BdVbnlPh7/hix6Ss80SqH1H+Gt/FBbMhPMkN/M3L58UJzyN/HIquf8umgO4yrzq
    oia3mCgx7SwdwUH1VqgmyncUXIoMnuRHtRyjrwXkBYmbBWDYOGpGdhBcnNlwVw5i1oNuWv
    9W7h8MWR5SN6ppyXFLPPpNukLjqaoEbNXeBUzRiUzaBWXht5APFSD2mZKhBEBrpPXUnDab
    ri6AzpLSz4CCPB1H2982r0YBtAUuBEiuYkG1/OO5wVrMi73u3E/nqWgVlVfg
X-ME-Proxy: <xmx:aSoXav0Q5XvRULzS1YawR00NQ8KaJDujgRDeFF8Y2Z30Eqqu7OjT9w>
    <xmx:aSoXatSk0myVll-5ZBlRlZkYqZaR1sVAg1J3AFXfXx51HPrPjtlU0Q>
    <xmx:aSoXaikRaB6ltK5mLibW7HgwpNH46nhOvC1Wc4wRqNV-mu-JziLH5g>
    <xmx:aSoXauNd15lmgYmzpgtn8fXEIIVnuaQ9uieinh3jXO9Ky0qjl9ZZ_A>
    <xmx:aSoXaoVwE9HcRBagsZoohbYKqBK3oRsACjCUA_-grrbdFXcZN50vowcx>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 13:31:20 -0400 (EDT)
Date: Wed, 27 May 2026 19:31:19 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Chuck Lever <cel@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	kernel-tls-handshake@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH net-next v11 4/6] tls: Factor tls_strp_msg_consume() from
 tls_strp_msg_done()
Message-ID: <ahcqZ7rShtVcReAa@krikkit>
References: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
 <20260526-tls-read-sock-v11-4-244fe1dc4abd@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260526-tls-read-sock-v11-4-244fe1dc4abd@oracle.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292415-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,redhat.com,vger.kernel.org,lists.linux.dev,oracle.com,suse.de,wdc.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 76AA25E8559
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-26, 10:21:34 -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> tls_strp_msg_done() conflates releasing the current record with
> checking for the next one via tls_strp_check_rcv(). A subsequent
> patch needs to release a record without immediately triggering
> that check, so the release step is separated into
> tls_strp_msg_consume(). tls_strp_msg_done() is preserved as a
> wrapper for existing callers.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  net/tls/tls.h      |  1 +
>  net/tls/tls_strp.c | 11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

