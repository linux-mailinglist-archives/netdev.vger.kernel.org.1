Return-Path: <netdev+bounces-251943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHoJIGnxcGk+awAAu9opvQ
	(envelope-from <netdev+bounces-251943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:31:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2201D59374
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3B1270BFF6
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 14:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BBB480341;
	Wed, 21 Jan 2026 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JuQvBZUM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0C33F8B3
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 14:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006701; cv=pass; b=bDxCfdUa4So/TGBkq541NkvgAz2snu6mJF5u/voChiyJJcquGjtO/mlpqkNmp8zQXqkT5zEYb/PpemMIOG5QPj767iQjhcGcnQze5f8vmkKvPJ02LBk+4Nek9wRYlhMLuSjWVZEAvu9DYq6rKasSobuOjGNx0G2UhKKW8kiLgPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006701; c=relaxed/simple;
	bh=Xu/hTwMLUvS81y97PgpDx0XsQ5SQXxVaA2e6jtW6itk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ghv8KBtcT6DMZ6JYugxcGl19LanzvmLsVa1IR0dPtqWSkZattSiILcFsC5KptG3Rj1iUEjM4TeIsh3j5Y6xtEg5MR1rcpuHM/qlt0U4TEdLUNDMjLR2BfayamaOHUEkscUzoEooa+DaoFEwoSNZ3nbVsJ7eI0sGh0ByySMAXjHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JuQvBZUM; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-501502318b1so53164281cf.3
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 06:44:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769006698; cv=none;
        d=google.com; s=arc-20240605;
        b=Eqc+FPx5kIH7Pm+dqFCe5dgYP8aPDdSBt9AkQL5xeMS2ecLQsa0n9D/+zgzvy7Leqz
         Pq8Xu+wPyD/1Ya4ApSN76KJLyEAcK+VpwXTKCFTRYCU47T+ageX44A4e2tSqe+0XSZj3
         v8/Kx6CGFuBfvlHMsff8GYd98JjFrJFv7FFv+qLzQD3enWZKW5TIGwQm5yo0l9mfjCjR
         zi4W9YJyByztXTPGcDxOOoAzC7o7wGlbQCPH4qrI3dDcEalN6dEnH6QGOjbZKse5oEWl
         h/fnWkRPiYsMtmv7IKF8rz4DzS2EYXdOErH93iVEOfC1ZKsqN19yAIfqlVuxLdD15wTi
         EQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WDknDeeriRuUySYC4BIAbGBmZKe22ziZVXk3IrvrB/Q=;
        fh=nu5ejpi/mPb6liMPCw2AYv550Wc+Xnbk5pzNdXjBWAY=;
        b=DDVMP7Xp02mjHqa3SxFT8SW1xetolctcbc6oThdxBa47U9SbEJqfAb/B+LY6kIJ8YJ
         Wg6dPg8/zNlimpGD6OlnQ9xr+KpdR8Yhkh1u+zwHStKdEACSfVO0nfxEOe+T4Nz0oNFZ
         GhexkDxnRIa733Ed2YwY+SRDVIBzX65UhoMzNYYF61gryB/zxZMWDEuq2dxDRgLof7WD
         1jEEyY6j8gUdOPkraUBRH8My+c//gTkdReLgHN0StKCKGuJVbfYHNFyS9eGzZQpHPckl
         KfiXtSdSZvBPx9vTC8HCaKI3wMqx26cAyUxkXKjSrcquMJhCj38bRWs0MMV/J3mCZkvH
         /Vlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769006698; x=1769611498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDknDeeriRuUySYC4BIAbGBmZKe22ziZVXk3IrvrB/Q=;
        b=JuQvBZUMHV8GkQ3lzJYfdnQSMm4I6zL7A0RLc3DyjQw3Mbcd8OIh5NCJtQw/sjopJA
         9/1MeMk7SYiiaRO5wVZfUZgKWR/AFdT26uMakfQ0NX7Jjm8XoUcW/D6PfDFUpUpnzAiF
         iv1uhgi+bfkm+kII3eD9OBZRyKdTbFNCS4fDS24MWA3SGzdF3WZ0KMul+LF0QO+1fgWP
         cmJ+nrWapmZTKD6jUKI1Ay6LZoW9NuSw/CkzlZw5ha7PynzLodke4JfvzFg018aEI9LS
         Qo0Bigw9jyGM101Q84orsOMJAsgBqHoTZSENBE84WBA37y9XFFZsivmguyV/AsHgneDM
         V4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006698; x=1769611498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WDknDeeriRuUySYC4BIAbGBmZKe22ziZVXk3IrvrB/Q=;
        b=enqzGHhsYAX4bUgmstV/AO0o3bXWC7psEPLneX9ZcmNklDOlW3FX/qdDZtIlOUchMy
         dkvWbSpQT+JP70yX/rr6HS2KoWwzhJ6+J0Lcx8kQd+KG4NtkWvVjOlLW8l0eJEOp21u8
         UBZ6u6fFOhGdZG2SopiQY1kgyL+rpIjO5L4T7mJbT3m0pKLyh6lO88yYtWGBhZLrMuTp
         NMOiMLyXD7sETiiDFEvB3tUoQNwQRCzekE2u0Q7l35ZWsIdyzcWMJV0MDHigxpEw4eiM
         rkZWQcN9A6C+fxgnfMYBMi2Vz+5Yvl/nVEfJhPEOa+2IJ6xnlffMebxZT0+n5Bpr23iM
         fiqg==
X-Forwarded-Encrypted: i=1; AJvYcCXKT9fMUbnfAMwhFwjVSktqsi5MqAalKMlr4jawpOlesTrqtrejfhjXbrWIexeR5/5bI1I5c2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzooPcxYGytJW7wPfrSd7l0up3u3EA6FLdOLUtR2Y4bvrn/2lNy
	nMYgjHh0Di5vTGiOLHzgYmNeDxiZ1hHhVzvHCKHBEe9DLhklIqXk7j2oXePwqPEp2RVqvcp2cZL
	mnyP6RnBXbEgngl3ucTy5J+amKhr71tC1rZ2zbHr+
X-Gm-Gg: AZuq6aKKFd1UL4jL0kfJESh/XnVK6GLTf+TZo4IYUL2D4+7Sxu9XT4z9jEDuWHz4qu+
	aFhy4UZpxKAiCnGuwywrjKACsqCIlETG0xIDjVBthd7C4KpcKGzYcTA4F+Wqod8KBSRYJSMk9hw
	OMlPEnypxWQGzyFNGVM2D2qbO3yW1gjzm+3zQxTjzAHd6X9NTR4D5csCu/o5PNJLvi7GNYesl5D
	G31WcNeQhVfHdmeUgPMF32oxmKLBcVsdCdPe0UpMaPxpBOEpWY13pOeYHOci+dojompFMs=
X-Received: by 2002:ac8:7f89:0:b0:501:50c4:a9fb with SMTP id
 d75a77b69052e-502d85c766dmr69283611cf.80.1769006697633; Wed, 21 Jan 2026
 06:44:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com> <20260121143215.14717-11-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260121143215.14717-11-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 15:44:46 +0100
X-Gm-Features: AZwV_QglfYe-rR61PYDqNirvWqL5d8wU90xI4swixYbQudivaPcO8KkO1yRJQIE
Message-ID: <CANn89iJz1Au-kfk8Kp001vwvuxdndYX-Y++vB6NK5A_CBXVLHA@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 10/15] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
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
	TAGGED_FROM(0.00)[bounces-251943-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,nokia-bell-labs.com:email,ietf.org:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2201D59374
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 3:32=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Based on specification:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
>
> Based on Section 3.1.5 of AccECN spec (RFC9768), a TCP Server in
> AccECN mode MUST NOT set ECT on any packet for the rest of the connection=
,
> if it has received or sent at least one valid SYN or Acceptable SYN/ACK
> with (AE,CWR,ECE) =3D (0,0,0) during the handshake.
>
> In addition, a host in AccECN mode that is feeding back the IP-ECN
> field on a SYN or SYN/ACK MUST feed back the IP-ECN field on the
> latest valid SYN or acceptable SYN/ACK to arrive.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

