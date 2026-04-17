Return-Path: <netdev+bounces-279298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI/UMWMS4mkg1AAAu9opvQ
	(envelope-from <netdev+bounces-279298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:58:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C3B41A870
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 922F830915F8
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0782D33557D;
	Fri, 17 Apr 2026 10:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpG4++RE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBAC3750AC
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423258; cv=pass; b=PZxNnAwXUu2B7UcEZsp6OEqLP2mi8giDLdntvdKTLZrIMnG9gffxHKwza3hkFGtKTK+iX0yuJS3AEPFo9AWAnEgbIaMHLK0Tz8a2aMfL6YX1mA5MENrG27SA9EVTGkySUQ2dddwCtD7jQr5zF3AIdizRLAbWRtnYnETaFSq9wOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423258; c=relaxed/simple;
	bh=rYOrWIDSNXAQo54u5HrFdLmmao5azs25TBe5nOd11a8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEESMp26WJH7GH1TWvVP+Z0bpXyT34K1g7i1CsTxo7dcE9D82b/cVIlFA0kecbwmT8TEyeKj/lQjwevbbaaJY1llRPyyIWEa1dqoB11KG1gM3PuuIQQt611g8YNzy+W80R3ABKq7WWadQX9ORG8X0Z7ecrbunA5ZN6dBmwggUt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpG4++RE; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-682d981b025so312713eaf.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 03:54:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776423257; cv=none;
        d=google.com; s=arc-20240605;
        b=LiLcOIuhpl483d6A3BpvGzEWk7nfx/f1RBnZ6xyGC1hWnv1L7dIGmRNgA9fTxCmIGZ
         bYcJWaGA0PsWNz7/bVEqVxpJkLv7RGqM4eVP/kdIdyIhAbdMVb3Y3nIPxwEfgZoVjbOg
         eCpxUHel+C24mLgQeEfhtC3C6ecUd91oICAwrf7UNaDfPBv53gO56xOuGIQY1vr0S4Vg
         itTCbfvR64ZFY8CUem+vYCNoRKx3zQg88IkWYDreyelsfn+CDAPE+qifExh8074z12HH
         CoqnDSh+4p4oQTpclR1Dz7mBAp3OHvK6yrP6VIH2qK5XIT6bLicbECkq1Wv5WfyXPKXH
         volQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=rYOrWIDSNXAQo54u5HrFdLmmao5azs25TBe5nOd11a8=;
        fh=zzd/IfhFdPvXdZGJlOdS9FH4Ul/gG8znh119JFNSCxs=;
        b=AsDEQV4mRLHaOj19oKsIXW+eo7molHhnQt+ZP5+c6F02p2QJyi1R4qu8QCPKsx9vvr
         BHT4O5HLbK1VU0oemcx6SXh2jvsNN1ktlURdFSSwXEuUvg6SrM0Ek0bkgd/D9dWfrbum
         xP58pbx8dq8L0L4azAgqq/10duwOId/WZKUPwJGHb93jsCxWWpAeBny2siFjqWFeyEya
         2TdBWFcQ1GHi9+tK6xLsfYabWguB30KNEg0wyOlbzp5a4JMYw+0hBrZI0Zkb4eh/6ew8
         Z7ZJfL0qSmMv7KSiLtDQAP4jcwI8cYPePjTVqrm+Ryn+QoCoqhCRtS21kjiQsW7W/TAZ
         aSPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776423257; x=1777028057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rYOrWIDSNXAQo54u5HrFdLmmao5azs25TBe5nOd11a8=;
        b=RpG4++RErmHAAKDAZbhCT6l/NGFEoY2SnzdKJXyitikagcxbsIDT27ggp2PhzCD2hH
         +KV+yyZpcKQnXuviY8Fbpuki40kF7E0Zm8FJnldfPt1t1fPKSdKMcXhK7OJ0MjV2fpgQ
         ZAxZe5VXuKzD3QW3KKnGIbgBCaufRPp/Erg31jBVh7MrjjIMZn6JVYbcjoYc5HhIQmhe
         28mtcglQ1Z/95td0V2nu0t/4irk3YerKd2stUPX0TMoVlYptdfA42f/mVDhfxvaZUHXZ
         RCytV7DPOin0PMMXjuVGWSja3RzvN6J0p8yEHQ6nDlkUmpcWOCfOBQfcqOYsQKW1FBUk
         qPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776423257; x=1777028057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYOrWIDSNXAQo54u5HrFdLmmao5azs25TBe5nOd11a8=;
        b=eGGU4mJOQYFQ8qJpYleG9rGVtOpTJwmeKxJNkvZ6ukKolwlqH2e/Eh2+nxDIXKrDEy
         eQNo2eb5wouXaM0D1lTFvz9fwnhHJcfL3Qx0L8nVv+3Z8D46Ngq9LQIantMHn9aVrXVK
         B9vu4qG8s/UnZRpMmCztibbAYro1yTn9abVm3QLigqLANc50UQ/JDOP2in52Y28TRSce
         5sJIhWUufrI2ct2HNUkj0rGQc1w0WWiH8BrusQDwjfagXy/OxlxZJ1csvzthzo51CBk2
         xI0okEqAz7mpVrq6Suh72KaCZXZc/wIfQCsZOJEkEwGy6jWB4tBIsgR3KOnSlvH8gqQe
         kyoA==
X-Forwarded-Encrypted: i=1; AFNElJ88caRP3vqCZqRj26VirFr5ZwW29PtKd+ojPQEXaGnJOausGDBwucQkAbG6cRX9mHKnteMxv6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjeO1Ct2iIpxvd94Lx3r6uT8oCo/e0AjEcLLU4V8TunZfX4/rm
	Sk03aJV594hUCKBwRp1Le93U9sxvtG/Gp8/2PY7IBehm4kLIDyFR4VppIvtNb9bAjtzmaH/z1Qt
	ZImx5WsjjjzVFcZlOJM/xVZUs4M5aPIY=
X-Gm-Gg: AeBDievT206lhtEn57WrbqjYTWcNIYAPfdvHOqKqt65bc7cBQ0Osr7fm/elE7LQbhLl
	THoOV8Y8Q4AZ7I0l49CVslIwj/VMEjFV50S//EMS+G/ySFJq3qfF2PjPYF/0VhO8dcBw8Ic75xi
	I7Zti8pBi8oSHfUxMH3SrGZio0T8Awt/7+9GzycDCJ0GWP2M3bbuint7nzSiva/ZfiGRTHJ9n8k
	s+3RGKuKV7j9qHY7/6HBuKsJ7v2CtIUPxn0m4vpb0ZghztUy7dZmr6Spi50ak4qtwxq8uTQrYgc
	j7zZmb5BXg41bzzRI+C9yDMLmjmKgcqwwSMvyPHt0f11kRba
X-Received: by 2002:a05:6820:607:b0:689:dfc8:5e2f with SMTP id
 006d021491bc7-69462f04d37mr1237951eaf.47.1776423256628; Fri, 17 Apr 2026
 03:54:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com> <20260415-binder-netlink-v3-2-84be9ba63ee2@google.com>
In-Reply-To: <20260415-binder-netlink-v3-2-84be9ba63ee2@google.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 17 Apr 2026 11:54:05 +0100
X-Gm-Features: AQROBzCmlobFC01Q7lv7Toh7g6hjFSHJpMM9Ccx-2HUcYBNacN7AJnZP98WiGoI
Message-ID: <CAD4GDZxGo6p9A07rKAW4MZNdFOYrMVzjkYNjwTqKfFcqKkzU1g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] ynl_gen: generate Rust files from yaml files
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279298-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,davemloft.net,google.com,redhat.com,linuxfoundation.org,android.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54C3B41A870
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 at 10:39, Alice Ryhl <aliceryhl@google.com> wrote:
>
> To generate netlink frames from Rust code easily, generate Rust
> libraries with methods for generating different netlink messages as
> appropriate.
>
> The new 'rust' type corresponds to a Rust version of the C target
> 'kernel'. There is no Rust version of the 'uapi' target since Rust code
> exports its uapi via C headers - choice of language is opaque to
> userspace.
>
> This logic is kept in the existing ynl_gen_c.py file to reuse CodeWriter
> and other shared pieces of logic in the existing python file. This has
> the disadvantage that the gen_c part of the name is now wrong, as it
> also generates Rust. One possible solution to this could be to rename
> the file.

Hi Alice,

I started a rough refactor of ynl_gen_c a while ago, so that I could
reuse CodeWriter and the gentypes in a code generator for strace
decoders. I just rebased the work to net-next/main here:

https://github.com/donaldh/linux/tree/ynl-gen-strace

If that looks workable for a ynl_gen_rst then I'd be happy to help
tidy it up into a patch series.

Thanks,
Donald

