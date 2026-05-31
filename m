Return-Path: <netdev+bounces-293457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HJDNlddHGpbNQkAu9opvQ
	(envelope-from <netdev+bounces-293457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:09:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40713617136
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A486300D68E
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9924E37E2FC;
	Sun, 31 May 2026 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="wFuwaf2Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DA135AC05
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780243795; cv=pass; b=OjN/Dh/VIx5V7PquwlT8XS4ZCGoBDyFVukAuCjJd2qV3hmYGMvtzjA/TajlMY9TO5fHBR0mmzfQW1ByYEv70g+H4ouU+FE00IvDGEZdJ8jEQH0iE9MzXsPs5+MsWhsKwzouqN8bQPLI0kiDHaW1x12RbDCDNON3hssa5sIFXppI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780243795; c=relaxed/simple;
	bh=6+epObum8fY6fyGCsmLAf4aiQbgIq0YQp2nylQcq1Cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6MLtv2LC4a/S7ysuQ1KBbcsre2tFGpbjWD8fJKZtDmetywTD15+UT0JhUSmrVqM7Sg2/D1i4F0N3YE1RdgbfRj2p36KQRNo7GlC1og5ovA4ndxoYbBRdV1aAPjoE93DkMwsbBx1+R6HXV/iNdN1jzmI+dTxo6NJnwTP6ApsR6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=wFuwaf2Y; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36c68964315so614131a91.2
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 09:09:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780243794; cv=none;
        d=google.com; s=arc-20240605;
        b=Wh2U9oEm67VxEPqqFRh4dG/ospF/4z988rzEt+uEBmHZ6YVy0EcZBq2NkbmyYeSJ67
         Wga6aOCub4cXXnfTP5G0+RevKuB72dpSRulZOBhFP0Kv/mTpmI7XWOEejtzHJ4Qr/KvH
         /aN89U6P1Y3xYY5STk4TsghTL0oCgXYuNlo7iVJrN221/BoZ3pLrKSlCsMLnTW0KnFGs
         RDJl6bN7DPgN4gCS7kqQgb/lN7ygfjk3MMEselym0LlF9Ph3HbGSmprCWO8FwozD9Xp5
         9mr7b62cWGPu8HbHs4OF7zOJuSQ3jt0vY4DWj6uWtvlxQxrpW/qessYJB3VUMUmQ+fNd
         Bjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6+epObum8fY6fyGCsmLAf4aiQbgIq0YQp2nylQcq1Cs=;
        fh=mBK7lmOPmIATH9qng9v5bPoYGuxoTHFMw6gE6yy3gc8=;
        b=MtbO+N3GJouKTZGD7N6lMkBm14J9m4gJpFMXUamDLha2bJxgBjndnE9wOLCyMPBiYh
         5A7/Oobrmpka9g426M4Mc9VmlUrfn+/TQl+8OS6JnJiCDovpmD4/BtpBMfDWUPcv2aoZ
         QurPb0hke51dDxtCIetuqB5epyQ4S41LGVJswIBPI51Lco4scshbXSLxiAZj30nKHqV3
         glQUsR8086n/ZOQVcDUXNP67BvM4c8s3GrlSY6IPKc7l661ClDPB+h5t+E4I97JUbcUw
         CBSo79QoFVRprjEnEHDpX42yZ2IZnC29tyXrnGKz5C/N7iifEn1H+wHcUJuc6nDoa0f/
         GsuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780243794; x=1780848594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+epObum8fY6fyGCsmLAf4aiQbgIq0YQp2nylQcq1Cs=;
        b=wFuwaf2Y9i41MV4R3frfS0VjqdoymcJPRJYPvp/oBAte1wdmLJe8KK/Z+YxdcXOBio
         roxuXQRU9d4n6HtqYemJrYgPv0dywkm/9SPArD45hNq8qzmgUYIRhmR/QeoCzQYRfP6x
         BAAmGBNKiO6g8Q7JUPyhTsLilXFF1F5Qa6WUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780243794; x=1780848594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+epObum8fY6fyGCsmLAf4aiQbgIq0YQp2nylQcq1Cs=;
        b=X5xCKzQk9nhh5J+GrFAhFlvmNk7Ry6a57dn49cpNrLSEyF7yY4aIul8np/phEIPNPl
         TQTCXxD+JXjF0Jp/uizALOVDmaMLbPQDloSJG+C5zmZE7MktY+Ip2xURFEjAg0K1r70R
         1C4Uu6Z6tNGtiSZyJ6zBrbaXI0kWiPIZw2/XpbnQTso91xyuJzduO36eMUxZb0SOE77R
         ic8EVjoZdOEiYHgVrM8SROJHzP+k3snAfgbxHl6XtOzshT6/yrh8Squxgy9dCUEMz5aa
         2gVAQ87iaH1HLq8U6mvyyvHjdX0umN3x7st0xI6jLxEhKvj1MxKBCId8yVACvhTggw69
         6qNA==
X-Forwarded-Encrypted: i=1; AFNElJ+bqG6POHb+rqope70EzGHcgGX5LYVNR3LpBeIQI5bdCn/n737TRvucBtO35szpZwBGcH4D6vA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+JwDl0VN+brmvHkPk6UezBgNZT+cHn9Mty1Us64laEZGX9Ykb
	NOUVCUlRVrLg2VAYEudsgh4d/ZTs2ugvXH8WwTHAlRB3vGSvWZIBMCGwp2HN7O6R1gCBKyMATSC
	HNx9LTB4CDAUE/YKO1to/T/pkqtslhAzx8BOHBsol
X-Gm-Gg: Acq92OH8Cij3W1WA7eWz2vZXkEmQnBUot+bTGBtnvFB6VauBf/H6LyTdlRM0VUmwVUD
	pMLvaff5ssp3k/dTsJrohwfy7ZJ6YKBFTWzxQs8C9OTkviTw7+uyaeJNHlzLRBPNtXrSpz6sksF
	DvkGMaerkXPEK1r+ONIW8mwlA/lAS+LXT6oxAOVNRjLJ9bMEWdgK9QW9DSpNqrZXeMt6Fe+asfI
	JgXmRppxNqDe7Y97MsIcCYoRfckmwQQPQ7F6Ng/CQVsmcHl+nzPt/+RZ4PbXsEddM4PEx8jjkG4
	a5E858ZENu73WRl3ywMYn60kpkcpYQ==
X-Received: by 2002:a17:90b:5704:b0:36a:fcf5:64d2 with SMTP id
 98e67ed59e1d1-36c501dd3eamr7406642a91.16.1780243793714; Sun, 31 May 2026
 09:09:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526220847.28365-1-kylebot@openai.com> <20260528181319.79aeb1b2@kernel.org>
 <CAM0EoMmH+5q1JXH0c0GRJHLF3sN-BjpO+4X+ESjARz_rmZZ28Q@mail.gmail.com> <CAC7i469+v1bcoxD=82=VJffV-yXiL7gPtfKPdNatRSpGQincVQ@mail.gmail.com>
In-Reply-To: <CAC7i469+v1bcoxD=82=VJffV-yXiL7gPtfKPdNatRSpGQincVQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 31 May 2026 12:09:42 -0400
X-Gm-Features: AVHnY4IP-p-0k76Sylv4ClN7hR3p87ZsK6xWVDSQU6h2doU5KpXfUPLRgZxfmrw
Message-ID: <CAM0EoMmuoLQA5QFh6rHSTX6ev3y7N+YgUhfc+TTTvm_hDZyJAg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_api: use mutex in tcf_idr_check_alloc
To: Kyle Zeng <kylebot@openai.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-293457-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openai.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:email,mojatatu.com:dkim]
X-Rspamd-Queue-Id: 40713617136
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 7:15=E2=80=AFPM Kyle Zeng <kylebot@openai.com> wrot=
e:
>
> I ran the PoC against Jamal's patch (with inserted mdelay calls)
> multiple times. And I confirm the issue does not reproduce with the
> new patch.
>

