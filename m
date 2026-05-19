Return-Path: <netdev+bounces-289490-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHjeJn19DGoSiQUAu9opvQ
	(envelope-from <netdev+bounces-289490-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:10:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCB558126B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FAED3029CC6
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACCF3AFCF5;
	Tue, 19 May 2026 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bb6PSVhf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260B03AFCEE
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202990; cv=pass; b=HOxoVXaw7GqUpGkfAinEkkjLD/h/EM/Ldl2Gvs0t4fazDuUqIHBEvyiPIY6hy8nYi5ZJOE8SwrAM+GjgQQYzU1Dy3W1L7aSLCBue3ikQyWLHwGQydU+vMoTuceWZhBnaOw6k4gbbD7pIAkP6GFimeR36LJ07jR+ay4MNhCNvbec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202990; c=relaxed/simple;
	bh=Tjl2ls9Z+VA+nuOQG+hetVaXMpDolRpiDCdTqZs2jlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFSzeAxPD4SbDxBrRa+XTMyqrlb8D/Ym/lz0mtytEPRZJ2s+25/Dh3WOFzOh5ponzqxAZahRoDziscfqj2IEq9k7Pq275Ldsh7Y0u876Eieuxn0RzUeb7LHL4vpRuEhyhY9J75DhcxNwPVmyoCODhkl+pBU5rcMWr48S41figQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bb6PSVhf; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65dbe04fc1bso3861410d50.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 08:03:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779202988; cv=none;
        d=google.com; s=arc-20240605;
        b=M32Ar+6EwTJos2gs1t4Vlt0Nht+yzO5EaaQlEa1mfFJ/MCueXDXHMDGn96bjHzRLRs
         UANOwX9WrL6clmBVnShRQXJjp8AaEB2WU22VKqkajgjo4FHDK1rP9W9AUXs04oOJkvDS
         PLyRIs95If3cRnlV9e6Q+sC2lmqji+h+r/2TnGyBL/YPfENrc6nkdsoTabq95mFd+URQ
         aythfmIOXgZh770FjU+8w0SMk/J7RIl9EwaarxB7OrMPQT91BL2d4gSIZN6LQGiWo1QD
         dvg/Pd5ygLegbFW0hzKMtqPm2rln6BXy27GZFAx9hxP7YIdXdCWmuFwuEqwWuOl4q4qJ
         x5tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4PJXirnt4DLgnmMVZo8Ztt0bfavWMywGZFzx3zm2FgI=;
        fh=azsy/VxzKjR4WKbFXlVMoguv0/M49KKITh6NE6j9PH8=;
        b=gxKBzOaOWMTnIADIu/vQFG0cEa5o4+YY2/5l71wZS77APqcxsozLqZTtzq0wmqwafP
         0CelKgpLNbvfE5SaBxoIf2aexu+VF+eWEqTTIjjJizExL/3W1iHFZ8M8qclajFnZFdTK
         +I9PdxZhnXjtVH/j7eFh4E+hDx8wlJnOqYZuMaRe/csUuDdoJbO9D0Tk7cxwsbNR9kC1
         pDZANOtgorXLp9aRlcFSJGgktCvRSYQudGCfUtxw4VgjBuo+1rp8EU3U+YFgef20M3IJ
         O2E2qmlin6YSWu5w/OELt1XAEt+qbdDBet3nHHq1az7HZCG8k1yrX8WVCieAADe94lEC
         BwaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779202988; x=1779807788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PJXirnt4DLgnmMVZo8Ztt0bfavWMywGZFzx3zm2FgI=;
        b=bb6PSVhfmCB4o+A5gYbnX7GQ7s4Wa7BysukjjN+FbXIh4YtjBEwzEc9DNM3n5XoBfP
         tFw3Rk3aVVXfi/EJPj2xImlMa8SgBwy3cWlBW2gORRByslAi35Ymz8AyZKSr2glV1uxW
         WgOICLwsoRP+TaroWm5i0zxv78R7yeHvIEdm3rJ3fG8c7OeOwqqdVI3S0K5AZrSFRZ3k
         +eWof8Z8yYMb212591vwqDpuASLdG+EXvHKekJrXz/I+HTzWNuqCPz4Dib9bbcGNz1oq
         l4ACjD2hGLvXbMg1DcfjnwT/+LVS1q7SNLDeHM+H6tREPCM6edKkzuG92YFd7vIU8bIU
         Bxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779202988; x=1779807788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4PJXirnt4DLgnmMVZo8Ztt0bfavWMywGZFzx3zm2FgI=;
        b=cQzxjSwvFg0TQCm4L2aKalBd5yTi+ONTh13fVXsaM30XymvwORUlzUdyFFGeAnVu3W
         4sRQn5z7GdeXadazgjRndwqFr6iQKJoi7e9MerLPDRyJ0Z4i2YtoeKGXGNqJufvx3aCd
         xqgpbwxP29JJehTfiOMZoqe/N1TTLv8KKXxojiilGTPAyZGcuxo5nlGvrK+uc329qxDJ
         9NeIxGqH6DYqwUiZeL/fm0eAi3EViKYFbqmNMxhxHlYb7LWBdZeedUwAIk8hthLL8GA6
         HislLUzOfV1G9nJxY/ll/3HV6WlkUoQB7c9hzNFN8iu5EUO/ELt2hanhQYGDx3mZnlGi
         Yu/w==
X-Forwarded-Encrypted: i=1; AFNElJ+xtX11lMDlP5RnjmpDHEbbV4iiMulQ4h4IzwyF9Fh8oZFbLAa07Rbr2jhkBdVe4PvFPMh0/hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvD2Q3TdtS9A/8JAPAnw/OvCH4srdQLOsOrSXo7PIkOyoUVKtn
	MQcuKzRP9f/wpcKGfTxG2FCcyeWsWkb6aONcC20LhsyJA2s7dAQFtp1v1MqJ+0xRHClO/CqArHg
	Z2flYs9DsEf8GJm9v7KNwY8XiLA/JkRI=
X-Gm-Gg: Acq92OGR4arn3MC7RAYiMzmU9zD2b52XPIHrMTKtgwaS3G6hlJwf11sC0HmKDVMlz2z
	/TC7bng27hffXcM/RjHoKrHJHxIGOyuRjUiZd/U/CgIhNzJV6kyo3ltborI0LXoUTYOXhEooj0H
	kOJDVWSw1xkSOm/wsNlC+hkwpDhQrw8XYKEVBPsz67EdVvwzyC+CdGqht+IWxwKQcDrki3HiD28
	yzzqWGS9Iq+VmOBAyDRZfiTSGbt0Ly5rP1SF7OxNItM+aXZlP/8jSfa7NSu/EGXOw03mbcF4R2d
	8Z0u/cKh0stqBEQnsvgIQ4uvHlAUW8y9Soi4w1KealUTgrk=
X-Received: by 2002:a53:d015:0:b0:65c:391:4553 with SMTP id
 956f58d0204a3-65e2264f62amr18227183d50.2.1779202986459; Tue, 19 May 2026
 08:03:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517155645.3882533-1-michael.bommarito@gmail.com>
 <agx0ZRfgc7WhuJtI@krikkit> <a91b5359-68e7-49a6-8701-fa37f3e5ae21@openvpn.net>
In-Reply-To: <a91b5359-68e7-49a6-8701-fa37f3e5ae21@openvpn.net>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 19 May 2026 11:02:54 -0400
X-Gm-Features: AVHnY4I1d4v7Le9ILNrWVZFUhe7_a7WC9rZwqq2c_oiDf6xmUfHIxdW4_9PTaJM
Message-ID: <CAJJ9bXzL-N0ThjzAdV0e6X+TLOE1Q+BWBdSzhoCbSnVYd8Ehhw@mail.gmail.com>
Subject: Re: [PATCH net] net: ovpn: refuse TCP socket layering with an active ULP
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289490-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,openvpn.net:email]
X-Rspamd-Queue-Id: 9DCB558126B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 10:37=E2=80=AFAM Antonio Quartulli <antonio@openvpn=
.net> wrote:
> > This is a whole commit message, not a code comment.
>
> I am also not sure what would happen if ovpn goes away first and then
> kTLS is left with the ovpn CBs saved in its captured sk_proto.
>
> Anyway, if we can prevent this from happening at all, as per Sabrina's
> comment above, we would make our life much simpler.

Yeah, I had to iterate on this 2 or 3 times before catching these
loose ends.  Here are some cscope/clang+Claude notes that might help:

  1. ULP before ovpn needed the attach-side inet_csk_has_ulp() refusal.
  2. ovpn before ULP made simple detach restoration unsafe because it
overwrote the TLS sk_prot and skipped tls_sk_proto_close().
  3. The second design, leaving ULP callbacks intact on detach,
exposed the close-chain issue: TLS had captured ovpn_tcp_close as its
lower close, but ovpn detach had already cleared sk_user_data.
  4. That explains the =E2=80=9Cextra junk=E2=80=9D: the sent patch=E2=80=
=99s ovpn_tcp_close()
fallback to base TCP close was the S1 fix for that close-chain case.

I have no horse in the race when it comes to keeping my patch or
throwing it away in favor of a better design.

Most useful thing I can provide is probably the setup to reproduce the
issue.  Let me know and I'll send off chain.

Thanks,Mike

