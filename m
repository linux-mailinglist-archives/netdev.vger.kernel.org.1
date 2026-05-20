Return-Path: <netdev+bounces-290089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFvQASgTDmoW6AUAu9opvQ
	(envelope-from <netdev+bounces-290089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:01:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08682599082
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5346230451DD
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BEA32938D;
	Wed, 20 May 2026 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="rZg1P4FJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6DE3438BF
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307260; cv=pass; b=dfuJmZURpBDPoaK+XMkNZx68QDRPMnNlhp41bK4JUyoRXK7rIaofycDwEYaURImng4Om8bYv0hImUA4J3RhGluyBL2r1/V1WiwAx+IM/tH5rOdBNwYJFpUsDeWm0W7dy7sRLlwdGE9R3gckyx9h1vUhbc/Yus1L7C5HdfZVIhrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307260; c=relaxed/simple;
	bh=QgZPwpc53x2gDLOn/7k6j8lEeyE8Bm+sPm/7LN2H6tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFnLppg1nDpUlA6CiNwolT0c1lz5smJHEwe0htoNBaE1AAELfyTDpD3yIAYnVh0CFbWS0ckHHO+1jvYdv5SJfos6au/NoccXaHhBldtpEorKxVEU+q/6/Ezo2nLtf6AY/kuvgA4avNIxjgdYivqLjZJ+QIDCiSkNv3gqaKQtOzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=rZg1P4FJ; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c82471904fcso2346920a12.2
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 13:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779307258; cv=none;
        d=google.com; s=arc-20240605;
        b=WReVdflw3nJgor3Sek3UNUEa83TgkmYZXG12D15gxl8E5ejLJUg6P0UztxyLPPX/hI
         l5gY+YWFjPT2cBELVkNMBEtA1zfQVEA+XEM3HXgaATHVPeIrMjsmry/5u9b3uZCAgjul
         3hiFclF8wZCD+eanrgcjhKroggcBBoID2FrYF4oh+CuAWfxcxYPBFyjuKov3tquSS3fH
         hBe4PpJR8rCDx2bNp4KL6xS/i+5IxBRzyuJTus++leG0E3yuYjr1YXVGVYzBQ+aB847O
         VMXXTLvyleIjAKFfRoW2fdB0U2KopMVzrfFYvga3rbSE8qrTkPoLXrq81/JbSOGSaChW
         +dYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tc2MPVC08RCr6+ofbLSUug5Nk24uq4ZJZDkkbUz3sOM=;
        fh=9OV2Fj+jq0UvwwDq3/PSsLPxDD9s9tw3U/HVq1Z658k=;
        b=Y6+vdh3ORq+u3cPsVIZbvctn/WvZwBhNktMSPWVwTzmug1ci9IZdYbdms9486H0MXw
         x8sf0zGsAoLfv2xudDvaOdP3hhVYx35w7oLmp2uRzyLI1L07jAL50KtqmORmZKti6/qd
         05WJ+M6m6TfybOCOocNmb9N+L+CX9QKO0mArIGIASgBl8OEYH8220WSbFgj0Rl/+hZGq
         D82e+cC5VHNIC0OEhWtemxXcaymwxcPd4ikSZhSef4kGPupTLwgizAABcT1Fd4Flerw2
         MpwXGeqUnnuo/7pDb9g9jEVqTUyW1VACS8SFavC18nlnvmgk2ciiDHtd6aHrgzN5AgAr
         G4Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779307258; x=1779912058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tc2MPVC08RCr6+ofbLSUug5Nk24uq4ZJZDkkbUz3sOM=;
        b=rZg1P4FJKAabLNhGlk29EYekhYSr2/E8J6TkXDxhVgqsSJdiDbdJRtIGFAZft3ihnH
         IEF2Qz7sJoGvCg16iD0zJMmfZPHFtdohDBX4FFcLOWCFQZX5MntxOM5YVUH7/sZ228+L
         nwOuzaAs/DTtkz5OwnaT381TaVnDBnCsFSZ4s45T1A4psTBrj9qXk2XH1OURLwP0J3ij
         uHowdJLuwtembmy1W7uQwgI/kLaK6Kt6SVciVTB354uvhVE8udmW1gTfPYdf8SFEvJFH
         FW6TbiB5YdJbJ6vIotvxk4p3nDTPDXSteFoUGmp7XtXQwEf/zC396CUWmsqnTBBaVGdR
         FhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779307258; x=1779912058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tc2MPVC08RCr6+ofbLSUug5Nk24uq4ZJZDkkbUz3sOM=;
        b=UKVGjpvny5/gPmELt+spfjnrBmNvRZk+YYllKsGXbFE0WN+WPHJv3LragomM94t1zo
         8RPpMwbWu4nNUIGOdABJC9gQOcuh2hwl7f0woTDbFVpeGp+U9N/13R1zQ42cS50HZkS+
         wDqFmGdyYC8hhSd4uPh5VazemsI72NpfIPXrj4vyLim+j9KvluzGqP/JZllDw/zUZL2C
         hsDJE2f9KZB3e0ooPUSErS7aeeiVPWN/LFAjfDsU3kLiMqwTI5abscnjiLoti1RZFFZL
         y8CWjiC2mFTx478OfiH1+kfBwbC8j6Vebh5jQaTjM9PnoF3qEvyNxkn/mJyP0w2K+AfZ
         0qQQ==
X-Gm-Message-State: AOJu0YzanllRFvb3pp6dnDvf8/xDnMftIW9bJl08nN1hzhJ9Vo1fIUsJ
	BwiRecE+s4RiTdHrzaN8NUjgH/F1EHq9XgFOaO7LTTnCc5b3m4E20rnKjHyakQhXuSn9YK72w76
	tFhSzSQe44Yn9nqMUIxoLqACoDKWa0bbml6b3OZSI
X-Gm-Gg: Acq92OHCoMhIQhZtqsfFmq/rfYWRDjhO0qilwf+it168DS3fScnYtm7UTSHrVvFbWhR
	lGXv8jXa63AfaPg2YalcuKmGzGfTCW3MDYbKnCGEFqQ8DcKwWk2kiFDzxVocre9OGvA5nHr6YRc
	0M125ebkmWQHwuZgRhuxpHbSlZq77YQiN5K9tVd6I4oWkO1n+/OCS+g6tjoeyek0IJe2dq2GAqd
	/TAq+jvOnZzRFfX0B/OqYwllpbomaMmnStik6DFvusGo6pwmTbY36vkuOtVBs1fn4N45uNCJRjV
	GQnadmAf6MjRG0UPFeY=
X-Received: by 2002:a05:6a20:e212:b0:3a3:a5cd:5621 with SMTP id
 adf61e73a8af0-3b22ecf84f9mr28046959637.51.1779307258336; Wed, 20 May 2026
 13:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com> <CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
In-Reply-To: <CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 20 May 2026 16:00:44 -0400
X-Gm-Features: AVHnY4JdU88E66yN5fzHrusUXmGZwSxrbCF948vEraCWVpbQ7BtFVgZcyNrXofM
Message-ID: <CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	yimingqian591@gmail.com, keenanat2000@gmail.com, 2045gemini@gmail.com, 
	rollkingzzc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290089-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mojatatu.com:email,mail.gmail.com:mid,linux.dev:url,qualcomm.com:email]
