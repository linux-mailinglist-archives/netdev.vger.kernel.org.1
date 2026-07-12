Return-Path: <netdev+bounces-306941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xwA5Nh2CU2rvbQMAu9opvQ
	(envelope-from <netdev+bounces-306941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 14:01:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 322D6744935
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 14:01:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=V+MKz1YO;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306941-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306941-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1FE53005D12
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 12:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371AD3769F6;
	Sun, 12 Jul 2026 12:01:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB312EC08C
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 12:01:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783857691; cv=none; b=S3WMeayK38ZaDw1jDHQHFvQ/HUJoO2q+4zRejtHFOKhlF9hP3r7REJWsNGbg1/SRIIzKvoBpbM9obtRoVdhwI8PwxGMCuZwtsHXvoOdCeN2Wt1cEcC0AhmR3RM2lTDwknWU6r5Xpny5XpXWIS0GFF8hOX++gh3ixaSddWd8VFM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783857691; c=relaxed/simple;
	bh=Z6MPUwvfzHPsGb5Z5H+NXRopv+HDbqAPxI5eNqREkAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pKh1a1tdR6aE+PHhm+88Yo3/yynSSThyEGHL8Gvn15RX3OtjvJ90QWIOSA2AMXCbGNcJXKtCdrTp6WWj1+8SQgcUWHgSUOQJfPQtfJlIhTWK13ZMwt3+QZrDySKQY4mIUQaQ8VYQTGXZdXcwlctGAfPG5PMieX/yZGyUQh3nO2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V+MKz1YO; arc=none smtp.client-ip=95.215.58.173
Message-ID: <be1731eb-e6ec-4015-92e4-c09fd88019e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783857687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+qAD85lzCUvKNtDkSm1kSorQr3jUvrrMQyVJ948Vnzk=;
	b=V+MKz1YOo3io/fhhDsXPAABOyf4Q0W0Cqn6wYZFl3TrCbAo+HBNo76KWyv5/b6bZB15KDH
	MrjfTm1AEP8/yRS9CtWlbVzhtPXTteAqXzlLj81c8AySSJlvdhZ5tcPHgXVQZNeOVhQwpA
	XKdvSwjSOjRBWZKnusljwlxG6qHvCJY=
Date: Sun, 12 Jul 2026 13:00:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] nfc: llcp: reject PDUs shorter than the LLCP header
To: Doruk Tan Ozturk <doruk@0sec.ai>, David Heidelberg <david@ixit.cz>
Cc: Simon Horman <horms@kernel.org>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260711072702.70231-1-doruk@0sec.ai>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260711072702.70231-1-doruk@0sec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306941-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:david@ixit.cz,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 322D6744935

On 11/07/2026 08:27, Doruk Tan Ozturk wrote:
> nfc_llcp_rx_skb() reads the two-byte LLCP header (DSAP/SSAP/PTYPE) and
> dispatches by PDU type; several handlers then derive a TLV-array length as
> skb->len - LLCP_HEADER_SIZE. Neither nfc_llcp_rx_skb() nor its callers
> guarantee the frame is at least LLCP_HEADER_SIZE bytes, and a sub-header

that's not correct. there are 2 ways to get to nfc_llcp_rx_skb() - via
nfc_llcp_recv_agf() or through commands/locally generated skbs. The
first one checks against LLCP_HEADER_SIZE, while latter one creates skb
payload with correct LLCP header size. Do you have a reproducer to
trigger the issue?


> PDU does reach it: digital_in_recv_dep_res() and digital_tg_recv_dep_req()
> strip the DEP header with skb_pull() after only checking the DEP header
> size, so a DEP I-PDU carrying a 0- or 1-byte LLCP payload is handed up as
> a sub-2-byte skb.
> 
> For a CONNECT or CC PDU, nfc_llcp_recv_connect() and nfc_llcp_recv_cc()
> then pass skb->len - LLCP_HEADER_SIZE to nfc_llcp_parse_connection_tlv().
> For skb->len < 2 that subtraction underflows: truncated into the u16
> tlv_array_len parameter it becomes ~0xFFFE, and for a CONNECT to the SDP
> SAP, nfc_llcp_connect_sn() uses a size_t and underflows to SIZE_MAX. The
> TLV parsers bound their walk relative to that length, so they read far
> past the end of the skb.
> 
> The aggregated-frame path (nfc_llcp_recv_agf()) already drops sub-PDUs
> shorter than the header. Apply the same guard once, in the dispatcher, so

that not exactly correct, it drops skbs which are shorter or equal to
the header, the check added in this patch is not correct then.

> every PDU type is covered.
> 
> Found by 0sec (https://0sec.ai) using automated source analysis; the
> missing guard is evident from source. Compile-tested.
> 
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:claude-opus-4-8
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
>   net/nfc/llcp_core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> index aed5fe1afef0..e3b3077e0e83 100644
> --- a/net/nfc/llcp_core.c
> +++ b/net/nfc/llcp_core.c
> @@ -1481,6 +1481,9 @@ static void nfc_llcp_rx_skb(struct nfc_llcp_local *local, struct sk_buff *skb)
>   {
>   	u8 dsap, ssap, ptype;
>   
> +	if (skb->len < LLCP_HEADER_SIZE)
> +		return;
> +
>   	ptype = nfc_llcp_ptype(skb);
>   	dsap = nfc_llcp_dsap(skb);
>   	ssap = nfc_llcp_ssap(skb);


