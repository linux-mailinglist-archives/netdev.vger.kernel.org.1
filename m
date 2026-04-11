Return-Path: <netdev+bounces-277657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id H8MUGm/X2WmutggAu9opvQ
	(envelope-from <netdev+bounces-277657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:09:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C193DE5F9
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 07:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F980302DF9F
	for <lists+netdev@lfdr.de>; Sat, 11 Apr 2026 05:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B02E2EBBB9;
	Sat, 11 Apr 2026 05:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="0WSw4+yd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E1A212FAD
	for <netdev@vger.kernel.org>; Sat, 11 Apr 2026 05:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775884139; cv=none; b=lR6i88xQ3jXnF96EGZggTOUNtB63MkMTqjfvkn4EJEdDOg6fXiuDyfF0PyFLPJOH4+PNnlONRCaVRinegDvmhCTlp1mLlmBNJEoN7xTasBhdKDYbXKU50IdwOkqGAT3UzM/ZGUn2D/K8DgENCLBZaI/yH9uXVCB0TS3EtsfDs7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775884139; c=relaxed/simple;
	bh=hnhWOE4trs7qoLEby7/aycHMsLsS4L6lD8KHob2ggP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D597SI4zSm43CRej2zhJaHHx9d9qaFYoY8xzdnUJ+c4jDucrIeJKlmsKo//ybXW+56+435Hwf5c5oxUJW0vJPdD4Kzov0D1wH1CwmtV+bENddyJGyj6uGiO2h5FXjVkRGeudyRWkOdqgpHCPwM8D4xjCiO8JgX0qqwfrX4I2gwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=0WSw4+yd; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso3090506eec.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 22:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1775884136; x=1776488936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRF+l/zUg18CEVvIdDUatVFVj/D1hXEfu108gn4gtSY=;
        b=0WSw4+ydsRb3czymF14tch8tkISlbC1lk38ly75MvyX01GPQF+v7E6TMOJXVVqg77q
         /M89fyqPz21FZRiqF1ZWFClR1GcuQhgbee9yR/TGXvevT4TQ5p08nABXtmeDn+Knz6Y/
         gJgn+yLLQcofQ5TmsaJ2+M8YwUjz0XMsYdLysNhnMnB1MA+hqssykcbHbMmtLmGStDNP
         a1G7zS/AWRCS2p1M0phSaTTF+5fKPsPgnekImzhtznNvhhTXqQwS+29tcUcWp/7rt/FP
         tZLLY4xaHqO0tfbz2vsHGtcksch1rVwcmsrQ+E2s/WQP7OJPxc/+ygo0sD0XhPaQf4z6
         iiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775884136; x=1776488936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XRF+l/zUg18CEVvIdDUatVFVj/D1hXEfu108gn4gtSY=;
        b=gn8COMA8jYkMVAedjQ7hSKOC2K0LELS5jCQ5vYi1b6pDtg9DfBkrwnKlHKHLOmco5a
         I/TFhY3N+OWhZtCRT4ahZvceVfYZE1iPKk1z7BJBa33Iv3fF4gvf0CHKirf+e1GVt9T4
         I4VKdFS3cZYmH+HIx0QPkJzZe4lrABdGeP2udO93NTtQ8mIM7XD6Z07SArPK4UrFJ7Od
         IAacOPDxxaKz9Es4QuB4rBi1fNKF0opLLkxj40oZsohMF3onpMFJenxAXPczQi2NTUZe
         GkL3+vwpJ7XAPYmOwGQ9OCxaUY+3T3QyIBaT+xdCi2MuYlqfTnTuktXU8ETzvieO1pVQ
         OTFQ==
X-Gm-Message-State: AOJu0Yyd7RtIfnbszpC5QL4FemHm+r1hXfi/X7cxNR4hSTtecK72cLuL
	N8ksV6mC1r2GfQj+8TfubQPScrVSB1JO63SezpxdiTajrDHRNQmXTTQLOylc3DEmBEKbWj/cP2r
	OjMAq
X-Gm-Gg: AeBDietyRfOtVQrxuDjE332kQylOPOgSZR7EVKkttb+seO1PDMbkUx4fB6cWt1ghH6c
	WaNyxEb2nGel2M9DXjDJ7CN6FmUh5Je01SIZ30GK5YAw1+6FyvR2YwFJZ+uJA56ApdyBVjMyzXg
	VQP11INCR2A+LTDJcKBK5IHVNSihsHe3eHZUsqYDMk/N0gdDNGtUS29GH2st2truQLLWfVdUWBT
	UNP1qRozGD8bOs0gDGI0QB3S02iM6maVKdEk39mL4/5AtVVUzoLL5LAsQkan7D1FAtcXysiV3K5
	T5nbwn1h7Lgx7QkK7bIOK58cmG40ckDVJYU6DwAiIL5hwKM2GbR3GckYr6R7XvGbfRmFcFMVnmE
	JQX17bgT/MTQMtV5xCPFasVQVHGDjkvx8QIrOeao+CkM9Aw88QBcnbwZ8I2jUvmDJQKTzlPHerd
	Pv1dOUEKftwRqT+Mt0LDCfVMEUrXH8l032gN1cfZweg1eRvQ==
X-Received: by 2002:a05:7300:2384:b0:2ce:25be:c8e8 with SMTP id 5a478bee46e88-2d5881a8f1dmr3818451eec.17.1775884135748;
        Fri, 10 Apr 2026 22:08:55 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55faa5257sm7451465eec.9.2026.04.10.22.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 22:08:55 -0700 (PDT)
Date: Fri, 10 Apr 2026 22:08:52 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 4/5] net/sched: netem: add per-impairment
 extended statistics
Message-ID: <20260410220852.1fabffc0@phoenix.local>
In-Reply-To: <36e86b68-f7d9-4455-a0b5-613f717e670a@redhat.com>
References: <20260403225324.476787-1-stephen@networkplumber.org>
	<20260403225324.476787-5-stephen@networkplumber.org>
	<36e86b68-f7d9-4455-a0b5-613f717e670a@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-277657-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: A9C193DE5F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 11:30:00 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 4/4/26 12:52 AM, Stephen Hemminger wrote:
> > diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
> > index 66e8072f44df..fada10cb9b7b 100644
> > --- a/include/uapi/linux/pkt_sched.h
> > +++ b/include/uapi/linux/pkt_sched.h
> > @@ -569,6 +569,15 @@ struct tc_netem_gemodel {
> >  #define NETEM_DIST_SCALE	8192
> >  #define NETEM_DIST_MAX		16384
> >  
> > +struct tc_netem_xstats {
> > +	__u32	delayed;	/* packets delayed */
> > +	__u32	dropped;	/* packets dropped by loss model      */
> > +	__u32	corrupted;	/* packets with bit errors injected   */
> > +	__u32	duplicated;	/* duplicate packets generated        */
> > +	__u32	reordered;	/* packets sent out of order          */
> > +	__u32	ecn_marked;	/* packets ECN CE-marked (not dropped)*/
> > +};  
> 
> Sashiko notes that the counters size will be set in stone by the uAPI,
> and u32 can wraparound very quickly (especially for unconditional delay).
> 
> I see other qdiscs generally use __u32, but some have __u64 too, so I
> assume there are no architectural blocker to larger counter.
> 
> Could you please move use __u64 above?
> 
> Thanks,
> 
> Paolo
> 

Sure larger counters are fine, mostly just following the herd.
I assume don't need to need about 32 bit tearing when reading these?

