Return-Path: <netdev+bounces-299639-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hK31GxF/MGpNTwUAu9opvQ
	(envelope-from <netdev+bounces-299639-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:39:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D09B668A6A8
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:39:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=dama-to.20251104.gappssmtp.com header.s=20251104 header.b=bzrKEgw4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299639-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299639-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 197D4302BCDF
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15703290AA;
	Mon, 15 Jun 2026 22:34:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE9136AB44
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 22:34:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781562888; cv=none; b=jiXFFrMbaVJm9c0TNcxrnrBs3gjujJp87MLFzL/8y4U6M6GfHzK0UzwNkpX8luYCWKQkC3tjkWrdSL9hdKXvL57eq7dNpA3MwGTVhnQzZ6hmkea5qyTJZebInm2Zuzj+pzLWMT3cylisNJ+2Dx171PBInt4CHQNJdAcS3hutq60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781562888; c=relaxed/simple;
	bh=Uu2ZPwhh5vaVogX8ivqDgkVCAIMI3ZIQzWUWRs83Y+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mvrx8KJaOh3tiYVZh45cCFEvWDu838yeS0lFVRsXo5p3DNkDDtLdlyxzUp/R2NQSc4cFMWBM7U1lW5epxnSx3HmDppb39zwm5SmZTuEnpnza55F6b6sBslw++dPi8a+jprDWae9zjX9w+XSS9QhRWcrIjJGLPH5DS47ZWuChibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=bzrKEgw4; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so2761669a91.3
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1781562887; x=1782167687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BxQrn967BchhiPMVf9s3SPbfGb2SRsf64DIOXc/lgs=;
        b=bzrKEgw4QH8a/q0js2IwPN/EH7sigXS/lV9JJU0UF76mrhU4GfpEe9CyMg3lyyHZJc
         9D/kk5Q492XH+0JfbOBiyMgQ316BqPqLzl+H/FLLTwJCtU4xYBdyi1nq6+7pSl0UfzUb
         HWe/l2ilz50/jpdA1zT1A89/YjVwpfkyszPnvwOkcqk2FslH5QuaCil4BLyKq73jUAxU
         EjaNtYycVST4MQc++QMIR1zTwmHz/Y3y28bgkyH3bdVvf9WLTI5UEosZYL79U63ajHV0
         /05T3mbyKL3srdvOl1KWp11hPG2Zdz7/Xe5FC8nXqrvxHkGmbBGAyh4yYDrif5Ctn9Dc
         qkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781562887; x=1782167687;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BxQrn967BchhiPMVf9s3SPbfGb2SRsf64DIOXc/lgs=;
        b=sqxZqhAOyn0v39gyhEqU48oFhmjqSA1ReIacsGAw3ZrpAMLB+IgZz0KeujD4hj5zAb
         SEihRMBgURbO03qMRSJ3bljDkvmCODeMOaSzX6TGQ5nSrXu/PBYH9mhphCcS9TJkb+/G
         4vCoN6xDmJS7CeEazxD6X7qpNq73rEP9wUZYDomjjVlpiXDJ5Ux8C27MT6EIs2Ol+Uz5
         cgQwvB+H1oEQX+dfF5mumsPXZNkJQaTPpvwj3/hr3L9pvTeHX/KmS6ZpHNcjsn2+xQYS
         ezHFkt9HXTTQk73qYie8FA/izVSstvIxBZjN1lub+aYumsTAvD8dj9e6MMlJfNQ/o/5v
         GQ1Q==
X-Gm-Message-State: AOJu0YwKIdLrnB+sNXCzZN3VXFq4EBVxS4qNhO6oLUCoPmO4VxhHuynB
	anIwi978xftoRgmvh1JUmQQlHwVVthDnDLzUXu6MhoqOx0BFUBCHzCKs7jkvMplQcm8=
X-Gm-Gg: Acq92OEy0ZBxJ04AFR5gp0S+MZf623IJ+lEMDcyEIVBTDmVhuPDJQsrWjJzDO/Nrj9b
	bOWFWfdnEHsd3UBl+sXU1jMImAhm23XlFEk71J5Y8tuqL+ZTA/UdPT6FkrTjIO+d8+cugdGnhTQ
	GmK8iovd1rCCRQlGnftCeq4Hx73Z+2kudw/KQNOwNkqSqAWjwWQUam8CdHHyBOiXLscpVfFfwZo
	Cj+3mKy0Y/qEZ6/vmyCpkWXF6CKNpbUBJ/y/PyUSeuksZyP07X5Oa1Uc/laoOirIAMvDxijiYjm
	wINKwvVp/49Y8CS84KOwmjVA+vs+odfz3RR1kru9Ftr6eka4LASATrXXIgnCM9ydj0TIxkqaY9d
	61lUN87tHssZLUWh0O8GeJ7ioHlOHyfIpNUmWYZBznjvCEvPK0vxcLwj5NyZxWBdYf+1949cFx4
	mdIDgi
X-Received: by 2002:a17:90a:a897:b0:36d:66d4:270d with SMTP id 98e67ed59e1d1-37c2bd08179mr9024782a91.20.1781562886775;
        Mon, 15 Jun 2026 15:34:46 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:53::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c522a019csm620311a91.14.2026.06.15.15.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:34:46 -0700 (PDT)
Date: Mon, 15 Jun 2026 15:34:45 -0700
From: Joe Damato <joe@dama.to>
To: Wayen Yan <win847@gmail.com>
Cc: netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2] net: airoha: Fix skb->priority underflow in
Message-ID: <ajB+BfOXHpRhCTnO@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Wayen Yan <win847@gmail.com>,
	netdev@vger.kernel.org, lorenzo@kernel.org, horms@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
