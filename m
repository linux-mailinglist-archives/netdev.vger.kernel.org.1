Return-Path: <netdev+bounces-301514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XTKoF8oJO2pePAgAu9opvQ
	(envelope-from <netdev+bounces-301514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 00:33:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D43C16BA6E4
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 00:33:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bynar.io header.s=google header.b=Uadk5vg0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301514-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301514-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bynar.io;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8FEC3013D58
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7280A3749F0;
	Tue, 23 Jun 2026 22:33:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F069E1DE4FB
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 22:33:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782254010; cv=none; b=QZ2+7JZK96RpWvcU1LW7D34+06607cqAKWd8XiUku2+I3/Ji+fgPOGYDVj+czJ0HJREv0GvZznn3F4IRx0zXVFsCW1UF+IJR4j9brVowKEZg3P5UhJuUyIDgR1lHFjiMr7oryK0vNehgbSl/NJYMq9uVE5G6UDGRWTvfK2o3iBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782254010; c=relaxed/simple;
	bh=28fitR7AD3p5MIhLTudcCTvDU4SWVERttyDPYSu3Y2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEk7s8oU6hKinSYbE09VYMz2ChdUPUD7sY3si46bXerUiWEve+Abm02PvwbdAIA8QqvxGLOm+O5QcqjgIBjA+wafmLFgK8UqFZBQwoLICWoFSVlnAcC1jlobCe8Gvu8A5W7x1Voppa/loEJTKjZ7VyVvEHV4PHyivUMIonqI8XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=Uadk5vg0; arc=none smtp.client-ip=209.85.208.48
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-697b8540279so567097a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782254006; x=1782858806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQe2zkk4/rX7iIUXwjPWxzQOps0a3V9iYGHKEVDhy8o=;
        b=Uadk5vg0yJWg2f0ravOpdU6TFLnE+Zs1Qj//ttPrWAU5ID4ir4XOez7+9m/cVncHnD
         hMLvA6JzzmZRNemRVK95Xg9Lp2eslpmGJdgSsJiKd4NKMOfT3iitXR/xPXgPyy90j77s
         bg1QPPidpUWBBNBAtfSMcgJXPVDDVqZMt2fTJIwR8mNiesAmvKTHihsOfe8ygezqUZ9r
         0U+2XtdhFo84EfEIecd/lEkzWy7I9ao1y8TAmMk7uAijQLnXu/LX3xZf61hL3a88R5fY
         Yuy1ItkWGm84kIEo+IteHVdOy1eCxfcz2Y9I0doz3uBaADi6JNaF8KpcyG7A8stHiPSn
         1f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782254006; x=1782858806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQe2zkk4/rX7iIUXwjPWxzQOps0a3V9iYGHKEVDhy8o=;
        b=dz+iPZrkVH5GuTIq5kit6AY8TKCRGbtsU0TYwOFv+l451oBw1OG023Hdj2CChKmBTI
         JXZdwEdPjS00vBB+i8uzzX0/sFnR6Iq4rgorx8m8VBaeH6CSq4KUZPNmvMU+lO52muR7
         CWAue2be0+yKyBGedWG2pzWmC9ihmVra3Dh4SN4tgTGL9MQ5GNlR/LFeZMA/txlQvcTF
         GeEf/u598Rv1zy/blsbOPL1qmH4JC0vTFHTHiTLLcdaYJb6hdT1j/zf23ZDsLBCikeyU
         uqKHm3AbrtRNwnimk2dTkebs2fOcH/PCVSo7PQgh50Im8hKVNvwL8yTGxsvFnVYRoebC
         T8nw==
X-Forwarded-Encrypted: i=1; AFNElJ/Q25QiYm/BQzCcT5auDDHpbvFchg8xF7CfwV1I1KtqJKJknZv+QFz3i8kOyqNVb0r+3L7+abU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xvyDlGHqnTvXINl2SD4vsK0wRKw2uiMrKfj2fzqGFLDLNWpq
	LD6izLIyefZ4Fb6NXuzqLJ0H3iFgULNDmUJdTCbfstzDE6YwYQ+tG++YEMsQGMW8Wuh9
X-Gm-Gg: AfdE7cn+GwTZaJTerCtuEpFYa3GauDKbYsyOKS0/GnfqGomBkj5bRqzNpn5Wez5h/Dq
	oOMR8HrS3SfMHWoxXth2jf/SS4n7t5jHCzejKo4ZmMnZkaNHNNDVCTYznjsUaMX5ZXCMw7U9ZtB
	MmnOj0MdgwTwd81Wp/ZmfEgJ5VAGQ2oemJ31fs5PRCg7XjqFagIE3xWqU55UWFQ+kZ3UPNkuNfh
	XhC2WNdDKzA0wKDbt+pYjyC5gOZtG92L4YxT4hALfJeCfB3vSEJGuJfZHAwZ3+GjgtDhlTg2F2H
	q8HOJVEf4DJfRoIrweXulezvhQfGRjNJsnER4dyL60e/Hp7RLRx0FNIbIJ8vvxO2rYRStqK1MaK
	Rsjtg6aZZ+9Pk0n2Lyw3lmoNApuEnZpNCImW22hnDTcdb5UlTObqDhN9fLpsmJUCk0pqfK19pCe
	2abVlcpH6FOuaa11g8fKxKzUGSWKaDI/T5/JbuoQMqnODWV//77EZZmD5M
X-Received: by 2002:a05:6402:190b:b0:697:98dc:1196 with SMTP id 4fb4d7f45d1cf-697db815650mr2261536a12.0.1782254006268;
        Tue, 23 Jun 2026 15:33:26 -0700 (PDT)
Received: from ?IPV6:2a06:61c2:d427:0:b321:1c7a:b072:326e? ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f4bd44d0sm125957a12.29.2026.06.23.15.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 15:33:23 -0700 (PDT)
Message-ID: <443e2ee1-e9c1-45ca-be57-0c67966ec7d9@bynar.io>
Date: Wed, 24 Jun 2026 00:33:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] nfc: nci: fix out-of-bounds write in
 nci_target_auto_activated()
