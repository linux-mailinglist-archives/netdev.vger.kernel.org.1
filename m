Return-Path: <netdev+bounces-291424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAhTMIibFGo0OwcAu9opvQ
	(envelope-from <netdev+bounces-291424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:57:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 678175CDD94
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EDD030058F4
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1B83822AC;
	Mon, 25 May 2026 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpz2uYBd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CBF37D13E
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735427; cv=pass; b=VVq/h2eS4IJyN3hNqylPmHXz5tZ1Dh1U0ruOACLcA8PCL0svCqdqJdoHSQ8Qgrywh/MmSv0VZFHf1oJS5j93uH/vjGmMV3sH96EcVdBphbx5XQIAnZjwl1F2cKIw6KDISJ9gCmGor//4TOmAmjudsXMvGLOetrSFOgFDgoypqjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735427; c=relaxed/simple;
	bh=XRSAh5kaVrEP9O3Q+Tnd8XqIjC0TIqhy118oZx7RfYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIKWrjMHV5GtEI3hBY68pNMLH1cbsiH1BC4gbFe6FS0bzr9PNH1/k2WgDxecJIIQUdMfBIxji+p6q0HfVLeER/usJHpVN8JZ5Gey9dvriLa/rEaag4J1FHET8yKRozT53U14ZXLqWBSkimOOdcNkxTHxhGVWXS+BA/sTJryS/WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zpz2uYBd; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so30465605e9.2
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 11:57:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779735425; cv=none;
        d=google.com; s=arc-20240605;
        b=DDGjLEae7FtjIcvNWYHodoehM5xIWF3ls6R2CctZ+3duoHhlEaeXY7tILXY89nDkVs
         rxUyjFZKrdJFeRM+kA4bn+J+x9JKur+NeqqKDfFY70wINuHRzhDTtOey4neuzwRAwmj6
         o2+4we5hAljOPklvmxbI+fKoHkuF8nflInr/HtGKMLwNo0yuWhKPVFl7fV0KFJt/0JJ4
         57Lk8Jsra1Q1chxxWch1C/yZxBSsU23OFimPDYor8cUmYqxOknwla61rvaouz0UwiXWA
         rJ3PSR/NzWAHJZMdQiDjeHRz1cchfkiXb2MyJ6Vj7kspKA7yP5cTq49aWj8p1Chm43nv
         x++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZUDg9BmpR8ZyuH0bT40ooltRfnMlL+nDk1jBlF5K26w=;
        fh=sM6VuaYsMfjtEnnAeAQ+Jp8Hfetc4IwVoLQFhd4ML/0=;
        b=Kdo59G4qoXE/sl/tQsdL+tOmrfkKDz0fo5NAarRpArmhnP73zDojsYX6YPyTkZme+q
         WANy0+spYealZoUApJuVREJIeRW1AxDy25z9L+7g7k9hsR58BPZk+U5DFveAN5+r5Q3A
         SS6Du/gPQRGS8AYtIVdtpeowo4w+SEphg/NhWootuIQPu5dFKqQZrI2uefEvaMftzBQI
         go7jt6Rdo+K6Dcniy//bUCIHqKQEM+qUYmHKWyAp5B7O9U3/zfov4d0MVXj8CBxldBlv
         +McsxorLW8xAyPgqHJeTi6EJmD5BvhMXYCgUGJKWNii8iXCfjxS86tXBxVq86eZrqPnN
         j9YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779735425; x=1780340225; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUDg9BmpR8ZyuH0bT40ooltRfnMlL+nDk1jBlF5K26w=;
        b=Zpz2uYBdW77WFf75ro1dBZuNifuc1A/2Dw/xwW2AWDrRSCGGNTZf/1wGcBp93yFKR7
         G+v1EQw1gyx3taxvZogCXYr0FCjUyxwWwOKqnMS5HP2/RFKM5UkragIhBtIqCvQc7MQl
         yV5zkHwdieI2Jxf8byIklJK73EEjAruvA0qY52POLJNOb52wo9haLrnHvU0n1cHEoJ9X
         rmGZBoSfWyRM1a/Bz7XJ7krs4FDOF4H4t/VgklpyrxW4dIorqtZDxEjM87mNDuuu7ivd
         BMIBHTmL4iKcdnFoH8ELjQgx5oC58ZiGtr+6ic2dCEN2wzHd+wgcADcU8nftfkRK0VeU
         bQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779735425; x=1780340225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZUDg9BmpR8ZyuH0bT40ooltRfnMlL+nDk1jBlF5K26w=;
        b=MqMpFJzAEIuOGNX4AFoOkDP5B4Cl0dmmghUDqEY6OHAYrBmM1DGLt/QEPLfdfcoqlG
         66+ZiILI4iPWEcF03RJPFCdj8XEKwHTjOfvBX0colt+PQwBQQL3bNhcZTAVtbIPjC6pt
         SpbUrKS/aaMqsi2xb0J3Qk8NyCQ3xsN2jE1jc2VdmOGJ/yvc9/mK8pHZ8IBZmfKnX3U6
         UkBY4gqnR1sePmpDZRnTR1IyybvzUKLC2+BJQaLVE5XXFO466q4x3W5zZ73e1qYa9Ndb
         1D7lzopN1jjDcSGWHfSWq6seriyXGc3hqAONgUvQafgj948HcsasbyyLAJm7+kWwX+nS
         9dOg==
X-Forwarded-Encrypted: i=1; AFNElJ9N0/l0GfwfCR0EXp/vMfkL6fAdem+/dra596uVKD4NehcYZgX0jxHz51MijeSmI9NhTmZ84t8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwy5i/s/Vv9dQKdQartsOLYxZv2/mkMVffC3w3jbLPAUMMH+Yy
	2X/FAgg+wu2Tg322Ii+FSN8FSe8OUHH2nmujFhAgM9kMpk8cmPB16n22WDKNKGFC+GqQSmM9CHW
	eSiCHiDr6xAVqac5efE9mUwFbFBBsp+4=
X-Gm-Gg: Acq92OG+br8xAAcHZv4rip0xQqNt9ESayeCGLsBsUAMyQgfSL0WxW1z25+U868QzG72
	Y+WcVSl+25b6QmEGgB9pTNUr+NmMeoX7zsCImiPW2+XwSALrqgmtcWKDUKsF6JbRVdaYB2oB7VX
	1octhQGp+1S5+MbQEjLZCMfmPEH1KL/C55zAQ1QZfO2a4b5b0T0i5xorbBdj0dVcKJW3UfDFqpC
	tW/XEinDFV4r+BDtd1g/3hA0pfPu8vVMX0pkJo8at/1J3M6cTxkpOAjMrmvm+52OhVVxutDNj5l
	qqB43ridzJLxExjTZzQMQYtvcxtmSpweXvMfz5r2Wo63tblKd1uNJCbtlz0wRh5QfExaQa64HRq
	/q3TvWma0ZeLkpJDetPXj1/Rl7Q==
X-Received: by 2002:a05:600c:4fc1:b0:490:7227:100 with SMTP id
 5b1f17b1804b1-49072aa14b3mr15431835e9.18.1779735424528; Mon, 25 May 2026
 11:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522025854.341647-1-jiayuan.chen@linux.dev> <20260525110303.4121f19b@kernel.org>
In-Reply-To: <20260525110303.4121f19b@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 May 2026 11:56:52 -0700
X-Gm-Features: AVHnY4JhZ--CeC1sfmDhn6orAED0FCr8ggM1y4msArMBO3eZWeUtyax74Fh4ptM
Message-ID: <CAADnVQJ2bjT=dYsBM60H=7BZwSGVupCCBPR7tz2+j_+g7EXXmA@mail.gmail.com>
Subject: Re: [PATCH bpf] net/sched: cls_bpf: prevent unbounded recursion in
 offload rollback
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-291424-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,iogearbox.net,kernel.org,gmail.com,fomichev.me,mojatatu.com,resnulli.us,davemloft.net,google.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 678175CDD94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 22 May 2026 10:58:53 +0800 Jiayuan Chen wrote:
> > -     if (prog && err) {
> > -             cls_bpf_offload_cmd(tp, oldprog, prog, extack);
> > +     if (prog && err && !is_rollback) {
> > +             cls_bpf_offload_cmd(tp, oldprog, prog, extack, true);
> >               return err;
> >       }
>
> Doesn't matter in practice but for code clarity we should only gate
> the call to cls_bpf_offload_cmd() not the entire error path.
>
> With that:
>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>
> I'd take this via -next.

feel free to take it into net-next directly.

