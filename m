Return-Path: <netdev+bounces-186285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FFDA9DF32
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 07:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D3D5A6F96
	for <lists+netdev@lfdr.de>; Sun, 27 Apr 2025 05:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6EF227EB6;
	Sun, 27 Apr 2025 05:43:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF9226CE5;
	Sun, 27 Apr 2025 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745732606; cv=none; b=octWBoWVLtK/4MEiVDwIiI9uj/XeiGSqMYNvtNsor8ZZyYN8Qx4NJo0gnRnmHqqEU1ZMpikFADsOaG5UecvjCkhb/eLkYZrH4mCqzjPpBGrsb4x92YB3Z2OqnXp9CDkaTJAJ9rnIeVzRpw+hN7ytBQqryhX7gWn6X55n4+X/eNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745732606; c=relaxed/simple;
	bh=fGptivm7HpFQnBALM9ABS0OE4T0+36zBT/L71NS477Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcrdFnFpObbiUNO1zGvJZBZvJXsqS8IPASld1l2/DZADhUApQ2Ona3Pvo8XjWmxJ/uOp1eWaxntUc3AyujnV9yWHQiDt5nkgaaXoczGEVDJ8kQNeTj1wUadParQeJHGR7pvq/O3Wiq4/VNS2Eh98F72+PnnkDcF7QEGG6Lcsr1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d8e9f26b96so31895895ab.1;
        Sat, 26 Apr 2025 22:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745732601; x=1746337401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oy4M4hL9SuSSgN6ArJgNtJBu7fkhmoEiZXyOUTNGzv8=;
        b=tt40fIlinBzUgnxDBQUUi9Jqz3Z6ew/XHzCisYcEq9ETTIF4lQ3CKrsMBWJp5lbFob
         2EnCRGjy+J3TXojBrwMZAywnvbfutGUua91y0fc18XHicVFjxEUXQ+JTXZeLEKlFGzM+
         VfntOve0i+IQbyZbODrOvuLSgatUWdC2PTrNTXP7DVrAiHyiiT+9eknIiUV2fE0gRg6V
         1RmjtvSmSgwYH9Cg5ww55ATkh2g4akyfVbmxBA2HR6cgaId5U8kUUWUc+txV9w2qKxyx
         N8d+NLsC2sk/WQg829bsa6gp39PBPUGTxiWyUDN6ZEPxhvJbzIqYCQ6spC0e+OmTeGSi
         QffA==
X-Forwarded-Encrypted: i=1; AJvYcCWaA+js85aEVLs48d7uIIeUHCY0c/ROd/q7OAkccrJBADLzdOAc8AUbTT4BuLHWraJ5rOocaglz@vger.kernel.org, AJvYcCWp7lfGyaXacgW4tiGkuYdZdSN66zheghCmklOGKhA1tJCyYM+LjWBcHDWVrT+L1buz2bOrX1sipYuN@vger.kernel.org, AJvYcCXuI46egPlWg+N2uU8E+BjWjj6JMy4A2E9n9Iqtnr9yHlYt95mfl4d50BnJWyfwhEU3pqYYpYUoEZyno+4D@vger.kernel.org
X-Gm-Message-State: AOJu0YzofOwxO+M9JVVSohy0RwmDngplMVepYii42kSytYh8vo+3QJCn
	VnvMx59UwqME2UfnpFC73VPyeqkSnlnyMbyukQ/oP/qCX5QUwI5qixxPpLurNe0=
X-Gm-Gg: ASbGnctgGXH2FzbkvgdeDE0aKEFoLZp+XG6XSoRh4fOL59YTXDe4bjvY3KIG3JdaBX+
	AtVqdU8ZC79XqIt7k953PUIftjTBcgzU3BAdwyqxaLk+65KU3/6ZJNvK04+E36vkpsHpCDSQVzr
	xy2pLl6fO3O/w98YfWEIu5Huckko+SnhhGSl3Z7QN5WDpZkWwU61LdLNDPGjFelU/bQOXdfDUrN
	SdmiciYqeT9ti0iR+G4ZTYbF2gCd8Phkvss03hXi9LopsCo0N5NnWIhLipk7ZNaHptEa630/l+U
	fVXHP8fCIuj9Thuo+JQb6I6jtV+mBTX+o+IqkHEFFSudWF+ZtILzkWGU6SRW1Cz5gwo3KQoQ3CQ
	Pz70feL6K
