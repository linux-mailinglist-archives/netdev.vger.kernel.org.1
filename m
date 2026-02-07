Return-Path: <netdev+bounces-257766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ34H7dOh2mjWAQAu9opvQ
	(envelope-from <netdev+bounces-257766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 15:39:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC04106373
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 15:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75AAD3020E95
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 14:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598C6350A1B;
	Sat,  7 Feb 2026 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="d3Nqzrp6"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4AF2D9EF0;
	Sat,  7 Feb 2026 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770475093; cv=none; b=U7qtZA8BxeK5xzqVXOq0X9u0CGyp/tNiwz0S+Gaq6MiMBKJColzTKKmQ5VSTSvVzklzzAFNC47MqG/Zlnbdc8DxUbsTBUZjz3+Riy+axl78nRyNGLk4uKqHiNuDGXnk84duLWKIE2ztOD3NKxNo5MKNIrmxE/L7wyzE8nYmwRwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770475093; c=relaxed/simple;
	bh=uPhTkoUWjHgNMwwXTNmsb77q8glN+hMS3JyqfBiQvpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IGgQ3i2mwll4bKzvQHLd4Tu/hip+HNYNAf3qqsafzWsYhJSc4X1iaTtJw2gXits6sFiUzCQsavJu8xYiF4L7rRb/EVawiJs5dE+DniZjCOD2a0pCh/8jswJ+sUeMWFzQreW938N7dIRglM6YBNuTKPXqSb6RLYRNqgIkTuSccTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=d3Nqzrp6; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vojRl-00Aje3-5W; Sat, 07 Feb 2026 15:38:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=TEPq9Z1dVcmlqvSnG6I2Wyw56Ztf93dpV8RY4AtCcjI=; b=d3Nqzrp6lhqZ4T8FFWvs2GkYJy
	u0iw6c5J4M07zofx0kGPoNIfASUWnCbJ4c+0T6pLvCZcNqdNhgiZZdvwH29idGesyOzECDCqZor+q
	YMhLn4bvfcfiw7rt8bHWyLH/EvuVNejX+LY2rN21dWH61B49a1RLdtYhIyISZsIX9ulfk2/SNBo+S
	LrgwMoX5OTRCqpNlYXuWTTJ+LETzuRs78D+S2D4rM7FAtyqfDGGn7nYS489eYHx+06GxJDPDw5VgX
	jB8FFv7BTpRXDes162Zfd2PbiJBbDjrdvcBdhdmvllgJcdRB2tkYlou8RS+UEnlUUKfoznlntycZN
	8f9J8/6w==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vojRk-0007hg-QE; Sat, 07 Feb 2026 15:38:04 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vojRT-006OsM-Sd; Sat, 07 Feb 2026 15:37:47 +0100
Message-ID: <82925c1e-11ad-4cf0-9b44-c22ee9193cf9@rbox.co>
Date: Sat, 7 Feb 2026 15:37:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf, sockmap: Fix af_unix null-ptr-deref in proto
 update
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kuniyuki Iwashima <kuniyu@google.com>, Jakub Sitnicki
 <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260129-unix-proto-update-null-ptr-deref-v1-1-e1daeb7012fd@rbox.co>
 <3fc5611f-394f-40db-b49d-2f26402e221a@linux.dev>
 <3362017f-9c3d-46cd-b3ce-cb750b565d5b@rbox.co>
 <612a9446-252f-4b14-8605-ae1af000cc41@linux.dev>
 <CAAVpQUAc3S+Ebx2qp-Pbg9qH-Zc=yHdzVJbchCu++V_4XF3DLg@mail.gmail.com>
 <7603c0e6-cd5b-452b-b710-73b64bd9de26@linux.dev>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <7603c0e6-cd5b-452b-b710-73b64bd9de26@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rbox.co,none];
	R_DKIM_ALLOW(-0.20)[rbox.co:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257766-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,google.com,cloudflare.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[rbox.co:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhal@rbox.co,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rbox.co:mid,rbox.co:dkim]
X-Rspamd-Queue-Id: EEC04106373
X-Rspamd-Action: no action

On 2/2/26 20:15, Martin KaFai Lau wrote:
> Regardless, if the proper lock is held, all this complication and 
> reasoning will go away.

Here's my attempt:
https://lore.kernel.org/bpf/20260207-unix-proto-update-null-ptr-deref-v2-0-9f091330e7cd@rbox.co/


