Return-Path: <netdev+bounces-252305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEkmJOgScmksawAAu9opvQ
	(envelope-from <netdev+bounces-252305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:07:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD66668D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34509900EDC
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142473A9636;
	Thu, 22 Jan 2026 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNYHVdcw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1877331ED66
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769081421; cv=none; b=ReFu0BBP2yj3AilDBagCaJfyxAbxJSb0t0C+rk9xi5Zz5QJiWVFyhC6cfkyiCsz54JFbgTi79s7Pq7yvdl4HtWMDV73JTm0q8jPJgw4dPXfo0dWHvckxen4PgKtTJ8Qw9Eq6Q6WH5ngpyBhK7l0W2c2i/cLkjL6KQXo/r82I5Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769081421; c=relaxed/simple;
	bh=39FPDHITu3Mcv+kLd8pXIXa7VRQv2QF7b1+o3jrmRAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dyRD7OTdJWNM80+C6Mr1e3RNHZ63IQvlKh8fT6s4+6AIPpy8/tiEVEywKjB6l2/G3Anv/j2trTp5KsJ0krnrxMmh5jjf1+mj+60XnaDKw0qZ59SeBNspkCT5QEEz/8I/vt6bKM4CH+3UJ4HjRtlI1PaxiZw3W1C2MQ8H3QSdOCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNYHVdcw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so11587175e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 03:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769081417; x=1769686217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dnqo+Zg9fRRtteZPakxnCOruFtX67sgTE3miBZJngDg=;
        b=gNYHVdcwB6qugUb+NizIXFxmV5hh3HerG6j3lhD910ftP4l5wNDzjBtzVtOqjG2Dmh
         0GKYbQjYwF5F4ulbQE/XiXHEZHPvrKqdCHzJDtYvPQnudSnC2SbBFogJfOTZi0u3HaXS
         5O33u5arQja0qzn7hCrqaNQVX33UQivegUZma7SFS5KrDLeqTugI4S7rxhOAKUcVTKN/
         HUUGHvaU5y7ajVbsZfaHbPfO8+jS6EeLqX1WfTAKOrqzPe0IYnHrTYzkkT6gT1Hkuhu/
         2+EhL8tUlNaoBDsR/MGL06XdKaWtFDwG5xshaacOy9o53pRab7sj+7SA3QhEdAFEOhzl
         Y9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769081417; x=1769686217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dnqo+Zg9fRRtteZPakxnCOruFtX67sgTE3miBZJngDg=;
        b=KWunzX75E+FBP5no3+oFhkGx/a2guUntcQTyjtivbHJfAGiJlxBQaVahsVXpw1t9Mc
         dpxju8fgzrYbN3XkIQy44i4Q8xa6o7G5vBykr+M4m4MEhFigDJvxteyMPBDCOsIxg3Cb
         6mvBYv46K8A7LvkjP6jtc9PZBd+Tmh3E2MMvV93NXu16iyiKSXiGrxKg3lV/grByNmda
         eBK2hMvDuSoCZA0jk+FpOUFOTuBXFbATPmk5bGggx4Lv+CQ0np48SM5BcoyWSioOVGSo
         WHErh4pLBA3fqFbW3NGFcP9J8vgcpOr6KXlp82+1JMKiLp6wvyuuOhcqGYD/rQKhsY+z
         ROLw==
X-Forwarded-Encrypted: i=1; AJvYcCXeWiXcKB0MI5QuGixHGXVkGkxELTmy6aBn3kA5v8iuj+gCq/5xplVPOv0BKz4UG+g6EgryGb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZDiGlFUSLzBtq50lqh0/YTQOg3DWnwXEUz5ky790OA0rXOIy
	K6N8xogSrWXgf+caPuaTcyTu/HoKxBhOAH4xEioZ/VtoLB23tOOEewbT
X-Gm-Gg: AZuq6aIj5Q1zBG8Ie+j7sTIXR0DQ3VQtnofEcFk8V+UpCpK5Ed5P/mWO5fhU27LnXu7
	0KOMrxD/UclounQxhFEhAFx/WSWR+C/66DQ7u3IsUQKz8iDcsr845O6v1gSeCAWN6q0fMzdh1wE
	sCQoVeCBrumPVmaPNTU+ltMpqkClhLuvL3YvWRZ+7l7xh+R07ovkvh/CVNIjme8IwUTfge+1Neq
	xOFmIGaJ1tzeEVFp0alsVSwvVy2b3PxOBV1j4EU1vD4XT0q0JVhv6cp7F1FAWC6Fumh4Ni0dt+e
	hQXA74pseD9Q/f7sGCa/LIsdxhxQJDqI79AYT95UWY4BpGUW3oN8wg3wD4tNv5xwPdUkFEaXU/F
	ZuTbkHqeCMuvqp+GxIneRfUABtbgABNmAD4BaUI8tD/rRC4EuUDTxsNl8XOg8IVNc4Zf22W5HJL
	/DrNRTK9FwSnRFC5aP1tM1wFsOBp3Bc/DXgw==
X-Received: by 2002:a05:600c:a013:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-4803e7f0e39mr133251495e9.30.1769081416765;
        Thu, 22 Jan 2026 03:30:16 -0800 (PST)
Received: from [10.221.200.32] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4358f12ee69sm21557943f8f.11.2026.01.22.03.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 03:30:16 -0800 (PST)
Message-ID: <58fe1908-48de-4bca-ad4e-4976d24581e6@gmail.com>
Date: Thu, 22 Jan 2026 13:30:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] tls: Add TLS 1.3 hardware offload support
To: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, leon@kernel.org
References: <20260121215727.3994324-1-rjethwani@purestorage.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20260121215727.3994324-1-rjethwani@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252305-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ttoukanlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 34AD66668D
X-Rspamd-Action: no action



