Return-Path: <netdev+bounces-142981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D97DF9C0D5D
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 18:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE17283469
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A888216DE6;
	Thu,  7 Nov 2024 17:56:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4907A6F31E;
	Thu,  7 Nov 2024 17:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731002166; cv=none; b=rHpgKPKQx9mNi2izTYXkdqLoxeJvczYEFVRZnH5y94nN8HA+MDLIoRUm5FLYZlagaZwJW5T4mOpyVo046l1N+/+u+FAA+2AJIgCnUza0dZ1Fjwr4q2u+smT2B/AwG2wdT6pC8b9GTTsETY7S8kxk/DYHpDt3y+XUa7qDWbVOWAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731002166; c=relaxed/simple;
	bh=44SFvsY3EbVgoCeU0PGd7b4bHpTs/rBli5I/UFcljmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S51lwHtQsI8wA6v/2LYHOUNhaT7Zfz3mD01T4ycpiL3htChgNyOAFCMpxiIjUfpgvcOHCSgQ0RxPUBf1J2P5rZbANOOys6oACKEKF4OramItFeEY6haj1HEktnH5u+gl9ibA2/j/Rpoiuj+hL6Xuc7wrEfaoi9tldPmMv1o4cXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2feeb1e8edfso18747071fa.1;
        Thu, 07 Nov 2024 09:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731002162; x=1731606962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tP/qKLz+iHJlHRCHZdfo5uy95YSaSJ3sCnJdjK0vrGs=;
        b=SWunCwExSTeaWmNeN52OturGt3BepM7mHJg3fS/9I5pnmlQf3ugUtylkG6sLrPap+Y
         d8cs6I/41NBhoD/r8aEaIiJou/lf23rwD+KSjYdnw1jxKHN4Qf6ohqjeCBU7OW5cccAU
         pptnB/9WQonZyqgbtIrg1QSHYmbtnw1QeS6RfwzNGSb8o2KGJcw4XqQ8f7+II+qvQ6Ki
         +QIQ7mZMyI5YPDbbaFOxr0c6GxOOSs0zUlYOlT/n7y0ByKDG8RumVbs1vgGxRxzXQ+Db
         7WtOCb8m+Dp5L2CzqY1A6ZqxRPxproG3UCLKD6a/H+uv4z/CnA9rEgg/k3cZ+8+XARX3
         q4qQ==
X-Forwarded-Encrypted: i=1; AJvYcCW56NoOEY1ATirOjdOnzKzK1aLjbSMxa9Dm6t2cIwHltI/0CGY+zG//+LqPWjXDan3AORe8GoQY@vger.kernel.org, AJvYcCXKyX3zW73dAeDmRn62mpckdjvnGS5pwuNjGC+jGG6oX58ZlmbH5NRSDXj+ltA+YSso7Hqh93eVIft9wf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx36E+ujHgN2Jpb3ns0IU4wDaa0l/EAhiOSNMdx+J+lapJbYNSY
	lK4uxB7WyQiAIwLhuISAtr/N9cEfu3XobbKy7C0cErfsQ2russ0a
X-Google-Smtp-Source: AGHT+IFHLYpj3ZLtahOBia4xKuBby9WPxYjS7VNvCREv4Tc6KpmeDRWROurSFh27fQ6xP7UYP7qEUw==
X-Received: by 2002:a2e:bc84:0:b0:2f3:eca4:7c32 with SMTP id 38308e7fff4ca-2ff1f709790mr2939901fa.38.1731002162114;
        Thu, 07 Nov 2024 09:56:02 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4a988sm124806966b.59.2024.11.07.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 09:56:01 -0800 (PST)
Date: Thu, 7 Nov 2024 09:55:59 -0800
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net] ipmr: Fix access to mfc_cache_list without lock held
Message-ID: <20241107-lumpy-newt-from-venus-c61cb2@leitao>
References: <20241107-ipmr_rcu-v1-1-ad0cba8dffed@debian.org>
 <CANn89iL-L8iBwp=rq-YwAeeoUY2MTjr5akWm=S=k7ckpkaEy+Q@mail.gmail.com>
 <20241107-invisible-skylark-of-attack-e44be1@leitao>
 <CANn89i+kYM_QRsqGXfbw-nzTe5K=sbVW3G+Nb2pCW3so5Tr-7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+kYM_QRsqGXfbw-nzTe5K=sbVW3G+Nb2pCW3so5Tr-7w@mail.gmail.com>

Hello Eric,

On Thu, Nov 07, 2024 at 03:04:19PM +0100, Eric Dumazet wrote:
> > Do you mean that, execute the dump operation without holding the RTNL,
> > thus, relying solely on RCU?
> 
> Right, you might have seen patches adding RTNL_FLAG_DUMP_UNLOCKED in
> some places ?
> 
> More patches are welcomed, in net-next.

Sure. Do you have any explict driver that you need help, and no one is
looking at?

> > Clarifying next steps: Would you like me to review/test and submit, or
> > are you planning to send it officially?
> 
> For this kind of feedback, I am usually expecting you to send a new
> version (after waiting one day,
> maybe other reviewers have something to say)

Thanks. I am testing it now, and I will submit the patch tomorrow if no one
else have any further comments.

