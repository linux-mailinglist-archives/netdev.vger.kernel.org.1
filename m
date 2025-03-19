Return-Path: <netdev+bounces-176243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE7AA697CA
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DE2480F98
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B2821146B;
	Wed, 19 Mar 2025 18:12:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC32212B09;
	Wed, 19 Mar 2025 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742407950; cv=none; b=nfdygdtOMQwMYC5nUhb/7qUz3ny22ExLJEvZEXfRhHW5XSBiLU9051dJ1HPUwvb0qsDgvOlaY6r7xaizdbzWT8Wr75aJHiw31RGIFtOlXR/TPCCgaynA81iiUIiEkuBxFitok4kcZ8bJKqlCDX+ohUKAd/Kd0tlVXcAf+75UZxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742407950; c=relaxed/simple;
	bh=yYcxxMaGRCqFRTPVULaIX2bYJGgjsUIv54Fh+juOWow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pv4ObAYZA5x3SBV2/pEyB6XCRTtsZvMRgYYta2TK4mKSIPsQoi2ZEMnRsRdp4ixyVrBk2oPT5ynbkrR2XW3tsIkqzKg7/XlWufUywqqqhSyOJRcmjxPKrBwKsyZRgw+VEr6ZRFjP106oXLizsN2xYRgIb/HPoakmA5pTEb3u+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7430e27b2so164916666b.3;
        Wed, 19 Mar 2025 11:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742407947; x=1743012747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Up1xjea84mFFtC/QFUl+9GqZdL4YQBVY41iIzJ7s9w=;
        b=a3wH9JGAa25Izj6W9yw0ASMT2GQUcKId97otZdw9QDIlvuyCpwCu9xBI5qKpI2OpsN
         wIxgAB1EpKVUgvoFycglUIVThmTtdgqTPOjCIgQWKq8oP2uHsu8SCwITW2LXKZnMe69C
         q6CYvvwyRyn0Ch0OgribKmgzR1Lx9R4+wdwRQ4Mcsi5s2CUjlZMaBDgG+90x76JkQNOh
         Kb6eKsnenBK47BVxKRBCgqekGJmJR405rn8IeSJS5BcyB1p+3dsFaNdjrT2VbXeTgxWX
         bJAba/yzCghmCTb5i6T85dtofOeV1WIs+ncVN+CAKQ+4cTZ8WS3SeDmH6rSEKnt2nj4g
         NabQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIilm+ZH82zizzD9TDvE7tsWT8GIwGcYRvYLKQo068LYRqMfLB6TWpAdBnxXSl2DAoIuMhCbA=@vger.kernel.org, AJvYcCXHNv+1mvJjwvK2DyfWe22oxn/9wLRwWiXPEff35v/xzzKuSch8boJjpkn3G5rABS5VkraC@vger.kernel.org
X-Gm-Message-State: AOJu0YzWkWp9qf+3rmEzGcr7y19/QQbxEMOAxR7+bUN1qAZ+sb/S4llE
	3iqcbDs2ncbgvQOMcGpCI72dTA+u4+uj6J+a6lh8DspLT11SS0PK
X-Gm-Gg: ASbGncu5+MoqnjOtyjEShbXgtJyL+tpCwQ+uaNZxMZcDGHzP3UywBiHR3wUO3DSJ6yQ
	bA6FtF0o40TixMRyY1uqBtylZcKwk6ihXhNbdkz1KW8JvXxMsY6R18OfP41JG6Chh1/e6MTBy0J
	UVy6zkzK40aKpo6OrXgTafAur9ODOMPbgkvGiH0xDidWjHf2oK8fOYiuTwrm15naSuRrAG2X02n
	03paIO+SNSrFK96osSxd1la6uEHPCfgdujXYV6c4ax0YcZRqcz7SsVRh5jgYkUDgVNzhAmrBws+
	DKBAqh4wH/8/toHVLL+nY2JiWgxqySP/TJg=
