Return-Path: <netdev+bounces-284266-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DijKhit+Wky+wIAu9opvQ
	(envelope-from <netdev+bounces-284266-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:40:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C244C8C6E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6E77303C7C1
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10933128D7;
	Tue,  5 May 2026 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1br+6yq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WAWU2/Yv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D13C313534
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970449; cv=none; b=R/NaFGmlgSCTQqjSENMHfcrjqbt+oWHisRNSczdyAAzOXL+yYT8akW57MWudd3CW/iLqIwtlTRWMNPZ/X+PfXXt+5FH4rASZXFRhkzhwly12fLR/DseGseVLsGYORzZrN4UGJs9XqC6HrePnmqlo+TIj+ippru771+MLxN8fHGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970449; c=relaxed/simple;
	bh=UezBx2UwHi0guTnnv1h2HzqS/N/IcDTQkB7+qNbFGu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8QwILjh4+yaByC3iAyWyFwb/Xp2IfpNYA7fq4/BraaE7ywaVwUTo2jWI/LAFzwmYamv21/n/Ln2p6lIqfHcanNAYdvWslxAWHAJZI7ZjMTrF3q9RKHIQV9QUDUGW0BaZVzIyE1SyAZBRh7hCHGU8KbpCoIYPfm2uPd9S4Upsas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1br+6yq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WAWU2/Yv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777970447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7BeyXB0jKPsixYU4aFsWUSImCQANnnKW1CnbnC5jOE=;
	b=c1br+6yqD+W8g/J8EId8p+zYg7lna+MpULGOSpRlgSa1vGg57pvUIkrgOs1HpRKFGL+2yj
	Tkj7CfXc0L26XsFsPi2V5pzfc0dVtw5qmi3TnC/qdpQOHXH09YtQgq2ZvOOjDDUWwSo8nE
	4S39nHy4PnE5N6bdvyTh1mCcIdl7v9k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-2Vi-yvd_O-W5EnsHGvKDCA-1; Tue, 05 May 2026 04:40:45 -0400
X-MC-Unique: 2Vi-yvd_O-W5EnsHGvKDCA-1
X-Mimecast-MFC-AGG-ID: 2Vi-yvd_O-W5EnsHGvKDCA_1777970444
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d8deb75fso41857245e9.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 01:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777970444; x=1778575244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7BeyXB0jKPsixYU4aFsWUSImCQANnnKW1CnbnC5jOE=;
        b=WAWU2/YvcO8RyL+KR9d6mFYejlzrd7pmSfN6Y8+PiMS67plFxYRVHs6/TePHaftHme
         vH1YIbIMXQJGevZT14DNqZ0jq02SfQJjAmZzRGIfKyoDjyd8DJg7wErXKZwbRlmmHcpX
         tC3qJAwVA0n1aBG6GGBDStLAW6f4qGe6qv5M1JyT7N+rlFOILornY7JtxZAFSZokxJvG
         rn8H1dKIigunBGN/m9HD4aXqcS8UKSeRIsQVzAEjWH+M+CUUhUwjy7p3wMjXXAo2R6JN
         rx0CauQnloDGK+xTAcgpUIhYNLO2S/HUROr1mEbX7jV43aQW8y4tc60dp3bmTKIGWXlJ
         TSgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777970444; x=1778575244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/7BeyXB0jKPsixYU4aFsWUSImCQANnnKW1CnbnC5jOE=;
        b=dyHMeFlSYNl3+C+wcX1Yj4PckqhN80UB7eSqDjpUOvyNvy9Mhct07HINyLEFSXuo/T
         zvFzyeA0/qykqyfyclQsOg+RZK+Qigl+XB6wnyjcpZg1ctKy65hQACC2niqUVBgzUwHZ
         8HP+RMhK/p1URpbRLxK2rPTP9d07OI37JAV5hPLgdvI+0om/BNIaBKrIkY7FWmSC2RTz
         rKfl/w56CNAAXvUhqNog7YiFQt14HRTfvRCPGN4OJQcWlw/DNF4UIZ+pV3eemBS/hPo/
         PnpRSKukKOcl5CIKGcFfYlY7qebdBEbAcCcnHLDxpLXVkcpuTLurO3zXU66v0roblpWp
         KNmA==
X-Forwarded-Encrypted: i=1; AFNElJ8eiKPBPSH1DvmitylY8idYfT2HJ1GVpURIrMRUI2zRQN+kuEkN2nIOYWn98LsWPQuTWDLIfj0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5nwY438Ha5+4+e8lFkHw/8TTV12EEexSD2XZQmNjeeH9zbzeK
	+VzQt02z9AKx3AV154DS/WNdtKo5uXEJqLUN+Bc8zE929fd2hEhumxP4eaBktNNDUtWPSj17ueI
	k/qalVdprcOEd2tGmjU9/2KI7uCFEzqEB6CHrYpTQuvMpnR62XKOU8ZZiyA==
X-Gm-Gg: AeBDievTMh5Y0sh9VEu3r0avHyf3rVvbz+HKTNTlVzzTbnwb85KFnO6Egg8nh6aF3UE
	iFIpax+Si2JezWo/DfcYu0y550oHqYfbRzjN3Nt2UuCjZgSkB0TtrAbKVgu/zFgQLJI9klSvb35
	CpFsI7ESHOTbyKFzsk9Or6QEN2aXlAAkQwnogjHjBCx5gFQqx5e7wMS+k+BhPsWF6m6CVdrTRtm
	DglZoFuNtGNYsirTkY0QVR8XDHTIfBeNEU5d4EXyhio/eVc1LrrrYixCtwxFiRix7asYwx3mZWe
	3VpV12GI+EtUI03ASBqLZKjBr4hpBrn7pdhzTTBGOvcRDHWX64YK5KYfVU1SzXg0wBcr1MLlhSK
	DaZdyQPXGxdjd/U9ZFkM58cayd00ZBBOjw8A/RwrPiQ9JbRl6ZF+hS263eqUodHg1pzo=
X-Received: by 2002:a05:600c:628d:b0:48a:56de:d620 with SMTP id 5b1f17b1804b1-48a988a223emr230703555e9.14.1777970444426;
        Tue, 05 May 2026 01:40:44 -0700 (PDT)
X-Received: by 2002:a05:600c:628d:b0:48a:56de:d620 with SMTP id 5b1f17b1804b1-48a988a223emr230703085e9.14.1777970444026;
        Tue, 05 May 2026 01:40:44 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b02c5asm2768933f8f.19.2026.05.05.01.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 01:40:43 -0700 (PDT)
Message-ID: <64d71f18-f86b-4fd7-a6bd-02243eed0492@redhat.com>
Date: Tue, 5 May 2026 10:40:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 5/6] tls: add hardware offload key update support
To: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com,
 borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
 sd@queasysnail.net, davem@davemloft.net, edumazet@google.com, leon@kernel.org
