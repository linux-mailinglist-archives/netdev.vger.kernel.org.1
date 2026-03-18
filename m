Return-Path: <netdev+bounces-268840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAcqNo/4uWkMQAIAu9opvQ
	(envelope-from <netdev+bounces-268840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:57:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B8D2B4BFB
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 228593007292
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32F121771C;
	Wed, 18 Mar 2026 00:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7u9Ifj/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EE715E8B
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 00:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773795466; cv=pass; b=nJ1bY80wJWj1y1k6Qo0YGBYGkeVBCMmULS55winuFaCP1lLtDcDe4qdOGA9xk63aC9vdOU2dYClQRl5HjCtIPBl50vVQw6pSCLcnhKw1R4U31Iqs1fQLI1C2eFcRhYnYnugWHLLoMzcxOugiphRYkSRc/AGRo0+V4SK0/ssT6Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773795466; c=relaxed/simple;
	bh=zgBpJG/2jqM+9Mm93fLpe4VYFDz667Cipkzkcf8MrJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TqJU755No5Q2CBoNQb+wYZmyxACgesTBVv56IhB6ouehIoHn7vBbaPFjGm/PyZ4dcf1yBpuQL/EvpU/ixwjMI14aJToHAJ+mxqlQcYqHf2khr1tGGID5bkL5hIH84U8e4j28ZHwgyvFdVlVTu1oz4BDX4tg5PGDEZL1u4+d5yoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7u9Ifj/; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b467dcf0bso289095f8f.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 17:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773795464; cv=none;
        d=google.com; s=arc-20240605;
        b=HpwkVkLrRUDQHfv3jzuuGvr0p0FRu108hFCS+CVhirRe44GS5aXlwffdfCnytLvIec
         klBOIXszBJnr7RsweqLWCZozjMNsM7OraFmMxOwDfYgQxnxgyuxG6etptL6mfEu/E686
         T4zvIV8Z2IVo6Bi/wM2F0HqmbDOFyb+pFSmkwFiB5bqzYYMEfdjW6p5WiPR5N9VVb9Bn
         U5MB1ID66WzkqnhqLK6wfpQSODgKCMgZ0vOwmvU+kx0gxMbd6EnoqJn2pvZpUj5l+6vr
         SSnVR+CLx0r36mHX3tvhgL6P3+1KZkKt6TF2Csx19sGip5sgcvR1jE464bY7yxEmj5t0
         Vj5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zgBpJG/2jqM+9Mm93fLpe4VYFDz667Cipkzkcf8MrJE=;
        fh=bycYS7JgmiUXKbC/jX2cfQusFQg+tlVV6/SHbUspdl0=;
        b=dCotSXSJWivWw8cgv6HcFR8KwzjGE+6pEFkYF2wvkvFs4onbTSW45MT6no6QnNPSdA
         f06VML83PaqiMuV7TgbeF8P4d9OiPdRd1vT/CWkWHlI8JxEjwYFpttJwl96MDRVJhPYv
         ody3kgLh09xF0a9xGz0UNXcOFXbqY50uP+2WZRRNZWKOyob7rVH1mAxfRZAAJ4otguRh
         PYimwXGal+Rt8Rnao/6xJ9j4Jna7ocmXxFLh/O6AvKruzjBfnoyxdEW0/rWvt4xUS3EH
         UPxYzOfjfr30NUY0POAjO00dsEHRqXZUBM2MwKMMr2aEhEjQp78O1z28+lNJToB+qkmg
         mkVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773795464; x=1774400264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgBpJG/2jqM+9Mm93fLpe4VYFDz667Cipkzkcf8MrJE=;
        b=k7u9Ifj/KiXDYt5AGm8rpGNVuaW2Clq1UmKdb/6Zf4x+CReKfLa/dUxOfcVtYvBLS6
         NwP945ya+T2OUBiQZaKWUCHW/xp3rEJlWgETwGFmtv+5TXj0zk04BbvUsBsVm57JtXSX
         TznuXv+8vlv/mGRPq7zDRboqwqyJw3OLXfCluiFXVHqYTBO3bZG/p0t7MOOyKe+GeZ7+
         AMeeWTWlxR4cI9LCSzQpyxXancUTxHMn0Syh7FqZIcMhXcU+kzzH/mc0pR1zXKhJjNmt
         t2/jy9m1kuwYejmfC31jPI/u06qxkvT1WcRmXHhSZpSpO3wL2ar51IENQK6vAwYwZa9v
         XA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773795464; x=1774400264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zgBpJG/2jqM+9Mm93fLpe4VYFDz667Cipkzkcf8MrJE=;
        b=mIzSgahAA0E6u8o0by9MEvQ4uyi6RgFbqm2TA8EXves4A+Ak2xq29kIagb43Ci3voY
         Rz/ZTv+nJB2Zpm7Er9Yjqz1YBI/WS6Bwc10R+pTB6pWUQ9As/yIkOn0/ximvzk5lFtJv
         xb+d/hdc9p7ens8V0HIyvTh6VzPh5Em83yLO79QHfDgqDpV3c+8PabUP4tIhV4L4T51E
         l6Ya2jtXT3fzG0XLHWspHedGrQbN/RnqWQ2DXWmA78kHn4/xTHPiSW5dy0A5hqK1EXwB
         nGKmKPZL8UyCk8VABxBLjwHVAL0HGi4AYjDyLVA61t3+ZGcVenLky7f3lVCWQs0pSnle
         +0ug==
X-Forwarded-Encrypted: i=1; AJvYcCUGulr5T5skO9gep1FSZMDZ9HPSbCYi/XQw7E9hC0pC8c1gQxM4eQUbym2R5apuy0cvOUTowIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/68SxELsdMJhrXMnKEmTGUaxyaeMLqI0/ngqaWVR6qtwjcaRm
	kOYbqArsEsDEzwC06bHFA7cD9r35pLnTmYfN0abgQo2oomGCnCbrcAeqesPumrk68pnr6wp81Kf
	zJzKTGeEkttNp4KMLsX3k1TrQqXvsYeE=
X-Gm-Gg: ATEYQzw2Pq8kcSftdroiw9Kwj9aJNyq3hwhSAIhwVaDWVOLG5lHmYBMHiycXZ8FBdX4
	YaLcejoTPhqwlU6If5FrqIsOKfFbB1EKqPkN/smriQg0PjwhmpDzse02i8GK5oo3PFwB9aRNhMh
	S/Fk1eVeeghcThunCteMUfT1WHOX42BGSaQYnxSrO3yABGDLAEDL7b3uPjtRZwqeJd8nqeV8Arw
	RONZGrX723hYsxq5Y5D99TH4kYsxnuI5z1v49xblU8U/tToAKjwuddABXF/rLwf95JAU0Pwoax+
	m1GTRfXwH2Jiq0aXElEwTkvrdHqi5w1wUBITPdk0+4Vr33i3hDIWeqFOwjh/zs/oeojPVwWfDxp
	5bke4s3fp+sjr6g8YhaXm/TCzRg==
X-Received: by 2002:a05:6000:144d:b0:439:adc3:f0e7 with SMTP id
 ffacd0b85a97d-43b4981a37emr10343567f8f.9.1773795463711; Tue, 17 Mar 2026
 17:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316140557.461288-1-maciej.fijalkowski@intel.com>
 <20260316171200.4b8a96a0@kernel.org> <CAADnVQJ=nryHHb5A3r77H6dzg=vzC97eHe8mCeBA=BMxa=+P5Q@mail.gmail.com>
 <20260317152045.58c719a7@kernel.org>
In-Reply-To: <20260317152045.58c719a7@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Mar 2026 17:57:32 -0700
X-Gm-Features: AaiRm535rY1ksCmYjCVo8Mr_kBCyfeLnf6hnp14oRGDNzNgMiG-yzjHw7PLCL6Q
Message-ID: <CAADnVQLZOUMGxNDwxhRzfx4finsF3aua31cggKpgTA6h0pjgAA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] xsk: use __xsk_rcv_zc_safe for ZC
 multi-buffer Rx processing
