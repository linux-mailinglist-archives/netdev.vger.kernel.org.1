Return-Path: <netdev+bounces-296466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LMhwJ4uWJmrXZAIAu9opvQ
	(envelope-from <netdev+bounces-296466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:16:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBE6654F24
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:16:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Z3sZ0rqq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296466-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296466-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3889E3042C56
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24CA3C061C;
	Mon,  8 Jun 2026 10:08:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961DF3BBA18
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 10:08:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913297; cv=pass; b=L3iESVTBnRppGlBs8b0/IyMyBrPhuVG7Gl/K6Lzi6lLj3vLA+/i5dZTYVvp4BrFGur8dwTQFZPMijo3EGgH0CIN79vwvo3eBR+6K5+WY78CVtJDA6wYwtqP9ZFUzN00sqxzlV0aE+MRoRh0+lrkmWz9MyNDMxS4DVn/xaH1PCfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913297; c=relaxed/simple;
	bh=6LrKMFBGjj8ct9TTofDjqiF5sLmpqspGhITcv9oyCgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdyqDaNDxj+iP7LgFoV2mgLRNgOuabBtJlSlDgCooQ9hN9YPNSnsJQd6UI29hL1pZgWZ8ij97Pu4zf/RgscDbJD6HtOpQVkBlIvVW7g8L5jc22w/0ZKFa+mobkIMRXI5eIIIDOf5x5nv5jttfxipxt1qodaTxMxIHPXbLnIHdpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3sZ0rqq; arc=pass smtp.client-ip=74.125.82.174
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304dc707c7eso355844eec.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 03:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780913296; cv=none;
        d=google.com; s=arc-20240605;
        b=MQZK/BlNrWRkXvwWW8KICTn12T5zwj4sSDGscS1xCXgVJOnT1+jEz3XnqYw9bG1f+l
         XNl9zDNICaF3RcHOBhNPvJfGMzzp5bqhsiKzUrTpCXGUWdAGmD/lk1JqeJ4ess5RxLUq
         hFIJScwMtQ5xPAdNZP6ROHG525wehLMSkMz0he7hcXHDND1GVV3XPKz4Ip7D8sJrwD9f
         EdGFDTzVw2CLkOqNq8j52ISKWxSQa6wCsX0D52V9pAR3ZIHg5cqsPxqaIsvdVTzrzEvS
         luc2hJjxtjeYsHMFIOO9q2WgJc0DHjQvq9nTgYKggKzar0OVvzS3yZCLI9PceT13IfS8
         XfAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4xs9GW8UG0vcJ1ziYEME099eUBntAL0P9yXVtIBd74k=;
        fh=KZaLzw1OYkFEI+XzQy8DYBOK6wKm0ran0DyWSH8yIFM=;
        b=Sptm+W1p8xSreqsFqjgdFxG6BjcRN19avtKIxmsuKC+tYVhFmXMakihpnl0+1HAMvt
         g8QZOhdBVSDJDFGedUeCj3gS6ALK4egb4tb4SzIbj4wfaVXkDgIwecmuBZfAYdPmLdeE
         2XcMxeWyf1Runfsx4In4xBDkOpornVn5zsTJhpvHF0m9Zs/N2t5MLJOp/ozoViu+H4mh
         2CrveoJtjPDF9WAzEZ5k0i4CgtL4B27yFf2g3/6Dv2AppwIRYQB+FCokmwnQ/MYw5qI7
         vLfc6AzsCBm5fwC6A4kaKcKBZn03jmyh9IZspgFUj/oPdDvp+1TVLu/R0q0nmfl1X93a
         x0pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780913296; x=1781518096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xs9GW8UG0vcJ1ziYEME099eUBntAL0P9yXVtIBd74k=;
        b=Z3sZ0rqqotGaOvNoy+q60CliGQlxSA7tyer492ZBOkSqL/EJWis4/CFCihA8c/L8wZ
         X4+UKuZMNmswUGkQ/QTGRA9CmC5vj5MOJ8ZNCCH0OvF5A89LNloEVpzsn3/RLtbXtDTv
         +tqCB8KrI6x6uVhE3MHDx02idfaou19XVt8KwIq6ClC2OIOtJHIKN4yMj43DOD2OVmyU
         KZpFiDo7V/d++8iUXiyRnboQa7npSKMydgywC3R+BtlPcNsNKCn190lNofWH+xMU+Jqv
         rlzsGbQ4jQ10rqSWx2WeYqPCcL0f6DavgCB5NboQYaz3hckfvKAEh89gBt4EG1T5TXlu
         N0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913296; x=1781518096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xs9GW8UG0vcJ1ziYEME099eUBntAL0P9yXVtIBd74k=;
        b=atantuRit+siIpxRlgPedTYVoqt9bk7UDDQMp5j8MSkXUe3HstzineQIifON8w7JFl
         KFTVSwuoce7X+DvmbgfZfSyJg5r5GHUpq5JKiXDMhDP8TFZEe7KNatu9/rruR8S9p39G
         qrmRjhNcmQVE9ClKVKSn8OcEoms3bweJCBE5prFIXJbW3mJuPjA3OAJpokl6yYb+U8O7
         BZ95gCQt1oheEHSeR/1abbs7MiV0gZTKdJlsJjgv6jSFtlriASaE65HPnGKFll+3cw/F
         3LNCCzwIOEmCStKjanYztAAloX9jxfMRyUczGDz2/znElumv+LxZvIxu0OS6H6cQStMa
         /3Ig==
X-Forwarded-Encrypted: i=1; AFNElJ/C35S+b8byJTxr5mVHDqc2Uv0s5rtqhHkY9Wez0ZR4cftR3xWZJ1bJxS3f/PG40WrtzCRtdeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ0y81Y1npucefjXLOfm1Uj6ml2AvjvbFifGMhcDoSppkNNpKB
	4chE7FvtzAZGN6ujYi+zc+9u5zImleF+pQkj+ZvbdeX3T030Wr7oztk2U1NgrGM3g9DPhArKiZk
	2bNMFlGAfGaCI4kk7zWDe191sdFYQNIs=
X-Gm-Gg: Acq92OGe3G4FEFZ8jsQuBN7CXHmx7B/ij5da5FqaHi+CHrK/ZiMxiDwDZvrLFB9nEAc
	LZV6/X51hjXB1js8fk0+OPyBZozkgncwC+hreUVaQUoRTTj7+xBIzctBBC6zU0LK7QSiojgS6yd
	tZVKQ654R5fsgOlDtHbY97sPI4BYS3aBSZo1SwCKfIPBgwvwzGriny//ssUD+EYrYq3VKuaMoDL
	t1jPxg0sW5DnNju5TeV2XvQzFqlMvtQuNmwnPTaIJVbwl34WdTUuQuvCZnHZDeDWpC4wxuLqT9D
	cbsyrUl3F10Ds24EJeiAWSKt3Y7EQ/8oRWfVgycy1MxOH4sAPwrcKdKp7LkmPQ8I/htiBS8h8QG
	oFaZkYOAeSCWG7cmGzEmWNyLjBe5u9ixrHepdmJPHIpCX
X-Received: by 2002:a05:693c:3945:b0:2da:a813:a629 with SMTP id
 5a478bee46e88-3077b223afdmr3586110eec.2.1780913295620; Mon, 08 Jun 2026
 03:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607095727.647295505@linuxfoundation.org> <20260607173214.92693-1-ojeda@kernel.org>
 <CAM0EoMkszTXv82To=KnEYTgzQSmEdRW9XrAMVtJsUaDn=Akf6A@mail.gmail.com>
In-Reply-To: <CAM0EoMkszTXv82To=KnEYTgzQSmEdRW9XrAMVtJsUaDn=Akf6A@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Jun 2026 12:08:02 +0200
X-Gm-Features: AVVi8CeZqXycb_mHPYx-p3hvMm2G0q4sVMGiMxTvH8pjrUyAWon96zgP6NZJLr8
Message-ID: <CANiq72mJNbNzYO37VK7s=ua5v31xBrRp8EnHDvEnKF8Z77jDmA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/307] 6.12.93-rc1 review
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, gregkh@linuxfoundation.org, achill@achill.org, 
	akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org, 
	f.fainelli@gmail.com, hargar@microsoft.com, jonathanh@nvidia.com, 
	linux-kernel@vger.kernel.org, linux@roeck-us.net, 
	lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev, 
	pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com, 
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, "Kito Xu (veritas501)" <hxzene@gmail.com>, 
	Victor Nogueira <victor@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:jhs@mojatatu.com,m:ojeda@kernel.org,m:gregkh@linuxfoundation.org,m:achill@achill.org,m:akpm@linux-foundation.org,m:broonie@kernel.org,m:conor@kernel.org,m:f.fainelli@gmail.com,m:hargar@microsoft.com,m:jonathanh@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux@roeck-us.net,m:lkft-triage@lists.linaro.org,m:patches@kernelci.org,m:patches@lists.linux.dev,m:pavel@nabladev.com,m:rwarsow@gmx.de,m:shuah@kernel.org,m:sr@sladewatkins.com,m:stable@vger.kernel.org,m:sudipm.mukherjee@gmail.com,m:torvalds@linux-foundation.org,m:hxzene@gmail.com,m:victor@mojatatu.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296466-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,achill.org,linux-foundation.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,mojatatu.com,redhat.com,resnulli.us];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,mojatatu.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0FBE6654F24

On Mon, Jun 8, 2026 at 11:55=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Thanks for reporting this.

You're welcome!

> Unless i am looking at the wrong code version, in the current code i
> see m_eaction is always initialized before being used.
> m_eaction =3D READ_ONCE(m->tcfm_eaction);
> Probably a compiler false positive?

No, it is an actual bug -- you have:

    int i, m_eaction;
    ...
    is_redirect =3D tcf_mirred_is_act_redirect(m_eaction);
    ...
    m_eaction =3D READ_ONCE(m->tcfm_eaction);

i.e. the assignment goes later.

Maybe you are looking at mainline? Please note that this is a 6.12.y
-rc thread -- are you looking at the commit hash I mentioned?

Or maybe you are looking at `tcf_blockcast()` instead of `tcf_mirred_act()`=
?

I hope that helps.

Cheers,
Miguel

