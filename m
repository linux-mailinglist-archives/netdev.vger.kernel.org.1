Return-Path: <netdev+bounces-273108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN78LjJMymmb7QUAu9opvQ
	(envelope-from <netdev+bounces-273108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:10:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A98A358EDF
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 12:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 081BE306799D
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8373ACA66;
	Mon, 30 Mar 2026 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2LT8uQR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631A53939D2
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774865069; cv=none; b=rlP5HQm0vIezyMOpXklPR9uB+hBcUD0oPO04WVzz7zwkdeLA/BgZ4Bkht0uLBz/+pjdDqXZVeQjyD2UrFE4M24afpIuFdCLdD9LihjDaEFimF4FqZIQeGGTOtA85PNEz2vsa3IUOTEdLXB1Pdt1gSbbvTlpq5smAfy6XJwGWcRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774865069; c=relaxed/simple;
	bh=jHAnZJXX5bu3wipcgVK2DdxSb/SVt4ovTeDSJgrvrPo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c1ZnetMfirEQzWJkxX81ICNAmLSWUfd64rUTIUa8lTWVECwWx3TEVbGeTlPM7YXlFmctD69Hq7GzWypJh/VSj0w6PqE+AiunbCYuK9QJUL7scEwCz874IIhJtwk7WYkCP2vWEcmS3mlBI9JPvmCw30qu18TNmXFF+Hm41AdquIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2LT8uQR; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso739341a91.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 03:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774865068; x=1775469868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tF1ddv+zYFLMJMK4KGFrCt7VNKHNz0KsOPJkJNUEJKw=;
        b=S2LT8uQR0OOB5DmDmbxnHYy7HF7uOpU5tzBDtlkqT1DrPew+K9E/pJXVih3sr8PQTu
         3XbDEbFfZOIJwUChmjEQ27s1oIzJrVlu4yebl5IUqB6XZRWxUaOArE1kQAyxvq1fqoeh
         CfgfcsXNaHpZ0LZ2E5NYniRv04dKyg4jOU3P4eP6+e+PVGVYqEZfM996IBk7/RlaUlkz
         sv2SYGf9WY3hpIxTjVXwNL3L8o700RVPKQ+s89XmjaQj6O8LrQKGBXPZD/z4hk7hod/Y
         zA+PSx1C9l2UiyfRJn77iT68N+rwJTfZBQgkYYgsrfvXCCfDTo+N8xjvsVNaftMA7o/f
         XlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774865068; x=1775469868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tF1ddv+zYFLMJMK4KGFrCt7VNKHNz0KsOPJkJNUEJKw=;
        b=fz7DtPvSDDvZgMXreKuYoWHI1SBUrHWVriwLyz8FLDOh+7qs/jH3fOf7B8w2UYChuU
         zWG9xA0MLd1JLxKZz9SY04keueKb+WoZuosdbVKHhmwXFmIM2fkwm9JXl6rjk6vjmz/Y
         ZkW9lBekXtZQRe+aIbD2hq1pagDT92nVPGCXKQiU1yDTD8u8Ub8+FVYj58EkNiriVxZk
         vdpSVEuHkrZu6iRwEGutFhqsfJic1MKAGbw6Ku7FBZaqdBKU/+1SCDjU1BvCRZoaNl37
         G13SpgN24lIajH3PyBk9ARpEQ2iiCHpHxX7bWw44vgrp/JS54+HHIxDSyUcqefIdoNOs
         DmjA==
X-Forwarded-Encrypted: i=1; AJvYcCUP3RDJkhLCUhLy58zyD92uPKwo2ow90LDvCIgTCqTqxY3jXvJEiturTUOcgLWnGGi0T3riFHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU1OhMfB6dm7WMEyeERwcXxAxWp3osxL9WZ44IvevBrc/u4cdd
	NYnoLJjhKnQprz5n/lebSFkzeHGbT1J/iv6gfqPdNkgzoLYIlcQh39B9OGhpnSW0
X-Gm-Gg: ATEYQzzPodaC16qC3EeXggbHN1pDmrevOIprB8VwrrVe+8hIhgKaDROuhIMQcQQO8mY
	RZW8ZlP/qrQTi4xYwf0XP6duwb10HNHEJppGRw6lhjP6QOKnZtIypM9urn/Pz4JjN2LrOimCRGL
	hw3327MCIc0KNnN4GGGjCeol2t9OWrlG3jjEqKHy6bs5/CiGOnxs1BcObFf0zKWFW+RgHzI9jIh
	uZpy9HP8jfw7jqooTBz5Zh7UEkdoKSZaGx7Z1tIziDuUw0m6xBlwucp14hJ/V6pnsbgptI1J0Ja
	giWCT37Ie1d7+G+97UeSNyCYlGziqII49qN1+cpAWz+lYwKXWrY+a9/S5DDdoPu8QUXNou5RmR4
	yxttHhVHGIhnqVyz4LqIkvZsgOcfvkHafNT4GNAZcmCxiEXUPBaRNKwLbzOEFb2ocI9/5HRzpqG
	/hqB/BxdcPGo3zTg==
X-Received: by 2002:a17:90b:288d:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-35c30a80a02mr11140026a91.0.1774865067647;
        Mon, 30 Mar 2026 03:04:27 -0700 (PDT)
Received: from localhost ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d9c4e4278sm2453545a91.0.2026.03.30.03.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:04:27 -0700 (PDT)
From: Carl Lee <qq1145099@gmail.com>
X-Google-Original-From: Carl Lee <carl.lee@amd.com>
Date: Mon, 30 Mar 2026 18:04:24 +0800
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, krzk@kernel.org, netdev@vger.kernel.org,
	carl.lee@amd.com, peter.shen@amd.com, colin.huang2@amd.com
Subject: Re: [PATCH v2] nfc: nxp-nci: i2c: restore IRQ trigger fallback
Message-ID: <acpKqD76FUWSH1UE@carl-amd>
References: <20260312-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v2-1-362348f7fa30@amd.com>
 <20260316192609.3e001253@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316192609.3e001253@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273108-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qq1145099@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 3A98A358EDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 07:26:09PM -0700, Jakub Kicinski wrote:
> On Thu, 12 Mar 2026 10:51:35 +0800 Carl Lee via B4 Relay wrote:
> > From: Carl Lee <carl.lee@amd.com>
> > 
> > The driver previously relied on IRQF_TRIGGER_RISING when requesting
> > the interrupt. This was removed to rely on the trigger type provided
> > by firmware.
> > 
> > However, some platforms do not propagate the interrupt trigger type
> > to the IRQ descriptor, resulting in interrupts not being triggered.
> > 
> > Use the trigger type provided by firmware when available and fall
> > back to the historically used rising-edge trigger otherwise.
> 
> Sounds like a regression, if you can please mention which platform you
> hit the issue on, and please repost with a Fixes tag, presumably:
> 
> Fixes: 57be33f85e36 ("nfc: nxp-nci: remove interrupt trigger type")
> 
> 
> > diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
> > index 6a5ce8ff91f0..7aaab92c616c 100644
> > --- a/drivers/nfc/nxp-nci/i2c.c
> > +++ b/drivers/nfc/nxp-nci/i2c.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/i2c.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/irq.h>
> >  #include <linux/module.h>
> >  #include <linux/nfc.h>
> >  #include <linux/gpio/consumer.h>
> > @@ -268,6 +269,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
> >  	struct device *dev = &client->dev;
> >  	struct nxp_nci_i2c_phy *phy;
> >  	int r;
> > +	unsigned long irqflags;
> 
> nit: when you repost please order the variable lines longest to shortest
> 
>  	struct device *dev = &client->dev;
>  	struct nxp_nci_i2c_phy *phy;
> +	unsigned long irqflags;
>  	int r;
> -- 
> pw-bot: cr
> 

Hi Jakub,

Thanks for the feedback and for the detailed investigation.

After further analysis, this issue is not related to the proposed change and does not appear to be reproducible on our side.

I will drop this patch for now.

Thanks!

