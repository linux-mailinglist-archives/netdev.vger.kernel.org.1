Return-Path: <netdev+bounces-285014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKdiIxeY+2ladAMAu9opvQ
	(envelope-from <netdev+bounces-285014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:35:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3C84DFDB3
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C774330233CC
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 19:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6891833AD82;
	Wed,  6 May 2026 19:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLiUfVj2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823129898B
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778096087; cv=none; b=eDG7wlmSjRfBBAbP50PgX09DS5yWTsrELzqS3S91bZk3T82ahOgdeJGErvxBJ9AxTBTnK6Qb+xySg+kM7TSNSIoRV2s7yKOpJ9IOJX40PFbAOU42Te72D5ezC2ltlqdxEUCHV9dpIt31RGrCCWBdUl2+WW3iYy8a5qPjp1P+4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778096087; c=relaxed/simple;
	bh=5yOmDRJWkQ4VG/V7rOIXT5728PKpPtwtAqWp9eTLsJE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=odNuXoc6BavVOnS0iiPTydkBxS7DlMYDUBfyMAOK+U04G6+TDAhGOyVB9IoNjKQHthR+9tddtwaOL6br34J5XXGQDe+ruRw9oWRZwS0j6xa1CQF2eT32Krg772QmKF4SKRmvKLNTPj62vE3CafCYP5P05oaxC9jpLQ96X4hfbyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLiUfVj2; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-651d6347a69so1277036d50.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 12:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778096083; x=1778700883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp0M4sn108wJFjNlGoJSEJcEfpd1a9QgqV/Z0Ft6epA=;
        b=OLiUfVj2gpbxeehgSZ/7s3vaNX+AsX/VZbFrpqnLq9CM1LoQCjV1Q5ZNM3Xizgegfx
         PFjAR1JQe2l/jsBijut2EluhKLEf9CRWlMqr+JKLb2LDW2dfO6QRGpn6ojzvDbEnzwnk
         MlcZE+9x8DQSMDP8Ft5ZCF05bICgEnU54DF6Yk3l7wg9d/CP6eaoxyD7sja/xxJack3+
         dmH6oL03WDJRbfsUOxP2Bw0qclhKeMAdUBZX9LoZad8JS4DOtPNeP5cI2/R2vaJkbDIb
         7bieX/WHFwiU/fnFOIrN/Y8jEUZ1ul3MP+Ll2E1483X1/zZLz1vM69IVgtmDtYQOKY0B
         yJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778096083; x=1778700883;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sp0M4sn108wJFjNlGoJSEJcEfpd1a9QgqV/Z0Ft6epA=;
        b=hnSbeUPZ6p47rkB3AEPSuVB3nDPUib6kC5rmn3LvppZ+86/WbGCWoOaahJmFZH5wSV
         9ldOqXGIKxlsrQQEofRKluU7G45BKQd7eHZaZ5MFNxEViuI1YX3pSXZKZ49B3z2kBhdI
         PjsUiGwPgF+wkd67H6R6pvBGClUzQgIH3/LC1WeKp/FBEfuyXRUi7Aze7+HfLiQ8idFQ
         P5xOnbwzBhXFDDysK+ncXLwH2FQTwX8iXlZNq4SJHvjBZ/Mzs73AF59dtFgWo9qdJKAX
         WPzTWY4fnXT7huHZjmtitDcHi9MEbI9FFJ2pwOfvwW0b9w8sUsITntop1ZN0RCObzgCz
         AlyA==
X-Gm-Message-State: AOJu0YzvtKfE7WTGIlOUBWE6Iu3oDFEd8sCO/TD6ktOO4aqcrTYkCHe+
	L5arOZJQsT1ZwWS2jH5iVbsU4/1jJhC8iCZmywZWDToawg5Aqn63HQ4b
X-Gm-Gg: AeBDievw12/WiED8rsyogP7fUaH7QEszWtZYsoPtNJunylvcuprI4b9vmQ7uvZpYPl0
	r1uThUebw9sZP1oJ+Z5nHky5KCZXmvzu08VL44uCr6JpsWvIGv77KbS7CR3Oq4OCixXIz3zt5Qn
	clWBs15j18NH7WKGt/l5oWuXWyWZBRjXNn5AWI7Wox27Gy0/iBv6Rt9vmLKCFAcdms6qZXWX+6K
	OWUbLZ2EXXM/7SJVCw3qq7OgM03prCHM4xz5AkF6JJ/0yGG+q2bzRmsaKQppQuTZAQqUlI5k4pQ
	DBYJehTK5JfXPKY0lKScq0CV00ZRRHayCK+BPcH6/ChJAKcKiOaXRtzuZS4mdEs78y4EywkSjTP
	0SCQ209Eai1mnJWv+mZSKeiEeAIyNkvObxfB/ohpFVHWQVctajfsP3OybmD9yXEKsmJLTGDaTol
	FAjif343W0TVvhywR29aKwZrDbHshsoLTitxAhrJ87UDEA5QUXmSsEW/cn6Cp/8MVMUOhhrOXH2
	RWPtYEUZ9dJalw=
X-Received: by 2002:a05:690c:388:b0:7b2:cfae:8a0a with SMTP id 00721157ae682-7bdf6022205mr39159647b3.0.1778096083160;
        Wed, 06 May 2026 12:34:43 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66888cc7sm82283737b3.44.2026.05.06.12.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:34:42 -0700 (PDT)
Date: Wed, 06 May 2026 15:34:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.173236793ca@gmail.com>
In-Reply-To: <20260505-psd-rcu-v1-3-a8f69ec1ab96@gmail.com>
References: <20260505-psd-rcu-v1-0-a8f69ec1ab96@gmail.com>
 <20260505-psd-rcu-v1-3-a8f69ec1ab96@gmail.com>
Subject: Re: [PATCH net 3/3] netdevsim: psp: rcu protect psp_dev reference
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2C3C84DFDB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285014-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Daniel Zahka wrote:
> There are two issues with the way psp_dev is used in nsim_do_psp():
> 
> 1. There is no check for IS_ERR() on the peers psp_dev, before
>    dereferencing.
> 2. The refcount on this psp_dev can be dropped by
>    nsim_psp_rereg_write()
> 
> To fix this, we can make netdevsim's reference to its psp_dev an rcu
> reference, and then nsim_do_psp() can read the fields it needs from an
> rcu critical section.
> 
> Fixes: f857478d6206 ("netdevsim: a basic test PSP implementation")
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

>  static ssize_t
> @@ -228,16 +237,23 @@ nsim_psp_rereg_write(struct file *file, const char __user *data, size_t count,
>  		     loff_t *ppos)
>  {
>  	struct netdevsim *ns = file->private_data;
> -	int err;
> +	struct psp_dev *psd;
> +	ssize_t ret;
>  
>  	mutex_lock(&ns->psp.rereg_lock);
> -	__nsim_psp_uninit(ns);
> +	__nsim_psp_uninit(ns, false);
> +
> +	psd = psp_dev_create(ns->netdev, &nsim_psp_ops, &nsim_psp_caps, ns);
> +	if (IS_ERR(psd)) {
> +		ret = PTR_ERR(psd);
> +		goto out;
> +	}

Do you want to create the new device first and only delete the old
state if that succeeds? To avoid a netdevsim in state without dev.

>  
> -	ns->psp.dev = psp_dev_create(ns->netdev, &nsim_psp_ops,
> -				     &nsim_psp_caps, ns);
> -	err = PTR_ERR_OR_ZERO(ns->psp.dev);
> +	rcu_assign_pointer(ns->psp.dev, psd);
> +	ret = count;
> +out:
>  	mutex_unlock(&ns->psp.rereg_lock);
> -	return err ?: count;
> +	return ret;
>  }
>  


