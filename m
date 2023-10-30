Return-Path: <netdev+bounces-45267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B3B7DBC84
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 16:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6522813D5
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 15:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62DB12E64;
	Mon, 30 Oct 2023 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/V6oVYv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326C18AE1
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 15:23:31 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA60CA9;
	Mon, 30 Oct 2023 08:23:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9d274222b5dso274021566b.3;
        Mon, 30 Oct 2023 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698679408; x=1699284208; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eNH80CZxnqUyHpVk9sm9AYdpPQYIATzHj8k0WS+FHSU=;
        b=N/V6oVYvBAJNH76k2/U90OBTjW7t1T/iI+SGR5mzdiLpF6DsBXAXlbYWxK5UZU0pDM
         i5pJAhvqZmXdccJVIsRIRVfdNEN6N3mQoRjeKcBc2rJVDp0ZRKCrxlBWmwTBl+NAStXa
         iBHbP8Mpf6MlYDYTrgUjmeiUNe5NGxjnagar1TkBbQifN8h3sp7xjkyHVCnVUAPpqGE+
         jIgd74fdn3zgO6lFU1vFRk1/j7kfO9I2t6+TQWiudC9akKm7Teg1SDcKlYtO8j54FFs/
         5sVkP38+PZUNPhXUkmlVMKZEwZ6SmwbDoiju5euWQtd8JLd5ZrqgkGOqUBW/BE5LgKqt
         cS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698679408; x=1699284208;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eNH80CZxnqUyHpVk9sm9AYdpPQYIATzHj8k0WS+FHSU=;
        b=mFeAzA1/GFkd3bJvj3K0bJUx17agRXBQWA1VJCuQbiiDCJxg8wfVRSf+bMNkoqyTbk
         LA4NpcV2kZwDV1KbUZ7JOV85K1yqVgdCrGe/dNSJjoTvYuxUQ1dWBdoUtKn83JxigS/8
         tBW9COMD4OuGkOX99UkcuouGywbu7gHZRzasdyHNMhGM9XcpqUVYUR/0EuyXblxs3R7g
         4MNqB2vn5YpFh/VmxvINScdtSOSZ1PoWefJaaC75RU08+0DWMEpVacFf10kp7b7PPRYt
         6lWpnaL09+eehsWLa5Eb+Dkh5aiJ7+9URNnGNjbO0sJT/FbNaQ+KZ1FhkgSI8C4v5N/u
         h5IQ==
X-Gm-Message-State: AOJu0Yz0dCWsvzwqfyLW+SmREOLr0PuMDlWT1g3iWTpoekhkeQ+cX/3S
	+FnaeXvXUdeDaWYb/9e6NVE=
X-Google-Smtp-Source: AGHT+IGS5nNGthSZEJLEA8gIhHr1Cj5VgpSa4w8EbK/pMrU1iBuqRElaTqG0yRemfGMfWVOoSlM0bA==
X-Received: by 2002:a17:907:74b:b0:9bd:a738:2bfe with SMTP id xc11-20020a170907074b00b009bda7382bfemr8196716ejb.38.1698679408000;
        Mon, 30 Oct 2023 08:23:28 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id j11-20020a170906050b00b009a193a5acffsm6129522eja.121.2023.10.30.08.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 08:23:27 -0700 (PDT)
Date: Mon, 30 Oct 2023 17:23:25 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231030152325.qdpvv4nbczhal35c@skbuf>
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf>
 <CACRpkdYg8hattBC1esfh3WBNLZdMM5rLWhn4HTRLMfr2ubbzAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYg8hattBC1esfh3WBNLZdMM5rLWhn4HTRLMfr2ubbzAA@mail.gmail.com>

On Mon, Oct 30, 2023 at 03:37:24PM +0100, Linus Walleij wrote:
> On Mon, Oct 30, 2023 at 3:16 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> 
> > Could you please try to revert the effect of commit 339133f6c318 ("net:
> > dsa: tag_rtl4_a: Drop bit 9 from egress frames") by setting that bit in
> > the egress tag again? Who knows, maybe it is the bit which tells the
> > switch to bypass the forwarding process.
> 
> I have already tried that, it was one of the first things I tried,
> just looking over the git log and looking for usual suspects.
> 
> Sadly it has no effect whatsoever, the problem persists :(
> 
> > Or maybe there is a bit in a
> > different position which does this. You could try to fill in all bits in
> > unknown positions, check that there are no regressions with packet sizes
> > < 1496, and then see if that made any changes to packet sizes >= 1496.
> > If it did, try to see which bit made the difference.
> 
> Hehe now we're talking :D
> 
> I did something similar before, I think just switching a different bit
> every 10 packets or so and running a persistent ping until it succeeds
> or not.
> 
> I'll see what I can come up with.
> 
> Yours,
> Linus Walleij

And the drop reason in ethtool -S also stays unchanged despite all the
extra bits set in the tag? It still behaves as if the packet goes
through the forwarding path?

