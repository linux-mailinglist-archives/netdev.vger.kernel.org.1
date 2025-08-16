Return-Path: <netdev+bounces-214281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A79DBB28BD6
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 10:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361535C2EE9
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 08:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9072623534D;
	Sat, 16 Aug 2025 08:22:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3EE1B425C;
	Sat, 16 Aug 2025 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755332547; cv=none; b=aP9orEgZJCc79YOBtgAptoRV2mVLca+VuKCKkXkk9ch3/ugYdTn44RUEbNIZAg9oad6fFiZPWZIghUbY4/kQ2MKS0ej8yFq5/eKjwuqBQn5A1y8WrkDn3JDnn4GIBIF7Imgh54SfxFt1+/9MS37o83zbpQvBgnP2wfOE/q0/gJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755332547; c=relaxed/simple;
	bh=TM6bp1xwXZfHaRbosSDin92Zfgbdz9bNeieDgzOrvh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRyry5mKhXlF1FoLS/qQCyyYHLwGXCQ4y0aFJJbJX4AaW5jQOmo58ET/ISdfTf321yKJTlMa0dlvUuOMPcoR6NexoM0G5hniOt9lOdWBckDrjWn3IfUJYIQZJByCGGdmsj0Lj+YY4ukuDtbr8dbkss+QkgvXC0lKpSjzW6hPuvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-50f8af33918so879133137.2;
        Sat, 16 Aug 2025 01:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755332544; x=1755937344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsBaPqarhgIk8XEByqeqWZqmjqN39o7TFwQ5D893CU4=;
        b=gnemNf14isM9LVcn8WppExA4uryTHftJkfK9r6TWsbuuAclLmYLL/7d3VCFojgXBlU
         9D8uDmupUVBKxgVkw4+LqPRSxPCKVhIxHGRyrcj1vhDNvnXh7DHSl7PTM/i8p9y1HSn9
         eE5S8h0YcnXZY40mnhjf8nz5fVZF7Lck2Ofe7Z84HbmU5Ab/20akSX7AXT7XP4VjC9MI
         1qwdGr8AZWRdOi3Si0HD06hlzTvBcOdafBn+Tts3DYkZGOxmEQtKwLMpJSQ26q5Fmp4P
         bpnCmyvGRL6grToIj6ujivjJdH2sDaJSPoiMSf+jINXH9Ea6elkagRUbm8isBsSD1pQ6
         d/QA==
X-Forwarded-Encrypted: i=1; AJvYcCVhYCypsAHWCDzaAKPSBz7YoihXhXWbHMjKBc6pu7JaDMGfSlwKhbayIjU9+f8gKKYKNXbopCoORy/HLiX4@vger.kernel.org, AJvYcCVu4y95KnDdV7Jy8Ic/iw7mZRQ6KgwafL6ZZuZkM8dLfx3L8yda0eABfDOSkRA37vFoXbn4HvL9JE5z@vger.kernel.org, AJvYcCWfwTy+KRnt1fEyxia6v8sLt2qR50wUdpjax30UOxzVDUp5b3yktu56ZuQ3NABIqL/q8J9/QC/3@vger.kernel.org
X-Gm-Message-State: AOJu0YyPDVyzrIwrJjxLgdYcTZ2rbCu+4A1gGJo8+HpfOys3CLrAZvmN
	9oyaSiyyKDCEJVKB4OHgo4Biq8sTEuPo+LSUFzCOpJsU48++isLaf1U4iFPjKq2t
X-Gm-Gg: ASbGnctEsteqwMGoJg6PDR3irNv2QgVFxGgfnrQ55j0t5fOnOYZlDBsJctSUqDDu49u
	WHj+e4lsgEaDFZ+hboZxR0YziWLg6mGEnfRDnAJI+mR5/o954SIAfdkw/KBfYdYvYsEcHmIByIn
	38CFwVwCH7kxkF+V/PVmkbz2amLpEWmVSeaOoD8SiszemP0GC7H4XG5pR2LnZ6AqSeVNSu1JpoU
	8+cVGtjNU15LDnAWa+aRdSWcZMMdOeCe8VEsRjAKifelJ+0lZ1/lZKcyp2XUizAED1zUIXRIvqw
	77ZBpHp7N7fnU0ggnrVCwS+e4k2zfnc+IXt8fLMlXGN8ULNrVhId6CcopiyLzrmeYpncZcdv2jk
	H2F9qqLKqalO/zLE5R4OthnLqYoHl2OViljw8ojGbdNI7eHGRFRFWurLTIGUGV1Q87vewniM=
X-Google-Smtp-Source: AGHT+IHaiz4raVNdjFjtWOmC/235muh4ZiCovtf/P7sFWMPAzbeZPF5WSq55MTEMfmu5da2JFILUiQ==
X-Received: by 2002:a05:6102:809e:b0:50a:530f:baad with SMTP id ada2fe7eead31-5126cd388cdmr2197830137.13.1755332544010;
        Sat, 16 Aug 2025 01:22:24 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-890278ec6c1sm686132241.19.2025.08.16.01.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 01:22:23 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-50f88ee8ac3so752125137.1;
        Sat, 16 Aug 2025 01:22:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV02lJTsfL5dhznAvGOvkHT9P2Pvv+a7Q85/7OLsT6WZ5AzrbFk5QHpIi5erwkxm17A7hQodaZY@vger.kernel.org, AJvYcCW2ueq9AXojGKYDRN4W5lNV/h5M6dSUVNUr0IKP64DvvshXzx5A+P8BYXZB8dq0m2cNSIGedSczs0WZeU9+@vger.kernel.org, AJvYcCXiFrRyKuxsqjQaoFd7o1WsPYr4LGAU/BZVdta12FB2BvB8SL357dWY999j536tPVOtvTNQlWxbe5wb@vger.kernel.org
X-Received: by 2002:a05:6102:a52:b0:4e9:8f71:bd6e with SMTP id
 ada2fe7eead31-51267ec340dmr1989710137.0.1755332543532; Sat, 16 Aug 2025
 01:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815194806.1202589-1-contact@artur-rojek.eu>
 <20250815194806.1202589-2-contact@artur-rojek.eu> <68a6d0a7-b245-456d-9c7e-60fbf08c4b32@kernel.org>
In-Reply-To: <68a6d0a7-b245-456d-9c7e-60fbf08c4b32@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 16 Aug 2025 10:22:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVj8r_voaXqVdt07fRT5mdJJ4B2NFiK9=XhtYDCuRgz1g@mail.gmail.com>
X-Gm-Features: Ac12FXxA8TNUHbRbvipWZzi2vHsQ_uunk7HR-ZBiE8OpiAEHJPsa-wMKtKNt0Yw
Message-ID: <CAMuHMdVj8r_voaXqVdt07fRT5mdJJ4B2NFiK9=XhtYDCuRgz1g@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Document J-Core
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Artur Rojek <contact@artur-rojek.eu>, Rob Landley <rob@landley.net>, 
	Jeff Dionne <jeff@coresemi.io>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Sat, 16 Aug 2025 at 10:18, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 15/08/2025 21:48, Artur Rojek wrote:
> > J-Core is a clean-room open source processor and SoC design using the
> > SuperH instruction set.
> >
> > The 'jcore' prefix is in use by IP cores originating from this design.
> >
> > Link: https://j-core.org
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> How is it possible if this is v1? If this is not v1, where is changelog
> and why isn't it marked as vx?

The patch series had several iterations (v0, v-1, v-2 ;-), with a limited
audience.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

