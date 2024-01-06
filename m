Return-Path: <netdev+bounces-62197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266AA8261DB
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 23:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C30711F21895
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 22:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A247BF51D;
	Sat,  6 Jan 2024 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="KXw6zpMs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F9F9D1
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3ef33e68dso4496035ad.1
        for <netdev@vger.kernel.org>; Sat, 06 Jan 2024 14:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704579030; x=1705183830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YntTIELPGPdMHyturrIg20eSWNGHruzw3MIeNxoF7ms=;
        b=KXw6zpMs7QkRniFQORMbr04g3MhxCrHPiRCPu2UVRrNsCNWabI4lYnno/yvVWvCiu/
         7gUEgJrKa52Xj6Zx1wyX1/VOlKjipDPw1c16Mqy7qFw/9ueJR0Rpr3wo8dBFT5dUvVwy
         FI+mjAVkry8vmx1iUCTIRADm3oTCZuvKfuXnYJnUqUwSr+LnolfmwU918rQB4EsZrcSl
         x8KTJO4DJpZdRsUU51xkcfvnm5tX8uqx8NTDmP8YRMmmnqIWw1TqMiQhLG5FIDQ+PpWj
         ZXL7fqyXl8UmvD2/kEIY+NMYlJtSAIYj0lzFy1JbloI97F3pqu4ey0GnKHUyf7Tw2/5e
         bkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704579030; x=1705183830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YntTIELPGPdMHyturrIg20eSWNGHruzw3MIeNxoF7ms=;
        b=TzYFbXkqUjZ4ApM1sPRjAkF1GLN0dKUFg1yMum6+qR4/lru97prXBf7ErEfkfqGiO8
         bP5iV8dw4GvJ0nNQijSjnrHQn68JET+8HmlhFPV0IOOZHNwVkSIZIOfHwQZaU/j5u0Ql
         b9GGZINOzzypLE5VzXLDfRMlMc8Dv+9xAahAJp920tv34ywwaoRgfnJr3J+ZC843fiPh
         6sVsaSXYhxeFINzYinJvzL+fhSKbc6ZgyY0d689ZOiC42Aef/m6F72FzUBMY7Bmg2fHs
         e0O0B1grcWKw1nCzs15zXn/s7J4+tToaY9t9MuIhDQShJU5ETPqxyoRf9rJnYRYtl8Ee
         1hhQ==
X-Gm-Message-State: AOJu0Yw3NAJg8A1omfwAm6gGhzAkQ96OOVWKgBOOWisJpJMKpKLWT1Tl
	c1sGKtXdhyZZB7bjJSZ6UiQGZa62FJPGuw==
X-Google-Smtp-Source: AGHT+IGEJAbaND8uiI4xJF1e8Ek/80nvG/VA0MOQUi23nWwj2YLZ2vFAq+0n6iMUyG/4jE/dAQprPw==
X-Received: by 2002:a17:902:bb01:b0:1cf:b4bb:9bdc with SMTP id im1-20020a170902bb0100b001cfb4bb9bdcmr1511033plb.9.1704579030136;
        Sat, 06 Jan 2024 14:10:30 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id jb17-20020a170903259100b001d4725c10f3sm3533951plb.10.2024.01.06.14.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 14:10:29 -0800 (PST)
Date: Sat, 6 Jan 2024 14:10:27 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] lnstat: Fix deref of null in print_json() function
Message-ID: <20240106141027.2ed2f890@hermes.local>
In-Reply-To: <20240106190423.25385-1-maks.mishinFZ@gmail.com>
References: <20240106190423.25385-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Jan 2024 22:04:23 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> Now pointer `jw` is being checked for NULL before using
> in function `jsonw_start_object`.
> Added exit from function when `jw==NULL`.
> 
> Found by RASU JSC
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>

Probably not worth fixing.
If the malloc() of 20 bytes ever fails then something is really wrong.
The Linux kernel will kill the process first.

