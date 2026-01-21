Return-Path: <netdev+bounces-251949-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GGCD5HwcGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251949-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:28:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8C6592DB
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED603A6C391
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB75F4A2E0A;
	Wed, 21 Jan 2026 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjExIxLc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41104A1391
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007490; cv=pass; b=FTK+J+/zDtSTPmU2BxLpRpQnJaM3MeaoEO1DkN8R2RWYkxpW9IG9313k29yhiJPw4nln5KRJ9qpcehBCs7mT5iHI/Zs1pVp/hO84xnEVEPK5T9RaFJUYQ/iAMNsSsrULLUMKlrasSIycM/LDI7CGZZxaqhbq11tkaSBjIy0uFH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007490; c=relaxed/simple;
	bh=pXnTl94BbhB/76UcLMWFQmfo8hdhUhMeAxYtkkN1M+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R04hOkBFjhCWZs7LTGCc7TmeTadiURawGYIbKL+z+CdnFYfLb4tbnNMe4cz5qlJ5bYas7SL0EAOg2IX1XcQ6j1NiPYC6scBdD/ho2N2fIWFEEIFig/HtDfLFtsUUSjgiF2Hvs/COFsD/z1NBULLggqzONynhoFETtObXtWyhlLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZjExIxLc; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-502a789834fso42112801cf.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 06:58:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769007486; cv=none;
        d=google.com; s=arc-20240605;
        b=gsUSgdqYxhjbIi3zrJpTkFrj+UV2JVsWbok81zyiHt3NEfcyLIHQ5wLAUubb+qWXEO
         Xi23zTcCL7a5sPw/tl+H+KGQnprGyhUYSME+aAz6zx1grP/jSx8Ln1qSsHvJBsG8D1ks
         0NF9aWjS2OjMJQmE/SLFiDbw3rr3+R9S/dfqBAqUmysSOPwHVIXwR5VhQY92/JsOMjOC
         Z2bKP0gdy/5lzIaY1IfYMqtMEW+FhLHgbTSFo9P0Q1VSXZbCNV4cXan2TKvBLl79xyLB
         CU3O3nXNwYrslmKG3HCDhdNtBRfog3G1sq5kra5mR+lPYeNJy5NPmN7AAV7/pfgUfXuY
         Zmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F/VqqIhXdgX7j/dXUyWw4LxUrc07WTrCM45z7FHNuOc=;
        fh=EVniMq4rZ3z5QVs+W+lFCnnQFpXalggk19NLaweQiZ8=;
        b=dN42U6D4F52bwLz01P6ewRalAZVRUuN4wa4Kev+OHQRQL52SDgavDuzQW1HlY+KkiS
         Q4gS/8YXkyHs+zSA+ociwFrkCP4LZst2ptLXfWu8WL36tCP3tHgsaWTAjN4PDHOYQQhW
         Jo+g874QX4+dH4uv5sXhRRJNd6Cz5/TiyuQMYCvXulPt13Fi054rIxhG63KP/rR813Os
         /CY3qaZVgw5R0xtnVGqpnprHTC1ydnP3iSdE+AyR1DJBNnhGOej4RkO6lwU/R8cqB1RN
         JSZEScGSVBViJEBf+f9jb7w5Y+fpJouRb4raRer8Kaac3/RuzTlhGTX79R9Fdk/L1BRs
         70Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769007486; x=1769612286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/VqqIhXdgX7j/dXUyWw4LxUrc07WTrCM45z7FHNuOc=;
        b=ZjExIxLc2LNqlP24QAI+e6v0pZxcrEgpu+95SusdGyi51+bDN1XnBwncQP1b0ZlZUy
         HQH1KhN4CzuV41ctbFYWvDmZ4TWXX4kHgXU3DH1EIUgxX2Ud+34hG2A55SeTLmqKw9c1
         xnSA+aOQIIPWSvVGNDVLVmsIFwOFlyKyj7G9UJgbULURinDg1hgwAFme6ZzFNbfz4Ef9
         54O0ojMRsFrIZOCsXVmWH/wmVupVjp+L05gNkjOHsl73Nf7cDtHXpqZYLIov2KCctP8m
         kzLCuiZIAzeZo0n+Zh+KLbGphBEyzIwMC/HNlRnPyKtj39Cv/lnT0vaOOZapIHLFhZtU
         Jm6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007486; x=1769612286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F/VqqIhXdgX7j/dXUyWw4LxUrc07WTrCM45z7FHNuOc=;
        b=Y0+6SebOBP4/uKK7FOya4MMuMUGaylCN2+Hi7WcTq3rP6mcgCZBP13HDL9hnWXYmnS
         dBfWXWQ2Qjq09c7gez11yIP0ncF+eaGLeYYDxLQwoFxvaGGtPorlxJrBFctJseqeIUVl
         TJgNWvYY2tNSQdixMnLMOqbWulVULsXU6T/0c3m/V0AD3YKpSD90cLEdVSG0u7HU1Skc
         lnt3PPo/UxdtgqY8o28eZzsd5Wince1QZCmgrzPzewZDvO1reWV8E/ga2T1SWEUoUyix
         OmLlrNTgcFP7xcH9dQR258YBsEeJgYko1MTwIPm8iicMgzM/KPZIlSEJPrFbiXIgwMD2
         8zxA==
