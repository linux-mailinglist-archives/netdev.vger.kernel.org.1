Return-Path: <netdev+bounces-282198-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCiXKKNm8WlfggEAu9opvQ
	(envelope-from <netdev+bounces-282198-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:02:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD3848E36D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 005573012205
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54BD361DA2;
	Wed, 29 Apr 2026 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lliWcAj2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C637AA7D
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777428119; cv=pass; b=X6K4wT3GmUIAeXhwqRPhkgmhMKeobNLJdz0EfbW/h8iiILjcTa4h61bhAKokf6lWzTBzVvpNLRbPcLqjJQ8VJTKiA+EmjM6iHuX/BvgqnzfADUP761uKSJJsDLd4zUo2KGMgL2uKx/K1X/3SDwXcRw8B7+aStSLwfEyWL+MocZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777428119; c=relaxed/simple;
	bh=gzUNhxZ3fhsVHj081BKhGFEpLe3M9C3PO0A0qmW6Peg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRAxRUqtegUWFVYdkQ224CL12rmqb6yB4xu7i76zmTdkxTp2rwaFgIZ6EOsqIXEwLxV5akgWVfQdQX+cpwxpGC9SV8eJaxRCNEwfjDAWNkvXad4wFO5YgXXPpH/lTV043JZVrzvfpLzUYz6QIHQJP7PClEBSGAwVnGWQ/DqMntM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lliWcAj2; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79ee5037d44so7044217b3.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 19:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777428117; cv=none;
        d=google.com; s=arc-20240605;
        b=kYZeo1JpHz5DVVOtng6mIABGM97oHqiil7bZuwLaSX86vtFGLZbA4pl4+CsVmOX/fi
         OK5pAroRirNdaqQ93NUZV9qU8nN+KSsxSi23vX21UDgbh4v1GyTqif/sxomEoQE8TfTG
         Rz9dlnPkQ/sz+YbWduoS2rxX/ysS1xXf0dYr6F0Lm0nSajLQ1wOBDtGOYWpyoOHHmnEF
         ObbtxARVUl31PX78FEV4PfKAld87HWLD0Ko+OY2hPsgKHsgtOEAVjaK/v38Z5quBE0Df
         WXnJXf58C5A3aa2cpJXH1DIsAcbfT+AJr6C0CnsA8xIEmI4PETLS6BSVhFPJiKJ4rL5S
         zE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WhiOa3S5gTJr0LR+yeY23Dq+ec8CEArjxBM7MxSqTIk=;
        fh=/oJC8t2ettZwBQ7QFkm8C8JZjLICBs8DBgneV2yA05U=;
        b=NaNk9Uve5jlapHc6WTdNccIARSDPwWIF8xhWprsyuKfuoYAv4bp9jtwgf7FAYsgk8A
         cEilOC43c8ZBc9whxw7Ve8SQKDHmxaEqVog/QHyuNa6UHvplBxup9+44WvPCXPp94WK8
         /eykE20js4+Z9Qcvypl7CsaWnT/3dxsR9UeXvdUO28aW/tF+wY8z6uasocbgnQRzjPEP
         iOaC24/9YE4++gBRQ91fi694dDMgqag1I33Dk534FHf9Cg03XEsUE9GMm+lrqLJl5Tnl
         XceYrC8/m3eovz4Lkiy9I9r9J9JC76BEn/XZag/D7t/Fa87yT/53nx89RwUwShXUl/6A
         rnJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777428117; x=1778032917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhiOa3S5gTJr0LR+yeY23Dq+ec8CEArjxBM7MxSqTIk=;
        b=lliWcAj24Q9X0ySjWB5gq5M6BnTVRpRtAhsYXsQp6nChWjlCXpH994cp/TM3kVHOcy
         7tF/fEjyy7BPSX8iBO2hd01fseo1r/ETIoxh+zWqlTMEpkMgT9JXSH9kk3c3O0CpNBLs
         PApVW2m7QLjuTqicsxmBtRkDxb5ZNnq08gKxQQ36XXOO3eu3EDTwXpL2loSQkkw+amSh
         42r8MBHwo/9YxrOG+jTCUzw+2oHWMS2Y/Cdz3IGYM0ygGgl0by6FiO7rfYuQVewlJClB
         rwOap1E6DpbabbenZVFrtSfWjDpnyHWGh5tpL2MJ+z74jZsJLBcTVMBSGxM/+ljNBkCw
         W2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777428117; x=1778032917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WhiOa3S5gTJr0LR+yeY23Dq+ec8CEArjxBM7MxSqTIk=;
        b=AkzGjY/Oo1Iu2idu2G9YziO4csKK01qip0FsJ58m08ONCPn4N8eNr2IpRHwmOdEWJU
         kdrfywMxuSeLt3FZYNeO2M+kDYJzys0hLPKXM6o1x8GY1kY0kIRXLHQeU6PXqmt3/Uo9
         Yzy/8PCI5r5G60ps3MIpaOFTUIFF1IRe+d7HHalDTK0IWjChx+ICJplUiwbRVA9CXif0
         Mm/oWAicmCEJO6nZziNLHZU1HsmFkBO4YVsxH961rbRuPRAcQSBqyTUXHwsqLEJ2fc5S
         7WuffLQxjLMqzMahAEAZvDnQa09E3gePYzTJc5CG0k5yokUfvlLe4dt+hTAzADrhHiDg
         SW2w==
X-Gm-Message-State: AOJu0YwUh8gK3eBdBiyXm1fz/vf/MovnzHFpf5cWwt7ME0vMBmqhCopc
	Bi7sC+bn05nH111FQ+vDo4dBOL8L4CeQA136x2JNcMw6Iw+zolEkArIrAKvpFZKugvS0JMO7/Py
	N5b+x/i7FG1NmgBJz7WPj6f0KV6/sAKo=
X-Gm-Gg: AeBDievtp3+ZF202cCcH71QVQ72FvnMb07ACkQ51NgF+c2+kYH5fo3+p63Cc75a/t6S
	0973jLxtgte2q2AOgv+GBfmazVF68j1aty6si6XrT3iz0TJqHSgFqd5JgFD8gV4yIjYesRjmPxS
	OSP58mutV7L5Ut8I1ikQxBRl7vtlYdoyc+PIoRgVzkkaYkDzW46wXayFEEWiUypBqtcSg/ODEqd
	PzLn21aGFZgeqzuK5uyBbbwCYv7yoDOHb+EQQSIbF36jC2PwLo4ZOFd/TraJEkjhO9LXPnMGkJS
	tNveACOV8mXZQ0DWoR5NBZvy2SBxuNKLN0SZ1B+ASxMuDpx4EZo99MEDOn5HKjj4MFfq8LvVpby
	gQL6MGS4=
X-Received: by 2002:a05:690c:6610:b0:7ba:ff4b:553e with SMTP id
 00721157ae682-7bd23d468bbmr10495807b3.8.1777428112698; Tue, 28 Apr 2026
 19:01:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414020947.65905-1-kartikey406@gmail.com>
In-Reply-To: <20260414020947.65905-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 29 Apr 2026 07:31:40 +0530
X-Gm-Features: AVHnY4K1dTlwHvFNyxRAmA8eoedys5dPDggZK8_JRPj9HAqQmEbRIFf8AGQP_dM
Message-ID: <CADhLXY7C8SAw1SehHmko6JpCqGXCDindcsDbVi0EBsbcsHbW_A@mail.gmail.com>
Subject: Re: [PATCH ipsec-next v3] xfrm: cleanup error path in xfrm_add_policy()
To: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6BD3848E36D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282198-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 14, 2026 at 7:39=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> Replace the open-coded manual cleanup in the error path of
> xfrm_add_policy() with xfrm_policy_destroy(), which already
> handles all the necessary cleanup internally. This is consistent
> with how xfrm_policy_construct() handles its own error paths.
>
> The walk.dead flag must be set before calling xfrm_policy_destroy()
> as required by BUG_ON(!policy->walk.dead).
>
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v3:
>   - Changed prefix to ipsec-next as this is a cleanup
>   - Dropped syzbot references as suggested by Sabrina Dubroca
> v2:
>   - Reworded commit message to reflect cleanup rather than bugfix
>     as suggested by Sabrina Dubroca
>   - Removed incorrect Fixes: and Closes: tags
>   - Corrected subject prefix to PATCH ipsec
> ---
>  net/xfrm/xfrm_user.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index d56450f61669..ae144d1e4a65 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -2267,9 +2267,8 @@ static int xfrm_add_policy(struct sk_buff *skb, str=
uct nlmsghdr *nlh,
>
>         if (err) {
>                 xfrm_dev_policy_delete(xp);
> -               xfrm_dev_policy_free(xp);
> -               security_xfrm_policy_free(xp->security);
> -               kfree(xp);
> +               xp->walk.dead =3D 1;
> +               xfrm_policy_destroy(xp);
>                 return err;
>         }
>
> --
> 2.43.0
>
Gentle ping on this patch . Please let me know the status of this patch.
If anything is required from my side

Thanks

