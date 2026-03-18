Return-Path: <netdev+bounces-268839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gApCLsv3uWkMQAIAu9opvQ
	(envelope-from <netdev+bounces-268839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:54:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7062B4BAA
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA9363061630
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF7E20B810;
	Wed, 18 Mar 2026 00:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTBcZmcy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BC0175A91
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 00:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773795248; cv=none; b=gbts9/rnH54kJh7nrJDH6pCSGkgp4FyWeAUxzVgmuVy9pQfMweR/RAcpkTzTax3UpvzrMCTFdN5AP6n7Yyfa/cMEAF5Qx96pDXSGvK2ieqwHywQvmd0hvbVlhe7G/2AYRrUTiNyFZwlYZl435AOB5LYYTbjZaOcd6zQc9s8AMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773795248; c=relaxed/simple;
	bh=LEYmdWK7Kk552UX5ZZybeDPpxRvo8AVLuiMGGPj5UHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klTBh81/Jddbk2pnjQe5By7OfOmxFX7R34wRrbVTNmHmJIhIozmR+l5bRqrD8Fu5geWi03s76z6G1obxA2bhqtMmZKGB85EI/vau05n13nPtTWo0Pc1gjnKJ9sFcA5ovfn26+jzXD8c8l/LzpWkvUZow77r41wpIdjfPN4cEadE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTBcZmcy; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ad79dfb6eso7357252d50.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 17:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773795246; x=1774400046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UAEC4LpUFt6nufrPf92R86ddLY16BiwOGudignGq+G0=;
        b=BTBcZmcyZtxR4rtVUZQpSET3dHYGss21xAB6JfH2H/zrMsqGYHKcTDAkpnvvE0u+Tp
         GVoy6LHccnwgnd+4wt/1IiZTRh/PhtdhBuszUFlddEvU/t3yDuQ1xL7MLq0BVXRbDVsO
         5vFm/YJBgUdA5WiQrMRjVH18/asRNE01Igj8tzl40J5/sF27vWNIQZvql5DboAzQdAJY
         t8wO0KKUbZ5b0zq3dPF9e3Hj7VEe7RaHOOPF2bdGW0oeMfYmAD4jePrEcswmuJroQxtv
         +zPHY5zP2FELIyNEiUGv18OZaRpJhyIRjL26+1AcOLAiP2BoFsW18hvuYrMkCq2bDpaQ
         kHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773795246; x=1774400046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAEC4LpUFt6nufrPf92R86ddLY16BiwOGudignGq+G0=;
        b=ggTWj6mOBylylrP68VTVZ1ZCbgVlkKrECB1vsCVC3qgeboJwASgRN36EqG0aMcd1Dl
         pgO0+pu/5A3OkUAT2UN9LoqETWFx7ghd5q+1Iz4/Mgia+dh48xpUQPrAWnrKr6B1xJEn
         NsbaYAjqiNQzfdZEHLtFbzX+DLWUk6Ol4pIgZbhdKGujaPAuRe+HB0X+sR6Wh2Djhrd6
         Wsxn6hkB0MqCHF7VV/kFfGQjw0r1yjY8s2b13qeEggJ3iWUoQ+QDh6MjfjTX3JR6jkVN
         +UvkQOJC44kUuCDW41J91KAOlnhzYjw7CEln/mPUAitUHZ0hjeiK0/p763lnDT06F/4H
         od8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWq0zrHW7SSzCgANilYLLRaAUy6nRfUbV1oZ2/gbhINRM26kHZK+5O7pOu9KAkFVEtSpNw904s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Lq0sTFk+FnPS5OBae85Nll9rcpsvtSpR74xfI3CzN6994S3a
	KcDCivSDpkeCt2gyFqMw4YyYZ+i9oh5abRoV84glI6s/QuNj1LIYP5ov
X-Gm-Gg: ATEYQzyZFFVZ1eyczhjMR3mV50PdlpxQkFuDIOlT28wx0oRLIm8bMCU8l/TwC8JgpSg
	fAENvYmkrv2uZbzXAjRz5goQH37uJoL9rlzqR+WEWzwN576izQV3DIUDU8dpwLeyHVKrX7f9OHY
	f2oUKX1PpCIy/S89KLPgorIxsSR+6qS62kkz/U1u0gK+3lyO12BG5f9xbUlYZQlJjaBFQWBfp7H
	TXmdMPqssp2VS/ktT+NBPHZzqnNjj5zSoxt377SiBqpFaPPieZqNuThP1Ym5VMeqgRdbl4oPeRU
	WX8waFNCMUJWUMkas7KGubzvS96ROg41lEEmWInwjEKN6T2QNIRxQvoWZM6jEoF+dQPS/deVjvF
	gnUeFyrYVEntFPuJX4NBopXfQoDDQyMzL2AqnJoZuZs6uzt67uqwLbugnGtAef+eK1earch//wE
	md3dfI1oXVLri0Oi3JAdsPHAUOG/28+50MU1i+0Jn8IRpcDbc=
X-Received: by 2002:a53:ee53:0:b0:64a:db17:3ce6 with SMTP id 956f58d0204a3-64e912ebf63mr1522789d50.2.1773795245924;
        Tue, 17 Mar 2026 17:54:05 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91c29074sm746207d50.20.2026.03.17.17.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 17:54:05 -0700 (PDT)
Date: Tue, 17 Mar 2026 17:54:04 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>, Wei Wang <weibunny@fb.com>,
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 5/6] selftests: drv-net: add netkit devmem RX
 test
Message-ID: <abn3rJGXXyDYSNzA@devvm11784.nha0.facebook.com>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
 <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-5-b53c8cd72b23@meta.com>
 <abns9COj7WagFtZ8@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abns9COj7WagFtZ8@mini-arch>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268839-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: 2B7062B4BAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 05:08:20PM -0700, Stanislav Fomichev wrote:
> On 03/16, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add tests for devmem RX over a netkit device with a leased queue. This
> > is the same as the other devmem RX test except for ncdevmem executes in
> > a namespace, binds to a netkit, and skips the ethtool NIC configuration
> > steps (relying on the test runner for that setup).
> > 
> > The RX path is setup as the following:
> > 
> >  RX Path
> >  -------
> > 
> >  Remote            Physical NIC          Netkit Host        Netkit Guest (netns)
> >    |                    |                     |                    |
> >    |--- TCP send ------>|                     |                    |
> >                         |-------------------->|                    |
> >                       dmabuf                  |--- BPF redirect -->|
> > 
> 
> Is it too messy to parametrize the existing test to run both with and
> without the namespaces? Feels like should be somewhat doable in python?

IIUC, we could have main() do something like:

for env [NetDrvContEnv, NetDrvEpEnv]:
    with env as cfg:
        [...]
        ksft_run(tests, args=(cfg,))


And then the tests could call helpers that check cfg.netns to use the
nk_{guest,host}_ip6 addresses when true, otherwise use the regular
addresses?

It should be doable if I'm following your drift.

Best,
Bobby

