Return-Path: <netdev+bounces-20637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7FB7604D7
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 03:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105D12816FF
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 01:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA19137B;
	Tue, 25 Jul 2023 01:40:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36A01FB5
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 01:40:24 +0000 (UTC)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16861E69
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 18:40:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666eef03ebdso2896151b3a.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 18:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1690249222; x=1690854022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nhU6y7XwoRFtx4SkmdksQsvIv9DXjvv1NdS5ywyg2g=;
        b=dwav9WIcAgOsLWjS+7lHn+Vx3A9Qw3Q1BCuyhBQ1El4nHUtSltSLDCuUxzhAgEJsmE
         pLnecry/oTlLVnux5klptRWFIM6GgwISb9GA6/hsyvMKhtPqezhQNwemggsq4FX+QpQl
         wfxKxGEhxbxkOJqi6xoavNglvGR4QhcOog6Zgfid4WYukFmlr3MpTs4c0day+vQGAv8O
         uD6y5KV7LgOvC0V/BKzhc5/jmEJbssZU7nSWdpe/GTLnw6tMQW+r9Lg32KDnDhWGjaGY
         FOkt9v4rbAwb2MUcBtTyBUqdgXWbdyIW07K+uXGlZPQIgar95jcUYnyNt8iwfxMa7scU
         nMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690249222; x=1690854022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nhU6y7XwoRFtx4SkmdksQsvIv9DXjvv1NdS5ywyg2g=;
        b=SWiUoL/vXDLr48mwRYa3jA5JRbdkyB7BAZZnUu5YyUh3JIgVNOxxFhkwPFFUiyoe0u
         DIo30JfA+SXp/J3WGobNHtx/drFMMxasFdgkp9iNofZR07yLz0z1iNBKFOXAWPiAF5+a
         BpeSNOxFsgy+ichrLcakORSje+A+aCFhu3XhIfxuQrjWJC3Zk9Xnzcl6YpGD8rDlzG9t
         TEXDEf86bkaBNTlJ2gfIV7Nr5Rzwm8a6sZUm80qhv6t28m45u7Zj4OQWaNwjxpYYdRVN
         6V/Yoih1+mEZ7HExGjoLYNkA4wovijBhOXRAEF0HmPnd/9JKVWnsng4VtBHvJ4zzJLJM
         VCxA==
X-Gm-Message-State: ABy/qLbAHkYqP/pgfJd/ViLDAgJs0yrWES8HXSuV8nbbLKQVPAHsNEci
	x2+GvhQqrFug/H4Egf8+m3zFtzAwaTl/cMb2NVXpjA==
X-Google-Smtp-Source: APBJJlEyrxJWw8t9qhd1AbBab7b5IG+pao8UariuqWbHAx4dQogB0SDx8iN9609hNS/RQuYOTl8DCA==
X-Received: by 2002:a05:6a21:3299:b0:130:d84b:eb91 with SMTP id yt25-20020a056a21329900b00130d84beb91mr12533822pzb.49.1690249222526;
        Mon, 24 Jul 2023 18:40:22 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709027b9400b001b392bf9192sm2188306pll.145.2023.07.24.18.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 18:40:22 -0700 (PDT)
Date: Mon, 24 Jul 2023 18:40:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gioele Barabucci <gioele@svario.it>
Cc: netdev@vger.kernel.org
Subject: Re: [iproute2 00/22] Support for stateless configuration (read from
 /etc and /usr)
Message-ID: <20230724184020.41c53f5f@hermes.local>
In-Reply-To: <20230719185106.17614-1-gioele@svario.it>
References: <20230719185106.17614-1-gioele@svario.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 19 Jul 2023 20:50:44 +0200
Gioele Barabucci <gioele@svario.it> wrote:

> Dear iproute2 maintainers,
> 
> this patch series adds support for the so called "stateless" configuration
> pattern, i.e. reading the default configuration from /usr while allowing
> overriding it in /etc, giving system administrators a way to define local
> configuration without changing any distro-provided files.
> 
> In practice this means that each configuration file FOO is loaded
> from /usr/lib/iproute2/FOO unless /etc/iproute2/FOO exists.

These files are not something the typical user ever looks at or changes.
Please explain why all this churn is necessary and consoldate into
one patch. Trying to manage/review 22 little pieces doesn't make much
sense.

