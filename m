Return-Path: <netdev+bounces-276657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEyNINqL1mnzGAgAu9opvQ
	(envelope-from <netdev+bounces-276657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:09:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FF33BF504
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C540300939F
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B990F328B75;
	Wed,  8 Apr 2026 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LDW/Q7hy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8E0330315
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668177; cv=pass; b=iFGMnpdt3HDL1TbrJPjBXiED+UX8ExZ9oMx+wio3561L4wol5dsdtWk+7qTTJm23KhrK1avQfkWam0tCsdt6zr4o6hzzK3pgHIi11BOBaNvhunEG/nYhene4LBTp4c/E4A/tOzcV8b1r8REECShfFkYd7U2I10dns5t3LxubEEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668177; c=relaxed/simple;
	bh=Un7lDabhahPp6sdsLdTVXHnOZIFR6dwRmuqZi7BkEu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=js9nFjRTwJEdTyZ00CqtKVdhSboyzbZmlAbfpdkv8Vh5GH9WvDO1fjnJufVl5ixgPghGSrTSJBbFTAS73V5K+MF/i9VCRNZ9d0rI9xeWphxNHqJb7eGTsje5R1jKDnLDT5vbjKGU6V6+txgKCxTdLUsyN8RqJjOVhZQanabCdkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LDW/Q7hy; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a08fa355a1so562836d6.0
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 10:09:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775668174; cv=none;
        d=google.com; s=arc-20240605;
        b=iIpW/Nz3aczbR41+U4hfOEMyE8wE8J2RAgmLpFFeaTyMtCewG86qIKQVDzSr9kh0RD
         6BvkYjqTw/3FNQjm/vlGTJcbWrkat2fkus0KvNmwyjaoOkzvhMMlcMdQ334O4NfqqI/X
         jVUxNYEfwsr0SIs+ayw2BR/+CWbJBNAMi4X5kKF100OM7fY3IvxknghU+fGGUS9Uj0eu
         8AKgfwWUrEgDcja+sOBtk3I6/9BXVm0GVKwLxr21FGVp0mlU6FkOit9jsWnAGPQEPVLn
         xm1+WxvMviSlpKyhjuXb8SS0XUs6eauhtwjFemlE6IiJw+ELNwwtVQZv0PjXD2NyjqTu
         j6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TgbfzZ5OCrbiJRFkpAnhPw6zLJ56/O32cb8WtIU2nbU=;
        fh=sQNjgiFgL5c6mXyt2DJkHlhyVQHTjYM4LdQl/K8SC+Q=;
        b=ijVTNu9mHXr60wfh1HDnLiQ39ymtLI2neM5x05bze41Drw+1iUJUO9v6FhiGX5uaCp
         IdeJispCtdW4N2wEiLwCwnYvPkSHA2beePhmPJSRlagQp3Lz5gDbLqT/zPyIurBztLaa
         ru/QXZSedex0sRkSyTeoja3CdcidvuscY60nyQHjiDBNHsONXEsdxsx95Inf7A2C+jg4
         601tPB8ac0BSxN9c18oxXGau67SkD0XK0h20XuG+G4QqwQUASmbd7ZBsTfPcVsK5Gcyc
         DoaSFyzeJs9H7658dagV4BPkpzBeZvt1rbVkt3dejdzoIiXFI4ahr57k7Hb+S/KO48bv
         GDwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775668174; x=1776272974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgbfzZ5OCrbiJRFkpAnhPw6zLJ56/O32cb8WtIU2nbU=;
        b=LDW/Q7hyyhI8lyI2HygTlvpVCFrD+AA+9vcKbY2Qy34aMmcWPjdwjxisFX0jY1cDZk
         KxWZb32GfI/hi4gkINVPw83sWgAvtgbQ6OXGcbeLDPhRlqIzOYH598IjWL9/nLXHSCe4
         D5BPGhKeE5HFym5ehvRhS4FNNwTB2Qx3mo42nAo1tVr+ig/h03AbQt41WPWQ5lEURn9N
         Lf9CsVY7WKs330zbosXQKGVgV1nkNrhU3Wt9PCVU2+NB+BN4RF437HSG4H7hnSoQ5h+f
         TBJyWlOFwi7coeDaUvCMucHJzKCdaMS9hCgpcAPjhEPwBTicaFKtSi5DxgZVheygo8ue
         MCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775668174; x=1776272974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TgbfzZ5OCrbiJRFkpAnhPw6zLJ56/O32cb8WtIU2nbU=;
        b=GoWfc7aFA+GtYjPU7IiEOcSFFz1wTk8H6elB8DFFkh4clMNCV100V04pn+nyfFWFuN
         edZPGQRY6a1ghRVD3Kcl6G6D0D6VTorsLV38MdmCJrm0RsgHQ0En4Lpo53pWgHsfavT+
         aLts4aKf3LGfFdJpJp5N+fF1qJvlQDwtr+2aCbPYyy69gcMBdDz94BcgZxf1d91Ia/eS
         BZTtTfJLN4O21G+r0jn7oZPxhZVDOEd72plNzKjfmFuXPs21QfytXuxt6LvOT3tLvYr7
         foTRi9/Mow9uz/a/+aznRZkjuXN4TAH6qV7G6tyeq/womIKGsG4U2vxFf3kExVdRqEtD
         sk7A==
X-Forwarded-Encrypted: i=1; AJvYcCU2A3zzhFKCQEqobaHY+Yix8g4/PJy0gwrkPQDGRM0NNVZ1PflXxEAZFEH0BEsc74qzU6o5ntE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEUZ/VHDWug4O08zOGfuCOFBpU3RnKBWtt+ZSQO7GAuEmtEYfO
	On6aWa0J+pq3+IMUP5BsfkCrJb67gcHf6IPs6hbG0yDXc1xWunS9mOow+C9rvQxBIctyJNe3n9O
	iEudaAS+uiCR3WW9hpm94iHJmyPs+MBO1rQMfrMun
X-Gm-Gg: AeBDiesrvFuf9PxaJ/65O/SMmZ0VvZZB0w3aHzJ06fqqYNSIajedzAg4kjosHmleZ6e
	QTLgRSLQn0MG80g0AUGKPs7fZY4SYvoNeJcH7imaBlMrBvfwunqP99eqNQMJcd0Mq4excYdsbYf
	/xov+YXOAOdIYvOBbfrogmystkoi/kFVXVrR4eqrhT22GE+kQdXbQFhfNHK0vK3kbGnf0JD45H+
	2z+tta5QuVgUarQsyEn/p5ZpoZOrEzJV2dPF0V0aqRCElFWAQ3t6kkQMeWsHEcQ3S6W6UZhpB8P
	gA7+7wA=
X-Received: by 2002:a05:6214:8088:b0:89f:d316:2b01 with SMTP id
 6a1803df08f44-8ac743c929amr5729256d6.26.1775668173910; Wed, 08 Apr 2026
 10:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408125611.3592751-1-edumazet@google.com>
In-Reply-To: <20260408125611.3592751-1-edumazet@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Apr 2026 10:09:21 -0700
X-Gm-Features: AQROBzDPqbmqAh97CnZyaqvAsUXpsUeP_VNxYTzF1L3GFRpSyorw-z0J4XehHqo
Message-ID: <CANn89iLe4jen+wQQ0JJ_z+OpEygP+Mpa5MOMMsV1pMmYLUD6SA@mail.gmail.com>
Subject: Re: [PATCH net-next 00/15] net/sched: no longer acquire RTNL in qdisc dumps
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-276657-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 88FF33BF504
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 5:56=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> This (large) series bring RTNL avoidance to qdisc dumps.
>
> We first add annotations for data-races, so that most dump methods
> can run in parallel with data path.
>
> Then change mq and mqprio to no longer acquire each children
> qdisc spinlock.
>
> Last patch replaces RTNL with RCU for tc_dump_qdisc() and the
> qdisc ops->dump() methods.
>
> Series was too big, RTNL avoidance for class dumps will be done later.
>
> Eric Dumazet (15):
>   net/sched: rename qstats_overlimit_inc() to qstats_cpu_overlimit_inc()
>   net/sched: add qstats_cpu_drop_inc() helper
>   net/sched: add READ_ONCE() in gnet_stats_add_queue[_cpu]
>   net/sched: add qdisc_qlen_inc() and qdisc_qlen_dec()
>   net/sched: annotate data-races around sch->qstats.backlog
>   net/sched: sch_sfb: annotate data-races in sfb_dump_stats()
>   net/sched: sch_red: annotate data-races in red_dump_stats()
>   net/sched: sch_fq_codel: remove data-races from fq_codel_dump_stats()
>   net/sched: sch_pie: annotate data-races in pie_dump_stats()
>   net/sched: sch_fq_pie: annotate data-races in fq_pie_dump_stats()
>   net_sched: sch_hhf: annotate data-races in hhf_dump_stats()
>   net/sched: sch_choke: annotate data-races in choke_dump_stats()
>   net/sched: sch_cake: annotate data-races in cake_dump_stats()
>   net/sched: mq: no longer acquire qdisc spinlocks in dump operations
>   net/sched: convert tc_dump_qdisc() to RCU

Do not spend too much time on this V1, I will send a V2 tomorrow
addressing some issues.

pw-bot: cr

