Return-Path: <netdev+bounces-135885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A5D99F805
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 22:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F854B21A63
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF67C1F585C;
	Tue, 15 Oct 2024 20:20:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0500215699D
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 20:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.232.154.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023652; cv=none; b=gdG3iakZm9gibRwxeh9nfJZNeTPb8Y6mMm5SoK7ShFDu2aXziiSPffiK2vt7ODP+HuXpAW+Sb8Vkus+snSub+J+4bLXU5ltoKgP63o3s1yne2i1GTMFDk6eBKaKrIQj25dGYhzzLaBM+lvPfhVjhbNzqmScEdQgnkxI6PMBVf7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023652; c=relaxed/simple;
	bh=PUt3dEeBuBiT30TwHntufLwBoVSlymx2e4MQ8LUWTcs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CKdJNNlsZu4yLKSjqVsJsBgHkedb3ER1Bjg1xl6ZpXbKjRFMM+lVPCyh3w+Bncp0c4Zjle9rYBcqQXwkImWd0s0+KDlbkOVKurI4Eav4gv/t2tojiTgmSqvWbUCdPaHxU6cxBRfkWYbjeOnRerqeUX+WYrT8zImoQiNkrRV2ZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=91.232.154.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from kapsi.fi ([2001:67c:1be8::11] helo=lakka.kapsi.fi)
	by mail.kapsi.fi with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ij@kernel.org>)
	id 1t0nXx-0013WU-24;
	Tue, 15 Oct 2024 22:49:34 +0300
Received: from ijjarvin (helo=localhost)
	by lakka.kapsi.fi with local-esmtp (Exim 4.94.2)
	(envelope-from <ij@kernel.org>)
	id 1t0nXx-003TdO-6E; Tue, 15 Oct 2024 22:49:33 +0300
Date: Tue, 15 Oct 2024 22:49:33 +0300 (EEST)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ij@kernel.org>
To: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
cc: netdev@vger.kernel.org, ncardwell@google.com, 
    koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com, 
    ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
    cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
    vidhi_goel@apple.com, Olivier Tilmans <olivier.tilmans@nokia.com>
Subject: Re: [PATCH net-next 17/44] tcp: accecn: AccECN negotiation
In-Reply-To: <20241015102940.26157-18-chia-yu.chang@nokia-bell-labs.com>
Message-ID: <4eb02755-8061-6cf7-3fea-5b645e371caa@kernel.org>
References: <20241015102940.26157-1-chia-yu.chang@nokia-bell-labs.com> <20241015102940.26157-18-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-396686182-1016422414-1729021773=:1579188"
X-Rspam-Score: -0.6 (/)
X-Rspam-Report: Action: no action
 Symbol: FREEMAIL_ENVRCPT(0.00)
 Symbol: FREEMAIL_CC(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Symbol: R_SPF_SOFTFAIL(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: RCVD_TLS_LAST(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: R_DKIM_NA(0.00)
 Symbol: MID_RHS_MATCH_FROM(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: ARC_NA(0.00)
 Symbol: ASN(0.00)
 Symbol: MISSING_XM_UA(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: RCPT_COUNT_TWELVE(0.00)
 Symbol: DMARC_POLICY_QUARANTINE(1.50)
 Symbol: TO_DN_SOME(0.00)
 Symbol: CTYPE_MIXED_BOGUS(1.00)
 Message-ID: 4eb02755-8061-6cf7-3fea-5b645e371caa@kernel.org
X-SA-Exim-Connect-IP: 2001:67c:1be8::11
X-SA-Exim-Mail-From: ij@kernel.org
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---396686182-1016422414-1729021773=:1579188
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 15 Oct 2024, chia-yu.chang@nokia-bell-labs.com wrote:

> From: Ilpo Järvinen <ij@kernel.org>
> 
> Accurate ECN negotiation parts based on the specification:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
> 
> Accurate ECN is negotiated using ECE, CWR and AE flags in the
> TCP header. TCP falls back into using RFC3168 ECN if one of the
> ends supports only RFC3168-style ECN.
> 
> The AccECN negotiation includes reflecting IP ECN field value
> seen in SYN and SYNACK back using the same bits as negotiation
> to allow responding to SYN CE marks and to detect ECN field
> mangling. CE marks should not occur currently because SYN=1
> segments are sent with Non-ECT in IP ECN field (but proposal
> exists to remove this restriction).
> 
> Reflecting SYN IP ECN field in SYNACK is relatively simple.
> Reflecting SYNACK IP ECN field in the final/third ACK of
> the handshake is more challenging. Linux TCP code is not well
> prepared for using the final/third ACK a signalling channel
> which makes things somewhat complicated here.
> 
> Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/linux/tcp.h        |   9 ++-
>  include/net/tcp.h          |  80 +++++++++++++++++++-
>  net/ipv4/syncookies.c      |   3 +
>  net/ipv4/sysctl_net_ipv4.c |   2 +-
>  net/ipv4/tcp.c             |   2 +
>  net/ipv4/tcp_input.c       | 149 +++++++++++++++++++++++++++++++++----
>  net/ipv4/tcp_ipv4.c        |   3 +-
>  net/ipv4/tcp_minisocks.c   |  51 +++++++++++--
>  net/ipv4/tcp_output.c      |  77 +++++++++++++++----
>  net/ipv6/syncookies.c      |   1 +
>  net/ipv6/tcp_ipv6.c        |   1 +
>  11 files changed, 336 insertions(+), 42 deletions(-)
> 

> @@ -6358,6 +6446,13 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
>  		return;
>  
>  step5:
> +	if (unlikely(tp->wait_third_ack)) {
> +		if (!tcp_ecn_disabled(tp))
> +			tp->wait_third_ack = 0;

I don't think !tcp_ecn_disabled(tp) condition is necessary and is harmful
(I think I tried to explain this earlier but it seems there was a 
misunderstanding).

A third ACK is third ACK regardless of ECN mode and this entire code block 
should be skipped on subsequent ACKs after the third ACK. By adding that 
ECN mode condition, ->wait_third_ack cannot be set to zero if ECN mode get 
disabled which is harmful because then this code can never be skipped.

--
 i.
---396686182-1016422414-1729021773=:1579188--

