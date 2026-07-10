Return-Path: <netdev+bounces-306589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D5qgNO8AUWpA9wIAu9opvQ
	(envelope-from <netdev+bounces-306589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:25:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D24C73BB75
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:25:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CjFNZgkG;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306589-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306589-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7C603075CFA
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15850348C6B;
	Fri, 10 Jul 2026 14:20:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B269B348886;
	Fri, 10 Jul 2026 14:20:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693240; cv=none; b=O6DxJgtxt1t+6YU7S8Q2ENy54lzve7kYQXQa9pSapPUN6eQQuub/Vtz5cVSGqYFXhKTfy2TdpzQYFj0p1qgt1W7sGWJoNlbAc5fqweg1NM/TmzsFbBtYcy/VK3TW/HwF2I6GZIM8IV7gP3ju9ft0EPLzSDosLF2fJ+jm4Vcq3Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693240; c=relaxed/simple;
	bh=ECtrqPwlDWjSuIObRf2MYTZImAmEfsn/QV2p/KH8+bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0EWln9buYxfPGOISsl2KhmPiQcWlpIs/+m7Czxx5Mi7+JTQmB6lp7YJL1oyuhwylJR7HczJ7WP9QRK4l0zaIH6dn52FZRrK/DAZuKuUiBnnhI7h/Od8cMkllF/9UAr8/bWWwXI8wZTcJCPbhAvH57RFMPK/ob9rHyxgvMR+sUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjFNZgkG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDE61F00A3D;
	Fri, 10 Jul 2026 14:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783693238;
	bh=/pccCglUhRsC0pv3Cba+TIYCpljCUdyXdTko957Y5Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CjFNZgkGcnNtKVJDBz0476l5a57ZWkbDg/lwvuGwakH3217zTRU3cj+juBSP9Mofk
	 +fOKMOm7bLt+mZU+4s/PtUWmxg0fVkk05kMaahbUkX9R/ZiMYMqcr5T8nm59L7F5r6
	 hURndqIw37GotN9nxu3OVOixjy3MhMgyAGxOp1Lsxic1C3IyiZtpyR8T4qC/UayWy7
	 AKd/cns3LGvhro9cAYXhctkX2j/A+K5Q/I1e+IZfzYNh8cHm9avh2ObhGnqLpM6laa
	 HMvvHS214iJe0N707bw7lKjn9bydtGmGMmcQByoe3mq/ZmVVRRPQB7nhShOiLj9Jtn
	 zSIsfkSQRwAOg==
From: Simon Horman <horms@kernel.org>
To: Selvamani.Rajagopal@onsemi.com
Cc: Simon Horman <horms@kernel.org>,
	parthiban.veerasooran@microchip.com,
	andrew+netdev@lunn.ch,
	pier.beruto@onsemi.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andrew@lunn.ch,
	Parthiban.Veerasooran@microchip.com
Subject: Re: [PATCH net v3 2/3] net: ethernet: oa_tc6: Improvement in buffer overflow handling
Date: Fri, 10 Jul 2026 15:20:18 +0100
Message-ID: <20260710142019.1619159-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705-fix-race-condition-and-crash-v3-2-3e51841e4d08@onsemi.com>
References: <20260705-fix-race-condition-and-crash-v3-2-3e51841e4d08@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306589-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Selvamani.Rajagopal@onsemi.com,m:horms@kernel.org,m:parthiban.veerasooran@microchip.com,m:andrew+netdev@lunn.ch,m:pier.beruto@onsemi.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:Parthiban.Veerasooran@microchip.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D24C73BB75

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: ethernet: oa_tc6: Improvement in buffer overflow handling

This patch teaches the oa_tc6 rx path to detect when tail + length would
exceed skb->end, abandon the current rx_skb, and resume on the next
data chunk carrying a start_valid bit. It also propagates -EAGAIN as a
recoverable error through the chunk/footer processing and the outer
SPI transfer loop.

> diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
> index 5b24cce4f9b5..a6b8762f6052 100644
> --- a/drivers/net/ethernet/oa_tc6.c
> +++ b/drivers/net/ethernet/oa_tc6.c

[ ... ]

> @@ -931,8 +966,7 @@ static int oa_tc6_prcs_rx_chunk_payload(struct oa_tc6 *tc6, u8 *data,
>  	/* Process the chunk with only rx frame end */
>  	if (end_valid && !start_valid) {
>  		size = end_byte_offset + 1;
> -		oa_tc6_prcs_rx_frame_end(tc6, data, size);
> -		return 0;
> +		return oa_tc6_prcs_rx_frame_end(tc6, data, size);
>  	}
>  
>  	/* Process the chunk with previous rx frame end and next rx frame

[High]
Now that oa_tc6_prcs_rx_frame_end() returns int (and can return -EAGAIN
via oa_tc6_update_rx_skb() when tail + size > end), should the
"previous rx frame end + next rx frame start" branch also observe the
return value?  That branch is not shown in the diff, but in the
resulting file it reads:

    if (start_valid && end_valid && start_byte_offset > end_byte_offset) {
        if (tc6->rx_skb) {
            size = end_byte_offset + 1;
            oa_tc6_prcs_rx_frame_end(tc6, data, size);
        }
        size = OA_TC6_CHUNK_PAYLOAD_SIZE - start_byte_offset;
        return oa_tc6_prcs_rx_frame_start(tc6,
                                          &data[start_byte_offset],
                                          size);
    }

If oa_tc6_prcs_rx_frame_end() here returns -EAGAIN, oa_tc6_look_for_new_frame()
has already set tc6->rx_buf_overflow = true and cleared rx_skb.  Execution
then falls through to oa_tc6_prcs_rx_frame_start(), which allocates a
fresh rx_skb and copies the start bytes, but tc6->rx_buf_overflow stays
true because the guard

    if (start_valid && tc6->rx_buf_overflow)
        tc6->rx_buf_overflow = false;

is only evaluated on chunk entry.  Subsequent ongoing chunks (no
start_valid) then hit the earlier

    if (tc6->rx_buf_overflow)
        return 0;

path and are silently dropped, and the partial rx_skb is later thrown
away by the next allocate_rx_skb() -> cleanup_ongoing_rx_skb(), which
also increments rx_dropped.  Is this the intended behaviour for the
oversubscribed/chunk-loss scenario the patch is targeting?

[ ... ]

> @@ -972,8 +1004,9 @@ static u32 oa_tc6_get_rx_chunk_footer(struct oa_tc6 *tc6, u16 footer_offset)
>  static int oa_tc6_process_spi_data_rx_buf(struct oa_tc6 *tc6, u16 length)
>  {
>  	u16 no_of_rx_chunks = length / OA_TC6_CHUNK_SIZE;
> +	bool retry = false;
> +	int ret = 0;
>  	u32 footer;
> -	int ret;
>  
>  	/* All the rx chunks in the receive SPI data buffer are examined here */
>  	for (int i = 0; i < no_of_rx_chunks; i++) {
> @@ -982,8 +1015,11 @@ static int oa_tc6_process_spi_data_rx_buf(struct oa_tc6 *tc6, u16 length)
>  						    OA_TC6_CHUNK_PAYLOAD_SIZE);
>  
>  		ret = oa_tc6_process_rx_chunk_footer(tc6, footer);
> -		if (ret)
> -			return ret;
> +		if (ret) {
> +			if (ret != -EAGAIN)
> +				return ret;
> +			retry = true;
> +		}
>  
>  		/* If there is a data valid chunks then process it for the
>  		 * information needed to determine the validity and the location
> @@ -995,12 +1031,25 @@ static int oa_tc6_process_spi_data_rx_buf(struct oa_tc6 *tc6, u16 length)
>  
>  			ret = oa_tc6_prcs_rx_chunk_payload(tc6, payload,
>  							   footer);
> -			if (ret)
> -				return ret;
> +			if (ret) {
> +				if (ret != -ENOMEM && ret != -EAGAIN)
> +					return ret;
> +				retry = true;
> +			}
>  		}
>  	}

[Medium]
Is it intentional that a real -ENOMEM from oa_tc6_prcs_rx_chunk_payload()
(originating in oa_tc6_allocate_rx_skb() -> netdev_alloc_skb_ip_align())
is now folded into the retry path and converted to -EAGAIN at the end
of this function?

Before this patch, -ENOMEM propagated up through oa_tc6_try_spi_transfer()
and produced a netdev_err("Device error: %d", ret) plus
oa_tc6_free_ongoing_skbs() cleanup.  With this change, the outer while
loop treats -EAGAIN as non-fatal, so sustained memory exhaustion is
reported only as increments to stats.rx_dropped from
oa_tc6_allocate_rx_skb().

The commit message describes the change as being about buffer overflow
errors; is the change in visibility for allocation failures intended?

>  
> -	return 0;
> +	/* As a recoverable error, not bailing out on error code
> +	 * -EAGAIN. If subsequent loop iterations, if any, succeeds,
> +	 * error code would be overwritten. retry flag helps to
> +	 * make the caller to continue and retry.
> +	 */
> +	if (retry) {
> +		ret = -EAGAIN;
> +		oa_tc6_look_for_new_frame(tc6);
> +	}
> +
> +	return ret;
>  }

[High]
Can this unconditional oa_tc6_look_for_new_frame() discard a frame that
was successfully started later in the same buffer?

Consider a buffer where iteration N returns -EAGAIN from
oa_tc6_process_rx_chunk_footer() due to STATUS0 rx overflow (which
already sets rx_buf_overflow and clears rx_skb), and a later iteration
N+K carries a start_valid chunk that clears rx_buf_overflow via

    if (start_valid && tc6->rx_buf_overflow)
        tc6->rx_buf_overflow = false;

allocates a fresh rx_skb in oa_tc6_prcs_rx_frame_start(), and writes
the start bytes without further error.  retry is still true from
iteration N, so on loop exit the terminal oa_tc6_look_for_new_frame()
frees that newly-started rx_skb (incrementing rx_dropped) and re-sets
rx_buf_overflow = true.

On the next SPI transfer, the ongoing chunks of that frame are then
dropped by the top-of-function

    if (tc6->rx_buf_overflow)
        return 0;

guard in oa_tc6_prcs_rx_chunk_payload() until yet another start_valid
arrives.  Would it be safer to only call oa_tc6_look_for_new_frame()
here if the last iteration was still in an errored state, e.g. by
tracking the outcome of the most recent chunk rather than an aggregate
retry flag?

[ ... ]

