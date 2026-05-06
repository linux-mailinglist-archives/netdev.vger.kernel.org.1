Return-Path: <netdev+bounces-284806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLVZErQz+2nfXgMAu9opvQ
	(envelope-from <netdev+bounces-284806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:27:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD43A4DA2C4
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9856A3014C66
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC544105E;
	Wed,  6 May 2026 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQKidTzN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFDB270540
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 12:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778070449; cv=pass; b=F8ZzX6o8R1wVghtn0N7lxQkZOxYAFo/6XEsspA49gbkNcW1/NI/EryRFJ8qaM15o6Odm8xXMvkSS2xTwzPJfMlpB+Fmz0o/punJfWIXnA6v2LlQGckDCBm24QN32eEJFQ+kjQLWIUlckEionUn3XMF8FhchjEqfMyGPuf0bhHD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778070449; c=relaxed/simple;
	bh=GAzduJVtej92bVl00X3WNOvbt5QWqBqf24fbe1pc7gE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipoNNhajpDDSks5p89cVAzseWsEgbNaJXPFt3TXC1cHj0BbHlwz1DmnJ4cOUIMQtjQu6oc1SzD6RaOfOrK85gHDkxuLyNYf7EcAwJKJmx1c/Z0m3UslL3lFSLhNDB0y3hlLHnmWiwi3baDKSsZlVEMSxO8MuTdIx4gWsu4K/aDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQKidTzN; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bd65714dcaso54497637b3.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 05:27:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778070448; cv=none;
        d=google.com; s=arc-20240605;
        b=GoOOkNZ9nZICtNHpqI+J5zLNa4jWVohjvc95gYfY5K+CVoFvJBDFqjVfc2S5uwGt9Z
         Mh35DsCt2ip8KHVGq1wf+7d6tdmxD5Dafhr7mtiVyLix4H3vuV8PVCbm+8X3PMBfFBqJ
         oYT40zm2JIXfGwcIMZX3V8o1PaKJamolxXdm9wNJKEz43AGoyt3ud0go/Rx3ZrWUN/rF
         zSKjy40LB4J5+qC0wS/AkBR7GucuAftBQ9ZgG0w7L6SRClTqFxJIU2hVdqGTD2r+9KK5
         VtuTft/TnOKi70gMSaeaj4/sCUGD75y8Y8TpbBIWZEkMMCgP6j/rd1n/DFeVYRPrrl1v
         aKGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GAzduJVtej92bVl00X3WNOvbt5QWqBqf24fbe1pc7gE=;
        fh=So3LluMohyos+gQp4OknY9hyTKXCYFBF2eiIkR3hVGM=;
        b=AoFvjUNhsNZhoVNRcPUR3SXVaNKhaXKmSqvgw7cP3d5l9jmGPWkV8nEcXo0HmSsay8
         t/y8IQiNtU2vL76dCQDceCwNu09tg8cgO615MWQcqI4NHEjQUK6lqs5RONQmORUXbnLm
         DqvBirCCwT8mfHKlClDm+QQxlR+cBetpZej7R1sw76z6XoL69dyxP7CpAvpv1SpHeFqK
         DSGBF92+L7NAN0ofYQXD3chrUbePTK14RNjfBpcalReXL1E5OdVJFa482+Ogcf4K+M+c
         K+aARunfy0tegFFAWsA7JSS3afstn5+/zzLNgd1eoghbQ0EHkS4kBFDDLjSfRmNXpdnK
         Ixrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778070448; x=1778675248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAzduJVtej92bVl00X3WNOvbt5QWqBqf24fbe1pc7gE=;
        b=VQKidTzN+nolgvcJtSdyy/MCiYxr/IK0UEYUaWHmQyEQyo/R91SC1FBx4FIOgBPnqa
         eJQP167qhsKEcJWjYEoluI9B2YvbeS+xpuZou0mSu68meejh2uLwBlPMuEBoj2Xd/DQV
         RWVQ3cLMHNJeUm3KBpg4ZvvkxjdcjUiQersOV1aWkAXsLYL1sWbLju+FqHyOfsYU42p1
         L3/8TIWhWbJTDRiCWX59XAMVYo6VCtTbjnql4A2xr90nUYQY+OsiqqmaJKewZQE8p04Z
         Y/B2HWj8lATo1dIG9kk/55yW0dHV2XIgOaTgStEogOkoqhRCCAAcexXhTfbMnBxUxmFg
         9Idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778070448; x=1778675248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GAzduJVtej92bVl00X3WNOvbt5QWqBqf24fbe1pc7gE=;
        b=OvF7pz3KqZ36D//V0OqsVuiWzO5yFWC3xsK9NStUVD3fcrVesSTY2kqeu4IBTXiTsC
         bwjW04PmRq2JAQelNrinXKxUoUNlWsXRYWyNGTPgH5ctDkvSYHbS2LQ9KFJie61ST1Fz
         xlqHSzVrOhyNSaCRBB3+5Xih8AkgekEvXxgm+pJMPyoafXtJlBmef4hmrsof+4mR0wDO
         EQYfPQ1wQXenGchTBL9YFAfZfH2H6eZVBLz40h47ABTKlgtFA+Gm1Fuzq68QPewuLMHl
         oLXnhFuY9MNZhFf98R39PoWM3lW+8prN5cPszAXk+RffFaTG2yeVvPmG89m3SRun4OxY
         UZbw==
X-Forwarded-Encrypted: i=1; AFNElJ8GoA6//12jhf4ElrGDx0GceTjsF6vglZ09dcSHNTYiPwXANwkCJ546MNfZZX/lum95GbLXlms=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr3BHu427iNDtjkrmnPMfMjiERQ52ffcW19clJnG0Bup1yIFdw
	dK4lisSQ0LSrgVRqcteowriV1wSU9iXyEuCtYbs4AeuHqjcFfGfOMlA2CUnvn1tcDGRUbigyNwG
	aIamUeDQt3biuApxIgrWN4UvjkY6bREE=
X-Gm-Gg: AeBDiesgQ5wNttHecSMYYc5LH6+zsuphD0aW4yKvTOrYS28Mu95fsXdBO20GHVmtj2L
	W0WCH9EtrdczDo1Xca7XYg0PNnn5oqypCw38o2oLinmrhY+qGlxl6d1c4vWqhYdcljAsREtlpEl
	hY089rkHcxxB2dyVxkUW3JwX6JfLv9ZUiXhi2gMhkWG1V4M5oNFOjqr0rqciFVpzox9D5MN+/5j
	6cpQ6ao3blxMA+SgTifhw7V627dvIFuNKOG839xy5ymWsdzVw/3wQFj1DIzlJjv5SdeQ2RLnwrV
	WpcDZi5hsxUYkI8xegVDWWpa8Jalw5LfIdL/hqKaCVC+INjqeVP4haATEg==
X-Received: by 2002:a05:690c:6ac6:b0:79e:9cc1:edf7 with SMTP id
 00721157ae682-7bdf5da8c15mr37150617b3.13.1778070447680; Wed, 06 May 2026
 05:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506120034.2146771-1-cuigaosheng1@huawei.com>
In-Reply-To: <20260506120034.2146771-1-cuigaosheng1@huawei.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Wed, 6 May 2026 20:27:17 +0800
X-Gm-Features: AVHnY4LVQ5PLSM6stSei6WuvL93BxQAfl2RRSXYgEbbHlbSGc423uKlaLMvtDZw
Message-ID: <CALW65jYMfBN33qrWAMaNmnKfOd0eK4xA8KvCijkPS5mdBfoWSQ@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] Revert "l2tp: do not use sock_hold() in pppol2tp_session_get_sock()"
To: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: jchapman@katalix.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, gnault@redhat.com, 
	gregkh@linuxfoundation.org, lujialin4@huawei.com, gongruiqi1@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: BD43A4DA2C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-284806-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi, Gaosheng,

On Wed, May 6, 2026 at 8:01=E2=80=AFPM Gaosheng Cui <cuigaosheng1@huawei.co=
m> wrote:
>
> This reverts commit ce63943f9bce64df1be9b6a65b04fa6e1d99ec2c.
>
> Upstream commit 9b8c88f875c0 ("l2tp: do not use sock_hold() in
> pppol2tp_session_get_sock()") was backported to v6.6.130.
>
> The blamed commit c5cbaef992d6 ("l2tp: refactor ppp socket/session
> relationship") was introduced in v6.12 and was never backported to 6.6.y.
>
> Revert it from 6.6.y to avoid incorrect reference counting and
> potential use-after-free.
>
> This is a revert of a backport, so there is no upstream commit.
>
> Fixes: ce63943f9bce ("l2tp: do not use sock_hold() in pppol2tp_session_ge=
t_sock()")
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Sorry for the confusion. The backport is meant to fix another issue,
but the commit message was not updated to reflect the actual use.
Link: https://lore.kernel.org/stable/20260318012653.232518-1-dqfext@gmail.c=
om/

The backport is correct and should not be reverted.

Regards,
Qingfang