X-Google-Smtp-Source: AGHT+IEOemKhKGhg4a4tg8ITb1dquc69hh1KYuf5vsdw87ScX1yRti50XS5o1E8t+CiITwRmsLaS+w==
X-Received: by 2002:a05:6e02:318a:b0:3d6:d147:81c9 with SMTP id e9e14a558f8ab-3d93b46e94fmr97825505ab.12.1745732601683;
        Sat, 26 Apr 2025 22:43:21 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824a42153sm1610801173.56.2025.04.26.22.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 22:43:21 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d8e9f26b96so31895555ab.1;
        Sat, 26 Apr 2025 22:43:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDw9ZPPBno6JfuX6flLfwbObWdv7VTwvh+ObJc75bsUegOQNgGp1tnhC8iBdp32bCR5mg+0qT8irkH@vger.kernel.org, AJvYcCWV28s41ojcs/HxNWTXGfbBGGsq3n76H7eYSyHwpB10yCpMmDfRA8/8OFwsxGS9Oto7qwGUJf/+MbpeQgTB@vger.kernel.org, AJvYcCXGmNaHZpDaD5EuR6Qk3tY0ukg23/5rVL47P/OrCMLho8ePdas2F+P7QpQ8WcYJk2EQs0IAEPmH@vger.kernel.org
X-Received: by 2002:a92:ca48:0:b0:3d8:1d34:4edf with SMTP id
 e9e14a558f8ab-3d93b5cd78fmr81686365ab.15.1745732601011; Sat, 26 Apr 2025
 22:43:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org> <20250424-01-sun55i-emac0-v2-2-833f04d23e1d@gentoo.org>
In-Reply-To: <20250424-01-sun55i-emac0-v2-2-833f04d23e1d@gentoo.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 27 Apr 2025 13:43:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v64vy9Zx-mJgT7dLMMcx4nbAeQ3n8pbvwT6QkuMTL6kQTg@mail.gmail.com>
X-Gm-Features: ATxdqUH2fWJgqqz2HBql7fBmhdeRPMb6pK4jyUd7a8JS30hjhTPhRmRmPYt9c6Q
Message-ID: <CAGb2v64vy9Zx-mJgT7dLMMcx4nbAeQ3n8pbvwT6QkuMTL6kQTg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: arm: sunxi: Add A523 EMAC0 compatible
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andre Przywara <andre.przywara@arm.com>, Corentin Labbe <clabbe.montjoie@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 6:09=E2=80=AFPM Yixun Lan <dlan@gentoo.org> wrote:
>
> Allwinner A523 SoC variant (A527/T527) contains an "EMAC0" Ethernet
> MAC compatible to the A64 version.

The patch subject prefix should be "dt-bindings: net: sun8i-emac: ".

And this needs an Ack from the DT binding maintainers.

ChenYu


> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
>  Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml | 1=
 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-e=
mac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.=
yaml
> index 7fe0352dff0f8d74a08f3f6aac5450ad685e6a08..7b6a2fde8175353621367c8d8=
f7a956e4aac7177 100644
> --- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yam=
l
> +++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yam=
l
> @@ -23,6 +23,7 @@ properties:
>                - allwinner,sun20i-d1-emac
>                - allwinner,sun50i-h6-emac
>                - allwinner,sun50i-h616-emac0
> +              - allwinner,sun55i-a523-emac0
>            - const: allwinner,sun50i-a64-emac
>
>    reg:
>
> --
> 2.49.0
>
>

