Return-Path: <netdev+bounces-293354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JK/AEcOG2q/+ggAu9opvQ
	(envelope-from <netdev+bounces-293354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 18:20:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EAF60E16C
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 18:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 474AA301FA5F
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 16:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919AE34575D;
	Sat, 30 May 2026 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="sMh7xpjV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64485329C6D
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 16:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780157753; cv=pass; b=R4jTu6SFpc+C2h2cuSDyzDCtpM3BVReskVlQCfmGGzTXYEOCN4iTsi0kC6PjaZn0/p3kDgQsnvjGXlBC0nju7jlKLU6usuexMi9RJisi7fHEJzZci22pRks/qR1bdzbi2L2IeLaKdIHzrDyOh4wTcfbEJeS0MSVawE0v9oNE+yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780157753; c=relaxed/simple;
	bh=hN6BoXr9+AIc7fHq0SkZzHYGZKYDgLsQXDW3Cz+y5VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kwe1IqbObPQLprM0ugxIRdbPvoahHWufwJ11xbJlS5qlRGJmMTzUif6gB++sYaCilIrXTE6Mk0YmrLnmHtoJmHZsQif1obGfJL58D3elyLh6TeMAQHHRCsFYWOq261CrjE4jiJbCIN0qd3pLBK21PQ5Ghxua7Za/KmxmFMhZ7Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=sMh7xpjV; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-842307473b5so342452b3a.2
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 09:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780157749; cv=none;
        d=google.com; s=arc-20240605;
        b=Ye48EmDdZSSmrhAgbzpkU9gqgTvbYI/JUxXafm2D13Ji34HOYsezdmP7uRS4pxDI0v
         wq+jdrKdLoFeOVLIj6+ZhdP8AII1ORKZc15EbAzrIURXSX1KfqNrJTAo2tq/vgofbW9I
         qWLO5UYtnnHK8OhjjVRsIQ/i8VbNwFCae8e4eQgRvyjjqYkT3Ko+4OPkm1b98M0e/GOu
         dhvNE3R/VsT28yEB0vv/Pi9tuJAxxqmRIVtgOkrwn2PCl+ELB8zOlg3zJ/uwEahIRj4H
         C1dN5MtB2DGQc5M5ydsr0cbcm5o5oJnMmj3ET2ScwycjhfUzrdWHutd4ZSPrka0cWFRS
         +qBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=twXxdlmI8oYfkNFvjOhwFQw43r1vCRyIh2zSKzOodEg=;
        fh=CZlqreM5+7+5mMHP6qPd1TfrehY9udzjmsxD3tzPdVA=;
        b=IbJRzooJnCDJW4ekdPIV+9fncXHfvbkXut+f1FNkeytip/x4Xw2eV2nDyq/GTWCrLL
         f7sXga8sBNOZYoUnhci8IGQeotL9CQcdsRW8v8hXrgbXgL1tCjYMoBUVrxRMRGXg2SsY
         Ex0P4QRsphNjKhAAFG3TXdaChXhrMhrH8+/ZbmeRxgcHRQjrdaHhoQXdiC5Kf/EZMeRR
         KUYBaV8I5QLNmp7nlP70R627A5SFhkGahA1/QICdAUvWuTL15yuNMVloV80Ux2siOR3L
         zokk0jJj+ZBvnjVKtvj0NBai/HWtaiMeyWlTMgMST2AABH9n+9h7I0eGeSKIFaLzO1qm
         LyNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780157749; x=1780762549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twXxdlmI8oYfkNFvjOhwFQw43r1vCRyIh2zSKzOodEg=;
        b=sMh7xpjVRYSAtTC5PBpL7GqzMIYgDHRVbKktMaDzfJ70yv1eryRtKsR9EN1y57deTN
         wqsYsw0mHeGjLC5udEY3wlWqHtTJi0Gh1sViDlRwt/PtYvMsc3u3htBCvbab6u+Biyf+
         yV3SKRGeZqS2VbUhXOrAcQNgOGTBmKNIBWJR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780157749; x=1780762549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=twXxdlmI8oYfkNFvjOhwFQw43r1vCRyIh2zSKzOodEg=;
        b=S+mCNC+B72jHoEjZKhgc6eXi8nhxpnN9BydaGj2kopNhnTb84KCWNhMGj9NzYWGhJq
         qnCbbl4SO+kDsEh6wEHx7+e33ex6JEjvcpwRMBJ5f5k9Qpg95QgceUqT1JAQcKbmN/Wr
         Gp55vOL4d2UUwDRvJwKtFdz6NJcYWKZR8nHlxstCHWTKgN++L0erxAG0BL0XviqOZoJG
         adc1ZvSBthE5x6DrpgAmyYlKKIv5xv5hPl+sTOELDXQxQCkKj8BkaDsFEZ6LhGNZZ+Z+
         4ziHhPZ44HeuLIzrrbJyIqED437HHdxvnwMnUmyY9aZqM6yXpFCiWREy4XQ9IH8TPcsH
         eAEw==
X-Gm-Message-State: AOJu0Yxf83Hm1p1yByPnIjRtEp/QcHbQaBcUJ3spBvuncfh3OmrtfFcJ
	A56f6LUqZRcQ/LCDas57f3bBcbQtFVLSxHAefiSevV0yQHNkb05UDTbczZSzFe2sYDL5JK5eNnO
	ZS466mtJsmHkxqNF8RDjUpEO/QZkJfXK4sG86Jr/F
X-Gm-Gg: Acq92OEpz6NQxGdkco3Nb3+3Wx98xwCLHk9VgI5H/FKU1p/FGH2ns0PoUk86h8J0Mbk
	/4LKzLXr2BdBdS609smb24f21jaFAI5IYKGTXT56QE4SxU4/qQDp34RqF7z5cj7p+AQXpgg0Lg+
	YaqkES0EYXE8bpeQMQEJI0k7gqQBn/GJt2bjTrdESRWC9WNw6gdxgqh6xvHgleIAvJ42OThMYMe
	dZPYA0Cs1QHu7yK0z7sP8mqjYQzXUlkptAd28nDy6w/W1X1m81Dk1+FP7XTrRsOfO1vAEhs11W1
	A8/CrrycxoG1v8A=
X-Received: by 2002:a05:6a00:3924:b0:837:db4e:a35d with SMTP id
 d2e1a72fcca58-84225841222mr3647154b3a.23.1780157749352; Sat, 30 May 2026
 09:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530080643.1345521-1-jhs@mojatatu.com> <87bjdx2ads.fsf@toke.dk>
In-Reply-To: <87bjdx2ads.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 30 May 2026 12:15:38 -0400
X-Gm-Features: AVHnY4Js4ankQciESp8DObJ4cYwvKVcP8DsXqcMzzIKI8MG0yOy87xiV0vYbTRc
Message-ID: <CAM0EoMmAs6N3xemJEcsKpG8OJZcxyB=U3nRa3vGwo+kbk8azfQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] net/sched: fix pedit partial COW leading to
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
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293354-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,mojatatu.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: 53EAF60E16C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 11:19=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@redhat.com> wrote:
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
> >
> > Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is wr=
itable")
> > Reported-by: Yiming Qian <yimingqian591@gmail.com>
> > Reported-by: Keenan Dong <keenanat2000@gmail.com>
> > Reported-by: Han Guidong <2045gemini@gmail.com>
> > Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> > Reviewed-by: Han Guidong <2045gemini@gmail.com>
> > Tested-by: Han Guidong <2045gemini@gmail.com>
> > Reviewed-by: Davide Caratti <dcaratti@redhat.com>
> > Tested-by: Davide Caratti <dcaratti@redhat.com>
> > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> > ---
> > v3->v4
> > 1) Restore the Fixes tag which was accidentally deleted in v3
> > 2) Remove tcfp_off_max_hint as pointed by sashiko [1]
> > 3) Fix a boundary condition identified by sashiko [1]
> > 4) Add unaligned access support to safely access ptr support to compens=
ate for
> >    removal of skb_header_pointer() / skb_store_bits() which handled it =
fine
> >
> > [1]https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260527181731.1=
166373-1-jhs%40mojatatu.com
>
> Re-tested and LGTM. Let's hope this is the last one ;)
>

Fingers crossed ;-> Let's see what our new overlords say tomorrow morning.

cheers,
jamal

> -Toke
>

