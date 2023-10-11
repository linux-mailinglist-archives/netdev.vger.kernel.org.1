Return-Path: <netdev+bounces-40179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB1A7C6110
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770D9282597
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642E525105;
	Wed, 11 Oct 2023 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="fTRaLDAe"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5F125CD
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:22:59 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A53B6
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:22:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c9c5a1b87bso3198575ad.3
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697066577; x=1697671377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeVNiGwxsvJF+wlAgF5WVj+lSxGM+0XrruYrnnJJkOU=;
        b=fTRaLDAeLANnR+vKmkYyrRo5xJ/uhI9DU1Yaw330T90gH6RusP7YjdSg8Q3IPpewf9
         HZK6eBdLr8eSbElRs/pyoQNmwCyUR7ioz8+mF0nbfslW39Vkv9BcN+saMAK/E8Nk/72a
         bRF1bKA9Fi/n0KxjvfYL34yLkz2sgzmyxjq1XVE9i5WU64mzBSEPhawkVK44teapXfNB
         Qgi2MM68hNKF5f6Er3irrTd/QpOSuLOVHSMBcACQKi8ilcK4AUeVBAT6NbFXZDk0cP10
         2EIB74RiYR8BauPca+y/3ctPauG6KwKbk9mi5QxsNv8J1S5DM8X06QvXF42vkV7SkYi8
         4I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697066577; x=1697671377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeVNiGwxsvJF+wlAgF5WVj+lSxGM+0XrruYrnnJJkOU=;
        b=sHP7hyEYp6p2MqwzZ+IbBVMMfMA3vZJ29Pr7/OB8d3F92W/OdS45LlD9upJIdHuT5y
         y97rWJEC9fyulXT0l1iDQgix3h2YusZdnzpYRq2A1lvqlg1oGsD4f6gpXwdzSiu8KMTv
         DGkzfdRSc59XjXTiNJjJQaFxQ5AyPU10GdckUjGqnxQGm3v7VuhCY3RDeX6ma/VBMOtC
         ROhimjIz/D+zzjRQ4mnlSjLLD6E61pvCXZNCISKkkq2xRYNjDPJ4y92r5KZbsivsTm+S
         maKah6uC6Uj7FxLqBI1xEL76Cd2xFI1WOmP9W9m9NzVCPedk//gZDIaZc/+/Iy7E/VX5
         0pkg==
X-Gm-Message-State: AOJu0YwbPkWnkpLyeauK54lokSWWfLj1RxNHvvfl2pqn30cXralmYrWY
	ovlGDgAQG+vZ45j1X8fI+4PGgg==
X-Google-Smtp-Source: AGHT+IHuTxbgGR06/zGKzrw6PZahK5qMxccB9wlJMHwXl/wYWvrFE4DFpkAkP12v/5XzmFWgb40JpA==
X-Received: by 2002:a17:902:9885:b0:1c6:16d3:1783 with SMTP id s5-20020a170902988500b001c616d31783mr18560284plp.58.1697066577246;
        Wed, 11 Oct 2023 16:22:57 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id je6-20020a170903264600b001bbb8d5166bsm407618plb.123.2023.10.11.16.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 16:22:57 -0700 (PDT)
Date: Wed, 11 Oct 2023 16:22:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
 support)
Subject: Re: [PATCH net-next v2 0/2] Switch DSA to inclusive terminology
Message-ID: <20231011162255.6c00bd6d@hermes.local>
In-Reply-To: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
References: <20231011222026.4181654-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 11 Oct 2023 15:20:24 -0700
Florian Fainelli <florian.fainelli@broadcom.com> wrote:

> One of the action items following Netconf'23 is to switch subsystems to
> use inclusive terminology. DSA has been making extensive use of the
> "master" and "slave" words which are now replaced by "conduit" and
> "user" respectively.


Good to see this.
I started on doing this in iproute2 CLI terms for bridge and bonding,
still a work in progress.


