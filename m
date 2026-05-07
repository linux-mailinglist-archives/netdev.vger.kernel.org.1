Return-Path: <netdev+bounces-285423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id A+/iMN+6/Gm6TAAAu9opvQ
	(envelope-from <netdev+bounces-285423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:16:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFE64EC0B1
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A66030E150F
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAE845BD71;
	Thu,  7 May 2026 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUM7c/a1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B012CD8B
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778170038; cv=none; b=MXeGVYQV7H3akPQVlR8qfETNo05/NOT4xUMauJvYw4tdUgGR9DrMXfNtpswECTj8LL9D68UgW98djosTAHZ+ZVOC+wcRvi2N0+Lh6tW8sEwwcZ+oGFawc19Fpkra8mWTF70BKD0yFZ2TEWHnB5PGPq2Wy5XXrhKIjBW9m1K+Mdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778170038; c=relaxed/simple;
	bh=eeWF4DW8Vtc+uCRa4YdosWQ2ENZOTVVpLyovPsGpCwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMAyjTgtvZ2CnJQALQf9bihX5n7CsjJz2b6a4JDS7l+jtk2iIIDoOWLWsYeiyhZfLrJZsEQS7lgpBeXljr9ylYAuMPUFQlE0GzV4KLWnHbxl2ubz0rWk1kzAUhpSTPGizMkhe53j3I+v9YoFlimgcgRCUuNtOHxONVxtyENmN3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUM7c/a1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e5ad864a6so9211571cf.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 09:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778170036; x=1778774836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H/8IlocfHpqcK267BzWvtEjiH9A/YesBMhn3EFEYzaY=;
        b=mUM7c/a1Nxte8IoelOKj25eaUu6Fw5vLLHevT+uF+FBmhaktsQcFhVn0mnYOlmfsco
         8IQ91ONCXzdyqv0S9xFOmsGU0c+vbe+90WZRo1+npIQ8xxf/ffiFOlKF36W/qtI8Sw5l
         VTFMzAdKb41ol5HJzNn2M6FobK452W6wo1IVZLrTLnbgLUHjABNSwTZHyBQy5lZBrxfc
         G2VYJ6nlxQ45NLi7dk0eS+zcz4GUYWnSKA8Gjn89dEjhhD3+i7rgsOiNfVVB5TDb17Yb
         z6RlRHfeKrgZIIhYywRTUQ29Y6gmIdW9OJKxxrs7mTX3rsmMSfA1fW56Dqgq/Tfqgq6D
         XTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778170036; x=1778774836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/8IlocfHpqcK267BzWvtEjiH9A/YesBMhn3EFEYzaY=;
        b=OcRAwk9J759MUWlBUyV5TM24apMCpVCUbF6NV94CIyZ4XAajUEi/WZbM5LpvTR/uPg
         l1q7AKYrxToQTAlSNExpjb/VPPbEAIApCUAXEgo81nJn2KL7N5H/vSc/FEFeGEw4Oszy
         BWYluYREswYphUU5VcXkQ1fkPa/B7cZPO4Qg9EO3DSF8nE8MVqdottyZ3i31t4jBrTMf
         umDkIPclE491E712B40MWMQpGCuKD656pPCAGfWNpV35wVcHJRu+WPZ1sPyTGwx3VtSC
         wMY/MxhkQ5+E5FMFtxlluqclNt9ccFeaLv0WbPT4R+NQpGG01Bo16LoVMJvMw1Hw36rd
         wIAw==
X-Forwarded-Encrypted: i=1; AFNElJ97sFfE8psebk2utGQIGl9tigUHC0TTTs05D26NomwHd5OtGXSJCeLBCoKPdmIwB4BWk4MPehc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf3XhIm5/Apg+2luhoG3bjzU5TWUqvlqC8r/Q4p3IBjSeUlyRK
	yVXT3AF+m6/uqWyFhQUWsOI0nNT7FYMAnGJOPJ37WtivOCstT43dQHRq
X-Gm-Gg: AeBDievZGsV45WdXP/912qslk/LDEnNqA9F4I1kQAQRqEbxuahZ0YjVq0Xi85FdzQeg
	p8p6/EIt+vntspVYMyHJNZv1R7mIki2Fgh/Wv8+ga9l4yNspXdcxUclVyuVxfKF4ZuDxBEMPxQb
	ZQ4l625vuvha8b2iVovK4wdqg9f3lDoo44r+cDhzJ88oXH6HDL4ETv5yEVIBCvE89yfDedMMS/7
	pKSQKInrUhO6HNlIQ42AXCMnLOOTnB9VL6L1tshHAUrurj5JunYuuOxnyKarh34P2UtmMttAz8x
	Uaw6gm7CMF4pwW6RwZIutAV8RBBrJHAeyQJ1dZQeZ+fnUFC2RmUSyuKU7f42kwE6JMG9vPpyWJl
	BSNX5KtHo3eZfDJpJg0+BYdzpn9/WWzMtnAQEzEC9yyq7DnIo9SkBzI2ZmHtfggKn4dp3ALZNUN
	3QMnphY/aaUw9O12EwGfw0XxU0xtqBV+vLmBbM7HLuJ1ljSEM=
X-Received: by 2002:ac8:5c88:0:b0:50f:c1d4:d9e1 with SMTP id d75a77b69052e-51461f9e37dmr119360191cf.38.1778170035651;
        Thu, 07 May 2026 09:07:15 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:2f::])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-514851141ebsm665421cf.13.2026.05.07.09.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 09:07:15 -0700 (PDT)
