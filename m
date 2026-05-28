Return-Path: <netdev+bounces-292789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMGhD6yBGGpPkggAu9opvQ
	(envelope-from <netdev+bounces-292789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:55:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 895815F5F6C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEEA83007964
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041A33BB13C;
	Thu, 28 May 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="YdJSDbVZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC7575809
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990807; cv=pass; b=sedu3W1j1d6AOfLKMWD4kdsluif6eG03g53PBaNeKh93EfqinRp18nxA1XUrNRO/HlVV/O9LsQmdYRSnV+HqUojVrgk3z9YZCtKqVLtJOipadSE5UkLZnWzbZhY3xndy6KgD/t+fF9Qeisi7KxizEBYFtTxYthhRmit7BqHGcno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990807; c=relaxed/simple;
	bh=Ojf9hS6tdEKAUY35kGZlNQdhFakKlp3N22FwdlEPo4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bA5J5CmQDcMwjx5avLTzFRh2CteiM40fS2vqY+Ife4wCpheFwNElxt8Y5NOecd2xz/TdVcUDagXMvJD2tY/hY8V5vQaZUZUiXUvSwIn5bUb494MXHJsvCGtFcMBf4S5S1J793P5U/IQ/G1DnvkwlbEEmqrl7LeKy39j94rdikfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=YdJSDbVZ; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-367cbac9c37so7808643a91.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 10:53:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779990806; cv=none;
        d=google.com; s=arc-20240605;
        b=NyFuHXHR/LXnu+ZIVqc3Gtv3rHKi6TWZwy68tN/LO4uJalzhmsOOJJBhau+sIVhd5C
         Sm0ny8Q20OFQ39mTsC7QPVPNOMvm2pYXJTWblN/RgJavaEZeOd4yHR3osA7P/auEXmRB
         diljmEFIYsUsyT1DCfx2VgMV+UqYVd/Dn/QCAtxlDLPRIb9qrx+mIfCaxQgzU3oG+vW6
         gOFOI4tgOT1N+xLOzMLaHSCGKQtmHR1+cBgXarD3fZSnPpH8uGawQUWzTqHMmy8QSESE
         QjDNcbt02fAQZYrhxPKuVrFLCDJDyuKYE3/oMeP9TwgOCzSmJ4hqglTT65OZDMgjQUVl
         JIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FTv35aHvFSD695eca3kEt96+k1nNAuiO2mYdREMdyHk=;
        fh=CZlqreM5+7+5mMHP6qPd1TfrehY9udzjmsxD3tzPdVA=;
        b=MKGUnuRswarTpJ9UHCPClJSIzQ0sDciVv3RXBHIO+PbblmIrWG0/e6uwwNznze0hT7
         DhrYyLOP5dgNbSNv1Ue0rmAiMW0PvHgj4TR965VYQjHuODIIb9iVqhHxcdNtQDLPz0DF
         8oHPD39Hgv5O2BYRuXYtVDQRhTQVO24n9Knn8LvaAyIwzB7VZBOYsuzr0du8SrLqQFPJ
         zwMhpEOWbV46colGJsCJnBJblZpJSKyJiyb/x42ybNbcQYkJn+MGi4L0+e/XFV5qQ4Fa
         VF6jDBrzjhq1sjfaIM25MsEA5GjUdroJxYOVyH1Lgx8XGh/BZ//32QU5e6QBnhKukiRF
         Ftgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779990806; x=1780595606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTv35aHvFSD695eca3kEt96+k1nNAuiO2mYdREMdyHk=;
        b=YdJSDbVZ4Pc1FMvGX6Ir4WVBnfxPID/lxAVzd7AlN0GaeYDbaciyfFIHDrdbbcQzQ8
         ImsqqkSoBt+2SAy6zHRutl8PgJcLBKhcd9JPDCb3rvPVMnE2xOtyHmlZcOsXeVLeo5XZ
         ImowlQdpDzKc5lI3xNwGed6xKVKeSIdokyC21kr8BswhlUOO9PpALzA9xhNHDJRQTBp5
         rZcooQeftilUXVmueXTZvfHgs4ZsRhi6fPi5gs/KpjC+/MSm7KRZLNRn6/CVDm1CzQIc
         Se+AijT9zFgXKM21ubQRZVWbXwuvu06n0HLTM9TzyRaJNqNHGKIRHdKzaNe+M/5NVL5+
         VR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990806; x=1780595606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FTv35aHvFSD695eca3kEt96+k1nNAuiO2mYdREMdyHk=;
        b=aGe4OOE8y8Fk0CurdzkJ7I1eSBaaKT/M/FKQm9eDTr5mPCx5aA/JlhvWIaQos1MbTs
         bnNXwneJ4ppdTJAcz/OD5Kk6kWd3E2jnL2lB7XEWPXfqikdRnjK2wLqaJRVw5aC3gBuw
         JvdiUd7+hvB392+TG286aVFmuaHGQhXL+lIfv1Y0WNXPOoCQl4p9ZsM2suPAvxJszsQA
         JcCLPS2d90EY3DLpBq0gJQeVFOR6OmsBecwEzY7bMqXgG6KgjAsC2WCXqCDzCETk/Wnq
         Y1+/2xhZUJUwBOJtm5lvBBiDwxBrhdorgcBXKz5HmwuJKhLWhC0HUyvC8Pb2ZMvmsYct
         TH9w==
X-Gm-Message-State: AOJu0Yxu1EoUIG8H3DiGxkLUbyeQyJQRTHqmKuGs9QZGXQb8Sh+udyFh
	xyE22FG3Wv1Etmfenr0FTnK2seji7qgTj6oNZ5COU8YtVnmGz0f/8pAQnwKcENh/Z94JdeBSqcK
	yWTEawPSaGWvrj0qi2AkQ5dYNsY7hKudfaV07hp1n
X-Gm-Gg: Acq92OHVRoFTLUub0J6aCOg3VSsHTfyA7U+0FL5KItDyPEO9hgi482nIE1l7XkdPMBT
	hJeBNr5hhaVq50E1ihsmWhhDRk0Z7bfuYhLScBpUAq6v3xu4QzrAsYpnqmUpm4vU1+xJPBuvIw/
	rnYWqPvP7CKTflMK0bKM9NxqpTURg7OFwJXknY8Z54JFXxdjfa1msV8ABQFZ1JvyLcJsAFHcs/x
	FkONGZvQ0qmh89rO56hEiNOtytQxEVtOx6uPyDJfZ3EGg5sc4vg9A3zuUQC9/lbFaNYVq2ZMG7M
	0cY3kX9i7V+cpr+ZG/yl8EieWeeDxQ==
X-Received: by 2002:a17:90b:1b07:b0:35e:27ec:de0 with SMTP id
 98e67ed59e1d1-36a67506b93mr27312342a91.13.1779990805905; Thu, 28 May 2026
 10:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527181731.1166373-1-jhs@mojatatu.com> <87ldd33l7r.fsf@toke.dk>
 <CAM0EoMndYr5MBg42AOV+592H1QQwxYW3Dw1Q40YtwYx9MfcELw@mail.gmail.com>
In-Reply-To: <CAM0EoMndYr5MBg42AOV+592H1QQwxYW3Dw1Q40YtwYx9MfcELw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 28 May 2026 13:53:14 -0400
X-Gm-Features: AVHnY4JQeHOuW5r8ZpCe3bb4E42-O-OiupEocinnStuyl2stDlvdkQ8jaIHOhzE
Message-ID: <CAM0EoMkkr7tXk+dHWDhvwKPPo4zrGCcVBokC=cPE_msshxOpSw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292789-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 895815F5F6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 6:26=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Thu, May 28, 2026 at 6:03=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
> >
> > Jamal Hadi Salim <jhs@mojatatu.com> writes:
> >
> > > From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > >
> > > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> > > once before the key loop using tcfp_off_max_hint, but the hint does
> > > not account for the runtime header offset added by typed keys. This
> > > can leave part of the write region un-COW'd.
> > >
> > > Fix by moving skb_ensure_writable() inside the per-key loop where
> > > the actual write offset is known, and add overflow checking on the
> > > offset arithmetic. For negative offsets (e.g. Ethernet header edits
> > > at ingress), use skb_cow() to COW the headroom instead. Guard
> > > offset_valid() against INT_MIN, where negation is undefined.
> >
> > So you did tell us not to nitpick, but...
> >
>
> Actually, an opportunity to nitpick has opened up;-> I have to resend.
> In my rush to send the patch out i accidentally deleted the "Fixes"
> while adding names and removing obsolete commit log. Probably missed
> something else.
>

Sigh. There's another issue that both sashikos pointed out in v2 but i
wasnt paying attention.
https://sashiko.dev/#/patchset/20260526155913.1060694-1-jhs%40mojatatu.com
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260526155913.1060694-=
1-jhs%40mojatatu.com

I believe this is because we removed
skb_header_pointer/skb_store_bits() (which ensures you get an error if
you try to write beyond skb->len)

Toke/David - Would this be ok? It passes the tests - but i am afraid
it will require another round of reviews/tests

static bool offset_valid(struct sk_buff *skb, int offset, int len)
{
        if (offset < -(int)skb_headroom(skb))
                return false;

        return offset + len <=3D (int)skb->len;
}

If this is agreable can people test? then i will send the patch

cheers,
jamal


> > > 2) Add more optimal boundary checks (Toke & David L.)
> >
> > [..]
> >
> > > -     if  (offset < 0 && -offset > skb_headroom(skb))
> > > +     if (offset < 0 && offset < -(int)skb_headroom(skb))
> >
> > Seems that bit of the changelog isn't actually accurate.
> >
> > However, I don't think this matters, this version is not actually buggy=
;
> > so let's just get this merged, and we can code-golf the offset check on
> > top :)
> >
> > I did re-run the tests on this version, and they look fine, so
> > re-affirming my tags.
> >
> > -Toke
> >

