Return-Path: <netdev+bounces-261222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCc6DZT+n2n3fAQAu9opvQ
	(envelope-from <netdev+bounces-261222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:04:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8E31A23D1
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9175B303843F
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5A3392C3E;
	Thu, 26 Feb 2026 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pWeDcwtH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECA1392C28
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092932; cv=none; b=XahTFkr7kIzYXo66/FVmJUCZSkAHOvsahFXJM4svtaVCktwEduekTPPPPmOxho5njV2UInYy6qmu79gpTCe7DvV7+eBqLKayBacFC0nBACmKR6GwHT+NXj03wBSkH/o1hSCMXwoUSYjz3fFQU8BHNmctcbvolbpZUJ1wt+n2Qvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092932; c=relaxed/simple;
	bh=psYWwKUvm0boCnP/VBokoXXzODe+2v77zcC70+9bdVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/982RsXPxWkI2aucUkuSX/ANZqOhVP2ShwgCLkZ5CAfHSFzdB7f/5jgUmuOmAveXDprFU+ORdjshXUaC78TPgn3Dh8d9s2WQ808c8DCZSkm7E7u9r+vgqao0UarfCfOjwXzDr6F6hcjs5xtK3NIqbOmY983TduyQxpnASrgPiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pWeDcwtH; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43770c94dfaso496877f8f.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 00:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772092929; x=1772697729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLAiq0vc9Bp5MrzPDt1hlssSl6Q9GvdlXHn67lqmMxA=;
        b=pWeDcwtH/SyTRxn/gel4iQdgnwFWvs5yJ/2OOLRnMxf4DhoDBWrdrLaEUQAUdIfCCg
         dHdlqwvKZFBHEeRcAuBl7UKY5quebtTrvyqdj4mmm0XpFjWMm6sKF3wvSSUCuRUXtYGl
         tppbX2ixmydtaw7utT039N2BdU79iLrPrbr3JbtRjTXU6qh8jWXQ8nP5edo3WgsumjTI
         GMT3M4042PYVjNxftpvxsyVeNkvuWW3NXM2uqGRXJ88qNjMlL7vkK8OZH5kbx3dKtdju
         PAmL88vzpd4Ov1N7UFGIYt076MA71ThtUdaIulRB53bQ0zChNlcDM8A2cGwnJodMpygx
         vt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772092929; x=1772697729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jLAiq0vc9Bp5MrzPDt1hlssSl6Q9GvdlXHn67lqmMxA=;
        b=X5CULlY034dExT78LxeAW/aTOlaiLpiS3vQwV3vSnxwGW6LGUCV9NKLvBVTcSJzQOO
         IDImj7mFhXtQb8umKm+4SSaQHb27yX9NwXbWRlRDwgHcA69RcLZ7wBYYaXU1b+XiNbVw
         hMJvKSJKAxFpJwegug21eVtd7e5hm2nkzuPtZyleptaWj8vj8r9Hyxsyq2eCD4kxHbIX
         4NT9wHmVmceKbVASl/iIXD6wIn5mkUiKJ4nPlTyq/GNNkgoJJMecKW32gU2zIK6pUL3V
         Ohr5ksWUlLYWP79saBYrtD/tRPlwUSMKIbZGz1+c4fP1KYykR1d4jAWsr9QuLrTMRaa0
         fAwA==
X-Forwarded-Encrypted: i=1; AJvYcCUCS49Ju/J4LiIMUtpiMMbEmF75wLBD9h0ouLjYSfMZttGhNH7hAlgtsP6NSYW61p354a+FAAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGtY3EU33v7MssOIsfNl7zu7IY7xO8fKm1QDv2p81R91brm0GS
	CqT8XHDsdOGp0ep3HdtAJqiL+IWTsd8xK9ZgpnFABgrXVrTFrGQOFhGWXvExEw7yYm8zxeG4SeV
	O5FYQ
X-Gm-Gg: ATEYQzwYlyl9sqnYH75hkXLBTiLxev0eB38mDlVkrWsfpK51fu9/T1Ag4/c1McRUGl+
	Vs4RHknNHNG9n1X8zgb0+VfWF5x6Yg7T446gaFgANbY/DVNT6pvE3VZ0MHTkaV+RSZD4QmvK+D3
	N0tZoFaX5TwOmwop5LbeW3s+raOa+tMsNLfQh4+eh1yFza454ZdOmYgGxjVatBjx8r3VQ4Q24oe
	A5ZWphaPgD4nvCnOCMM5Ur86Z2ODw1XOrcRlw3LTkjr0w7+3TxelwdQS9Tl4y99JHmdwx1OO8Pd
	l78gKULn9jZyhtSqq3qkYXBRORePbJX8WMlVQwwhdN/hgfB+JBjhK/KRcOJDk3x3YWPxJuN48eQ
	u/h07ErP+/KtTKgJjj1Z+fHFKu7fNJn1xXqTLSZS9wLqDOuTGF6AeeQrc2dbfKcIhPdH55rB+b9
	eLU2w5QAYUIn2yJ7dlipGgYP7BxPXP
X-Received: by 2002:a5d:588b:0:b0:439:9106:3bb3 with SMTP id ffacd0b85a97d-43997f469ccmr2397212f8f.59.1772092929269;
        Thu, 26 Feb 2026 00:02:09 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c09897sm40536977f8f.17.2026.02.26.00.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 00:02:08 -0800 (PST)
Date: Thu, 26 Feb 2026 11:02:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2] net: core: failover: fix NULL pointer dereference
 in failover_slave_register()
Message-ID: <aZ_9_twriI6Z1oh7@stanley.mountain>
References: <20260226075737.8948-1-zeeshanahmad022019@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226075737.8948-1-zeeshanahmad022019@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261222-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:dkim,stanley.mountain:mid]
X-Rspamd-Queue-Id: 5E8E31A23D1
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 12:57:37PM +0500, Zeeshan Ahmad wrote:
> Smatch warns that 'fops' is dereferenced at line 69 without a NULL check.
> While other callbacks in this function properly check 'fops', the
> rx_handler registration does not.
> 
> If failover_get_bymac() returns a valid failover_dev but a NULL fops,
> the kernel will encounter a NULL pointer dereference when registering
> the rx_handler.
> 
> Following the pattern of other failover callers, add a WARN_ON_ONCE()
> to catch this misconfiguration. Abort the registration if fops is
> missing to prevent an inconsistent state where a slave is logically
> linked to a master but lacks a functional data path hook.
> 
> Fixes: 30c8bd5aa8b2 ("net: Introduce generic failover module")
> Signed-off-by: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
> ---
> v2:
>  - Target 'net' tree as this is a bug fix.
>  - Change logic from an early return (v1) to WARN_ON_ONCE() and abort
>    registration to prevent inconsistent state, as discussed with
>    Simon Horman.
>  - Update commit message with detailed impact analysis.
> 
>  net/core/failover.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/failover.c b/net/core/failover.c
> index 2a140b3ea669..1702bb1feca1 100644
> --- a/net/core/failover.c
> +++ b/net/core/failover.c
> @@ -63,6 +63,9 @@ static int failover_slave_register(struct net_device *slave_dev)
>  	    fops->slave_pre_register(slave_dev, failover_dev))
           ^^^^^^^^^^^^^^^^^^^^^^^^^
>  		goto done;
>  
> +	if (WARN_ON_ONCE(!fops))
> +		goto done;


Move the NULL check in front of the fops->slave_pre_register() stuff and
delete the other later NULL checks.

regards,
dan carpenter


