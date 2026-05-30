Return-Path: <netdev+bounces-293345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A54N//OGmo59AgAu9opvQ
	(envelope-from <netdev+bounces-293345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 13:50:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E4460CA3D
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 13:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C23A30293E6
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 11:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A593AE18A;
	Sat, 30 May 2026 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="VFR2xx2u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2207A3ABD8C
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141766; cv=pass; b=XLojYaATFKBf4nUHMWJJ0IeIC04ycGhhc0ywj7QjCkPLfvGWNZeo8kM2rlnYeDm32NTcGV6JG6cfPEjcv09NDTDWwdvGfFowqcobyS2N7WMzZDMUKTwaXvUtzn023YmUCmm6M7su/xly/LcRidJP0PTW7oID/YTGiOhyoBXBq70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141766; c=relaxed/simple;
	bh=yVI2zXsje2mfxSNn7nO4Zsvfmi4gqcVAuqbDLqZMjWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C5wZHrDrpM11GT0BwXF1wkz8gnzvX3ZZC9ilAYD+NnA34mq1YqvCP++RQXW61DwYUAWGfqPYcEVCKjurbDy0rU//eRl6tsbpWsWNDb8vCan90Sy3PhqWYk0ek0c1LAO4v2BD9Cve4l3OYPmhJNWCVuEyzQnImZdXx0Fg7waVMes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=VFR2xx2u; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c8585ecdd71so233086a12.0
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 04:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780141764; cv=none;
        d=google.com; s=arc-20240605;
        b=DIXhuxZsusW5l2zYNEsOoyfwgzhi+pQfAm9F6/rlynny7iGQws2c9tWtWFFUG9x3En
         j0k0sS+BDvGLW+fNONm8ecXx67J7JNV3zMAnbg/F8nsQnTqEYOwTMdZza1czucl7nPKu
         +h1yuC0znuDlv2leVLoiK35MyNHJsgQeDtwM33pA13yH3oFn9Gzk/1lJ6lYmyz6ufd+I
         vHl5vkwdgjXS8unEt1WMnA+uvYWwlVIpiEy/5UX2w/UZKxL+uCGBKKEIKoat6NpTT3YR
         yCvxrmanyx++6uHYSn5ToFgQQeBCuykZVxlX79b/DPdSkp5amgaYxCaRIj8rn+BSHeId
         sqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yVI2zXsje2mfxSNn7nO4Zsvfmi4gqcVAuqbDLqZMjWo=;
        fh=PuV/JvSqfWxyIthkC0ldjmRvEtZPeoZFuUEyXIcM14E=;
        b=DAFZdJVE6EM6iAL0VJXNUriEqwYBLDhL1LtZzYi/Rxcf8iuuPaJ9TF6FbLgaI3QedJ
         Vfa4aB5ngBcc4iSU653zMsDBoQ8v0vFLtzLN7TdNjnaKwYpK6gX1EdWFQ+XAAP1dyyEZ
         bwpkltNGiu/ivRzeEw3/VUd1H9luWMpjIz9aqip6cnGcCmoPZyQn/8YQrYDJjCUDysD1
         i3bXJI7K0jSRvxX6Q25yEW+RHg8iXB66+nY2zM9mv5qBloL7WbpMWntA+2KIQO7BepCS
         BSPYt09C1yh7lMS2HFEineBmTZ62SHJ98ASa1Ct6bChVzJVqgttO4iKH6zAj952Yb8UV
         aYMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780141764; x=1780746564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVI2zXsje2mfxSNn7nO4Zsvfmi4gqcVAuqbDLqZMjWo=;
        b=VFR2xx2u0AjcJ7X3gqdnx8QCSdMPIDBgoQjDwQ+OPIwl4CvlbbrI6t2aUfmdppgTo0
         RJ9o8RTlnh72tqv1SBasKZvbvzW0xUud7qPGMXKw7SlnsS+fqb4NKXPrVQBomxSZ4vNZ
         eX7XVY6qoViMd1IJc3qF15G7UQaA/Wp+iG7gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780141764; x=1780746564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yVI2zXsje2mfxSNn7nO4Zsvfmi4gqcVAuqbDLqZMjWo=;
        b=i9t2EBSSI6cd0/TSpTju8CKdIwdbVWXr3QLvA4NXAj7ioilod5OBZQbUpjqECt9uAM
         g+nFwX5joP9pVCJC+5G0C4legmUqB38oxugU1tDspnYd/bLXx04lWmSwgiW8q9nTIXxo
         tbPoaGxkXaGFlSezKBgLFvofxvOFS05Yixftp5Q7qmHJBsYusm4AlMTndzrRZx9o93Ri
         rkDnxVdfmyxWZJ6VJZZ9BA7Rdigp623P3C7Yjw+bBBXCsalG8838J610egFSjLPPF+no
         DdLU4m+NysahcVuRz3kT7JH1YdbvnLflVKpIr/NAK2tsjE/uDs7Q0Tb9Q8QkbESZUBB8
         m0qg==
X-Forwarded-Encrypted: i=1; AFNElJ+0UvNUrXkocRL7kCwWUj8iSW6FupcBeLV2rrHfF7CDdIFxMedqhUV5mBu5gTyyE04nyhaKFUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc253nQYoa8KbB2s7pzqvetDudxu+u0ToWbn/BeNbBOCPIztOI
	16t1XIWu41rfE50ZjVLvYln6H2vn31R+uEBAzOzPkf32z74TptNrmjM2zqhetUvCxKq1zOLxBGP
	rmValWw90YdjyG3sJrzX6I5/PmIOUbrcfIh89cwPnlZxPu8sTWIiV4g==
X-Gm-Gg: Acq92OFhZlxFWlKi8wvq/iFFjnKVTPMrx8liHu/hPs4eTdQtDAiizFOa4GktlmjAz1O
	TMFVD7CsGwjqytUscZSXA0S/4UbTwwKAyCqf6T79W/4Iz1gFpWIKg19K1ey5rQsFwlydLw+0pbB
	zpU93wTsj6IicWqHXFtPz54UtjUyTVz5iFpMWDGUzPA2N03T3M94lzE07NfEtAETXqtOPo06UQm
	QqB8nylSUHEVpEn3eZZR9lwXqmoQeRRcZtNX4+S2bGa6Wrjncw8vVEazwkOGcOhscMawULPynCt
	8NLlN8zO/UsmBRyy2YA=
X-Received: by 2002:a05:6a20:72aa:b0:39f:a42:924c with SMTP id
 adf61e73a8af0-3b427c63fcfmr3548383637.17.1780141764261; Sat, 30 May 2026
 04:49:24 -0700 (PDT)
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
Date: Sat, 30 May 2026 07:49:13 -0400
X-Gm-Features: AVHnY4LB9RiqqesNBW_dJRYRz8x00rr-AjCs2buufWcIbVojOFR3_F_mHJB0S8o
Message-ID: <CAM0EoMnNTAcWPkkHsc-Y7Yq6WKe+P8ac0kchGHDO5Pb9ZeEp7g@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-293345-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openai.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 65E4460CA3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 7:15=E2=80=AFPM Kyle Zeng <kylebot@openai.com> wrot=
e:
>
> I ran the PoC against Jamal's patch (with inserted mdelay calls)
> multiple times. And I confirm the issue does not reproduce with the
> new patch.
>

Thanks Kyle. I will send the patch shortly.

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

