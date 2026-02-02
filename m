Return-Path: <netdev+bounces-255857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG9cOBmagGnL/gIAu9opvQ
	(envelope-from <netdev+bounces-255857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:35:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8BECC650
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 13:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0261300E702
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 12:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673391DFF0;
	Mon,  2 Feb 2026 12:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="muHc/539"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046BA10F1
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 12:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770035594; cv=pass; b=kVdXl1ALC0VKJvkyZ9Y4GlFmKiMKiIpopmCEmkbLWKU1V0TsHwoRwuuqJAHP72w5BS0O6z/kafpDr/ubNbCCSlwWJCJsJVFtFyMJ9KBessChAzD2TNMo73bruyQJwBpV/3BnSFeIPfhnVqum9JmoBGynLrxsWkGhgOI3IqfSA4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770035594; c=relaxed/simple;
	bh=Ia6f5z77vCaSbY2DnUWmxK9K1HksZS+epiB1FNS9fM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSqqXuoH/Rh5hQeedJvV2zKwsaJrCKnXssTSevwHud1CUmJll13XY3QiV4ZZng27a0EX4qYlWg7lTDqY7ssz3o2rwiY6PJtrnD7m0wmrmjyEjnqn6GC5Wsj34Z66rLZLSCAJyZLYlGjCMKz7eqTlAWsUMkv+jJjwjxfvH1vZG2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=muHc/539; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-894674a4c4aso79847456d6.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 04:33:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770035592; cv=none;
        d=google.com; s=arc-20240605;
        b=ZFrVf1BVnRymCrdGMZgvM9hEerD+oz6no0hOAtry1oHmDVg0aGI1Jvz4wCByQlpaY1
         VQQS9JF2bPN2xZpG92Rx9XtjqS9oaVVTtXAENZt1nBYHquEu+6x3OzwsmmG7ixx78dka
         P70YGKr6+WwQOTj6PJRkf9AVBhnN3dqP/CZSEeUZQLPtSFxliJDLSC/oIA3Ytip0LFNo
         wUj2M/4hlfTI0AmNMKNRXzenoTW7WMFORk7fbZf6qZy1hMbph6EJ2Hofv161O14nph3E
         NynBX5zd8nZ1TTozYKOOyQN6GA/9bZuQa5Wt/PdK2i4cqwsIltA4Wft27NTKP7ACq2q3
         evmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ou5yDjzsnqfXupfNKA1W79qfMcN50pCnT/+goRLmU7A=;
        fh=pDW60WA5aFUPAHUu3RkwnSvwfiSA+8Y67VyTDfnKNvw=;
        b=EH5YlpNfxsicMF36QAGS2zv/ocAKRda8c1c9Fh/r6XbB6kE3BYFhn66aUVfc5/1mWy
         tnTJpxvv3VsNLL7f8Ul6Jtc1QRSV48zxeuFPf0ruKY/nbpJoXZ2RoAeWOJjaLo6gJBto
         RjPurxzuQFHrAqh/StOX/G6WwOp/uC3UucfVhuEAYbyLSODIrJLK+X65PigBj58o9jkK
         AuFyjOSY24+YJs9PAATp28xXzQt39lyGNGOOscJa0ujkA/gFFDVkkEo20lix7mETU6iq
         wzNmJ7dGeBVVUwRi/hohFKjUMS4ZbzS4Nsob1itm89YKyDdg89R2YdfsDE4B+6uwMxed
         lTbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770035592; x=1770640392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ou5yDjzsnqfXupfNKA1W79qfMcN50pCnT/+goRLmU7A=;
        b=muHc/539ln4T9U8RD2wv+oAvmzmAV/K9PizMkS+VTL0x2BJKiuN16nhabewCmRkDBO
         T5JxxS8TRmMamaPTjXj9joPjObpK3syqhYHYaS6ic1GcOJFczSMV1MXXltt1kQwPzcvZ
         JBRj1cNrd4HxdmintuScFPlQasu2qTwUQyVSSBEGFv5KaMQ3f7K+4WWF2I5EbPYSHrsG
         CxMNMH+Xl0fKO7omPatdOucvgoZ603UzgN435RUZZCaHk/JpF3Epm0yUSaYgViyW7dDs
         Zq4QPm3WFruOm6PSIDijGRzYrhJ7J5XYWvZusSre5YRdmZ6r7rTMxihPbw22wauHrUkV
         FXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770035592; x=1770640392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ou5yDjzsnqfXupfNKA1W79qfMcN50pCnT/+goRLmU7A=;
        b=n5CpTXKlb/0lWonIBOdP+TUqmc/YetR0VU9T2IetGZqNrTZ5NVVRfGS+0pniHKECWe
         V0BmbO2dj6VS97NjN0hOLDEfbAK3WS/gxP7t0Qz5NVCrCKCRgjKxPmWP1yEbItUtUFQi
         a/tbZf9ZrWSxboZYFs9W1dFTwo2uGLf+jaQ4orVItJNKs2C/zOl0fm5JpHQLo00pDLAd
         jAU6tcFH01KBObldGAODIRkyooFWxQi3b9HRJbXZZEFtKjrtRsNMlSUwhyIqXeOHkQiY
         CjHY2uDyyIsfEGlu1/pcodN+uCWs85OYLKdNR1xh98iwHaREVDaaPuQPTwCkD+lqCKA1
         4f/g==
X-Gm-Message-State: AOJu0Yyhh3ZY2MLf2SRMy2mkvEzbBwo6uEeIIBcsjsYu5RnpvMqUwmOG
	azoEnKlj+p0I7FHEMH4X8YystjMEvV9OAL1B8KqEeFUcln4dtjHfsfEUf8sszYqHr6No+HSkhB6
	0vDlVv2Tz/MLLwUtn9HTiN6Pw5EXaEp1LkfWIV5LU
X-Gm-Gg: AZuq6aKJ7CKMmUXpZoew/G9NPUsZ909bCFwHQceGszVKTQP6D5WfkYHffvAZOmB0Ulv
	l6Ku4qdxs4ZjcAtkemiNvG367K7E7s0WMypXxCLe3D6BMQh2aA9421FVir44pac5D4jQwsLct/r
	qLMlfr4RDyRQGkG6kKmiK/k+n2qxNH6DsgrDHteKnpQcVDwjICVW0QhPXun+KVIN/Gouc5sazXE
	6QXbgeSkplmksiD+lVwvhDx2q7hXRxJOn0KpAE/RTN5/EWAl5XgoxSbMFtYlgdJGzUH1c0=
X-Received: by 2002:a05:622a:302:b0:4ee:275c:28db with SMTP id
 d75a77b69052e-505d226cb67mr147229721cf.40.1770035591574; Mon, 02 Feb 2026
 04:33:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201135915.393451-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260201135915.393451-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 2 Feb 2026 13:33:00 +0100
X-Gm-Features: AZwV_QgPLc4nJlo3TFmGopx9XDmx8wdP3wX-l5kzlpT4RqtmIm4meodvFu4uv_A
Message-ID: <CANn89i+zKPEuZaYpQAMyYQO72LyA7PxOcm8QuVPsaSqGBw1dWQ@mail.gmail.com>
Subject: Re: [PATCH net v3] linkwatch: use __dev_put() in callers to prevent UAF
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	syzbot+1ec2f6a450f0b54af8c8@syzkaller.appspotmail.com, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Marco Crivellari <marco.crivellari@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255857-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,1ec2f6a450f0b54af8c8];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 5E8BECC650
X-Rspamd-Action: no action

