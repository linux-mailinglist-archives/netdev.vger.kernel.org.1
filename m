Return-Path: <netdev+bounces-283906-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNFlHYy3+Gn1zAIAu9opvQ
	(envelope-from <netdev+bounces-283906-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:13:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF414C0810
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15BC630BE138
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A403E0244;
	Mon,  4 May 2026 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmp0XHie"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292613DE45C
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906466; cv=none; b=EOmyPTEk5hN/1qZrU1RCxyxXv3SNv+34UoRreIZjy1ZhDC1kG57hBpsArbGdc9d1D2SYyUvOOMxrYDFLvf2OMRuYe7jDYHKbX2t3D6uo7RI573esY9tmG7fc+btEH9ig2UE4G6pHLQiJ5IxTwL8l+0kH/9nzf0jkHjHc9yDHBV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906466; c=relaxed/simple;
	bh=KHqYr0ItdAFMXMIPUhb8rlWKl8ynxj6igZ73aDx5RRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoHcs5b8OS/f2t+2SDNo+f3DsUAVvC6uWzd4DHreyn8S0SvFMjcfi1Tj970KfI79wOsdHT0b9MrWmUE5pt26RMpvcD01cxEq3EJq7ficLoQHqjbhctjdLWVqM4iCkV0C5/cEptbLtBLlckYbc+tWYa5rZ4lo/I72jsWJhwQ5K0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmp0XHie; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-365313b86bfso857692a91.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777906463; x=1778511263; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6kqUUkAQzlw4Bmuk+4uOMY5eXHd7Lb2epHcnpLdT4Iw=;
        b=mmp0XHiekBoxQmGL2lAhOK7VYw/4KOJ09ws7OqAZ4ex4xzXTSjyNFCrK696ZSGCGCn
         EbMILymXPgrGicTTtfpCPjif/TCRsKwzfW3kIoOjFhKAoCueM67gWkpB3leCGll/ln0+
         94seTP61Zabhd6WFok6AAv1zmORFEwQ4iqWGut2uTDj2E8Y5JIWvCuoDD+oh1D6tjAl1
         EYl4cAdNeoz9wY7JCu3CZssKdnbekX4JLQ3kw4IN22uUsfw3DqPQsxTEyO9HpS4I6y09
         ZzAbZlAFm2b6dwji+DdPRtN6mSnYgu/WIGKfsYbllDE+RY/r2S+YhvO86bDpQTAbEsKB
         TRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777906463; x=1778511263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kqUUkAQzlw4Bmuk+4uOMY5eXHd7Lb2epHcnpLdT4Iw=;
        b=kg9Pl5lRnAPXJsuZ6QGeuI+uZXz6w1Ikc7ni0oqXFbLILu4d7yr3bD/NEZEDoGtyPK
         tlSG9nBQIUGyPTurEuEkAdU/XeIGbHuK0TTIO/EbWJvWvWNODpZWEZuGyTpBaG8NOgB/
         m5+gssUbXjlY48yl18mAQIw6t1ghvFeLtRJja7grcbr1ewtkBOZ0RVX6vwjujVeXtWkK
         DD7OIumeE7AoS7AOoF+BnCU0II7z2luce2jEYBvicKMU43IErA32jo/QzWZH96FfuYlb
         cPk8KHfgyIl3h0eThkRutT47mNfAU4hwIrA6FW6TZw6yBcluReskuEgIBjbCviBMaJWp
         SMbA==
X-Forwarded-Encrypted: i=1; AFNElJ+Pxx3V7EO0mQLH2NRcx+wNQ5lg8zcfTPYMKYKSWZV6yOoduK1yUPFaI/dWLrEb+CQKwEVLQIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxzwJXJllqIxRDU6MAEDi5crc+/g7q7q89eNuJlwPMNdATDbN2
	NouwBYyaTo0ct4zQFpRT5rXV7owIGvtouYP4a1V5e5kPONFSNp1EOOFAWAqcnxfk
X-Gm-Gg: AeBDiesFSNRwUEPeqGZQOI8QSu5soorQ6B0iS+fNJznOV7xGYvsj8HFpA1HhvzlugYB
	8ONXyJ8VFrIxu0gB8n/s4nF3OhHMSMluXcj2pFgDWcd9mCNFE+e6FrnbL06xWIhi+JcAY216fpt
	uTzQ8fQ+tosp1CW7uOROi8PMZqD6DLcntW6Z33/XPNFIw7x+zB4k8xVPC+sItYvSdfX+c3fxLHm
	NpFNdLFJ5d++rKODptBYDBa/vLYX5hh2h7z88FsNRvlEVcZKPePLfd/LGbuVAugAIAJf9wDyS6P
	q6VylQO139NB2Kif4wUDS6UlRcIcw8fH340MMNTH3NRqNHCOI1prKsKSgcFU1WF+xR4fbpTv/Vw
	OjZ7VxvResUYDtChx2VXpm5kOAFtw+l4Wu+vXag9gbNm21hi4KWYxQB+Cn87xfdgKBUACTBiMLJ
	eLbGqyGSB0t8f/Jg3e+1k1FtFZog==
X-Received: by 2002:a17:90b:2888:b0:35e:5ae3:2993 with SMTP id 98e67ed59e1d1-3650cecebbdmr9653365a91.15.1777906463552;
        Mon, 04 May 2026 07:54:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364be028cd6sm14794209a91.14.2026.05.04.07.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:54:23 -0700 (PDT)
Date: Mon, 4 May 2026 07:54:22 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 2/3] vsock: convert to getsockopt_iter
Message-ID: <afizGJmDPwi92IHx@devvm7509.cco0.facebook.com>
References: <20260501-getsock_one-v1-0-810ce23ea70e@debian.org>
 <20260501-getsock_one-v1-2-810ce23ea70e@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260501-getsock_one-v1-2-810ce23ea70e@debian.org>
X-Rspamd-Queue-Id: 7EF414C0810
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283906-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,devvm7509.cco0.facebook.com:mid,fomichev.me:email]

On 05/01, Breno Leitao wrote:
> Convert AF_VSOCK's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t. The single
> vsock_connectible_getsockopt() callback is shared by both
> vsock_stream_ops and vsock_seqpacket_ops, so both proto_ops are
> updated to use .getsockopt_iter.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of put_user()/copy_to_user()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