X-Rspamd-Queue-Id: 08682599082
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 5:23=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Mon, May 18, 2026 at 11:42=E2=80=AFPM Rajat Gupta
> <rajat.gupta@oss.qualcomm.com> wrote:
> >
> > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> > once before the key loop using tcfp_off_max_hint, but the hint does
> > not account for the runtime header offset added by typed keys. This
> > can leave part of the write region un-COW'd.
> >
> > Fix by moving skb_ensure_writable() inside the per-key loop where
> > the actual write offset is known, and add overflow checking on the
> > offset arithmetic. For negative offsets (e.g. Ethernet header edits
> > at ingress), use skb_cow() to COW the headroom instead. Guard
> > offset_valid() against INT_MIN, where negation is undefined.
> >
> > Additionally, linearize skbs with shared frags upfront to prevent
> > silent data corruption when pedit operates on zero-copy pages
> > (e.g. from sendfile).
> >
>
> Sashiko makes the claim that:
> "
> ....
> .....
> If the payload part extending past offset 0 resides in a shared
> fragment for a cloned skb, wouldn't skb_store_bits() write the
> positive offset  portion directly into the shared page, causing a data
> corruption regression?
> "
>
> It missed the earlier code (before the quoted code is hit) which is
> very well documented!
> /*
>  * If the skb has shared frags the user is likely using zero-copy
>  * (e.g. sendfile).  Those page frags may point to page-cache pages;
>  * writing into them would silently corrupt the page cache.
>  * Linearize so pedit operates on a private copy.
>  * TL;DR: if you want zero-copy, don't use pedit.
>  */
>  if (skb_has_shared_frag(skb)) {
>         if (__skb_linearize(skb))
>              goto bad;
>  }
>
> TLDR:
> If the  skb  has shared frags, it is linearized upfront using
> __skb_linearize() which means any risk of modifying a shared fragment
> is non-existent.

It seems there's a second sashiko ive been made aware of - these
things are just multiplying ;->
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260519033950.2037-1-r=
ajat.gupta%40oss.qualcomm.com

Both points it makes are valid. Dont have time right now.
And infact looking at the second point sashiko 2 made I realize I was
only paying attention to externally shared fragments which the poc
used.
So probably the sashiko1 had a point as well. Anyways i dont have time
- will respond by am tommorow.

cheers,
jamal

