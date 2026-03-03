Return-Path: <netdev+bounces-263099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CLyMAuupmn9SgAAu9opvQ
	(envelope-from <netdev+bounces-263099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:46:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 267C91EC130
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 136E530DDE16
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 09:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84EB38C438;
	Tue,  3 Mar 2026 09:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mf87Jsgj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WxPywm04"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902A326C38C
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530957; cv=pass; b=JoUo1ZhlPGvEIUXaO7esdR2POxto5ni2dB4q7s3qOPyT9mzjivhtVuK3h8dnxgOlE+/zcOeD5D4mUF677jZFi9ATuqCiC5omYQ0szBAzedkzrwsE6PQlwQwpHzJ2w5fygaGTTwD+o5/odHoMjqyEn99OVDxEwQbt3M7jZBdFnbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530957; c=relaxed/simple;
	bh=/yj2mW0NBVKsw8Lzty5GF5IiC48Z0uRzqpsfTB7QeQQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SL9GzJYunn69mZoURbwAwEkha5syfmqaBnUyHG1L6rXUBV3xkzKsb1GwrmRBIgp7EL0gGGMl4O6G+yMgqfsmhZEBABHzLdK8w+uBYtRTinhgzB/T6hfQLJzkOW0u1fFAuUZnICgsHjsCkubGhoXcPn3H7s/gv56P25xjfJGPJCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mf87Jsgj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WxPywm04; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772530953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=280O4eJ/wV+tCznStLFLW+f7jjqPyV02bSsKWxFTH3o=;
	b=Mf87Jsgj381bJkP9XMM39icaHQxDwGmFVrIq/xb4PkWBMPlNlne5X5Q4ok+s6YYH3in6hj
	IrgDS7INZiwwm2Aod3QTm0IVaoXA0VyhNQi+9xmJFHICfs1ifiAkcw7EyWrRcmceDcVpXQ
	lhbCN/rB/w7IvG6MNalIck5n6U8jZP0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-KvUFhRFeNnSpSpdLlzB-cA-1; Tue, 03 Mar 2026 04:42:30 -0500
X-MC-Unique: KvUFhRFeNnSpSpdLlzB-cA-1
X-Mimecast-MFC-AGG-ID: KvUFhRFeNnSpSpdLlzB-cA_1772530950
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-79868eae64fso109545667b3.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 01:42:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772530950; cv=none;
        d=google.com; s=arc-20240605;
        b=Xz5Z1rn+rPRL/c+6oRsG/LgOQHzwMh599lcjDR9qmhibdiH1rBcKN7s89TNyfZ2PZI
         VV/ivS1SaXr5qLtzPmxMrtOnpJM+NkUiVE9tPQdEej4VyM9XCijm6fuk2CfxHD+xDt/n
         befq8zJB6qMmcGD4sa4k+b9alogM8VlnQhn4o5MzbU70WULKkGNMUZ1tq1DwkY1w9mgb
         RSdTZvu830TErfE5yUwWmUWXIWegncP0Djb6WqKhCg1ACR8jOc9CT9hY/tXmb7pk3zQ8
         lTNHck9pqllht/FDagabmupXXyM0lW7b5QDXc0CVlwyqfIa25Yl9VoN8SHV+nnJ8wSaC
         qg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=280O4eJ/wV+tCznStLFLW+f7jjqPyV02bSsKWxFTH3o=;
        fh=jINEsUBQWOZd+deGc3FHL4g0nsUug9R4JEYroMqMj4Q=;
        b=SEQOJ3Nm1qELlu/3oFFYyMz49LRsdZ+P9f0grHWV2+pY7NSyRG3/IZC93DBt3F2HQW
         lLxgo0cbpkfJl4jgG6pJdfpicFCjdyVHdEQ2E4/hiu68n6gFILdWhDRLRz6hPiZl6afU
         36t4f5M1LMFvxTvJIhbIpNANCW2BjQlC08VGk6meLgsSSC7qODG0zOGUKxswcgEtPSTn
         M8ShWlgRB/tYJAmr7Sfqpwg9ruaHtvrbrJBdcnIRwY2zAm7ihkonBbn1zWi3uYTMYxRu
         sak+vb4xM0KKCHlnVXAuxQj6IgzSas73ISvmQJJCqX1J3T51oKaYm9yeNEIxKtZ0sVtP
         iTcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772530950; x=1773135750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=280O4eJ/wV+tCznStLFLW+f7jjqPyV02bSsKWxFTH3o=;
        b=WxPywm04zcNWMfgMPm9fGyTPbUGs0DFPmQF1OP4djXpQXz5Dc/DP+LwDzjN/3kfnL3
         RKbGupFzeB0gXdRqz/6d93jhb736mhvLgdld4IQeZAWLYgMD9KmG/o2sW4gwHBZQajDM
         0ReYoVfTxR7J89mK0gPc+Ww+noCe81pwCW8fcS8MnkM/7lxO1Iq1cGD1ImoIE4MUbd3f
         drD1xoBiBexgN0msD72BsKm95PvTp0WNmzYNUbmTzXj/g8IkADT8HBSUQ2N7XABRp+iq
         9uPVcun0CYiLXm0mcwOq8KhKsXz49xTGe9b/ogLXo1M7XQcoq8eygVmCqDF8VhOVHW6J
         zqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530950; x=1773135750;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=280O4eJ/wV+tCznStLFLW+f7jjqPyV02bSsKWxFTH3o=;
        b=b6I+tKrxkOm1gzH3JB79acGVav/APlONbCl4V399gFCs0c3uWjKqkUgVYQx05Z+msl
         VwL/mKKdNiga1Xh8p21DLtgIQgPKn+5usZfQbH6YCmZyK8LmydZOG/7x/PRrAGlnZoYf
         pEhWTFfGSWYLjQT8w200DEp9o5KPWK34nNz6pXk6SCldI7YXP7aCTTfX2cFQC5cydhWz
         pAyJqB32jkpuptZTIfCRYlucGPyl7EgOY3XLfNT1WEfxyZ6ap5mJQbRykQQ6Zx/L6ixK
         obLlnItOfeTqPfwsl3aNy7PxxPs+GR5OugrQNg7d7OYDBKOFcn622EgU8PdhH4ofdckp
         WpAg==
X-Forwarded-Encrypted: i=1; AJvYcCVXCqErmctZZUN2wZ+Te6MLn1pIcdWrSIvhTdliDVC0//Jk/G/k8cM6+5FzoFQJ6YAmWTFahLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhPK1S8vaOLye7QsIQsEWKmS6DjsR5Rhg2Q0qDmqEyNTGbtxFF
	Uc+s5w4GfDmA3p219OZKPTRzIA0+IKNGJomA2ZUMELzwOj2i0/gWDuLu1tLND94Q/6kF/yaf2mJ
	o8m7zHLUpnu9LFDCY+Wc9ZPIBnG2vevLmn21stePPsDbWzM3ssOHphFZZJt7RqRtnowBEJjyCPu
	nbQnFi2kTWXjPYRjvBItUps2wTxAkxvimL
X-Gm-Gg: ATEYQzzzUdcOASRN15LreBZ/Nt0fwHnXAlW2qP+vrGk9WvEXGGtJ+v4TxNUKEHdWwoG
	oe6ibXCkBoCeCOh5uSS9OGZBJ3lcCvmh/mnge/5Qkc04ArdF0tj5jsf1JvOXKUro7TWu2Nbu2r+
	GwPtH7fvxxv/3GASCBpHX+WMyVyStpU3S8uRCm22VsX7XpuWFrKzRtVI25AKmTUqKF/RZFDey1o
	VhAnXc=
X-Received: by 2002:a05:690c:e:b0:797:ce9d:5c71 with SMTP id 00721157ae682-798855c6320mr145284167b3.45.1772530949840;
        Tue, 03 Mar 2026 01:42:29 -0800 (PST)
X-Received: by 2002:a05:690c:e:b0:797:ce9d:5c71 with SMTP id
 00721157ae682-798855c6320mr145283957b3.45.1772530949457; Tue, 03 Mar 2026
 01:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 3 Mar 2026 10:42:18 +0100
X-Gm-Features: AaiRm51ZULYt-vLs6o1MyOGTDebdiHIeo2M9vqVZ7FwXgbPhxa9AQgGMccX0isk
Message-ID: <CAF6piCKbxHF7DASK47-q3DFdtKgvheAGdLUaTwYsfg3ikZAi-w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: datagram: Bypass usercopy checks for kernel iterators
To: Chuck Lever <cel@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Network Development <netdev@vger.kernel.org>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 267C91EC130
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FAKE_REPLY(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-263099-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On 2/25/26 5:25 PM, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>
> Profiling NFSD under an iozone workload showed that hardened
> usercopy checks consume roughly 1.3% of CPU in the TCP receive path.
> These checks validate memory regions during copies, but provide no
> security benefit when both source (skb data) and destination (kernel
> pages in BVEC/KVEC iterators) reside in kernel address space.

Are you sure? AFAICS:

size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
{
        if (check_copy_size(addr, bytes, false))
                return _copy_from_iter(addr, bytes, i);

calls check_copy_size() on the source address, and the latter:

static __always_inline __must_check bool
check_copy_size(const void *addr, size_t bytes, bool is_source)
{
        int sz = __builtin_object_size(addr, 0);
        if (unlikely(sz >= 0 && sz < bytes)) {
        if (!__builtin_constant_p(bytes))
                        copy_overflow(sz, bytes);
                else if (is_source)$
                        __bad_copy_from();
                else
                        __bad_copy_to();
                return false;
        }
        if (WARN_ON_ONCE(bytes > INT_MAX))
                return false;

Validates vs overflow regardless of the source address being in kernel
space or user-space.

FTR, I also observe a relevant overhead in check_copy_size(), especially
for oldish CPUs.

/P