On Sun, Feb 1, 2026 at 3:00=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
> After linkwatch_do_dev() calls __dev_put() to release the linkwatch
> reference, the device refcount may drop to 1. At this point,
> netdev_run_todo() can proceed (since linkwatch_sync_dev() sees an
> empty list and returns without blocking), wait for the refcount to
> become 1 via netdev_wait_allrefs_any(), and then free the device
> via kobject_put().
>
> This creates a use-after-free when __linkwatch_run_queue() tries to
> call netdev_unlock_ops() on the already-freed device.
>
> Note that adding netdev_lock_ops()/netdev_unlock_ops() pair in
> netdev_run_todo() before kobject_put() would not work, because
> netdev_lock_ops() is conditional - it only locks when
> netdev_need_ops_lock() returns true. If the device doesn't require
> ops_lock, linkwatch won't hold any lock, and netdev_run_todo()
> acquiring the lock won't provide synchronization.
>
> Fix this by moving __dev_put() from linkwatch_do_dev() to its
> callers. The device reference logically pairs with de-listing the
> device, so it's reasonable for the caller that did the de-listing
> to release it. This allows placing __dev_put() after all device
> accesses are complete, preventing UAF.
>
> The bug can be reproduced by adding mdelay(2000) after
> linkwatch_do_dev() in __linkwatch_run_queue(), then running:
>
>   ip tuntap add mode tun name tun_test
>   ip link set tun_test up
>   ip link set tun_test carrier off
>   ip link set tun_test carrier on
>   sleep 0.5
>   ip tuntap del mode tun name tun_test
>


> Fixes: 04efcee6ef8d ("net: hold instance lock during NETDEV_CHANGE")
> Reported-by: syzbot+1ec2f6a450f0b54af8c8@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6824d064.a70a0220.3e9d8.001a.GAE@goog=
le.com/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Thanks a lot for this fix.

Reviewed-by: Eric Dumazet <edumazet@google.com>