On 21/01/2026 23:57, Rishikesh Jethwani wrote:
> Hi all,
> 
> This patch series adds TLS 1.3 support to the kernel TLS hardware offload
> infrastructure, enabling hardware acceleration for TLS 1.3 connections
> including KeyUpdate (rekey) support.
> 
> Background
> ==========
> Currently, the kernel TLS device offload only supports TLS 1.2. With
> TLS 1.3 being the current standard and widely deployed, there is a
> growing need to extend hardware offload support to TLS 1.3 connections.
> 
> TLS 1.3 differs from TLS 1.2 in its record format:
> 
>    TLS 1.2: [Header (5)] + [Explicit IV (8)] + [Ciphertext] + [Tag (16)]
>    TLS 1.3: [Header (5)] + [Ciphertext + ContentType (1)] + [Tag (16)]
> 
> The key difference is that TLS 1.3 eliminates the explicit IV and
> instead appends the content type byte to the plaintext before
> encryption. This content type byte must be encrypted along with the
> payload for proper authentication tag computation per RFC 8446.
> 
> Patch 1: TLS 1.3 hardware offload support
> =========================================
> Changes to tls_device.c, tls_device_fallback.c, and tls_main.c:
> 
> - Extended version validation to accept TLS_1_3_VERSION in both
>    tls_set_device_offload() and tls_set_device_offload_rx()
> - Modified tls_device_record_close() to append the content type
>    byte before the authentication tag for TLS 1.3 records
> - Modified tls_device_reencrypt() to use prot->prepend_size and
>    prot->tag_size instead of hardcoded TLS 1.2 values
> - Pre-populated dummy_page with all 256 byte values for memory
>    allocation failure fallback path
> - Updated tls_device_fallback.c to handle TLS 1.3 IV construction
>    (XOR with sequence number) and version-specific AAD sizes
> - Rekey handling: HW offload key update (rekey) is not yet supported.
> 
> Patch 2: Hardware offload key update support
> ============================================
> Changes to include/net/tls.h, net/tls/tls.h, tls_device.c, tls_main.c,
> and tls_sw.c:
> 
> - Extended tls_set_device_offload() and tls_set_device_offload_rx()
>    with new_crypto_info parameter for key updates
> - During rekey, the old HW context is deleted (tls_dev_del) and a new
>    one is added (tls_dev_add) with the updated key material
> - Graceful degradation: if HW key update fails, the connection
>    gracefully degrades to software:
>    * TX: TLS_TX_DEV_CLOSED is set and sk_validate_xmit_skb switches to
>      tls_validate_xmit_skb_sw for software encryption
>    * RX: TLS_RX_DEV_DEGRADED and TLS_RX_DEV_CLOSED are set for software
>      decryption
>    * In both cases, tx_conf/rx_conf remains TLS_HW
> - Record sequence management: during TX rekey, old pending records are
>    deleted and unacked_record_sn is reset to the new rec_seq
> - Split tls_set_sw_offload() into tls_sw_ctx_init() and
>    tls_sw_ctx_finalize() to allow the HW offload RX path to
>    initialize SW context first, attempt HW setup, then
>    finalize (memzero new_crypto_info, call tls_finish_key_update)
> - Added TLS_TX_DEV_CLOSED flag to track TX hardware context state,
>    to avoid double tls_dev_del call, symmetric with existing
>    TLS_RX_DEV_CLOSED.
> 
> Patch 3: mlx5 driver enablement
> ===============================
> - TLS 1.3 version detection and validation with proper capability checking
> - TLS 1.3 crypto context configuration using MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3
> - Correct IV handling for TLS 1.3 (12-byte IV vs TLS 1.2's 4-byte salt)
> - Hardware offload for both TLS 1.3 AES-GCM-128 and AES-GCM-256
> 
> Testing
> =======
> Tested on Mellanox ConnectX-6 Dx (Crypto Enabled).
> 
> Both TX and RX hardware offload verified working with:
> - TLS 1.3 AES-GCM-128
> - TLS 1.3 AES-GCM-256
> - Multiple KeyUpdate cycles (rekey)
> 
> Test methodology: ktls_test : https://github.com/insanum/ktls_test/tree/master
> 
> Please review and provide feedback.
> 

Hi Rishikesh,

This version doesn't compile for us.
A few comments that we wanted to share on V3, but I'll share here as 
this is the latest:

We tested V3 and a few issues were spotted.
We did not debug them though...

We run a server/client test with nginx and wrk.

a.
When requesting 128-bit key, ss output shows "cipher: aes-gcm-256" for 
the respective connection.
For TLS 1.2 it works fine.

b.
On the wrk side, the mlx5 rx_tls_ctx did not increase (meaning no 
offloaded connections were opened). It works fine on the nginx side 
however...
For TLS 1.2 it works fine.

We can share more info if needed.

Regards,
Tariq

> Thanks,
> Rishikesh
> 
> v4:
>    - Split single TLS patch into two separate patches:
>      * Patch 1: TLS 1.3 basic HW offload support
>      * Patch 2: HW offload key update (rekey) support with graceful degradation
>    - Removed record_type check from tls_device_record_close()
>    - Removed Broadcom bnxt_en out-of-tree driver mention
>    - Link to v3: https://lore.kernel.org/netdev/20260102184708.24618-1-rjethwani@purestorage.com/
> 
> v3:
>    - Added note about Broadcom bnxt_en out-of-tree driver used for testing
>    - Link to v2: https://lore.kernel.org/netdev/20251231192322.3791912-1-rjethwani@purestorage.com/
> 
> v2:
>    - Fixed reverse Christmas tree ordering in variable declarations
>    - Combined 'err' and 'i' declarations (reviewer feedback)
>    - Link to v1: https://lore.kernel.org/netdev/20251230224137.3600355-1-rjethwani@purestorage.com/
> 
> Rishikesh Jethwani (3):
>    tls: add TLS 1.3 hardware offload support
>    tls: add hardware offload key update support
>    mlx5: TLS 1.3 hardware offload support
> 
>   .../mellanox/mlx5/core/en_accel/ktls.h        |   8 +-
>   .../mellanox/mlx5/core/en_accel/ktls_txrx.c   |  14 +-
>   include/net/tls.h                             |   4 +
>   net/tls/tls.h                                 |  14 +-
>   net/tls/tls_device.c                          | 319 +++++++++++++-----
>   net/tls/tls_device_fallback.c                 |  34 +-
>   net/tls/tls_main.c                            |  31 +-
>   net/tls/tls_sw.c                              |  77 +++--
>   8 files changed, 379 insertions(+), 122 deletions(-)
> 


