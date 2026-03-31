Return-Path: <netdev+bounces-273611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEZYILvAy2lqLgYAu9opvQ
	(envelope-from <netdev+bounces-273611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:40:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D55536996C
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B3CB3099454
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660D23E2771;
	Tue, 31 Mar 2026 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lvprhxrh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOMZdJkr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9C3E276B
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960685; cv=none; b=WMWAy6QzzStnoAeMoD/pQCJbJLCw2nIQIB0MTiXQTIx9zJM7Wdp+6wXuZ3I+ku/LdHix8s4D3GjDsuG9uCvL3yjBh9vYxP+IDFH0fx2UB6Vwh3IteGU5UC+SOofGHbV237wG/JvzLDi4BBaGFMrdO11m6Bq51VUzdJKJsjetYSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960685; c=relaxed/simple;
	bh=WyQ1KWk2tLGzM5pawO7qh2AFOjdX00b5vnT3sEq6bbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCdExIom6mO6sTK4/OzNbkGMVDBbBWKKxWNftQBc+i+q1PwCn3P9EzaJW4mHwMuiQkKGRsX109cNjAW9fYknxPo1Vp5ZM/rENVcGBVqS3+sjlsMyVd7P2hHapimtuWjlFLdaRCP1Wjs9aKAAnVJSHH0UxQsjwWT/Nc1G1t+uqBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lvprhxrh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOMZdJkr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774960683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzhsTZpeiHM1+rlPEAX0sxNpD7HCMbnEx89xRuI/9Vo=;
	b=Lvprhxrhj9/ws01ImR3UkmrNa5u4qYP7gJNbYDIFXY8ewX9KnBJaBOjsajps/Y9FMTHqKa
	pEXH2ke60PpbdGonQX/I9QmRB2+FoCps+DMuOQ/P2Psms/cgo4KkQma99DcvTk3JaW1P1V
	SguVhHYGO1vt/hKnsQ0Y4dgNYhQjg+w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-dA-vMf2iPyyi1F3boZL0IA-1; Tue, 31 Mar 2026 08:37:59 -0400
X-MC-Unique: dA-vMf2iPyyi1F3boZL0IA-1
X-Mimecast-MFC-AGG-ID: dA-vMf2iPyyi1F3boZL0IA_1774960678
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48542d5aa9eso50522175e9.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 05:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774960678; x=1775565478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YzhsTZpeiHM1+rlPEAX0sxNpD7HCMbnEx89xRuI/9Vo=;
        b=UOMZdJkrjzvDZHacQtabXgQVQEqVcSxCKeuFWqWjHDQ880Fb9ltOENr5o+CKZR3N9W
         zh8J6ndGVSqkNUS3HLPNnsf4B6cvaybL/6tQgzQckdT8Fmm5WTkLtX0PPycAb0GZ6d8k
         U5MIQ+I6KujVnEteKHo2YmOXmFEA4t4yJiHp8Fhne+bUm4TNBJOG+lAiHLvT1NGGiFDe
         7pViFV3Hdvevzv1huIlBX8gcPLxtVlBAgT/G1nroIn78idthMQXvgqkienbm0Sm29WhN
         RUKhytm2mQYy2G4KhPGMV33H6dZhFyx8hCgZq/oifxwZqVuZHDEyERoRDeaiDU7shsAp
         89QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774960678; x=1775565478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzhsTZpeiHM1+rlPEAX0sxNpD7HCMbnEx89xRuI/9Vo=;
        b=orKM5T2KF5FCe8s3/V488adInLPJEY4nYq3lYXYZhrZ3TW7Qs4D3xCqBiCu1fXrEBv
         Ahfs9nCHKthuWoRRNkVbTEtHUry1vA/2KfO9lRP5fMa99euAcW2xkY5ZBFR4OADPTwF7
         o54Lw25TDuhxglYo6dRDTh/qRWtcXmYMFZ2Uwf2/jYhi6X9tAR/CLG/C/KF0choJ1GfP
         y61FS8i3zdIF6SVxSEyL1tzErCnUVmpX+QcRp8s/BU2QqiS7gOGRUf2j/ZvWSGWKumeh
         rj1mg8j/utwchqwEaDJJ7wUhl4pA7IeM/ChhN6570d/j+ZOfh2XhqNy1JFBpfEvRrsKS
         HZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5gUETeAp4+KkmxTVSZBSZIb3UA8hLppfJP64x+CHsrzdFvs/YEDO4FKK/e63RaJoQwdMzjhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjM0tvvdEUh0ooWn3oZbuwVXPfRitkmrIHVUeUfsCPyBsLD6wZ
	WwE3T6+eCuVJIjgmd/vYHcIMlnmXZ1tsP9OMZQrxK/wgUwhEA36b7UVZKH8hWDa3ZKuQYVsU1G4
	YVsHZ6qXqgvECnOkwnUGye1T1VKatyD/IiMe2lGSC6WqAPRE/jX8GIOr6bQ==
X-Gm-Gg: ATEYQzxNvZUerBkY4jyzTkPLBJj9cWoxkLD2124WU+15ZIzgUYwzMoPMTxjPzN4Cxwv
	wFaiJYhg27ZDeAjfD3ZD9B6RkegLDfcirzT9lze7AfA+r1APSRV7sf39C2XkjmQ04Rq2WxzzPqu
	uK0g5FWkxZ3NdgtGBlJj5ag0n19Kwx4zZ/CUCaj9P7TXLwU27HahWfvY8JAKFaRUSfNGQm9gHxx
	dyM2SB8SmaCPbJzxTh9A2RgX5jZsVLNLI4st6akcjhZPhLQq7L6GHnYmWTJH21ZuwUP7m5XRfrs
	hUWiG1aiIYeW40m8DHW5Xjw1VxMJbNXmg9s5200YiarTD9dJvWsM9o9+wITFSD2OmB2bLyBkkqr
	vSkuzvTyJMr2pNl8LTMleF5b33UIPdV1V8GSHJ8qVFZhweChbWiDJfTpSZKAfZIaQv3seuH5Ee+
	WF
X-Received: by 2002:a05:600c:6386:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48727ee5532mr266099565e9.4.1774960678319;
        Tue, 31 Mar 2026 05:37:58 -0700 (PDT)
X-Received: by 2002:a05:600c:6386:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48727ee5532mr266098995e9.4.1774960677780;
        Tue, 31 Mar 2026 05:37:57 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-139-105.business.telecomitalia.it. [87.12.139.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80148csm35693595e9.5.2026.03.31.05.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 05:37:57 -0700 (PDT)
Date: Tue, 31 Mar 2026 14:37:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Norbert Szetei <norbert@doyensec.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, John Villamil <john@doyensec.com>
Subject: Re: [BUG] vsock: refcount_t saturation and OOM via buffer size
 invariant inversion
Message-ID: <acuKUpZQq6z1DY_n@sgarzare-redhat>
References: <523A8D3C-F4D9-43DD-A3A6-01C9EC335656@doyensec.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <523A8D3C-F4D9-43DD-A3A6-01C9EC335656@doyensec.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273611-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D55536996C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 06:28:12PM +0100, Norbert Szetei wrote:
>Hello,
>
>we have discovered a bug in AF_VSOCK where an unprivileged user can bypass socket
>memory constraints. This leads to refcount_t saturation and OOM. While
>refcount_t prevents a true UAF by saturating, the resulting state triggers
>kernel warnings and kernel panic, depending on the setup.
>
>In vsock_connectible_setsockopt(), the SO_VM_SOCKETS_BUFFER_MIN_SIZE 
>and
>SO_VM_SOCKETS_BUFFER_MAX_SIZE options are used to update the buffer's minimum
>and maximum values independently.
>
>The vsock_update_buffer_size() function clamps the buffer size to the maximum
>first, then the minimum:
>
>// https://github.com/torvalds/linux/blob/c369299895a591d96745d6492d4888259b004a9e/net/vmw_vsock/af_vsock.c#L1950
>if (val > vsk->buffer_max_size)
>	val = vsk->buffer_max_size;
>
>if (val < vsk->buffer_min_size)
>	val = vsk->buffer_min_size;
>
>vsk->buffer_size = val;
>
>By setting buffer_min_size to a large value, the second clamp overrides the
>first, forcing vsk->buffer_size to exceed the intended maximum. The transport
>layer then uses this value, allowing unbounded SKB allocation that saturates the
>32-bit sk_wmem_alloc refcount.
>
>The fix should ensure that SO_VM_SOCKETS_BUFFER_MIN_SIZE cannot be used to set a
>value higher than the current buffer_max_size. Conversely,
>SO_VM_SOCKETS_BUFFER_MAX_SIZE should not be allowed to be set lower than the
>current buffer_min_size.

Okay, but that wouldn't change much. As long as the user sets the 
maximum to match the minimum you set in the POC, it behaves exactly the 
same way, right?

Maybe we should add a sysctl to set a global upper bound, but this is 
another problem, I agree that we should improve the kernel behavior 
around min/max.  I see 3 options:

1. Just invert the checks, fist check for min, then for max.

2. Simply adjust the min and max values so that they make sense. For 
example, if the minimum value being set is greater than the maximum, the 
kernel could adjust the maximum to the same value. However, this would 
not change the behavior of your POC.

3. Force the minimum to be less than or equal to the maximum. This, 
however, would require a certain order when setting the minimum and 
maximum, especially relative to the default. For example, if you 
increase the minimum beyond the default maximum, you must adjust the 
maximum first; conversely, if you want to set the maximum below the 
default minimum, you must adjust the minimum first.

I'm more into 1 or 2. 3 IMO is too much.

Do you want to send a patch?

Thanks,
Stefano


