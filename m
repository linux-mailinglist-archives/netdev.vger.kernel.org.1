Return-Path: <netdev+bounces-194560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CB9ACAA5A
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 10:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D33B167364
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 08:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F54E1A315C;
	Mon,  2 Jun 2025 08:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F071DA3D;
	Mon,  2 Jun 2025 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748851526; cv=none; b=dF0oxWSnZp7FyBMo91F1aaySNq9xHr0AKF1esVEbkX0MBZCIR5A1RM3+vYmZ0Ind8V77Cutj9sXOwywycIXfIAHBjo5xA8I6NGON9NmD9A7HleFk43palrrzVALw9qSNnmR2EZWI6WLUsRXrus0ZBpSLGr+7DBM5K3a4vIaKrFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748851526; c=relaxed/simple;
	bh=D96eIVOxJQ+rek4K05aRdoIjN1z88eGFOvWxNezKpKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2eqt000cZcj9OJ88UczVmg/8mwYeOsKBvYskes5Rt3eLqYCvbIEJSBJ681A1P1R3e/WP9M5rFyEHnlDCrsX+SKhpk3F3FuUqTBQpZWGqeFteFUgxbNUfbp0KwIVTDX9lEx/jmUlr37L4a2wniLznX3KHZsyoKiUSXYCx3snLMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad89f9bb725so832015266b.2;
        Mon, 02 Jun 2025 01:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748851523; x=1749456323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TnpUBJv6ndq4yD0mJwW3UwYjXvudmMh804MNYleN4Q=;
        b=sMWp2ETJsHPItQIPHxonbDo/QS7oKTLNW1LQTMx7BYMuDW7fNhklJk2yZNeaVkWEvy
         7r3bgY5KZYFusW/Z8NbTvUXuDvl/Wc1LJijMQOy8WAIwWhdc4ZRCeiGLbbv8cBBRJydo
         ZMkrun7NSr0s4iWnvXA+Kxx68eTD4kI1maJbxtPTfUdqCibEel4kvBlCS4V/V9kCLFtc
         KQ2laWAYsAoUbLqjB40h1aIHOCCAiamg6d79El8yMMUr5ZH088Jy7aS/Rggxi7ESr1P4
         T26IrsNgin5icxUpNtPcpSTuCU9Lj4vmvgu+rWED5q4T9WNXAfDls5UsOzNPsk1ygjkR
         6kGA==
X-Forwarded-Encrypted: i=1; AJvYcCWHYyiDEgArNoBTN6q9DOHsQXd7k7Xhw3w7fIbpoRb800sHyLYSI08UyzBR3KkuMHMj9RNQGC7/@vger.kernel.org, AJvYcCXDeHU5QUCbxO5vQiIO7S//MG2g6BeoDWUpX47EKpMOlpVns4eLSMHmOfPR3aERqc8j8BlGCydxxtBBhZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoForp42/DuQ9HWMa0VcOS/zsJg01pS335tdFk9+3Y1BUkXRWj
	k90FDoDzrQTI0JH7jhfTBj2DEquYVWSriRcRORbgQIZBEurzi+qCxFW+
X-Gm-Gg: ASbGncta1xMO5IBP14WzDOEwwjHKfWp/pL47PGX+I6oH7P9xC8lFnEmsJa4lUsO2ee2
	Gkt/1s5EaGctewIE+Nstd+U8YLPfqUjqP9o4ymrRcE7kV/cWg0/zaH9JYzamdeolgGgSTMhMsZM
	AtRi3ItjWgq+a4RfSE9FM+XJym/uVnSCRV1JHLdCux+2Dc70DM5ZHxzgKpwtj0WNxu6rjr5Hen5
	VtYQEdxLI/7TRXC+wgzzeM7ppO0pwnU/88UBF6gz+pDsgk/HS95hbW31j7C7AwkZiCEZGDT495B
	jOokvk40J0MgSfRar5UYFWUv/dyw2lLPmPdF6Kp8Gg==
X-Google-Smtp-Source: AGHT+IGsaRGKpbNo4CLvIKmr8AgOECTRgdOOpIFTSHWhx2VcsQ0PH7nvD4Q1b7jOn3RZkzgXB3lSyA==
X-Received: by 2002:a17:907:7246:b0:ad8:9c97:c2fc with SMTP id a640c23a62f3a-adb36b31a5dmr951412566b.13.1748851522528;
        Mon, 02 Jun 2025 01:05:22 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb2fb63cdasm611884166b.120.2025.06.02.01.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 01:05:22 -0700 (PDT)
Date: Mon, 2 Jun 2025 01:04:25 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH net] netconsole: Only register console drivers when
 targets are configured
Message-ID: <aD1bCTmWWrOZs+Lu@gmail.com>
References: <20250528-netcons_ext-v1-1-69f71e404e00@debian.org>
 <20250530193052.1bdbc879@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530193052.1bdbc879@kernel.org>

Hello Jakub,

On Fri, May 30, 2025 at 07:30:52PM -0700, Jakub Kicinski wrote:
> On Wed, 28 May 2025 10:20:19 -0700 Breno Leitao wrote:
> > The netconsole driver currently registers the basic console driver
> > unconditionally during initialization, even when only extended targets
> > are configured. This results in unnecessary console registration and
> > performance overhead, as the write_msg() callback is invoked for every
> > log message only to return early when no matching targets are found.
> > 
> > Optimize the driver by conditionally registering console drivers based
> > on the actual target configuration. The basic console driver is now
> > registered only when non-extended targets exist, same as the extended
> > console. The implementation also handles dynamic target creation through
> > the configfs interface.
> > 
> > This change eliminates unnecessary console driver registrations,
> > redundant write_msg() callbacks for unused console types, and associated
> > lock contention and target list iterations. The optimization is
> > particularly beneficial for systems using only the most common extended
> > console type.
> > 
> > Fixes: e2f15f9a79201 ("netconsole: implement extended console support")
> 
> Code makes sense but I think it's net-next material.

Sure, let me resend it (with the other patches) to net-next.

Thanks for the review,
--breno

