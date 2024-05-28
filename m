Return-Path: <netdev+bounces-98642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 245228D1EF0
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 16:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD1B1F2365C
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 14:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528B116F91B;
	Tue, 28 May 2024 14:35:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92116F8F7
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906911; cv=none; b=pMkSet8xD8GRyX9WXTlvRVWnYRLG5I/Q+jxuh6eLlLLNp6AEimVTbGUjuMBalOyyHffzj8XV4JAQXo7heyeGuCi4qU6ZyL5SJPqLCyHv8urFg7XD4au4x7XMT8jFmn9q4F6hA1QhFXmD9dM/0n/0ay3z46GhchpIxsRXm2dajxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906911; c=relaxed/simple;
	bh=/nGhB9c8A+331G7SYk7FCAQiq8mBPLApK+XL8SaTJGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3aAWIGgLfOqLSy6IV4IkYBAMfekEfXAnnkLWICmWRosb+V2m5mIYdHYcczDHoJRdw0+6Oi+4t+fFHleaJPZQNNGT/cGnDr9HfjL/v8VTq/IHbcaTgeO2maAOwHD9jFH++ok2EctA/wiF2P0Dne+tytHWOA7HwMrHh2R3K/IWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57822392a0dso1188271a12.0
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 07:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906908; x=1717511708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQO2kredD+2T3otnmj2WQc5swXEV8QSYfustGmRUi9U=;
        b=Q4MIy3ZvEOS9eDKYbqL6KKyWbbh+KS4xyMryhyi0eBPvmcw0fub+iTPMGAPLyLGguN
         ZiyQLNJqoTfffwKBNArqa6CtFZLqv+YBXon7/YZEyZA+6rBQh2jM+ztcAAW8LmYHxQof
         qj3pykAv7EGS/mpNWzb5OMjTzsFzXLX1gm6dTfVg1nHxg+Z2Hl0ADMNFIpdd0F29HOWI
         T6vhJwrlE1ZnHNFgsVLjy34DkthaLVIjw9P9e8eKx/rLqfJZv+7AI87AlMYPFsPQM0+Q
         g8Q5KYGSEBbdkjs6aJ00d70nN2pqfhqCWcH6PbKVhZy67D8MAtL35onL6OlrJtx2yl45
         fZrg==
X-Gm-Message-State: AOJu0Yxvbk9EYjjhb9CGzyqnzhqxVOjZ9lHCY2QmANT/INtoW88bX23v
	nqJuX2UzoWtQfnEx5Zb92ibu74fxIJF4hd8JRJZuZsLJJBHLnH9m
X-Google-Smtp-Source: AGHT+IGJwl7AKXsTLQVjDqLaWbra3EPYka83/2cAo/+wbkSlBXo+19Hec0vF0/vHHP7xQEErqYWoBA==
X-Received: by 2002:a17:907:6d11:b0:a62:d028:ed59 with SMTP id a640c23a62f3a-a62d028efedmr557926966b.57.1716906907699;
        Tue, 28 May 2024 07:35:07 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc4f81csm614214666b.119.2024.05.28.07.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:35:07 -0700 (PDT)
Date: Tue, 28 May 2024 07:35:05 -0700
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 1/4] doc: netlink: Fix generated .rst for
 multi-line docs
Message-ID: <ZlXrmYrM8Gh2yHRL@gmail.com>
References: <20240528140652.9445-1-donald.hunter@gmail.com>
 <20240528140652.9445-2-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528140652.9445-2-donald.hunter@gmail.com>

On Tue, May 28, 2024 at 03:06:49PM +0100, Donald Hunter wrote:
> Fix the newline replacement in ynl-gen-rst.py to put spaces between
> concatenated lines. This fixes the broken doc string formatting.
> 
> See the dpll docs for an example of broken concatenation:
> 
> https://docs.kernel.org/6.9/networking/netlink_spec/dpll.html#lock-status
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviwed-by: Breno Leitao <leitao@debian.org>

