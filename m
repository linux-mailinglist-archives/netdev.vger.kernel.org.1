Return-Path: <netdev+bounces-281150-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yC5CA0nw7WmYpAAAu9opvQ
	(envelope-from <netdev+bounces-281150-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 13:00:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0875B4697C4
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 13:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16EBA30028E3
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 11:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AC0314A9E;
	Sun, 26 Apr 2026 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="VzNxAK4z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906AB35028C
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 11:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777201214; cv=pass; b=ZIHNaM7m02dLW/HLMAJDZQKb+vVXRthlpRBwHDak9/h1kpU/oaEGDPRvbbgKZo7/ycJ5JVz815Ou/u4bKPcGL1F5X4hlzzcq2QpdpS4YNetInKeVUMnvk95oMkcGQuT+ywxwhSdZ9HIJVY/1r2YS3Qm6WVw1a9R0lhNt3Pevcls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777201214; c=relaxed/simple;
	bh=Py2Gmr1ZMZHxlIxxuiTASzT6HalctrDZf2HMocIBGc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9BtuvVK6byZdJAD60yu8UukjRXvykNnsTF/S35vtMidYD0ALZLjDSoEDWAK8riLZXJvgdIkNRG/3qtLJn2dWf9RqwsL6iTjZzh9KrwuMXlKGx9+p+6L2AnMgINHYRNY7ilfQPtWfiW/EG9TaEsreeO++G/ZdnlyUIRgDh8s4lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=VzNxAK4z; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-824c9da9928so4514585b3a.3
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 04:00:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777201212; cv=none;
        d=google.com; s=arc-20240605;
        b=LZiDnT9honnz0y/0NblGiUd/cIOVXBMN9hy95JmfBLC5/LoSwck/Q0hZO+JT0CX0sq
         FtsU+rnnD+TvBj/4BWknTiHbFW9w6ZIoU2NrS2a9sMm8o9AIhZWju2YK9BnG1420qdPL
         ZM/PWPnOYuX3ndGYqzd5v0A9MyRsVgvpH3lYZ5jVUL9m+bQiMCxgHKIfy+2rpQsIk1Dl
         CI7rdifLsWcuVu28/us3ZymDk5fKGFoZvT0fY1lQ8pe3D5KJomZiLeKCL4SFMppF/Zr+
         hf/rK7pjfe6/FGJfp9uZ2H53OrgCaL1En07na6hwv3A4wB9QkHr599wWWY0YoDGV2tG1
         77vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E8A7gFcKvdyWa++j9tbO0q1d1HYO3JFhanggdfF7mY0=;
        fh=hqMS+QWXpMW/4ahke8zCMS/9ZfyCrgYFS2He9/5G+0c=;
        b=F5kx1XALQdThxJvapHRBI2TBYRIewUMmAxvHMwU+39fq9pGRyL90vrJgOwAsFmWcLH
         4TkfZPDNiX+Eez+9RaLdBVgcQpP2C8DJhymnEM2BdKgtaAsYL4bLl7uRYMMF8cahAIKu
         McblVHEzUh+FoisfqlkOpNXkJMglfwWXxK/h0bw2XIN++Xs0UVbqsqxSFvlLtgmE9jCd
         0hTT91WWPUvMPnPI0rlktEZA+EaXU6vDc8ucjVXWC6MEH5xuI8j9fu8cBRMSV4ybrC+G
         Nacw9Bl6EZO0Nq5qb6L3NOauJhg6IpzCU+yEmoP4JwM1vtNXHdThA0V0kB9y+EPACfLz
         3Emg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777201212; x=1777806012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8A7gFcKvdyWa++j9tbO0q1d1HYO3JFhanggdfF7mY0=;
        b=VzNxAK4zXAptbAJCMyrUSbNd/muLmMFeCoL/F4HV3tdjVCi2Hhave+KBhhd9wyfeY3
         VBPCM+nPpDgfpAcAXtjiDr2buD+SoOEa9LZC8PARVaEalIASipIbw25HbJynOxaBlcJE
         jpNE8NzXhAvWRp9DT04qJGdUnmsyj4DT4dpPlASfsj9E+r/irAHMM1WrdVr5fUjbg2Q8
         AofZCpLDR42ndYSkc7BAxtWrLn+85soY4qkE35LahyopAJJeNVMm5DvU81QgLn0uJqFJ
         1w2dBMlZzslLOTYEKTR6mpPZUInIa9ZlEv/l1yOKIUKlea7Oen9AAElrHTfrvm4Oadsc
         hREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777201212; x=1777806012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E8A7gFcKvdyWa++j9tbO0q1d1HYO3JFhanggdfF7mY0=;
        b=CtFEEI2zZD+ZUyoGpYNaQ2lPGX3eaiYQuEYWESDVX268VUL/+rB2TGODAuIdXofqko
         kvKiOIJcv7dIIn6xKvmD/ttEUm1QJxEdfgICjeTbXoJ9OxnTbqxSbCnEg8eZr6WOSyUT
         7op3MgRWAtsou6ND7gEZDe9LAIwtFefOHD4+N+LuU2573UE0lfWi4s54jQggmLOmKKEQ
         X+Z5GySnLWTvxTw6lUymxFV8HfajI5UZ4yQeDayw9cA9/6iJptbvUeX8H0D0+7s3MVyU
         HpbPuXJZvyTm2tkz8LiJ0aHXmICyUYFwPVMyX/GIoZduMgZzMq1QaHf8Qly0B0anUcaS
         dHvg==
X-Forwarded-Encrypted: i=1; AFNElJ9wKUYDzjKV0a7KaENtRZPk1ogD0YXxRmpaxZAB7d32MUYDZ/CsoxQhD6aVuagL11f3pH4GybQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxZtpSzDEboQ/0nVfOY+Z/AYmR4MLjWG68NrqHPYb086b1zJj8
	obiZi8jYOdB/SVRFH1LPTz/NNCMYfDEu0cIdyUAgTVY7qwu9D8j2VRgAErrhc0vGpICOsdaQVZO
	Llm3JmmZxLLcWap1yNbGE0RhlOJSCQMvnYtdomLa0
X-Gm-Gg: AeBDievF6yOjOudCie8M3Sr0nMS3f5PhqAdcxjTf8Ww7/qo7oeH+mp/fp2wu4C0+nLP
	96NVamOre7WiuCLtYQU8eqAb6Y5KPnqmG/9sp1vK/BQlcZgXNBLhgAf+MReFnALvY1LDX/Wdopl
	6BrJIWkOnthFABm2wSulUHcitw2cYnOxv+G0VoboNywZIiIm/+nwINVEIAD7q0FEbIjRHAj07r+
	FqzrJP/keFoRceopg7AvkxNKZ2SvQkUouoWyjhrmpfDFL71U0EqAF0rFhpqzpCSojSGSceH6cU0
	HFog+qOIU0PCa+R7klPXFr7YrJYM2A==
X-Received: by 2002:a05:6a00:27ab:b0:82c:21af:a7bf with SMTP id
 d2e1a72fcca58-82f8c8a0442mr37056102b3a.13.1777201212002; Sun, 26 Apr 2026
 04:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422161958.2517539-2-bestswngs@gmail.com> <20260422161958.2517539-4-bestswngs@gmail.com>
In-Reply-To: <20260422161958.2517539-4-bestswngs@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 26 Apr 2026 07:00:00 -0400
X-Gm-Features: AQROBzAgSdaBXJcboV9nvHChxz5j4Mz83IiN2mpkjN3RKMZV28Q-ZgpRwnfLPEs
Message-ID: <CAM0EoM=aaPvbDz8SCd_xcUCAmQ9m-aK=ZaQPAN8zUURhs5jmBg@mail.gmail.com>
Subject: Re: [PATCH net v5 2/2] selftests/tc-testing: add taprio test for
 class dump after child delete
To: Weiming Shi <bestswngs@gmail.com>
Cc: vinicius.gomes@intel.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	vladimir.oltean@nxp.com, shuah@kernel.org, xmei5@asu.edu, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0875B4697C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281150-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.721];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Wed, Apr 22, 2026 at 12:20=E2=80=AFPM Weiming Shi <bestswngs@gmail.com> =
wrote:
>
> Add a regression test for the NULL pointer dereference fixed in the
> previous commit. Before the fix, taprio_graft() stored NULL into
> q->qdiscs[cl - 1] when an explicitly grafted child qdisc was deleted
> via RTM_DELQDISC; the next RTM_GETTCLASS dump then crashed the kernel
> in taprio_dump_class() while reading child->handle.
>
> The test installs a taprio root qdisc on a multi-queue netdevsim
> device, grafts a pfifo child onto class 8001:1, deletes that child,
> and then performs a class dump. On a fixed kernel the dump succeeds
> and all eight taprio classes are listed; on an unpatched kernel the
> class dump crashes, which surfaces as a test failure.
>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-6

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
> ---
>  .../tc-testing/tc-tests/qdiscs/taprio.json    | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.js=
on b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
> index 557fb074acf0c..cd19d05925e40 100644
> --- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
> +++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
> @@ -302,5 +302,31 @@
>              "$TC qdisc del dev $ETH root",
>              "echo \"1\" > /sys/bus/netdevsim/del_device"
>          ]
> +    },
> +    {
> +        "id": "c7e1",
> +        "name": "Class dump after graft and delete of explicit child qdi=
sc",
> +        "category": [
> +            "qdisc",
> +            "taprio"
> +        ],
> +        "plugins": {
> +            "requires": "nsPlugin"
> +        },
> +        "setup": [
> +            "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
> +            "$TC qdisc replace dev $ETH handle 8001: parent root taprio =
num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-ti=
me 0 sched-entry S ff 20000000 clockid CLOCK_TAI",
> +            "$TC qdisc add dev $ETH parent 8001:1 handle 8002: pfifo",
> +            "$TC qdisc del dev $ETH parent 8001:1 handle 8002:"
> +        ],
> +        "cmdUnderTest": "$TC class show dev $ETH",
> +        "expExitCode": "0",
> +        "verifyCmd": "$TC class show dev $ETH",
> +        "matchPattern": "class taprio 8001:[0-9]+ root",
> +        "matchCount": "8",
> +        "teardown": [
> +            "$TC qdisc del dev $ETH root",
> +            "echo \"1\" > /sys/bus/netdevsim/del_device"
> +        ]
>      }
>  ]
> --
> 2.43.0
>

