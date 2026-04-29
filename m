Return-Path: <netdev+bounces-282371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEzVHUz78WmElwEAu9opvQ
	(envelope-from <netdev+bounces-282371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:36:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F067C49423F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1565C30330A9
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4678F3F2101;
	Wed, 29 Apr 2026 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rkcrr/JK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BDD3EF663
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777465929; cv=pass; b=ZMoMYV91cujLrXxyj7DdZrcHwpflvZumV4GrbN8OHltH0pQ6ufQjo5jeVP4IBJHNcAsW7yKBHzl5JzxuBxYXhQdeR1q4srwQ42KhzyxlzY+hsuoTzKhrW3rz6Cf/6Y04c68xErBz6i4ykYjrw+eRJLfB/db4PLUNInQdEF0pW50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777465929; c=relaxed/simple;
	bh=KGv+d56Pg7QWyBPbrJ4qHztALT+NJSTOOru5rKlWGoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2lW60c5ZDFIiZ5SUJqEarmLfEzwJGW3pP0Jl5jPz0qmTDmzGpMd2qb37c8kRs7SxG+ygxsCeh34ms7dTekcaTKJRHHUgGXDZDZtX0su9+KyPm6mMSKEgKHcqWAV4/5JOo3quTxvhS8uiFrES9JALezTR+0BDzaEp8aCbzUT7R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rkcrr/JK; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506aa68065eso90715561cf.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 05:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777465927; cv=none;
        d=google.com; s=arc-20240605;
        b=aI6z7rQnL/os4uTq2L0JXc6X+nZUoYEcxuA/FI2zQpdsvOu49mhy6IuA63FMboA74R
         x0lzQgRjvVQBkIBXTH0Q7aTC6IA8PaHShBNVx4YJBpdNhXVm3V9ePxd/QBAHbs7f3w3H
         74TKKjWg/s87dDAi4wd3Uv22R/tXgymkGO8F21/rVX8lmzlJFr5Bjz702CdUaNh8mohi
         PanbhS7yyLbp/wOPxQqsFTACE/T6QhXpu4rIzVx7lyGUXTwlUO5RzcMLfE6peSc/v5UV
         YSOuz7FWLz+4TUXEfFJnXgMqUjRUue4dE0p19tTkvjvAktpqYBhA3mtZbKo9HullSBNw
         /vHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9DHs+YzocsqeU+mv/fyZTv7O47rCb6IRdrHqru+bKqw=;
        fh=vuEPLyGSwB+7RzNTOI7nlc8Tp08bner6A1cmXtHNWEE=;
        b=JzIsCusnd/i51CfUahFARv0Rvz6dBV4VzGOCbfSqhPwkURw2XB8Y/5A/F5Xe+R6I+v
         JgAx3H2+3e8xXg/MxKH3lH7fo7jxmMJbw3v4m6m5llY6WKAQOoZgMX2gtdK/1H3F0FOi
         s2FSsijDCo7Dvql/rjFl8yp4cR9zj0+e0AxcwwEeWkPqqqI1kIIgH7Cp8SGBbHYY3OsY
         I41PAAHZeeIfo2cNHe3XKkVUsaRLgnWtoFZMwkCoZ8Z2u5zTmDmPVwKvljNnE1MR6Bkg
         0werErdxJgjlaSVfQ3VOn2GSkrTRQXUwTsdemLQLAvRO7j0hlwqeHY+rt/+zkKYVic9U
         Gb0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777465927; x=1778070727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DHs+YzocsqeU+mv/fyZTv7O47rCb6IRdrHqru+bKqw=;
        b=rkcrr/JKz6zRqdQofqPNeiMk0oGTL4Qd+UJNzzKhAIOq4o57iDSTq6tITLs1iA1Osd
         A3HqyNky/erxG1Vhypr319cZCjuCgGbsjDx4VewdcRyexPouDtFP6SAACxOrlBHrE+kb
         6A+20fy12nCoOaNuHtcftiyVM3kM8QUJ+jbZvBMnttCvSg0zrWpVc8jpYXFVKHPZP9al
         VvUjlSMMkoASk1Lys2/QaExJZ4IJj7y+fb+OR3EDgC/DWRwqHvhQM5Q6KfiQjhyjA+wd
         tFjZS/jr9buzio9LTQYMDKCudAdPVuXaBBed6FBlp3TWJNowGwcRExlHG5qrLQhEf50p
         PCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777465927; x=1778070727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9DHs+YzocsqeU+mv/fyZTv7O47rCb6IRdrHqru+bKqw=;
        b=Yig27lp5vcNpLVfRZEJob9pOnqi5E4Uo3NktrXLHqsGaHvuOEDPiOuTvbTlI39kk9r
         4R1zKXc1kg6y7Fr5uWZKXI+uRkW49IGBXJUGaOS1YqFn1oGmseTmzVWdKjhsm5NUmAER
         yHaKqm1FzunOavwYwuPZLHx3roEmpJW13QAw0RshpX449389MJPpghrOL5ZXTlJtcRTy
         8TBhmNV+HD98/bWPdfQAlOdVNO0QQ3v+0xKoO5xOhhzfRdemeIUkyS3mhYnRTHoJnj2V
         59PxMzkK+5tm4q9CuEwOl4EqxVq3a2s9eR3Ru2EjnM302Rl9UtVJ7taWEOVNA5zWmOGx
         nbvA==
X-Forwarded-Encrypted: i=1; AFNElJ9CywWmKueVNghVkxui4iAyuKoTuKOOKqekbQYdfwSh2ui0kUcLeBfI6TNT/W2i1ibmADjntZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH5LCM5jTOd3V2RX06H0HMd5F5GlWFb7Ad5qmvSOc9k1JGsprm
	mAIekGFN848m6jIYFW9FcNelaYWVNlwEf/6dkHRoLLZaUbcK9mfEjgLv2tqhMG1yS/MEBEzupy4
	qB93xQWDNlPJw+V+HWTJCvwrAkr6L7oB8EdBV5fTf
X-Gm-Gg: AeBDievALb21InPLdRZwMYzCGUY1hyPZvqz1pQXnezEWGnioRruP+W4BKeMtl8IrJyh
	yuu9yotdcL1SST8Gi3VTMo0dF6e2X1Wnlv+5oIdgujBXOodFXHgXlyWSGvdZWVMTZZ2xP9Z1/e9
	yeFNs8e6Hu0eT2eDfN5PdFbSUarmIW9QcstwVWYfT9N0fjHuqZJF5PYuhfkmJ9QIWZKmT8xH49a
	VSY1JOwKfJDoGVGi8kTNDWDkjejplWe+Iuvh2NBugKJwXjFp3D0k+UjeQEZn/mhP7shSnxgVuzP
	UbWPzboIVKrpf30ER6Yel+RH8lHBe2HRr7QAijYehTST+NUp+EomkLw1quDa1XQiNO9oGdHuqzx
	65W5Qy2cE
X-Received: by 2002:a05:622a:480e:b0:50d:60a4:47a7 with SMTP id
 d75a77b69052e-510189363a2mr51069921cf.4.1777465926253; Wed, 29 Apr 2026
 05:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429123741.3777677-1-yuehaibing@huawei.com>
In-Reply-To: <20260429123741.3777677-1-yuehaibing@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Apr 2026 05:31:55 -0700
X-Gm-Features: AVHnY4LqdOcLvpMRs8mkOJGdSd5JEyHBiKDCrR6RiidZ6hVrPe9macOE23BDm98
Message-ID: <CANn89i+BCcSMCPTzrXPrJ2Zevtrjj6RYu+cadT6qXErMLmLNRA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: core: Call netif_get_rxqueue() in get_rps_cpu()
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F067C49423F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282371-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]

On Wed, Apr 29, 2026 at 5:15=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> Refactor netif_get_rxqueue() return NULL when rxq index checking failed
> instead of falling back to first queue, then use it to avoid code
> duplication.
>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  net/core/dev.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
>

This code (get_rps_cpu()) is super hot for some of us.

Are you sure netif_get_rxqueue() is kept inline?

I do not think gcc is smart enough:

scripts/bloat-o-meter -t net/core/dev.o.before net/core/dev.o.after
add/remove: 1/0 grow/shrink: 2/2 up/down: 116/-132 (-16)
Function                                     old     new   delta
netif_get_rxqueue.isra                         -      84     +84
dev_getbyhwaddr_rcu                          133     149     +16
__netif_set_xps_queue                       2837    2853     +16
bpf_prog_run_generic_xdp                     899     846     -53
get_rps_cpu                                  835     756     -79
      // This is bad,
Total: Before=3D90848, After=3D90832, chg -0.02%