Date: Thu, 7 May 2026 09:07:11 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net v2] eth: fbnic: fix double-free of PCS on phylink
 creation failure
Message-ID: <afy4r3U5ApmZ6HsS@devvm29614.prn0.facebook.com>
References: <20260504-fbnic-pcs-fix-v2-1-de45192821d9@meta.com>
 <6cec0c03-5bdc-4131-9899-bc5c77fba198@redhat.com>
 <20260507072453.5eec7051@kernel.org>
 <20260507072954.263ae8dd@kernel.org>
 <afyxOaFhFzEKDK//@devvm29614.prn0.facebook.com>
 <20260507090127.285a5087@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507090127.285a5087@kernel.org>
X-Rspamd-Queue-Id: 4AFE64EC0B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285423-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 09:01:27AM -0700, Jakub Kicinski wrote:
> On Thu, 7 May 2026 08:35:21 -0700 Bobby Eshleman wrote:
> > > > fbd is a devlink priv, not netdev priv, touching it after free_netdev()
> > > > is perfectly fine. I wish Gemini tried a *little* harder instead of
> > > > guessing :| Sorry for not commenting earlier.  
> > > 
> > > Ugh, not enough coffee. It's complaining about MDIO reads, I think
> > > that's valid.  
> > 
> > It is, but I think the race pre-exists.
> > 
> > static int
> > fbnic_mdio_read_pmd(struct fbnic_dev *fbd, int addr, int regnum)
> > [...]
> > 	if (fbd->netdev) {
> > 		fbn = netdev_priv(fbd->netdev);
> > 		if (fbn->aui < FBNIC_AUI_UNKNOWN)
> > 			aui = fbn->aui;
> > 	}
> > 
> > 
> > Definitely possible that ->netdev gets freed concurrently with
> > fbd->netdev evaluating to true... but fbnic_netdev_free() faces the same
> > race.
> > 
> > I'm open to fixing this all at once, if preferred. Probably need to look
> > at some of the other fbnic_net ptr guards too.
> 
> I agree with Paolo, seems separate.
> 
> FWIW I think the fix may be to move the single aui field that mdio
> cares about to fbd instead of fbn ? Feels like the problem is due
> to a layering violation, mdio should not be touching fbn fields.

SGTM. And I'll take a look at moving aui.

Thanks,
Bobby

