Return-Path: <netdev+bounces-280289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJb8GWE16Gk6GwIAu9opvQ
	(envelope-from <netdev+bounces-280289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:41:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 603504418DB
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 04:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38E3E3013709
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 02:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2841037F75D;
	Wed, 22 Apr 2026 02:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cWbZu5hY"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D684391849
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 02:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776825537; cv=none; b=T2pvD+C/wxtpdVQGU8b4pBkocU7Xz67D37UKs+5QvCg/OjfwhsowoYkQG6ci/69PhfI7leawl4JhHOsmTzAquxGC9PDKD0x3rCi7XzD02SKgn0PkZ4VS+kiV/sXNJOpwllcL4w0iFlwcarphWUvVhH1zC46ifAi3jZTIpNB69do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776825537; c=relaxed/simple;
	bh=fzwjmIqQekPo8o/ATAU9/Fm3reUgMbTSC0pjAkixSBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcNdcNQ+7/0JbAujlbfERCM0uUUBwsijE48HkiTX3DTbublq+qmysEQxFUAePNU5QbcOUdib/eBUKoMHaE0oQfuSgL/nKlhUibz1sZhNaB7PKAeRN9H9hTvAzUFwB5gH7dJMc9V0goRDy+qIi8ml7fNXkMxHAEPLDNFwerzTje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cWbZu5hY; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <615b2902-597e-49dc-9bfa-621c7e072b5d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776825509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXr5rEctMiuiUbhVQzGATPHv0oPQBw4ipel+oTNpUYg=;
	b=cWbZu5hYhYzKX1CUShZqMDVfB1wjkHFwTRYVkc9HGlez4kuyN59OykEXelpQ5Dq7BH6+yy
	z6wqtYgT1NdVJpHihoHXeBhmX79uHTh1mFipEIRRmV15wH4eEas679ej0tTUb2Bqs0NKs+
	PEPD8UJIhjwaFmFR5CWGHtE6I6TVsoQ=
Date: Wed, 22 Apr 2026 10:38:22 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 2/2] selftests/net: packetdrill: cover RFC 5961 5.2
 challenge ACK on both edges
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260421014128.289362-1-jiayuan.chen@linux.dev>
 <20260421014128.289362-3-jiayuan.chen@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260421014128.289362-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280289-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 603504418DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/21/26 9:41 AM, Jiayuan Chen wrote:
> RFC 5961 Section 5.2 / RFC 793 Section 3.9 require a challenge ACK
> whenever an incoming SEG.ACK falls outside
> [SND.UNA - MAX.SND.WND, SND.NXT].  There is currently no packetdrill
> coverage for either edge.
>
> Add tcp_rfc5961_ack-out-of-window.pkt, which in a single passive-open
> connection exercises:
>
>    - Upper edge (SEG.ACK > SND.NXT): peer ACKs data that was never
>      sent before the server has transmitted anything.
>    - Lower edge (SEG.ACK < SND.UNA - MAX.SND.WND): after the server
>      has sent 2000 bytes (the peer-advertised rwnd forces two 1000-byte
>      segments, both acknowledged), peer sends an ACK that is older
>      than the acceptable window.
>
> Both cases must elicit a challenge ACK
> <SEQ = SND.NXT, ACK = RCV.NXT, CTL = ACK>.  The per-socket RFC 5961
> Section 7 rate limit is disabled for the duration of the test so that
> both challenge ACKs can fire back-to-back.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> ---
>   .../tcp_rfc5961_ack-out-of-window.pkt         | 46 +++++++++++++++++++
>   1 file changed, 46 insertions(+)
>   create mode 100644 tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-out-of-window.pkt
>
> diff --git a/tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-out-of-window.pkt b/tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-out-of-window.pkt
> new file mode 100644
> index 000000000000..44d54c812820
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp_rfc5961_ack-out-of-window.pkt
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// RFC 5961 Section 5.2 / RFC 793 Section 3.9: an incoming segment's
> +// ACK value must lie in [SND.UNA - MAX.SND.WND, SND.NXT]; otherwise
> +// the receiver MUST discard the segment and send a challenge ACK
> +// back.  Exercise both edges of that window in a single connection.
> +
> +`./defaults.sh
> +sysctl -q net.ipv4.tcp_invalid_ratelimit=0
> +`
> +
> +   0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
> +  +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> +  +0 bind(3, ..., ...) = 0
> +  +0 listen(3, 1) = 0
> +
> +// Three-way handshake.  Peer advertises rwnd = 1000 (no wscale), so
> +// MAX.SND.WND is tracked as 1000.
> +  +0 < S 0:0(0) win 1000 <mss 1000,sackOK,nop,nop,nop,wscale 0>
> +  +0 > S. 0:0(0) ack 1 <...>
> ++.1 < . 1:1(0) ack 1 win 1000
> +  +0 accept(3, ..., ...) = 4
> +
> +// ---- Upper edge: SEG.ACK > SND.NXT --------------------------------
> +// Server has sent nothing yet, so SND.UNA = SND.NXT = 1.
> +// Peer sends a pure ACK with SEG.ACK = 2, beyond SND.NXT.
> +  +0 < . 1:1(0) ack 2 win 1000
> +// Expect a challenge ACK: <SEQ = SND.NXT = 1, ACK = RCV.NXT = 1>.
> +  +0 > . 1:1(0) ack 1
> +
> +// Advance SND.UNA past MAX.SND.WND so that the lower edge becomes
> +// reachable.  Write 2000 bytes; the peer's rwnd of 1000 forces two
> +// 1000-byte segments, each acknowledged in turn.
> +  +0 write(4, ..., 2000) = 2000
> +  +0 > P. 1:1001(1000) ack 1
> ++.01 < . 1:1(0) ack 1001 win 1000
> +  +0 > P. 1001:2001(1000) ack 1
> ++.01 < . 1:1(0) ack 2001 win 1000
> +// Now SND.UNA = SND.NXT = 2001, MAX.SND.WND = 1000, bytes_acked = 2000.
> +
> +// ---- Lower edge: SEG.ACK < SND.UNA - MAX.SND.WND ------------------
> +// SND.UNA - MAX.SND.WND = 2001 - 1000 = 1001, so SEG.ACK = 1000 falls
> +// below the acceptable range.
> +  +0 < . 1:1(0) ack 1000 win 1000
> +// Expect a challenge ACK: <SEQ = SND.NXT = 2001, ACK = RCV.NXT = 1>.
> +  +0 > . 2001:2001(0) ack 1


https://sashiko.dev/#/patchset/20260421014128.289362-1-jiayuan.chen%40linux.dev

I don't think the AI's concern holds, but I think I can split 
write(2000) into write(1000)
so the test doesn't rely on kernel internals.



