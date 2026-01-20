Return-Path: <netdev+bounces-251457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBmUJuBdcGkVXwAAu9opvQ
	(envelope-from <netdev+bounces-251457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:02:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5385148F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 06:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1185472AE2F
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63473A7DF8;
	Tue, 20 Jan 2026 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RuFIMCT+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01763491FB
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907896; cv=pass; b=VU26kKpuQN4nItFjf+zYmP/tUpO3jSmgs+ERfaEHHDlQ85fXtVrKjajq3grCagJ8vPyTY9QhWCRZsRbG9GLId5jw6uY8lzOctFFJyXST6hXnzR4QwEykmIS4L0DRQDOvdQiazJxgD2oe2SPwY95TWA+Kv7Fslk4KhBwO0Qlu1W0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907896; c=relaxed/simple;
	bh=IdT7Cnqlw0gbduzUyd6rGZsiu6oNpbZ6fLa8v0srGMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGLE6fh+swCOmzRX2cdPP2otU/TCUjZWN4vMCJl5ok0ELGgkwyIAXx4UJMwmjOWa6P1+aVsJQ/hcVwn8uiwtnWiCObK7+c2SkDVekPQJ3ynil+EI12HrMDCyp+bOAu7P6vvsP2v9I/tuxrK4kiaiSeMai0h70L6YwltynPmqyIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RuFIMCT+; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-501502318b1so42660991cf.3
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 03:18:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768907894; cv=none;
        d=google.com; s=arc-20240605;
        b=N1mSFh2ytEWKE8hSM7Hb/UMBjeUEzU2uP/t6doIIyQ+0tdWtL2wajGhZUEck6BA6YN
         H6qPvNSCnZX+js0rsZ89iXWgaO45edIz6EMQleZcbMBrd11Un4qcPXpdiWeD6d6biiUn
         P10VE8MLBungmAOrDUrI3PFihEyeAAKR4m8lNQaiE1gCzoY+Np9GbZLqGWPlHUwUKSlm
         Ikm93zameo1FcyLziHuO6IROqLG/eaxg5VL+ACE8AB1mnHLuFST6MwKzB7hz9T9dk9Yg
         +qhdBasAJqOD35z76WT/UGHo3cjmnNfQ/SBJNhxO/vdWTBJ3P96+3Nxhu/JP0sOmeRAU
         RMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LUXil22tiizCYyaIA03hv+e6KoZWp5K7Bky9alaR5BI=;
        fh=JfUheiQqrAJoIAlZuLrAdhXTUFiXVLLlCUoZRwMzuN8=;
        b=B9yB5dU4T7uVBqoHP4+z7dyLhjNTbeYWKpS7o11F83Y/RSoRP9oQQOlxm/qdPFT++C
         /Kj8KicMiPHzW4YNEgeIg2YkYx5zmeLmOBlf0tp/2gfCPU5ncS1GIgPHrQ/HhLzDUuAl
         iZ0cFZA2c0cc6Tx0dkeEp0VWmC9Ycu3xmY5Ea2jA2/FAKMOhjDsVWycbUKsgD8s4vovB
         U9nQO84UFyz3tD5IrT4FSdNIIbLrKU7ZWNG4wXtU1jYu9aQn4p9EO8+C08qh24O61jtm
         1iAJLIbXoTgkKjLB8qfuIVdcQ87zTZhEqn8AE/iUGrJAxowqU9rXR/PEKNga2m/wPXYH
         2ibw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768907894; x=1769512694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUXil22tiizCYyaIA03hv+e6KoZWp5K7Bky9alaR5BI=;
        b=RuFIMCT+LVz7niNHIRJQfbaoPRSsdO8Hqz0Z/J3m63nr6LKihwAtY76EjTAxL7Y5He
         DTI0+HBc2DA7Wws9P3a+ky+IPgAJiu38WkSpaLB9WI4HPkcQQJa1O5OABpYGa+wOaog0
         2Xbxu3SsZ+voGu4vgCZtfGmL2Jx9v9GWUY1tMOd4nk0RZVG6ynthaiaHNcQoixfRAI/x
         eQphwNh2B/mS+Kq3XTCmbTH89oN2NySA/zUtUdQYuoihubFh6NZjZW4Z0lv5RxuG5udH
         jlwtVEf9G+ok8ktVWOYSAZZ6NkFiMIZO0+uEHNZYn/kHcdsP++8gMj3Q8f5KClcKCmsF
         lhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768907894; x=1769512694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LUXil22tiizCYyaIA03hv+e6KoZWp5K7Bky9alaR5BI=;
        b=ZaB2uhU4cuLjYsV1FnoOlIYwVXjh2u+zIr2moEWn82xBczIq7te/1BTM24LPQrXUXm
         oRq/iiEEc4yumbMP2gaB4edE/seSSberLpY53TD8sh/UXI7FV+LFWHwJTf1C450H7seg
         cCVBbPLAXs7Tju4KE5EB+8i4Y2kn24lNwGBXvzg9Y3GIlMuoOPMv55VCxVurpi+Ok76A
         bKBCJnHqaiB+hqYSL4Ye84tPmD+UK3K7WDjVKEe5q7hucL5tnC6D0Xslt8BHEd5KHCjc
         WuzaVklwXeyAneVwOzOxnI24xpxaYquZxue8qtxb+7XY8XQ5CMQ5XEi2EOVODiyOd3sS
         0qVg==
X-Forwarded-Encrypted: i=1; AJvYcCX1mnQ61x0ZJFnbu8eU5n6bCwy1HdvEo13gF7zPpXpCxTXcgkZEWwg2vCTNm0Q2kccEgYEdUck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDy6zYNTlG4h+0waV0owSJpZ8czKpI5K91X2rf/Gv8c7s7/1DS
	o2FPPhyq4UGSNQiu1iTPg3ckIurgzmOHQxqwFEensbLg25+n1Ad9SFODbEoCwRgPkynG/WQ5556
	H+Xkn4ILghZHJkmjzldI44MD6EaLcshoy4BA502PX
X-Gm-Gg: AY/fxX6q0XMfl6f7Ka8wcDkxbms85V/FxblRMwgSxabUn1JwIYao4y6V6tXcSE0P26M
	L8QF5XxkJf2UPsvyxLsft1wrIP8tcrn12sNxK2uI66u1JZ7r0uo75c3/p5snyx54WLbooObFy6f
	fTbga19M0chuH/D+EbiEnxUyYtr80zHZNrfkddhjk/9Xl8v+TaHRyIRZ/a2TdSQViI8BsQFpMb+
	n5J4qRa6hmNn+0MTlO1l5q8U5u3OPBPJuUoJLNzxJlUS3o3eCClIR0To9osz+byFUQ5lpE=
X-Received: by 2002:ac8:598d:0:b0:4f4:de04:2434 with SMTP id
 d75a77b69052e-502d84b0bdfmr14314171cf.11.1768907893248; Tue, 20 Jan 2026
 03:18:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-14-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-14-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 12:18:02 +0100
X-Gm-Features: AZwV_Qgc8lwWGTeaXcXgJnQwinHD3Ss17Aa4vUO4GXRwqkl214KVxmDeii_C688
Message-ID: <CANn89iKhAs3rMWFdmM-rma1wS-Xd7mf9PBUQKL8YMKhB81Jkkw@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 13/15] tcp: accecn: add tcpi_ecn_mode and
 tcpi_option2 in tcp_info
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,google.com,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	TAGGED_FROM(0.00)[bounces-251457-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nokia-bell-labs.com:email]
X-Rspamd-Queue-Id: 0B5385148F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Add 2-bit tcpi_ecn_mode feild within tcp_info to indicate which ECN
> mode is negotiated: ECN_MODE_DISABLED, ECN_MODE_RFC3168, ECN_MODE_ACCECN,
> or ECN_MODE_PENDING. This is done by utilizing available bits from
> tcpi_accecn_opt_seen (reduced from 16 bits to 2 bits) and
> tcpi_accecn_fail_mode (reduced from 16 bits to 4 bits).
>
> Also, an extra 24-bit tcpi_options2 field is identified to represent
> newer options and connection features, as all 8 bits of tcpi_options
> field have been used.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Co-developed-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>

Are you sure Neal Cardwell really is ok with this patch, saw it and
gave his SOB ?

> ---

>  struct tcp_info {
>         __u8    tcpi_state;
>         __u8    tcpi_ca_state;
> @@ -316,15 +334,17 @@ struct tcp_info {
>                                          * in milliseconds, including any
>                                          * unfinished recovery.
>                                          */
> -       __u32   tcpi_received_ce;    /* # of CE marks received */
> +       __u32   tcpi_ecn_mode:2,
> +               tcpi_accecn_opt_seen:2,
> +               tcpi_accecn_fail_mode:4,
> +               tcpi_options2:24;
> +       __u32   tcpi_received_ce;    /* # of CE marked segments received =
*/
>         __u32   tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters *=
/
>         __u32   tcpi_delivered_e0_bytes;
>         __u32   tcpi_delivered_ce_bytes;
>         __u32   tcpi_received_e1_bytes;
>         __u32   tcpi_received_e0_bytes;
>         __u32   tcpi_received_ce_bytes;
> -       __u16   tcpi_accecn_fail_mode;
> -       __u16   tcpi_accecn_opt_seen;
>  };

tcp_info is ABI.

We can not add/remove fields in the middle.

You must add fields at the end of it only.

