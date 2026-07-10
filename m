Return-Path: <netdev+bounces-306619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HvgzApYQUWqw+wIAu9opvQ
	(envelope-from <netdev+bounces-306619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:32:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 548FE73C47E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:32:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=CP5PJfgy;
	dkim=pass header.d=redhat.com header.s=google header.b=kefbZYpS;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306619-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306619-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D0BA30078DC
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE0F3655FF;
	Fri, 10 Jul 2026 15:26:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12301365A12
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 15:26:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783697219; cv=none; b=QyXDXvlNrH7gZVE4NDreJ5Twl/k09SVycnIfUpUHBSZWm3x9YGwDY2LB+1D110bR8C2zbJk6jutVtuKPFvuiqHEdVbOeeHjyH9hXkBhzKJdN5UaK7aJ9IboKtnVrQLKLppDNVeADVQTJCR3MPyMamZdpxYZL64xiiCJ5FIygR2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783697219; c=relaxed/simple;
	bh=PXbwaqibc8aLYtHt2AbJ3XN4O9AIlRXDUFvInPc+0KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jRBNpv4qxnAEBcj1zgWIch4YKflomvDNO0rj7Yi3qEhCQo1Kud3OIEJTHToIo55RWi1eDAq45iVIjm4r3N9Bx6kXaPlzfE2ghXmf6wl5ZboW2bEBFuEMKhvgu0C8m4rx1gaG9+yejMfF5V09S5wNCjO8sBFaDjtzZzQVDP06kmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CP5PJfgy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kefbZYpS; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783697217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h+YxD4p0SB+CCECA8qTnq1hIIPDKgloEvcPzGaAbiCo=;
	b=CP5PJfgyUgyHF2QmzbMrkEsZyNnCZJ+ehUAfFpEG5pr5edJVeuXAwt01KEDx90oH62BNb7
	OYEryltNjFhOrkZx4OW2ZZ9J4jzXlFMJaRaFWvp7osGmaCS6LDFuWi1lALbm9XtQC54xlL
	xSwbhyflnzXQxSjsN60879VMoJPAuqk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-jorimt1CN5y0V-xrzJmuCg-1; Fri, 10 Jul 2026 11:26:55 -0400
X-MC-Unique: jorimt1CN5y0V-xrzJmuCg-1
X-Mimecast-MFC-AGG-ID: jorimt1CN5y0V-xrzJmuCg_1783697215
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493b54823bdso10986305e9.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783697214; x=1784302014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h+YxD4p0SB+CCECA8qTnq1hIIPDKgloEvcPzGaAbiCo=;
        b=kefbZYpSv9+du1gzG9yOWSdd8EPUa7ftQhWK7h/7dzWqO4XEJfrqYqj6UhIW6gS89a
         2oFQcDUEch3jD7P3X0QRayglG8KSa8hLteBThb0zNbKBLCdWYzD/8TfJv96zoNTAvvn6
         87zF41uK6+K5fQCmop8AtUOgfoNRUD/vnOe60STfQZwMeUk/EayMEtp29lN4TWmwcZBG
         uLN4GTHxRyCqMrbIjSY9HbVOMF353NYkcAFsNH4mPOGcYqG/UN2iT+UXkK48yv/IPQJl
         n5pJjBw62bKpTb6xiM3r3PMx65gBLj/+CT9aTmK7oNSpLzQWh8SvMoPMXFm0qfXe/qb/
         lobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783697214; x=1784302014;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h+YxD4p0SB+CCECA8qTnq1hIIPDKgloEvcPzGaAbiCo=;
        b=Nug+dZnU5NFr6vYHTKsFPN+tGihji0xpr+G7ZFvYOThalZbMUqRUSlZMqgFPYSueWd
         rvZZPIct7p/P8oNYS5HoZWtmsEMXRNqr2i7P6j0fI6b7WQzL9n9w1A3cFYCONncOz6Fw
         FaO7Kowy9askry80fNgqWw7xgaAcx3LK/aw71cASj+FW9sX92XGohpiGUcdfv+rxYkZp
         9+H//dXX73cUFvvV5oBScaXfBuURdeLmsN9I79T9/Rxmlcicx/7d0ROPxx4UycDljoS+
         TAX6+3uLgyVVWts9WQ6rNF1GpoZjae9vxePIZ+mozK5BHVgt8bzKplLVMHIO6tPZkrE2
         K+qg==
X-Forwarded-Encrypted: i=1; AHgh+RpExeJsn8awLK0SjRDS1dYwkO3r0PSDCY4Gw8GCKau/X66erM1SKFOswALRhai2oP9juCTateU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXm8JyiKRZqTyMjPUxF5SPehO3E76UISMmDLTE4zr7ndnxYdFz
	W6I+ryxN2uvKFhbpAYl3qvfLwCncCobUxkUgMBcIFNIiNceP42//0YDHPxhTzofKwI75VmD0e7K
	kYX6KtIXxj5vObQE/KV5l9fJphlOrzZgwW5zdwo3YsqNZd+Fip3dmRuR3dTpppEuGlw==
X-Gm-Gg: AfdE7clLxiv8Sjui3W0i2E2k4nrURgGab2cxjhEfE7nD2loJaPxmqbvDwXwlrlDVUj6
	NNNSDVL87RLve6Yf4UJ3jDR9CMiwxFjnP8MUMhUsx6soRHAntPzZSsfZ3DICZ8Log8xAwNcDPK5
	pjMm35IublW/bC23kAlSXuKRlsgk97v9rNz4T9E5RbGyoBn2ZePMiiL/A0pJvcMYmRKyu8oHEdw
	0TEGGL5R70MU0M39a3xJqI5KeqGXcVP8b3AGVm0954FzOA6Wpqkg4WE0Vp8phw5bVO1HYzkNNgG
	ScSFZPGEmbIJup+Iozx3408kRIjVpao2w0flhXcdi2ve4yZgJI+JqSAsRSRFtilG8+d8E+ycT+f
	A9KymvUaq0g63BB1P6/jIB3mBfVfFq7KPcjc+FOpixT7n3HOeUL8VPBRKcxHtjk8PURfjUCnI3z
	PjQ56kpJft7aqu
X-Received: by 2002:a05:600d:8445:20b0:493:e963:e671 with SMTP id 5b1f17b1804b1-493f2b24ce5mr32456975e9.3.1783697214638;
        Fri, 10 Jul 2026 08:26:54 -0700 (PDT)
X-Received: by 2002:a05:600d:8445:20b0:493:e963:e671 with SMTP id 5b1f17b1804b1-493f2b24ce5mr32456695e9.3.1783697214203;
        Fri, 10 Jul 2026 08:26:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2d97527sm75852785e9.2.2026.07.10.08.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 08:26:53 -0700 (PDT)
Message-ID: <531c4085-e7eb-4915-ae63-c53571930aa7@redhat.com>
Date: Fri, 10 Jul 2026 17:26:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/7] selftests: drv-net: extend so_txtime with hw
 offload
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 horms@kernel.org, andrew@lunn.ch, Willem de Bruijn <willemb@google.com>
References: <20260706133433.3142805-1-willemdebruijn.kernel@gmail.com>
 <20260706133433.3142805-7-willemdebruijn.kernel@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260706133433.3142805-7-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306619-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:andrew@lunn.ch,m:willemb@google.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 548FE73C47E