References: <6a2ff493.5934d26d.389ef4.d16d@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a2ff493.5934d26d.389ef4.d16d@mx.google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:win847@gmail.com,m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[dama.to];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[joe@dama.to,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299639-lists,netdev=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,dama-to.20251104.gappssmtp.com:dkim,dama.to:from_mime,dama.to:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D09B668A6A8

On Mon, Jun 15, 2026 at 08:48:13PM +0800, Wayen Yan wrote:
> From b894fc031e307f1b6756ea9fcac98e82e23815e1 Mon Sep 17 00:00:00 2001
> From: "Wayen.Yan" <win847@gmail.com>
> Date: Sun, 14 Jun 2026 07:30:54 +0800
> Subject: [PATCH net v2] net: airoha: Fix skb->priority underflow in
>  airoha_dev_select_queue()
> 
> In airoha_dev_select_queue(), the expression:
> 
>   queue = (skb->priority - 1) % AIROHA_NUM_QOS_QUEUES;
> 
> implicitly converts to unsigned arithmetic: when skb->priority is 0
> (the default for unclassified traffic), (0u - 1u) wraps to UINT_MAX,
> and UINT_MAX % 8 = 7, routing default best-effort packets to the
> highest-priority QoS queue. This causes QoS inversion where the
> majority of traffic on a PON gateway starves actual high-priority
> flows (VoIP, gaming, etc.).
> 
> Fix by guarding the subtraction: when priority is 0, map to queue 0
> (lowest priority), otherwise apply the original (priority - 1) % 8
> mapping.
> 
> Fixes: 2b288b81560b ("net: airoha: Introduce ndo_select_queue callback")
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Wayen <win847@gmail.com>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hm, I tried to apply this patch to my tree just to see what would happen with
the duplicated SMTP headers and it looks like they just get added to the
commit message.

I think you might need to re-send it (but you'll have to wait 24 hours between
re-sends).

The code looks fine to me, though, so feel free to include my tag:

Reviewed-by: Joe Damato <joe@dama.to>

