Return-Path: <netdev+bounces-221473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35CDB50948
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E88681AD6
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8748F2882AF;
	Tue,  9 Sep 2025 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KVRepvSx"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB15A2B9B9
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 23:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460834; cv=none; b=cD4C6zsQ1dT51eDnsKeKGA7mbDgDUzXOSNi/5lm+2CBK2wA4aYsRbOwelMTTy1FAJ3zl2r7wjUdB2mcJxDi2t1PMbd5Nif0TiOVyJM6+BPM8HFkNVdgjmRTNvQJVY7IDMldVItwSYGyZzF4sstEgOEL+QobQA/BG1ntDe3Gr8h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460834; c=relaxed/simple;
	bh=E6ZD1H6QAYh+Iw5LjP8zTuXu8SZFsHhAJJPeeCME+lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eQoT+TihPBsOur9bnSOTpyihP1gorcSYUIlWVjP5yziVc/Q1GjdM5Uq8bvzdSAJmSYI1cAELVigSWDTaMZXaC8zI+VIt7lYvsYE6Tdbo/b4OxXNcsjYS5rW9BfaYTI2+cPoql67oSHo/uunnfUQIEVZdvlYlkhRvpKNPWpE8yJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KVRepvSx; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b2f3d2f8-1a0b-4c58-8861-229c0bb06f5b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757460829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/Hvh+2vOtj/jFkFOnAU5o4Gre5byeUjDZdrAy6Cbx0=;
	b=KVRepvSxvygZvkS5LOVWrMwveQuKLNw5b0+iWzemli2bwXsVitAoEJzYZa8099a0Vs/BKL
	lD4TuQe3U3S1ygJXJCp3SGcQ6qlAH52FiNMFe1Y8/9LpCWXypvAIyjqlGXrQxOXQeDujgd
	byOlJs0I4NvhGqB2Owkl/BEbxmaUtIY=
Date: Wed, 10 Sep 2025 00:33:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 3/4] net: dsa: mv88e6xxx: remove
 chip->evcap_config
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>
References: <aMBLorDdDmIn1gDP@shell.armlinux.org.uk>
 <E1uw0Xk-00000004IOC-1EJd@rmk-PC.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <E1uw0Xk-00000004IOC-1EJd@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 09/09/2025 16:46, Russell King (Oracle) wrote:
> evcap_config is only read and written in mv88e6352_config_eventcap(),
> so it makes little sense to store it in the global chip struct. Make
> it a local variable instead.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

