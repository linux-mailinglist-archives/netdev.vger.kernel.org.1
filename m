Return-Path: <netdev+bounces-262228-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAl6B7Nlo2ngCAUAu9opvQ
	(envelope-from <netdev+bounces-262228-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:01:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 653681C95C8
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 23:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9211D30048C0
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F88635AC1B;
	Sat, 28 Feb 2026 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0LONu78"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8735AC24
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772315889; cv=pass; b=PCgGdxT0cZchPiSYr6aLt9eKw96jfWIf9qOfmcu1wl60mC55V1RLpuNKfF6n/BgHVXUwKSnFjpt0D3r1JWzWibj+oN8YJrovgXHxyKWvrtzYl3qkZ420THUCj3pwFpXNO+uXiz34fJtoR57pGmLwQhgYxVQaloxEEarhHMH6Udg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772315889; c=relaxed/simple;
	bh=NOsnm1WMT6oquwFkOKXtq9mpI3K3Gfqoq7wlHkSQeIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1HpzyguA2ow5c43kApo1KBBfn4oY1vooOQZSAlFJ8NH9F6TQKGqjthGUaG+HtRYfXIIXkTHbSs+bLeHsH+SDSflbRNEDu4GDCxJEEPkhtu2IQWqTFqCsyxJ37sl3mKjShZUBfzL27sDU2LUzJN+IsrlzSU+46u8eaU+KHMly+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E0LONu78; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12758ce1e8dso1580565c88.0
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 13:58:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772315885; cv=none;
        d=google.com; s=arc-20240605;
        b=RUkN5D0uZ9pbrIpDS+EbOxzM2vRasPuU7me50KMt1gmakbej1VKVLv6j2iEJPYMEKQ
         5fqmaGB9DHekUhx1n0/sQj8BS+jT12ARsOpSdBs6e6hIg0+u5SFycb7p7LieWeSDCyH7
         kg8DCiwqjc5Wgn5NiZpB+/pW7NNXkF19+7Err04tk8gKgd56sH0nlMuGa1owt6odB5G0
         3OQ5ZL6SCD80kpUS+CCqpXtTyOxDVoUCCde5TrTATXVCLQy0GVcxUoXpJQFeGw22rAdN
         gSZ8WYje/gDBYX3NTU+aH+WP2Q7zEyZB9uxi00y/Yc8xb7urYbfwuuMkeffc2YfAG9JU
         bKZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JqewYjJx5AqKptY80zybKuRX9nlvDFB85qIMIDwbEWo=;
        fh=TLv9cOLAqyInEHzFZSlOyS27QVd8yJk8EWZMXHtRbAA=;
        b=Wac1GSAZlhPKmt7qaFmdY0aAL92rtIPE6IsYOOkf8qXkCLwJ+3rA34wfMBQtHv7uJt
         pvvEF76fl3bXmdOKwsiESRr4kHmKT6IwsfXowaCSISvsF13ogtFDoA0mvCIpMQnu+UEm
         W0dQgmUZk0kNELYy2iua1oYzlnGrVMuD5afCzhEutX2YYgmn2A/DEroVbbJKZPSyXa4m
         Hxp4BVr6PJvh395DehfP0AKxkhw8yctwpCYtaXinMXxKABhJYNkEtktp8utUsAwjhJd4
         vCanVaMSNYm9qHUhQqyGMUjtsWVPNvzkUGFar/hwhjBjRoiARHq2KuXRR3DmgJARwZBQ
         KRtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772315885; x=1772920685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqewYjJx5AqKptY80zybKuRX9nlvDFB85qIMIDwbEWo=;
        b=E0LONu78wBYftoYVeH+b8JhVAESH4oSmdGsklf9xFaZB1N6pmCMNOOveJd1su+OFUN
         77wE67ikVl6UJ2zN8650kI99fQ+2N15c4jfn9YZ1WiYs/AfQDxnqnYap5rO0vLlLSYYX
         0YpVOA54Zzo5p6Rkr8/cyC+dFbWBFkd7cxOzjH5j68kIHvqz85Y+IO1719FgHW33XUVh
         Fr+pETpBpl0L4WbilTqKbeqRFAJ93Oh/OMIosoCX/NGS/amJjblnnW0uotADflk9z35j
         6yc2iXzhbD3sXnl6ZaTGBkYGUGJFoS+r4FBfMYL0usUp3sOGGVAPXagPD7sK3lPqcJSj
         Ob3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772315885; x=1772920685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqewYjJx5AqKptY80zybKuRX9nlvDFB85qIMIDwbEWo=;
        b=d5z40doe5H4wTWvXosGM/CUNP0nSDgd3F6PTut/lHd5JbGnKVOvnFhhp30S8TodT7L
         CcL4qxO7Ld0G44z4iQI0hZPUv9O1GjiLwOwiHl6ThZvNH2bluvFhPJs/SELEtL0/aqcc
         G2OCeVjHr+DPi3B0kE5iYayKWHimRAyUwPCupyygurI1D2L4dFTymw5+uqLNGEfIqfqx
         AKzg47MMqLYbyogmah3SwMqfBLere0R8ow14BtHGG37HAcsIEKh7BdACORpUoaSRxXP8
         O1POoAgbWcbxmYSy9Rki7Ff//JEgN2VuW1Dy7mq9Y0Vs+O85XXLZxmsO2cJcVvHUqpc/
         +ZUw==
X-Forwarded-Encrypted: i=1; AJvYcCXAv19r1DRgoTNg1Qknds0pSKOJYZlyetx3SW1/bO5gS0hY5uWVO6LhBKG/8r7yfwlHDaEqH4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGXB+jeGa5nvyCID8U9OsrdWGf3K8Ooj5FFTqxFgBNtl3fj8FU
	+tZegi0aR5B0jczPAZYQObVSZTq6finyOrS0TjtYcgISl8ydp9+BnL+8pP6Ei3juJYRTyHVBARO
	mWd3SmepfLv5btHc62Jr+4n1xc0q1WeV5aq5lQwj+
X-Gm-Gg: ATEYQzwOEwioFX7/p+pvqfWnszq4s9jq9i+Zfz4othK28J/rxF+BGOgID7DSmNPw0Zx
	uhM5cgwtR0mEpFXrDI0trKDLOpoREAbdVWLKwRIsz/J0u5XlX6UOqwpNKeBnHk4ZXRlkUeqO5XC
	0U1/D+8WpXwB4YuxYXRlBEyXiScfqu1cP6Pg+Yb+H/sBWjfJEPg5bRrSLjGkLqtE+ui35UsuRaP
	H/OtglLm8LlmkXSKPxIlfEuQZ8jGF6ayB7UrgLwTlJHRzQ2bb8fatC+r96pOlW/WrCxIU9mIMBj
	R95T1EJpjpuwvs2aUk1mlKIPzdY5DnoYFVbzJRcxAaIV4od3TyAVRK1H29ebyLooRgE1LTU/
X-Received: by 2002:a05:7022:2217:b0:11b:88a7:e1b0 with SMTP id
 a92af1059eb24-1278fd44074mr2866578c88.26.1772315884311; Sat, 28 Feb 2026
 13:58:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-2-kuniyu@google.com> <20260228215436.4094668-1-kuba@kernel.org>
In-Reply-To: <20260228215436.4094668-1-kuba@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 28 Feb 2026 13:57:52 -0800
X-Gm-Features: AaiRm53tbBSrse7qXHdmJQSvFpNKWls8QJ7MEAnpEev_rLPlpEdJOgx9D-8A4e8
Message-ID: <CAAVpQUB454JYrDzRRSO_OCs7gaXQa2GYYC9Gr1UdY2cdUTBWyQ@mail.gmail.com>
Subject: Re: [v2,net-next,01/15] selftest: net: Add basic functionality tests
 for ipmr.
To: Jakub Kicinski <kuba@kernel.org>
Cc: dsahern@kernel.org, pabeni@redhat.com, edumazet@google.com, 
	davem@davemloft.net, horms@kernel.org, kuni1840@gmail.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262228-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 653681C95C8
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 1:54=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> selftest: net: Add basic functionality tests for ipmr.
>
> This commit adds self-tests for IPv4 multicast routing (ipmr) that
> exercise various setsockopt and rtnetlink paths to catch lockdep issues.
> The tests cover MRT_INIT/DONE, VIF management, MFC operations, and RTNL
> integration.
>
> > diff --git a/tools/testing/selftests/net/forwarding/.gitignore b/tools/=
testing/selftests/net/forwarding/.gitignore
> > index 2dea317f12e7..418ff96c52ef 100644
> > --- a/tools/testing/selftests/net/forwarding/.gitignore
> > +++ b/tools/testing/selftests/net/forwarding/.gitignore
> > @@ -1,2 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  forwarding.config
> > +ipmr
> > diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/te=
sting/selftests/net/forwarding/Makefile
> > index ff4a00d91a26..bbaf4d937dd8 100644
> > --- a/tools/testing/selftests/net/forwarding/Makefile
> > +++ b/tools/testing/selftests/net/forwarding/Makefile
>
> [ ... ]
>
> > diff --git a/tools/testing/selftests/net/forwarding/ipmr.c b/tools/test=
ing/selftests/net/forwarding/ipmr.c
> > new file mode 100644
> > index 000000000000..b6b00e36b3ce
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/forwarding/ipmr.c
> > @@ -0,0 +1,455 @@
>
> [ ... ]
>
> > +static struct rtattr *nl_add_rtattr(struct nlmsghdr *nlmsg, struct rta=
ttr *rta,
> > +                                 int type, const void *data, int len)
> > +{
> > +     int unused;
>                 ^^^^^^
>
> Does this code have undefined behavior?  The variable 'unused' is declare=
d
> here but never initialized, then passed to RTA_NEXT() which expands to a
> macro that reads its value to perform arithmetic.
>
> In nl_add_rtattr():
>
>         int unused;
>
>         rta->rta_type =3D type;
>         rta->rta_len =3D RTA_LENGTH(len);
>         memcpy(RTA_DATA(rta), data, len);
>
>         nlmsg->nlmsg_len +=3D NLMSG_ALIGN(rta->rta_len);
>
>         return RTA_NEXT(rta, unused);
>
> The RTA_NEXT macro performs '(attrlen) -=3D RTA_ALIGN((rta)->rta_len)', w=
hich
> reads the uninitialized 'unused' value.
>
> While the modified value is never subsequently used, the read itself is
> undefined behavior that could trigger compiler warnings with -Wuninitiali=
zed
> or unpredictable behavior with certain optimizations.
>
> Initializing unused to 0 at declaration would resolve this: 'int unused =
=3D 0;'

Fair, will set it to 0.

Thanks !

