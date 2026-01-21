Return-Path: <netdev+bounces-251951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMTEDHL4cGmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:01:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D6B599A7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFA69A2A35A
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49514BCAB4;
	Wed, 21 Jan 2026 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbCPjr8u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2285C481FCB
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007837; cv=pass; b=EwlcGWgiajZrUDt726tU637692RkvSKvuJQUFMktdQVsODPKbX9cmbAS7Xum2CgabIZRdwBMEBexmzb8f5x4Dw/TKeKbPcrnu/vgZ9Ac/q4D4yaJk1Moe5O0y7qvhoE76iaVRl1wI3vye7g6amtGI0CjHvAJfrQi1V/xYo5nda8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007837; c=relaxed/simple;
	bh=QnaNpo6lSG0kfxJQjSpSQ0lKtOo9FhwWS7NgxulV+90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSwGIzXig+IIhY0jTm4U+RPzCwuZNHpyI5vo5oC0fbfGLbdFqmlkoXcGIU2UbPnQS0f2m1e3usBZT/I4C1MEycXPFZ5wPzIXM1XkO0zUonMZBqPTvokJIJj75hoVLfLbHpn0Swd49qwh/topiR0B7KDF/sUN2wTfTTU6zrYBGoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GbCPjr8u; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-501506f448bso39396251cf.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:03:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769007835; cv=none;
        d=google.com; s=arc-20240605;
        b=E/uMTqFNqkarHYnHWK4j/PHH3mFquKAiVL7jwY+qqFBkQZdE/jz4gmu7VjbdQyw/YM
         fd+BxfZYlVOFjwErwhF9n8EkwnVXgdgH0aLGUh36iyjn+Ds6mSR32iwVrEG9eSgGnQQB
         TSr7NEKNoQNL0tv8GznafchkilrPpl9Gr06a+3D4C1Tvt7nC2tnFftlrf2M/R5w6CuQG
         fjOzEU7++NffaQaFGzWA2rLdm/12rrEj5mpHbjpYsLNRYabbBNeb+1vH4cKF8APP+MPD
         67wtZ6uBNLNHdASGVCWix3Ec8UvqsNlIyQ9CVrDyQ+yWFq6qmud7k+QgGIxVq3zj4LHL
         VSzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BkfXslef5CleGTOMTYe++OlaJ9VsT1NdIrx0Bt2jP6E=;
        fh=94lZkp1YAftuiKGHU7UM9B71kbRXMASvJxpMfMg8dYo=;
        b=QWMj9Q8c11Ks2CC1+oWzm5PV7ph/sxAmoAVe1m51UE0MLNTwM+rL8xdS9CXSLKvSjR
         xPJHldfDjvdzzRRo/JotSOJKVLYZbGcTkjuwLTq2LDaUj9fDYI/St/570bie5SzIS8ew
         fwQn48DDdDop5dvccFA6adbbPpVUe3JAaASM7qf1h3WBYHKv/+aztTCLvPNyRk9GxLCK
         aPY/Mw8q5pp8JFZj1MFdD+ggOgXYVmypEqKJulYMbUCjkSh0wGsVFxwDUHOftVM6hxCW
         y54fvYLziZ0TnKfIGhojx1Dq1uGSbk7LjNLxzN+IYcvG8BeXhuE+IDzRMduytyVCWFiY
         qV4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769007835; x=1769612635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkfXslef5CleGTOMTYe++OlaJ9VsT1NdIrx0Bt2jP6E=;
        b=GbCPjr8u0SxkrNuOj/F+aztCCHfE5nwZe9Et23PvmkjZfL4RKDUh4WSOqoedBr9LHH
         Hw1PETrMTJsNeCxF1eqy0FlUkwuBH7i9JmVdG0a6bh9wA+of1Ty0d+pC6JqdqOCw1pBf
         i4XCZi8hYLgRdvEC2MDuyBaH/zrJH+/7CkT4MHypOyO/Aa6hxdJsaiUIkBetAeVlMO+W
         B95p3FLmq5CDKQT2T+MBwcJbZHNwL24IMtPagFbPJ2yF0eZ/gi2tKDRsxJ3OFYrVkhVT
         srzWEQeIXNXAABEP3EfdHSvVVG1DosM/p78pjkxF80ZM08HE+LeK+wDQNoeYxSaRzo1c
         Dseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007835; x=1769612635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BkfXslef5CleGTOMTYe++OlaJ9VsT1NdIrx0Bt2jP6E=;
        b=RjabZX0Z1/FZIUGuNDnwEKzjFmrSrAiiewU2Df4VND75s8oO/VCI81vENZqPoibMA3
         8P2L6mS+cQXsu2PBE00NFaBBabfBbjdai5U65xz/2nUcMIBs0vMqv9RNp1GETufaVLMw
         X3FagXPuo6IDYvU3D/hthcbx1lb5oB0mp2B4qLWmBC3q5yXE/YwZuu8RGprE91bjCvxA
         4GcLZmVwfi2GZYfZph01IpQQJ+hy0Cbt7Kf43oVMq0NvT3mFjIEVFhG6FqMEcEQK+6z4
         cQDd797HfUy2AvSb2enK35wS3zWxg+7fYUthL+t3I5v1u/C8QXEvEH6IgCYy56cpjPbh
         UOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1OTOMH8hvhi5KIMnjlzr83w6MtqnaU/5znf8a2dwBK+GTSZ5Frd2HufJp2ZjJObXBNgJEzzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdXbh1w4iy3hWAPy/71IDz1OSxkKMfurzwfL6P4kaGrPqCroUJ
	EnVG4nWVWt4b1t4OKtNjxYWVZKT+TucBaQVZ2Cud2D0s16w0IlP3871A3pDzLBxSyeYHcssOF8g
	kHWSF+z5p8/1uocp67TgGYb20Il4SHAMY/qrMGTlK
X-Gm-Gg: AZuq6aJ3FKxccpbVzIC2iCuGKFY0reYYxF6jwcq98pbkcR8OqqsgQlNcU7Q2YSA5UI+
	AQ1FgoXyIf5nk84r9DkwDd5KnWLXqb1fX3BySPQJhR+L2U5KMfjNETqf1mq+/w2vTyRLfdWDOL8
	nMJNG77W4gzWM0FreTZ4Pr2sYgbj7VjS4Orvl2xqbG8Tat/oUbb8JiRqPM/rTlOqoAeHuXmIzLP
	ZFL8EV2rQb+KMBgGmwoXrUGycDWuoCeeiVTEFVLw/p8rSGPLYRr6Lwlkk9LK0AMllGdCys=
X-Received: by 2002:a05:622a:180e:b0:501:47d3:217a with SMTP id
 d75a77b69052e-502d829a969mr66313571cf.25.1769007834257; Wed, 21 Jan 2026
 07:03:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com> <20260121143215.14717-15-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260121143215.14717-15-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 16:03:42 +0100
X-Gm-Features: AZwV_QhPskOIydB8GymjUhQQqHYwHvz2ukB4yAm_VArjAbRnW32yObrkavrJhr0
Message-ID: <CANn89iL6ax4=xk1Q+KhiSRAQwCRpOSPVLTe0gwjBf0FBd0vm1Q@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 14/15] tcp: accecn: enable AccECN
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
	TAGGED_FROM(0.00)[bounces-251951-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nokia-bell-labs.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 97D6B599A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 3:32=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
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