X-Google-Smtp-Source: AGHT+IEuv66u+KPCyIcrPW7krwGJW4YIwC6fn3uWmqhmLRToO2D33FQi8aLT4Don7dLT/nluRUhFqA==
X-Received: by 2002:a17:907:9706:b0:ac3:3fe3:bea5 with SMTP id a640c23a62f3a-ac3b7f73116mr326822966b.38.1742407946951;
        Wed, 19 Mar 2025 11:12:26 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816968c0csm9466508a12.22.2025.03.19.11.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 11:12:26 -0700 (PDT)
Date: Wed, 19 Mar 2025 11:12:24 -0700
From: Breno Leitao <leitao@debian.org>
To: "Paul E. McKenney" <paulmck@kernel.org>, longman@redhat.com,
	bvanassche@acm.org
Cc: Eric Dumazet <edumazet@google.com>, kuba@kernel.org, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, kuniyu@amazon.com,
	rcu@vger.kernel.org, kasan-dev@googlegroups.com,
	netdev@vger.kernel.org
Subject: Re: tc: network egress frozen during qdisc update with debug kernel
Message-ID: <20250319-truthful-whispering-moth-d308b4@leitao>
References: <20250319-meticulous-succinct-mule-ddabc5@leitao>
 <CANn89iLRePLUiBe7LKYTUsnVAOs832Hk9oM8Fb_wnJubhAZnYA@mail.gmail.com>
 <20250319-sloppy-active-bonobo-f49d8e@leitao>
 <5e0527e8-c92e-4dfb-8dc7-afe909fb2f98@paulmck-laptop>
 <CANn89iKdJfkPrY1rHjzUn5nPbU5Z+VAuW5Le2PraeVuHVQ264g@mail.gmail.com>
 <0e9dbde7-07eb-45f1-a39c-6cf76f9c252f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e9dbde7-07eb-45f1-a39c-6cf76f9c252f@paulmck-laptop>

On Wed, Mar 19, 2025 at 09:05:07AM -0700, Paul E. McKenney wrote:

> > I think we should redesign lockdep_unregister_key() to work on a separately
> > allocated piece of memory,
> > then use kfree_rcu() in it.
> > 
> > Ie not embed a "struct lock_class_key" in the struct Qdisc, but a pointer to
> > 
> > struct ... {
> >      struct lock_class_key;
> >      struct rcu_head  rcu;
> > }
> 
> Works for me!

I've tested a different approach, using synchronize_rcu_expedited()
instead of synchronize_rcu(), given how critical this function is
called, and the command performance improves dramatically.

This approach has some IPI penalties, but, it might be quicker to review
and get merged, mitigating the network issue.

Does it sound a bad approach?

Date:   Wed Mar 19 10:23:56 2025 -0700

    lockdep: Speed up lockdep_unregister_key() with expedited RCU synchronization
    
    lockdep_unregister_key() is called from critical code paths, including
    sections where rtnl_lock() is held. When replacing a qdisc in a network
    device, network egress traffic is disabled while __qdisc_destroy() is
    called for every queue. This function calls lockdep_unregister_key(),
    which was blocked waiting for synchronize_rcu() to complete.
    
    For example, a simple tc command to replace a qdisc could take 13
    seconds:
    
      # time /usr/sbin/tc qdisc replace dev eth0 root handle 0x1234: mq
        real    0m13.195s
        user    0m0.001s
        sys     0m2.746s
    
    During this time, network egress is completely frozen while waiting for
    RCU synchronization.
    
    Use synchronize_rcu_expedite() instead to minimize the impact on
    critical operations like network connectivity changes.
    
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4470680f02269..96b87f1853f4f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6595,8 +6595,10 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	if (need_callback)
 		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
 
-	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
-	synchronize_rcu();
+	/* Wait until is_dynamic_key() has finished accessing k->hash_entry.
+	 * This needs to be quick, since it is called in critical sections
+	 */
+	synchronize_rcu_expedite();
 }
 EXPORT_SYMBOL_GPL(lockdep_unregister_key);
 


