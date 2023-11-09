Return-Path: <netdev+bounces-46897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE6A7E6FEE
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 18:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FEC1C208BA
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA96220327;
	Thu,  9 Nov 2023 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5JXSI7W"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5D22032E
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 17:13:37 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23B130D1;
	Thu,  9 Nov 2023 09:13:36 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4084095722aso7919215e9.1;
        Thu, 09 Nov 2023 09:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699550015; x=1700154815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4AVwkXLIEdl9JfCYU2WPJHWlDPBRi3Q+4jqeNhAXcg4=;
        b=J5JXSI7W2hcPgda7jeCso4BYNJQ8hRcKDr0z46rjoGM6fsvdrzFmjFxt5rek43YX/p
         kIeJmLQ8d6ZWm12m2vH6nQyWtw9vnI6B60a30lp84aqei4O1iPrKh3AwgaBbywNwT4wL
         73RZ+gWjY9aTAUarzT0pTJzAwGbQbAe1JLVnLaW990rPII33LrDwbCbe9cDIFLawrqTX
         v3xBtelTGC2xIsN3bOmEMaChXBc0d4N7bgGJhPcvEXE9weJJyXAKKjrAzDKIArA78vBy
         s//MMkXHyX3++znvqRf15VLfIGyIWmVeqS1O6Gxi+0i7/69Xji16R6iXonZFYhGIyl7o
         wdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550015; x=1700154815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4AVwkXLIEdl9JfCYU2WPJHWlDPBRi3Q+4jqeNhAXcg4=;
        b=AzP3JwOCU/7seABUkXosH3c+mOofTOljSXR/e9yv8VQeyxAcoOl5rp9r+cYCl2pcKO
         8GXNGSksxvh8z7Nz8NVvP3OkRwmdThxEoP/lk7jC/U2G7doBkcW94ddfxEd3E8XNMnTd
         thJSqSuPzT07qLZ4en5FqJu1hikIYOitgg15jXD5rW1KgpoZYFB5CniNJhJms5u3eRCb
         mAwZuU5Vgq2hQIPLGadgVTrfT/VGkzDW/x+SjwNRCkJNEj5D8oJzmlIKVYfcual0DizM
         /OFYIP2FeviuQ5FAG+O436cPBZyElYfQARDNcQQvAi/z/ObAg3teS3bgrfyAi8xXJgD+
         UiHg==
X-Gm-Message-State: AOJu0Yzs0JO5EOZn+OH/rrS12eRad1rBC2eMNArje0FinWKsMNmewB76
	ZlE9XbcxHODKCo5k4IJRBkz4BgY162U=
X-Google-Smtp-Source: AGHT+IERbtAL0tYz/VeynBwEXIcTj5xImOUl1HbrgbJHryzZGHNYhFM8yhd55u1aZP2s52PKktSnzA==
X-Received: by 2002:a05:600c:3398:b0:407:8e68:4a5b with SMTP id o24-20020a05600c339800b004078e684a5bmr5433241wmp.38.1699550014820;
        Thu, 09 Nov 2023 09:13:34 -0800 (PST)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c4fc700b004064ac107cfsm2713038wmq.39.2023.11.09.09.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:13:34 -0800 (PST)
Date: Thu, 9 Nov 2023 19:13:32 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Hans Ulli Kroll <ulli.kroll@googlemail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4 0/3] Fix large frames in the Gemini ethernet driver
Message-ID: <20231109171332.kcw5yiac5dv7bheq@skbuf>
References: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org>
 <20231109105037.zppxrr3bptd7a7i6@skbuf>
 <ad66b532d1702c36adecd944e25f84e4497ef8b3.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad66b532d1702c36adecd944e25f84e4497ef8b3.camel@redhat.com>

On Thu, Nov 09, 2023 at 01:26:17PM +0100, Paolo Abeni wrote:
> I fear this is a bit too late for today's PR. I hope it should not be a
> big problem, since we are very early in the release cycle.

No problem from my side.

