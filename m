Return-Path: <netdev+bounces-264269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAEqGJFWqWkh5wAAu9opvQ
	(envelope-from <netdev+bounces-264269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:10:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A91EF20F72A
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 11:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBD9430160EC
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A9C347FC3;
	Thu,  5 Mar 2026 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/UE0MDN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5353793DF
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705239; cv=none; b=OMJh/BR/aKGW82Sdn8bTE9Q6zCSL+tzYVrVvRNDvqehWXPw177WIj3omG6Ejb5jXZ5KO7+Ydk/tSe9pxVZ/11SnDf1BaT90UTfzLqvK0oXVSL/WVZSU4rKYn6DnUIX1MbCwasLmLKcxjtjXMedVYydK5I9eDF4k9vKo/Oc2XQUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705239; c=relaxed/simple;
	bh=+Q+M7cI0qi9DjEW5m7TcEzhYI9x1o4qiiLEOx9eYqkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wcq5gaBtBt39RXZXghnLmwJ2YFJugo2adqRhRv/H1RybUkMcVBxwiOrp92XEGfrEJfFZ2/UcCZlY7NEd5aGJynqatAuLEhMBDZjtsPfc4dZT9vOIU88oDb2wDH2TuH+GcVE+z4vC3SRsAisnVG7XFXrO9mP6wXc16loFpcSO4Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/UE0MDN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806fd9033bso13185985e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 02:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772705236; x=1773310036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1CwWPm9DJ3IJQOBV2n4yNHXxnfi05DFDUDyq3i3oj9Y=;
        b=N/UE0MDN62QxEYMOxy3P4rNId2Xyq97VbbxbtWHxrm/GW+PQETMDxmvq/1eJsPEclv
         Yon+3QXPEP07A/E65PWen2Csgws/N+PClDCz2zW5fzeb/Q9FEdIu1wQMFKzHucDV5ZjT
         bfx428oIcMPysB2BjUIB9MYE+BCaNLLlw0uNwdhbdLyW5wVHk3ML7LVG79EccClkory1
         nvtQpRA+4oqdV4+ZQAc5RrSVL66OUmIc7OpKtLBqC1HCaR59LovXr0dkH3HXTx09dJ6W
         EMx0lkMxLncOeVHXhGPlvMqr3xpGpBTk/ByBJq/F2totj1gZGjCWV4zA7ZyQD2r2rYiQ
         ne+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772705236; x=1773310036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CwWPm9DJ3IJQOBV2n4yNHXxnfi05DFDUDyq3i3oj9Y=;
        b=TI7+v928VbMmxfU0ec7j/TCGy2MuGDVUR7Eohfx0k1dH595XSoJ2YzH0+95aNNQbZk
         hSBFImzBVZqT4AW2GJZAQdZw9d6vqwgTtZEkXseiFzSgVAVeverdL/OTalEy3wBUscRv
         zOaphhVNj/Y805W4B+mPuJBzhSIDiNq5d3PLAu/fdqZ1SphOoQ8hbfGYk+4uCCjojDIy
         yRdtafc6/bJXZZpayDZB8j3TjsK1AWGwI7EDIEhrJ8jqXkQRUpCffThyBsSpgKhXABQY
         Ew3FpbsDJp0/lJsT64or0yWDxuiWn0coK5lvrcAYYI0ngWkfQJxK6dnfxnovU/W4a1OR
         pWvw==
X-Forwarded-Encrypted: i=1; AJvYcCVVS0wmLPomwqAljqRI31J7/4CRToTG6PFyngmSFpjv487PllkNNW/LTzUCN+BMoeuNfpeXGFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxsaLkS1PFkSXAgcS87LOgWKZ9nAecnHtqHqAR99vhAWZbCtY2
	2oJBhheKXiXKoLNPuIRWtT2Fj1ce7LtylXKbwPJ1LC/NlI+F6wuXHwnH
X-Gm-Gg: ATEYQzzmqCW0pd6n7KrvZwdNiTCDPY/ZkywrjYgkitphz/MfrOXbv9ETYCIe2X4rBaA
	f/sILBApsggFyEXQgkL0YteQ0ap26iSrBT/8TE3YnEwAws4bA0RLfrPugbLvGgJKrKv1ChqDSxm
	yjaxy9aM5dNEzSqk/vCJVeMevMPhYtzxpZY0YB8xcfDifXM+VFidYSS0X6WlnGEC0ncqQA5Ge6w
	xc6mOjsQS6Wi5GJMnJN03JgfBUEw/wBwICEjtkO30keIJzSWMplzut6AIUhTIb1JHa5Urojv45z
	Gy3Ay4Hx9kjDYzDoknrUjT8dCmQg0d/T8LYj343UKK8cfvhv7fmUC+jX++zwYypNhe6g7r2W4oG
	PJVx94iKaT0zDDEEx4BzdZKpacu2mcCaJZn+iiVoVEwBFl+wckMY456wYXpH4x/qZ3djh9lkURt
	ZoAMopxH6+yhexZCw=
X-Received: by 2002:a05:600c:3489:b0:483:7631:befd with SMTP id 5b1f17b1804b1-48519896e6dmr53898955e9.7.1772705235377;
        Thu, 05 Mar 2026 02:07:15 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00e:3600:16aa:c9ad:4288:9dcc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b4175fd2sm34211242f8f.14.2026.03.05.02.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 02:07:14 -0800 (PST)
Date: Thu, 5 Mar 2026 12:07:11 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 2/9] net: dsa: microchip: Decorrelate IRQ
 domain from port
