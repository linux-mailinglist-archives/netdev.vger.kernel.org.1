Return-Path: <netdev+bounces-216043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A98CB31AD5
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183C91887263
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09352FFDDA;
	Fri, 22 Aug 2025 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFVLq/5+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932F2FDC3B
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871481; cv=none; b=HlahnTOkqaGZTBRrfRPblpERBiBs5Kbrx510kW7iFGMytYaIc03+22rxaGud0EH9U0Zq/ylpwAqjQBjKpNH1moAwI99jaXVuFBkTD8a3RiRGIEfOQ+kLamBMJvJXUA+c99sar23LKeARTzBoX9lFjfx8MF1cfdtlPD2nBO+wbjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871481; c=relaxed/simple;
	bh=lnXfUbhwjwvmKYPmzSa4znMTh2n6CcVoBz5/ntha/kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyMzwzbYC73BKKdbGnL7dm82pNipMPqa7+jNaqB89kIDoPW3Ef0zlS5xUsDwZuIcw0oPOxA2H63U7I7SHxb+YzptoBgzWo2aTaKpDGxxfa4i7R+ZnIlGPEl+XX+E5GHCA3Bhso6f6PjXbbhey9ATplYfFd/Mwcsk7MxXOjGDAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFVLq/5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB16DC4CEED;
	Fri, 22 Aug 2025 14:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755871481;
	bh=lnXfUbhwjwvmKYPmzSa4znMTh2n6CcVoBz5/ntha/kQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OFVLq/5+Ub4dj8tgte5CU3YyS+G3fbUUCVHF/U0fN2r4VHg5Qc2QgGjsZX6ikjnRX
	 rwoJO+kNO+WT2C9Il4VcHqV9qGPlniquUYMxTaYPBFGsMalkVoT4P3yB4me7+FQxJO
	 Ztkhi1ObxOocGbxM/jgyg44dUPONEq78O8ThI7eikBEXCREwhB030j+FXrdPhDYvP1
	 SMASRyL/17cuNSMhyxVz5mBEto4pcz5tDDZEX7yRo9ihT7kpqXFLbITPtTAAqwnOAr
	 7AOUvOW3X9kahbJk6a0IDLbfWFPKxadajkDdF0MhGTvd3hlBjdaUDsRBuLnt9ToNRQ
	 /kIyrUWIcuj/Q==
Date: Fri, 22 Aug 2025 07:04:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: airoha: Add airoha_ppe_dev struct
 definition
Message-ID: <20250822070440.71bdd804@kernel.org>
In-Reply-To: <aKgVEYMftYgdynxw@lore-rh-laptop>
References: <20250819-airoha-en7581-wlan-rx-offload-v1-0-71a097e0e2a1@kernel.org>
	<20250819-airoha-en7581-wlan-rx-offload-v1-2-71a097e0e2a1@kernel.org>
	<20250821183453.4136c5d3@kernel.org>
	<aKgVEYMftYgdynxw@lore-rh-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 08:58:25 +0200 Lorenzo Bianconi wrote:
> > On Tue, 19 Aug 2025 14:21:07 +0200 Lorenzo Bianconi wrote:  
> > > +	pdev = of_find_device_by_node(np);
> > > +  
> > 
> > did you mean to put the of_node_put() here?
> >   
> > > +	if (!pdev) {
> > > +		dev_err(dev, "cannot find device node %s\n", np->name);
> > > +		of_node_put(np);
> > > +		return ERR_PTR(-ENODEV);
> > > +	}
> > > +	of_node_put(np);  
> 
> I moved the of_node_put() here (and in the if branch) in order to fix a similar
> issue fixed by Alok for airoha_npu.

Ah, didn't notice it in the print..
maybe remove the empty line between the of_find_device.. and the null
check on pdev then?

