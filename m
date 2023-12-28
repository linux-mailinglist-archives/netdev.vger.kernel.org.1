Return-Path: <netdev+bounces-60427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C16581F378
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 01:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C01E0B223B5
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 00:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29B917CD;
	Thu, 28 Dec 2023 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="NbgleC1Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1664017CB
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-20389f2780fso4714047fac.2
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 16:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703724422; x=1704329222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPqkljWihwve+9ReiYXoWr+FKC8QIzSC87rgTJEjVj0=;
        b=NbgleC1ZWUivzelxhuZsbcZT+BVpTEwjFFE+vvMPek1OaeuTT4IKDkiDmHrgtJyLIU
         nITdhbIzosztwsCocJDTmHAenjtoN7sdjLSqLZivi/z0PPCQmA3GS0dNutwS09lp+EpK
         OaM/cZ7quFXjfMsYfY4Uh4qK7quNJLVOzYl+IVfeKR5QG0uCAxasJIi8nbQlfSWL8e5E
         Iib//bGzMeBSvOtEGbwxOGHfTKyMvjVPUeYLBxM+g/Zow8z2peDOrvQVc6Z+tAm8k32b
         2jgQMJAHUUUAQbBWx2GHMcMHyXXui9Xpjv65NAyuBUhpmvfS7b7+uMnjNLV77xkZsjGB
         zIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703724422; x=1704329222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPqkljWihwve+9ReiYXoWr+FKC8QIzSC87rgTJEjVj0=;
        b=m1azoK0dh5Y3KKOznSFWD3+Hp5AvKRxpcw4KxGOGTnAMAS6TO9euEd7t/p9jP034/w
         PsXHgRHG9yZPckkrBKT2hcqYNQDiytq1dYw0APz7w+eZhbtT0cb0SjL1O1swqDDvkIFq
         0M7nXmofpltnI6P79Ts+W9Z3N7ZjtGb/BkUMiwvc2SD6e0pRGZmKiGyrRRztKAo5jF2T
         PWQsHIHfiDAaGDSwkA3usgc6QtQPb9OOFTOAFGmtQUj5GOnYkYLT8/eBIihN45xtgTSs
         uUIuTZ8syvGzAbZLcgRGJBB8Iwj7DCAIe4VDsMlYe3UtVVkAx34LNxBrFIaZpkYxdOMC
         TSHA==
X-Gm-Message-State: AOJu0YyEQU8zv7xPlz7uLVuxp+y129HQdGstbDJ4CD/7jfY2yy9Kbp+e
	YwJxc+al9UW/HVuqwn9iRHqaSb15CaYFjw==
X-Google-Smtp-Source: AGHT+IGk1Bjs9jJEnl50MAx8kBvxfEIHYB3DdiMlCBnREgMJbr3z52lckTnfidJMFQWaJAz7InhOdg==
X-Received: by 2002:a05:6871:a483:b0:204:5b41:6e46 with SMTP id wa3-20020a056871a48300b002045b416e46mr9846638oab.79.1703724421810;
        Wed, 27 Dec 2023 16:47:01 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id a12-20020a65640c000000b005cdfb0a11e1sm8206545pgv.88.2023.12.27.16.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 16:47:01 -0800 (PST)
Date: Wed, 27 Dec 2023 16:46:10 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eli Schwartz <eschwartz93@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 1/2] configure: avoid un-recommended command
 substitution form
Message-ID: <20231227164610.7cbc38fe@hermes.local>
In-Reply-To: <20231218033056.629260-1-eschwartz93@gmail.com>
References: <20231218033056.629260-1-eschwartz93@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Dec 2023 22:30:52 -0500
Eli Schwartz <eschwartz93@gmail.com> wrote:

> The use of backticks to surround commands instead of "$(cmd)" is a
> legacy of the oldest pre-POSIX shells. It is confusing, unreliable, and
> hard to read. Its use is not recommended in new programs.
> 
> See: http://mywiki.wooledge.org/BashFAQ/082
> ---

This is needless churn, it works now, and bash is never going
to drop the syntax.

Plus, the patch is missing signed-off-by.

