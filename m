Return-Path: <netdev+bounces-289910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMBwJPaiDWqu0gUAu9opvQ
	(envelope-from <netdev+bounces-289910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:03:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED6758D342
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 14:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9984D32524DB
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356F639B48F;
	Wed, 20 May 2026 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="uLM3otEc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2ED3AE183
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277252; cv=pass; b=fXs4f9i9wJKwbqkabVUO7ukYaj6fIsb+z1TqTDZzvHja9AcFnKtr54rI3UXoXCgE7wXQMhPze7TZagsPSH56CvivIQQlskr7vC8CHiSl4UkuL8JnWlZTDqB86mCZLrmLSZE6wrq5xpbM5HdPfzKt4q56VS5RPvfqXDvd4oxCrw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277252; c=relaxed/simple;
	bh=HQXbaSs19KZiSAdvpODUHkN3T2isD4yhKcr5SxoGzn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bensspZdJNP1NLe7GJkeosh8jKQ2UMwEsrOrz3QghEzRXX1UHUKf6iIuRGifn4lIKclHzOol2QFy+4DErVo4MS96Bfrp3CMO6zdrHzS0h9OIhsRg3KmtdbkHUQ3w92MwQrZX1C0ys6aZVl8vkXV2uJD+bUmwh1S3ADuS/D+wlv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=uLM3otEc; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-835386ff122so4887860b3a.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 04:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779277250; cv=none;
        d=google.com; s=arc-20240605;
        b=GtSzmO3m+8WZTSjoBkUnHixGuBjmISwUEEl9ZlmKt0Tkt3TeIbs9cigjC58IJcYx5u
         lfkc/1TV5iqIci8zQml/haSUQShGBeOqiU2xK6tWcKnT+AZZLrMNM774H4T7Mq+w0ItL
         PPdBK1sjmwUAT5pWmSKQcpm+svaNnbbDMisWGTXMZX5gF13ObzyQnKyooR+KXWHjGMqA
         Xx8o9qjWvxJdAVbOnC/dtCAQdTazkPIQ3fs7JtcjU455L8Uh0D6H//zEA+k50JTYuMzU
         kefQDtcjGzVzbtEU3E8aJgqrmBLaVsTqTEzjU97DXmVc9d3uT6UAjO2V3n3oO5Yb4Bv4
         spog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HQXbaSs19KZiSAdvpODUHkN3T2isD4yhKcr5SxoGzn4=;
        fh=dlGWmTpRQuQQdGZmpxM9cmEr6M6kc+WUP80Mh0rHz6k=;
        b=hCjnp6HYV14mcJZNFE/S/b2NXnS7fJmQ5QvxwjOIvlaeCi0rqE1Foonau9lIveqlJL
         Q8NFmh5uwg/Cr+n5ec1mfNoHhnHnwo9i4cAMjHDSVjOw5bIhcqNkO0rbPx6hALY0ncvL
         EbNYH7IXvoSDXEtaWtUerQPhuh+cmGrbIq6bIAweru+y/jTJ8PO1moS7Hqlfu8ihPsrN
         IXmxiXoNWnAuiPf8vm9TCVWHDDgDias31VtGcF+uN5SD/UmHgr4o/RytgxjtcOtWksUV
         uczeVXPS4+0fOp627wAJcvxXNrn6ePa754sBRnJoNcHxkq2Qg1ofDQkdfCMEIPLSg2TW
         nq2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779277250; x=1779882050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQXbaSs19KZiSAdvpODUHkN3T2isD4yhKcr5SxoGzn4=;
        b=uLM3otEcZQ2V8V50vIycZkUQIKhzhfS+7p98Fr13x0a6pCPHhOeAQ/WfzHHtAmr58l
         a36hzKI5Vpx+CvLYBspbBVg1sGZt8D4FLTV/qRegfPzuJq2u5ECX+27FEWRnN+DLhKnU
         RE8NYFJUhzTBjkMSUxVbEE2BVwCPHCm6EZo5NrDITuulkn3aoz1Ruh7qnCSOCn9Z+wga
         XAmV/aaDSHbst9FEpUcRbNXRAYPuDgojjKkTkLk6j7Hb6id1I+Gtd4oSM5zDE3rrinC5
         BUd33rcCVu35PFOAXtuEXIOuc31IX1iqzM9YWxKiagaOGS1Pp5dK3b7eujh8ppvOxYlY
         QlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779277250; x=1779882050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HQXbaSs19KZiSAdvpODUHkN3T2isD4yhKcr5SxoGzn4=;
        b=KHE2m7/FcD7re9remP8viZSFagbaMAq8H4RgOBE5cJ9xfs/dlSTPYjnN311pYzAi/p
         tBcIrzjJXHpvS7K64XfqhMnD2d4qGBFxO6QKQHJWinuyrpgolN1AXSuLzQdk098Lz1d6
         bxR8Ex/dAuW9Gd0Uz4g3MNcwOE7vM7kZp4k2+a9ylxuornP5jIH4Q/u9vmriGkRpog0y
         GihYopi43XgxFSZpkaq20v2pZYunuQhlOue8Dj1mKYStZO/B3+WdV/Ga0RwBG+Z9lHBI
         vBuFDnCC21w5YwlPPtnC2mZLaaAkZUDfHuJdtPyMMr0eMd2SD5Oc0lpv9mJQY3MUYDhP
         vMbg==
X-Forwarded-Encrypted: i=1; AFNElJ/dzcw+7f509N+fWikYoiz9Ftp8V5a9dmBSecUykHwxylOCMrkZQX9k3dcteDwlOQvQcJkE8Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwXdt9ucnHXJ4V5DzkiytEN8toX7et9KauMy2PELIZkOKkXwHZ
	9p2PdeizSeu8l3+sjo1rXb2O2oLrKwpp93D5IqOhKEcXHtzUYyGXoU6aaAaitn2A6/mx3i2VSE9
	jD0meFp7kuobyJq8v+5RgnpzUdGsjyaVSaTRD8Fcj
X-Gm-Gg: Acq92OEmu+xPTgiZ7YmYGx3azABqvyybCocB21WkDC4wSp9Fdc5bBM2WkDlkzwQgsn7
	FAC+q4i28XCIYVHkOBtYqw8TLlnriw8WnVcV0J5TMmWumDEKyqWAdyVxdrFyiMc2QHJMm8Z5iL4
	tzvFO5u+wJQ4EBic3xfd8Oyaey+tlG/LBOG0YPCcHjiy3CvzeudysxBCApLryHUz3qAo/q4ESwf
	RsaxfUFo/Vn1WqnUeFdaRFdZdl6GZqibiL1WC5qCzwFmSEL9lsCXCK7gYDNI7H1yZfy46uFIXQY
	ZcZ7LLNpAV2qZHwTiN8mn2cprcZfGg==
X-Received: by 2002:a05:6a00:22cc:b0:82d:603f:f3a with SMTP id
 d2e1a72fcca58-83f33c32d2emr24646229b3a.24.1779277249757; Wed, 20 May 2026
 04:40:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com> <CAOPYjvb8d61sappVT6VxBd9rLsK0q3wHaiMsYp5cFXty0NOU5w@mail.gmail.com>
 <CAM0EoMkaFabdr11nfiabpEjO_0iB7uKAd9_nFWX=yj-O=8YF0Q@mail.gmail.com> <CAOPYjvai8o1ak_iCUPUbwi339TXgL6rdTq8L-mcAn=ZGQeYQGQ@mail.gmail.com>
In-Reply-To: <CAOPYjvai8o1ak_iCUPUbwi339TXgL6rdTq8L-mcAn=ZGQeYQGQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 20 May 2026 07:40:37 -0400
X-Gm-Features: AVHnY4LIBwHjw4gd5kXhlcA85qnrEZ5meuogdVkfVQ89SElDuGKo1iMS0ETxbic
Message-ID: <CAM0EoMnzKychtS1-b=PHhyTVDeUs5sUX_xfY-Nj_R1fBBPm3BA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: Han Guidong <2045gemini@gmail.com>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com, 
	keenanat2000@gmail.com, rollkingzzc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-289910-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 2ED6758D342
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 6:37=E2=80=AFAM Han Guidong <2045gemini@gmail.com> =
wrote:
>
> On Wed, May 20, 2026 at 5:12=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Tue, May 19, 2026 at 11:11=E2=80=AFAM Han Guidong <2045gemini@gmail.=
com> wrote:
> > >
> > > On Tue, May 19, 2026 at 11:42=E2=80=AFAM Rajat Gupta
> > > <rajat.gupta@oss.qualcomm.com> wrote:
> > > >
> > > > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> > > > once before the key loop using tcfp_off_max_hint, but the hint does
> > > > not account for the runtime header offset added by typed keys. This
> > > > can leave part of the write region un-COW'd.
> > > >
> > > > Fix by moving skb_ensure_writable() inside the per-key loop where
> > > > the actual write offset is known, and add overflow checking on the
> > > > offset arithmetic. For negative offsets (e.g. Ethernet header edits
> > > > at ingress), use skb_cow() to COW the headroom instead. Guard
> > > > offset_valid() against INT_MIN, where negation is undefined.
> > > >
> > > > Additionally, linearize skbs with shared frags upfront to prevent
> > > > silent data corruption when pedit operates on zero-copy pages
> > > > (e.g. from sendfile).
> > > >
> > > > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb i=
s writable")
> > >
> > > Fixes: 6c02568fd1ae ("net/sched: act_pedit: Parse L3 Header for L4 of=
fset")
> > > Cc: stable@vger.kernel.org
> > >
> > > I took a closer look at the code, and this patch is really addressing
> > > two issues.
> > >
> > > The negative-offset write into shared head/headroom appears to be fro=
m
> > > 8b796475fd78, while the shared-frag write, and thus possible
> > > page-cache corruption, appears to be the later regression from
> > > 6c02568fd1ae. So it may be worth adding an additional Fixes tag for
> > > 6c02568fd1ae,
> >
> > Pushing it a little - but sure we should also point to that commit.
> >
> > > and I think an explicit Cc: stable@vger.kernel.org would also make se=
nse here.
> >
> > Please study the rules.
>
> Hi Jamal,
>
> Apologies, I'm still a newbie learning the process. I checked the docs
> and saw commit dbbe7c962c3a ("docs: networking: drop special stable
> handling"), but I'm still a bit confused.
>
> Did the rule change to allow explicit "Cc: stable@vger.kernel.org"
> tags for netdev?
>
> If I completely missed the correct documentation, I would be very
> grateful if you could point me to it.
>

This is a security fix. AFAIK, It does not follow the stable rules.
It goes via the net tree (then propagated via net-next) before making
it to linux main. It gets picked up by the stable tree.
But: You are correct that Ccing stable is useful when the vulnerberity
hasnt been published. I apologize for being harsh - too many AI emails
claiming bugs on which i spend too much time and you bore the brunt of
it. So we should Cc them.

cheers,
jamal

> Thanks for your patience!