Message-ID: <20260305100711.byyyubdk7vycq6uh@skbuf>
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-2-3f4c47954c71@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-ksz8463-ptp-v6-2-3f4c47954c71@bootlin.com>
X-Rspamd-Queue-Id: A91EF20F72A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264269-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 11:18:53AM +0100, Bastien Curutchet (Schneider Electric) wrote:
> KSZ8463 has one register holding interrupt bits from both port 1 and 2.
> So it has to use one IRQ domain for both of its ports. This conflicts
> with the current initialization procedure that ties one IRQ domain to
> each port.
> 
> Decorrelate IRQ domain from port so a port can use an IRQ domain not
> directly related to itself.
> 
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
> ---
>  drivers/net/dsa/microchip/ksz_ptp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
> index 4a2cc57a628f97bd51fcb11057bc4effda9205dd..64afe92a3479ec87b5afc66e489b92787a0fc715 100644
> --- a/drivers/net/dsa/microchip/ksz_ptp.c
> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
> @@ -1099,18 +1099,18 @@ static void ksz_ptp_msg_irq_free(struct ksz_port *port, u8 n)
>  	irq_dispose_mapping(ptpmsg_irq->num);
>  }
>  
> -static int ksz_ptp_msg_irq_setup(struct ksz_port *port, u8 n)
> +static int ksz_ptp_msg_irq_setup(struct irq_domain *domain,
> +				 struct ksz_port *port, u8 n)
>  {
>  	u16 ts_reg[] = {REG_PTP_PORT_PDRESP_TS, REG_PTP_PORT_XDELAY_TS,
>  			REG_PTP_PORT_SYNC_TS};
>  	static const char * const name[] = {"pdresp-msg", "xdreq-msg",
>  					    "sync-msg"};
>  	const struct ksz_dev_ops *ops = port->ksz_dev->dev_ops;
> -	struct ksz_irq *ptpirq = &port->ptpirq;
>  	struct ksz_ptp_irq *ptpmsg_irq;
>  
>  	ptpmsg_irq = &port->ptpmsg_irq[n];
> -	ptpmsg_irq->num = irq_create_mapping(ptpirq->domain, n);
> +	ptpmsg_irq->num = irq_create_mapping(domain, n);

Looking at this function, I think there's a pre-existing bug.
If request_threaded_irq() later fails, irq_dispose_mapping() needs to be
called, because ksz_ptp_msg_irq_free() only frees the IRQ domains that
were already successfully set up.

>  	if (!ptpmsg_irq->num)
>  		return -EINVAL;
>  
> @@ -1162,7 +1162,7 @@ int ksz_ptp_irq_setup(struct dsa_switch *ds, u8 p)
>  		goto out;
>  
>  	for (irq = 0; irq < ptpirq->nirqs; irq++) {
> -		ret = ksz_ptp_msg_irq_setup(port, irq);
> +		ret = ksz_ptp_msg_irq_setup(ptpirq->domain, port, irq);
>  		if (ret)
>  			goto out_ptp_msg;
>  	}
> 
> -- 
> 2.53.0
> 

