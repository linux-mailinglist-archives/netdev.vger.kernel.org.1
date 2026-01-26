Return-Path: <netdev+bounces-253466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iItJL3Vdd2n8eQEAu9opvQ
	(envelope-from <netdev+bounces-253466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:26:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A29882AA
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62DDC301484F
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C973358D3;
	Mon, 26 Jan 2026 12:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOr04dty"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644903358A6
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430386; cv=pass; b=stre4Q7ir+8UbGVmFjW7RAEfG8JO/2rxpGloLY4T4DFbMYzDZy+V2Y7dCSjqY/l9l35v7SzxtnbxPPX/CUS8gy8Kny8PKDmKu7Ca5BLqZB7hearJ7pxunBhSh3mZoWpFDrR9YWOJJWo6w+FwndXnAv/M4Xa2vLobeJzJQZvIgRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430386; c=relaxed/simple;
	bh=vPCZu31gxLfRaeY7YQxgNiP/GuzXwU0aaq6khzdHMjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZJ6UHXSrGZrNY50a69BRcUdyQ7lWdlJruPH/+uOfoybbbMMkdEt3KxGAXF9cC7BXkvW4e4pSYEOT11HJDDPqVW6R3slmtn/0ujoCoeUdDdky5YcWwipzSZZa9fNaTiO36rLkKnbSPSb7OQPTkz0WPtH0ffpdZyl/22PJP1W+VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOr04dty; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-894723da7dfso71890936d6.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 04:26:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769430383; cv=none;
        d=google.com; s=arc-20240605;
        b=UEzbHabw3QGnf+iMjgaoZ0tIMXZ7+AFW72G/oTp6Q82+3AJyX3Szz11bvNmMdK/mVc
         bKzyWSxueK2LYwglsWMyFGdysLJraCBHAjbPP9OsRo+F7K/mvrByxWdTcfRuMkQ+02lB
         +QQMimhLH0cMkIh9hXGlsy4uRXh1z7vA2J4pSVSucw0XAvxn3TNhLY8Tfko6hc+0z3kG
         Oyjg5z6jEZijFe8qNKXVejtD9dTLVZbF8K+wPnnIdYDSYj55MGH9T8Cx2+j6Pab1vGfH
         k0KSQ/N2t4o8mFWryxvqQ0FcN5OoROZGOxLBYoGpz+UKk36ihrMbqth3B1EZR/W4EguT
         GKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BQR5xxlaPiBFDty3dHak2wCiTHJHX4MEnx5OyreGB1k=;
        fh=vo3Il5wHTuJZwrMqyd25qqpESAoJmfKVgBrDbXThYSI=;
        b=M6nMMjJPET3zB2tBW5bnkmUplmxVvz1hAQYHTIGMa6xgpT55f24+W+l9uSJEjgTYGR
         IvEaH5ZU43rxKCENVNujfp1o1PnI2GESqm/cdzqM7guEkHvUTn56RumAxhbPf+C4woWn
         ZMMbaBty+E3D2KnX5OeBunzq6wk1xGzZ2lgt1ycp+s48V+Xd/+7G6SplV/UUmNV4a0PU
         lsxoyOqGSB8z5SxyDVPXATBSQDcpgopnXRi15jMrpKl/4DFBNyK5VU+RRXezx/SPQj7U
         im+dM8MpefLoHR6LNk5ewctxBCdhZYNl2niCZNJFEyH6SKgI1PwNAMh0P3ilZSxUfd4U
         LHNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769430383; x=1770035183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQR5xxlaPiBFDty3dHak2wCiTHJHX4MEnx5OyreGB1k=;
        b=MOr04dtyfv1Zp3nhw24YzWG7ABxDremBoErKo6ZplFU2zPggccQO4PzvoJGxOhI/Jl
         HQLACN5xSdo/ImjxkTvzkF1d7NWVZj6ObWpsYT0uR6fEybxxGtUSS08pupCshWlGuzA/
         i0eIrFivcY/Z1bc/mYb07OkxA8sKyjqYcfDQp2oCFk+2v6XAtHafO+csYwYBIe5n57ty
         HUSmF+w3SZ6tzRopt+huY6NnyK+Xm/cFCb2uRgfHECHeK0OmbqMBQ34DOUT/bCjjKY5j
         +kNALa9pzH0zlDlNZy5pMlaJjTgW3wmJtfInPrq4Ms5ay02OZO66rNkwaqPYmt8cbVdd
         BywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769430383; x=1770035183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQR5xxlaPiBFDty3dHak2wCiTHJHX4MEnx5OyreGB1k=;
        b=VuCbspxosvKvMsD5a0g96bXhLvFeheB19qRy8nnUM3K14nulM68oG4Z3mqFcvXRotz
         xbOC0Q+QUTDovkb037aM9p2DhVi9W3m9q1cZZn9JdBTsfHkzs4f5s5wuOO+z+iBgJhT5
         Zp66T8FGe4bA9QypX8KrKdf3CtM4fA1xZEcBZvbSGE2kVsOuMal354buxnnBqZDRfCPg
         JNKKxw18uJNTn381sIcLMtfjG1OqEkoBd8zVCPw7KUeYy/HxS3fO0owv/cElZORjf5Jz
         H3fKReudVxJ3L1n6jFYL2pwm2XxOtpdplbBvgQgk+tz1Ds3MtUGldhKbTqGdGDs4QoXt
         J1TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLihPRV4f2HYeKJe+layjBFd3YjR0cyT/PSez+kaDxrpt7A3Zp4fw/438+ltB3U8ynxduUI8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj1BbTEMYNYgITNn9emlollv/tpIg/YDAxWw44plr5/sjEXwWR
	WlwJ3cRGnC0yqUBQwtaJrfaesc1o8zknoud7IAozycDPl8txEGI5xyKgqm6Yn0C8x17pP5U2jdp
	reB3/ahSI43sC16SChVLFs05muXF8xNdLcqL3wWja
X-Gm-Gg: AZuq6aIA9wfRGNqP2HbAPPX/kifdrsalppFoNCU6SHYjNFXNn+C3PcxfIp2UlOMMkLV
	gi/8fBXND2b1K5vBISpVO5AIVSgj+0Cw/IZJGS0QRLjLfWX3SzWWsbBw9/MBkXpnnmhYX9lcih7
	VQQhY5CFaGv4dKH1TroyDOjxxrsR6qLPICoilOd88haUksoQ5kJ+a7EhQQZUIHt/BvVeyisUsAK
	Dy9bppzF2DxGmhKSOjxd/2o6zMx9tHlWVas6jD6DC36WE6hL1tf3pBvEswv7joEKwqEgA==
X-Received: by 2002:a05:6214:20ca:b0:880:3ce2:65ad with SMTP id
 6a1803df08f44-894b075ebb8mr53564136d6.41.1769430382887; Mon, 26 Jan 2026
 04:26:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGfirfeHMgBUq-Q8tCn8dr2tHVJdQtZbS0JMutqF+b04T3EoWw@mail.gmail.com>
 <CAGfirfc70aJ7YUa02ObbxPfkH1u6B=BPZpUXDAg2FU16aKvL1Q@mail.gmail.com>
 <CANn89iJrXSHouF4ZnnoVYz4Q47J5jkwU4OuXMpJi3Orox4uT_Q@mail.gmail.com>
 <CANn89iJvj8YXtuMNTh1cQOjVctBsMs88FHx-xLn+rCzyBGn-og@mail.gmail.com> <CAGfirfebdHJi13epyM5RWYfQ2TGSWExP5nmnoKra83awetAbLQ@mail.gmail.com>
In-Reply-To: <CAGfirfebdHJi13epyM5RWYfQ2TGSWExP5nmnoKra83awetAbLQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jan 2026 13:26:11 +0100
X-Gm-Features: AZwV_QgiWGm59mk0ei6HnIkVkYgAcOxBiqQElEceFpCpuVrl3oQIO1cRxuadLxE
Message-ID: <CANn89iLhXQ0W7+rOQCqxLpGyoHBAJ_xeUhjL+7MtQmN2saaYog@mail.gmail.com>
Subject: Re: [BUG] KASAN: slab-use-after-free Read in u32_classify
To: =?UTF-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>
Cc: davem@davemloft.net, Jamal Hadi Salim <jhs@mojatatu.com>, jiri@resnulli.us, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	xiyou.wangcong@gmail.com, horms@kernel.org, syzkaller@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253466-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,mojatatu.com,resnulli.us,kernel.org,vger.kernel.org,redhat.com,gmail.com,googlegroups.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 38A29882AA
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 1:11=E2=80=AFPM =EA=B9=80=EA=B0=95=EB=AF=BC <km.kim=
1503@gmail.com> wrote:
>
> I propose the following patch and would appreciate your review.
>
> hoff is used as an offset argument to skb_header_pointer() in
> u32_classify(), and negative values can cause out-of-bounds read. As
> shown in the code below, offoff follows the same pattern and requires
> the same validation.
> ```
> TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *skb,
>    const struct tcf_proto *tp,
>    struct tcf_result *res)
> {
> ...
> if (n) {
> ...
> if (n->sel.flags & (TC_U32_OFFSET | TC_U32_VAROFFSET)) {
> off2 =3D n->sel.off + 3;
> if (n->sel.flags & TC_U32_VAROFFSET) {
> __be16 *data, hdata;
>
> data =3D skb_header_pointer(skb,
>   off + n->sel.offoff,
>   2, &hdata);
> if (!data)
> goto out;
> off2 +=3D ntohs(n->sel.offmask & *data) >>
> n->sel.offshift;
> }
> off2 &=3D ~3;
> }
> ...
> }
> ...
> }
> ```
> Therefore, I propose a patch that rejects negative hoff and offoff
> values during u32 classifier configuration.
>
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -1104,6 +1104,11 @@ static int u32_change(struct net *net, struct
> sk_buff *in_skb,
>   err =3D -EINVAL;
>   goto erridr;
>   }
> +
> + if (s->hoff < 0 || s->offoff < 0) {
> + err =3D -EINVAL;
> + goto erridr;
> + }
>

Negative values are valid, it is ok to access data between skb->head
and skb->data.

