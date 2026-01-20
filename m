Return-Path: <netdev+bounces-251458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMyxNwRdcWnLGAAAu9opvQ
	(envelope-from <netdev+bounces-251458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:11:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A887C5F575
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 00:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4EFC606307
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 11:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0F4421EF3;
	Tue, 20 Jan 2026 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3L+6hw7+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544DE421A1B
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907995; cv=pass; b=cAn94FPFQ7+5K/4OKaSBhVDz2jDT+xJlOkGHGorYe0i6KnfweDow7r7/KtJbY2n+aXsStTCpj0xHZp4rGeNNbKDSwMnEcuRWmWQQB2+hLEymGejHfIbhc4cVViEYSk7nAHXRmnSdxWp/UfF2ggjpVd0JjmPMGdUKxoto+qR+PNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907995; c=relaxed/simple;
	bh=2SaI+Uz3QGNZurl++WnxVltgVZ/pVYMSpuX7ISsHQbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gbo5EPAnWnlJ4+fhGuI15duysQr2sUDCvqZ2ucVgpGTYSf7iG4v1297bn0OLkqQhicNkwzi8nH73EKis/8Q2yE9lP3nAxkhOHzi0va0LIYZeSA+qNhSpTXwosegLYKjHqJkbBIAhTZ/kpJ20sx5EDg9Y0db7K1Z3FO1OgxKWYps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3L+6hw7+; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-502a4e3e611so33694471cf.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 03:19:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768907992; cv=none;
        d=google.com; s=arc-20240605;
        b=fe/uR9jjoz4M2powBOm1PY/iSwhQ3uSkNiDGxrgixLfjjDQjrExutMTaOSDawwU8zZ
         HkxAP4vRL3uPJNewRmCGgop0Jo/39NFJNbVMCRqfxGbxl+hLPsUybZ5qqHCnrx9rZK2w
         O6bYqDToFJLrI/1A9fZ5v7/baZTypoHgqtjiaNrFz4SNJ2IAOs3vdrA/+iFUTEfP1I/7
         xLzmHXaXoHzN8FJiXohYFzh0InWygAN/X6K00UjRh5OBZmkW+9JNbccELcfRZ65WUkKs
         ZQqNOy415vbD7a4WDxbqmfKCkxQF9YIM8RgVsD59Mgcn0Pohm8pCYrLNRGTEAjhZBKSJ
         sU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VqnDOdzFUDP6Yo0/hl8kW5DFgiqEg80gO7B+GBRDshA=;
        fh=LToPmgZbU7LPsWHZj6oqdDa5Vp8mP1plfn4ofEfiQlo=;
        b=FJDl7jgzYV9xXL+I6iOM4LMyeqdvMndz2F75w11Ks8TDmNVClLYLHT52GaUinDFApY
         D8JmyFKl11seRlRiZNCwgjivaT5tGX4bzpjCWlv7tU23R/fSxmxdl3vjKrwQWp92O2vp
         t8eXeERmVkTxHW5HgDKBNxyuo5lA2uOILw0vyHx4OqCCrsypKF8KVq5iwZsNzbrpBbi2
         85lOnixkcRCsbG/bowI+fZyBakvy8e9/ZwrSr8BSc+D0K+Z0li5wYIToPKAelVMIwos+
         WqiZjEyruzTF3z2KRuOX+4q01RucgLAokjbL+S690gKUkI4rTF6Pmc9n3wjLi2XiYLiQ
         j7bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768907992; x=1769512792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqnDOdzFUDP6Yo0/hl8kW5DFgiqEg80gO7B+GBRDshA=;
        b=3L+6hw7+J/bvuzDos2PmP/fEqPXW6Vv/PafJcFx6vJQWpS2lDQhi9uQtq/88F954o7
         vd6e8kufz3LdVkvcgn5AsHHXaqNSpGEYnePLRl9cSosx1tHx37i2+GEW1svJZz7rbSfg
         MVwdzPKbpeMLnZ9CwwtLryrxZr4mBubNjBBu9KkyZcUeQiBgQ7vfBuHGvQk+C4+1GaAZ
         LxpLlOj40rEyQqWfrEGhYFBEkurwtlBWUERzWK6+uNh11EU4Wso03UFCiB1C8dxESqRi
         9IhG/DqVbR2qB3E232HcKoyLKpS6vbr9KoB07TtGlLQLXYEyzTbgkDL437C6Q+jl+ZKc
         0deA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768907992; x=1769512792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VqnDOdzFUDP6Yo0/hl8kW5DFgiqEg80gO7B+GBRDshA=;
        b=JXxA2rNzYovt6BJb+x8JIy97f8FFC5WTlZrO4hqtVlPja94Z709Pl37jT7724Pdpll
         0zBr/91ix6XlCAx9I7chKzLqJ+sInlFigl+FSO9zJLeEBVRQ+XgDPszF67+kTT+dOUUV
         Hr4mg2wGnn6vnpmjUW7PFp9MNu5y9F7bNGf+rV/881bbsBpUnin3gdRLeTH8OoRkJcSd
         8b26GloyFrOwTlunuj6dITVxrg6mdFB3zw48dpWCLRlEkIy2hI/+lidPOY0zcQHDbL2h
         euRtZ6m2Ll4ndbGZFJ71OPaFquSjGF89EE2kzjK3BCKKJCutQuhGjTso83Lf/chXHBjJ
         9PWw==
X-Forwarded-Encrypted: i=1; AJvYcCV1wqWRSIecN6BK8JZ0s6irCPROClWB2abnc8CQbYF5WhPFP2OyQTCXUyZU/Dp7t7bF1QAHkM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNdmAl3H/EDL/gLPUAbfNo3ZK1Qd5frRKALxx2AkSY0fyB51Pz
	dj7y82nqopltoDSRp7Uw1x51BnoftrId+6eZmj2YAdn4tnZ7ZQ0maxXK4id2MSeGYIwi9Cdmo4L
	lV7o1Uo49neATy94bwU5/FxyKrxTcJ0VseRZEIBKS
X-Gm-Gg: AY/fxX5ZhhRywbmItgIfKjg/7OKRPkPoOPBYL2Sogz51iAgMvFKKcjTNypyGDLFiPWY
	ZWMiGZlUcph/zB7jImRhVnRdyKGbVNRTyev9MsxCNdpWesLE85nQaxzBjkkRBFWlAd6Gp8K/NJe
	JDLImE4lhGvGlFItvTuntOclSQ4iQYQLTaTd+sBgCIIx1PrvJpcqTZS1Jfm05uUJDFBVbkdhjh1
	7mx3rQEDHdW3L8hSrnZI75AcLI2NhpRnZjIuR8Qyq39dS7P2Kda+5FEgNjutPCZpUdMbGg=
X-Received: by 2002:ac8:7fd0:0:b0:501:7d6c:2d4e with SMTP id
 d75a77b69052e-5019fafcbc0mr253993531cf.42.1768907991860; Tue, 20 Jan 2026
 03:19:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-15-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-15-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 12:19:40 +0100
X-Gm-Features: AZwV_QibkXIKRoXdwgvYg4Ojoj32k0JWscBRg_R3cjBAHC3thHUdUCmCY1qsLyM
Message-ID: <CANn89i+fQQvoVhpg3HVh=RerB1tjKi25kGypVh3fwob2HWoH2Q@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 14/15] tcp: accecn: enable AccECN
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DATE_IN_PAST(1.00)[35];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,google.com,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251458-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A887C5F575
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Enable Accurate ECN negotiation and request for incoming and
> outgoing connection by setting sysctl_tcp_ecn:
>
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> |              |  Highest ECN variant (Accurate ECN, ECN,  |
> |   tcp_ecn    |  or no ECN) to be negotiated & requested  |
> |              +---------------------+---------------------+
> |              | Incoming connection | Outgoing connection |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> |      0       |        No ECN       |        No ECN       |
> |      1       |         ECN         |         ECN         |
> |      2       |         ECN         |        No ECN       |
> +--------------+---------------------+---------------------+
> |      3       |     Accurate ECN    |     Accurate ECN    |
> |      4       |     Accurate ECN    |         ECN         |
> |      5       |     Accurate ECN    |        No ECN       |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>
> Refer Documentation/networking/ip-sysctl.rst for more details.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

