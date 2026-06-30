Return-Path: <netdev+bounces-303289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZQNfIwHoQ2p7lQoAu9opvQ
	(envelope-from <netdev+bounces-303289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:00:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7526E631B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:00:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=faJ9sheX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303289-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303289-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2719030686CE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954804611C7;
	Tue, 30 Jun 2026 15:51:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC174657F5
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:51:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834677; cv=pass; b=Kv8BKluCZsjCsKAH83xtvLTCqrqdJM5yfsvlp7t5qhYl0qcNH1aw2wJi7TVsMjbd6fj+lovVbNgmpIISxPWE1CzqMvC817G5F0zCLWXKZn4YxYgFQcJHQkYl/dQZyMUQ5/uSR1Ez72mtk7xiG7URT8wOAurVjwRvP6t5msDhzek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834677; c=relaxed/simple;
	bh=zqyF8yxwG6cNKl2LQ8L4m+cCMSvDc9RyHC0Z0oRs8JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QbrWBh1VxCN42+SEnlATndGdRHDdnkTbBdSjnb1WCPcEpLbMxTBBTWi68frYGOJrNn+4VhyaVy7oTqvy1eot3L25eRqJYmdV/qSBF/zm8M1GcDX/xsV777yBfpB3EKAHF4poWJr+lMuFiqgSKoqqAfnP53FS9sWG6hyeBBpz7U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=faJ9sheX; arc=pass smtp.client-ip=74.125.82.44
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-137335bc3caso9847283c88.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782834672; cv=none;
        d=google.com; s=arc-20260327;
        b=DyRBeG9vP8RnrT+11WSAk6bJb6Dumnti1AzJygSwsn50yutbhmjQ6Qfbkr7cFFrsSp
         f82Kbc9eRdENaJZNY61dQefnbvLxRByvdKjd+mV4YCwMzeHpyrqMIDh7ld9rYC7+RmVb
         6Ar2rsstmUNN+PsmKSk433eBDNv9xJtRrmV3qE+0oULxsv71/nLAxc+sEFIVQbBLTKiN
         D2Tk6DOMO9Q3IyoqTrxNo9zEXld+/8wMjm/VjQk1IeoJMfGb89VTuF4cOFsnpn82tmXO
         yHfX7HmGDDlduPPKwjTMOlDtvPXjN8vL7Mt12MWhKMExLqEil8zfdgYJa1QcSpdKdQBm
         Bpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KcdItWjXmyMwZLybZEgMEp3Pbc2pQR/msa8PTL2p4cg=;
        fh=wAb5Mcbs3Uw9YI7zste7u6LNqqAVnbGAC3HnUpHeFcA=;
        b=C9GGrMuSkn/A4nxuD5lWzB9AZHH/+aLr8l7DTPNGfLTN/moG9qBpO0RAg2HaiYhTfU
         pnL50QUHEV30asGVUMwXowHAxW/UquipGqQ0SO+h7cT/nLgW6XtlLbfFirHYpbX0qZ0M
         cNerKfJYwF0OGiI9g3wLsoUj1DOJuME5fChxBdIuR1RtcQHXHWDQ8mgbTYim1Fv9lEXI
         y8dT6hI8qY3H3UqKjaTlvpPq1egJoHUbKJbxWe9LQ8r7mHk2WjFJT5RbJKvDyuzA+sbu
         9uUVc4NRoGgv8680YLqClq/oqEm5rhR3cELUQb8wMVmKemZqnp/cEhP9d7yQqFTLTh3g
         c2Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782834672; x=1783439472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcdItWjXmyMwZLybZEgMEp3Pbc2pQR/msa8PTL2p4cg=;
        b=faJ9sheXklRN/DBNnJt/CNUbqy3BkQEft74otv0BluJsWbYDkRgRbCfS8iBZZL1Mx4
         Hh/dMS/Mjq1ehyH/suddTnh3NhT/6aMLBxdzpfhgEMcj/zb3tN0au40sdZnuQ7tJZV2t
         7XoXtd8SDCSJ/NYll/a3QZYLLfyoqY3UoODzcIxLydOH8VFP97/Y5tlaqS251LZ9W5K4
         3cwgGuXDr8y4AMOfhlVSz86dJdPjj3MFzRUvbuDEQfC94rk5RoTEUSBzYPiVkvPNYrBh
         fHdtdFdEAtEM5B2kghkeONYnGIpp0/6B+lKNho9xD/EB5ndlFtUJHebnpdUvknvVNYuH
         ZLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834672; x=1783439472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KcdItWjXmyMwZLybZEgMEp3Pbc2pQR/msa8PTL2p4cg=;
        b=Fv0PZ55qwpQXDVeGx6zrIn760CzfpbSHY6OAyPsVBVQraAkWYVQY3+WsvEgHtcwJWb
         OzEMWAr8D+ejjR9IlphmENQkaAk4Sw0r7w2t/JaZFy6KtzYhCf0qDuwburAyG6v4B8Vb
         UevLEFvt1zuUtedwHkpcxXs8P8YCHi4AjT8LMzPMxtQL4E/RPdY6WXRiCSTGQN7pczez
         NHrSbRIOl5KyolTf1t9HpHjEYHljaEbpZgSGI1pIeRFsCwO04gljCyEMaJLgeQMOacMU
         7S4vf8H8+7ve7f0XMve4rrSiIeKe4wt53Vc0h/QD+Msv1x3dx9UCqfv3oKs3e/29lusF
         UdDA==
X-Forwarded-Encrypted: i=1; AFNElJ/U08hY8WupzjrfpZ+neLjxU7fkQATq7fim6LRPZZZvfniI7Px/hloCW95d34o9UfE23j9XeTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxByz55yHW0eOfa75CPd8g2ZT9Ckk6nI9Y5gd9fj9lhWg9UN0im
	gaeF642dzdSyVWl35ujoFHVsOjLTFVZMb6yGrqWPWaRY3C5C/QWOW1ftLQehAWgzlZ9yg6g0pj+
	FHw+YHB/XjCfegKwMdyJo6K+Fcc0GbQtSAkBvxvlw
X-Gm-Gg: AfdE7cm78rGvDP2C1+MU7bvUZfz/79RFtpOZiXfF6XU0doOW8qs3TWrpmh08mJxkq6Z
	krIQOYrqk17SScmMnUvGc/KT57c91dObxHFLDjEdmmVG3o2lpTwkm0h4QaRnXGEQH05WjtbqNyr
	auhl/tXRCNqmtKGxaAr5gDROWAQerQgHaF//aiJ4VVCBDk7k+BhigaPtYhQBV+rt52uS0+kimR6
	5MyYEyOP741eVhF9rNssJIHiNTR/KNNhjjTI03ecVarMruQ41uXNC6BfgeWVUXBO3L5V8raeX7v
	SMIpvaD91Nep8IAOZisUMP2PtsJxVv/XTdeMQWUs9/cl7lAASyR9607e/haqN9/9UxU79BuH/uR
	8/ilKCgeg
X-Received: by 2002:a05:7022:6ba9:b0:139:cf4f:3b80 with SMTP id
 a92af1059eb24-13b2a1bee2dmr2559342c88.34.1782834671865; Tue, 30 Jun 2026
 08:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630070600.484-1-yimingqian591@gmail.com>
In-Reply-To: <20260630070600.484-1-yimingqian591@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 30 Jun 2026 08:51:00 -0700
X-Gm-Features: AVVi8CdG-THb23zBHuXZmwMHxmZ2j5WW-aQiDS951VFSGK66qfbh2iiOed2Ei78
Message-ID: <CAAVpQUC_EcpFf9GmNnD07KhFAOcPhrCa5xNF-idz0CsB=TJV9A@mail.gmail.com>
Subject: Re: [PATCH] af_unix: mark MSG_SPLICE_PAGES frags shared
To: Yiming Qian <yimingqian591@gmail.com>
Cc: security@kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lingchen5202005@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303289-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yimingqian591@gmail.com,m:security@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lingchen5202005@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC7526E631B

On Tue, Jun 30, 2026 at 12:06=E2=80=AFAM Yiming Qian <yimingqian591@gmail.c=
om> wrote:
>
> unix_stream_sendmsg() splices external pages directly into skb frags when
> MSG_SPLICE_PAGES is set, but it does not propagate SKBFL_SHARED_FRAG
> afterward.

I think it doesn't matter with the plain AF_UNIX.

Please elaborate on the scenario where this could be a problem.
e.g. sockmap ?


>
> That leaves later writers without the shared-frag marker even though the
> skb still references externally owned pages.
>
> Set the marker after a successful skb_splice_from_iter() call.
>
> Fixes: a0dbf5f818f90 ("af_unix: Support MSG_SPLICE_PAGES")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Reported-by: Can Liu <lingchen5202005@gmail.com>

Reported-by is not needed when it's identical to SOB tag.


> Signed-off-by: Yiming Qian <yimingqian591@gmail.com>
> Signed-off-by: Can Liu <lingchen5202005@gmail.com>
> ---
>  net/unix/af_unix.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index f7a9d55eee8a1..f2cd0f8ec0914 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2458,6 +2458,7 @@ static int unix_stream_sendmsg(struct socket *sock,=
 struct msghdr *msg,
>                                 goto out_free;
>
>                         size =3D err;
> +                       skb_shinfo(skb)->flags |=3D SKBFL_SHARED_FRAG;
>                         refcount_add(size, &sk->sk_wmem_alloc);
>                 } else {
>                         skb_put(skb, size - data_len);
> --
> 2.34.1

