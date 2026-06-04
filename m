Return-Path: <netdev+bounces-295197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z9mwANRjIWp2FgEAu9opvQ
	(envelope-from <netdev+bounces-295197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:39:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6978763F7E1
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 13:38:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=KZD8gqOM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295197-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295197-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6238303110D
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 11:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9D83B19B4;
	Thu,  4 Jun 2026 11:35:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A1407597
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 11:35:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780572955; cv=pass; b=Q+ELRaTtDJBB+S82sWPmIVYYU2KpTBAxos7AIzjkXZ251BkwaQ41Z9jAeWgEew6KQVnkWV2J/ZQnckeRWzFyKKWa0CZAXsIm0s5AbYEJ6BD+OMZ0nR5VAgL9qafdNtTNoop+cdfbbu6oXmHmv3YcXGBW4cNlNLCixMqgMj3gAfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780572955; c=relaxed/simple;
	bh=SgU2+O1qVnP93tbbWQNDkNxh2GJU8NRcrJqhzXyf8l0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyP3zIlkNfPYZ5M0w9FPA/A/52mquuieZBexESH4gH3iLdzvD1xNcium5yiXGV2MKI20z7Nsl0IcV7eKe9F2xBj6TIVrN/CeeUYaA8kpBSJ4oRpFhH8oR/s9eBdfU9uyKV5dOfRwkX2eRnPnnMBMG2iD/VprjD0TYZAs+rq9x4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KZD8gqOM; arc=pass smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5175d339e8bso521221cf.0
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 04:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780572954; cv=none;
        d=google.com; s=arc-20240605;
        b=EoOkTPe7GCViMY4EbA74dO+7zcGfwangWbQCZd5pGbxWxsFDt62pLR3yGmWWzLgnUd
         Hor6wFvXPU9YsvAyF2du8MhNyTDIlajkx0RcIyBvSP6vvZYfvClLOYQ+N/FDJ6TQni+R
         +YAMb5WdteZ/fFlefNgAQ3td1U+Ihbkpaqvb7qvmhfj5Xk0kYDtEu+OICpDacdrJruNM
         sspxBu0pwBIZGPBl80d1i46d+jNP4RR0hDYZGKptEvFrTPv8lh9vJJ09awKfLXpWybDc
         5vid/sbM7rLrCmD7UOqer0lxTV3A1B5peRPVbeTckQ1muG7lb6DtVxHPrYZqRLIt2i7X
         qWnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yg4x99fBtz+f6aO+UsqxYVWgAGOJf5YpBuFNQpiKhok=;
        fh=1AqvwXpwljB1e6nnNrr77wUgDtAr6bssWemo3TCf4+I=;
        b=UXUHvTwLMpo2OrOBAU4LRwe6HSQvkEM0pkVt3D2dKYPa47FJ/AnTFEWwt2k9Nw/gXG
         vIRSAs2qtrasVqeY68oKc0bCVB4U0i2r7fxKh/pE6t1WbVn8cWrJQF1ZnrsYRuYQOfvq
         529d0hfZZ1D+zMjk3WFu/Yt//rMdvJfogRiI/oF8Yi0XZ20h6uYNQIX3rUXXWXsuirtl
         YYp2cE1qGBC22gvfmAgo5kj7jPFklTJThN/V02MFhXbpS2UZrpKSKHfUAK5flSIp1liV
         IUn4ZKfliXVr0Cc0awWutXuOi2NVQTQvXbrvHQUGYo/LIlFb+Dz/KZDbdpEwuXPqql5+
         X2Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780572954; x=1781177754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yg4x99fBtz+f6aO+UsqxYVWgAGOJf5YpBuFNQpiKhok=;
        b=KZD8gqOM3Vb/3ankMKar0nH6CkccCSAnyZHHmgb+w8nDtVwuHoo7F3ii0Y9DZGaeiV
         2Rg/gXdGMWQo9XdvA8TWKPnpB84ZGBcjA5kQf5z7nhaxUnuItHVXO71InU9i2/Sa4UgL
         F/AxMJVyIgQZtEUKc4lfLGlXK78tpQG8GJApyX088i2+E8np2I5YkpkzdNCPu2jGKG5z
         q2lU+sEl09Rl8jaem28bLKqhF8wNWW8mZc6xQbn0XpFfryOcxul6ux7gxjPZfpvgQivC
         gg+5OhTMtLoWjNkBcfYnnBhtvghL5iOgOAeUzyONY/oupZYDRUYfW+aPv2C1SyyY9AsF
         v6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780572954; x=1781177754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yg4x99fBtz+f6aO+UsqxYVWgAGOJf5YpBuFNQpiKhok=;
        b=bi12az/MSFI6RkczmbGA+j3TEHOsOdKvDbVb0BG0T8XOsklXQT1Q7c2fggXQFMudUF
         Esb6ZN3uf4mE0dmhEm3La0eOETeOVjGD6bJNipZTLOr8woENMDbtY65HbpvAkNTOHD05
         U93yg2IJdgfo5DoRFgc7zUp99nafGHh+LfRsCghOirgYxLYqA5aBKADfqH71K3ejI/W2
         uQ/phrKebbhb8X+m2A7eyiN+OpH1qPXHdzmP+nF4onMVISo7v2WCDaXuOeP1oR52HflZ
         GMIiSfUdHLq7kbyguK9r24RNXvqukq+jW3Bdsd8eJlG+Spu4xH3MHKu49EE4fPs3nQON
         NTUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9C/2L0BMFQsX3ZsxyvKc93w5mxmSXBJxwIeYzQh2mq3Fbb14pAg/zNxZgc2UBGiUgsk7kJ7+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCzjm3dt2Mgpa9A5vusz46ZRnNqcd2F9E6muG1yOkS3zhRWSBX
	YKBWL9mqvhNtBwrDuMfaG8se0Gs++vITcCyU+iN9zuh6LOULbH18w2Sq+RIuIQpGMkBp/ApOVgS
	EWbQyi6ymggkHyiCEcDq3/rRZlB+N9T1F2kH79Jlh
X-Gm-Gg: Acq92OFMnRbo8zfWdBMVcLjWsht/wYcBDA70QxBZKlcyROkiG/saWFTyONqWOQ/X/mP
	IGUsyTu2/E9qX9hvA4VzUD2ps9S4O6lFUz3Blx577yN6BthqVUgykzuAezlQghoDHXOXyOdFmLs
	/Lm4sNL1iDFZ8JzIhcxmBlbp+T4VKTOFHCFBf35SqwOVsL91UC3p757WlEYtRiOJBGv0JU5Dhyf
	H/1vrDcWScUwo/bKaa9YupPSW3GFu9WeCvgtn/wjnwehPIDqLzPaoMgMP8Hn5KavZ8J5NSoD0DG
	0uFAr9dvGYh9HbHS+7ukd+61SitNhnKHk5FH47NaNycgMZzAgA==
X-Received: by 2002:ac8:4651:0:b0:516:4f62:85ed with SMTP id
 d75a77b69052e-51787a79f2dmr9114181cf.18.1780572953224; Thu, 04 Jun 2026
 04:35:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531030705.3754389-1-yuyanghuang@google.com>
 <20260531030705.3754389-3-yuyanghuang@google.com> <20260604102001.GC771160@shredder>
In-Reply-To: <20260604102001.GC771160@shredder>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Thu, 4 Jun 2026 20:35:16 +0900
X-Gm-Features: AVHnY4Lb_a_R7bflhmfrKCJj7HqnSgAjEhk1Gu-NoCgjI_cfw2jrUR7vXLGTjks
Message-ID: <CADXeF1F2E55krqjxHXv3PrhvJ_E1oUnUWg9oZ4pL-M13Ke+fyQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ipv4: igmp: annotate data-races around timer-related fields
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295197-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6978763F7E1

On Thu, Jun 4, 2026 at 7:20=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> > Fixes: 1d7138de878d ("igmp: RCU conversion of in_dev->mc_list")
>
> Pending Paolo's approval, please drop the Fixes tag given the patch is
> targeted at net-next.

Thanks, will fix it in patch v2.

>
> [...]
>
> > @@ -2964,6 +2964,7 @@ static int igmp_mc_seq_show(struct seq_file *seq,=
 void *v)
> >               struct igmp_mc_iter_state *state =3D igmp_mc_seq_private(=
seq);
> >               char   *querier;
> >               long delta;
> > +             int tm_running;
>
> Nit: Please move this above 'delta' for reverse xmas tree ordering

Thanks, will fix it in patch v2.

