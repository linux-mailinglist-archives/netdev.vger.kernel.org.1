Return-Path: <netdev+bounces-288356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPI9JjNMB2opxQIAu9opvQ
	(envelope-from <netdev+bounces-288356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:39:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B91553ABC
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C793D3060F20
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2E43F58FC;
	Fri, 15 May 2026 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAlYK5Ku"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1250A355049
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861609; cv=pass; b=SWQyEjzbAOPsz32OZviJ6AyCA68RvdInOzTWUBcWTeUvOtvA7C2aloLmSZEjILWzL1ZGmEr+b2uq9v9LeVIySdPgrk/li55HXx85wF8k8CN/lnlEuwqjPuoBpFeUnedOW1a6sTuE5MKKFMQErneE0tR2bZ4U9eErmRXxXlc2tHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861609; c=relaxed/simple;
	bh=zR1yYc9OM8/abzeKbNBLcU2waXyUwdgxJgy2JNeeQrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rkD3T8cDHVn9x2xszhxlaVt9FSSttEzMd/8KcbWqBCDzcK0BVX69kSkI2bbQrOuaYaH/d4WPRE2QhLOs8ExBtfdo7OdWHUcme6uz6vcGGZBEWgNjuG4M9RReSga3qL0vPRLqOz/NUv2/kY/aILsC/sB4l0mILgm72LjyJldR+e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAlYK5Ku; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-67cac5ece75so15573830a12.2
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 09:13:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778861606; cv=none;
        d=google.com; s=arc-20240605;
        b=F1KzPPdXxkw1yKWdiG+Ci1J6W6wFV8QsMqJn8l5D5GASu22izYYTxo6C3MWR2OBToU
         E7r7wz8pvtzEo3WMaJUEgC5MzK4b6MhZRoQjCQQC7mEuNoP22ZwBW3haP91zad88pExW
         OE3nagGVziONADFVLU71vULbTZGTpZ8ZunWPVWUf6E5X7z7zqJZADKZW5XNLyXuaFRJ9
         sFU/rGg+4lqiSS95ren5+FcJ9aazkIPbf1zgV5TOwr6y8S1mIfpJrMofVbMMh9xbQ2Ag
         FVxivVBL+Ja7S7ON+NEXqaslYajBWtROJwQOvXptaDQTSBMh+tMg5HGjn0+0wPo3Cz6E
         Ga8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RdcWSBi36KnefYlCpM3Langpu7uSIZQhoWSIjSgZsAs=;
        fh=1fVcP6baE8cLHYLAMeiXOiVr6cdi/kwDuEYeaojmXWM=;
        b=fbT5CjkAeg/dl8CndOFQHU3HiMVAEWgmZBv/UB7RWFSq4YLs8BUtwVp4brL55BDZH/
         ueRzKrZcNHtEZob0axYEqY8awC0cXgd0XQQatWdK5NihXSXdAgh50JRYKNlk4ji/itYM
         ew4rn5l01w1y7VRCH1/Nw5MfbyqisN58rxUMOiFztyJpZn/kUxzl+8co+xGdaLwq9/hC
         ejG/4Qvzpil6Rq1aFBm+LqG+Im+gjQ7Bir98flArSvGAtuoSujgyyDX8s9IkvWPLji1Q
         7ohHqBDwWt6RlvExkJUDUuvKu+HS0CS4veR1/M8NWjMywpPfGzt1ZO6yEYAGof4XQNYy
         c8cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861606; x=1779466406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdcWSBi36KnefYlCpM3Langpu7uSIZQhoWSIjSgZsAs=;
        b=aAlYK5KuUM7wYoFNKdy8WyjLHt/suDkMJJA+KotAxncEydrn6WgtWDlHLjOGdhSafp
         LjJFhFic15WqS2MCaIijewIv00VLOcqFURiVirsFot0/ra9kxwyuDFdxHQvhsc3RaoCb
         hzRkE9Zl7yrs4DZGZMsNJ0HoAzEKSvZrHouyjEmSSrcfzPqBCxfFMa23YkuJw51HpUAr
         LaxhQzK8m8sS8eJgKFSNaZA62moNhzrPjEwAQpBe2ZV7vSLdjAHura42lMlyCcKYv441
         3UXlm6Kzh1v13tQV9+h3vtYHRHw5MCjC7S/6pUE1WjlkMihbknFVnbKUb91WIgz3DCK3
         hDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861606; x=1779466406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RdcWSBi36KnefYlCpM3Langpu7uSIZQhoWSIjSgZsAs=;
        b=m2L/CdsPD2YQXfTaWooA2DMFTx+i6cswnZLcCF+Az1ITIMd2E7CEeq30C5gVGgRp9e
         uJ52zVyLJV+DRXOQqlkqCKE0kJ3Rw91Rkj2tGX/8wuyTKBsI+LRUAcWkjfzqvvJVWdwi
         pTQxkec+JuJXNEdRTM58zmULTin2ftCz27ouTy7bMesLGLlD1UoH7a0t7trtZfqB5dYh
         v/5fNDu3qNtG0mwIbeel6DIlbzBdJ97cROZeK/q/aUlMUHtLXR2LfW6FxD1rykjrxpWB
         z6Hm97y3Jr/FPtawCWk6+7YmCyQKQclPwp23aPEQzZWB5rpNiFjRvVZutfr1/9DY9F0N
         TIzg==
X-Forwarded-Encrypted: i=1; AFNElJ+qjoM00TBuTmhfhU9K17Di2DnETbeuKuQ6qE2CgPcFRFYnODw1K7Gx0KtfKNQPNSgNTv18pzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCOh3inFeP2RSZmSghfCY29iyA5FSfXn9cIBPuYfCAugUpI4g7
	Qrhd+w2YUyDfzMO3uptcWi0PhNM69BMll5YNA6XGmSDjRghgQ1HbYI2ZGxwyOgjhsrR9oJdWniS
	cLA+kzcS2G3GeTOVUGjp2r2jCvliZkJM=
X-Gm-Gg: Acq92OGlbsDjm8dA+4i6rvKUjKSgs3sTl/guX38izK3decxL+k8aa9v3edXe1wNOVcO
	a2wmMOSHaFXH2j400C0M0HaET6S7pRw8bethlDODU+OAb4WGB3O/PbXVEvALHcWAP12yrY0Jbiy
	WW14QgMNg8yx3bwBtvHJFiBmO2A70Ohu+YEeExUlg70Z04yviyKwLbPmyBrDLEoKV8Ar2aurvwP
	h1JmLI+1WbyBJkuW/vjIBSsa3PkdwprD27XJumHhkBatEA2ZI6YGzndM5WdjXv+3jtqP14I4eaH
	Xu3QDSZ2f9F8PR+MpbbBAra5//GcKu6D4F1WUbJMAcrGw/NHTqNbFjWd+CDBRVKN5UAF0/Exngc
	4KrGR4SbhmE4XjFVl0CYWg23YzgLFuKMA0xEO
X-Received: by 2002:a17:907:2d13:b0:bd5:2c3c:616a with SMTP id
 a640c23a62f3a-bd52c3c6261mr97395666b.37.1778861606050; Fri, 15 May 2026
 09:13:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515113102.2389020-1-arnd@kernel.org> <CAADnVQLYitAZVpXCTygA1uAUtN6m8pMkWzFi9su719M=nktmQQ@mail.gmail.com>
 <b387dd31-0ee5-41b9-b07a-13b718080e89@app.fastmail.com>
In-Reply-To: <b387dd31-0ee5-41b9-b07a-13b718080e89@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 15 May 2026 09:13:13 -0700
X-Gm-Features: AVHnY4LIZBVCqMg1hBQMiFvFAmVKWiP3lskvoyscc1J20sfPKogHZR-c06VLQak
Message-ID: <CAADnVQLa4KbzSHs-5NdabqKhXAYLx+JGei52gKNEv9ww+Q+Bbw@mail.gmail.com>
Subject: Re: [PATCH] bpf: test_run: reduce kernel stack usage
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <kafai@fb.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, bpf <bpf@vger.kernel.org>, 
	Netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 35B91553ABC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288356-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,fb.com,linux.dev,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,arndb.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 8:16=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Fri, May 15, 2026, at 16:47, Alexei Starovoitov wrote:
> > On Fri, May 15, 2026 at 4:31=E2=80=AFAM Arnd Bergmann <arnd@kernel.org>=
 wrote:
> >
> > 1k?
> > pahole -C xdp_test_data
> > /* size: 192, cachelines: 3, members: 9 */
> > /* sum members: 120, holes: 1, sum holes: 56 */
> > /* padding: 16 */
> > /* paddings: 1, sum paddings: 36 */
> >
> > what s390 doing to make it huge?
>
> I think it's a combination of cacheline alignment (256 byte
> lines) that leads to padding before 'rxq' and at the end of
> xdp_test_data, as well as CONFIG_KASAN_STACK that increases
> the stack usage further.
>
> > Probably better to rearrange the field and fix the root cause.
>
> It looks like this change reduces the stack usage by 256
> bytes, and keeps it under the warning limit for all the
> configurations I was testing:
>
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -98,8 +98,8 @@ struct xdp_page_head {
>  };
>
>  struct xdp_test_data {
> -       struct xdp_buff *orig_ctx;
>         struct xdp_rxq_info rxq;
> +       struct xdp_buff *orig_ctx;
>         struct net_device *dev;
>         struct page_pool *pp;
>         struct xdp_frame **frames;

yeah. this is much better.

> Another alternative would be to allocate xdp_test_data statically
> instead of on the stack.

iirc test_run can execute it in parallel, so static won't work.

