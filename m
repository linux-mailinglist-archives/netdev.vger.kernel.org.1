Return-Path: <netdev+bounces-265688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMyHAbESr2nJNQIAu9opvQ
	(envelope-from <netdev+bounces-265688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:34:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EA023EA14
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 19:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1E57300F179
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 18:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA52347BDD;
	Mon,  9 Mar 2026 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="3Fgdbvro"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98E532BF42
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773081255; cv=pass; b=jZIj2ga3vP5qbJ6at2BMZR9RdNIatFe5CSPtZluEHpipyumrH/dI19yuKzI5F1tovv20FOkJChbOZA+rufxFLXxIufw5VHoc+cKdwfY0SUsvSELuq5fgg6NSWEIq5S5x6U83GC3nARp/WWjD3JEAnbph/BtlDF/zxNnEykBedBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773081255; c=relaxed/simple;
	bh=Th/Vm5yJvjJFlnWx4DiQQq3OKW9BqqV7UtSysK0C5T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWOoVNqlVbjBYHos/aiI2Dgq4UoSwpvIRJcOYYQ1A01VDfx0BzeIWVA2flxHypsbD9NJg+GUhntetjGaeQAK08Tkscm/cXXBwusGEaB9hibDPRgzBNVf3ad7wP/fDDDA4ANbyddwBtyKawaPoOwHrtQnzefyQJZmOv9cam9KQNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=3Fgdbvro; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79902e1fb71so11304817b3.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 11:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773081253; cv=none;
        d=google.com; s=arc-20240605;
        b=X8+/RWxWKmh6bLDnuwUwTFxUFX6NTCf0uiX9wz29v4XznY5sXdVCt4bvrl7qsezOWA
         eGpfQZHYCr3nv3youXADOtn0qH9x4jKyR/UwzPtzd0JFWYiCzKt3j9rjwr3gjSf0p9JR
         LZhzl9RD7aFD2FNXRE68ph0QoZh9J2mrYqbtDgRCtT2rGrN3jQRet4sWy5FBQphmu2V/
         0yidy5NHbzxwk20Adj6VE1ToMY2ZInpX3+ujy1rUOQJg/hiNnYgLXN+ofqfdtPGJy9va
         QxyKmSbe3nTmwVqKhG1GmFaj0PAVEhJXOdda9SqzgNfwq6pQKH+cwWDT1HV088MhlOfB
         a1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tIkDbd45e1YDVubOvjwhJvyku4GXAKAJYDkkxfPowjE=;
        fh=H0Ppw6+i6JRudBxd1INF0FCU86zK4YZDdVM4+aggkU0=;
        b=GE0Ij/2bFmR90cHVDWryvfFUDrOvtyt/FPwDAEQszLPT+tOBaURrccwU6iBYR4wI0N
         tiVYoHF6OG8/buxpo2J9vaDMrqQpFh+dy4crQGN7xECZOEARWdq/MZB5MLTDBscRYs/W
         JeFhZj4OmXMa3jBsVUYrJmsDgUzDWdbrZUSKkwSQtEj6hC26oq0HUZglATIsd8Yd9eKV
         4LXH3VtqC2LgHGVYFvtoKLVKGfk4RZ6iyQYu29KRhDEACL/hXrFfZ9G5qiPWKEjR7D6A
         khnKfBgMiehe09f6s2oVMB3jJYiYT4uNBoYctFZRh7yFs+n3HmOJPtQEsOSN8/Y5Pv8D
         SeOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773081253; x=1773686053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIkDbd45e1YDVubOvjwhJvyku4GXAKAJYDkkxfPowjE=;
        b=3FgdbvroRB4h+7A3rEt3vOCAlv8EegipA5HHgVsNLDCDiLaRT7kYLVEFvTRFV8ePdR
         SBCmjfVxyG2uy+kDKjrU/Ii1VmDr5Zp3pxERTIElpfVnr6q1wIb4QbsJxWg3Y0mol7AX
         NzpJkqeM08TAV1cknLhVr56fl99TYPr4TJZJHQb3vgLZvW81WtnkzK1HV25nIHQih7c/
         ReH6U+BjWF/0vAc+2LRLlC2R9FbeNqjv0/WjQWYuyznzCG6D1GJALIGexO2UMFD37foz
         e4BAZ5Ib6JLHScPGqUrG6bq35RAAuyJP+YXSKMN8+H8ACoDOvC/oFT1oirJDLYOoP/U0
         aa+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773081253; x=1773686053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tIkDbd45e1YDVubOvjwhJvyku4GXAKAJYDkkxfPowjE=;
        b=BbLINeC/vCcOFCMccyDLWoSJnWXvoU6s56+Ls1yrVPCMlke6ItcFuSWX/HfNOlcLwm
         MJaPCW1r1jDm35UrvqgFLPdF2n1E8QULtN03OovkqT14c4AmRy9l7PFvO80cqjlyJD/U
         Fiy//zJi3LmCvpfdxGO2PMWdItwHVL442eiZrYtqaZLMQpOKMwSNlrf1SPOezVDk2p61
         ejuNhlwQlYzUtK0IiekDZIaF+f+eqg8sqjBF0jodJqFLcbEpmb4D0IuJX2tYOJrtiMOH
         YIG+mY6Ihh8+gJKsUIUVGn784u7LbFsON9bvcP4jqiyL8mUQewaGkztzHRdbMciwgygA
         Yikg==
X-Forwarded-Encrypted: i=1; AJvYcCVvTiVuh9eL1VXUZY0nvQBiUE884JCioANg2MZdePTIjHGBjnvsyERxLeutAs6Lvb3I2ZvQByk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTQmvXHRjbJvuXAvrcr4dGYRvpN1DT4LE9sM3Yi2XgpEsik2hi
	kiYkSU4dow7ftG2OibBaYOp/XNTGjOj21LH5h2Zr2ldLy0zd4KF+5hEDXKYecBys8rSoqx14jYJ
	99anYhuDelcqUjJb84yJFJ8W780h368mPAi+HL8hB
X-Gm-Gg: ATEYQzwx4oT+LK4mKXKKuabanu4FqpAszJcvaCL5gLSyFPgNXYrlUOr3B828IVd+lQd
	AwFTK+4iK+3I72mvXBW8YK8EQ25GAvKOliF5Rl2sK4kZBNNotZTyR2ElfGgxc9Sxido6HL0B3Kp
	uLtsygaf9h1Xq4Crl2MKyDxkDSn9lgIOtA3iCiEA2+T+wtVsPKKf5tEy/p7vwtIoDuBwnfwtmZ2
	68vSovukmfQPV7AeAMqy6IAAh6DeJPsz6CGSV3EWnm5KluFvnIcMwhPUjrscHdcGQvLsWzPd+Ik
	avb4ZPAuupHyMYQBXtpc6Q==
X-Received: by 2002:a05:690c:450f:b0:797:a9d0:f0b7 with SMTP id
 00721157ae682-798dd717e41mr118562797b3.38.1773081252866; Mon, 09 Mar 2026
 11:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307133601.3863071-1-edumazet@google.com>
In-Reply-To: <20260307133601.3863071-1-edumazet@google.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Mon, 9 Mar 2026 15:34:01 -0300
X-Gm-Features: AaiRm50kHhT1fFacOlxCSltURRrlLPpNX_C4Smiwr326cuuFlAfC8WfjCt55tg4
Message-ID: <CA+NMeC-3dP2EnD2cCH+n6enQvXa+23NNFeZ8+DDm89zbM3MkNA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/sched: refine indirect call mitigation in tc_wrapper.h
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Pedro Tammela <pctammela@mojatatu.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 79EA023EA14
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265688-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,mojatatu.ai];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,mojatatu.com:email]
X-Rspamd-Action: no action

