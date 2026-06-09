Return-Path: <netdev+bounces-296971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xAvHEGLNJ2oC2gIAu9opvQ
	(envelope-from <netdev+bounces-296971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:22:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F93065DB82
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 10:22:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=cBC9U49N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296971-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296971-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E85C3102A3C
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E2A3ED3A5;
	Tue,  9 Jun 2026 08:14:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74B3EDE64
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 08:14:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992846; cv=pass; b=uvlFgLeAftIWOEMV/oY/XAkn+b1yrb+fnb+0iz4hydUBcszee7m2ZYzpu2S8JSfETl/1WZnIkDVKepxjPtyGuWiKDd122gP1x8rwAlqXM+K8rzHAOGy6IjRjQwiOXhiFz+zeoPInZA+NR8WjZtk3aHyz4JInjei8/PZjGJGGi64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992846; c=relaxed/simple;
	bh=jpBMVbXcusrEMvBmUF/dRJ+gQ1j6wnRpj0ePwoXw71Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+TXwu78KysYI9Ep5PRILrv/IjKrI8217CKD1Ki17j0TJmYTzp3XQp7A4dZWj6yVPQAOVNVXlDbJkEfSWF7xFUyKp0NONQwtbqscdzuPsSUaQ7fLQt3EqP8EXfkAc52DGIEuRKGRZvZlj6o5U1MXKvDZOWMQ1O9YLX7kYSV49L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=cBC9U49N; arc=pass smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-36b7b7b7a80so3330346a91.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 01:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780992844; cv=none;
        d=google.com; s=arc-20240605;
        b=aAwrevCZpuabLqibM1/9soybtUkzK+vRJkGmw0WgGh1gOoHpcQCQi3dliqSO3c9n8S
         8jj/C1T3GxV0ZCdaCjEeJlYHn4pvIEhtIw8ErAE7oNE85Uj3zm+VTmEgM4cmkcDxwKh3
         PG0HTgPGdI9bmWN2ArDh+BGed4S23JvnAXFxuzuGn+cDFF1qsEyPPx/smSgAxn9v7lGX
         fA1GhUg4OB05D1PlgICYpSkeGXi+K9fFX8etGXwykkIT4UUh5g6Us713+GVaIupO5Qtm
         Si4uAQAevq3mIK8n8CrlUqwzWTM6kPVCsvz8fCdiFRlBt1e7GnBHXDMvwuCU19ATkKbm
         chtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v9VryaH60xfoLk76bMOCCDJWPkr3dAUhALxUukgVR/U=;
        fh=F5SIwZPCEJ6RPFO5FmSqekmMdPz8af1oJypOUxZ2YvE=;
        b=ElewEnK7icc0JUjqd/rcSf8VhxMg7GpT2WxzO4yHkYMZ6XHIBi+tcNXFx51n3XM7DD
         NIbRhmYSej1LZucUR0QhGHpc07XA2/9rmvrj61HV6NsNfKFdyyzAjzLVgaT29mZLCaVB
         lEhx1fR/xKyT8b3NPdd1wctIsCrIGFmdULeJ2dgLJsjh5Q06AfD+4Sgywy/xTE20sVou
         kAYpIkIXjJdvZAOkO3ahLWKtjUPHKbyJzdSv2YJ0OELn4ta5DjsnrtxJPnJ/cM8kMKgn
         SNg1BGq8hCSD4RLLsLm4+eDHkTBfLRItTKEAz/XTGJnjpHbnUWWQ0m3mTJB0ii26/2nF
         T9Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780992844; x=1781597644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9VryaH60xfoLk76bMOCCDJWPkr3dAUhALxUukgVR/U=;
        b=cBC9U49NbUgVH3huleaT0jTzSMdVyIizb+nXzqSjskUyqLDnhIHm25bAjTUgrZ/1nJ
         dgeeH13S5gboj7JD7sJpTubEi1BUGvEd8uJlSRbOV5e1LnA7eK79lnOnM9pc833yk5fr
         Rr1/kg0YoDPWyviFHBM5amClsVhng1nYt6DGgEzQ122CWT6gLgWZaIg9NEA36a/PKLxY
         r9fbzGy00ZqEOCat5v6zUibgi9Xkm0OTW423eNV7Fkxi0NPcuoGufBcfim2UOxCcVGKq
         II1jduH0zy3w9EpDfztXmZuiwtvOM6yun5JPsFOUzgMgYofKgDhywV0A/oslylXpn2/I
         kwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780992844; x=1781597644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v9VryaH60xfoLk76bMOCCDJWPkr3dAUhALxUukgVR/U=;
        b=iGGLKAVECE7phi27olih1bmQFeioUi/y1jJxHVJrDB1BGlSk7ZqF0IyXMQmJ4Tlicp
         H+cd64SG9ZI7msYnzc3PEZTP5I5gCL4RhlzmSl2TVtI/EAm1BdS7wxA7MbtQFHUOHAbp
         YzivBIOGehTftLITzeKfxHX34/AFBkuVh8oOEoM1xQW9E0hvJoEcLNcPj5RZ+SyIYKiT
         q3/aXHarOzz7L2YxF24Q98dsdBX2YUwTSP/dx+8YQlBaOw2gQZ4hKK40q7lM26DsL2VH
         /6S+HY+Po9B3jrUkgjRD68gX5n0V/je3TYW5FEfAyVSh31nMCtY4sBHAxUdLySAwIaJM
         eMsQ==
X-Gm-Message-State: AOJu0YxVRxLDNZHgvf19Vun4rBIRBr0Xn5qj+8mamaZmKxsOmd9eBeYb
	nwPlehLQUZS/zdRTxksVStfT/P+igRuVjSb5TsjqEszNykecYWUF4DzS+gxYOo5hTRLR6O1z7z4
	OJOzN79V+s9+j9m6cvoytisHQH4V2lfro1GacIx/T
X-Gm-Gg: Acq92OFF41NHoNXbM4hEGQaNMMKK3NFFQIFXtwGynS/1nPXnz/6yH7/+VSuZ2hKoFWL
	jL/NEakzSlQvXuKrvmkwc6o/QTt+dTNYPlQVi0XKqKE94q6j399SITLUziWfxKS9SyIo7EiMuE2
	IBTzwC9n0CRoYSzWD+iUZ5/dmBUekMbKL7Pf4cffwKBWus8epzMjOA4GwdWzpYdcxcIpiAfp84P
	nG0bBN+3C/Jc3dX3S+D/FGb8pnv5VJvdKyhZmdt2F7QjiFTfELJmGVfI9Mj+n7lMQljIr6DsISC
	cpYeLY56qH4j9JzPJA==
X-Received: by 2002:a17:90b:3903:b0:36b:4d63:4a93 with SMTP id
 98e67ed59e1d1-371328ae3c0mr16093603a91.13.1780992844361; Tue, 09 Jun 2026
 01:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609065116.2818837-1-xmei5@asu.edu> <20260609074606.GC663407@shredder>
In-Reply-To: <20260609074606.GC663407@shredder>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 9 Jun 2026 01:13:53 -0700
X-Gm-Features: AVVi8CddlugweTVHZnFbsUW4hGvFX4X5keZXlIefSk9fZFfXDwmQ5mvxObZY2E0
Message-ID: <CAPpSM+QUrK6mMSsngGpU0=ym2cMqffWKq6to8NUTUeCO=M5OrQ@mail.gmail.com>
Subject: Re: [PATCH net v4] bridge: cfm: reject invalid CCM interval at
 configuration time
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, bridge@lists.linux.dev, 
	razor@blackwall.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.linux.dev,blackwall.org,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-296971-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:bridge@lists.linux.dev,m:razor@blackwall.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F93065DB82

On Tue, Jun 9, 2026 at 12:46=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Mon, Jun 08, 2026 at 11:51:16PM -0700, Xiang Mei wrote:
> > ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
> > the configured exp_interval converted by interval_to_us(). When
> > exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
> > interval_to_us() returns 0, causing the worker to fire immediately in
> > a tight loop that allocates skbs until OOM.
> >
> > Fix this by validating exp_interval at configuration time:
> >
> >  - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to the valid range
> >    [BR_CFM_CCM_INTERVAL_3_3_MS, BR_CFM_CCM_INTERVAL_10_MIN] in the
> >    netlink policy so userspace cannot set an invalid value.
> >
> >  - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval has
> >    not yet been configured (defaults to 0 from kzalloc).
> >
> > Fixes: 2be665c3940d ("bridge: cfm: Netlink SET configuration Interface.=
")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> > ---
> > v4: remove the Suggested-by tag
>
> Should have kept my R-b tag...
Thanks, Ido, for the tip.

