Return-Path: <netdev+bounces-277840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKIAC/XJ22nzGgkAu9opvQ
	(envelope-from <netdev+bounces-277840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:36:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2933E4DC0
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54AD8300B3DB
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A0F1A3164;
	Sun, 12 Apr 2026 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIM+XRpq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCB633985
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776011761; cv=pass; b=i+xWxgNcP2FEdoIsH+FzgEJPwGmB4uksB3pv8YmxrDeZEJyCfL/PhdkX7ybrs81JmOaSmQzCumamhDOwoK3mtUoKINmlFYTBk6eOsaDxR33tjBVTR96RlnJiWX1IRr640VZF8J9VJ7Uy/QkIMAPoGbKAqOP5ofWE8PHv7OEDVOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776011761; c=relaxed/simple;
	bh=mIanxl7aSG5J8DWKMf6Ozl/HKq3UFkyMm+8iPvpP5ek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVCYAnsVHGAHT20CgomYhKVvREx0Lr0zh8Y8jLzSgrQnVklZkN6srNHL6KKV+zsD2oQ0xolPWcH9ulx8arsVJIyU6A+5iYKNR1D/APPm4vq8mfyyRQgeNJnljk7rZZlqVfzLI+BIrns2YrSlMydcNb+6KETm+EwqiY/pmQVUhdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIM+XRpq; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82748257f5fso1930432b3a.1
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 09:35:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776011759; cv=none;
        d=google.com; s=arc-20240605;
        b=Ve+6m2TEqLRCnR4/9R8oKBTqA6Ljt7WinxnRgy7to+sdYDy6dyC3tO45hpJ6qxbolj
         bwXeiSD4TJjJNvR1BvIOrkwQmAqmc81nR/7ywn52KxcaX8E8Fm4nkC0SB4iQa2f9XWLJ
         Np9dS3n//3Ua7iWlyWwLFQHRgmks8pZ24xxTmx+w+37BRgQU0t8xyE3Ch+FIQ/X4sIXg
         y4WywewWI4fZvsc3UlGjjBYR2jmZuJWEOmRvUWVhaG1Q4WaTbX818/wU9zoEV0SdqwIy
         jrSbSsJBNkdv4/EfJlB9vcCHrQWLZqsmLr505LGmjzhuIU6bhGILOLrkoTfbkEj1dEkS
         z/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NQ9NvNayGMyZ+dVCnpodNX+JAbkBTvtmDGNN9xFuIxk=;
        fh=QrQRFxrUHZlaH2jmCJuRxR89wDGsyMoOooirS75foAk=;
        b=Fz3+EbOej1Qs5OE8xokOC+qgsPHHC3cNf8JuR6vaAS2n191pfxpFZuQeofoeWOP//Y
         77LV4j81ATbKXYK37lo7uxFs9BXQf2f2FKgFHMBnF3LG5KOI3qZRH2P1WbyZZgjlJqKi
         nLrNNaM8rAFmberZjCC7IXHt2EzrZkwmOaCQh298yVmIp82HK0iJZApx+hPsZICAuqXc
         2hEghsu4L/MgtmvcyaNEO+t3Vs3P0puceMKl6WmWdZ5oLq6ffHTuw1bNlk+GXShQ0UFZ
         Y80X0sUL9b0XuxJykqFTV47yRuunV5fgaklIkVpEcOxsAK4rHrd7RymIZckAJog4JUII
         JxDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776011759; x=1776616559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQ9NvNayGMyZ+dVCnpodNX+JAbkBTvtmDGNN9xFuIxk=;
        b=fIM+XRpq69x2sa5xz3IGTfLDycnnBMu8PL6vj/QJmLOnXAHmLDykRiN9OlZbBwIIXa
         0QCWgsWYitDH7H6tmHAJ8yh70mYwvxQIHxB4tdy7C3XWv/w7N/P0VlLaT5PRbxu0mI+J
         crqrY8Y5FOb+0p6NAdmkhJAnM79VnLgN0LIqj9++TkBD7bTsvO0IsCYCwsNBNK6yBZ3Y
         ov/U99P6D9tDTG5zZpqjY5YiSgqeuZHteQnaV23UT4xDxcIx1be0AhNjXg3ZyjGhNREP
         MT/CMbRZwtOFJhPqJ8jozUDtRhQcVQYamwJCs/2A+SQoj2lpZ2r1mhZUc2j56LD2vXDl
         hyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776011759; x=1776616559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NQ9NvNayGMyZ+dVCnpodNX+JAbkBTvtmDGNN9xFuIxk=;
        b=bLBisVGplakBGQP5pq75yhUQZFwjhyDKVMkLqZG0ZPS+uJ9JZrTDCumXpc8JgOlL7u
         dh0xaSj6UtaOZqdMVpLUmmJb4f0n7omDBvFoKfHaDfoDZh/GGl3dbi8ko+2PB+ANaMl/
         XkYbbtWX1jHURqo1E/XqB54PecTux4OlAgmyskQNYFv2CwMrJAodanuGIihqpm6UPAGC
         zwxQOw35wqE0yX5qTf/RGdhOUTZANug7sbyGFmRRDMPgO4rQrgIpa9pk0CaXchM7gyNN
         AeS8wvcU3IIuxl6Wifl6RWiHak2UJpXbM9S1Hkmw/TU6bkEOOHak/8HZEqvXctuXr/50
         1//Q==
X-Gm-Message-State: AOJu0YwzvtouZNQCf22gJ4kyTI0+qMI048xlFFUVu7YZPTvN1911s24E
	HVvZlNlDJsKELPKZI/O0UAfoNiT0NZVkvvtIrxSWayW8bzTLkftZAVrxCO2W2gEMY+7teZnYlln
	R3IvXg9pSUlDxUcxzxf47n6YPXiYxHjSojV9C/MQ=
X-Gm-Gg: AeBDieuWBBrn0xgK8a1dup7iIoDvyTCDeEBDBzTBOOaWlv2XwZxA3BMhZK95ddKW8RH
	vd+8K2Sose+dHV+yaU6jzIN5Ui3KtjfqPnihr8WjxR8UWEsWcknyKedBaZU2VVc/+eEwFazyqVJ
	hN/FSbuWQrwYaB9LbfbNtZH72vUP/IrffyCTZnwk7d5HUnQ7lBIvFvIam7IeysH8BeKkay5fuxg
	8CA+eOI9IK9nBXfbnDZIAq5jglmGv5BIEPOfQSiuH3RrqfT5gAb+yri5PbtlEW2vG9lsRYkmYTW
	a6xW4AN6Ds1DW+nVotiObYIYrUeCh/AZrhALmSCsXFQ798o9qHy83piOl7+fdlP72u83HGhCG59
	B+kNrYA==
X-Received: by 2002:a05:6a00:2a06:b0:829:7a62:6a with SMTP id
 d2e1a72fcca58-82f0d3530d0mr9367525b3a.22.1776011759466; Sun, 12 Apr 2026
 09:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775847557.git.lucien.xin@gmail.com> <6e09f9a8d1f13f3ce691c696d3dd7b2a2e6c6184.1775847557.git.lucien.xin@gmail.com>
 <adqsEmki7ppz9T1g@strlen.de>
In-Reply-To: <adqsEmki7ppz9T1g@strlen.de>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 12 Apr 2026 12:35:47 -0400
X-Gm-Features: AQROBzApleORXuHh2o6vMtozQ8NYBzR5LhVc2PGYSEkZSDGn2fRU2yAsiYhwJkg
Message-ID: <CADvbK_f1Cvqx0_-J1jGaT865eWiW2ZHsJT8EkN6kr21j88Y9kQ@mail.gmail.com>
Subject: Re: [PATCH net 1/2] netfilter: skip recording stale or retransmitted INIT
To: Florian Westphal <fw@strlen.de>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Yi Chen <yiche@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277840-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9A2933E4DC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 11, 2026 at 4:16=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Xin Long <lucien.xin@gmail.com> wrote:
>
> > diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf=
_conntrack_proto_sctp.c
> > index 645d2c43ebf7..7e10fa65cbdd 100644
> > --- a/net/netfilter/nf_conntrack_proto_sctp.c
> > +++ b/net/netfilter/nf_conntrack_proto_sctp.c
> > @@ -466,9 +466,13 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
> >                       if (!ih)
> >                               goto out_unlock;
> >
> > -                     if (ct->proto.sctp.init[dir] && ct->proto.sctp.in=
it[!dir])
> > -                             ct->proto.sctp.init[!dir] =3D 0;
> > -                     ct->proto.sctp.init[dir] =3D 1;
> > +                     /* Do not record INIT matching peer vtag (stale o=
r retransmitted INIT). */
> > +                     if (old_state =3D=3D SCTP_CONNTRACK_NONE ||
> > +                         ct->proto.sctp.vtag[!dir] !=3D ih->init_tag) =
{
>
> Should    ct->proto.sctp.vtag[!dir] =3D=3D ih->init_tag case also
> set ignore =3D true?

It should for a stale INIT, but not for a retransmitted one. At this point,
though, we don't reliably distinguish between the two.

Also, as this patch only aims to prevent updating ct->proto.sctp.init[]
(introduced in 8e56b063c865) in this scenario, it=E2=80=99s safer to avoid
changing other behavior.

Thanks.

