Return-Path: <netdev+bounces-288338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJe9Egg4B2ottwIAu9opvQ
	(envelope-from <netdev+bounces-288338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:13:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6388551F4C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 17:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADFE63009150
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F7E35A933;
	Fri, 15 May 2026 15:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKoWG+4N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530823C455B
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857906; cv=none; b=LumxGsCW0fNMWL/V+gBfaADsHwQIly4TZjBIjKiDIi7A5Hh0PJdD+4GsNVltWtaimKNFVKsT0iewjDC2cQIA6+S3/yQYZ/+ohQthx5WrKdx1l1zmKxmE0ftkhY7Mz6n/vrDJj99H5gRjGewtcwJ2zuJ0IZsOuQrhd2jI+q/ARMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857906; c=relaxed/simple;
	bh=rNv5wTd+OwH9OrJwYf3t41fO3JHFELjQmAzT7Xm6Fxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmlzFJUjMBqzjA8/jS8X1jLox31CGFgqTytd6Yji3Is9Df2x0crqaOKlXoYwkt8gMeWsOuq41ikcu8RchTGVpIi7hwkMT1RlJ9pzI5SL7gNvVtqw5ii7OS85tgn+60NKGX6EC7td3400mBCVMxflrPg+Jy4Rpe4AhzJgnLnMDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKoWG+4N; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3684a6f3b0bso491767a91.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 08:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778857904; x=1779462704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZKkoPrtOMnP/R4I2FshePQlDkAk6vhTwm7Gaf2CmEI=;
        b=nKoWG+4NY6mZzHPqqabQeA7qgwRDnRRSQWF7xzs3bIoSYY2THHKluMZVE9zSgXzVpV
         qAVCbHyxtU19wHepaVb92Z+l/Q7k1Yvgrh9CbvglkJ96uebRpewmOJx46+uNNTIsU54u
         CCoxAXSOO3GXzRPWTudOI9yu90v8oUxxDCkvTHpeX466O+moDiGF1i52Rk5A+eAJC5Dd
         w9wPCq0Pf00GJNBPdWOIsiLBCK/mTqDO3ECitag7TAdG8TEiBKsDGyCU9/0VUnljqxnb
         3WhVtMk7wyrMTNfzRcxAruNpYr828CXu8JiehlTpZ49CxpocuT2FyoyXbS8P4114eZQZ
         iziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778857904; x=1779462704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZKkoPrtOMnP/R4I2FshePQlDkAk6vhTwm7Gaf2CmEI=;
        b=Zn5d0kCibPWbaJPVcm/O7KKccXFyQvn2wMjf+GH2ClmrxFDAVnlljk7g4A/41obmAu
         oicq1LcNUJCRa7OJ9nYc1gFz2mbqaLGncCq38rCoQ/qZeFU/CxFYc+JWLQG/WuXTCIoC
         sweH8N/KKr8tk2ZX4m2oA0eCn77miahJRm76Iryd5Q/HjjcS9yAN5u6Nj+M3IfbW7r+I
         KwFUWBIo6TimPNfjfE58325baT/T1uhCRdd5X5QBj6gCrTLf5kKRoTQf/SWnXv8Ey26Q
         pQTK6LAAX7SFirQDtv2HLuNojnOQD7SzHA9BtshBkN4UU9tfGjI4pdZGQIMIjATIplf/
         lL5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/0xNR7FZMvPQBckxAGJrZsa9qzBaloNzOdDd3GI2QiOb4kA934cHIp9WLjbDKFShb7z0yJfhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/sJYj4xBmgMbo2z8nB2F75TswTHB6SDv08eLkbGm8rd9HRXL/
	5Eed8Mr71vwOJkxUVF1mcQVUDa8/No3n4vnqwPRClCVNPpKiC+pRAJES
X-Gm-Gg: Acq92OEqHt5XH9TDyGHFOw5ylsAXrLISAudT8wtvqfOz6MHZce7Rzm/Ad0cvA4f7fIp
	HKuoRbC/4mwOTKo9Fl+ooaSyLhlt6dlTJo82jaXkMFmQl6TjA5cDpJT094X3OIIPhX2wFnZjpOk
	0pSO2Qx8GECgCKNx4zlsyuIGgMD9Ov7W2I2nODB3geANnK0sIEInTjqeIRFuEHcs1IasgjBbb0y
	VUDt7Z/GiY+JLMr579XB8skzdxKtS6RG1oaGffzdczALlQFRDTG5NdD696Dq+gSGrwMchCqnNwh
	UOW3A03KsQoaZJdjZyiYVB2ULLYaLAKKFi3kfLY7xcsdrq+MTW6dbsmVhQ8Do7BSOKK9R/rklO0
	X1QQhu+CQ+W6sug32lNvvl6Z5F0ND+EZzgovKGEG618sB6hfKEwPKN21ygbU6/3J5zBNo6a0MvC
	zanmHTB209VhcMSUgsIuEmOhp8h0dhacg86zrOPIjyxn3i2H4BcB1I9g==
X-Received: by 2002:a17:90b:4ec4:b0:368:3fa8:dbfa with SMTP id 98e67ed59e1d1-369514195d8mr3502620a91.7.1778857904401;
        Fri, 15 May 2026 08:11:44 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369517d73b0sm2968356a91.13.2026.05.15.08.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:11:43 -0700 (PDT)
Date: Sat, 16 May 2026 00:11:39 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
	kuniyu@google.com, mhal@rbox.co, jiayuan.chen@linux.dev,
	steffen.klassert@secunet.com, ben@decadent.org.uk,
	herbert@gondor.apana.org.au, dsahern@kernel.org, sd@queasysnail.net,
	netdev@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v4] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <agc3q4sVMIu_0btE@v4bel>
