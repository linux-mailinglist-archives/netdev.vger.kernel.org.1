Return-Path: <netdev+bounces-256562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCAaBAnUgml5cQMAu9opvQ
	(envelope-from <netdev+bounces-256562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:07:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE99E1AB8
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3820E3045667
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 05:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC3352943;
	Wed,  4 Feb 2026 05:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFvAyJWP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4B92DECA1
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 05:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770181622; cv=pass; b=FtpWXi7/rZ8KGWKFmz1jICUqGM2gLICSzifWV5+RZMiCobVSVsT70i6zPfUL2iB0vZPfsHc+iCSsePaC2Bo7cmIJfoYt0aqdVgdI+Yhp7U8bHSSLRET3NDcsOWRh/E7CXDN70eseSzKPgrUZU0Ew2YIsh+fGLX2wI5RZ41evoAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770181622; c=relaxed/simple;
	bh=uYblh75sinfOELc2Du3NVGGCgB+ks7J9IkBiNZ3OyzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hh7m956/veEEUF+vjBt4J078YhmdSX+RZLkxfP3PkeNepVuH7pQivSIPGgFEp4FzgLZeOnEZQVyuAStpvQvEakus0w+v1FCYUkby2VCHes9ic3rRfV62SgLXO0w00O3GjhHgW7Nslg2HrF6c9fSpshqnHCR4IVMUVuH8Cj6yqYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GFvAyJWP; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-505e2e4c35fso31351361cf.3
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 21:07:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770181621; cv=none;
        d=google.com; s=arc-20240605;
        b=FWVrkons9C3DWiVHvVSuHI1427IRn3JyPFZM67MiueuViQ5uDXB2Y0hqudGveMpdMu
         vmEo5bnMzhRlf5QA3xKRngUf9mw0nFXfVFRGjcMKflBzESw7mGbYh0Gmw6BeOCM7m7UY
         bmeTGk2d0Twd/BGvI3mLdxb97oN1J6mRZfEHBzsfLglV+kCqYY2LwndRPJDmAzXtA3RF
         Ktj8pReQw5+WzmMpMs9BYpqq5fvQLaPQuIYKf2Wy7btPJ/A8Du4xundCU+qEuSoPLRMv
         dYUBqJzA5jFqYtVSgC3LYoMkZwmyEojtM99Vs1SrXutJDUv5bgtyTKZUWF/QNY+R28yg
         4p+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7klJ34bE5c21vIGvZtifvnvADyVovGFGjq67k+fGEJo=;
        fh=KDDcXEseCp2EEqiBfdyADjVo5PsNWdRUQwVy0DUavXc=;
        b=dCUWCIOwPCbAMSlf61/NGjC3xFvswoG5JEk/ps0szLNT0xMFQLsJyD1pwOG+KmznU6
         3c+5Me9i2OTKuko5uy16iGac68/zJ1bFPVRqHi1BpNHiqfcvwIRHDejJeV3s8FjmGIt5
         lePTa5xA8XZxSLFqKYRc2d43/FwEsY/gKma3jBqywcjm3mQesGsHl59vyqT1EJxkFPBD
         WfgZmSNgo+XrPX5ogytBhLLJVzJMtrGi5qNb9Jy4fbUP4Js0WvFDRpIgIPSwN/SEtu11
         SnbeaI2Es2//VBE02laAqYVE8US+M1ThjXO3CFTsNz/qONZzH2siZj4S2e/G9D1RTSp6
         h4sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770181621; x=1770786421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7klJ34bE5c21vIGvZtifvnvADyVovGFGjq67k+fGEJo=;
        b=GFvAyJWPl4KadtMS5DhEuFtk/Kf+nDyiewlAtSAjMNxENXP7S3/H5aScjYzIU2oez9
         v0Nt7Q40v/8PGcn+vB8W8b8S4rbhw/c0LU5n0zbHLn4x2ErQEhKVD0vBGnCAAAVZgl8x
         Feq8vywttFtNh8G3cIi7hqYxvU85LzMgS/11t8A8HTrdQ5cJf04yLC7Jc9+NZiHvOPHL
         SM12+01HH1Rn+QW1qAEFrMVOw9HsMK+Nu1R88lcPRrf7J/bZIb7XmTNGDaHqMuhaWNDb
         N8EXMNBgJ4AyYOPYryobP6EJCPfeZ6g/4JD4kCWXi8COOAZNYX1+IQWo28cOj21cH/CD
         zlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770181621; x=1770786421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7klJ34bE5c21vIGvZtifvnvADyVovGFGjq67k+fGEJo=;
        b=MeAUtLaBYr/B0SgzRnE1CZkh0rr5hcwTVHzyCsskfsv1Q77garF56rgUcjz0DlpS7v
         VZ6kly+C9zo/qbzQRWZ8TR5EI6uI8qGWQmx92JV52YEtbgVF6A8q8Je1TLW6IoiHDeM4
         riAdkqCw8iYTfbEDiWIspLyp11aJiRmlIEOrboSxRBGUfIidu69ZaYQ9Oitf78fVBy6d
         nD4Uch92Hn5cEn/2+uIKDyp0tUaqluCHF6n/TPtt3pBsiohPIKK2JX24bmd2PKD9f9z8
         WQebSUuyq+slCZTEDsveHSJ8CPktIhgF59uIrcDy2ywEk/1SgndddxULi2KwdJIyoA1U
         Dy7w==
X-Forwarded-Encrypted: i=1; AJvYcCUrD3rgyFOQLcI5+XX+dJxmRtpnH7qn0sXjPM2Tc3RXpiYYjjrcWjWyd+rvuD81KVOA5g6ujmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTP3gNWqnAFRJXZ/JBkhFRiPGKZIVcqZZPtDZbSICZIiWpMsXN
	1aLbRINBdeJsgo9zGF+ekYQJ9XqfxSFIT9mCPxUDwW6EKDwoPElkfkhoDFPkZS/iEtKRIRPV7fG
	9AMoxjLyv2yjlU7G8RogFbI1WNOEcxLzPMlpX4WCl
X-Gm-Gg: AZuq6aIgXX92nueCSIL64qQpqZzuagreryzGJ/iLUDRIM6AriHezxAlQbGVGT6/UxiW
	yEuhmR4nbZy39G1Oe3Lrf/UtjNDag1lnCdBQcJk/uGM9IB9/VaB8PBG8jSgmKBp0t2hpPa1ymDN
	e0LSRfIcuqCQjmvtacQyx9OQ+9uGIszQxefboMSBHQ3upiNiVQgbpDmOiSq+Fw+CBcWMPssW84L
	zaRfX+JfbOsdeFKebL6l44FMJkSReQPJ3Zhu6pmNjWvtNkPWVdWnB0qC1xwmbSZK3U8Yg==
X-Received: by 2002:a05:622a:1108:b0:4f1:caed:da6b with SMTP id
 d75a77b69052e-5061c12da73mr23296981cf.35.1770181621141; Tue, 03 Feb 2026
 21:07:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202082200.650516-1-edumazet@google.com> <20260203191740.2404d44c@kernel.org>
In-Reply-To: <20260203191740.2404d44c@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Feb 2026 06:06:50 +0100
X-Gm-Features: AZwV_QhKuzLFHAAni2Vyj1EmZwzokJ-BwGDOaquuXn-LiBD0RVndVQ3SDsaYBsE
Message-ID: <CANn89iKCHZVdKynuYbWfV1Qjq4FTjvb+KFAS7fpnQcPCTm-t8w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add vlan_get_protocol_offset_inline() helper
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256562-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7EE99E1AB8
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 4:17=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  2 Feb 2026 08:22:00 +0000 Eric Dumazet wrote:
> > +struct type_depth {
> > +     __be16 type;
> > +     u16 depth;
> > +};
>
> Should we prefix the struct name with vlan_
> Seeing type_depth made me think the function is returning some compiler
> metadata :S Maybe it's just me.

Sure thing, I will incorporate in V2 your suggestion, thanks !