On 7/6/26 3:34 PM, Willem de Bruijn wrote:
> @@ -38,6 +41,34 @@ def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
>          cmd(cmd_tx)
>  
>  
> +def _dev_setup_pacing_offload(cfg):
> +    """Configure pacing-offload-horizon."""
> +    ethnl = EthtoolFamily()
> +
> +    try:
> +        rings = ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
> +    except NlError:
> +        raise KsftSkipEx('ring-get not supported by device')

pylint complains:

tools/testing/selftests/drivers/net/so_txtime.py:51:8: W0707: Consider
explicitly re-raising using 'except NlError as exc' and 'raise
KsftSkipEx('ring-get not supported by device') from exc'
(raise-missing-from)

> +
> +    if 'pacing-offload-horizon' not in rings or \
> +       'pacing-offload-horizon-max' not in rings:
> +        raise KsftSkipEx('pacing offload horizon not supported by device')
> +
> +    if rings['pacing-offload-horizon-max'] < 50_000:
> +        raise KsftSkipEx('pacing offload max horizon too small')
> +
> +    cur_horizon = rings['pacing-offload-horizon']
> +    new_horizon = 50_000
> +    ethnl.rings_set({
> +        'header': {'dev-index': cfg.ifindex},
> +        'pacing-offload-horizon': new_horizon,
> +    })
> +    defer(ethnl.rings_set, {
> +        'header': {'dev-index': cfg.ifindex},
> +        'pacing-offload-horizon': cur_horizon
> +    })
> +
> +
>  def _qdisc_setup(ifname, qdisc, optargs=""):
>      """Replace root qdisc. Restore the original after the test.
>  
> @@ -56,6 +87,7 @@ def _test_variants_fq():
>              ["one_pkt", "a,10", "a,10"],
>              ["in_order", "a,10,b,20", "a,10,b,20"],
>              ["reverse_order", "a,20,b,10", "b,10,a,20"],
> +            ["beyond_hw_horizon", "a,70", "a,70"],
>          ]:
>              name = f"v{ipver}_{testcase[0]}"
>              yield KsftNamedVariant(name, ipver, testcase[1], testcase[2])
> @@ -64,15 +96,42 @@ def _test_variants_fq():
>  @ksft_variants(_test_variants_fq())
>  def test_so_txtime_fq_mono(cfg, ipver, args_tx, args_rx):
>      """Run all variants of monotonic (fq) tests."""
> -    cfg.require_ipver(ipver)
>      _qdisc_setup(cfg.ifname, "fq")
>      test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, True)
>  
>  
> +@ksft_variants(_test_variants_fq())
> +def test_so_txtime_fq_mono_hw(cfg, ipver, args_tx, args_rx):
> +    """Run all variants of monotonic fq tests, with offload horizon."""
> +    cfg.require_nsim(nsim_test=False)
> +
> +    _dev_setup_pacing_offload(cfg)
> +    try:
> +        _qdisc_setup(cfg.ifname, "fq", "offload_horizon 50ms")
> +    except Exception as e:
> +        raise KsftSkipEx("netdev does not support offload. skipping") from e
> +
> +    # Expect all tests to use only hw pacing, except beyond_hw_horizon.
> +    hw_only = "-h" if args_tx != "a,70" else ""
> +    test_so_txtime(cfg, "mono", ipver, f"{hw_only} {args_tx}", args_rx, True)
> +
> +
> +@ksft_variants(_test_variants_fq())
> +def test_so_txtime_pfifofast_mono_hw(cfg, ipver, args_tx, args_rx):
> +    """Run all variants of monotonic tests, without fq pacing sw backup."""
> +    cfg.require_nsim(nsim_test=False)
> +
> +    _dev_setup_pacing_offload(cfg)
> +    _qdisc_setup(cfg.ifname, "pfifo_fast")
> +
> +    # Expect all tests to pass, except beyond_hw_horizon without sw fallback.
> +    expect_pass = False if args_tx == "a,70" else True

pylint says:

tools/testing/selftests/drivers/net/so_txtime.py:128:18: R1719: The if
expression can be replaced with 'not test' (simplifiable-if-expression)

/P


