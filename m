Return-Path: <netdev+bounces-299798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uY1wCuwfMWoLcAUAu9opvQ
	(envelope-from <netdev+bounces-299798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:05:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B110368DDBF
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 12:05:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=aLdyCTz8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299798-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299798-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75B8430233CD
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC1D426EB6;
	Tue, 16 Jun 2026 10:04:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910A9426D14
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 10:04:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781604265; cv=none; b=MM0LLwgS8VwBVbE2gIb87roIt6wqCP9JFVyonmRCtLkVfOesQzelPuMhselB9QutVg6HobybH3yBI6HBWIl7CY80qDzJDway67jU5g3QWQVZzcCgRdUFF8ZRINsyD7uGa195WwcaAfuSwzAc/hfAUUTZKEcF6RAYLzk4PFPFIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781604265; c=relaxed/simple;
	bh=TIIjdlJ1X8AiPK1RSlH0x9/gUJnCBnzteMJ7p4ST+kQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UEIAmPnzIgwlsM9p6yOK1AKz6466a0uzZOyelYnRnhwdulmwECT/XaNMf4TB7h6uWucZqEnLRpTZsgKMFlMxRoDb4IqaiAlrOTGsI5npdzE74Gf8RbZ2hgVSgv8Ca85CNJ1OqrftEI/HaAFxKAMO0DuSjXwcUb8gbHhzI6oVPZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=aLdyCTz8; arc=none smtp.client-ip=209.85.208.42
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-693c51a8a19so4688599a12.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 03:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1781604263; x=1782209063; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mcc40ssZ1K96Uavp2GwOvrRk3/YMLKSUvUHIzWqkOLo=;
        b=aLdyCTz8BxLb2pE1vibPX7G9oJV1/kj0dy8k3ph3UnhioQS5hZhY5lD5YX+9JE8uOB
         Nqf4kCfkyaxnz/Zm6N8mCDq7Bxn9uWZP3Bip2K2tFoTb266D/dv48U1iGi0rULXS2YWj
         vZjAedcZkYI7uyy8WAqwrtTMZApuJ7VirSnUjUyUVBGSkHhxwGW3lvQskcEd7Kcdpdps
         /Wr8zoy7aVQR+PddCHSo0/y2pIu4BpUlddj30UuTGtbmLO8hll2KQt9UFgH0MLtEAros
         1S8Y0tRUXC2p3M0PucOuuEL6euv9cXR3bHRQCVkhS36Ptbx1KGZ/HvQsJqs98YSd45Ne
         gSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781604263; x=1782209063;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mcc40ssZ1K96Uavp2GwOvrRk3/YMLKSUvUHIzWqkOLo=;
        b=pigCTviKo1bYlKQzVqiEjSkj7aZHDfkWXkQuNHSsGqE4e7fuR36WVAehyvC82JHdP0
         VK2eUItDX9P1KIps1To0F9rWreV8AAD+d3Hl6CVg8KzocMINcLbhaOk454fE7Z3Nk6Zs
         4t+oR9eHbcR24v6/cOZLiMv0kjPQEJR3BQ+0Ihvf/kkv0KY9UQq7WCISWbkrz4K3NqT8
         P3wPJ54SpJrLidTeKyMh1Sl1H5/Z2D4v1ILHFaSxJK0cKdSwFY2oWp5mq0PMNHWnafqe
         pu/oXoFVsAA7ryHFGwt2rkvN2K7QKzcAMlRk5vMeLvhELlJ03w2Epelk9u5HmTt4gdnv
         GjMQ==
X-Forwarded-Encrypted: i=1; AFNElJ//1HJDQd35nsT00Mak9e08v5fipAgwD+nQPh0S1gCtGJX1sRw7ySHKDC3zrLW5jw/NfgMapf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDE4Ke2pFuMxLQRVVsBEsBQSlZQuvDNIJTt6+hRMHQs1Qz4Lpr
	kzu67Dh4sAIJ6+iANc43LvSa6bvilAdsYrRqq6GrvqwQqdaO0lsBNRwaHwcySrrLkts=
X-Gm-Gg: Acq92OHcZFH+vhnCCftwDP58AnkHRSVI2eivmv8FiX+GYW1oQ857/22EcFRjWnMaohv
	/FV1HgE13hg5MW3BlWdY6rLzkXCGdDu3O4FJ6ZiXagUWwBFDDhmGBZSbXOFao/4PWv0KkAh9DMC
	bmvqB52SxtWtN6gfteukZB7aSk0WKhEPelXis5bf61UzvyP+0GFzrA/0zE2KQX7/2osUBXXTBbK
	BmkngtUKlINbqDDq4t0PxlISWVYvxWw3Rf1d2btAG9F/k6TaM6mAooLMNyGzLFnRA5w22u1yk2G
	NJdb1UdpQy2mfFwoVjbLTuq0TetsrS+waUVrCx9hB3wTtqflGaIc8chBlbaBaXXUvllHCSXhUD3
	Iv4oVyWriNcDqdDku9x8uaa0WCRaFEF2s3EcMcWMqL9kq15g3QMN3yKL5XaUNababtl0kUGn+u0
	qv9XZglsVnxlWcExNSvYaqmp7iBA==
X-Received: by 2002:a17:906:209a:b0:bfe:ed06:565e with SMTP id a640c23a62f3a-bfeed065926mr404990866b.51.1781604260716;
        Tue, 16 Jun 2026 03:04:20 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb8341ba5sm623905066b.42.2026.06.16.03.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:04:20 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  bpf@vger.kernel.org,  john.fastabend@gmail.com,  sd@queasysnail.net
Subject: Re: [PATCH net-next 3/5] selftests/bpf: remove sockmap + ktls tests
In-Reply-To: <20260614014102.461064-4-kuba@kernel.org> (Jakub Kicinski's
	message of "Sat, 13 Jun 2026 18:40:58 -0700")
References: <20260614014102.461064-1-kuba@kernel.org>
	<20260614014102.461064-4-kuba@kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Tue, 16 Jun 2026 12:04:19 +0200
Message-ID: <87ik7iby3g.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299798-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B110368DDBF

On Sat, Jun 13, 2026 at 06:40 PM -07, Jakub Kicinski wrote:
> The combination of sockmap and TLS is no longer supported - installing
> the TLS ULP on a sockmap socket (and vice versa) is now rejected. Remove
> the tests that exercise the combination along with their BPF program;
> the file covered nothing but sockmap sockets holding kTLS contexts.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/sockmap_ktls.c   | 355 ------------------
>  .../selftests/bpf/progs/test_sockmap_ktls.c   |  61 ---
>  tools/testing/selftests/bpf/test_sockmap.c    | 227 +----------
>  3 files changed, 1 insertion(+), 642 deletions(-)
>  delete mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_ktls.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> index 6ed8e149e3d5..cda6b22cf759 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c

[...]

>  static void run_ktls_test(int family, int sotype)
>  {
>  	if (test__start_subtest("tls simple offload"))
>  		test_sockmap_ktls_offload(family, sotype);

Nit: We probably don't need to keep this one test around.
It tests pure kTLS and overlaps with selftests/net/tls.c.

> -	if (test__start_subtest("tls tx cork"))
> -		test_sockmap_ktls_tx_cork(family, sotype, false);
> -	if (test__start_subtest("tls tx cork with push"))
> -		test_sockmap_ktls_tx_cork(family, sotype, true);
> -	if (test__start_subtest("tls tx egress with no buf"))
> -		test_sockmap_ktls_tx_no_buf(family, sotype, true);
> -	if (test__start_subtest("tls tx with pop"))
> -		test_sockmap_ktls_tx_pop(family, sotype);
> -	if (test__start_subtest("tls verdict with tls rx"))
> -		test_sockmap_ktls_verdict_with_tls_rx(family, sotype);
>  }

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

