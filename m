Return-Path: <netdev+bounces-246466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC61ACEC8D5
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 22:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EECD300C0CB
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 21:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8122DFF3F;
	Wed, 31 Dec 2025 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaI6nwFt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5E028541A
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767215151; cv=none; b=axfcfXE9ouANZ0VZGhfzX8a8t7mAwr8rAE5XrdzKHNh9jsxamKylYBs4aex6lKKum5WfKCJFq1nyqjKSpitK7tSKRPB4q4wDcUruhYbEQYL/raDBTmtXMbbqXTIFl6YKhN/No/OsOKoQtkj8qM6xaI/Jk3Ejwf0ZQ+ILUe3p4mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767215151; c=relaxed/simple;
	bh=gVG+4f3c3Bu5r+NrW92d4uzjYFTCADkD2wcaWwugsHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DH06tMvP7jRpSgE2QV14TfF4/YjSU2eHPa51ATdLHWbaRACanzkydvR9sgdRp8prCvO98RaLW14wartqXj2ca+rL2vqR0kSN199f/jj+xspOv9TZIvYFe5j/Ero7hqKWUk7G01QQb0cuuD9Qnzwc9Y2jKHHQb4TgzAiNSCKT6qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaI6nwFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DEBC19421
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 21:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767215150;
	bh=gVG+4f3c3Bu5r+NrW92d4uzjYFTCADkD2wcaWwugsHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AaI6nwFt7eFGSwaaTMzQQUS97nNUzWiCW4bUsCOWwP8yUdHal1E8VML2ajAtgavXM
	 hGNtaxZVDOSVvsnNbKwp+fVQSUn9LzWNfWZpkz0m5Y5O29YI9i5qj1FH6caJ+PV2uv
	 CsySj5WsX+ehzGTME4UcqFNt+Z2ofkWhzVpveYF43eoDXkQEGUZYKe+qKjyWdBiep/
	 uMaOmFlo7D3VAcBF+X3qs+AxbzUNS6czn6dkneIrBEkZiv7Eehd/Xf/LmFcsoUwYpZ
	 OzwexB2KhHHdlq4WTN/wy1Md6ngcYdLsUx6d1lvfZy8T1iy9/A+HlMesVb/HXyaj5z
	 XUUcEkLio4HKA==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-78c6a53187dso84522427b3.2
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 13:05:50 -0800 (PST)
X-Gm-Message-State: AOJu0YxRlufJPDMBJb9OWGZAmry64hTa74GRfimjeVtX+RWKMqmkkoqG
	69WKNG4uIj2uH6+MgNO1m6TJPYmIZvb6R6LuBTx+re7vL6d8b+49DOvZ2AXuad9Q28CdcITK0d5
	/C+SeaYPYUgQI37lgyofFvL0ZXW3D1F8=
X-Google-Smtp-Source: AGHT+IEO1aI2OXQUm//32Sb2/7MpJdNHv7Xj7duYLTmrfefQrU38FCv7hzxV3OozbA39z1dZQbQ1GY+ZFqZg35EHT4E=
X-Received: by 2002:a05:690c:6388:b0:78c:3320:9c4b with SMTP id
 00721157ae682-78fb400543dmr332717507b3.44.1767215149946; Wed, 31 Dec 2025
 13:05:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127120902.292555-1-vladimir.oltean@nxp.com> <20251127120902.292555-12-vladimir.oltean@nxp.com>
In-Reply-To: <20251127120902.292555-12-vladimir.oltean@nxp.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 31 Dec 2025 22:05:38 +0100
X-Gmail-Original-Message-ID: <CAD++jLkssrCry26f=-2GYb8QkiWJuMRjWGWZpP20SSTT9zYRHg@mail.gmail.com>
X-Gm-Features: AQt7F2qnrGJhMjQZLXEy69IxKHgbIPvZQ6eCMzB6sIXyhtwEQdxYHLRkAJde-m8
Message-ID: <CAD++jLkssrCry26f=-2GYb8QkiWJuMRjWGWZpP20SSTT9zYRHg@mail.gmail.com>
Subject: Re: [PATCH net-next 11/15] net: dsa: tag_rtl8_4: use the
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

> The "rtl8_4" and "rtl8_4t" tagging protocols populate a bit mask for the
> TX ports, so we can use dsa_xmit_port_mask() to centralize the decision
> of how to set that field.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: "Alvin =C5=A0ipraga" <alsi@bang-olufsen.dk>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

