Return-Path: <netdev+bounces-204455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60488AFA9F7
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 05:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D4A172E1F
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 03:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963531D9A54;
	Mon,  7 Jul 2025 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPu3+fvM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D211C5F10;
	Mon,  7 Jul 2025 03:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751857631; cv=none; b=OLKjeyt0tysNRTGF1xc2FyYVT8IB8Jgg47AnD7YgnLl33k276eFrxgrLaGbQXeGzyboOBHlaYEtAvtrS2q8Mwk7ffG4WHME3+KsAyBDmPFrnlYqRX0fnpmgyGHoRAa/Q4FhzRam3IJQOmd5eDjWwsgc7s9pxubJEGLOl1SZPwO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751857631; c=relaxed/simple;
	bh=v1UftHYhRB8xATjAz1JGnEzRaXydzhrZZxcPW/vtTUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPZkV+N6Buxp+biyosBq/PHTDg0c8OoUZOb+rjMMnWBzu4v4ywH6qsnsYqmwSKbrj62Pb9jRPqBQngDyJ5ZTc8Wkl6b3aIQrfyQd+p5errvTqTeF8VQUYPhgsQET0ASI4wmgFnjH1C+x9NX9lp8qAKaFN3LIkInsBdyrWLyusZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPu3+fvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1ECC4CEF4;
	Mon,  7 Jul 2025 03:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751857631;
	bh=v1UftHYhRB8xATjAz1JGnEzRaXydzhrZZxcPW/vtTUE=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=gPu3+fvMr2YkUv5RMMYP/4O11elB3jPtO1/cV6SnNUbtzSaH+I+9HqQBG1opoginv
	 6I1AEUSUUrsUnhiWWnQljRjzQLFk3LFX48UBxbrxmBFKfdDqdyBXsTteLxTZrEBtf1
	 JZvTpPrDmyigr3Yah/O4o4zltWPjHPih6s71SH1iZORm9h7hl8w8HSRWNNRtp/dHRs
	 alt1Ku5poCl9IQb26oYFK42+UxYn33OsouzPx074d6eg4720yTwACIaxDjE4TKQ81n
	 wTewSc1PU9tNcUMQ52Tu56xrC91xCVUdQLZHNEa2LttzIJqMCv9076LmMYjXJYAOeu
	 csflA8jap0FZQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-556373661aaso2387693e87.2;
        Sun, 06 Jul 2025 20:07:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbjAxudv06LKoO0h8q9mv47Qewx1bN7va6arpSVxPPuC3Xie39NkSLqJZ8ogluTVTtIxl3kelXFc/o@vger.kernel.org, AJvYcCWGuOOjRtYfhgAZ+RP2/qAm1cISw+xPgUJLFISOPCqzmpOpxTHldiGOxRly5qsNfnS9vgQZSRQWQvYSs2KB@vger.kernel.org, AJvYcCWu7Et+uSDX62itpuytqWvqfJz3c7f2QwEQ1Nh+wy5VKe6KJ/S+o10kNIGNubc80RTzp1UhpPly@vger.kernel.org
X-Gm-Message-State: AOJu0YyLFPX7HciNK1L159Jpvf/PoF857Mcadw77ZIS2pmJ15xBsEwP4
	/JYAGFoF8e99b/MXw3uUDGco2/Kzx4OlbpKZetlrE4voWpXjUMHyHO0hGF52kmMy/EXVS3+KmdU
	1mpiboYvg08fz9Tlps7QG2vEp+HEbfnk=
X-Google-Smtp-Source: AGHT+IHSPXaz5/NZR5gTdJVLlMOpQ/Or5z58I2fgm2B/VVEk81Iu3g65q4sL0qURMsxxw185/SUJwCyLy824+p47zXI=
X-Received: by 2002:a05:6512:e93:b0:553:2ef3:f73f with SMTP id
 2adb3069b0e04-557e5528af0mr1667783e87.3.1751857629190; Sun, 06 Jul 2025
 20:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701165756.258356-1-wens@kernel.org> <20250701165756.258356-3-wens@kernel.org>
 <c464d56b-dfd2-4e8c-a77a-4a0d05588768@lunn.ch>
In-Reply-To: <c464d56b-dfd2-4e8c-a77a-4a0d05588768@lunn.ch>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 7 Jul 2025 11:06:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v65rDZ+V6EuZQ5NDrV7n0C-4CpHLXP_M9M2hA-oR4cMJUQ@mail.gmail.com>
X-Gm-Features: Ac12FXzKWK3v5vqREGVst-EvPAuAK4s6ygrf3ghzOCWf6BVBtBER5yoQ2djNvyA
Message-ID: <CAGb2v65rDZ+V6EuZQ5NDrV7n0C-4CpHLXP_M9M2hA-oR4cMJUQ@mail.gmail.com>
Subject: Re: [PATCH RFT net-next 02/10] net: stmmac: Add support for Allwinner
 A523 GMAC200
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 4:19=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +     if (!of_property_read_u32(node, "allwinner,tx-delay-ps", &val)) {
>
> Please use the standard properties rx-internal-delay-ps and
> tx-internal-delay-ps.

Since they share the same binding, I guess I either need to split the
binding so that the new compatible uses the standard properties, or
introduce them to the existing dwmac-sun8i driver as well?

> Please also ensure that if the property is missing, the default is
> 0ps.

This is already implied in this driver with the initial register value
being zero.

ChenYu

