Return-Path: <netdev+bounces-270329-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g1Q7ACh9wGm+IAQAu9opvQ
	(envelope-from <netdev+bounces-270329-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 00:37:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F1D2EB297
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 00:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFFF23001C44
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 23:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2584346FB3;
	Sun, 22 Mar 2026 23:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9W9ZA8q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D12FD1C2
	for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774222627; cv=pass; b=Z1x0VEKfep9wLcAbuI8NzYeAJC9iMndUOVwAplYjohz6IkZ5iKxh4ci357hBNJmqQ+H0pxxG7ViVCNqOTeLOB872r2qXX8VkjYprHGFdyMPxzvPPjtJksc+4i9pWhWziowyUKDECdf+873ZZGFhIDYaXWkZR6KBs4FT7/kIJAxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774222627; c=relaxed/simple;
	bh=d7PBNXoAWJ9oKyq5BMHE3IFpACdy7SKGVvq01Y8kijA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDWYc7uLlutmlVZ6jTa7ZmnVzmYWxyw8gj6U34mouQwvVYcBk82KbqiWP+o/NmS/NoOia6CVsFtCQhApckL3GmLBCqe1vRCKne653uA9D0+h42iRkfw7bLEsOrnhukhtWHFHS06FZkLznMrpGUl44FeUXZPcw9oWiXmskfTpsU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9W9ZA8q; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2c0c4194b2bso127261eec.2
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 16:37:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774222625; cv=none;
        d=google.com; s=arc-20240605;
        b=azFUXrLNH8fl8/1QQYv+tEg1NY6aX45Hkw2f9P7vN7+qJIR1bfPbSG2I4DVmsDSjfp
         TTLV+zcua2T9IQSoYF2hmFXCEK5pDBGntsALWIYM8bSAKAaUvweaPmxZ4oZU35nGY2r1
         SF0oVH5Cfg3fVQE7t7jdjuRj4xCO2To61IpyyXNFVMLIPCfDrry8sFQcMNwpQBA7iqRb
         20xrcryWQQ6LFQWwruikX6RSqDBQLk8iYbHhpOKev2XokymQW4mvgmclUr0T1xPCP0yJ
         7ztNxSlbNF/+StrGyqwSL5YfFpR2CNJ+O15m/tq2Hz2JhluqhJWAdH9OjsWhE81/XQuf
         bqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3TFkIH6VCknZ8F6Tfn8RBWKBNHE4UMbauIDLil82xYA=;
        fh=IwvMdvL/m9pkoaJE2+V14NyeriHd7dZVfUWG7SDe+2o=;
        b=a6YPieQFEahvc8NlZ6xuw/z6z9+VUVUvPOTtaohl6CKnsFi1Y3+Xtcx51i+tJuzckv
         Kb1Nt+hHKNWL2X13mPNQRXJ/lj43tM/hGlm8JTfAmHHZoOXU8onomUm4OF9gRvj3E1ii
         3fyzTRjtUwogK8UJ+46DcXEQ2xY3OB6oMRPctM6QcQ37p5VqVlLWkk6+1runC0f/cD6d
         baY7WbH6sqpdYnRHleMPbY3APhCrXm/YN3smMYOzvSLcNk7WvTWLjI6uVrhkvhSlXjvg
         nuYrNSopVrDK2dv/MQCPBUsTbc0Aow2wnrcHJyiyjvWztnEEBGEvnl9DkS8yFNIHoOjV
         8scQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774222625; x=1774827425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TFkIH6VCknZ8F6Tfn8RBWKBNHE4UMbauIDLil82xYA=;
        b=L9W9ZA8qmmEzGtyrSM3MEliDmwlIObTnci3aB5OAQoRbdgSAy7xhuBYHXrJV5oiM9v
         Wp0rCmEwlcB/H8QGyyk4ZLsRHC//PjUpLhTFLdvk1knlcB8Nkgx86D1uvXmUH9qgVocn
         0OAXP6ZZC8vWjQ70trZXOlZ8R6ipE22cUQ1aG10MGlYgSNjNh7UcwoRqY64gjINs/vJU
         EkrWceHElYxLxDsFTiup+8dOtD+Asmnlmd/ZfIE7FrtcgTGxRSuls8h3FtPtqJdL6VAV
         bS6LBL5d+HehVK6la2mv3ugNnmmZPPNWvn6wUhqMGZfypGjZgoaVyJ74XAZ1253hQRe1
         KPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774222625; x=1774827425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3TFkIH6VCknZ8F6Tfn8RBWKBNHE4UMbauIDLil82xYA=;
        b=W3JYypWu2e9w1eY+HtpCegvZbV5BZxXp1eBM6RwnNcP7T3wD2qoMexRRR9aDmrfmSc
         3Nw4d93IulXi8bLz1qBBGfQHpWEdHYi4OgUFnIuZU+caMsiUH061s9V8s+ikA8Chb+vi
         O8aOzvxh1g3BOLoY9DdN0EKhHthMAG1d4E1MODt4fcZ5AlWVZEfLN5wL/HX9HssVvkwi
         WuspW5bkSfIEqql8kcgJd3sSc2ShFY8x09PHaVv7OsH10YQfY+SDLQbbyBjHQnei/Oat
         J933zmrKdTnDKVgFRzIuJF0rv1NTwfaU2yAkWmKxhYCqgMqbgVBHdME0wGoq5S052E5+
         7qOg==
X-Forwarded-Encrypted: i=1; AJvYcCXP07iL67ud/mMJDTO4Y+l1xbHbxJHwV/8G/bOuu9YEkQlCu9GM/OeN2ojuB5iDO7/6NHy2YMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhsHOD1SN/rti0T0G0K7OWH6SD0BuOg333+pba1CY6K4Fj6vGc
	uJvrW94YdiTnlx0R//uEbvWpG0OJoqSiQPJ89O6/ozmzNfP5pfWXlRtJYY90QEFICeKtepzIOQd
	jYNx/39Do8Ss2KJr9R8DvlztdC6pgaKY=
X-Gm-Gg: ATEYQzz1OmarAVWKnS+3HEtevHEJPUXoheM1iVFzK0SWaW6FAFCp8MJdCY5Ppc5BinV
	sdFHLm+hkYKexixWCiwFOWzwj8+hugioaeO5M1nQKaPLi2laLNOimteBpd46/OJlbGnIr1KLp+G
	nMNfuO/Tzhv083pjbkpTrWQ1vObxy3k+oBUEGfFRod1lSY1jHgLemNep1OE5rZFTMPlPIzXOPO1
	ZWhePY/Zlue0fDtdPJAeB4goWSdwm9p+ANQHBBlo1VUNamlw7i9WKKpwusXqadFhp6mtGUaKRHs
	c+OkRrEgUCtK25xngg5YUUJTtdEYaMl/OldW2WB0JEVmQoJzgqKhQdmmpQX+lOKstbcOxUZwpmd
	Sdj2kTFq2796Zp394b7teo9Q=
X-Received: by 2002:a05:7300:d705:b0:2be:681:91b2 with SMTP id
 5a478bee46e88-2c109784e48mr2354158eec.6.1774222624794; Sun, 22 Mar 2026
 16:37:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319121653.2975748-1-gary@kernel.org> <20260319121653.2975748-5-gary@kernel.org>
In-Reply-To: <20260319121653.2975748-5-gary@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Mar 2026 00:36:52 +0100
X-Gm-Features: AQROBzARASkmL1z31d-SPolLvyqalzs_slFQDBddlVkhvWh2YgJFEiUU-Y1iEYQ
Message-ID: <CANiq72kZH-AX=QQz2V+qCfVzMsUEAPan=o1E=OZOAnivj3L3HQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
To: Gary Guo <gary@garyguo.net>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Alexandre Courbot <acourbot@nvidia.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Tamir Duberstein <tamird@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Yury Norov <yury.norov@gmail.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Yury Norov <ynorov@nvidia.com>, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270329-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[garyguo.net,gmail.com,nvidia.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,protonmail.com,google.com,umich.edu,gmail.com,ffwll.ch,collabora.com,arm.com,infradead.org,redhat.com,nvidia.com,vger.kernel.org,lists.freedesktop.org,lists.linux.dev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 65F1D2EB297
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 1:17=E2=80=AFPM Gary Guo <gary@kernel.org> wrote:
>
>  rust/kernel/net/phy/reg.rs           |  8 +++++---

Tomonori: are you OK with these changes?

>  rust/kernel/num/bounded.rs           |  2 +-

Alexandre: are you OK with these changes?

>  rust/kernel/sync/atomic/internal.rs  |  9 ++++++---
>  rust/kernel/sync/atomic/predefine.rs |  2 +-
>  rust/kernel/sync/locked_by.rs        |  2 +-
>  rust/kernel/sync/refcount.rs         |  8 +++++---

Boqun: are you OK with these changes?

>  rust/kernel/xarray.rs                | 10 ++++++++--

Tamir, Andreas: are you OK with these changes?

> -    transmute::{AsBytes, FromBytes},
> +    transmute::{AsBytes, FromBytes}, //

Nit: We should take the chance to expand this.

Thanks all!

Cheers,
Miguel

