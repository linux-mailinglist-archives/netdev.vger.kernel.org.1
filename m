Return-Path: <netdev+bounces-280192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAU/IG6n52lQ+wEAu9opvQ
	(envelope-from <netdev+bounces-280192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:35:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED32C43D764
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F39F3002F9D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B90364935;
	Tue, 21 Apr 2026 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phoXAwmz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513FC17A305
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788957; cv=pass; b=YSnMLpNeKkZX/mUaED4OvFJ5DjTwm8THd9y7D/qo/nadNpYfRjWEoh0ikc+FYNYVcVvhDKfShb0OmYWGcUZM5E/CyrHlEKXyHgD2Xfl5s054UL1V8WncazqSQ0f2oajbF6yWy7PLHK2NAPyuaIWxa2Di+tu4S69Z898P6APPqH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788957; c=relaxed/simple;
	bh=nCF+1un+lGenxIgZVRGeii/JzzuN9IQd1W11H+yrdes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOtPhXh0DjoEIxQK61/6/ep6ttrkfcTb4XxiU0iF4FQoLBWUrBhnlb3miCPjR9NkOv02l4kSfO+u958DI5HPUsn0k6O/6gI4hHXAbFPk8w6vBuiGQZCqK6uqG7wOsDaobWlp23IPIHGV3SrsBiCuOTN+1xML0waGLm79WbDl1io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=phoXAwmz; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651b4d09141so5906093d50.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 09:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776788955; cv=none;
        d=google.com; s=arc-20240605;
        b=g4Y7pqbV+Edq1oWBVxDd8Pbxo5PggLLhY/2s64+u4nOaVKPHRG6bU3zkfP0pKWdNUD
         S9f64DL7Zm2BxZL7YnUzgAlQ/u9rgRCF7In8NPlcV8mBFdgufmDjTFPVLK6nDoPhrijH
         CF+x82PY4WG1HCk8T71Lhp1eykDbOeAxUh3ppaxetxyH3LtAZQsX5RjFx0LMpZcpjPWe
         +EoGLHuVzTMUqdho3R/C24IpvCoKnQiw26GdAugBI88NkAxn/jEFXnnFccpnLARRsQ21
         qnVEhgHU2km0XbTKaUe8ZNvYH22/YvrLJGwMq/4LFfIf4LFWLZIr32VW6VxOJ7VVdgnD
         gKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xaRQcetDxlzLKskdLR137Weekycfdm7Q7GRuYQIPPqU=;
        fh=Xg0OVk85tnf0jC6dwCKNcY8nXP97BqTlk9DffLqO/b8=;
        b=cP3PT3UKoLsiF8D9IBVHNWdvFM0+050d1tfARZnElgKlGRaZdCUSN/41+sBR/Uhzjn
         bKfHzKsLdNRCNKBnVBpMeKEKOSpXF+9y+0ZsppYGlcHR1BHx74iOGFawYELu2Dh6Z/VC
         sRvoGdgy9xTjsCA7zghwa6CzUBDiIuwNhZqkLFqgJYJBYPq0WyNC9Vpk8YQCjNmckQYi
         /h1pEPAe5AF1ljxX1pvbeARPikQopvU8n5H6dpYk8Vb2Xwv485YBAU/xcimzSltKXvrC
         s0t7iUuA5rEZbSdYIYoLYuw4TLceEs0f1BWnRloqrGzmeURSj7vUs6XN9+GY8Sm7HFDV
         C+oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776788955; x=1777393755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaRQcetDxlzLKskdLR137Weekycfdm7Q7GRuYQIPPqU=;
        b=phoXAwmzYg6qvzarMt49/30aRAa4xLFI836iLr664Z8XCH+KdN5T/3elpa3E86qk97
         MVWjUPx/ccPgBGUewsHw+EOZ/xkSftAtaXqiZiwH4Q/gxhitT7O37WrVgEGekZJiThNC
         BdXVz5WO571o2SvWz0NBaqWjkcViXVOwFIrt3ozAGbiosIlM15uKTW/YWEODYEO69hR9
         WOz7ei+gxidWdtNbF+EfuU4MQSYHq05XmSYmrp65dLtL7uRskO8G27XUCvUQHmofGLAZ
         f9cXpj6Jh4m6ySL3vQbBMIsLaA9PcszH8MODTr5rzBKuhK8hIhoirTveBK0qPBlNtI5c
         XLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776788955; x=1777393755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xaRQcetDxlzLKskdLR137Weekycfdm7Q7GRuYQIPPqU=;
        b=ir5jFxTDM0+6S1c74M9KQbJU93NCcZbDovopXpZ9SJw/e44yazSWy6oJilQURjHCmc
         +dpojh/8xdE5wm+zkp9yZD+5AcI/WNabXYV/Oev23V1w55jPf8Z8V9rc3fO2dMVzpy/7
         hXjSpNkTnR9Rm1ZXXMAtOsPRQ8Psc8h68l4nG6XDeYEmCfzfsnhhQuX7+zIAbux9RYg+
         go7NVEKmcuUKh86Qq34bGs3DogKGyeZN0KYrFr1NUVOl98Yn6YeJJQlDYAYpoyq49cvl
         tmKQ/GqCA0zW1osZmX6hdna3ql7q4BnF9rvTnJTEn4CZ4gIQU9ICIE8fBtAXA08JNhRU
         25mQ==
X-Forwarded-Encrypted: i=1; AFNElJ8cyd+4wbNhPXDhwDOU+7dzKMxG3LV747ApSThflfkI2asaLykSdb5R6ROF4ah9T1T/zkK989I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYKyHoeF7A9dUaZoRG88d+a1VprGGq2VQfef+wi6fLNaLWr7rj
	3MUuWqVSiJ31ukENo4s8lFiVhEkpuHmKGBv/887P6MQOel/Emb480pw/UWxYcr3tqujZAyJ4lNh
	AXT+8YXo2AHphgQ0FwOnauWYTe0d6hxk=
X-Gm-Gg: AeBDieuQTC+aODXLNhtrnCWG5USZ1LA2WhXAWDfGluOWSfheix6xpQl1rSB7uumVKUy
	ZZIxoMwm1M2guc+fkGfKINOPEjplPpKSgBzfusrmUOC4R/oxNz7lIUABDLuUlJGuhMiUan3HnTk
	/37j2GTc8znkFp2GOBMCE1P3DzBh/cnm6WBB/0FaNUV4wjSVT6SYbfSfUyd926mCcmjq7cksbeQ
	u3B5XjOaySh6fapwNBLbBNzU4OOFBoI0zIscrh61xC/wGyejAozWSySbX52HKA7/zDuPQCgAcy4
	E/peygpNy7RHosGWiMS/F7w0
X-Received: by 2002:a05:690e:1914:b0:651:c41c:80ce with SMTP id
 956f58d0204a3-653119894a8mr14903838d50.16.1776788955294; Tue, 21 Apr 2026
 09:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421155024.997077-2-bestswngs@gmail.com> <cc500964d83d95307126b05cc7557309b498bafce0c514fa3f1656dd6413ce71@mail.kernel.org>
In-Reply-To: <cc500964d83d95307126b05cc7557309b498bafce0c514fa3f1656dd6413ce71@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 21 Apr 2026 09:29:03 -0700
X-Gm-Features: AQROBzC0QupDF4QkVKXKjJ8cS1W-C8_sxM8tSkEEgO-pFajTN62MPAl8x7WV48Q
Message-ID: <CAMB2axO5rZP2bzj5X9uDsVZshXoxEXLZt64P0CuEvwGficHfBg@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix NULL pointer dereference in
 bpf_sk_storage_clone and diag paths
To: bot+bpf-ci@kernel.org
Cc: bestswngs@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martin.lau@kernel.org, 
	ast@kernel.org, leon.hwang@linux.dev, kees@kernel.org, wangfushuai@baidu.com, 
	menglong8.dong@gmail.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	xmei5@asu.edu, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280192-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,linux.dev,baidu.com,vger.kernel.org,asu.edu,iogearbox.net,meta.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,bpf-ci];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: ED32C43D764
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 9:24=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > index 14eb7812bda4..b2cd2b0292cb 100644
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/net/core/bpf_sk_storage.c
>
> [ ... ]
>
> > @@ -596,6 +596,8 @@ static int bpf_sk_storage_diag_put_all(struct sock =
*sk, struct sk_buff *skb,
> >       saved_len =3D skb->len;
> >       hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
> >               smap =3D rcu_dereference(SDATA(selem)->smap);
> > +             if (!smap)
> > +                     continue;
> >               diag_size +=3D nla_value_size(smap->map.value_size);
> >
> >               if (nla_stgs && diag_get(SDATA(selem), skb))
>
> Martin KaFai Lau pointed out in the v1 review that the NULL check for
> smap doesn't fully address the race condition. The issue is that
> diag_get() will re-dereference sdata->smap independently:
>
> net/core/bpf_sk_storage.c:diag_get() {
>     ...
>     smap =3D rcu_dereference(sdata->smap);
>     ...
> }
>
> Between the NULL check above and the call to diag_get(), smap could
> become NULL again, leading to the same race condition.
>
> Martin suggested passing smap as a parameter to diag_get() to avoid
> the second dereference. This would ensure diag_get() uses the same
> smap pointer that was already checked.
>
> Could the fix be updated to pass smap to diag_get() as Martin
> suggested?
>
> Reference: https://lore.kernel.org/bpf/2026420182243.zAiN.martin.lau@linu=
x.dev/
>

CI is right. Please pass smap to diag_get() as Martin suggested. It
will be the caller's responsibility to do rcu_dereference() and
null-check it. Note that there are more than one caller to diag_get().

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/247325=
81685

