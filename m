Return-Path: <netdev+bounces-281916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCuxLsbF8GkpYgEAu9opvQ
	(envelope-from <netdev+bounces-281916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:35:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F054848716C
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 310A030D3FD4
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A81390233;
	Tue, 28 Apr 2026 14:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="pKnWoU5t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758FF246768
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385922; cv=pass; b=InhSOnKDZe6rs8XD/4oRI3I9N5DdwDv/r3c8deJDIGqdqG/b64EhZ8RUXIbldYfwWIcY5Mmxy70ArGfW+6G1ZhQR90RkQ3lusVWeOG5DCf6AfKjRHRmOJfKClY959Rfd5HJXlxs+4AnGa7d+kCrfjs5GdYEdeX6pa8llqRJvOZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385922; c=relaxed/simple;
	bh=J68xMaCF8jCe1XryUKuJ5ufI8tAITDZLaeiQiotTnZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2b3rMBm1GHQSA3ROAiGMGGYlfq5j8X1eoqe4/2+Jbf8m1BrooLba7rlW53eqDlB7Pg3MJvwINLbDXRSynXh6x5q8mfQtttAs7ZV1R3kQxRqkcwn5IMJar+sPucFdUovpxeJvjkXjKmvbHsa/ZdYMYDUsom9JHe9GrrUFSgAka8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=pKnWoU5t; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79ea87af213so176440347b3.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777385917; cv=none;
        d=google.com; s=arc-20240605;
        b=P0rtNFwSwMaWXHvy+xYF1G3VE4CZEOGgWd2Q/i0XkV6zMF+bG6PNi9o9iBVrIB7bL+
         MhlfX54dpr3yDHJUBgh519PmEsicep+uBI1+Xyr5IDwZLCdVaDzQgAVQImXs8JVZNBqG
         UPWXMisi6q68q0JhaF6uPLe6D9/Y0HDzDbO5RGiuPz08Xw7mka8b3UFrV90nOz9E4hDy
         mDjFikXiusuZAFUS0cTUUvIdKyDu6CC5R7T7M0cCV9o4qJKkgg08brSIHk0nZSoOS1ut
         tuOX5zR14iFqSTUZOrCb7LbGbDVGWsYalfKIK8OjDY0DK3y41NHxqy4gqd/KUhVlIpQn
         tqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8dxvAsCxY5I0SeqYII8F7DHYxLpO3lM1xFmtrruUN3c=;
        fh=aQ1Fm6bmA8yy1Lb8IhKBVNB2Ib6N6S3JpCFwQJB/6zk=;
        b=Cct4roNZjcNeJhaPJDCCRWTxESpIpIV3nFc+zEI6i4k30XnKwEd7IsrpZPQ+HwhVeb
         oI1ebnB5F86phKDQHbjxkx2RbeewyrWZqWBqZWqIKGu4tM1sNhHyIscUIjklvCf3W/Do
         thTn1wmbxRNqe9b4Oqz01g/xOsMnEI0R/zTAAiFX9T1mnkG9mpIV+XLB9k/Z6X2S0doW
         KhhHp7xGWu3S8tEFccfORRZx0w9wLp83+Umg4c18yV65xEoTQIlPmTxm9lf++KB8fNuO
         xpU9No2gAMDmEP2FdlKsAfZ1YTJXc3Sxc+LOavC6guUck8FbNwS3khrKw+G1AHVM8htg
         Y3tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777385917; x=1777990717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dxvAsCxY5I0SeqYII8F7DHYxLpO3lM1xFmtrruUN3c=;
        b=pKnWoU5tY48ZncDzJdoJfICekw37gjWboflWiCvY543Uw5MA/sdMNFFlOssmZyerdn
         qby2s6vwMf4tyaemZ0+iARj0Xu/Ig5l4HopJdadM0nOJKA9SOt8rlHDppfMaB1Q5jULU
         co7avnzN7paSKLMi99aJkqvscdg5MJrJ3TaoyHm6O7C6UIaZN0UZmjo/AaW/B7jwHY48
         TSMjjT8ZsNP9Hy22SLIZueGpcJCILP28R72oKVFT3y+uQzlacnxAzbN3FDySmtVPDoih
         q+YKCRrd8CvQlJ3j0wPXWOonNW5A2OckbzvUXD+epXnzQvx5/ZTpZp91WaYUQR7NOjQ4
         KKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777385917; x=1777990717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8dxvAsCxY5I0SeqYII8F7DHYxLpO3lM1xFmtrruUN3c=;
        b=biKgMqINyOMisgDsBsRV16VANwgJ9TnJJv6pTszxnBXSzdZ+xiHnLZaeLmV3cxTtJx
         r5ZQK7UoMNAKMUHCIdlKznb9RldgQzCqUMenFeE7eT4ABBPNm5MtAShWK3LUpW1BjOaJ
         a8SksUi14c/1/IcQYp2rdrpeMAU0j7gBN/60scu8HpQU4stMGQZUCOc6kxFfErNZEFq2
         78MO0eJuMpAPVB/wSiA8aYnRdaX/KNpVUcvWJ+foyn+YOXACsRoLvDo2VgTERvT3yqlW
         SunpNbvQm65jA5uYRrAaklZcL2O30dNKBoqHKlTc65NC4ueaLDJsW0zKoQFJC5szVeWV
         VjVQ==
X-Forwarded-Encrypted: i=1; AFNElJ94LuR1RqTkQTqncIc17tW5F/D8owqIOkHceZ0e6+fliplD7MqquCiqAm2ey8eBWClCIzFXnXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOjGUq3x0LbKBrleBuHD78wGmYr38yAZbPcKb5yplR93OPPcEJ
	fCq/ijWSJ+TI4lmK7zI0Yo1Cdclp+p+46Oaw7Z+vT7h08YTstfDrrnu/KXklkW4mvuYaSm0u3CA
	VzS77Vo/1m+6OpYO9Q9WIu+tkfnZmTCGGFu54DnYd
X-Gm-Gg: AeBDiettk/vuwcIu77PIZMoNsn1Tznb1h4auUrCL7xibfy8ERDOdzg225sD4/NTrdYN
	JGh2dZmnBDn0cvf+La+2pUzLe04f0006xWVET5e5Kca8gIEKklO3gkWcB1wVWhETtyGRw+unOpU
	wyS/v7IaypVQgfGvNmSESXDgEqmF6URbxIoqwYZ/F+xBj0QmI+ze2/WGVFKybxzGCy04QsqoXTD
	nbH5FkyTfbjQs8s1WM0QQRrYYF1SzIFobaJ+KVA6x9pFcEeFJmSVVUk6TbKHiggkXbHhGo+M8iO
	IbQziPrpS5A9sC61DBQtkKkbqcsnRkvZ
X-Received: by 2002:a05:690c:388:b0:7b3:5872:695d with SMTP id
 00721157ae682-7bcf36d3aa4mr26250577b3.31.1777385917423; Tue, 28 Apr 2026
 07:18:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260426190916.128489-1-jhs@mojatatu.com> <20260426190916.128489-10-jhs@mojatatu.com>
 <850472d9-2dbb-446d-a070-0c2ee6b53cdf@redhat.com>
In-Reply-To: <850472d9-2dbb-446d-a070-0c2ee6b53cdf@redhat.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Tue, 28 Apr 2026 11:18:25 -0300
X-Gm-Features: AVHnY4Jh4ouWK6-sL4JNGOxPtEbrMJ9AsNEYXUYZFZcPrsp1W_kUTLdY3kfVlUs
Message-ID: <CA+NMeC9L6OyN4mbB1fxvWABMYOChJY4QZ6LsUUT-PbJxxD+t7Q@mail.gmail.com>
Subject: Re: [PATCH net 9/9] selftests/tc-testing: Add netem test case
 exercising loops
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, jiri@resnulli.us, 
	stephen@networkplumber.org, savy@syst3mfailure.io, will@willsroot.io, 
	xmei5@asu.edu, pctammela@mojatatu.com, kuniyu@google.com, toke@toke.dk, 
	willemdebruijnkernel@gmail.com, hxzene@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F054848716C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281916-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mojatatu.com,vger.kernel.org,davemloft.net,google.com,kernel.org,resnulli.us,networkplumber.org,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu.com:email,mojatatu-com.20251104.gappssmtp.com:dkim]