References: <20260429181016.3164935-1-rjethwani@purestorage.com>
 <20260429181016.3164935-6-rjethwani@purestorage.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260429181016.3164935-6-rjethwani@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 28C244C8C6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-284266-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 4/29/26 8:10 PM, Rishikesh Jethwani wrote:
> On TX, the NIC key cannot be replaced while HW-offloaded records
> are still unacked. tls_dev_start_rekey() installs a temporary SW
> context with the new key and redirects sendmsg through
> tls_sw_sendmsg_locked. If no records are pending,
> tls_dev_complete_rekey() runs inline during setsockopt; otherwise
> clean_acked sets REKEY_READY once all old-key records are ACKed
> and the next sendmsg completes the rekey, flushing SW records and
> reinstalling HW offload at the current write_seq. A KeyUpdate
> arriving while one is pending re-keys the SW AEAD in place; if the
> HW reinstall fails the socket stays in SW mode (REKEY_FAILED).
> 
> On RX, the NIC may have already decrypted in-flight records with
> the old key before the peer's KeyUpdate is parsed, so the old
> AEAD, IV and rec_seq are retained on tls_offload_context_rx.
> tls_check_pending_rekey() invokes tls_device_rx_del_key() to drop
> the NIC key; otherwise post-KeyUpdate records (carrying new-key
> wire encryption) would be XOR'd with the retired key.
> tls_device_decrypted() classifies records by old_nic_boundary:
> 
>   - after the boundary: new-key record; drop the old key.
>   - before, fully encrypted: advance old_rec_seq, let SW AEAD decrypt.
>   - before, (partially) decrypted: reencrypt with the old key so SW
>     AEAD can decrypt with the new key.
> 
> For mixed records skb->decrypted flags can be wrong (NIC clears
> them on auth failure); on -EBADMSG, tls_rx_rekey_retry() toggles
> those flags, decrements old_rec_seq to reuse the nonce, and
> retries once (gated by old_key_reencrypted).
> 
> The new key's tls_dev_add is deferred until the old key is fully
> consumed: tls_set_device_offload_rx() sets dev_add_pending while
> old_aead_recv is retained, and tls_device_deferred_dev_add()
> installs the new key once copied_seq crosses old_nic_boundary.
> 
> Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with multiple
> TLS 1.3 TX and RX KeyUpdate cycles.
> 
> Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> ---
>  include/net/tls.h             |  84 +++-
>  include/uapi/linux/snmp.h     |   2 +
>  net/tls/tls.h                 |  29 +-
>  net/tls/tls_device.c          | 753 +++++++++++++++++++++++++++++++---
>  net/tls/tls_device_fallback.c |  24 ++
>  net/tls/tls_main.c            |  92 +++--
>  net/tls/tls_proc.c            |   2 +
>  net/tls/tls_sw.c              |  76 +++-
>  net/tls/trace.h               |  79 ++++

This patch is really big and complex and you should break it to help
reviewers.

At very least you can split out the tracing bits and the trivial
refactor moving around declaration and definitions to separate patches.

/P


