Return-Path: <netdev+bounces-289347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKFVISEpDGq0XwUAu9opvQ
	(envelope-from <netdev+bounces-289347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:10:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E02DD57AF8C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE80B306AA6E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1608A3EFFB6;
	Tue, 19 May 2026 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJDZ7GjJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aeNq+G74"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FF3EFD1E
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779181172; cv=none; b=k60+Z++0PeGAitmm9rX1YE6c7zrsDSETJD8rfcqfKYTbsw5s/RHJGjDrClUBgeHRpIoMcWClA8n7mcXLFL+MLvpb+U1knXbgAj3F8WaLFViP767lcVfLnwDF64iaHRtjG+kmCe3v0snc9B83NQYXm5GQrn37F1/+BvGbJEXIfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779181172; c=relaxed/simple;
	bh=OhUuxdYnQ8EXDp+B9zkq4d55hNYbQ3Iucnfakt2Snus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEUVFiwMIec7RjNi3tIpdxUcRAn5A60Lr/iJXLrTff1o7xTQuuEOMmxySo4VX/t9kg/PCJ2fAiv/Lc9c9Bhh4o3E15hWVO9VNIVi6Yv0xlsc82w72bC/YE6rdfv6Au8oi8wEjhKpa4XNwT+oHiekhHQOzxMMH75xyMAymqSgIcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJDZ7GjJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aeNq+G74; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779181170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irXYXDyVAxFofevikDhz7cEViUnT1Nau5kq84wR5sdQ=;
	b=YJDZ7GjJKRCYwdz7zw8i+Fea20dNvQlAixo8FgXhmBWCzoO/tD/3BI7pzZqSwDcU09Rcq7
	+X3p6LFgdCwo/1a5BL/mtM4EF6G9Q5sNZtlzv6RHJoU5a2rdJl7oklF4c+dq0NcSfLYyqe
	Crc1ftC65HMGsZMwMVrPP1D02o2aNb8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-SWywvPTwOQSZZ5EM1DfycQ-1; Tue, 19 May 2026 04:59:28 -0400
X-MC-Unique: SWywvPTwOQSZZ5EM1DfycQ-1
X-Mimecast-MFC-AGG-ID: SWywvPTwOQSZZ5EM1DfycQ_1779181168
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d1b5bca0so13121845e9.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 01:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779181167; x=1779785967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=irXYXDyVAxFofevikDhz7cEViUnT1Nau5kq84wR5sdQ=;
        b=aeNq+G74yU4iBHpFkSdu8bJ7ROW9BR2PFUh07Hj/nKeZ7cggzwvF/svd3YpJzXHprJ
         51PDS3VQHqFRbKdwYVOl6UHK05XW9Qrb99uhbxTmhvy/FF4WL8F3c09L/Zxm1CieO/b3
         9/ZCmE1PmrDsSkkYpfAHdMwhDjhTbvlBXfVEissTpgWZGnm34VeziEka7cMJ/GI9SWKq
         FAdurmqn8g8aw/Li7Khti1P55Y1obchv5k5gaZLIx8XuxliTgCHklp9IRV7VydyUbK4T
         9Q5QO2TrXtx2PvNOgNVkciV9P5phDbZfRWpKw+YrBrE/Rtd+od/jf8xgPXOvKcKsTVjX
         lGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779181167; x=1779785967;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irXYXDyVAxFofevikDhz7cEViUnT1Nau5kq84wR5sdQ=;
        b=FfCnjF3ITxqqW5s2R9w6cUjFcFVaRuXBSkkdq9W6wichIb/WsEEnPqpuz1hDF2eKIG
         AwyTHL3GcJMSOQF7FpZRQR0uFxHC+mAUJ3hwSAnRvbv7vg4pAJAMLnXr6EN3ClBjQdat
         g4DyMc8S9EEpScuqGWBQgbT9mqTjlzf7T1Itoq4U6Ui+pOiIVoF3c9e3ZrKSzMdLYd7b
         H9smpnRTeRZhu44dTqXvgWxSLVErcwOid8kLFn3Fbpfdn2FfYGwJK30bVQBfA84pMY5X
         o1fYT7c8o2FSCtTSk9n5T4OiSdgZA5sTWv3RXmX1iyUuklC6H6nMuv4+Y+OyjAw5fL/J
         b5wA==
X-Forwarded-Encrypted: i=1; AFNElJ+PslBz7AeNUNtWntpmb+xXYuxojQEMV7lupBU5ddIrlJeQXrAZspPa8inzp/Ouy7DvWEKLErQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR5EBNlZYL+f/oROMyDPgrmO+95p+wkO9k/aZq3uyr2DxF4VlQ
	dw0BR+FH6/SoawroZ6UEIts1DQviRMFNAZ49+ZnkmVwsTYu2GDoed+TI0vBdhE5RCbJfkEcokgs
	RbcoSCR7tl0y4dLGEts/XrmEqsj4KECe3LqEeT5D03RTGsyIdU+EvjhNUjw==
X-Gm-Gg: Acq92OHR5N4vZ/oqvIXMdfJKDuTnItTtJj5XJsTy13MYEHs4UpZZEkNZtVcVdGEeHHw
	/vWJOqZLNaNpx2ogNh0ZdJSSrgYqBJiksCZE8XX1B3dCirlz2fDUiK8bn/hQWQwOLkXodw8M+Ca
	Mvt5GfhbJC3uFMNdLy1v5Rzik5CywsPjO8fs80e2WJKw+xL+8psuaD8KLOxEn2Ev2KRFQPo3zgc
	DhZR5emMvMEYZRYdWzrCsjzBTTUkHD3D38GFPSRw8Sl8bW2lshfKu4PpqQyY1HQrW/jgYSizkts
	f5hsxE/uisoz6CTufgCl4qaXE9ed38T7HrEeZelVQ5eJRTDTYXL3ohqX10sBZ0Ujf62wYxPAT4I
	ivsxljX6oGGFGMTKN5HyIicR0setW2WCEmeH7qGriDzy2r7oTg34kbe6W3eOIekFmkQ==
X-Received: by 2002:a05:600c:35c5:b0:48f:f64c:c314 with SMTP id 5b1f17b1804b1-48ff64cc4d1mr236441705e9.30.1779181167592;
        Tue, 19 May 2026 01:59:27 -0700 (PDT)
X-Received: by 2002:a05:600c:35c5:b0:48f:f64c:c314 with SMTP id 5b1f17b1804b1-48ff64cc4d1mr236441125e9.30.1779181167116;
        Tue, 19 May 2026 01:59:27 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53ab6aasm335423085e9.2.2026.05.19.01.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 01:59:26 -0700 (PDT)
Message-ID: <b670ecc3-8ace-49ac-ab7f-c36d6af29d8d@redhat.com>
Date: Tue, 19 May 2026 10:59:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 net-next 5/9] octeontx2-af: npc: cn20k: add subbank
 search order control
