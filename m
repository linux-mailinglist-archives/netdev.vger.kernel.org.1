Return-Path: <netdev+bounces-279086-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OBrKkMF4WkuogAAu9opvQ
	(envelope-from <netdev+bounces-279086-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:50:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B864113AB
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 17:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9EAE30251A5
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16ED274B37;
	Thu, 16 Apr 2026 15:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjENUUmO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8821419D093
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354623; cv=pass; b=pJu1Lu0vwxI+ujw3qw959nUOgRbuQdlhC0XpqKSOSfoXIK1K1/WUBBOO+uCpOhRgfHmmCPADnYZ1M80TgmB6Jk3abCXWAh47xDRyN+Ki1ItAiASBjbj0qsVot8r8wLBUKhAxn5xr2gMDd1QIRPDutAVyK8/IFsbZigBZcN3LygU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354623; c=relaxed/simple;
	bh=cj9y8wYErxUXR8Wk4lHjJhFXX4qW4UHdcZmQEcLql4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WuyCbsp1elUcvy41Hm40YS2oKKdvMBsCA2gF94g79prANlpJ3GoGN5/XG94UEGA+PDwLQ1AGVSvFYKR2Q28kMCa3XvmsmpRqFLca/Bh5P/v2vPa3U/paun/L74b0z+aMdog8gQPFHM+4O//ivhJZEdXaBfAggSl0CjZKH8tFoP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjENUUmO; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dbbe726c8fso990554a34.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:50:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776354621; cv=none;
        d=google.com; s=arc-20240605;
        b=b+6kdJ3ze/HtWrllYX5GLMnNWjqED7sC2y0F5GPPiowEmRoqCXZAiJilNSAPYcEcxK
         UBkilXSyoafU3Hpj5Yi3zwsECjz6wWndBgqCZCXqyLwEmL/5QYa7+9mq1xgxN24e3Ter
         chVH/ItpsC75vO7BA/XwAIOr/Jsv7k3usVGBN+hbSK+4runlEf71Mn3/iiub9B9i9nEN
         NSuRCMoRkblNOsd/8OlEmmT9Bc9JKM7+Ib3kv6B+mrPnZr9lLYjfUUUTqV2PSd3W+L1L
         rGLiYCB7+P7qUmCYB4Wih6JtE21BveNQbSE85AGtRUCqu7/unmsDrFGQJL0ON3ZpQe7J
         WyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ad/Cu4uRbEKvepgBt9xYrbQZAhl16aA9n6Nbb/sU6oQ=;
        fh=h8JSi214CggotktuzEst9ijuHrMAI0LoQ4aepkxzokU=;
        b=PTz7UT83u9fuCiFblZagjmosULHXWXNKQ29ufZBjxaAtMEVMw64VnvkuhNbawLh35M
         cEoaG1EYNgiDtLnZJzzWGuJdDisNa9XR+yHN3M7v58rV2E0hfDdaH8Ywa4gFP0LjgZyt
         ZXhVjebOnyArbqxqIEpdMIaLc3pPXtsTQjI/h/twx5FlOfkDWArqW6rU3oCWn1ncGZSc
         zu8Gbt0N7u5q4nF+zhnAsEuBTJm2h1AestEv8xKCHsFuXREzCig2W5rsFvQHBft90RhY
         vO3aLaOXS3OMXh117KMHBb8CcrHTPA5DAr/a+aO0LCQEybLcszoHZWGI1ejuVonitFmO
         WW8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776354621; x=1776959421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad/Cu4uRbEKvepgBt9xYrbQZAhl16aA9n6Nbb/sU6oQ=;
        b=kjENUUmOdwcmxxMOSuBZS0FzgCJL0V+xDofRQJNnj1wpYQfL/Y3DDe9cRJy8RtgiDW
         qpTa5eqH7dl9vU6v9ThQFa4zA19/DI4S6cjDlvxUEFzTBCOYq2uwKn2eIzFdfeOT5jst
         VCa4patbS3I6nGSEsAG7blLBEe5BT9Mbi+uSc173uFSEtfpI6sdnBTCFLYtpR+y1PB0A
         c5zW9xFswIEdTQaq3Xj6PPHcG89DfY+hFOkmxa5IwZRL4aCmA/ELRFCq8vAT3E1QfXqh
         JFAFGVuw/ZxMQ+A8d7qWEIM+Z8h8Ft9cuQNeEX4+Moz6EdsKvQNmGnkn/2rWaFrehieG
         ewAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776354621; x=1776959421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ad/Cu4uRbEKvepgBt9xYrbQZAhl16aA9n6Nbb/sU6oQ=;
        b=PUcMrNhtaZa/HPZhvtubhsPiKVsLEMlSOgPTuxrYUVzH1LJ++EyXUvCAF/2RC6FLph
         D3JRNz/yHM79XlNLD+eCVO9vYKydRKl4ln4FyO/vwHusvetgc8zm5YU5ApePFzNNAJ6F
         F8fA5S8WmRuPehvoqXC5L/YLh8Eac/Bp5MGrKiMHUXQILQHB6C7Ndi3CNc8OoPkrMUj4
         nGDAmEX/VsQ7RLQxsYy9/FolLnz/T0+aciz0hIBUPQQ5UCp+nkUNak3VrpB3lo0zXgPe
         A4v4csRRE2wpOEr5972kdcRdfmzd+/tACKgtGdaCijmLQgQbEaQ+xod/uGSb+3ebVCPi
         pfbw==
X-Gm-Message-State: AOJu0YwAbv5OTmAx2FmYyvXm8KrtHYANWIQDgD0dk0XuiCnsebLf5Noz
	B+Cks5GcSms6UuvAqTs582gsmZ0bH1vZV2ZhHdsJAhOED1vWEKpvGYGIADAGpIucIlCZ2eDn6Mh
	t36EaEETTDGk8I0CFVmX9Przn6ciMsAI=
X-Gm-Gg: AeBDies+ar1dZK2+vLbRfX01wD3/YMaoPUr2XnWemeY9ddDVABJRIi93GPpxCxDgsIB
	7odlDBstvLq/EkHuSUhcDUYO0I7fdjsdwxBDoOUgOh3GrZN9fD6SV/R0vMmR0LxN9H9tc9xacUy
	ZQkeTmbxrpVX1qdUv7vJsNlDdyfR4kd8pjHj6UHDHv15Lt35GYhA4XIzHIZKWxx1lkGtVPWS/a7
	XhCfE8Y4VdMs3fayHUrH+HOT/dp0E+i3KugTXgEzrx8ZKNh/jzr7iPZgwkxb0Liq1Ouy+Cb8uHk
	uRJFFvQNO/ahE0jp
X-Received: by 2002:a05:6808:220d:b0:46e:c1cd:865b with SMTP id
 5614622812f47-47978b78765mr2170677b6e.2.1776354621365; Thu, 16 Apr 2026
 08:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408231415.522691-1-weibunny.kernel@gmail.com>
 <20260408231415.522691-4-weibunny.kernel@gmail.com> <cb5bf340-e5fa-4866-b5c6-565709ba633c@redhat.com>
In-Reply-To: <cb5bf340-e5fa-4866-b5c6-565709ba633c@redhat.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Thu, 16 Apr 2026 08:50:09 -0700
X-Gm-Features: AQROBzDv-q221VlTuAk7mmYfNvhww8zIGor7VOjoMT0Hf2E7EXkGOlgCmOoPJ1g
Message-ID: <CAGqc4nVKDAdBrjO23Hv2nKccU81LNnsTSxtr3k-TuQf5smF_4A@mail.gmail.com>
Subject: Re: [PATCH v11 net-next 3/5] psp: add a new netdev event for dev unregister
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, Wei Wang <weibunny@fb.com>
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
	TAGGED_FROM(0.00)[bounces-279086-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55B864113AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 3:48=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 4/9/26 1:14 AM, Wei Wang wrote:
> > +static int psp_netdev_event(struct notifier_block *nb, unsigned long e=
vent,
> > +                         void *ptr)
> > +{
> > +     struct net_device *dev =3D netdev_notifier_info_to_dev(ptr);
> > +     struct psp_dev *psd;
> > +
> > +     if (event !=3D NETDEV_UNREGISTER)
> > +             return NOTIFY_DONE;
> > +
> > +     rcu_read_lock();
> > +     psd =3D rcu_dereference(dev->psp_dev);
> > +     if (psd && psp_dev_tryget(psd)) {
> > +             rcu_read_unlock();
> > +             mutex_lock(&psd->lock);
> > +             psp_dev_disassoc_one(psd, dev);
> > +             mutex_unlock(&psd->lock);
> > +             psp_dev_put(psd);
>
> Sashiko notes that the above is racy:
>
> ---
> Can this code race with psp_nl_dev_assoc_doit() and permanently leak a
> net_device reference?
> If CPU1 is executing psp_nl_dev_assoc_doit() and CPU2 is unregistering th=
e
> device, the following interleaving could happen:
> CPU1 (psp_nl_dev_assoc_doit)
>     assoc_dev =3D dev_get_by_index(...) // acquires a reference
> CPU2 (unregister_netdevice)
>     psp_netdev_event()
>         psd =3D rcu_dereference(dev->psp_dev); // sees NULL, returns
> NOTIFY_DONE
> CPU1 (psp_nl_dev_assoc_doit)
>     cmpxchg(&assoc_dev->psp_dev, NULL, psd); // succeeds!
>     list_add(...) // adds to psd->assoc_dev_list
> If this occurs, the notifier misses the unregistration event since it run=
s
> before the device is fully associated. The unregistering thread will then
> enter netdev_wait_allrefs() and wait indefinitely because the reference
> held in assoc_dev_list is never released.
> ---
>

Hmm... Good catch. I think I could do the following to fix this:

On psp_nl_dev_assoc_doit():
- grab psd->lock
- Do cmpxchg(&assoc_dev->psp_dev, NULL, psd)
- Do if (READ_ONCE(assoc_dev->reg_state) !=3D NETREG_REGISTERED) {
          err =3D -ENODEV;
          goto cleanup;
       }

On unregister_netdevice side, the sequence of calls are as follows in
unregister_netdevice_many_notify():
- WRITE_ONCE(reg_state, NETREG_UNREGISTERING);
- synchronize_net()
- call_netdevice_notifiers(NETDEV_UNREGISTER, dev) =3D>
psp_netdev_event() =3D> Read psd =3D> grab psd->lock and do clean up if
psd !=3D NULL

With this logic, at least 1 side would do the cleanup. And the clean
up path is guarded by psd->lock so it is also sequenced and should not
have double free issue.
Let me know what you think.


> /P
>

