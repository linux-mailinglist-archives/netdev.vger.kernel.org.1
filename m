Return-Path: <netdev+bounces-166508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8035CA3635A
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 17:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57687188C69B
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 16:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF22267732;
	Fri, 14 Feb 2025 16:43:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6118635A;
	Fri, 14 Feb 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551415; cv=none; b=NdHu8gW54+Wiqxufuc65RCc8BCwG/few0ZRBAx5Ty2wznQ3rHyWBM9iVmKTCLckUDGFo0jmFLAX7OUdMTtHpwL3nIePAxJEALFyDwfaoatelkGwymiPyvt8ObCk7E7868ToJ01daYjH5dNLlLOtbSBS8jNKjP+5sVVNGTzHpJAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551415; c=relaxed/simple;
	bh=675U55SFM8sU4+EhaPernPFOC39d5e7xO/3frydYZ2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjlsU767CPn7Pn3hOO/PJ2lrz49uZxVuKd29V1yytQioAlf7iV1W9JcpqAa6b6bdEVI0XI9y5LW6m7LJeyNbEQ+2VNHKkrDCQpmgV6mSREibNmswV8+bjnCcLgECUzQfeXoYFrHQPoT/LVObpbykBvDGa/xxnsQMy5oUogSFOPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de3c29ebaeso2874477a12.3;
        Fri, 14 Feb 2025 08:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551412; x=1740156212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t1Ns3NcaYBFWtkLRF5Ic7g1dCvI6biRGojqgTrE5Gw=;
        b=BH+1quUYchT/1DAs4iY8/YICD/xAnDTWRDxtFDHUcRLfQMegOQyc0uzt+9goEySGkZ
         L/QVGAJba5vbdhaDSRBctQHTfT3NqFtW6/r3yUNwDGwjS+WXi4F4xp9Rj2BC1cwyghri
         n+pG8PwXst2iig3AN48Nl0uCWXUV4NKgXJCJUd6O7ygAWOmL84urPGOacYlpDuekmcEF
         M964PmO1dbC6ihFpujB3q/900Hx5clbVkWNczG/Kh5Ki+4HpkbznVEoHENNWX/0MMGrg
         jx/vYiR6k3HTUbRJ+HF5rmaGYEfuVRqK1wsFyZ8rvE2W39gHvwDwJRO1jBZPnmc8tZCq
         2Y4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkWokDy5yD/qhPbpcLhrOZK2NFPlSYfQ+tTaHT7lujdh/M7aG3dbjAZWMWFsJPqkmB9aOSXX8N@vger.kernel.org, AJvYcCW37Hzhg2WxFeUSuY/p05RBr3O6dkA/nF6/chPr5WCRHUgOJIj9OgDd6OPnU/nsJLrYA26Dep1ysweL@vger.kernel.org, AJvYcCXRn5Ut1vyFxcVUNCav8wx1cR3LKqtuddd74t32MZm5D+7Hm9qDZLUa0dWgg7KaTdORNi6qtF63xYhQflE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/ZWV4fMDCtphBn5BmAjGjEMc2eg6gloJYg9x4BY7I99odu9z
	aMbcSLU/CwYkvPVjSqe3cNY3Q4eXnMsE0EoO3AQR4b/WJnvHmY+u
X-Gm-Gg: ASbGncuiQid9+rgC6pZrXD/WSV1gmjVFT633Bi4RCQ62dLiDvqZ9yqbaRmJH/y+4FmZ
	tuG/AzrXH0FVS6fCdJqbaA+674D3NIwKS2eshOz56Mi6gj3Ehx5NytZX6jglcHx7V0x7hTVWIQZ
	IZ/reLcvSgO04HDTIZ/F7R0hmthL77uL3DmHY97pVyA+UMIohbRCuGzw+c0fZPyH4MUHu7hZYkZ
	ZD0Yg1EOYO1zk2Z5gCQJM46x84jtv6AelbEqUY+rmMUSxGRLAk9qBT4WZf744sVRwfiUH280TuK
	IRol0Q==
X-Google-Smtp-Source: AGHT+IFBPPEELc2QJatVUYw0kOEPlaAq+EmZ03OI1xZEzH4jy5P0OOSZPQ0pK4HjxYlqMW0G7zWgkw==
X-Received: by 2002:a17:907:948f:b0:ab6:e10e:2f5 with SMTP id a640c23a62f3a-ab7f347e62amr1376490366b.37.1739551411728;
        Fri, 14 Feb 2025 08:43:31 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53398364sm373948266b.128.2025.02.14.08.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:43:31 -0800 (PST)