To: Jakub Kicinski <kuba@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, Stanislav Fomichev <stfomichev@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268840-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,intel.com,vger.kernel.org,gmail.com,redhat.com,kernel.org,iogearbox.net];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3B8D2B4BFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 3:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 17 Mar 2026 08:09:08 -0700 Alexei Starovoitov wrote:
> > On Mon, Mar 16, 2026 at 5:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Mon, 16 Mar 2026 15:05:57 +0100 Maciej Fijalkowski wrote:
> > > > Commit f620af11c27b ("xsk: avoid double checking against rx queue b=
eing
> > > > full") addressed a case in copy mode, when working with multi-buffe=
r
> > > > xdp_buff, where we were peeking onto XSK Rx queue twice, to find ou=
t if
> > > > there is a space to produce descriptors.
> > > >
> > > > Adjust ZC path to follow the same principle.
> > >
> > > Acked-by: Jakub Kicinski <kuba@kernel.org>
> >
> > Do you guys need it in net-next in this merge window ?
> >
> > We have nothing in bpf-next/net so far, so should be fine
> > to take this patch into net-next directly?
>
> Somehow __xsk_rcv_zc_safe() landed in bpf-next/master f620af11c27b8ec9
> So I think we have limited number of possible moves now :)

I wasn't paying attention. We can revert it in bpf-next and reapply
in net-next and probably route all future xsk patches to net/net-next ?
since it doesn't have much to do with bpf anymore.

