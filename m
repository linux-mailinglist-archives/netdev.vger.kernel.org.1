Return-Path: <netdev+bounces-291101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SM3iOW2cEWq/oAYAu9opvQ
	(envelope-from <netdev+bounces-291101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:24:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED14A5BEDFF
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4B2A3008448
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 12:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED84D396D14;
	Sat, 23 May 2026 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o74NdlAO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ED739659A
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779539047; cv=none; b=foUXJC9b//loCfX3FNYO1lWAZ4bEwLXvZ/FnRNq6Aw2/o8dcHaS0/Hbn3V0IkCXJRTyr05jz11+a2419wex50MldXKt+1M+gFB7R679lnFDACUBont7hQLocSVFOBH21ku+I7gZ4b+oWZKV5RTNXd0ZS4ff9jvprZlNHI+hKP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779539047; c=relaxed/simple;
	bh=8rJY2Ypo57R1HTvGgB8L4jUKXcQhCUj/+EHwQuN+KV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgqPARq0O90scXG9LuGqXTt0LWrclGffoaACCyUWr2iUg9zZ9U/QTWmyFYxIVlr01Rn5wV+f6QoDFdCZOAyWz9dcqyWcjxLaYbRt8AhAVdN9AZL5v6TAiMa21N5tyXDI41OYzTDIE1eNMMogJAluktJfFJHW6qD1Y92VvLA/Hhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o74NdlAO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2be1dd4af34so68747915ad.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 05:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779539045; x=1780143845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BUftknpjAzJRHNFFrDtQsWg7bJX0Pe38bqsMwsZfQGk=;
        b=o74NdlAOj3ICbxFo4EkbTJq2LrnAthPzBqOHmIW0z3gIdN7nRnYN4mOMPttEmGjl9a
         SUQnbYqNoul5Qy0sYZE+QEFITIXO6EKjb6YiwINqJnkZmUuKna7dDw9aG3ZLop0667Je
         VBgeqFBTFibjFadTOcgU7RCkT45qowHFtHtYsoDrDtLK9nzxsg3YIt1LtHWsDkr9gLaZ
         5fgDqzCusqT6GXm+ZQ7vKi8qs1jEk20eMGzULgwREunOpecmeIzulgujkgzfHlOL3bGR
         LeEn3VsjMKpmIBc1jKlDm5727vWTEEKrscKH19pNw/S/GASyRyj+4IVWuiNqB1oHjzeU
         PRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779539045; x=1780143845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUftknpjAzJRHNFFrDtQsWg7bJX0Pe38bqsMwsZfQGk=;
        b=agicr2lTxmSPsks9hub64bXh7dZkQpi6Tw+ENQxADqigF0lBefwoPiF2zyQn8nPmIW
         1IhBbMBXbyRD8soTHTm8ss6ZliQ7pr1XdkbALkTOgsW77L2xx72Kdn91p7oMOcMCpA1D
         1s5TZf6cRsy/cul0M639MVotHyiFiOpw4vZR+1VSQrUMShWIwAyxzOHWkNEvobxK9bB8
         PVLZJUX40I9ioTSMPgrZuSFAE9oOdFBqhmWp2DZ4q8EqSU9I4jyfOfFo4/i2xBsATXAL
         rEbKtcukPmZF0TLKRWneUPf4WnBDjQrUB8w6u6Mun9QD605dkw020G1Ako7AnzOmHShh
         A5WQ==
X-Forwarded-Encrypted: i=1; AFNElJ9B38aoaRRk7pUFzVcubP+GR2sOHp0+C2GGE9b2KZ0oIuAi4DppvtOQ/tytq605xBvnJe4EN3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFdASXIdwOMIvuH+ZmKBHBfB/JMZ8nW6J0NS3/fuEZi5hOhtep
	1+1zD4yiY5+gCb6pLzaxPG5MzmNaZDe7Si7o1jtKTK19g/TAo3YWRHvc
X-Gm-Gg: Acq92OGv3A/ywJvGkJ97a7Ffgr60fQBSpRPh5Egh4LoUCmYn8gHWToijOMBnrqRWco2
	EujBpIlWV/o4HEf/rC6ZtL7VSux4F8UWYd9g/Ox1n9n8v2JWvgaDP+3cWbtjZM2oc/5PBPKpnkE
	si72BL0E0Qsq8CFKm2YtZSnV70q9R3aKl8ELQ8Rq6cEtHvlVlEuEqnNiehn6kwv0pebSfHGft2X
	OjGa+4YkyKFgiBHFjEPLEgAGQSkhT4aDFFhgSMWkJtNEyvmngcNxkGSr+SQU26UwzDtwyAMa9Sk
	c/nxsy4EpbHFjsK72eS768AWRQebzNOomMqRuDi3+dMvyhXV060aUdvzAFTVSRLgKVNs10ExCqx
	GIqLogHOSuM6JbQ4lReqw/iGf0nnxpY+vzgpx2b2/etJdFtJ0FivjWyc9rVWNV2e7MmIQp4JG6d
	wxYiEz0Cvkemow80bkxdW7Y9QbEpc8CBVulQ==
X-Received: by 2002:a17:903:440f:b0:2b0:67a7:5c4b with SMTP id d9443c01a7336-2beb0603fbemr81368385ad.28.1779539044856;
        Sat, 23 May 2026 05:24:04 -0700 (PDT)
Received: from [192.168.89.2] ([125.149.177.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b2ebcsm45002225ad.49.2026.05.23.05.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 05:24:03 -0700 (PDT)
Message-ID: <5315a2f6-3504-4660-8a64-51f7f6b69a45@gmail.com>
Date: Sat, 23 May 2026 21:24:00 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add packet-mode ESP offload for Airoha/EIP93
To: Christian Marangi <ansuelsmth@gmail.com>,
 Antoine Tenart <atenart@kernel.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <20260523121522.3023992-1-hurryman2212@gmail.com>
Content-Language: en-US
From: Jihong Min <hurryman2212@gmail.com>
In-Reply-To: <20260523121522.3023992-1-hurryman2212@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291101-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,gondor.apana.org.au,davemloft.net,lunn.ch,google.com,redhat.com,secunet.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hurryman2212@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ED14A5BEDFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/23/26 21:15, Jihong Min wrote:
> This series adds the missing plumbing for ESP offload engines that
> operate on whole ESP packets instead of only exposing AES/HMAC through
> the crypto API AEAD interface.
> 
> The normal ESP software path can already call into accelerated AEAD
> algorithms, but packet-mode engines such as EIP93 can also generate and
> consume ESP packet framing: padding, pad length, next header and ICV.
> That needs a slightly different XFRM offload contract so the netdev
> driver can hand the skb to a packet backend rather than trying to make
> hardware fit the software trailer layout.
> 
> Patch 1 extends the ESP offload infrastructure for packet engines while
> preserving the existing behavior for drivers that do not opt in.
> Patch 2 exposes an EIP93 ESP packet backend for encapsulation and
> decapsulation.
> Patch 3 wires Airoha Ethernet GDM netdevs and DSA user ports to that
> backend through xfrmdev_ops. ESP GSO and ESP TX checksum offload remain
> disabled.
> 
> Runtime testing was done on a Gemtek W1700K2 running OpenWrt with the
> same changes applied on top of a 6.18.31-based kernel.
> 
> Test parameters:
> 
>   - Static IPv4 transport-mode XFRM SAs between the AP and host.
>   - ESP transform: auth hmac(sha1), enc cbc(aes) with a 128-bit AES key.
>   - iperf3 TCP test, AP as client and host as server:
>         iperf3 -c <host_ip> -P 4 -t 10
>   - The host always used normal Linux XFRM software processing.
>   - With AP ESP offload disabled, the AP also used the Linux XFRM
>     software path; in this setup, EIP93-backed AEAD crypto was still
>     available to that path.
> 
> Network-relevant test setup:
> 
>   - AP: Gemtek W1700K2, Airoha AN7581/EN7581, 4x Arm Cortex-A53 at
>     1.4 GHz, 2 GiB RAM, airoha_eth wan (GDM2) netdev, 10Gb/s full-duplex,
>     MTU 9200, EIP93 crypto and IPsec packet engine present.
>   - Host: AMD Ryzen 9 9950X3D, 16 cores/32 threads, Open vSwitch,
>     MTU 9978, backed by a ConnectX-6 Dx 10Gb/s full-duplex link.
> 
> AP to host iperf3 result:
> 
>   AP offload      Sender          Receiver        Retransmits
>   on              918.2 Mbit/s    913.6 Mbit/s    0
>   off             782.4 Mbit/s    778.6 Mbit/s    3569
> 
> This is a 17.3% receiver-side throughput improvement for the AP TX ESP
> path in this setup, with retransmits eliminated in the offloaded run.
> 
> Jihong Min (3):
>   xfrm: extend ESP offload infrastructure for packet engines
>   crypto: inside-secure: add EIP93 ESP packet backend
>   net: airoha: add EIP93-backed ESP XFRM offload
> 
>  MAINTAINERS                                   |    1 +
>  drivers/crypto/inside-secure/eip93/Kconfig    |   10 +
>  drivers/crypto/inside-secure/eip93/Makefile   |    1 +
>  .../crypto/inside-secure/eip93/eip93-ipsec.c  | 1413 ++++++++++++++++
>  .../crypto/inside-secure/eip93/eip93-main.c   |   69 +-
>  .../crypto/inside-secure/eip93/eip93-main.h   |   38 +-
>  drivers/net/ethernet/airoha/Kconfig           |   11 +
>  drivers/net/ethernet/airoha/Makefile          |    1 +
>  drivers/net/ethernet/airoha/airoha_eth.c      |   51 +-
>  drivers/net/ethernet/airoha/airoha_eth.h      |   69 +
>  drivers/net/ethernet/airoha/airoha_xfrm.c     | 1474 +++++++++++++++++
>  include/crypto/eip93-ipsec.h                  |  132 ++
>  include/linux/netdevice.h                     |    3 +
>  include/net/xfrm.h                            |    8 +-
>  net/ipv4/esp4.c                               |    6 +-
>  net/ipv4/esp4_offload.c                       |   29 +-
>  net/ipv6/esp6.c                               |    6 +-
>  net/ipv6/esp6_offload.c                       |   29 +-
>  18 files changed, 3324 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/crypto/inside-secure/eip93/eip93-ipsec.c
>  create mode 100644 drivers/net/ethernet/airoha/airoha_xfrm.c
>  create mode 100644 include/crypto/eip93-ipsec.h
> 

One note I should have included in the cover letter:

The hardware behavior used by this series was studied from the out-of-tree
IPsec branch of the mtk-eip93 driver:

  https://github.com/vschagen/mtk-eip93/tree/ipsec

That code was useful for understanding the EIP93 packet-mode ESP descriptor
programming and SA record values.

This series is not a direct import of that driver. The implementation was
rewritten around the current upstream driver layout and the Linux XFRM
netdev offload model, with EIP93 exposed as a packet-mode ESP backend used
by the Airoha netdev driver.


Sincerely,
Jihong Min

