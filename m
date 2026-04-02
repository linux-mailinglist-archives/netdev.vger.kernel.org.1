Return-Path: <netdev+bounces-274444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLgoMBU4zmmAmAYAu9opvQ
	(envelope-from <netdev+bounces-274444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:34:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA336386FD3
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C06B83063190
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 09:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CC43890F8;
	Thu,  2 Apr 2026 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Upz9cl5r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D3F388E7A
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121695; cv=pass; b=RLIA/T240F08tjCwvgq9xZMAleUHXmIPWoJfTcp/x74jRJA7JUWnn9yVfD5+u5ZuMH6xqwnNhzAZCOwiy4mfXhhqgH+d+C+kTDFMOB2INLRHqtOnYTHqzN1dB+NuiCPPZWhGYiJpoqlwg/Llgx3RLZKfNmLNwQ3ZwPQ/VOqwScc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121695; c=relaxed/simple;
	bh=7o1PYGTszXD7LKbuxF5fMm+gJsu3c7Psj+MM+y3V+Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QrL7n5w7EQ7T6EBZoEnDtCYAlMfQ9uOcAqVmycGSNHTyPZcDvFdL64vgixPy38M8aysdbG7zRQXTHT9bVC32ycOuNlmDMy8gqr5/7hlR9dsm4a4H6mKy8wlb7rLK9NCBenIooOm488G1X8tA737RikoGrcYBoGLtVK4tdkAqzKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Upz9cl5r; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fb439299so5592175e9.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 02:21:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775121691; cv=none;
        d=google.com; s=arc-20240605;
        b=fcuV8vzhjJNFRUGtCqHeD+XhjJEbo4i6QKxFTuNnCX+hrqBWE4E7bqyp+hmaxpvnP8
         eyYOME//msU3rM7nJfgrWtMjsq5ed0i7k2wbtFg7FsiUnCa9WJZTZbuatmxUJgMJStvE
         SiLYrwo61p4UZT6GLFRHEmZOT+V8Lnp1mqxjVHLbBMfjucWylV+G9Ja/RKN5Tn1YfLSA
         xEJN09KSyFI3N3WYBq9cXU6iZ9je/di7xQHfJtLXBtH8w6mXbShoSFPpMBstdPedE/IU
         UHYld56icldlZ/ffrCus1Fwoep04+vLDAOsFOYJjfX/3csChSxbjzznT1CMe89h0tBuE
         nmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7o1PYGTszXD7LKbuxF5fMm+gJsu3c7Psj+MM+y3V+Vs=;
        fh=fdjI/JSNVIHpkFseB8yer2SQZ97IkUde2EaN5frGOMw=;
        b=R+xuKes0LLMmiyf5IzTMNORGLNT9PnwLVBXaxfXHYz5ohe7oIXC1xT/ZcqaRTss64L
         oIRPSicSjh1tw4rYuEtRo5SF0vgBNws61DiWV7g361Ml9MAe10WNgZ69io0UoAEtYTgh
         qHXCp7zifnPDqMCrBafnaWqegMs157nEkw+4ywM9nC2D8gEfWomwRTeOBWFTy9BdRlNk
         djMfwOlFqf3Njlw1sdvqEcKsH6I3i+EMqpCWdCJ5+hVS/dVNAlzgOVEz1lPRd2jhv/Sd
         c6jPx8n2b6Q4QXcWvP5TmGdsU7YkbbZ7bVkGQqNiXCRiAxkK/nQcUKTP33sME7vErpoa
         70Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775121691; x=1775726491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7o1PYGTszXD7LKbuxF5fMm+gJsu3c7Psj+MM+y3V+Vs=;
        b=Upz9cl5r75yU3CcRSKD7iq9yfHcRptVf56aFnbhCu1JgKjZ3h1wwr32+soggZmtDDB
         D8RmbndPjyffBH9gJSonG9BTfTscGoFIGEla9u9KAPYZSMAk4Ksq/yK+JH2vX9HO1NUI
         euPb2am8//GI5Sk9jmgXIeCLhDs8x+zXhistZ/3UYqkN3rIJO5V8FbzgZFSHSR+CXjN0
         gEpN6H5z1B05UshpycOlRKmRK4qj66CyO6H03LqtwUJFdMiguHQoFhZLu+61QKIb7HS4
         L9IKI2vlxtT3wH+1N0uEUhApYV45h+0asFvMkDjali1zOEwftnNkp9/AQ5Y/fEL0HoO/
         +ryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775121691; x=1775726491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o1PYGTszXD7LKbuxF5fMm+gJsu3c7Psj+MM+y3V+Vs=;
        b=dmZIvlbYqw70ePPAud8pmbbZc12vXmbvQIJ9Jcas4uBN2vyaU5gSEjS8wGFfv2n+v6
         PfVy11EY6I4vHnulnsvf2n5ftG70TIoN+b0xW3/b/ObqgJhEeAfIP+5Jj/qOsRYaRGLO
         scvfbNMlUALxsPzNvM1ppI2oSZsckY1wneL1NwZC33itdK1LwbgfeFBPyRAW7uyRc7QE
         wG+vAFT08t6FZ1Z3PSueiI75Bqf34BVrDoKUS4ukm13+I1XERVgfcGkdij3fu5nkxtLO
         OkihmiTVgHRimIKRIvzA7cL2OTvwx3+uw0a0fsOmrEyW+hkcsCcn5GvaAaP2ZKujyXoY
         k/sA==
X-Forwarded-Encrypted: i=1; AJvYcCXg7yZMNsafKBxIfXycZKwxcl1RBdN4vc5mFWCjmWzfWyrDhk0OWSvdwFZ/6AUqPgYoi9SdE1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwptYJGgIya0xjdxRrDLaTt7hssqqem/rPjG8Vb4sXagxfNLvnW
	RZoSvqeoRdU5ysoQMEsfKNunKoeQ43DQON7w6UH44wF2PyjGY2Lyxy/oPggLjVAPeqsUkgWciea
	ssBoC1pH6W0B/ie+0z3MRLObpOAFgkfi6uKPLntEoow==
X-Gm-Gg: ATEYQzzfbfMJArocdzoT9n4mkd1TNI+htcykaXtu38tPoC/TB3/RIFNDAkJM2Hsfz8S
	AufiJkerVL4Qs7XqiOuaHCjqaT9aTfMIjANq6s+revqdkVbMFlEgFvdSRQcs1932kzZ+dKvlV0G
	6qlf/49K6R9IzN0t+LEtvPoZo33hIl7Sb2vWmtb21YMaj1IJW8Zn65SAQ9BtZw11nZ2RXcfBq1S
	rMlirIvt0X1vtCk6kdYE1ab6J4idMc6OodgB0McS5PXWHEc70HoDTwurR4UZ3GKg3JukJGtXuO+
	klIptUBf0/R3pnHdgn2Psur1eznC0tKJgUV0hg2TquZ7tGK0bZNDcr4AZVDyLS9IqXaNVpGMxW2
	iJ2wJ
X-Received: by 2002:a05:600c:354d:b0:487:386:3714 with SMTP id
 5b1f17b1804b1-48883597e29mr110144355e9.17.1775121691116; Thu, 02 Apr 2026
 02:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218073036.AlkNRoAP@linutronix.de> <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de>
 <20260226172927.2Ck9wZMw@linutronix.de> <20260318103009.2120920-1-neelx@suse.com>
 <20260318111849._MMol8Hr@linutronix.de> <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com>
 <20260318145101._iaDDpbE@linutronix.de> <CAPjX3FePCKQTaxB6zuo+_V09PZct=utw3vgJUTM_GrZQtv7_TA@mail.gmail.com>
 <20260402070319.vhRd6c-f@linutronix.de> <CAPjX3Ffz22M_ADE1xPqHOCyni1wLwc+reLTVyOrJ+gqNYY6vwg@mail.gmail.com>
 <20260402083123.1H4kyAEn@linutronix.de>
In-Reply-To: <20260402083123.1H4kyAEn@linutronix.de>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 2 Apr 2026 11:21:20 +0200
X-Gm-Features: AQROBzChG2baadjgz8ltJV9SHGvnYSyy-pP9io372jEf1uyHe9Xp8DZ8CmmjL-I
Message-ID: <CAPjX3Ff8Zv2EArKaCSKFAAFfBCCVu0YgqHk3SV85BBPm6-D7HQ@mail.gmail.com>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org, spasswolf@web.de, 
	tglx@linutronix.de, Aaron Tomlin <atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,lists.linux.dev,web.de,linutronix.de,atomlin.com];
	TAGGED_FROM(0.00)[bounces-274444-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BA336386FD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026 at 10:31, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2026-04-02 09:50:35 [+0200], Daniel Vacek wrote:
> > My idea was that the non-preemptible one can record `current` task
> > instead of the CPU to detect the deadlock. And that would also work
> > for the preemptible case (it would actually match the lock owner
> > approach as you did for the PREEMPT_RT case).
> > One code for both configurations, no special-casing. I'd argue that's
> > a better result. Am I missing something?
> >
> > The size of the netdev_queue structure would grow by 8 bytes for !RT
> > case, but that's not a big deal, IMO. For RT case it would just fill
> > the hole.
>
> We have xmit_lock_owner as int. If you replace it with task_struct *
> then on 64bit the size of the struct netdev_queue will remain unchanged
> as it fills the hole before the following long.
> Then you could record `current' as the lock owner in both cases. This
> should work.

Well, that's the patch I originally sent then.

https://lore.kernel.org/linux-rt-devel/20260318103009.2120920-1-neelx@suse.com/

--nX

>
> Sebastian