Can you test v2 and put your tested-by if it passes.
Sorry, there were issues caught by syzbot.

cheers,
jamal
> Best,
> Kyle
>
> On Fri, May 29, 2026 at 7:13=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Thu, May 28, 2026 at 9:13=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Tue, 26 May 2026 15:08:47 -0700 Kyle Zeng wrote:
> > > > Currently, the NEWTFILTER path uses RCU to guard action idr accesse=
s while
> > > > the DELTFILTER path uses mutex to guard action accesses. This
> > > > inconsistency leads to a race condition scenario, which can lead to
> > > > erroneous operations on refcount, eventually leading to use-after-f=
ree
> > > > situation.
> > > > In this patch, we revert the introduction of RCU back to mutex in t=
he
> > > > NEWFILTER path, which is consistent with the DELFILTER path, avoidi=
ng
> > > > the race condition.
> > >
> > > The commit message is quite inadequate here. Looks like a
> > > run-of-the-mill UAF so you should explain the flow / race that leads
> > > to it properly.
> > >
> > > Doing some extra digging with Jamal off-list we can't find the reason
> > > why normal RCU protection wouldn't work here so maybe hold off repost=
ing
> > > until you hear from Jamal.
> >
> > Kyle, can you try the attached patch?
> >
> > cheers,
> > jamal

