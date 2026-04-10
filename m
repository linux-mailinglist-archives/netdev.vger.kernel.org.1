Return-Path: <netdev+bounces-277503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FbKLFU82WkHnwgAu9opvQ
	(envelope-from <netdev+bounces-277503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:07:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3F33DB52C
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C83EE3031AC7
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837063E3D8C;
	Fri, 10 Apr 2026 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQfCHLOo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F84F33858B
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775844434; cv=pass; b=bX99V4BiHzHD036yBiG1J9yDwyta//BD+CZ10hc7WBH4NEFbbByVhuXz69/dSD7RZi7oQjYJSwRVQETC/DP/p84yUl+aZ6A+RmMQE1FcfN8HnvwQyeVDCXb+1AQlK6QQxv5LTkSnWPfue5gAcMU7HeyDM3YNcmdwMFtP2QxBhJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775844434; c=relaxed/simple;
	bh=m0SqRtjpc8fweCPgbIsrD2d0z6GAWlzdIRiS41O4cxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFR6r7v3cc+0Qw5SRqrW+bAz8JC8eb/Lk7eHCobaeeiQ64XkuPkjRlhfnK6WvhwIj2+9m4G8Sbm/TBUrtkA1BB6+apIKgwjQiLEdHDEAQ5DxIz+cF25iVl2uEjVjf8NAhi7rVF+/Uud952pjlBTHEa0Xrx4uP+1+MzZGbNO5GGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQfCHLOo; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66fb5f2183fso4138387a12.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:07:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775844431; cv=none;
        d=google.com; s=arc-20240605;
        b=g2SOeBHdINgsoFTKRbzdY9hwDwVzXfbAu6NWfPxeJFC8RPmlSf5dtN9ZxpTMGO1WNY
         wKrYdqD3pX0JlTs38LX0bxDzXsRB5LCTq+2O8BUubbsT9CQ1dkssXWiUqPvkZKoPHrbm
         hTJvKxaBFwgZkMgyTTszptdkrQfGnWt5HqJZtcSIW6KlPOwg7ZGgBvO0F+T3cA20ZBU+
         7OR+xcoZ4RQOH0ZK6IrZ9h4NlNDGuEcCBhxDRIgs67DHrRTFQspFLlqcjKJzklUe44HM
         kk+LXf32AxQ19NwC1NIsF1zKhdscReVMQ4Foo7zdmJUmoh+MEUIsd5yVH4WW+5ijMnKe
         nHAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGufM7na8wMpN8zx+blIkzaxv+HrthUqBNiPXsfFPcU=;
        fh=82KOFMWNCkTQRUEEIlzuEQiA42aAJOYUsDGMsQp4aOA=;
        b=Y/TH1kSfTSzXat8PzNnir3UwN8jOLuMKWA0HTevzZL5TpoM6UbEcyv5tMUgh6mmdZf
         nASm1e+OYvdi3/fvzBVz5PxzeJCEgdGZ2Yyki0i20pOIMa2Kmjcn2YShOtpO372qMnJ9
         DljOGSKEcoMGXTnK0nz7Y1DozXnjhdqsndQ8c0IZFVKvksOqf++0MYYFOK57yEy87gOT
         ELoIsAbzChuja4YdrHAhhV5SxZxSxhej+MMDm1s/UyO9bKKvz1kl1IMf643xM1aEv0Sm
         aPkKEZjvDrp/z8BTjpBJlAhDkQRnPHXrDzfS3Bnfn8kNLVuRwlqqC51u0xoObl6eyaug
         b/aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775844431; x=1776449231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGufM7na8wMpN8zx+blIkzaxv+HrthUqBNiPXsfFPcU=;
        b=MQfCHLOo+qYEVvGmLEQmTa5Ni3SM5nsNXEX0fpNlC1dVrMvE9BEDj1b+6eYfLMx4CS
         rZZuSg+ayDrdOXtIUGmhCzWY5wsjWVdPjBrzXRo1oUniFnOL9+rwWWC1ab0/ljBGCdOj
         ytYxAYMLnRTKptcWh8YVOKldvNQokwbRfyGDcwF0bb9/sVp7YxJBl3uV6uni8Ms+iB+D
         rRuEXhG06pO0VtZgURzb/P+5DA+exXexKxWLJrDhMZa/R6t7XuIU9UztZEWIXh74NFpb
         GqCPc6PtwFFD7hqHuoudnKtL9zt3dSHZhQl9j287LFwDNHWAypuYb78jzgV2DSsd5Ekr
         +xSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775844431; x=1776449231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mGufM7na8wMpN8zx+blIkzaxv+HrthUqBNiPXsfFPcU=;
        b=Y/bEptlO7v1601mEftzRBseGpX1UQCKV+AsgIX/D+bRY982k/85T4Bq4rVWAbyQCm4
         oYjqhrkBRNCxc/bMw6gtQHMxRwamANkJ+wHhn9frd8es3fU0q0SCYNg9NX+Knm1aPm55
         i6GCzuKXgOPQZVLJl/r2pVTjz6Qqsn2Fkky+RiGofuAKe8GzVaruygqv/XUNJjUtd+Qm
         v7MIuA/lXzrq1aag74mAQgacDa68DYcZbF+2NBROX9UmYTcCPWSxpzIu0d7IIjykdIae
         La5RWIo9XT2X05NG/Hl7KA0JHH1Bms4Nt6m7qBI3Vp8ege57RulKFTPTlkPi5vQUfisJ
         B8Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVLk7scLHl5PSP+i2o0UxC+K8UZFsIej9Qvj0u5bmzgpMdllGeYOi/nQ8sefDKMu3wtYLszjD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTuzJGn3Oijf2UH5EID/89LqnjOkBRiFAGy3/FG16tB7WQqKCy
	npVB1vvBJFD7XmdwHUS/bPZhZUVAYTI4nxQYGTuHhBXuuO8eCAa/boH/u+th6a6s4HSE/vqJEDR
	Pcz3KKWHRXLFk0hGKBblmzEflHP4mz68=
X-Gm-Gg: AeBDietTAOEEe51v6z3C9Iw1WpmXibuHDbkQfpkagfD55UptofH6bHIh3pslQmnxJdE
	SD3DVXr/yYYfvknSYTZWbOKT5EukT+mGD0ILdGvkxUfGMDtJ24feQeuSw3FfY696BhYZVNRzt6x
	UjENzAvzhUy5Z3xv4ugy+mi9/1ezrwXpEA4OiHS8Yg0KAFiZ6blQwdZL2XQqnbgIVs0RBUBFg4v
	0F8IKaF+ld0gnQ6IdX9iGNKt9ta4kZdc/ftfF7VU8SgMTKaF3OOkEyaBs7HYXciz5/U7zH0Yfxe
	PnsrfhA=
X-Received: by 2002:a17:907:a1a0:b0:b9c:55e8:fba1 with SMTP id
 a640c23a62f3a-b9d72980914mr205690366b.26.1775844431242; Fri, 10 Apr 2026
 11:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403150050.1235-1-royujjal@gmail.com> <20260403150050.1235-5-royujjal@gmail.com>
 <20260407134502.GD849209@shredder>
In-Reply-To: <20260407134502.GD849209@shredder>
From: Ujjal Roy <royujjal@gmail.com>
Date: Fri, 10 Apr 2026 23:36:59 +0530
X-Gm-Features: AQROBzA5y--UIRYT_Yu32kHeVQkZCbum9kUmK0fpAAGLhqzgcbax6qOFdWZqhBQ
Message-ID: <CAE2MWknjWczxM3WrKkQ0eHV7PdNxMQ62GnTAp6tCPToumZnE=Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/5] ipv6: mld: encode multicast exponential fields
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andy Roulin <aroulin@nvidia.com>, Yong Wang <yongwang@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277503-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E3F33DB52C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 7:15=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Fri, Apr 03, 2026 at 03:00:49PM +0000, Ujjal Roy wrote:
> > In MLD, QQIC and MRC fields are not correctly encoded when
> > generating query packets. Since the receiver of the query
> > interprets these fields using the MLDv2 floating-point
> > decoding logic, any value that exceeds the linear threshold
> > is incorrectly parsed as an exponential value, leading to
> > an incorrect interval calculation.
> >
> > Encode and assign the corresponding protocol fields during
> > query generation. Introduce the logic to dynamically
> > calculate the exponent and mantissa using bit-scan (fls).
> > This ensures QQIC (8-bit) and MRC (16-bit) fields are
> > properly encoded when transmitting query packets with
> > intervals that exceed their respective linear thresholds
> > (128 for QQI; 32768 for MRD).
> >
> > RFC3810: If QQIC >=3D 128, the QQIC field represents a
> > floating-point value as follows:
> >      0 1 2 3 4 5 6 7
> >     +-+-+-+-+-+-+-+-+
> >     |1| exp | mant  |
> >     +-+-+-+-+-+-+-+-+
> >
> > RFC3810: If Maximum Response Code >=3D 32768, the Maximum
> > Response Code field represents a floating-point value as
> > follows:
> >      0 1 2 3 4 5 6 7 8 9 A B C D E F
> >     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> >     |1| exp |          mant         |
> >     +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
> >
> > Signed-off-by: Ujjal Roy <royujjal@gmail.com>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Do you mean to include "Reviewed-by:" tag into this commit message or
the entire patchset? I will modify and send v4 once I get the reply.

