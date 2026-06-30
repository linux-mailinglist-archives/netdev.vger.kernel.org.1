Return-Path: <netdev+bounces-303312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kfg+Cpr/Q2punAoAu9opvQ
	(envelope-from <netdev+bounces-303312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:40:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CB16E6F9A
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:40:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ttUGDkqk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303312-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303312-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FB5F307FC2D
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927AA3DDDAE;
	Tue, 30 Jun 2026 17:38:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CB43DD537
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 17:38:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841097; cv=pass; b=d1KghuLwZIdA4Gocv8auDnNipzvsMtPJbK4uuK5kwFi7RahS3zXDFpGX+9fxsXNOpIU4hpzsnXKNMBSpMnXNFsZP9bruDetLHBUiNd3otYr3a87XyVgJ20kt0HIdQBfwEL7/0jEo4pKe9dTE1TxJ6CEv7EaqVhv5n0xGS/VD5U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841097; c=relaxed/simple;
	bh=5/krHcBHI1JSub7aw/+IBY1ssuiydpPt3+zadRH9bUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQn5ACvrv6tu3afXy9HcKz5lJaZ5/OT3zpnlBYDpDGxEE/yJk2y1DMWguSTQ3ncVQ8Hp3y122KOSxex4WAJ0I5GeNqN2dy4zABlggrp4QUf7c5v+lAqok08gy/g1Cn5P/UAj+fhdONB3n566BLaP2ACWh14S3N/zp0FD259kc9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ttUGDkqk; arc=pass smtp.client-ip=74.125.82.53
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-133362c30cfso701c88.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:38:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782841095; cv=none;
        d=google.com; s=arc-20260327;
        b=hCYTyTBFRPMSG6WRXj6/xu2yEZ3zemn2YBd/NgrMHkgSOGrI64oj1FccAWav2r9crO
         PRt2qxvR5b5gCEU2v7emi+JhWL2T1HOehpVnjiEPtKpoG+w+BTKmeFph3R6wRzt6qrf7
         Sf5IrKhvPlMw305AO4Pp61APamUIPT8nVf2GWG3nw9mmJYpz6wB3EcOGOy2Ib9vmh8Ja
         2i57cuDYdF0uSg+OQhHkUc7ZwzvhwngHOxoYSSsiulZFYmT5FTt9nqi1naXb60h/5Yay
         SjgnWxTdGKEZ1lAevuzir6dpL/rq0tmZA6+mYtLBnkWPER0aH/JfOV27y84iPr7ebTEN
         tPWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PhNh1O8KJd77HVRv00phfDVEbbQW7UcJOtJ0dSSwrLo=;
        fh=lyrIpVqQiWGRnXV0NtNTT0Qv03+2L+T97qaxMLMeJzc=;
        b=sfWc2z3kf8YbVS1OcTNvGdFjrNv2ZlQF0jYxQy17N3yXFjY8m4XDzCFUb2xikDRL7D
         1Oc1KQbDoaA2hEvtWV+C/Xj0SOhu9mG+Cbip1jmHcp1wWq5URhRQPUp7fpCCdxQbn3Qv
         M9+a9mb9ZXIQrqAaYolDLeRFB8pvA/KIhwaLDOhkHafeCHMzEJ6mL4U1xW0gSjuY210F
         Ng3wu3+O2b6EAuXxH0YX43AipOjL7QMJgamJlSg/uS/54S3vsnYRJh7hpfmpaOedypot
         3zjXZO5X//Gif/zurmqSUCUJhcwb8r20rAYfIIDiy7x/1uGyF1dqfh9jR587PauFaa/n
         Sxrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782841095; x=1783445895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PhNh1O8KJd77HVRv00phfDVEbbQW7UcJOtJ0dSSwrLo=;
        b=ttUGDkqkp91LfVvWBcqkb9cgcxwOJlHBKScZcl5r94kpA3V3atVGFyFt7Itdab0C3Z
         /XtGiNSsfec5Ofk3JPJ4iIhs4/Byzt0SDGMCgFnRd9PXhQzfctFo5ynF8kEpz/v/qEuh
         QDXYvZ2vAwDXkKg+xgwm5315lr5hLoaswz9CyoM8ZSGOFz/eye86NEdNFrNHkm0kJtbZ
         /EEkBBEZrq/K7voUqznwPkM2x/aQIsL8Obvf8ruK1YS52W/5fk2I9pdiW3+7i9+lT2Q7
         7Aw3MXt2GY3gKhFTOJoMdMcZXmAiK/YC/8DYBxjZjBiYd+CHcaxqF2vv4gQYi83pN24b
         dTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782841095; x=1783445895;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PhNh1O8KJd77HVRv00phfDVEbbQW7UcJOtJ0dSSwrLo=;
        b=MMi3DreYrkvEM1Gox1nmc7NvmN3PH3tT4r8t3V0RlHpEWVArRkG2V3wGJyPwR9jaxy
         0KZthn8uWuSOm7tWA6N4mfI8G+j5Kputtfb7IHMjLL60M03fOawgNoEOMV8rr6lua3Ke
         KepeXIrDss91Fc1ajknDHjjQVp1mkgxntKWee3NkednyKYLnr0tkVzPmRCB7yt33/AHB
         IBpWGvzzCBnVbRILSp4x71kmzwFM68OFCIaGbCjFBd0PrwWrKMhb5jbguu6pFxXbpDHo
         TNr1C+Q7FxhToeTtVqrmREOzKag1GBCklS83Gc3jiXMhb3JbzmuJ6ij2GbCRhlYCIyG7
         QBXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/jpk5kZdl/SLCPVfPpzEJxEP7zP9nypNkP5mpfZWSdiyppEyM4lcUoAFP/YIoJAwo9buj+TY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6P7VkMRLchNYPMTV66nucji4KbgG5ZzgY3XEU1A6kYCDtG/fU
	nITJRmhdRQneiWwbJVq7b++E5FXVHV4zzejVll3uEzmncaalj1k2zTkwjL/LzR60fcp1gnp74mR
	wPMNNcyePJgSAX1/eOwQxcSjaSW+KrwMeI/39aoIp
X-Gm-Gg: AfdE7ckIRMNJWhisZs8s5pf6RekKPLZB2GDqwOwPBlz8qpnnwBvdeBNfitrpUNymQ/O
	XjO8IRcjpQANAvINdnBGpFDEawPeYEozfR6BnwlCz9YrkqnN/Ypy3jLsroCAYnJ571NL70GMIUb
	eWQjDLyYw/k6eZtcS5H/wFvNmTLhvrKBAT/RjXwILYFVhVKPSCo6VQln3RVmdeFEubfIefGIhQL
	HuE8MqNxz1/V4YgcFcmwySsS0RXgLbedmow30PA0E3WehV5UTq83F1k6BNw/8sei2Mq1Cu4IPzH
	VgarQS52IZrWe7//gA21s3cRKiqQt9c3IFeV
X-Received: by 2002:a05:7022:689c:b0:133:52da:cb5f with SMTP id
 a92af1059eb24-13b33aefda3mr11573c88.21.1782841094527; Tue, 30 Jun 2026
 10:38:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629192029.4013794-1-tanshuhao@google.com>
 <20260629162619.55297244@kernel.org> <CAABY+HEcNnh+ATyA_JMg4LnVpP=egprTTi4UXxV9CfW2+71z+g@mail.gmail.com>
 <20260629181955.00e63b61@kernel.org>
In-Reply-To: <20260629181955.00e63b61@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 30 Jun 2026 10:38:01 -0700
X-Gm-Features: AVVi8CfIDRCEEftMp-9OYUT7tFXjHknuuH7nu2ohdOSy-r7PQmXeshFnOquXIA0
Message-ID: <CAHS8izNeoJiLyoyiPgzmX5CGcyivYqBpVxOcFnoxeOX_zzFd4Q@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/2] Reuse threaded NAPI kthread across napi_del()/napi_add().
To: Jakub Kicinski <kuba@kernel.org>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jordan Rhee <jordanrhee@google.com>
Cc: Shuhao Tan <tanshuhao@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:hramamurthy@google.com,m:jordanrhee@google.com,m:tanshuhao@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:shuah@kernel.org,m:skhawaja@google.com,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303312-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[almasrymina@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almasrymina@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78CB16E6F9A

On Mon, Jun 29, 2026 at 6:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 29 Jun 2026 17:47:03 -0700 Shuhao Tan wrote:
> > > Send a netdev Netlink notification when NAPI is re-created and
> > > let the userspace re-apply the settings?
> >
> > It feels surprising that the userspace needs to reconfigure thread
> > properties when changing NIC configurations unrelated to threading.
> > Another downside is that when userspace configures NIC configurations
> > in quick succession, re-application becomes messy because a previous
> > re-application might still be in progress when the thread is gone.
>
> Can you explain more about your deployment and system configuration
> flow? We may be adding micro optimizations when the problem is that
> we recreate the NAPIs in the first place.

We have an AF_XDP application with extremely low latency and jitter
requirements running on our servers. Sami developed busypolling
threaded napi for them. Since it's an AF_XDP application, they attach
their umem to specific RX queues, and then configure threaded NAPI
busypolling to achieve low latency. That involves using the Netlink
API to set the threaded/busypolling property, grabbing the kthread
PID, and setting some properties on the kthread. Concretely, something
like:

```
  local napi_id
  napi_id=3D$(call_ynl --output-json --do queue-get \
    --json "{\"ifindex\": ${ifindex}, \"id\": ${q_id}, \"type\": \"rx\"}" |=
 \
    jq -r '."napi-id"')

  echo "Enabling busypolling for queue ${q_id} (NAPI ${napi_id}) on CPU ${c=
pu}"
  call_ynl --do napi-set --json "{\"id\": \"${napi_id}\",
\"threaded\": \"busy-poll\"}" >/dev/null

  local napi_kthread_pid
  napi_kthread_pid=3D$(call_ynl --do napi-get --output-json \
    --json "{\"id\": \"${napi_id}\"}" | jq -r '."pid" // empty')

  taskset -pc "${cpu}" "${napi_kthread_pid}" >/dev/null
```

The bug is that the taskset configurations disappear when the user
runs an unrelated ethtool command. Yes, the root cause is that an
unrelated ethtool driver config on GVE, gve_adjust_config() will
recreate the NAPIs. My understanding is that NAPIs are recreated on
ethtool commands as WAI and standard upstream driver behavior; is that
not correct? If we held onto the same NAPIs during driver reconfigs,
this issue would indeed be fixed. Is holding onto the same NAPI during
driver reconfigurations an appropriate/feasible fix here?

Other ideas, FWIW:

1. We could add an optional netlink argument, "remember_napi_kthread,"
that customizes this behavior for users who want to remember thread
config.

2. We add an optional netlink argument: "bind_napi_kthread_to_cpu"
that not only sets threaded but also binds the created thread to a
specific cpu set, and then include that cpu set as part of the
napi_config so that's it's remembered on reconfigs.

But I think the best options are (a) not recreating napis during
driver configs or (b) this patch to park/unpark the thread, TBH.

--=20
Thanks,
Mina

