Return-Path: <netdev+bounces-59447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B81C581ADDA
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 05:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E551F23DEE
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 04:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EA153B2;
	Thu, 21 Dec 2023 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="WSoEbyHD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910C45699
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 04:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d94308279dso237017b3a.2
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 20:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703131490; x=1703736290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Plbe0wCNVVe1Ti2Muq1MUOVja+z1reqd4OIUs4dvMYM=;
        b=WSoEbyHDhOXlD9UrdnPPuSPQa5m0zELkGHqaFqM5tMX+YS2GwkC40TtRn6k2iX2BJ3
         0ZRpQEHMrlFY6MXZDPCEAmQbSGyg9qzcUkSx0UPIza+i4nD7Yhc3KNf9Bcuu00A4itIO
         tey9DlEiBgLrr2joPKzrT2WRmrx4SbuugazUZ4+tj7pUWtFJCPIyGIYd9nR7P5i3HVfx
         fe4RYiD6xSHmhmOpY8HA+C6k27q3QfQbnM+ciz4h3wOA9Ks7o9XJevOxVYMo1cit7wR3
         Wp2NBcVkfW+ItvszeJ12/Wvr18L+SdVXjd1T4TB0pzeJOftZXtFaIc5xSBSHFwT7H+m2
         X/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703131490; x=1703736290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Plbe0wCNVVe1Ti2Muq1MUOVja+z1reqd4OIUs4dvMYM=;
        b=URbDwytwdAZpx1OOnfxGT6iTpKgezME/nunOZAqmMZCoVlY6Tr6ARSNef6Q1H33TSZ
         e3PjWiG2sKCw1xFeQ8WRUy4f3dVan7bNtJaWVnRNTGxW0P9eWtfkF1DOf0cL1JwR5cPH
         rDys6n510VbUCKr0IYl/xQA6b23XzNEPrT7fM83xGnv0cieBCoqL2TOgQgIo3lDXyYoZ
         xA/8vP7nVVt7WBseQxyjrJDg1SKMPTeSAdq10Qs/jokw22s4LRIErMejBxtuPIVFhNIj
         Lyyh+MYZRnWq3qAQW5aGCulMu6V3MmLtwaXaKvPt+DgB6e5aaeOlLm0gY7/8xbXQTa4x
         4U5w==
X-Gm-Message-State: AOJu0YzSrbqq1OEej1DSgeXEMIVzOkFOiSTv+GEJJWNQPqvsuM7wArf7
	xRdZcSifb1sNdlNt/AKykwo8lA==
X-Google-Smtp-Source: AGHT+IFvp8aeXFGONlk9UREzy4SqZrrPmzqawM8/hMhX+4eYY3QsHcXyJCDzYCyqmekrW/ubRDBR5A==
X-Received: by 2002:a05:6a20:4f01:b0:18f:ec1b:6887 with SMTP id gi1-20020a056a204f0100b0018fec1b6887mr431834pzb.34.1703131489918;
        Wed, 20 Dec 2023 20:04:49 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id jc14-20020a17090325ce00b001d07d83fdd0sm514450plb.238.2023.12.20.20.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 20:04:49 -0800 (PST)
Date: Wed, 20 Dec 2023 20:04:47 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>, Roopa Prabhu
 <roopa@nvidia.com>
Subject: Re: [PATCH iproute2-next 07/20] bridge: vlan: Remove paranoid check
Message-ID: <20231220200447.5223fc98@hermes.local>
In-Reply-To: <20231211140732.11475-8-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
	<20231211140732.11475-8-bpoirier@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Dec 2023 09:07:19 -0500
Benjamin Poirier <bpoirier@nvidia.com> wrote:

> To make the code lighter, remove the check on the actual print_range()
> output width. In the odd case that an out-of-range, wide vlan id is
> printed, printf() will treat the negative field width as positive and the
> output will simply be further misaligned.
> 
> Suggested-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Tested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>

Why truncate the output anyway?

