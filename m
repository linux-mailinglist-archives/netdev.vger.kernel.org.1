Return-Path: <netdev+bounces-253410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UETzHc09d2mMdQEAu9opvQ
	(envelope-from <netdev+bounces-253410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:11:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFE28678F
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 11:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7ACCE300336F
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 10:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1DF32D45C;
	Mon, 26 Jan 2026 10:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3YroX+of"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A75831354C
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 10:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422283; cv=pass; b=jrWYD9FHdEVN+gjIcypTABqVjjtzFGXRFe5yIjqEwZkDLD9hj32zFEMIqIjZ7AvUKPBtzso4SG7rufctEmnN8AHRQwj1dztCy154YVtWHgXilCLOwQgC5n2KMpT1GiAMAlRGcv1bSbXUjhCgemG1IWHLK55+RtBRGgbbG5wSaKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422283; c=relaxed/simple;
	bh=7qO5wHPqVeLQmzQrukoO2j8QonqDy5iNr2FxI+LBRYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pR65AcK/K1aZ2sUFWq+hkfRuY61M7TtuGyXjXqKcDRKxb1TdDmK9GOi1RYQNykQt67c9nZd1ehvc2IVsgvCmpeRfLq1caSNmL4b6dAg5TXztE0QiQLFDxuPOZ8FhRn72c8S5gPnOaNHEoVNLAbZsyYn0Tr1cPU1WY6puYQ91Nt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3YroX+of; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-502a98c66f7so37990311cf.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 02:11:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769422281; cv=none;
        d=google.com; s=arc-20240605;
        b=lh1aTwmOVv3yorEp20yi5AeJtnM3vyF5NrMSR/wLqTi/LwO7+y8oo6z58d3X8r7SbY
         UrbpJOTkH0u7wqsL0qJtuWjg4jOArRBbvtDor2pTcR9PTL7SW3NW+IwUjhNXLIuJnQfY
         03TA/WA5ncP3zlQMjWmGepKSV3R4Z6twH6BKHlm1+CXOBAVzInQqHF0mdXE22krEWtVP
         I4Jz/LwHpvjWRosAG49QX0IC9L0y5wwmwWI2iGVwE7wVcbZrg96B9JzGPATcR0gR+PEc
         ngb9qt71apqQLbgONyL5SOX0HW536SAmZjAq3kl4qZk/QJYpgH+CU7jPR4/AlqHiijK9
         tQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mssb9nmr5W+RwPdCZj/FoJelAkGn3dNJ5Q5D62d9Ilg=;
        fh=jbo195CSOMMTf3ZXIhFvRPErnrQWsBr4V7dWAB29M2E=;
        b=biu0tPlxW4g6/gDSKuxVEFPxmuLz7QVNeAQ0fjuUFhQ8fCbYjlS8ZLQRezcRHfDHMw
         QDxZHi52JSkMkokJUyNTLkVp9f5sVRjpcYtUM5tKYhvbk8Bq/Z37lhi4tVxfyRFfS9br
         W0iPOGOUbQzIhSnwctKeCaT5DBa4/Hd/QeDdo6vGu8Qkr61+ghk5RCYHdTqB0fflPDJJ
         WyM9WyWEaqsJwboRGPfJ6tzkiu1vxMh6Xxgazjsk7DqgILLKPZPf6wHjnZ/j1LnYXyLF
         Z5vI/gRg5MWN1OmzBmtLTsb8Q1gnfd+LPhFZjbfRx3IWTQ0qij8pkE/ud3Jz2BjybH4e
         jKkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769422281; x=1770027081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mssb9nmr5W+RwPdCZj/FoJelAkGn3dNJ5Q5D62d9Ilg=;
        b=3YroX+ofCNljkMasicES/MCZquDznAiS4oc8rt4P7Ll9+hBKH9cHZXCDVyvEEg6iJP
         ExflFuiXipCkXPNiOqL2MdZbrW2lY7FGJ/JABiwT+HsetTkVEi5IDWUToBAhjki/hik9
         6kylwp5bFycL3PvMTXiYHp/Lt+a3JwN8JhW7kAKpGgSHzhq1dPKVMG5vtUHqRBD4FHpq
         zjR6GVDvH20B7d6nSlfFzBISzwGKRCP2OfYbfBQ4kzlKx2wd7B9jWyzcpGCE9YxkvNDg
         /Tclt2RVNwK+cNpxpwN/N/FbYKpp1C5OHhlW6gj1aTx9LLDFPdueKp2uCCktTDp/0aus
         SZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769422281; x=1770027081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mssb9nmr5W+RwPdCZj/FoJelAkGn3dNJ5Q5D62d9Ilg=;
        b=VvxZIZRiYN7b2MbpSATKHv9SQsyZBV8gTxbi/MkAmVcHc9RRWX3sCAhOcTgJ31Zfo9
         Ie8YMC4B94QjP3vG2XbxRtKUvYbxfeRXuC0LKquVDWaUrtgjyo3sN2vX8ErxluYSB52o
         CIxp3Kn/PSXoUvJnSPOuh1eC9le3zXxvBWB9985Tc4ts9CY4vlNIUk7JwgM+ajp0NJDZ
         lCQfOejMrNk5+p8sMcao98cjjQxBXtBTj9t8K5nW4D+jjS7lRSeS8w4VcW3p8MeZMaOo
         sw65Xdkc9AcBdtjDQ+yhclfBM4ZxIOBHhuBdpG2BKTkmajXlU75ORDWSSB2G1qrNAH7N
         fajQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPYFgqYyyaqBUuCm/erlYwFuB7YQUpd4sZ6+zx9iwFGrGtNb3rJAzdOIoKv7lLy6gyNVxPGjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/7OfOzqRryOeiU8c59Ga5WtZM2OKVy+uFkfnuLPi3fPiloDjh
	9Mmbvrlw3bZMIgjcPVoQJ09GWmSjeBPoZW1qj59syMnr9F8q8w6o1vs8g1whFNtrqoTuLLqT9X1
	csPyC7tIOPWnyEyFvKBQWGEnp+kGHc9uYfUO6oktj2kzPiYUmHjmz18S1vIE=
X-Gm-Gg: AZuq6aJMaCGRYJ5o8jbE4E6uONgCvTN3FT4coYcUzb9kHYSBYMUPpG/4FjbG03FWYyY
	4amqWV+fwwaA4926rH9CaFUF//oB6uofvWxXxsO7IV6D/HDdQD9CGnNmkJWxC1HT7sziglIXJo7
	ejLn1fajKiNbb9UCWN7/Pz/YKyKphsXD0hPQQ0FRNkiMe79SmOw6sWJDWI61oDEifilJtkPb3UQ
	Sj9qUWz1MXXL261LLWzYNOMMfJQsjG8QVmXDDnNoWkcY5QoTnwooJvYiDrPNsR5EDooeI8fAh2M
	uD8v/3c=
X-Received: by 2002:ac8:588d:0:b0:4f4:c0b3:f50d with SMTP id
 d75a77b69052e-50314b876acmr48505091cf.2.1769422280623; Mon, 26 Jan 2026
 02:11:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122185113.2760355-1-mmyangfl@gmail.com> <20260125152324.1b7e5a9f@kernel.org>
In-Reply-To: <20260125152324.1b7e5a9f@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Jan 2026 11:11:09 +0100
X-Gm-Features: AZwV_QjPEY8Jyvch2KTB5mfAsoR6pMMctAQZba8Fjfm5tMiR0WuVnU_nvBc_THQ
Message-ID: <CANn89iK9xfvQ275f+PPht8mM6K49mUq-T9D-4UUxUkTncM4tRw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: alacritech: Use u64_stats_t with
 u64_stats_sync properly
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org, 
	Lino Sanfilippo <LinoSanfilippo@gmx.de>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,gmx.de,lunn.ch,davemloft.net,redhat.com];
	TAGGED_FROM(0.00)[bounces-253410-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BFE28678F
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 12:23=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 23 Jan 2026 02:51:07 +0800 David Yang wrote:
> > On 64bit arches, struct u64_stats_sync is empty and provides no help
> > against load/store tearing. Convert to u64_stats_t to ensure atomic
> > operations.
>
> Eric, could you comment if this matters? I expect David may send a
> non-trivial number of these, I want to make sure we're making good
> use of everyone's time here. 64b accesses are not torn on 64b arches,
> and never used for control flow.

I  added u64_stats_add()/u64_stats_inc() back in 2019, and never bothered
sending dozens of patches.

Presumably compilers could be really dumb back then, I am not sure
this is still the case today.

