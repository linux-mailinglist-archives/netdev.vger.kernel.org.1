Return-Path: <netdev+bounces-280505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPcnMmj46GkgSQIAu9opvQ
	(envelope-from <netdev+bounces-280505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:33:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61469448B66
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FAA030211E2
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3175038425B;
	Wed, 22 Apr 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dFLFQ9Ij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A201337F8DA
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776875499; cv=none; b=TcQmi8m6JO/imvNm2XgcPp8dUVxTCGCWw2HafRG1mkAYXMugfZnUfY5MkdFOIwXWdb0kRKFUiIT6KdtXwiPclW41v4THwLi3XnB3UClkEuEBJ5h1PdENCmzCauUpjl0/KRmfx+FnuzxxIsP7oNzy0D6EC1Jua4Lm6gRc7jhiBs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776875499; c=relaxed/simple;
	bh=pPlUiWBDe8bOGmEouOxnQg1NNS4r/KUijif04dGB84Q=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=scvgNjmt5jBnJdzVI/pIZN0vZj1uNbVa3LNEOVTKI/3bPteDJ6RBQgoynlFDf+4xhHz9Z0/M7txq1UMqmdnPihEBY9V0guXW1Ceqw/sc6WvtI0PQ0yNpGn+pOt0wrgTEEDJvnxwLrzSASNHbf1jw6psI0L9KYQD3h4t9aalcTDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dFLFQ9Ij; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7dcd89701acso1565747a34.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776875496; x=1777480296; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kv1z6jincxy5WQdNfD4DCdTuj2rMmC7+D/DgcwscYe4=;
        b=dFLFQ9IjeqSRfuL/GDd8t5C/4/isGE6VG7/O+k9kezzOemnn1IlnsERmzyApbqfaK+
         KM8rvwqFCSkkSGF7ZLwB2M0Y7P+hFhwn+y0OngJNpSf0gECU2lceKQ4nPV/89MKJehNT
         C/uwOQegU7FmNcazmDegdy3o8H8ggFtcpVNETPhAwQnQ3dNBLPFWjL131rcBMNm46S3k
         n5pcRPhRgHtuT2zXPzp5afGd03efsuTAYN4kh1zCIPQbsl3mbNLgJDL39J9zdyOLTruL
         HysQ7SW5JDEH712l6sLJA1CGfU9qA+0kPV7EuZwrSV/mzHvSElsokTtQGzBeoNDsFQ/P
         Oysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776875496; x=1777480296;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kv1z6jincxy5WQdNfD4DCdTuj2rMmC7+D/DgcwscYe4=;
        b=rXkVsgixdgIJybs4+vYwYWLbjrZwDHpjGX20qEQmqIo3AFw8jtEu3qEQXXyV1SKB1M
         1EJeoG7k+r3Z2Fb8yfi2LSsvT5lMBJ1AhyZ8yMhMEGWnSt9alB05kd7iCMncBdBGfGMN
         ZY8p08znfJLjIECY2t8DpuDr02Py0ltCAqB8CXqDij8qLkVk8+fU1HzR4Q9uJU002ZYC
         Bg0eDfYszRki30uQECF6WDLodJ0DmyU9JPDXB4E1/uzJyiCc6zMkNyDIsserUu3A3rxW
         aN1UMvYEPl5Us5kFnYI9MMkO8z7uTxejjSdppz1e0u0nwgXQmtkMzsNpC2Ns+bDuh3Bu
         sPLw==
X-Forwarded-Encrypted: i=1; AFNElJ90+UQVGQZDO/Y7CJlxVWyQnUH0K1CZHIg0zPISHe2+o1plezQ/UxJsA0QMUmtsm/tX4ECgk1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCDrSocmZFNpd/dNyI4N7JFsjj7Lloi8n6y9WbJ9e2H6eDMPOR
	D64vify44wKDwwqYfnu48s8zG99FTgOgWdqNaFqFcdTT5ShW67izXpVi
X-Gm-Gg: AeBDieu2+wCn9XW+XOgN2vFrq4EIFeM0YqGnZVJBLl1J47C7IioyH1ohT4Ex9VoCLzn
	qW0ShCsWbYyIPyOYPpFgLj9H//kXfL+Lbbk4UqF+xkRFdYM4lXOopeSX99mY0psAIQ08DHO4+5Z
	VC7eRRbNypm1dK6WT71Uyg1WSA0XcYGK1A3kT6LldBUT3t4YOWrkU/iOjaOuVPdDppzbFLa8oQT
	VpDA5se+1Q/7nydYrbO2fX67Bx7uE/TjIp21Mqek0GHW6/npQJOjUHVQRxgeQxpPdZTxBlGVTo2
	NVhVMiy5fMSo+HG1od1ivH58Rg6z/EeMYAOzl1Jiq7ImgM6af7m2cPiY5YLkMqjk4CGEYu1l05X
	PusDSrB/NDfbBTGHlqy87nIBrU4vZPzAs/0v4RtPHW8dSgsQRDBNPsYt0AcZmNG/TQguBkGeZ8P
	8zV5RP0NC8+otmZG3Vy6KDdhMDEDXf
X-Received: by 2002:a05:6830:82d4:b0:7d9:7ea8:7a4f with SMTP id 46e09a7af769-7dc951c7209mr15569047a34.16.1776875496506;
        Wed, 22 Apr 2026 09:31:36 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:70::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975034e7sm14178428a34.6.2026.04.22.09.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:31:36 -0700 (PDT)
Date: Wed, 22 Apr 2026 09:31:35 -0700
Message-ID: <c8745f07b8534a2e1fe4de143ea160ff.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260422033650.68457-9-kerneljasonxing@gmail.com>
Subject:
 Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit architectures
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280505-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,fomichev.me:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 61469448B66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> From: Jason Xing <kernelxing@tencent.com>
> 
> In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> uintptr_t cast:
> 
>     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> 
> On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
> mode the chunk offset is encoded in bits 48-63 of the descriptor
> address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
> lost entirely. The completion queue then returns a truncated address to
> userspace, making buffer recycling impossible.
> 
> Since we hear no one is using AF_XDP on 32-bit arch, we decided to
> strictly stop supporting it at compile time.
> 
> Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
> Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
> index 71af2febe72a..819aa5795f50 100644
> --- a/net/xdp/Kconfig
> +++ b/net/xdp/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config XDP_SOCKETS
>  	bool "XDP sockets"
> -	depends on BPF_SYSCALL
> +	depends on BPF_SYSCALL && 64BIT
>  	default n
>  	help
>  	  XDP sockets allows a channel between XDP programs and
> --
> 2.41.3
>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

