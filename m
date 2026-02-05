Return-Path: <netdev+bounces-257165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA4YEIGahGmh3gMAu9opvQ
	(envelope-from <netdev+bounces-257165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:26:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C8FF33A3
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C40F0300EAAC
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28E93D6686;
	Thu,  5 Feb 2026 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qw3DsE13"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886F83D6683
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297869; cv=pass; b=TYEfC0hKL7UDXpsNC1Xfenkcn2cB4eQsgOVgoMqQ3MR3t6VPMv40Ga7gsjua1lP3yDWY4ojemzAPRNQcLGTIgyZ4w4OstJqwqVfACN1VR46lMecbo68oj2hJyz5L2SDWmcJjB0Haut1/fslVI3FCYdCNL4+cvw+htAiD24UJDYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297869; c=relaxed/simple;
	bh=PQuFRfseGtjZCs2LnFMBc+gFccaReHz9yiCewWdr7tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWaUvPEMZUxVwYVBzwmhJxH9RIzT10xlEmJ5cYN3bE2h5MkzX+ezEZcdl+6kuPGl7SeMGFBZoIxvV2Ak1cqkxaKVPPLIbAlSu2jSmwc03h9uESEZpoXrW/gDtaWg6CKIpl31/J5pCq/qmMoOvHp84cZOhbivsIXmkwUC1SU4B94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=qw3DsE13; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-649d4690174so1076902d50.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 05:24:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770297868; cv=none;
        d=google.com; s=arc-20240605;
        b=e0dFaGvvJKBFBS+vz88W3kbwfgdLkigtmzEcxdSR/BUY6pgypML68uQ314mXDghf44
         ZtgmtBjyZCEtc4Jv0Tgtj2V1qwQV7a1PT9CxJQ921UgRO2uLlRtRhU+qWbeTj2TTYcXB
         0FVhofpg5sykmn6a9KiS83lWe/SHtm+qmq/uiAsmwkRzRK4TMhMLlBMh5zisY76itjsA
         ahwTZr8iJa3fVVhfiCli26HDVAGzD3XwQY/IkDKurtGIyh6/4x6pZ9R/DZUt3IkZLG0A
         ifKaFx7hUkPzu4kD73ErJp/jZPWj9395P/1j4z+UTwSqo7F5286FCQHxXFN94WQsfpfG
         Gxhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=wWJQJSQM4MiepsuGDOp1upIX0oDFGMRimS+E9jTjoNE=;
        fh=tur3tTLjzLzFwCZlcVtDfQKdGeUvAEHw/Lab4ae6tQs=;
        b=FRIP6L4HJrJrnoQB+VulCHtooATOiQ9Z2T63dkzFIP5Ly9MCQ7t6tsQ1YiLJDHfGSu
         QfKNCX9emH7fq9FDGY0MmjRoIoGOxMC+63Go8cZbCJdAl427uBkbNnCHGp+19uAs15CD
         fJirHifqLoQreuzWOXy+fTcJpmJomLIGfEmPAx5+Bkr/E6+iqpQKbMk7jdvuXIpKsdJV
         uE0AOUIYGnUlZwdYR5xm+efSGmqlCBzt2YfUTsW7/bUXxyQxYzj/PoigHJIGfjsJmiYH
         MVZEMXaslgEEVCGuGCrELzDLMNOKy9Pi+tBUQWscgaSjQlGXVVsr1hSrqArlBTIn8pxj
         anlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770297868; x=1770902668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wWJQJSQM4MiepsuGDOp1upIX0oDFGMRimS+E9jTjoNE=;
        b=qw3DsE13v7+EoTqjyjal4HGchLU6/Kz4inyuxlaBwiJJpIo1o1GYheITKd/nGBeh0V
         X9lXAQsLBlqt4PWxbaGuQhqJYgpRRWBh9dy5pgJybPNLJ71rAWmWZXdOlC+TwEVCTJul
         jKEjdrmfmqXZdfHcmlihvxaz1ch5SJ9yoZVErymoNjflHeXEYURN+BDot24MrZ3/R85j
         JZ/HYqGE+yqRaJ+GIzH3FjWvJwGRWOv0SJrQEcGDtk4pOkqxCeYKZcWcwD6liC7GbZmF
         H3yxegOoG9py7XaWsEEUnF9T9byDtmksuI1CO58GaXc2RRg9+ublVRAiULfVV0kjUeIQ
         nQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770297868; x=1770902668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWJQJSQM4MiepsuGDOp1upIX0oDFGMRimS+E9jTjoNE=;
        b=HgitP/x9OocJpZb1dOQLhr1G5rkJ3AXEeg0K2lN62gGhCLx5ewhfVac7VL9NMaLQEh
         g6lVfITGqFtnj7s9tFYB6x3TAyTBl0DwaixjmucxW0ucyGse7wEaTLQkJ6NYTw5LK6XZ
         092W5kR5i2aiNJl2EN2BfAz9WtsT9Mnba/JO1+xTmA7zxJ75pqiHAIJVJIQDV5bmkiow
         ZYnaA20ud9hbg2deyk1nUIXZT9SrX2d/cKtlWw0RLDtlVnpUEZOYTCwKYOyNJI/iIKOZ
         Ua6Ky57V1JKxattQ0wzgvCljmZx2YsUMVZS1w+DsP6TB8QrnNEjTcfQ3VkqkEbwr6gAF
         jA/w==
X-Forwarded-Encrypted: i=1; AJvYcCWYX9ZqLhPX+65hCG5feh+Y8aP7cqkenH+MfVONaI2HH57ZQOHUDveuPB0RCxmH8OTXz2Icyc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzupO99v/XSr5aeR4sKtIVjmL92oYLA9bE2GT8k4EklS56iC/mY
	NOB2G31XsEGNwBpN0mDXWDL6UpsrC79bIPVXkGxqbAQxJbxQLrfTAp4mQE/OutsxxGIjniyAUQV
	9vl2yu8JJb2cAc2YmGZmcdjrPsINuXS/p5upZxrjY
X-Gm-Gg: AZuq6aKUTFl3wMnrdH21Mp4ew9ULcTBiZSN3BSlb7deh205xF+svkodoC/OKc/ZF8n4
	1q7UvpkER7D9k8mxnaoz5qrGIQFLE70X2WZx9qfX1uXf0uqCR8vSvC62LI7jH87kg9lZrDNVELh
	FiYUlWnN+QTfG2aNfOrYVlYUolTYUXakcTLxqNFK+tpLbY8P4Gx4DWU7nu2Exobbtlle2kjGVNi
	mucPljRgGtY+VYv7lbQIxrn2dsG6JSi3y2+iovIwRiZdfcU0/1G1wPu5TcanRAnddFXhyK8ZYRd
	KOgp0KIVDQ==
X-Received: by 2002:a53:7205:0:b0:649:c19c:eb88 with SMTP id
 956f58d0204a3-649db4ae1e4mr4304752d50.68.1770297868399; Thu, 05 Feb 2026
 05:24:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204132428.224465-1-p@1g4.org> <20260204132428.224465-2-p@1g4.org>
In-Reply-To: <20260204132428.224465-2-p@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Thu, 5 Feb 2026 10:24:17 -0300
X-Gm-Features: AZwV_QiIasAvBGy1qaVysi7TUiI88O9EzRAY9ErTDlI3XE43KPKDUv_79hUS2-w
Message-ID: <CA+NMeC9wKrU0PmLKe8k=MRsDk+T6F65Gqz4hpsvHP0=_-qjVLQ@mail.gmail.com>
Subject: Re: [PATCH net v4 1/1] net/sched: act_gate: protect parameters with
 RCU on replace
To: Paul Moses <p@1g4.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257165-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 99C8FF33A3
X-Rspamd-Action: no action

> Convert act_gate parameters to an RCU protected snapshot. Allocate a new
> snapshot on CREATE and REPLACE, swap it under tcf_lock, and free the old
> snapshot via call_rcu() to avoid races with the hrtimer callback and the
> dump path.
> [...]
> @@ -323,23 +393,9 @@ static int tcf_gate_init(struct net *net, struct nlattr *nla,
> [...]
> +               err = gate_clockid_to_offset(clockid, &tk_offset, extack);

I don't believe you really need this function.
You can get the tk_offset once after you've determined which
clockid will be used.

> [...]
> +
> +       if (use_old_entries) {
> +               cur_p = rcu_dereference_protected(gact->param,
> +                                                 lockdep_rtnl_is_held());
>  [...]
> +               if (!tb[TCA_GATE_BASE_TIME])
> +                       basetime = cur_p->tcfg_basetime;

This doesn't look right.
If you have an update that provides a new set of entries
and not basetime, you'll end up updating basetime to
the default variable's value (0). I believe the same is
happening to the other attributes you are looking at
here - prio, gflags, and etc.

>  [...]
> +
> +       if (ret != ACT_P_CREATED) {
> +               cur_p = rcu_dereference_protected(gact->param,
> +                                                 lockdep_rtnl_is_held());

Can you try to acquire cur_p only once and reuse it?
It will look cleaner.

> [...]
>  static void tcf_gate_cleanup(struct tc_action *a)
>  {
>         struct tcf_gate *gact = to_gate(a);
>         struct tcf_gate_params *p;
>
> -       p = &gact->param;
>         hrtimer_cancel(&gact->hitimer);
> -       release_entry_list(&p->entries);
> +       p = rcu_replace_pointer(gact->param, NULL, lockdep_rtnl_is_held());

You won't always have the rtnl_lock in this situation.
For example, if a gate action instance is attached to flower on an ingress
qdisc, this might be called without the rtnl_lock.
Take a look at what act_vlan is doing in the cleanup callback.

cheers,
Victor