On Tue, Apr 28, 2026 at 7:16=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 4/26/26 9:09 PM, Jamal Hadi Salim wrote:
> > From: Victor Nogueira <victor@mojatatu.com>
> >
> > Add a netem nested duplicate test case to validate that it won't
> > cause an infinite loop
> >
> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > Acked-by: Stephen Hemminger <stephen@networkplumber.org>
> > Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> > ---
> >  .../tc-testing/tc-tests/qdiscs/netem.json     | 33 ++++++++++++++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.j=
son b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
> > index 3c4444961488..7c954989069d 100644
> > --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
> > +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
> > @@ -336,5 +336,36 @@
> >          "teardown": [
> >              "$TC qdisc del dev $DUMMY handle 1: root"
> >          ]
> > -    }
> > +    },
> > +    {
> > +        "id": "8c17",
> > +        "name": "Test netem's recursive duplicate",
>
> This test is apparently consistently failing on our CI:
>
> # not ok 365 8c17 - Test netem's recursive duplicate
> # Value doesn't match: bytes: 294 !=3D 196
> # Matching against output: {'kind': 'netem', 'handle': '1:', 'root':
> True, 'refcnt': 2, 'options': {'limit': 1, 'duplicate': {'duplicate': 1,
> 'correlation': 0}, 'seed': 17230427318941832146, 'ecn': False, 'gap':
> 0}, 'bytes': 196, 'packets': 2, 'drops': 1, 'overlimits': 0, 'requeues':
> 0, 'backlog': 0, 'qlen': 0}
>
> sample full info avail:
>
> https://github.com/p4tc-dev/tc-executor/blob/storage/artifacts/622604/1-t=
dc-sh/

It seems flaky; there was one run where it passed on the CI [1] and
is consistently passing locally. I think I know the reason for that, but wi=
ll
investigate further to be sure and fix in v5. Thanks for bringing this up.

[1] https://github.com/p4tc-dev/tc-executor/blob/storage-dbg/artifacts/6222=
77/1-tdc-sh/stdout#L1902

cheers,
Victor

