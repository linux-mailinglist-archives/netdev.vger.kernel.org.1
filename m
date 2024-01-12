Return-Path: <netdev+bounces-63341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CE682C592
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 19:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F306284546
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 18:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA2114F8C;
	Fri, 12 Jan 2024 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2kW2g9V2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C814F82
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28cec7ae594so5599450a91.3
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 10:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1705084929; x=1705689729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x8WA3J+aVFFye1V6n2qw+4XA2DOWJGSaTDfT5ZPdGSI=;
        b=2kW2g9V2wFWthWGPpfkxIXjO+OCI7MRxM06oELfWwcVLfDO1e9WST36PAgo4RsI6S5
         k1q3oOD7/VeRXRuXTV6KMLe/MSTOrwH+rlJuD/gFCiBDxCzMtgxz1vyTjsQoEvtO6XHc
         cbmPJaZFslHZ9Lj/ztfU6K9Ha+vrlZ0Cs68dGWuoivnK7hOLgrVOV1s0kAxN/DH3apxg
         ZeTNlOh3uMyX9pKO9l8lF/SOeSkfjXzxqzT8HXvdHdqi5Zf4CVtr/VbdsUyzSvw35nS0
         XPFuHwBPmBxT+jGCOO5+d+E8iAzofDbPPLBk29VKSlUbJgtpGfN9xYGSEJBy6MQQMfYo
         9ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705084929; x=1705689729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8WA3J+aVFFye1V6n2qw+4XA2DOWJGSaTDfT5ZPdGSI=;
        b=Br7as7nybbknExqrCftR2clg4vLfAHrYpy7NY5lPPg4tFCnuNa+f2DdVV1RZ2VE8Ri
         KK65ZwIjTndBkEWrLH5tfxbfZiwOiDMMzTj5H8iA7pAg6KZiJPb1m2N0WxyCuyS2xwuK
         1nOIu1hDWGSD458xWPN7Ec3GVU4bjFH1L23ypuQkMmiXgp2EWo3UJ8sQvXsmZWTc2Plk
         1IJd5ZYX1Ixf6Zcmt7x1mk6SyqBi8x1NcS/Ygo3yS6PaYXpTQ2ooUgjr5dctwuVIQLG/
         CkofXAPKJtpSmk2ilTANjO6BwUIoVLSctvRIhp9hU8K1YwnWC4O2VXlzRFiybSsI4NRu
         AngA==
X-Gm-Message-State: AOJu0YwQpBayp6R/o92f8SwMNgNxf8bAlG2mUQOtRgU6imPod+V3YUL+
	jfjYAw3jCJdz71v4QD6nYH4R0dwvTgBpbA==
X-Google-Smtp-Source: AGHT+IHC9b0fm5WWYAr5DV7Qsj9TDFS+QCNDizz+XcKbcUvtcRAVpyv54oaTzp1mTlkws9V6gdtxIw==
X-Received: by 2002:a17:90a:ad0:b0:28c:ee94:cbc4 with SMTP id r16-20020a17090a0ad000b0028cee94cbc4mr1669978pje.63.1705084929595;
        Fri, 12 Jan 2024 10:42:09 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id sg9-20020a17090b520900b0028d9fc97c29sm4535565pjb.14.2024.01.12.10.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 10:42:09 -0800 (PST)
Date: Fri, 12 Jan 2024 10:42:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] man/tc-mirred: don't recommend modprobe
Message-ID: <20240112104207.120c0993@hermes.local>
In-Reply-To: <ZaGDLociGHMaumZY@nanopsycho>
References: <20240111193451.48833-1-stephen@networkplumber.org>
	<ZaE0PxX_NjxNyMEA@nanopsycho>
	<20240112090915.67f2417a@hermes.local>
	<ZaGDLociGHMaumZY@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Jan 2024 19:21:34 +0100
Jiri Pirko <jiri@resnulli.us> wrote:

> >> 
> >> You can't add "ifb0" like this, it is created implicitly on module probe
> >> time. Pick a different name.  
> >
> >Right.
> >Looks like ifb is behaving differently than other devices.
> >For example, doing modprobe of dummy creates no device.  
> 
> Older drivers did do this. Bonding modprobe also created bond0 in
> the past. Now it does not. I guess ifb behaviour could be changed as
> well.

In most distros, for bond and dummy, there is this from systemd.conf


options bonding max_bonds=0
options dummy numdummies=0

