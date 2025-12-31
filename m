Return-Path: <netdev+bounces-246465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F37CEC8D2
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 22:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E50D53005ABE
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 21:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F41B1A9F82;
	Wed, 31 Dec 2025 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sI8eNxjc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD130749C
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767215124; cv=none; b=gTuK9DDPawfnmvKzU/pV6+Xr+0Jm5PPK5H7FDT9gWNpnHoDaNGHexpS3bla00gIFM4SdJe71b4m7/KhjyIx5LJYOGDrMdicyKL+qfmgb64j71cOdWnzbzBdMbLmyzchwUtyAJ3XqeUCanyE7HV4FZAv/A3nnaqG9/rlu83LADEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767215124; c=relaxed/simple;
	bh=p6m5I6aCJ8gZ6SjaEzmsqRMR6GL6FXxzmEpExHTKdbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKRYRsEiMRFQv/pnqHOJ1p4rV5YrwQs9nA8i4vpVQMGgIrqSdNs9oSARzWoFC0pwknDclbRZ+ZydikQaFkXygPZWhwkOWFuTuZHv5tOb6AOrOc/07fFzvVSstbqqOh4Qp11MbIueUv6hjQOM2NxBLgNjroKDcTK7F/LwbzyLtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sI8eNxjc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF3BC16AAE
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 21:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767215123;
	bh=p6m5I6aCJ8gZ6SjaEzmsqRMR6GL6FXxzmEpExHTKdbU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sI8eNxjcmu3WT40tanlP9X+cUdsir+nT1LOvEetEkwsdzDlCdSnfeDRSFiLrO7/2L
	 sY41DgACXbs370P1KrzHQbp+Fi6cueEsxr97+kCg9drPBpGloIU3Wy/zuHgHlHvtqL
	 exIIYcV52IkwZS8Zv43cFbc7WL7xnoetDljG4S3KKUriy/6fH1UEkaVDmpp30CxYSF
	 RdcU0ZIENfltDBNP8TAecsDpqnZNeNo3398tdr5MDB9NHMekMjIfW/0mLL87A8U3C3
	 SuzGaKTReSkeXj4SsZI1fHAh1hU/yGd47Zu1F/H8Y89UKjM8nWP2zcO7oV7khXS3K+
	 JNuvPXzgDjaUg==
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6468f0d5b1cso6426572d50.1
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 13:05:23 -0800 (PST)
X-Gm-Message-State: AOJu0YwNyIgzI4DbvqmLiPgMYtdgXgQ1huujj1pyB7T2clgC8qeGC4Fk
	pGqi5dx2TArYQB3zMczNQXCgRNVUoF9ynRO7+gqY1+q3L2nbB7Zv8UaqbO5bBQV4GCqJV84XE3B
	8IVJwMreXRSLCzEmymQffxFhB/V4Ant8=
X-Google-Smtp-Source: AGHT+IHl8e1sa4GyqxUoss2zz15Ejn9v0hfuEMzDIma+W4DyrHdLRJU/QL094n35w2zRpzBlMcGpnBKFv88YcYJs15s=
X-Received: by 2002:a53:accf:0:10b0:63f:aa5b:bcf3 with SMTP id
 956f58d0204a3-6466a8be3f2mr22831342d50.36.1767215122750; Wed, 31 Dec 2025
 13:05:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127120902.292555-1-vladimir.oltean@nxp.com> <20251127120902.292555-11-vladimir.oltean@nxp.com>
In-Reply-To: <20251127120902.292555-11-vladimir.oltean@nxp.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 31 Dec 2025 22:05:11 +0100
X-Gmail-Original-Message-ID: <CAD++jLkMb1m4rgrvdT+u9gJg4b0YM1Ui2cwScTq=6pKssNtzgQ@mail.gmail.com>
X-Gm-Features: AQt7F2pvutAsA5GcmoHbq7WjiSMHYPgVD7GRlNZboZm96jquO0npowfeKRIjIyQ
Message-ID: <CAD++jLkMb1m4rgrvdT+u9gJg4b0YM1Ui2cwScTq=6pKssNtzgQ@mail.gmail.com>
Subject: Re: [PATCH net-next 10/15] net: dsa: tag_rtl4_a: use the
 dsa_xmit_port_mask() helper
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 1:09=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:

> The "rtl4a" tagging protocol populates a bit mask for the TX ports,
> so we can use dsa_xmit_port_mask() to centralize the decision of how to
> set that field.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: "Alvin =C5=A0ipraga" <alsi@bang-olufsen.dk>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