X-Forwarded-Encrypted: i=1; AJvYcCUCyEOKeGc0GIDhjyWtDHl9f6ylThrWbD6Sn/bR/fF+oO8ABVu2vBVFDPdsct8vWujdwvByDWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25yKfLciQpc8G8ComLUqEtzyOD+kDKO4TaLMlAZmJh1Vn9q5+
	spGLrFfrXPVH7idbDvhh+L1VG2mUDvh4v4tIsgQ9NSdvmmwFnTbFvxujjATH19GwR5dn2CRA+1J
	Vya0FP1CViDT2TKdF74PfKEX+GuN0TT5VNmV2F8G7
X-Gm-Gg: AZuq6aJEF2/hw+SkEzT5r3IPVoTO6udolHw+BKIpnRmjrkEtGo5SiVG+6Cm2w9FXMZc
	FdxQbB5KWa8eA88SQQtmfTIDTE4qAJXCQkEtcdHbZBPQu7cJnBc1om7dIa+auLkc9AKO58LUSlZ
	a+vDz6ACBchgXi8xvsLFd7P7FTiBvCY7DGskjR2iJoz0aKxozKEDs2PKT96aEKBNqy9OftT3efL
	xsWHF/lRT/UQYHwW8iJJ1KgL1Lla9BSu0nSRcKWY8rIvX2odnDULMMYSmMxjPjtK/xBpRE=
X-Received: by 2002:a05:622a:1b8d:b0:502:a026:3157 with SMTP id
 d75a77b69052e-502a1757181mr221595791cf.41.1769007486020; Wed, 21 Jan 2026
 06:58:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com> <20260121143215.14717-14-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260121143215.14717-14-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 15:57:53 +0100
X-Gm-Features: AZwV_Qj20kr6mRoNXbwQWdkosCn3zjOMui9Vi7kFMCTUHw3XP2Q1RPMTHZwkrjA
Message-ID: <CANn89iK3DOU4DX4=S-C7cKy-57DemUjToYVpYMT926mjFmyajg@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 13/15] tcp: accecn: add tcpi_ecn_mode and
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
	TAGGED_FROM(0.00)[bounces-251949-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: CF8C6592DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 3:32=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
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
> ---
>

 +
>  struct tcp_info {
>         __u8    tcpi_state;
>         __u8    tcpi_ca_state;
> @@ -316,15 +334,17 @@ struct tcp_info {
>                                          * in milliseconds, including any
>                                          * unfinished recovery.
>                                          */
> -       __u32   tcpi_received_ce;    /* # of CE marks received */
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
> +       __u32   tcpi_ecn_mode:2,
> +               tcpi_accecn_opt_seen:2,
> +               tcpi_accecn_fail_mode:4,
> +               tcpi_options2:24;
>  };

I guess this is fine, iproute2 got no support yet for
tcpi_accecn_fail_mode / tcpi_accecn_opt_seen

Reviewed-by: Eric Dumazet <edumazet@google.com>

BTW, are you planning to patch iproute2 misc/ss soon ?

