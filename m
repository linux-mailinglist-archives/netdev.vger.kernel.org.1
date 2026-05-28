Return-Path: <netdev+bounces-292774-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPynMgt5GGqxkQgAu9opvQ
	(envelope-from <netdev+bounces-292774-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:19:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3085F586B
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FA0630C9A34
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323DC3E6DD4;
	Thu, 28 May 2026 17:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCvSc1ky"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18DC305047
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779987921; cv=none; b=MdMa9FyEiHgb+4xtYPb8x9IY8lj621VInyB/s/IR1TAOVjHJGzwfew0wdgG7k7IuEVzIWUcsdW53dvyvx76BXYKTUCPMKohjV92xcxf8eQKW6MOqOMZTCdx2z1ecQz3O7R0AfTFV1rh5jgqJ9jwW0PPCgsttVUd3kWJvk2KofZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779987921; c=relaxed/simple;
	bh=SLFbiKwocMwO5DEk5WAFFUXDRrcNia8HiUd2IqawVcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzBdm0cm7sUDic+YHcMvYdcDRV5ZG0XDIh7/YoUlz68npJztvR3h4NIJ31OC7sH2C89at15eN3z4TO6ufRSpsqKS4KcLMX2CQEVMuW+DZXb/VDgVy7rluRK1ruip9bw1b7Asc697m09kObEdERTDkMwwcRx+u/AEEZHDL+BT/s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCvSc1ky; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bcd0111ea98so1811374866b.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 10:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779987918; x=1780592718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=caj7DELYYoitqJzkwAwAnO2//zgRbVrrcuHcc9Z7N2k=;
        b=UCvSc1kyAJOX8F0KqgGIeiTxiSfjWLQZpJAWS7uH1ZEOCSxr9eQYDekTWDyDj7oP6g
         YG79kaWJtx83pMRsdIecATEGXJAtK4GYyxBSBb0wq3PPgsYQO4Cx75JIM10RuQm9Ipl+
         INa2m6ZnCuTzqnM8iKSUtmyhDXSs1R7n9mtZ4ObCvNcWiFlkrC83A2d6EkdCg58FT8ey
         hmlme1Zf3q54dG4jE3N/JoNcw0bc40ydqr8yFo2IG9TWFXIuaY6MH3FhQSj/zX18i4+l
         YLefo0ER4zcl58tWzYlHO98Krz5KqAusLu4z3ErsHJbVAh7c2MQJHXkcvk+dJSg7pCQi
         2GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779987918; x=1780592718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=caj7DELYYoitqJzkwAwAnO2//zgRbVrrcuHcc9Z7N2k=;
        b=PXZq9VpUO3hti2erFuJYc2lrgjLRxAXwKk6OVMZEsMECL7ZpM5BYkTomql3OMN5vRB
         dGEJcoSNPVOJO0T/KlksgC2FB7JfQxjLf6p7+gyHVrRJYtMIUdS1DIlAqYSCFcYSbvkK
         SgexCXC2XPkf5XkoRR9wpi3EmSZ5gdH1H4fWYSuNcv3SkfCq5ADFcA1UisiUvVlz7qkp
         iBtNN5D7l/7UD39I0GdiJa7szSW7huuHsSkraEd5jRvdE8f/w0Q8n6bVIbdhXa6Q2qL1
         Ufd+O7iOsV17N+EYVwCdimYLlI4D7mUQngG0kLb8UXzR0wV0P+YfzrZTL3EKCD6Xh6VE
         gMaA==
X-Gm-Message-State: AOJu0Yx4S3giF4JLAtUz5jT8JXhhuEMt8hZhAbAnuaTZaFcb0+X+Ykml
	mgS/z9H6xpfsAEQztuiFMEQW7xoglaOJJFjWd3A+cqZj4vk+sb10xX3D
X-Gm-Gg: Acq92OF4sgjlVYiBTAtaXrraK6uKhh0D/wky61L921LFeSGklDrwJq3vSGeFKFoM4Y/
	9lo0i0y/tDlGJfkZLSacpKk9Oz9n/Dx3RjOm4ucEsicC6MnYG5W9XYJ+JUcRhqXNz8Wcm5vQfn6
	w50BhWORRDxxiwNyXfB/dWScPHm0TD9CQCp7Evw0Hqu0SfVVTJ7+GvoGYk44I4mCfM8g+CpCsQp
	kJCVZ2tsokuyX9l1C+FYZ1D20f8boCA9ndwOokLndCZGSVm1Ymza/oLseTWQao3K1vV8OH1qP6+
	Yb9sryXmUfVv+ctDf2MAWSmOvULaBpq7WzP3+YNJC7aEo6IjJvhpkgqWEi+7dFYk8eit+IuA317
	7KVyga6u0ENEiMRDHWlEqSzxv0eAvzK3zWuoJdwRybIPTEPAf2JdAYlSnOVIPOvqFKp9YMEvIRY
	taWccGK2u9v4j+1yg+agj+HgWUmccQeLbEZE4xC3ULfVmW6K3igsaAn05N
X-Received: by 2002:a17:906:f5a1:b0:bd8:f7f5:269f with SMTP id a640c23a62f3a-be9711e020fmr4803466b.6.1779987917779;
        Thu, 28 May 2026 10:05:17 -0700 (PDT)
Received: from localhost.localdomain ([45.128.133.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc5ed2d38sm745682966b.34.2026.05.28.10.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:05:17 -0700 (PDT)
Date: Thu, 28 May 2026 19:05:10 +0200
From: Oscar Maes <oscmaes92@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v2 2/2] pcnet32: switch to napi_alloc_skb() and
 napi_gro_receive()
Message-ID: <20260528170510-oscmaes92@gmail.com>
References: <20260525125437.4061-1-oscmaes92@gmail.com>
 <20260525125437.4061-3-oscmaes92@gmail.com>
 <20260525084528.547fe263@kernel.org>
 <20260528142851-oscmaes92@gmail.com>
 <20260528080748.3e74355f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528080748.3e74355f@kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292774-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscmaes92@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 6B3085F586B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 08:07:48AM -0700, Jakub Kicinski wrote:
> On Thu, 28 May 2026 16:28:51 +0200 Oscar Maes wrote:
> > On Mon, May 25, 2026 at 08:45:28AM -0700, Jakub Kicinski wrote:
> > > On Mon, 25 May 2026 14:54:37 +0200 Oscar Maes wrote:  
> > > > In my testing this resulted in up to a 25% RX throughput increase in iperf3
> > > > tests in both directions.  
> > > 
> > > On which platform?  
> > 
> > Intel x86
> 
> LOL. Please. Which _hardware_ platform.
> Or to ask more directly - is it QEMU.

It was indeed tested on QEMU.
Either way, the performance measurements were just a sanity check.
Changing the code to use the modern API is just better.


