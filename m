Return-Path: <netdev+bounces-290110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMpnDoYxDmrj7wUAu9opvQ
	(envelope-from <netdev+bounces-290110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:11:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C63659BCD9
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FD5F30BFAD6
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A864387588;
	Wed, 20 May 2026 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qov4Ksyo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C5C389119
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779312624; cv=none; b=mCJ5J7LtI2uErOrrY3i44/TgN6xN+hyK3qKL+2U1Flf22xfBi9X87/GK54yYkuZu0wBb41s/AuULu6lhEXjW6lbfcYWlZET00DhU/PXwjAQrpRLnA/il+tW+ucve0T62iKT7wnyNb0xBRUPWNuJ9YqScAX2O/2nVFhB4T6OwOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779312624; c=relaxed/simple;
	bh=CNa2gn4pFs3ZChw13qtMs/nrIOyVd4U11OySKw0hQjc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FGIxipm7rA1cuTCXqZOkG5aiP+5gapER/dNltEqs8Viy28NAM/ww7qgw0vLDS7kSDYLF5SV8cC+H7tShrDG1FY888iLTz+fD3bV8r2ACUE+S+siv8sv9OI/DYYbCdAxlKWupL5VdFrNOlcHUGfyQYN6UK3IHWbK/fz8Xfafhb/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qov4Ksyo; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c3ea2ebf7so6287849d50.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 14:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779312622; x=1779917422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+KjHLBU525JouIaDV1NgtcuH83HscW0YCgR8XNPGw0=;
        b=Qov4KsyodNaYoKKYGw8QXb0+Qu4SMVW8i44WdAko6Pn9HnrUsPa6L7IqX3v+/wC7+s
         o4SvVPDi3hO/Ka5e9rgBvgaF/rOVe5ZD5fDc2hhPu+R9gk82O4v19sddEP43dDG/5SJl
         0xXQO/w3Pt+qJdM3cGdz7gw2fZc5cwHDc3EzFXpr7Szk+iSe6FFDkYWbFYxNMpnOiG6C
         hUfsQu2nBVJiOYio+6Q/pBEF989u6fI3mTeFsPAvqEZFu80dMIQK2jUN3BjepdAOsfKQ
         CCbVpag47HIJWD1qjmXFu4KTEGlnWxQSMRD01mBEDL/JsOR6ihhyv6H7oLa+O/1Uggdk
         IFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779312622; x=1779917422;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+KjHLBU525JouIaDV1NgtcuH83HscW0YCgR8XNPGw0=;
        b=CZadqwryb7J8suImxuKJJK+4Wgv7WYdUxG4NBk8+Th3UYTgbI/DIR1REnLMUehxbPt
         N5/Xct1uxctjGEn980g6157HVwWWYKWDppVGvmQrxJh7sh+5D5j4oX6wlr9gH6LoZoNa
         FdlBBjkSkKxwifJKtnAxrZCnJ72a5sPLHHV/2eSEO5y3d7CvbU573LPw6awI3b1eeg4D
         Jq/uKtz6pdDVjVXclDeUa2iKok9kO6vek4AJ9SefX9zpXXIDbzxSv4idYilj7yYuegPU
         Rd//ZcdhcEE9sNypA1Qfiqutn4Q4rVn8GN/fj6SF11ODfo3BbFsbo/+3xVI3Fr8MBSBM
         MSjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9jSoeNdgT5LyAp9wwf3eutbN6XcwHPbYaUXbiLiDUaUanIgBjgGJN2EocE2mN7Gm1d937NY0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsTLC0QMYOL5JBrdIW3MCIfsWJ0HedEIx8UqUzwMVVMKpfS8kE
	sDXMc7p83+MkoneVnBMKmIiMzQYJbHqNro5ixoDR4AxIpa54UFoLHukg
X-Gm-Gg: Acq92OHWQEuM1orkQqzdHu7OkaOoQKmgm8h5XalWNRd3yRsGMdVtZag1N1GzQ5Y+ZJj
	NCZ05k6jy5c6GvOglqH0xy3aSfzd5V5G7eOgRGVClMQwG0RzuZRF8OU5NXdU9IcmjDPu0DY+K7b
	yGPCPRTa4q36LpTz9rJ2/5Z3QfEf8LlPN+PMB3WVDFCtNTsgsh6RhUdVLBqH6dq1PfG5lAqn8LY
	dyCWmKsaM8+dTzukmam1mCK3/rz70wNVIcdWQ+0pIvzmv30I0GAwu8PRJxFponVLO7WnlyiwwKd
	9C8f6M4/rvnXCru5++EpXr3hknRVURnVZuusOcQDWtznhxvp35JHaWZ3Ew0jDrN9kBrorsG0vic
	YndkARjOtU7Nz9EsnFWcvXuRrMeSedCe6mbP5yWgNaL5XYj5dUYTBdxM6EpJ+T2f0eFbSAl8hdU
	kZbefco9dga/4G1wq1uQ0Y8kh0CAXA4rsN9vVS4kDXlKz0bThOTagq31XtHqKcUNEyjyl4P7370
	4I010SET6u+VoE=
X-Received: by 2002:a05:690e:bc6:b0:65e:3c31:533f with SMTP id 956f58d0204a3-65e3c3156b6mr18817387d50.51.1779312621683;
        Wed, 20 May 2026 14:30:21 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d89b130sm9894594d50.5.2026.05.20.14.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:30:20 -0700 (PDT)
Date: Wed, 20 May 2026 17:30:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Weiming Shi <bestswngs@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 cong.wang@bytedance.com, 
 stable@vger.kernel.org, 
 xmei5@asu.edu, 
 Weiming Shi <bestswngs@gmail.com>
Message-ID: <willemdebruijn.kernel.377fc4fbfbed@gmail.com>
In-Reply-To: <willemdebruijn.kernel.69dc20190163@gmail.com>
References: <20260520075736.3415676-3-bestswngs@gmail.com>
 <willemdebruijn.kernel.69dc20190163@gmail.com>
Subject: Re: [PATCH] tap: fix stack info leak in tap_ioctl() SIOCGIFHWADDR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290110-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,bytedance.com,vger.kernel.org,asu.edu];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3C63659BCD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> Weiming Shi wrote:
> > In the SIOCGIFHWADDR path, tap_ioctl() copies 16 bytes of an
> > uninitialised on-stack struct sockaddr_storage to userspace via
> > ifr_hwaddr, but netif_get_mac_address() only writes sa_family and
> > dev->addr_len (6 for Ethernet) bytes, leaving sa_data[6..13] uninitialised.
> > 
> > Those 8 trailing bytes leak kernel stack contents; SIOCGIFHWADDR on a
> > macvtap chardev returns kernel .text and direct-map pointers, defeating
> > KASLR.
> > 
> > Initialise ss at declaration.
> > 
> > Fixes: 3b23a32a6321 ("net: fix dev_ifsioc_locked() race condition")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Assisted-by: Claude:claude-opus-4-7
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>

But it should target [PATCH net] and

Cc: Stable@vger.kernel.org