References: <aga1VyHpHaUhnGZa@v4bel>
 <aga8lH0sgneYCCgY@sultan-box>
 <aga_C6fXL0dZdDzb@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aga_C6fXL0dZdDzb@v4bel>
X-Rspamd-Queue-Id: E6388551F4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288338-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,linux.dev,secunet.com,decadent.org.uk,gondor.apana.org.au,queasysnail.net,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 03:36:59PM +0900, Hyunwoo Kim wrote:
> On Thu, May 14, 2026 at 11:26:28PM -0700, Sultan Alsawaf wrote:
> > On Fri, May 15, 2026 at 02:55:35PM +0900, Hyunwoo Kim wrote:
> > > Changes in v4:
> > > - Include the tcp_clone_payload() propagation suggested by Sabrina.
> > > - Drop the skb_try_coalesce() change; addressed by commit f84eca581739.
> > > - v3: https://lore.kernel.org/all/agW4vC0r8QOUKtRT@v4bel/
> > > 
> > > Changes in v3:
> > > - Include the skb_gro_receive() audit patch suggested by Sultan
> > > - v2: https://lore.kernel.org/all/agToIEDI4TaTNLRb@v4bel/
> > > 
> > > Changes in v2:
> > > - Also propagate SHARED_FRAG in skb_try_coalesce() and skb_shift()
> > > - v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/
> > 
> > Hi Hyunwoo,
> > 
> > Per your ask to me to use AI for exploring relevant paths [1], I've attached my
> > findings from a pretty thorough day of hunting for these with Claude.
> > 
> > None of the findings appear to be currently exploitable.
> > 
> > Please let me know if you have any questions, and I hope you find this helpful.
> > 
> > [1] https://lore.kernel.org/all/agWUdie1xBvBu22I@v4bel/
> > 
> > Thanks,
> > Sultan
> 
> Thank you so much. This is a really useful report; I'll take it and dig 
> further from there.
> 
> Thanks again!
> 
> 
> Best regards,
> Hyunwoo Kim

After analyzing the call paths, I also could not find any other user 
page write path triggerable on current mainline.

Unless there are additional review comments, I plan to finalize the 
v4 patch. Thank you.


Best regards,
Hyunwoo Kim

