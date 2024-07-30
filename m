Return-Path: <netdev+bounces-114211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A99941783
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F3D1B256B8
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24DB18B489;
	Tue, 30 Jul 2024 16:09:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E390A183CA0;
	Tue, 30 Jul 2024 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355779; cv=none; b=b05a8H45sixlNau03uf6fTANQo6Rwl3z//Y7rxazowJGgfes/arFqMJAL5Box0uzypSJcL6hn1vyoQbylDUviSCDp24l9XJm/g6tuoSHVI0ETFDC88KhYAs6VhHdCV58jENcjzF+TFaNqavT3w7xmORdx2A7V5/WMhgl3PmSSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355779; c=relaxed/simple;
	bh=N8xmTDJRMvIhJBBDeTk4nVtpHzkV3FiuLMDSMp87x1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fh4QAzXfaXQ7N6PiivmbstMc/20eF6Yo6qVEmZgrr3lDI2V8qaVtAulZFyCq0wzrAQustwMf4v6g4NeelMTr+f+cMbixXCBB7ZLQk/HJ3fweeK+5V3l+HifEU+AZWjvYgwjASGhyrnaSYn8bUvCzBDnOzchl7aQrv9LKfvqpPv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so6588671a12.3;
        Tue, 30 Jul 2024 09:09:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722355776; x=1722960576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAcn4UmH5RiCwAaknPHPG0WgcmYmIAy8lr/o5KP9yT4=;
        b=vvimV+mBJRKu5EW2+WIGy74XWe0HpZ326QCHYjfn+aTnEWlqXo9rHKHqPJ+N5nIsAF
         2RI9z1wCHQNQeT/n/ury2oqQBpIohsN5AhtHBPDCiOzAbzPR3jIqujmend4sboN4n/wk
         1fTqe431MkFO6jOXzWoQfASccsCMb5ZNXjCBLHz5T9y/3fJyVveo1L7Oj3esN3uch7Ae
         m6nKpmOoChoL83H1SF6uEP+oHV3LRJ3KpPVFLqw7t6fDmzbvKlxsarHPLIXIOxDSSDww
         nb+Txe4sNBXDRggb+yHP8aFwHD2nfyVCiwu25y0x0EGRUIt6MV8HtYB/MY5d76hdD5tZ
         im+A==
X-Forwarded-Encrypted: i=1; AJvYcCVD85g3QusxJYV8kTu0GxKGIK588ikVj3DkPcmCDNC+gl1MbtmfzQkOKUfBu2gnF1khm7+Fy0bojirrrso93J0oufJtxnWBNck7InVuwryN4xuVwAjJbrH4UAL3TTkk0InGwcoc
X-Gm-Message-State: AOJu0YxA8quAA5xU4M4O0k8UoSd7fdHvTFfjpURXy4nQ+Eq/+wgsPlt3
	mEaDau0rHpmo+hCSBDRrIg4VbSvCHH1K2/Bwc0q2pJFl8icMQIRz
X-Google-Smtp-Source: AGHT+IFRH7D+1NcrPIs8KojJvmyN56aun5heC6nmYH4odFzhrksr2nwOayScHxlDc2wTkVc3AyiM/A==
X-Received: by 2002:a17:907:874c:b0:a7a:b781:60ee with SMTP id a640c23a62f3a-a7d401654ecmr844326966b.48.1722355775723;
        Tue, 30 Jul 2024 09:09:35 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb021asm660879866b.188.2024.07.30.09.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 09:09:35 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:09:33 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: Add skbuff.h to MAINTAINERS
Message-ID: <ZqkQPeb8iNlqfSh9@gmail.com>
References: <20240729141259.2868150-1-leitao@debian.org>
 <20240730125700.GB1781874@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730125700.GB1781874@kernel.org>

Hello Simon,

On Tue, Jul 30, 2024 at 01:57:00PM +0100, Simon Horman wrote:
> On Mon, Jul 29, 2024 at 07:12:58AM -0700, Breno Leitao wrote:
> > The network maintainers need to be copied if the skbuff.h is touched.
> > 
> > This also helps git-send-email to figure out the proper maintainers when
> > touching the file.
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> I might have chosen the NETWORKING [GENERAL] rather than the
> NETWORKING DRIVERS section. But in any case I agree skbuff.h
> should be added to Maintainers.

I will move the same change to "NETWORKING [GENERAL]" then, and carry
you Reviewed-by if you don't mind.

Thanks
--breno

