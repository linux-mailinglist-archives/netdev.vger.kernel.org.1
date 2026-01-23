Return-Path: <netdev+bounces-252911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNsZAk+2c2liyAAAu9opvQ
	(envelope-from <netdev+bounces-252911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:56:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA797941C
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8404030432C7
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F55274B3A;
	Fri, 23 Jan 2026 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rUCxl/6B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF9A26B971
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190973; cv=pass; b=OjIDtuUvkyzrLjMf9vOA/02l2519WPyhq4P9Md2S0A01574txm4P9B0EKTK8RQIOWeB9bKllQHYMXeKb99Re3t6gqg0drTILCqKpm6nOjNSl8vw4+QxNpJS9A3K5ZChabkXq6rJvul5iUJYkl82vBbjCgZu6gjFErsc/Ek+gXrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190973; c=relaxed/simple;
	bh=47KVK4oV1KNaKpRFmFXPiFnrlHZSAOfNpFbyVM/rxyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNL1SoHgb0/G/WS5tDgEJXfmvoV/Axh8aPx9l2DWe32eKlpv5ag2hCXjkbGJLCIrnt/pl9WtCkn3gy5GPGzONbWOkndvSJujCCvfDK5BxDvafybHcrBRn9ZFY1J1i8G10mAHh+p5jpD7asJdmq3lHDRCVFPV4GR5KiSTV6f+v8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rUCxl/6B; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7942b9663f8so22660447b3.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:56:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769190971; cv=none;
        d=google.com; s=arc-20240605;
        b=PM5MRI1VEowD/CZA8V2O8PelUgDmAGlen6UBA1R7AecpOLCS/EzMLR5AbEYbwqO957
         amGMrMqy6Fm9Q56sZKNxb0lkCI/tOa/bThfrYhDc9LOLKpPX+P0bwUh09/MBfKYozHGT
         usYJq4ifG4unf47P0UyAy78u/DG1CjR9UrwGUXpOMXcqPbXIE7RH9HF6eet5r+wAVCdU
         CuQLFIMvcY6KDg6VcK99CfnkOjhkEzX0tpb1iEDev8f7+F9jpSJaZ47UG/VLQOpomj5/
         ugTCs6fTK6GYv99vYQDtYb/TUZte14B7u3CkCLwbNgSUlOJ5+HFdvFEkwz9QfOdPSNqn
         z27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hPEm2oRsWZ5WyQi5AvSh+MQur1z7+e5R6KmqSEmzJEk=;
        fh=1/lvlMLkDBb4Y6Ig9nzUYouUC8CzPStEVJKj5xHCTkA=;
        b=LRQ/27LStf3NmSkEzW0oOQSGFWAZVyYinz3HOxvARpVw2v3+r9pRVSAbK3rtlnk7LE
         zUx9/v/Ok2CO1suZemhih+8YtS6hiuiYPxWUO/53V4MCC69/8Lp2Tjw8pFcDTqaardnA
         fyBm6V4TUXTnEYNyCINmwLwS5/ukF7HziZ1fkXFRhHp1h9KZLouCzjU/TzJYA8m5yUgo
         dquypq3eQ+3UxvSZCZwV01MmX9jaUQ6+PA7q9iH5XykYiOU44jGqewrBB2/USkDM4N1v
         dYwdLQSi3Y++PUbbUoKUl5AhdlnIVefllY51jTIrScnYVmIEeGOvJmmBrZR1VBedmF0J
         TSuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769190971; x=1769795771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPEm2oRsWZ5WyQi5AvSh+MQur1z7+e5R6KmqSEmzJEk=;
        b=rUCxl/6B9CX1G6YSeqEAmlU9gKuzpwP4m4J/ytJWlSTahB76UL43dX23ZrrkDces2n
         RJD1UFStnWX8D/i1d3/FjwOAtQZ72hobj1LC4XmCZHB2dQCn0dOq+mDomCSNjn5o5BwM
         2WKjZR4QtfZsuB4RlRJwTcCmrzIB8Md6SScu17gsD4FKI/HlBfRHv667RCpwohfvWLqY
         EUFj6AUUiWQ2MVvYaQDz5MwQBacGIPUB+2333sQ8qtN9NJtA/t5KHO/HnAv9YCCWr1Xk
         zh7qfNOFhMQqXqfjB5tzoOZOHna1Pvyes8KPuWXiiFKzEsehmLqzCp4Z+2nnRs6OhAVT
         JRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769190971; x=1769795771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hPEm2oRsWZ5WyQi5AvSh+MQur1z7+e5R6KmqSEmzJEk=;
        b=ZISL4dSwaACefzA0LmfyHYc0QQuOWAJ7HwJf9VA3iCCNccorxTAAn++xxQ6CDaO6bU
         1zWhwagtYtiv3Ogt8k2WpfEDsQBno/aeOzimofLg//0cF4RyLeRPRIIN2VwE3Ybs05/O
         L/ihbcuvCNVVbS0eo92qvkey0IyVNJNGUHfJbRX7VgFTKhck59o8iWPOGoxRmE8fGhPH
         WI9AgF+igCqEFSRIeIYuwbrZQHOCYLYmkCP0y8Tx1OiAT7Z/IHqtoi9CUpl8yqHqw12o
         UFdJJHXYj5vBFo+0hVEGo4JdKpXAnYDG+5FjsvuzhJXiMZnSGPaUswJdOyOXgA8Eqdh+
         sIkw==
X-Forwarded-Encrypted: i=1; AJvYcCXeizqqid5N+q5fAefZ61kVIYXBOMLLF707Bk2/BQylZw0rNNQ+MUYpk4+kYl6sLknhqDcd1F8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOO20mrhNHhyeSEG0n4+D/onF/9jEFlKQe/2LXU+NsgfRQv6GE
	8YWM1xTHUX9MFseg8C/AZxr95UNOwgKo3nuwz6AtU5A1ujHPswlhe1oTcvDrmTl+I2GWHsqPoFU
	Aei1dK0vHpLfOLdHXBhixtg2RTPhFs+jfOs8OndPW
X-Gm-Gg: AZuq6aKOySYnIGAtq4iBi0l/1TzkcFg0v9AT0TkJXiBCE0wnSf16MUWCtqXRH0P+Pso
	Jpdmh3Vb9EOw546WOUG5qiIJa5YWz/Hv38GcXvTBGhNLioz9FBE27n5kDguYtHHrVdd6n7X0YGL
	34OuHK33mhZy30xsSkGW7NIqSDsxBjLwhxZYsr3NwhTtW1h6vGt0aQM0xeX0eIdf0B91gXMeK1B
	bBH/lkxLsb53/C4vRfXQZtrGXaVzss7bWKy/HD1/aGOgVzjeq8ADjnrqMdetyy8UJhcjdwv
X-Received: by 2002:a05:690c:c4cc:b0:794:146c:8bc4 with SMTP id
 00721157ae682-79439a0e8d1mr29143857b3.50.1769190971110; Fri, 23 Jan 2026
 09:56:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123052721.3765743-1-boolli@google.com> <CANn89i+ocUUpwzf-0t6_H9eZo3cikwrKd4ymtDkRL8W7g7uz0A@mail.gmail.com>
In-Reply-To: <CANn89i+ocUUpwzf-0t6_H9eZo3cikwrKd4ymtDkRL8W7g7uz0A@mail.gmail.com>
From: Li Li <boolli@google.com>
Date: Fri, 23 Jan 2026 09:55:59 -0800
X-Gm-Features: AZwV_QhidTXbFyW0hdKyy7IVS5RYP3NzTkHkHl0LvpKQD21odQoCxfOhDcfs-j8
Message-ID: <CAODvEq6NXpwYZbXiQeisYEE-sJaaG-tN1u-rq+RTSi=gPY+EAQ@mail.gmail.com>
Subject: Re: [PATCH] idpf: nullify pointers after they are freed
To: Eric Dumazet <edumazet@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Decotigny <decot@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Brian Vazquez <brianvv@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252911-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8AA797941C
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 1:19=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Jan 23, 2026 at 6:27=E2=80=AFAM Li Li <boolli@google.com> wrote:
> >
> > rss_data->rss_key and vport->q_vector_idxs need to be nullified after
> > they are freed. Checks like "if (!rss_data->rss_key)" and
> > "if (!vport->q_vector_idxs)" in the code could fail if they are not
> > nullified.
> >
> > Tested: built and booted the kernel.
> >
> > Fixes: 83f38f210b85 ("idpf: Fix RSS LUT NULL pointer crash on early eth=
tool operations")
> > Fixes: 8a558cbda51b ("idpf: fix potential memory leak on kcalloc() fail=
ure")
> > Signed-off-by: Li Li <boolli@google.com>
> > ---
> >  drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/e=
thernet/intel/idpf/idpf_lib.c
> > index 131a8121839bd..7af4214ec44de 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > @@ -1308,8 +1308,10 @@ static struct idpf_vport *idpf_vport_alloc(struc=
t idpf_adapter *adapter,
> >
> >  free_rss_key:
> >         kfree(rss_data->rss_key);
> > +       rss_data->rss_key =3D NULL;
> >  free_vector_idxs:
> >         kfree(vport->q_vector_idxs);
> > +       vport->q_vector_idxs =3D NULL;
>
> vport is freed right after this line.
>
> vport->q_vector_idxs content is not relevant.
>
> If anything tries to deref vport->any_field ater at this point, there
> is another bug. KASAN might help.

Thank you Eric! I realized this after this patch and have sent out a
v2 patch with this line removed as well.

>
> >  free_vport:
> >         kfree(vport);
> >
> > --
> > 2.52.0.457.g6b5491de43-goog
> >

