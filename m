Return-Path: <netdev+bounces-17722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A51F4752D16
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 00:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A9A1C214B3
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 22:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D2553B4;
	Thu, 13 Jul 2023 22:37:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D926106
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 22:37:15 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D1A193
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:37:14 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-2674d0e10c4so622278a91.3
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1689287833; x=1691879833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdnLOL461AgR0b+ktXPihwaXETymd8qoZq5kpQOZ5ZU=;
        b=zJe3bJdEZbhQYvgG2nEq7s/AqiZzo4nrYHN4ukroIH8vMl87WqiOWxBpKKiU32NawA
         3LkYD3FagAAUh1ikULQQ0vTMEFYnAGjuPEZQkwH5YruQyCPShwE2E1g2rrFBA3phy19F
         +E/VtHWW7PGaCbVajJ4JIk9orxTlUWXVuiC1rXYZeVKDJaiMkiQQXSQXvHy7dnj/DdLN
         TKJrJxe6WEoqeIkZx2gUfPTIAEomWTsQBm6p3ncBVyhSUffK85yEuCkBbM+Qb6mg6DdU
         a43mtiAQ7sC83v4hVJQu/bn3Mye7wr6EZvSLPOdcT61/AWGoHCLahdBvvTUCxmXmQ2sH
         LtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689287833; x=1691879833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdnLOL461AgR0b+ktXPihwaXETymd8qoZq5kpQOZ5ZU=;
        b=L6veS7IewTupsaEApYJAL+XuROGsXty1ncNs9mVveHa+E1EI2+XDy/43mRfYpBNH3G
         Jfmu8bHRm9Zg44xu+7Ny0SWGhRZBCE4dgkfTQZ9qJDnvb6HNkTNJbvFFKl0r/QhbpOt6
         8b4vFd1e1/FEq1a/2rkiJDbsIeCw5hBVXB6lxY3nUqHw0AIMB9BFF+LfDXWV5g6z0rwg
         FyU6KOAjxqjZ/NCo51iQXvlDFQycDKct+R5svN0Ss2CarhUjw9bNqnccbvFA2LbLu3ep
         OAuIuE958Ma8D4HSg6FggX8aWTptBB/otCO44Bby6Eb7C6Gkr34gj5+Oucej0AL4gCZ7
         kwbQ==
X-Gm-Message-State: ABy/qLYnCSzGjCEzEuUET0BSc0o39x2SWBdhfpNHTKUmK7rSkUjUXDAd
	XE3FMH7RvbRgGSCRtfLtmN+tBQ==
X-Google-Smtp-Source: APBJJlEgZyM47urF79sy+uY1JRg8HcjbBOzhYe4porbUra0soBhmtze/9jEZBrPItkMs2b+wseHOhA==
X-Received: by 2002:a17:90a:db06:b0:263:8eec:550f with SMTP id g6-20020a17090adb0600b002638eec550fmr1844228pjv.10.1689287833692;
        Thu, 13 Jul 2023 15:37:13 -0700 (PDT)
Received: from hermes.local (204-195-116-219.wavecable.com. [204.195.116.219])
        by smtp.gmail.com with ESMTPSA id 9-20020a17090a030900b00262d079720bsm49059pje.29.2023.07.13.15.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 15:37:13 -0700 (PDT)
Date: Thu, 13 Jul 2023 15:37:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Harry Coin <hcoin@quietfountain.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 netdev@vger.kernel.org
Subject: Re: llc needs namespace awareness asap, was Re: Patch fixing STP if
 bridge in non-default namespace.
Message-ID: <20230713153711.763b840e@hermes.local>
In-Reply-To: <83efdb0a-559e-edbd-a833-3891f04638ac@quietfountain.com>
References: <9190b2ac-a3f7-d4f5-211a-ea860f09687a@quietfountain.com>
	<20230711215132.77594-1-kuniyu@amazon.com>
	<b01e5af6-e397-486d-3428-6fa30a919042@quietfountain.com>
	<de5a9b44-fd6d-466a-822b-334343713b9b@lunn.ch>
	<83efdb0a-559e-edbd-a833-3891f04638ac@quietfountain.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 11 Jul 2023 22:06:45 -0500
Harry Coin <hcoin@quietfountain.com> wrote:

> Andrew, the only RTSP / STP provider I know of is open-vswitch and their 
> docs (last I read them) provide the caution to use veth pairs to 
> namespaces, but not run their daemon there--- and fair enough as no 
> multicast llc would make it to that code in a namespace as currently 
> kernel implemented.

There are at least two other userspace STP providers.

Multiple Spanning Tree Protocol
https://github.com/mstpd/mstpd

And older (mostly for demo) code
https://github.com/shemminger/RSTP

