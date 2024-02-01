Return-Path: <netdev+bounces-67900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FAA845479
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 10:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FEF1C28164
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 09:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445E24DA18;
	Thu,  1 Feb 2024 09:45:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from anchovy1.45ru.net.au (anchovy1.45ru.net.au [203.30.46.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5F24DA09
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.30.46.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780703; cv=none; b=IOQNuXhjkwVDBWFnEArjGnb4muZcJ3bXCqpOG0OhSFSGv3qnk2/PBFGHf+lsG/zyIJBJX2N2KFVVerXJtnRP7FcHBq+FI1FJJNnswwZzIKFzlRbGEGh+ADcjwQojKjFsAVzjSOvVWZpHoHdHO6hSluvTSngNdjQhnhZZbyNgiVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780703; c=relaxed/simple;
	bh=xHxcJs6KdzfPDRyRDwgWQtj0imeY+1vlKZQj2qJHI2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X6nLoSUSB92RUXgUfbwhjs0HKmaitDzuRkP4ZR2Yu5J7gxmV2saRwj88vxN/v9NgZ71E8XWQchj+9fg8ldbd4Vm7Ooz5Di5A0KQxYcDr2YegGX1xlGaIRLBEjmiUvGcVZnf0iFflw5qvh2sTAP+F3MNJJuTuwghl/ZDo9Wb8b7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=electromag.com.au; spf=pass smtp.mailfrom=electromag.com.au; arc=none smtp.client-ip=203.30.46.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=electromag.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=electromag.com.au
Received: (qmail 8865 invoked by uid 5089); 1 Feb 2024 09:38:15 -0000
Received: by simscan 1.2.0 ppid: 8681, pid: 8682, t: 0.3952s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.88.3/m:40/d:1950 spam: 3.1.4
X-Spam-Level: 
Received: from unknown (HELO ?192.168.2.4?) (rtresidd@electromag.com.au@203.59.235.95)
  by anchovy3.45ru.net.au with ESMTPA; 1 Feb 2024 09:38:13 -0000
Message-ID: <b757b71b-2460-48fe-a163-f7ddfb982725@electromag.com.au>
Date: Thu, 1 Feb 2024 17:38:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] net: stmmac: Prevent DSA tags from breaking COE
Content-Language: en-US
To: Romain Gantois <romain.gantois@bootlin.com>,
  Alexandre Torgue <alexandre.torgue@foss.st.com>,
  Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "G Thomas, Rohan" <rohan.g.thomas@intel.com>
References: <20240116-prevent_dsa_tags-v6-1-ec44ed59744b@bootlin.com>
From: Richard Tresidder <rtresidd@electromag.com.au>
In-Reply-To: <20240116-prevent_dsa_tags-v6-1-ec44ed59744b@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi All
     Thanks for your work on this patch.
I was wondering if this would make it's way onto the lts kernel branch at some point?
I think this patch relies on at least a few others that don't appear to have been ported across either.
eg: at least 2023-09-18 	Rohan G Thomas net: stmmac: Tx coe sw fallback

Just looking at having to abandon the 6.6 lts kernel I'm basing things on as we require this patchset to get our network system working.
Again much appreciated!

Cheers
     Richard Tresidder


