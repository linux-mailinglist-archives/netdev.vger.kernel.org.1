Return-Path: <netdev+bounces-270206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJwMGlGQvmmjTAMAu9opvQ
	(envelope-from <netdev+bounces-270206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 13:34:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DB92E54B7
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 13:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32F5330115A2
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 12:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE45307AE3;
	Sat, 21 Mar 2026 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRDQmd9Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CAE282F06
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 12:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774096462; cv=pass; b=jbXsd8qddDq9C0tg62XC5IQL7zEMDKczMt1JU+Bp+/nJ68P3ofnGMPJUyjuXxy4HlQkItfLpULgsaDCh/sU7F2FOjqVTSpg4PhRhmEQmOlogc/lCE4tUOIYTIoN7eG85lnSuyNAazT7Dmzd0ufboOnTCsH7M8ad0QrkfbOsTAbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774096462; c=relaxed/simple;
	bh=vAOxLc/iYSbulqsSrn9p0RF47QF7jBTSEff5apcZ5J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doLyn+/MVujAcdp5pCZ0ki0bH6bVXwi2LlSSLT7CV1vQGgdVtKmULlRpCVZ8NyjM59gfHLneabFR8tnJxEijriryDnHzxIfc3VSEOJcCMsEz6zomN8L5Rgyjqgg5y3ystRxotWHcqP/BjtBxXNIgMfxlAoxHPDGkG6vRTcY1kBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRDQmd9Y; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ea73e7b60so2165775d50.3
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 05:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774096460; cv=none;
        d=google.com; s=arc-20240605;
        b=YzqxqeJPHstSE63aIJEgtIMN4Xh8+tAWDuYZ6lZ4Xti2Kl0H6LOKu6gqR5ahFgYP8/
         fruixexrKj1Iu23Yt0WbhKHc+TYl/sIoHM0NHzhzc2x8d5l/lZ3vJq3v7IFo5qrrvgSk
         if8/jaNxMSobDuzY7gaftKOz/+8oIo8W+M6S9RQEKMwJ/DDg5OIkeI+Q+0ksduzGs12T
         4WiCSz4Oi4sxRpHJRFwgs2+++nluLVDuG//R8W1qsauZj7DvaEaRXLlBDqcZdJzi485r
         jLJClcjCjnXRq2IUbLUhqeFo+VMoZ+UFbLX7fy6DfvsWMBxi6cFBHMkfKkeCpMG70iYm
         xw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rNCB/fNUc/FK23+8KOYdAudgq7bzv4Aj6mVALRVzF8U=;
        fh=TBw3jpbIfrg7lhKVVyItM+/OegwyktEdsC6xnuTlDHA=;
        b=LzVgEPO29D2lzbLb9d16BlIQScjexUUvHk0Q+tlgIg06nms6NDLk8BxM1yo3d3pV10
         lGJj6HUuAK/oM4/5LwkT+4O6gueeTMk8zOa4tAeZaeDurVN20Yx/yLOChfnqnTW7zQvq
         ZWbm8sNHdUSwkecSHg0guWhFZLD7SuH77A5PZUJaexvSuNms+YlRQ+sELMjBoaLm4P69
         ko27228xkmiI4FuDt1aJUwC5Z8oPoMBuLWvjkxWMipvCQBp9z8Mf0m+LnK6qs74PEt10
         +tLVg/UeFmZsI0cEc5MhjJGV6mIXewMlbWcxo3evStDt2/bwPZwRhi58m1O4T2u260RV
         sSCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774096460; x=1774701260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNCB/fNUc/FK23+8KOYdAudgq7bzv4Aj6mVALRVzF8U=;
        b=bRDQmd9YnCxRcgOmFCMYSRtZpUAiAcjJdog4xBtuXRZn6QoVWo9HjflJwUiBQ3akxZ
         RQRXh1k7Z5OG+PTByTdvIyET/twQSBB5VixOyH67/21boqg/ZV+DPa+9SsjCLguUnseD
         rMltPTg2tSXTUBTANgLmeSFxMbg3wQx13iN/ZlsgUekY5jgPdK++fNtU5w22MVBfjB4X
         y3vyH5bHOIMudoVDzm09apmuU2lK4nAK95BGm+wQqF1sGeJAzFz5kL9sPJUxFU85wKzC
         Z5013IHkzoNG3md2N/BCtMLXAlwPnJafsPfgtmHoQP5cVRYCaWn6Wbh6xUvAymHoMk33
         DzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774096460; x=1774701260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rNCB/fNUc/FK23+8KOYdAudgq7bzv4Aj6mVALRVzF8U=;
        b=pfOUXc8NesOgvJ2zU7UGSZqtbr9sLQgElJ+RiUcZd0tBssEOHYKOSOJ99VLLoQAvmI
         Js1tq+JI9Nt0fzQ37f2brwOY9NGllI1lcYDGIg7fVKbM+ZB8QVosQnWYkSFAhXzUwItd
         4e9BgV0UlvG+oO0CPbSaNT7DbUzwK08rZg7lge8+G1ART0hNMONP/1ehgizM7jF41hum
         cMCrrlhsNNoUjRwLBlamrmPMb9d0jdjOS9c5R7kFe+0r2pX5UNWKFvnHuL0QMSboOuFf
         eRCjhop9jYetIrbfpl9WNhhVdLtj8q3lImrl0iUCHpiMO2QCYs10t3J3a+k0wBVLi66i
         JgJg==
X-Forwarded-Encrypted: i=1; AJvYcCUOWAU7Uxfxwruh+LMMasIdZErJvU42d7wFc5BiskJ/Dr9PlQv4u/NY8lygh9au7Sj5M0qzodw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqdVEZnvS6QXYew9z8Y6orj0QikGhlZ7qKb8Rsd7YAt9lHuxqu
	F5RJZ8p8HKB0lt6BO1K3onyENuA9R/TDTe5hj9uotJ/i6y3lvtmzJMGvUY6EAeUF71xB2dp4cRC
	ydRzEo+q1u1kWRw4cle08sIiJNBQ3s+g=
X-Gm-Gg: ATEYQzwjGL6bE3Mr3URT2vQt27jWBTXFk5nArR5G2eublBmNZwyxlkVdWG0XTJVutp0
	MKfaT2YY+SCxXNsIP0Dvoqu96Z/Om4stryME2DpYrSGG94eA+rfjPpU9sCeLFu3YIGoygBpv4YL
	DjtpDRHxqYULQOdaSpEyHkJTeMZv00Jjf36g76MtTSVFQw8f7qeCPGeO+X0sIJZIoOtL/ZzsUpC
	cfxDEFgfFPT05PnDLB2gd9bKhjs/cuOHUFyYIwiVLXQ18qKn9G5cxeGabp9xrwnzmcufj3FOmHA
	Uuj86iwAda2FVA8p37bYjuiieLuYsEuwMD0bjVJZtvOQwB8=
X-Received: by 2002:a05:690c:e688:b0:79a:8dd1:53bd with SMTP id
 00721157ae682-79a90ac1347mr44295527b3.7.1774096460153; Sat, 21 Mar 2026
 05:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320071755.483733-1-dqfext@gmail.com> <20260321085820.GO74886@horms.kernel.org>
In-Reply-To: <20260321085820.GO74886@horms.kernel.org>
From: Qingfang Deng <dqfext@gmail.com>
Date: Sat, 21 Mar 2026 20:34:09 +0800
X-Gm-Features: AaiRm50ubEYsiJ8QdUgGTYRZ9K8nu7fagVUr9fv4mGrb8iGhNnEk2zwf6BQK5rQ
Message-ID: <CALW65jajTpzKPAfc3nNpKeBOLbqqP7LZjaNaq6Eji1G17ZzKkw@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: net: add tests for PPP
To: Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-ppp@vger.kernel.org, netdev@vger.kernel.org, 
	Paul Mackerras <paulus@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270206-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ppp_common.sh:url]
X-Rspamd-Queue-Id: C0DB92E54B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 4:58=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Mar 20, 2026 at 03:17:54PM +0800, Qingfang Deng wrote:
> > Add ping and iperf3 tests for ppp_async.c and pppoe.c.
> >
> > Signed-off-by: Qingfang Deng <dqfext@gmail.com>
> > ---
> >  MAINTAINERS                                   |  1 +
> >  tools/testing/selftests/Makefile              |  1 +
> >  tools/testing/selftests/net/ppp/Makefile      | 15 +++++++
> >  tools/testing/selftests/net/ppp/config        |  8 ++++
> >  tools/testing/selftests/net/ppp/ppp_async.sh  | 37 +++++++++++++++++
> >  tools/testing/selftests/net/ppp/ppp_common.sh | 40 +++++++++++++++++++
>
> Shellcheck flags two issues in ppp_common.sh. As we are aiming
> for new tests to be shellcheck-clean I'd appreciate it if you could
> look into this.

Okay, I'll fix the shellcheck issues and the trailing backslashes in v2.