Date: Fri, 14 Feb 2025 08:43:28 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: Assert proper context while calling
 napi_schedule()
Message-ID: <20250214-grinning-upbeat-chowchow-5c0e2f@leitao>
References: <20250212174329.53793-1-frederic@kernel.org>
 <20250212174329.53793-2-frederic@kernel.org>
 <20250212194820.059dac6f@kernel.org>
 <20250213-translucent-nightingale-of-upgrade-b41f2e@leitao>
 <20250213071426.01490615@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213071426.01490615@kernel.org>

Hello Jakub,

On Thu, Feb 13, 2025 at 07:14:26AM -0800, Jakub Kicinski wrote:
> ... How about we add an hrtimer to netdevsim,
> schedule it to fire 5usec in the future instead of scheduling NAPI
> immediately? We can call napi_schedule() from a timer safely.

I hacked a way to do so. Is this what you had in mind?

Author: Breno Leitao <leitao@debian.org>
Date:   Wed Feb 12 09:50:51 2025 -0800

    netdevsim: call napi_schedule from a timer context
    
    The netdevsim driver was experiencing NOHZ tick-stop errors during packet
    transmission due to pending softirq work when calling napi_schedule().
    This issue was observed when running the netconsole selftest, which
    triggered the following error message:
    
      NOHZ tick-stop error: local softirq work is pending, handler #08!!!
    
    To fix this issue, introduce a timer that schedules napi_schedule()
    from a timer context instead of calling it directly from the TX path.
    
    Create an hrtimer for each queue and kick it from the TX path,
    which then schedules napi_schedule() from the timer context.
    
    Suggested-by: Jakub Kicinski <kuba@kernel.org>
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 42f247cbdceec..cd56904a39049 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -87,7 +87,7 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(nsim_forward_skb(peer_dev, skb, rq) == NET_RX_DROP))
 		goto out_drop_cnt;
 
-	napi_schedule(&rq->napi);
+	hrtimer_start(&rq->napi_timer, ns_to_ktime(5), HRTIMER_MODE_REL);
 
 	rcu_read_unlock();
 	u64_stats_update_begin(&ns->syncp);
@@ -426,6 +426,25 @@ static int nsim_init_napi(struct netdevsim *ns)
 	return err;
 }
 
+static enum hrtimer_restart nsim_napi_schedule(struct hrtimer *timer)
+{
+	struct nsim_rq *rq;
+
+	rq = container_of(timer, struct nsim_rq, napi_timer);
+	napi_schedule(&rq->napi);
+	/* TODO: Should HRTIMER_RESTART be returned if napi_schedule returns
+	 * false?
+	 */
+
+	return HRTIMER_NORESTART;
+}
+
+static void nsim_rq_timer_init(struct nsim_rq *rq)
+{
+	hrtimer_init(&rq->napi_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	rq->napi_timer.function = nsim_napi_schedule;
+}
+
 static void nsim_enable_napi(struct netdevsim *ns)
 {
 	struct net_device *dev = ns->netdev;
@@ -436,6 +455,7 @@ static void nsim_enable_napi(struct netdevsim *ns)
 
 		netif_queue_set_napi(dev, i, NETDEV_QUEUE_TYPE_RX, &rq->napi);
 		napi_enable(&rq->napi);
+		nsim_rq_timer_init(rq);
 	}
 }
 
@@ -461,6 +481,7 @@ static void nsim_del_napi(struct netdevsim *ns)
 	for (i = 0; i < dev->num_rx_queues; i++) {
 		struct nsim_rq *rq = ns->rq[i];
 
+		hrtimer_cancel(&rq->napi_timer);
 		napi_disable(&rq->napi);
 		__netif_napi_del(&rq->napi);
 	}
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index dcf073bc4802e..2b396c517ac1d 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -97,6 +97,7 @@ struct nsim_rq {
 	struct napi_struct napi;
 	struct sk_buff_head skb_queue;
 	struct page_pool *page_pool;
+	struct hrtimer napi_timer;
 };
 
 struct netdevsim {

