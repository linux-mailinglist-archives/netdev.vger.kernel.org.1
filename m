Return-Path: <netdev+bounces-98621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8288D1EBD
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD7E1C232C3
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2E016FF5A;
	Tue, 28 May 2024 14:25:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03EE16FF39
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906334; cv=none; b=UkZB6iPoP5rtO9GQE80mOZouwxQpi66e0tw24fd+dnAZedU3g7ZdR7NZxgS0jdjrzFjIuq8+QzLVToQv3X1k4Lj4Ql3SMXpOUFmAFhxpQDk1GZ2JdQOZNqi4YtkIF4JLxRVJ4vKpHa/hAcJMG3hJYddUdHrGDyO9U2YFDdpzq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906334; c=relaxed/simple;
	bh=qsAwwAgmwAR3XTijSFk+iQoJIX20uP0Sm4N3y6QFi0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyEl5FmmgU/JwAbDGDjVQyxZfqgmP1WBgB4tYTz2bpyq9tUFTpGI0IHnuJ1PbTsnpPfwRZijvZYt4EE0AWde570YXAXCoQ9pTFs3HGrNgUPStCeuL40tBzqy0IbJlwtr0B7K1WmEWWrtMyWj/3zailJg5/y0vm48U+dWcN4J6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a63359aaacaso114006166b.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 07:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906331; x=1717511131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hs1xgySS9IbM1mu3ljRr1ZQx3te5srTLWZH4sgEwWV4=;
        b=OphjmM4qwT3BXRBsm42DTbuhesq0eM9pFY0ReFfKr9qt3rcoyJml0eUJcDgaMRIBFc
         oUbzY5DMHzpXBJ8PME0Q0+R4Ac1qhv48ujuGd0au4YdqXL7FE2I5tboMcPAy0tpc3nmq
         lDcrMZ6HIat7LThPSzhuHR90uZT8PL0g9cdK/hC2LzS8A8dCTKglKkldHoh/gumgCTdY
         f3lN1+uehv1ylziNng6yWhDJN97EaHDI0Kxi2NNiI1E3QkSZiqIRYthAOkVaJUnxzYR9
         /okOOot+zmGpIVtaf27S4+jVOGuEj3ncYwsMx7XooBDYM4/9vX2ByhCqJHI7jrYyu8ss
         FRQQ==
X-Gm-Message-State: AOJu0YyVyehr5ihQ8XLHVQr2ia0iz1xP82Eri9S23QFUj1XQ0dUkaUxV
	+qHOnx7qenvv8URc+RKoc8ceAWimEkyoVKFoGTXSjoiXbAD3BRGi
X-Google-Smtp-Source: AGHT+IFZ8pUapLA3aH6wD/DhJyQSnrgelOhgrnVT1EUtlARlqKOmHW7M/H5yzKEuEzlHbctIJE8HQw==
X-Received: by 2002:a17:906:aada:b0:a59:9eab:1630 with SMTP id a640c23a62f3a-a6265134cc0mr768762966b.69.1716906330805;
        Tue, 28 May 2024 07:25:30 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc8e2b2sm625938166b.171.2024.05.28.07.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:25:29 -0700 (PDT)
Date: Tue, 28 May 2024 07:25:27 -0700
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 4/4] doc: netlink: Fix op pre and post fields
 in generated .rst
Message-ID: <ZlXpV0/oYc1bzemz@gmail.com>
References: <20240528140652.9445-1-donald.hunter@gmail.com>
 <20240528140652.9445-5-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528140652.9445-5-donald.hunter@gmail.com>

On Tue, May 28, 2024 at 03:06:52PM +0100, Donald Hunter wrote:
> The generated .rst has pre and post headings without any values, e.g.
> here:
> 
> https://docs.kernel.org/6.9/networking/netlink_spec/dpll.html#device-id-get
> 
> Emit keys and values in the generated .rst
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviwed-by: Breno Leitao <leitao@debian.org>

