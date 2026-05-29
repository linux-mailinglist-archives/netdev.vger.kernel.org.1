Return-Path: <netdev+bounces-293108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBi7NX2HGWqdxQgAu9opvQ
	(envelope-from <netdev+bounces-293108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:33:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6186024CE
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D741A30795AC
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44103CF69F;
	Fri, 29 May 2026 12:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9sgRqid"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4373438A8
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780057979; cv=none; b=NVy9HIOZ53NvxQRAIAqcdaTh+YOhtGzO19gUazLBqj88hOwu2oRrPB20A/NNkpvk3PCxVDi5xkVK+foE4mBiZnUmi7sXEEHb33p7Yneqvv8lIlCKxiG/X922Ojvmim1fgm4XdMH1TuGyAFWcsNO0dAz514y96SjhIh1MKXwqtPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780057979; c=relaxed/simple;
	bh=cclZf+Epg16CBzhDH3OyvyaSG0H4F39k5XvewEWnxO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5Y2JuWEv8nXuftG3D/0pCYEjjEv3QzW9uqmmoLRje02h60mpBy1BdG++r8kyZDCHE/u4a4Bj1Nrl4rHL9PmgpSxQpDqChe9jNmTHqBigtPO6PDwjISm8dTpflO7yiB4LIUkntH56+IPjVdIkbbsfYav95z8RPraCMKpdrw4mwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9sgRqid; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d77f6092eso7844188f8f.2
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 05:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780057977; x=1780662777; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EEKZEZxOVC/BS+13k9H03KzhdZwwm7vFIQh8bCvpl2k=;
        b=T9sgRqidue2n9AQhSc1PBHQFG8pD1jLotZ+GcE3ogjAS5nDsKl1J/MNja6/H/vbew8
         DW5Akr+/AGfVuNw0CwRQWY0YVswRcF0fjhdFPfPiu052o9KeXghtszJbFH8Y+6dYbo8m
         dWbDGHva7+MdDJhNOajykDbJbkv5YDbkJh1CfJhrtsmEXHVX1rdRZrH2Rbf9mRAOs5Ux
         z/MdqlZ6u57t0BkErh/seqTeCOXicL87FOOJzXmiSfZvvJLbu1Gxi+7d5ejPZ8pMtVIc
         lEhhNNPjV81Y/p9rwJS7703bHSfzn9Rq/bxQcEqVXkGy3wHMQ/VeLeDd3fqGlANGtXTX
         rUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780057977; x=1780662777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EEKZEZxOVC/BS+13k9H03KzhdZwwm7vFIQh8bCvpl2k=;
        b=CWvviYtIxPVmvaHt2x/5sVp6pun7pDshM/g7zES5y3DdsCvseqKFRO+0rW5G3g9V30
         /iJbpGxQsJbWkozUXYpB4Od+MXVEcCazt9REJz6wkChhQSsN3Dpk5PcBN+RPX5r6GU/8
         vFx8cKY/kTr9+Hqm2dg0ia4pX92XPtDRSz/TkOXxoMjhUcqycj26wQLQB+Klg2TAfa/G
         XGUr1I+RCz1HKC4XvouFNmDkDh84xtDJm3BnkeafSTLOEe6z7GjQ1Z8qLjnKhUd5rT6K
         dJKcCidcdSBo3zTJb3Tp926iwh5sN3e+Kc+eVWrJ9M06D8SoSSAQnpmjrEwajV0+aIjc
         CJMw==
X-Forwarded-Encrypted: i=1; AFNElJ8/ftp13ytTNxbO6wjeJB5lBeY6GVtjfkgp4HidZ5N60cvA+brM0ghkyEezEip5Kf2/BHGVmP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRaqTLvTzHhDZ8NhRfbM3h1GtdhGqU/VzUkE18B3395/zj8fJZ
	SJ9uXoVGK9tDc0dQoxIORG+w9ApIoEMgrHbW9BESP2d1dMvZ4wh06zJb
X-Gm-Gg: Acq92OGcIQINuyR3bE0eWm9ulvOG28IWoHQBecWqfrGLv5WUzq68LyrDJ7mJJqnFurY
	bku+cPnOftSdAvkPAMtpanfOdET0Sh33CBP9VcwCfeWLxUu9U/X814UfofZINiGmvKgm4ak5Hvq
	I5jAfGUXS2e0c6TGXgTMK7B7jck9LZrtHKYYgLTQuX9ROMBJlWUX5DnXnYRwuTo42xQvCjOOHvU
	KDcGIVhazuEI9cbyJCtDkYW4tLvNzQuALd+00fNIBXQxtcEUqDHl0gPU6eSqt+JJNGjM+nuaDRb
	aOXNlclDZD3truiPaYh3eZ44yH3yb0tQ7hglZEkK/yVrpKVBk14pUEB+RKuhd8dvjjJ0FQFLd0w
	U99LFIE5RIS+PhvN/WvUq7pXxKL6wrSjePDQ6lqK8BCZ0CN1gb4eEcOlIhCYxQEDETuzqcdwrBm
	cLm3IOQ1OAAhXEA2J2wDz8zjZTKMjSvdTk3qQUPf6KXhISCieiTMHQkQ==
X-Received: by 2002:adf:f712:0:b0:45e:f5b6:7bf9 with SMTP id ffacd0b85a97d-45ef5b67d32mr846572f8f.31.1780057976615;
        Fri, 29 May 2026 05:32:56 -0700 (PDT)
Received: from cedric-laptop ([195.225.166.186])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef357635fsm3165226f8f.33.2026.05.29.05.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 05:32:56 -0700 (PDT)
Date: Fri, 29 May 2026 14:32:54 +0200
From: Cedric Jehasse <cedric.jehasse@gmail.com>
To: Luke Howard <lukeh@padl.com>
Cc: cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next v4 2/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Message-ID: <gigqfzdzvtoegjd6kb73g2xv4j7uq7f5s2lkrwspiosni3c44p@him3vof5vzrm>
References: <20260528-net-next-mv88e6xxx-cbs-v4-0-8bd13b906457@luminex.be>
 <20260528-net-next-mv88e6xxx-cbs-v4-2-8bd13b906457@luminex.be>
 <DA213B68-5654-498A-B688-B92703923CCE@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DA213B68-5654-498A-B688-B92703923CCE@padl.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293108-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7F6186024CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 09:48:33AM +1000, Luke Howard wrote:
> > +static int mv88e6xxx_setup_tc_cbs(struct dsa_switch *ds, int port,
> > +  struct tc_cbs_qopt_offload *cbs)
> > +{
> > + const struct mv88e6xxx_avb_ops *avb_ops;
> > + struct mv88e6xxx_chip *chip = ds->priv;
> > + const struct mv88e6xxx_qav_info *qav;
> > + const struct mv88e6xxx_ops *ops;
> > + int hilimit_reg;
> > + int rate_reg;
> > + u8 queue_bit;
> > + u16 hi_limit;
> > + u16 rate = 0;
> > + int err;
> > +
> > + ops = chip->info->ops;
> > + avb_ops = ops->avb_ops;
> > + qav = chip->info->qav;
> > +
> > + if (!qav || !avb_ops || !avb_ops->port_qav_write ||
> > +    !ops->port_set_scheduling_mode)
> > + return -EOPNOTSUPP;
> 
> Only the first check should be necessary because the wrapper functions return -EOPNOTSUPP in the case of a NULL function pointer.
> 
That's not the same logic.
If one of the two function pointer is NULL, the other can still be executed
(Maybe not that likely as that's probably a mistake in the driver)

> > + if (!(chip->ports[port].cbs_active_queues & ~queue_bit)) {
> > + err = mv88e6xxx_port_set_scheduling_mode(chip, port, 0);
> > + if (err)
> > + goto unlock;
> > + }
> 
> Missing a newline here after closing brace.

Is that a personal preference, or a guideline i've missed?

> 
> > + chip->ports[port].cbs_active_queues &= ~queue_bit;
> > + goto unlock;
> > + }
> 
> The control flow might be clearer were goto unlock only taken in case of error. i.e. wrap the CBS enable case in an else block.
> 
I don't think it makes that much difference.
You've mentioned the felix driver before, that has similar flow :) (with a
return in the disable case isof goto)

> > +
> > + hi_limit = cbs->hicredit & qav->hi_limit_mask;
> > + err = mv88e6xxx_port_qav_write(chip, port, hilimit_reg, hi_limit);
> > + if (err)
> > + goto unlock;
> > +
> > + err = mv88e6xxx_port_qav_write(chip, port, rate_reg, rate);
> > + if (err)
> > + goto unlock;
> > +
> > + err = mv88e6xxx_port_set_scheduling_mode(chip, port,
> > + chip->info->num_tx_queues - 1);
> 
> For the 6020 (which you brought to my attention as only supporting CBS on half its four queues), should strict priority be enabled only on the CBS queues or on all queues? (I don’t know the answer, just asking.)
> 
I hadn't thought about that. The 6020 has the same strict priority settings
registers as the other devices, it doesn't need special handling.


