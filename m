Return-Path: <netdev+bounces-198503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CE3ADC733
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 131207A88B4
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5982DBF5F;
	Tue, 17 Jun 2025 09:51:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422B2E92BA;
	Tue, 17 Jun 2025 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153865; cv=none; b=Xnj/XV9Upn9ET/78gm5DtlP/1ILP3syqkQ7z5KL50PKHxMNXYK+owSLKfOthsH6m5R1m0H8+LzMvhYN4mjIK1u/1kEuYqdlwqFIj2awTidotWsEOHy+meXd+nIXpMwBrxTEZEK0DMumZx/pHY8sRHSWHaS+R8b4t4XnrK3I14gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153865; c=relaxed/simple;
	bh=3Az7+WRoRgQxE44r1MX8buhcWV382HDxqmNp/BUNf0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ7RUorQVAc6DXa/eJeErjI8/FzY4+TyIZGuWOlP4AfMvbM2VVLEzHqzkW7cRfvCTd1roKtNo7Up3zWLbBKizQ2xCAzJ0PxenZCFj6m6hTMbpNVU/aleWMCZxo/nbAE4Xn1AyDnK3lzWhjjHVS/xVE1wgD9KLsJ3pXGc26CI5Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-addda47ebeaso1109181066b.1;
        Tue, 17 Jun 2025 02:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750153862; x=1750758662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4ScTAQg3qsgStvKKi5EXq7XLcp8WRSVfKIRIlUrPdQ=;
        b=BRa2xVe1xZnMwFQLA8TTVsMTa8uoghI1oErIUhR7GOg7RsLZV15ukGFF1xNJ/jJ6iL
         0qy/lJ5L4TzaPlVbYZKt7SPNy3LrHpozYgEqjGXDk/GSkWmXW2ybxZvoRfDcJSU3KtUf
         xbSgJXmLCS/LQGM/CgXuS8OUxvAgWZ8sJuR68LxIKuCS7WJ6MCsq10LglRGq+VlpS7Lf
         l8yLsiM6eJ5ICqDGHVt1H418hf0UCUsj/nF4+UO+MJRvfmZRUP2qqORuXz9w2oXyNc72
         Dnr9CzUBwTZ2c+ZyZA+B08ok+oIgUb3RGJHFhgm6eKap72jcgcsT7CyZ0Ay24NXYFAD7
         GxBA==
X-Forwarded-Encrypted: i=1; AJvYcCWFTiGRSN2InThFjpM81C/amURGhWTwzhKXKXfiBjqBc61RAlwvEXJF8NAKkrABYevIqUvcEdXC9de/CVE=@vger.kernel.org, AJvYcCXwFqBlS0bfewAkefzJcgeN6HJiXbqIeWzrOuQa47Z6o8+2+qb7OQa+/8yGpUWgKbSkvO9C9f0/@vger.kernel.org
X-Gm-Message-State: AOJu0YxE6ORF6Czv12EGh42WAQSPfP136PDQhGZjmc5kBU5DgBbxsIDN
	Q3/k107E04MA3IQtXlAsQ1157JbZdvhyS6X75s0B7KOscrTTK+35Mycl
X-Gm-Gg: ASbGncuZFTbD27TDqoZplMtvfTt+kz/VdjJsRB9fAh+z+05P8HnKf5Jp7QvvP14A9gA
	K9uOwKWA0tZ41iDso6FQm7Jcs9AKkH7obYdU2zJz4KNPEBBsOJzmDiO9aEmLgCKPRMYP5cDWzGX
	HraJc0Ed8zIa3Xjs4yeEBFFyFDhVTT9VUwUxy3vyzkmtL3p3dVGM8BAAlZoH3nd649w9FeEazXG
	RcgWtdolnXpKsCmP7YmTQHEW0gocbYvC/7VhvEsE2WUjd1XspzS6XVydnWXV8qHGct/m/cWM+3s
	C7LGrQpFvsDSZoKIE4o/hif5Twr1qlaCbIdrCHcMNp4Bz9Lw+6xC
X-Google-Smtp-Source: AGHT+IGDmj7MBHIcc9gl9KEt2qeSTfQRtaqJPc6RvWT2tm0MOH6JhNGUifr4uadxP3Qq2QRgezaOpg==
X-Received: by 2002:a17:907:7f89:b0:ad8:9c97:c2dc with SMTP id a640c23a62f3a-adfad357b6bmr1243524266b.15.1750153861600;
        Tue, 17 Jun 2025 02:51:01 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec88fe57dsm831256066b.73.2025.06.17.02.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:51:01 -0700 (PDT)
Date: Tue, 17 Jun 2025 02:50:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ignacio Encinas Rubio <ignacio@iencinas.com>,
	Jan Stancek <jstancek@redhat.com>, Marco Elver <elver@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>,
	Shuah Khan <skhan@linuxfoundation.org>, joel@joelfernandes.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
	stern@rowland.harvard.edu
Subject: Re: [PATCH v5 15/15] MAINTAINERS: add netlink_yml_parser.py to
 linux-doc
Message-ID: <aFE6gn6h2g4P81/P@gmail.com>
References: <cover.1750146719.git.mchehab+huawei@kernel.org>
 <0db3a4962bfba8eca4a7e0404331ce1398701f5d.1750146719.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0db3a4962bfba8eca4a7e0404331ce1398701f5d.1750146719.git.mchehab+huawei@kernel.org>

On Tue, Jun 17, 2025 at 10:02:12AM +0200, Mauro Carvalho Chehab wrote:
> The documentation build depends on the parsing code
> at ynl_gen_rst.py. Ensure that changes to it will be c/c
> to linux-doc ML and maintainers by adding an entry for
> it. This way, if a change there would affect the build,
> or the minimal version required for Python, doc developers
> may know in advance.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>
Reviewed-by: Breno Leitao <leitao@debian.org>