To: Simon Horman <horms@kernel.org>
Cc: david@ixit.cz, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260622145243.3167276-1-sam@bynar.io>
 <20260623172109.1105965-2-horms@kernel.org>
Content-Language: en-GB
From: Sam P <sam@bynar.io>
In-Reply-To: <20260623172109.1105965-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bynar.io,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bynar.io:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bynar.io:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301514-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:david@ixit.cz,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam@bynar.io,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bynar.io:dkim,bynar.io:mid,bynar.io:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D43C16BA6E4

On 23/06/2026 19:21, Simon Horman wrote:
>> diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
>> index c96512bb86531..566ca839fa488 100644
>> --- a/net/nfc/nci/ntf.c
>> +++ b/net/nfc/nci/ntf.c
>> @@ -603,6 +603,12 @@ static void nci_target_auto_activated(struct nci_dev *ndev,
>>       struct nfc_target *target;
>>       int rc;
>>
>> +    /* This is a new target, check if we've enough room */
>> +    if (ndev->n_targets == NCI_MAX_DISCOVERED_TARGETS) {
>> +        pr_debug("not enough room, ignoring new target...\n");
>> +        return;
>
> [Severity: High]
> Does this early return cause the state machine to stall?
>
> Looking at nci_rf_intf_activated_ntf_packet(), the state is transitioned
> to NCI_POLL_ACTIVE right before this function is called:
>
> net/nfc/nci/ntf.c:nci_rf_intf_activated_ntf_packet() {
>      ...
>      atomic_set(&ndev->state, NCI_POLL_ACTIVE);
>      if (err == NCI_STATUS_OK)
>          nci_target_auto_activated(ndev, &ntf);
>      ...
> }
>
> Because of the early return here, nfc_targets_found() is skipped. Does this
> leave the state wedged in NCI_POLL_ACTIVE, permanently blocking future
> attempts to stop polling since nci_stop_poll() requires the state to be
> NCI_DISCOVERY?
>
>> +    }
>> +
>>       target = &ndev->targets[ndev->n_targets];
>
> [ ... ]

Thanks for sharing the review.

I don't believe the early return can stall the state machine, as
nci_target_auto_activated() does not touch ndev->state.

nci_rf_intf_activated_ntf_packet() sets ndev->state = NCI_POLL_ACTIVE
before it calls nci_target_auto_activated(), so the transition has
already happened by the time the new check runs. Neither
nci_target_auto_activated() nor nfc_targets_found() modifies ndev->state;
nfc_targets_found() only clears the nfc_dev dev->polling flag under
device_lock, which is independent of the NCI state machine that
nci_stop_poll() tests. So ndev->state is NCI_POLL_ACTIVE after an
auto-activation whether the target is appended or the guard returns
early; the state behaviour is the same with or without this patch.

The check is the same n_targets == NCI_MAX_DISCOVERED_TARGETS guard the
sibling nci_add_new_target() (the RF_DISCOVER_NTF path) has used since
the Fixes: commit; it only drops the out-of-spec 11th+ target, which a
conformant controller shouldn't produce. The device still returns to
NCI_DISCOVERY/NCI_IDLE through the normal RF_DEACTIVATE path.

> [Severity: Critical]
> This isn't a bug introduced by this patch, but can the ntf union copy
> uninitialized stack memory into persistent device structures?
>
> In net/nfc/nci/ntf.c:nci_rf_discover_ntf_packet(), the local ntf struct
> is declared on the stack:
>
>      struct nci_rf_discover_ntf ntf;
>
> If the incoming packet has ntf.rf_tech_specific_params_len == 0, the
> extraction routines are bypassed, leaving the rf_tech_specific_params union
> uninitialized. The struct is then passed to nci_add_new_target():
>
>      if (add_target == true)
>          nci_add_new_target(ndev, &ntf);
>
> This eventually calls nci_add_new_protocol(), which blindly reads from this
> union:
>
>      nfca_poll = (struct rf_tech_specific_params_nfca_poll *)params;
>      target->sens_res = nfca_poll->sens_res;
>      target->sel_res = nfca_poll->sel_res;
>      target->nfcid1_len = nfca_poll->nfcid1_len;
>
> Could this uninitialized stack garbage be copied into ndev->targets, and
> later broadcasted to userspace via Netlink in nfc_targets_found()?

I managed to repro this issue locally via KMSAN, I can queue up a patch
for this that I can submit separately, ntf just needs to be zero-initd.

> [Severity: Critical]
> This isn't a bug introduced by this patch, but does the general bytes length
> calculation underflow?
>
> In net/nfc/nci/ntf.c:nci_store_general_bytes_nfc_dep():
>
>      ndev->remote_gb_len = min_t(__u8,
>          (ntf->activation_params.listen_nfc_dep.atr_req_len -
>           NFC_ATR_REQ_GT_OFFSET), NFC_ATR_REQ_GB_MAXSIZE);
>
>      memcpy(ndev->remote_gb,
>          (ntf->activation_params.listen_nfc_dep.atr_req +
>           NFC_ATR_REQ_GT_OFFSET), ndev->remote_gb_len);
>
> The length is computed by subtracting NFC_ATR_REQ_GT_OFFSET (14) from
> atr_req_len. If atr_req_len is less than 14, this subtraction will
> underflow.
>
> Because of the min_t cast, this large underflowed value is bounded to
> NFC_ATR_REQ_GB_MAXSIZE (48). The memcpy() then copies 48 bytes starting
> from atr_req + 14 into ndev->remote_gb.
>
> Since the source buffer is part of the ntf union allocated on the stack
> in nci_rf_intf_activated_ntf_packet(), could this leak up to 48 bytes of
> uninitialized kernel stack memory to userspace?

This one is already being fixed on the list:

[PATCH net v4 1/5] nfc: nci: fix u8 underflow in
nci_store_general_bytes_nfc_dep  (Lekë Hapçiu)
https://lore.kernel.org/all/20260424180151.3808557-2-snowwlake@icloud.com/

> [Severity: High]
> This isn't a bug introduced by this patch, but does the lack of skb->len
> validation in NCI response handlers allow out-of-bounds reads?
>
> In nci_core_init_rsp_packet_v1() in net/nfc/nci/rsp.c, fields are read
> and arrays are copied from the payload:
>
>      ndev->num_supported_rf_interfaces =
>          rsp_1->num_supported_rf_interfaces;
>
>      memcpy(ndev->supported_rf_interfaces, rsp_1->supported_rf_interfaces,
>             ndev->num_supported_rf_interfaces);
>
> Similarly in nci_core_init_rsp_packet_v2():
>
>      while (rf_interface_idx < ndev->num_supported_rf_interfaces) {
>          ndev->supported_rf_interfaces[rf_interface_idx++] =
>              *supported_rf_interface++;
>      }
>
> Since the NCI control header is stripped via skb_pull(), leaving the
> payload length in skb->len, what happens if an NFCC sends a short response
> packet (e.g. plen = 1)? Could this cause the handlers to read adjacent
> kernel slab memory?

I've since submitted a fix for this issue:

[PATCH net] nfc: nci: fix uninit-value in
nci_core_init_rsp_packet()
https://lore.kernel.org/netdev/20260623222402.175798-1-sam@bynar.io/

> [Severity: High]
> This isn't a bug introduced by this patch, but is there a missing boundary
> validation when extracting activation parameters?
>
> In net/nfc/nci/ntf.c:nci_extract_activation_params_iso_dep():
>
>      nfca_poll->rats_res_len = min_t(__u8, *data++, NFC_ATS_MAXSIZE);
>      if (nfca_poll->rats_res_len > 0) {
>          memcpy(nfca_poll->rats_res, data, nfca_poll->rats_res_len);
>      }
>
> And in nci_extract_activation_params_nfc_dep():
>
>      poll->atr_res_len = min_t(__u8, *data++, NFC_ATR_RES_MAXSIZE - 2);
>      if (poll->atr_res_len > 0)
>          memcpy(poll->atr_res, data, poll->atr_res_len);
>
> These inner lengths are bounded by a maximum size like NFC_ATS_MAXSIZE, but
> they are not validated against the remaining bytes in the SKB (skb->len).
>
> If a malformed packet provides a large inner length but a short payload,
> could this memcpy() read out of bounds into the device structure,
> potentially leaking adjacent slab memory to userspace later?

This one is already being fixed on the list too:

[PATCH v3] nfc: nci: add data_len bound checks to activation
parameter extractors  (Bryam Vargas)
https://lore.kernel.org/all/20260612-b4-disp-6d52d8b0-v3-1-e26221f8826d@proton.me/

> [Severity: High]
> This isn't a bug introduced by this patch, but is there a potential
> priority inversion or timeout deadlock involving the device lock?
>
> Functions like nfc_stop_poll() in net/nfc/core.c acquire the device lock:
>
>      device_lock(&dev->dev);
>      ...
>      if (dev->ops->stop_poll)
>          dev->ops->stop_poll(dev);
>
> This eventually calls nci_request(), which synchronously waits for a
> completion signaled by the nci_rx_work thread. However, if an NTF packet
> is received first, nci_rx_work processes it and invokes
> nfc_targets_found(), which also attempts to acquire the device lock:
>
>      device_lock(&dev->dev);
>
> Since the calling thread already holds the device lock, nci_rx_work blocks
> indefinitely. Because the RX worker is blocked, it cannot process the
> pending RSP, causing nci_request() to time out and fail. Could this
> deadlock the RX thread?

No patch for this one, although I'm not sure how accurate it is.

Thanks,
Sam

