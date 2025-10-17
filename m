Return-Path: <netdev+bounces-230557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0632BEB1AE
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 19:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837516E189E
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AF63081B8;
	Fri, 17 Oct 2025 17:42:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72562EA493;
	Fri, 17 Oct 2025 17:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722937; cv=none; b=Xdj1fIHIAAjanWHRxtgYmNZrZI1IjCUdVcKaNp3SXBYEEHbUhT4n+rxwKTL5pl72/kAR91WJ6fRKVq38QhJP0ypMzfXpcluV8EK50uOsMO21n0l+TGVOVmfVyCp3qB5wcxxqXyc/NXiPrNp/EEnnXYzt/Kzhn1GMrC5RUqIJLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722937; c=relaxed/simple;
	bh=7aBNyH1hs2A8WMcKkuyOjp5fNna7UKZ5GH7Ej+Gjhbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXDDJxTBlPkywQV/FZdtKV3y/FhRafZaWV2vmtVwhiFuvi6i6KotG3hS84QWfPoKkj+/D/5hyZTKas2ImpUVHgprxWwCCnK7sqhWinkwnNbe0YwBB3WGM1QJNsOPDB2U1MILTafdZgrxmxV+9Clio0TqsqPtET8W2Q14Rq4pm7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01BEE1595;
	Fri, 17 Oct 2025 10:42:07 -0700 (PDT)
Received: from bogus (unknown [10.57.37.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 223933F66E;
	Fri, 17 Oct 2025 10:42:11 -0700 (PDT)
Date: Fri, 17 Oct 2025 18:42:09 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Adam Young <admiyo@os.amperecomputing.com>,
	Jassi Brar <jassisinghbrar@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v30 1/3] mailbox: pcc: Type3 Buffer handles ACK IRQ
Message-ID: <aPJ_8XJyse50Tgfx@bogus>
References: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
 <20251016210225.612639-2-admiyo@os.amperecomputing.com>
 <99aa7b2a-e772-4a93-a724-708e8e0a21ed@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99aa7b2a-e772-4a93-a724-708e8e0a21ed@amperemail.onmicrosoft.com>

On Fri, Oct 17, 2025 at 12:08:07PM -0400, Adam Young wrote:
> This is obsoleted/duplicated by Sudeep's patch.  I am going to rebase on his
> patch series.
> 

Thanks for looking at them. Sorry we just cross posted each other last night.

-- 
Regards,
Sudeep

