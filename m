Return-Path: <netdev+bounces-292648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOAIJlEaGGoBdQgAu9opvQ
	(envelope-from <netdev+bounces-292648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:34:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC90C5F0A41
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BD5A31475B5
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D199823909F;
	Thu, 28 May 2026 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="fw+Vyidi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606E234A78F
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964022; cv=pass; b=pXq7qyq0BF3IEZqc+X58yfKINQTRT6ayI6io4R/3iYZJBkAGJrtBpXpQsuQdIQG5KT1J0eaCSl1lNkm+iJQyinlPC4BcLF9hOUSeMnfVCevrgpi428iDa1svR69aX9YYSWaCKgWhvHv/zToKOiquOnueWotXDXLdojXa/OupZR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964022; c=relaxed/simple;
	bh=/J0kgNGVTk+3Eun5cpw3VNhPvcYjWsshz5LrI15e4Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsLJttCXlYHcFAAUcYLKujMHiyJjzmVxaZDzd5f6l2R32ZMQZitORWEeB2LX9EEzQaa14zPFkfYBQ/UAvPDJFVHbDt5lSNlYTRSPoWXb1OZ2myCvCwbhntAdAPx3Em3wLajBuh0chhUmaJ/wwoNx5V0mWhNlkWfT/AGZrVynJ2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=fw+Vyidi; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c80227c9572so5723404a12.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 03:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779964021; cv=none;
        d=google.com; s=arc-20240605;
        b=c0CcambttcDhEfXlvJCQD1zqwbatokSy8ZlOHCKIs2Iq04zUOezw81gVZduuD1JiMK
         0B8MoqgrLEycGK05s8gHEOtM8/E2EJipqm3ERtmRZ/5Wc2CKSiZHc29KjxoJW6e91ixk
         84BsBc9pJ+uOqjQZIG0vgPpdfx/vokLC/SkVcKsIAJxs9IZKwCgy4iD0K9nqI3dWnZM+
         x3tUPDnRCE0HIy6VP1eTfCrl/eSCkCUXSR5h3ICNd2HNvPgSe/DxY4ZEyJlQ5ayTtSfs
         /0pNT3bXnkdwrryHjNa5DCjwOBaeoJ58wOV9ZGUqmnwCZhl5PUsUQ40njMvNA8Y4lfZi
         ugRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pxZrOK9bsfQNWODmOiH4190mOKEGakYbYbkyypkEB+c=;
        fh=CZlqreM5+7+5mMHP6qPd1TfrehY9udzjmsxD3tzPdVA=;
        b=bYE+OQcBYa1InWN5uwOrlJPNlN/Z3vs13WiBf8w8viVm1m8liVYhrwhhuNMAP/gilU
         JEohMR2b6KRL1yrj3HF14KGTCqAsz/MpPrEjXSzDMSHGyLZo4LQ5zVQK2a6Q3pgY3WFR
         T0+nTWAXxyaOp1iBPXQCASacMp7O5ynNPBpd9gO/jBy+Wbbbf/MZbY7PK8xzrGGCt1at
         n+U6oTozd8jPOfLTmouMXxkXJjtLvVCAbUo0oR3Fxnht6TGmrMNuQMmvBf2TCv1cbBwz
         8DB4dHQKtbE7VNPvE4XW8bzTtW/fegMgFBCGvVZP6Yijewihz/EyMKhbuedhtNIWD7rG
         q3Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779964021; x=1780568821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxZrOK9bsfQNWODmOiH4190mOKEGakYbYbkyypkEB+c=;
        b=fw+Vyidi26842AkqsoGcbP6e24Fu/VTllLW9yb+NguTv5KyvjUdHnVrzeutQRaS0cy
         ldQ9kF1AJgMcHRX6TpCNbaxrBgt/ElByGaAOooTscDkbN9trqeO1iiNnU0/TPhpB8H/X
         dLEcdBvvO4VlS6jFepAbQZA8hfu8LA5xxD0KQdLu9FQybIRoCOD+Xx14cmPFlOME6+kQ
         Vzgw9uJcbC6rPPJzxMULyg+ZugwT+jQniGs7AjYBEbInsv5PK3Byipvw5XhWQXRhnrcv
         eVaaMpSJjS+GOXrVTxyomSKI/YkIHi0pyrUSJj05U7ivnVbWqV/PlNWcPNCtfYBqRBsI
         RmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779964021; x=1780568821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pxZrOK9bsfQNWODmOiH4190mOKEGakYbYbkyypkEB+c=;
        b=kmd4qtltAaYS1zMhLlDlSy9yUpWJqN1klE1KSy2VBpIZiZY31zzjFWWZ1E2R7n9mE0
         KGuz85uy4KzutNM4whHSQh5hrnASO0h5nL0I0s0FnsLJZ12MR+SvW3N7e9JQ1GKXGomn
         aX72oR6RHuBCxJqX4j7YYPwAfvzunklQpfrbuGioLDxLrWkTAdLl5fUCpEkzVX/LkeGU
         RJIfrFcqjBNi85xAwdwt0pWaqQpUZEKYNtukIQDdrRbleCaepn3OBJ7B2fkPA7OryKjh
         VfzFiFMGP6fwlk+yJkkBG35xU5Tq7JoA21ibVkoHabexy2oXw3YGfsEpcj7J7KavCgmF
         Vn8g==
X-Gm-Message-State: AOJu0YwyrY2xYmaIhkvkjW82Vr/yl3K61nzBrMxZq2w7lc6TJ76nODVK
	m8IkzFIZGYUektP4FOd6Gx2LBa2/IqWTvznXcBGO5ARJMZ8OpJkjDzOzzckNRIfcFNRfbIaXICe
	vFDt/plNFAjprh1BtCf/tr/sBh/KRaxax9rDo1svf
X-Gm-Gg: Acq92OHHEZ47SFw+7TKiagB6yjJnXxJKpMxu147R+i+GisJ5nD5Xdj2BNkG2xG44azr
	btHHSWoNKsW6hbvVC2GrsccPWR3wT6CeRf+221CZytIYJDkG0meMGk6Imul/hJ7RGYw0HFMBqNG
	eeKh50j9djHwTwl5L3npHgmb5cNjQCDqLqAS84SaTNc8qrGJdez5frB5Vz37nY79fNOWHI52Ds0
	w/gxFXP1xZoi4NOR+XRI29FEjkW3/pfRjW1HHCZGNAd4x+/Y9uN3N7fDhpCsnenA61NjKzhnT/D
	wEDMVF2rjCZ1vzGxcK6NURf1PmkUi+BVBfDH
X-Received: by 2002:a05:6a21:a343:b0:3aa:f9cb:d43e with SMTP id
 adf61e73a8af0-3b328cbc5bbmr27849870637.18.1779964020484; Thu, 28 May 2026
 03:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527181731.1166373-1-jhs@mojatatu.com> <87ldd33l7r.fsf@toke.dk>
In-Reply-To: <87ldd33l7r.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 28 May 2026 06:26:49 -0400
X-Gm-Features: AVHnY4IpvCyiNErOkm1HPil-lGJy_2xDq2JyXPur1wsfVa_nK8qQcf5XPJ5CvKw
Message-ID: <CAM0EoMndYr5MBg42AOV+592H1QQwxYW3Dw1Q40YtwYx9MfcELw@mail.gmail.com>
Subject: Re: [PATCH net v3 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	victor@mojatatu.com, david.laight.linux@gmail.com, yimingqian591@gmail.com, 
	keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com, 
	dcaratti@redhat.com, security@kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292648-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,mail.gmail.com:mid,qualcomm.com:email,mojatatu-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EC90C5F0A41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 6:03=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Jamal Hadi Salim <jhs@mojatatu.com> writes:
>
> > From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
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
>
> So you did tell us not to nitpick, but...
>

Actually, an opportunity to nitpick has opened up;-> I have to resend.
In my rush to send the patch out i accidentally deleted the "Fixes"
while adding names and removing obsolete commit log. Probably missed
something else.

cheers,
jamal

> > 2) Add more optimal boundary checks (Toke & David L.)
>
> [..]
>
> > -     if  (offset < 0 && -offset > skb_headroom(skb))
> > +     if (offset < 0 && offset < -(int)skb_headroom(skb))
>
> Seems that bit of the changelog isn't actually accurate.
>
> However, I don't think this matters, this version is not actually buggy;
> so let's just get this merged, and we can code-golf the offset check on
> top :)
>
> I did re-run the tests on this version, and they look fine, so
> re-affirming my tags.
>
> -Toke
>