On Sat, Mar 7, 2026 at 10:36=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Some modern cpus disable X86_FEATURE_RETPOLINE feature,
> even if a direct call can still be beneficial.
>
> Even when IBRS is present, an indirect call is more expensive
> than a direct one:
>
> Direct Calls:
>   Compilers can perform powerful optimizations like inlining,
>   where the function body is directly inserted at the call site,
>   eliminating call overhead entirely.
>
> Indirect Calls:
>   Inlining is much harder, if not impossible, because the compiler
>   doesn't know the target function at compile time.
>   Techniques like Indirect Call Promotion can help by using
>   profile-guided optimization to turn frequently taken indirect calls
>   into conditional direct calls, but they still add complexity
>   and potential overhead compared to a truly direct call.
>
> In this patch, I split tc_skip_wrapper in two different
> static keys, one for tc_act() (tc_skip_wrapper_act)
> and one for tc_classify() (tc_skip_wrapper_cls).
>
> Then I enable the tc_skip_wrapper_cls only if the count
> of builtin classifiers is above one.
>
> I enable tc_skip_wrapper_act only it the count of builtin
> actions is above one.
>
> In our production kernels, we only have CONFIG_NET_CLS_BPF=3Dy
> and CONFIG_NET_ACT_BPF=3Dy. Other are modules or are not compiled.
>
> Tested on AMD Turin cpus, cls_bpf_classify() cost went
> from 1% down to 0.18 %, and FDO will be able to inline
> it in tcf_classify() for further gains.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Victor Nogueira <victor@mojatatu.com>

