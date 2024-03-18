Return-Path: <netdev+bounces-80337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D9D87E5E7
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A1BB2180F
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B632C1A6;
	Mon, 18 Mar 2024 09:36:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44972C19E
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754586; cv=none; b=NaUlnP7PnNSuSoPWBNIpdCHybYSGpfHsOL1xR/nxmj466rJu/CtPRccNawHzDMGo4cEqU5dxt+mzkdkFBm7sfMuJqqoXufEkxQkeb7Om9Vl0c2YXHOeENFc2ZblMXUoSjeEffCqelvQ0QytLAhFsfGduOkS8fuwxSSvTti+QE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754586; c=relaxed/simple;
	bh=OSoJobqHSozFq2ugQbPZD7IjaysXUXKcohgu7ncoM7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgBJV8hTT6UEgg8TWHGNx5BIlowOgZxq2e9DbqWo+Iasmklqq/jqZBJLb0Zhw+w3hxxVYaTaipNyQ4cJBjWnjA2WX9zTCkwqFnaCQCP+T9VjiRxMaq7wH1j2/i05WWLV7un34yLfOwE0fXIZ3IssAczLEC6H3QIavrgyuNy4O6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a44f2d894b7so471079566b.1
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 02:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710754583; x=1711359383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxtFYkRtZaOMl4URhLhoMhTgqljXQTfj8uikvb8JokA=;
        b=nLuujEq8xYjIrNz0LQgktUd4bOJr80fOzyfp+yaBgJy17pOjZrBFwMqYlWrTMMTsoW
         9DIud9zc9aYp/2YdBBKVfz6sY3sog/BC31T+2UQWCNS27ftpx8KJ8l9/n7474fims+9x
         avhFP7Ax3DBjO0lPDIX0fw0knzeYx94LIdeIFAGJpkEBQ/HfCG1lt9mEoMxfQfWL779u
         IIDBU35Ysz5W/pgLqRW7Gbl2IBKWJGpdaJHFyQXBzOXVi67T+ATWuRtDHLj1tTnrKsum
         kbJWkZAqFmjsq/VkFKxvF0KOs88rf61YNl2agdNrjV4KYj5G2AIH5xU1z4sfpNYuXlvH
         tINg==
X-Gm-Message-State: AOJu0YxMks8T6coRNA9SH1r6i8KdsSxpv47crNjhkLCpm0ox7ymYneWR
	WruN3jOe5TdKmB7UBB2LwGvrfwKACdoHiA8rpudb4GhK0XraRcnk
X-Google-Smtp-Source: AGHT+IHcuLHagb63nCoq2yzHVtR2cwvPah/d0aM77KCOJupja+lP7Yuyb/BcyQ5i9lYn4ZUl6ZNWzw==
X-Received: by 2002:a17:906:e0c4:b0:a46:b75a:ed05 with SMTP id gl4-20020a170906e0c400b00a46b75aed05mr1994966ejb.22.1710754582809;
        Mon, 18 Mar 2024 02:36:22 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id bw9-20020a170906c1c900b00a4668970f74sm4660564ejb.108.2024.03.18.02.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:36:22 -0700 (PDT)
Date: Mon, 18 Mar 2024 02:36:20 -0700
From: Breno Leitao <leitao@debian.org>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dkirjanov@suse.de
Subject: Re: [PATCH net v2] hsr: Handle failures in module init
Message-ID: <ZfgLFIIgUDh8f1lh@gmail.com>
References: <3ce097c15e3f7ace98fc7fd9bcbf299f092e63d1.1710504184.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce097c15e3f7ace98fc7fd9bcbf299f092e63d1.1710504184.git.fmaurer@redhat.com>

On Fri, Mar 15, 2024 at 01:04:52PM +0100, Felix Maurer wrote:
> A failure during registration of the netdev notifier was not handled at
> all. A failure during netlink initialization did not unregister the netdev
> notifier.
> 
> Handle failures of netdev notifier registration and netlink initialization.
> Both functions should only return negative values on failure and thereby
> lead to the hsr module not being loaded.
> 
> Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