To: Ratheesh Kannoth <rkannoth@marvell.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, oss-drivers@corigine.com
Cc: akiyano@amazon.com, andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com,
 arkadiusz.kubalewski@intel.com, brett.creeley@amd.com, darinzon@amazon.com,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 horms@kernel.org, idosch@nvidia.com, ivecera@redhat.com, jiri@resnulli.us,
 kuba@kernel.org, leon@kernel.org, mbloch@nvidia.com,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, petrm@nvidia.com,
 Prathosh.Satish@microchip.com, przemyslaw.kitszel@intel.com,
 saeedm@nvidia.com, sgoutham@marvell.com, tariqt@nvidia.com,
 vadim.fedorenko@linux.dev
References: <20260514062537.3813802-1-rkannoth@marvell.com>
 <20260514062537.3813802-6-rkannoth@marvell.com>
 <agbKuUI4m1Wtnti_@rkannoth-OptiPlex-7090>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <agbKuUI4m1Wtnti_@rkannoth-OptiPlex-7090>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-289347-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E02DD57AF8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/15/26 9:26 AM, Ratheesh Kannoth wrote:
> On 2026-05-14 at 11:55:33, Ratheesh Kannoth (rkannoth@marvell.com) wrote:
>>> +    restrict_valid = false;
>>> +
>>> +    for (prio = 0; prio < cnt; prio++) {
>>> +            sb_idx = narr[prio];
>>> +            sb = &npc_priv.sb[sb_idx];
>>> +            sb->arr_idx = prio;
>>> +
>>> +            /* erase entry if exist */
>>> +            xa_erase(&npc_priv.xa_sb_free, sb->arr_idx);
>>> +            xa_erase(&npc_priv.xa_sb_used, sb->arr_idx);
>>> +
>>> +            xa = &npc_priv.xa_sb_free;
>>> +            if (sb->flags & NPC_SUBBANK_FLAG_USED)
>>> +                    xa = &npc_priv.xa_sb_used;
>>> +
>>> +            /* if xa_store() fails due to memory pressure, there is
>>> +             * no point in rolling back, as roll back may also fail
>>> +             */
>>> +            rc = xa_err(xa_store(xa, sb->arr_idx,
>>> +                                 xa_mk_value(sb_idx), GFP_KERNEL));
>>> +            if (rc) {
>>> +                    dev_err(rvu->dev,
>>> +                            "Setting arr_idx=%d for sb=%d failed\n",
>>> +                            sb->arr_idx, sb_idx);
>>> +                    goto fail;
>>> +            }
>>> +    }
>> Does this error path leak subbank resources and leave the xarrays in a
>> corrupted state?
>> If xa_store() fails, the function jumps to the fail label and aborts
>> without restoring the original state. Because the entry at the current
>> priority index was already erased via xa_erase(), but the new subbank
>> failed to store, that subbank is permanently lost.
>> Additionally, the subbank that failed to store is left with a modified
>> arr_idx pointing to an empty slot, potentially breaking future allocations.
>> Could this function preallocate resources (such as using xa_reserve()) or
>> build temporary xarrays to ensure the changes can be applied atomically
>> without a destructive intermediate state?
> 
> The omission of a transactional rollback path is intentional due to
> the systemic implications of a GFP_KERNEL allocation failure inside
> the xarray core. If xa_store() returns an ENOMEM error, the underlying
> slab allocator is already exhausted, meaning any programmatic attempt
> to erase or restore original indices would also fail, compounding the
> unpredictable state.
> 
> Because this devlink callback operates under the top-level mcam->lock
> mutex, no concurrent allocation or translation worker can read the
> partially modified xarrays while the driver is in this degraded state.
> An xa_store() failure indicates a fatal, system-wide memory leak or
> exhaustion event. At this threshold, the driver prints a critical
> error payload to dmesg to allow deterministic post-mortem debugging of
> the host's global memory subsystem, rather than attempting an unreliable
> in-kernel rollback.

I'm sorry, but I don't agree with your statement above: allocation may
fail under memory pressure, and memory pressure can be transient; it
should not brick the driver requiring a reload.

Additionally I think it should be possible to handle gracefully the
failure inverting the order of xa_store() and xa_erase() and performing
the latter only on the relevant xarray (i.e. xa_sb_used when store
operates on xa_sb_free, and vice versa).

/P


