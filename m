Return-Path: <netdev+bounces-266571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFpWJAk8sWkLswIAu9opvQ
	(envelope-from <netdev+bounces-266571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:55:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26247261673
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD99F3063406
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565543C0632;
	Wed, 11 Mar 2026 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kazYniEe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C11A3B5852
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222609; cv=none; b=IrmWkfotc9BLrX2sNJM+QxllHQx61GXB00P9yVg+9rR3FuPoPCCZe4d9U3CU+Joko6vS40VtA5LtNQb4qt3Nenmk+TnhLXuHVP4b/pdM/WDx5WGqi0bqRxNU2in4CQ6k3Bg1w/GL8RCg4j2/Dli8wb2r+wcoryhn0W9XkPyayQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222609; c=relaxed/simple;
	bh=ug6TXwH1a1ofPVLGOkxM9KCJk4lPxLPWmnb/fpxigks=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvhtSoY7RdV6Sg1+IPLGeneblUYrMOxHIC7XMSfQHY0JQiNdrl35ymtm1Jjgcb2jcyoIzlqeJzTEb67Jy8W52WQmjpuDGt1q6CbfrjL1FfDNYdEosrQUB+hTihs8R50hyCDfxyX4wtb2ay7rImWL9TwRDT251f5G5Vbp9al4DO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kazYniEe; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c06cb8004e8so5509977a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 02:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773222607; x=1773827407; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yYuyLVV1LJ+/EStpKSGS4rGugblh4oCR+Y+FEuIu2wI=;
        b=kazYniEew/DZLmS/jmw02S3hlOZk515bBjKB5F/YjkDAz+BfbS6FBsKzpD14z9HMn+
         zMN/Nh+WWUuFntty4xBpA/+eA2jv8/u48irmhfciFHKLOF3q7SZEFCzn7i/lX8LHp+nH
         wXM6YaLvaVdrglZEvil7bmX2VzQqRbeppNhzfT3mKsiN5pAvvsIzuRnIPIq5mJ5QjjSd
         nOLpeB1MrmGLoD9uHvchw1NMJg0EXZX/mmBAz0CHuZpY86tV3YvefpnfXvRGc1BQjXZ9
         +8iY8GXKErHt4cCUTtOqK1x+9FKgz6xZ+cgdsYp92iBSdOGSRPBIkUlJTsDhfDtx4jid
         8z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773222607; x=1773827407;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yYuyLVV1LJ+/EStpKSGS4rGugblh4oCR+Y+FEuIu2wI=;
        b=QLJsCjkStwOHNIvbSQ7ooEbVjTgiVsTNxbEBSi9y7D1nSLyy3870kCw8O++5GyMITy
         P8hcJyyitw0wx6LCo14UQOUmuM0Ccqo/9wsrqa26umEUTAk6VBQjkFp3X4UNy2SOP77X
         piufcV3BhhpcJDGKBK1FDnwGW4strnDPJCcLp9thACbxlpJ0WAvhZMt3lsfMUOIkXaWt
         JboKPljo3WF6bAMn1C1jHigZ2Te2M4BiJMjbj+Z81NqYgDTcZsOv2hTQ0x/wcxRiBxP5
         +9VqRRsrNCkZdpyjAzQLM/INO983+9SCkr15s9wfOclRhVFWJL7gm3hp2RcpC688hxbc
         F+Iw==
X-Gm-Message-State: AOJu0Yx6AXBwwxcyPgf9d57PXxMLuhiiIGXeZ8C4TNk2meqtXZPPQlTz
	yyJC4wIpFCuFqCCzCiVylrdyP4YWz/ETCp2yJ7vhUkAmol5l4yLmV89h
X-Gm-Gg: ATEYQzxMcKUfewnvyW1s0r0aepytcRKPWdjOkb9j9n/8wr40c2D4EX3ZDGFL8JAG2DW
	hj9lD1kJrookcN2UEVVrXfy58ddUY76y7w6Ofwfc00wOKnQlbqUGPtCh6flgBrlDMYATBrtEd2t
	PEc/AVV7AZ9viyFiMb8OfFcKKZufBjfyvhJq1/glayuCk2XKBvqPrBoF7B/MM1Demf+3CNUTZEP
	BpWcpeWLSjvTlFndCNHwyAgVnaa9nZa5jutK6vnbQKD2mhECEsGjAt0iAWydhjYEBF+O37QIeQf
	Ji9CtOnXB2ZcAkC9wlhd0ZRcKec3nUvU87EflG0TOLvKmoN4PJdHI4H620dEGnKvMfOFzZs0XDw
	TLVjTx/8S+EsRePKF8Vq3qq3hq7hPsZAkaxALEhztqgutNPdXtgaCTLDBO99+cIrMpQGbJVKqP6
	Rkd09LzniTNsBvTw==
X-Received: by 2002:a05:6a20:748c:b0:398:8dbb:d1f with SMTP id adf61e73a8af0-398c61ab2b6mr1897131637.55.1773222607255;
        Wed, 11 Mar 2026 02:50:07 -0700 (PDT)
Received: from localhost ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdf92fe7sm1704241a12.21.2026.03.11.02.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:50:06 -0700 (PDT)
From: Carl Lee <qq1145099@gmail.com>
X-Google-Original-From: Carl Lee <carl.lee@amd.com>
Date: Wed, 11 Mar 2026 17:50:03 +0800
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, krzk@kernel.org,
	peter.shen@amd.com, colin.huang2@amd.com, carl.lee@amd.com
Subject: Re: [PATCH v2] nfc: nxp-nci: remove interrupt trigger type
Message-ID: <abE6yxLHNqvq2Imz@carl-amd>
References: <20260205-fc-nxp-nci-remove-interrupt-trigger-type-v2-1-79d2ed4a7e42@amd.com>
 <ca967f7e-d671-4be5-bcc2-30d75fa919aa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca967f7e-d671-4be5-bcc2-30d75fa919aa@gmail.com>
X-Rspamd-Queue-Id: 26247261673
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266571-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qq1145099@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 07:13:18PM +0100, Luca Stefani wrote:
> 
> On 05/02/2026 12:11, Carl Lee wrote:
> > For NXP NCI devices (e.g. PN7150), the interrupt is level-triggered and
> > active high, not edge-triggered.
> > 
> > Using IRQF_TRIGGER_RISING in the driver can cause interrupts to fail
> > to trigger correctly.
> > 
> > Remove IRQF_TRIGGER_RISING and rely on the IRQ trigger type configured
> > via Device Tree.
> > 
> > Signed-off-by: Carl Lee <carl.lee@amd.com>
> > ---
> > This v2 of the series includes Krzysztof Kozlowski in the review list
> > for NXP-NCI NFC.
> > 
> > This series removes IRQF_TRIGGER_RISING in nxp-nci driver,
> > relying on the IRQ trigger type specified via Device Tree.
> > ---
> > Changes in v2:
> > - Include Krzysztof Kozlowski in the review list for NXP-NCI NFC.
> > - Link to v1: https://lore.kernel.org/r/20260204-fc-nxp-nci-remove-interrupt-trigger-type-v1-1-3bde91593173@amd.com
> > ---
> >   drivers/nfc/nxp-nci/i2c.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
> > index 049662ffdf97..6a5ce8ff91f0 100644
> > --- a/drivers/nfc/nxp-nci/i2c.c
> > +++ b/drivers/nfc/nxp-nci/i2c.c
> > @@ -305,7 +305,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
> >   	r = request_threaded_irq(client->irq, NULL,
> >   				 nxp_nci_i2c_irq_thread_fn,
> > -				 IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > +				 IRQF_ONESHOT,
> 
> This is causing an IRQ storm on my ACPI device that eats away a core of my
> cpu...
> 
> I'm not sure how this should be fixed but by looking at other drivers they
> all use irq_get_trigger_type() and then apply extra bits on top.
> 
> If there's no clear path that handles both ACPI+DT I'll upload a revert.
> 

Thanks for the report.

I’ve sent a follow-up patch series that restores a fallback to the
historically used rising-edge trigger when the firmware does not provide
a trigger type. This should prevent the IRQ storm on ACPI platforms
while keeping proper behavior on DT-based systems.

Patch series link: https://lore.kernel.org/all/20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v1-1-9e20714411d7@amd.com/

> >   				 NXP_NCI_I2C_DRIVER_NAME, phy);
> >   	if (r < 0)
> >   		nfc_err(&client->dev, "Unable to register IRQ handler\n");
> > 
> > ---
> > base-commit: 4c87cdd0328495759f6e9f9f4e1e53ef8032a76f
> > change-id: 20260204-fc-nxp-nci-remove-interrupt-trigger-type-d778323b3b81
> > 
> > Best regards,

