Return-Path: <netdev+bounces-58092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 185C1815005
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 20:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF5F1C20C07
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 19:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED31B3EA71;
	Fri, 15 Dec 2023 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHhyiItO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3923C41843
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so835813276.0
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 11:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702667556; x=1703272356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/7MzHYLzqZQheJqMfLkZzeOiy0VpB3DOKLySBs2Akg=;
        b=XHhyiItOgQT3AV3nk1DKCvzkKOt02iAQQu0+7TrGKZiV3nQb6oqQJ3Yw9hTIIdbahV
         slKm+OnEu/1M/zYZMBPYUx7DONvDdjFz9+VDuZIV1knh/AzmB04UnXeF858/bW6WRUSK
         nHIwaJasbbMDdCudZnku+K99eaFIPG7E/N2g75EHeJB1oFYCx7OYbE9Tu/67IGmomV7z
         lYHkNnC3dSr4aw4URwkheUu1Rau1QWngticOTc/600MrlpMT4Kk/31hDWeuYPgIxE/BJ
         zHyOXGy9Gl2RdWoM6ARejKKANTPyBxpJPcQ3qWDVsOBCLv/pqZiDemxPw+rcaa3QWjrv
         NPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702667556; x=1703272356;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/7MzHYLzqZQheJqMfLkZzeOiy0VpB3DOKLySBs2Akg=;
        b=X7YYLK05sRTfhIO52r4aN3AURgD1iVkhI+87xpvwrrDQQrJ0xTsZK3f3K77QSWGNfQ
         L+o8fQL+bSSmSaDIzcSRZIpaLUCPNIy2/B4sxs8pHVTRMpo/L+Vx2JrqMHcXsypNzqZH
         iTR0Ujf4jBpQT76f0aeGRLY6edZqYU/qntqlIkrpzDWRrgkkOqS9eAG3TYNTRjCwkDaW
         x0RMxHobRsjmJ9ewWmYp6PsYEqiWgKtc/u9eWRS0iPYk6Q0DAIpk7UJvSIsMoKCSxHY/
         /TCal8/N6+RDliNEEUtrxRYXJXdfj08+eZb9QucNjAQ5EysK5p4tC5SPqce7AtiBR8Xl
         jhbg==
X-Gm-Message-State: AOJu0YxOElRQZ+YW2/uFRevd4i7okOn5Xzss+VvhsETrMgKQvhA+eAv3
	tyu7enF8RNAoRBO79qeZBX0=
X-Google-Smtp-Source: AGHT+IEPDmPqsW/Fae8JRM7QKRAcGCa5W5/Wr2x9CIll8lf39S9KqIGvW/xWuVZo3vyV6dng/bZKWA==
X-Received: by 2002:a25:b12:0:b0:dbc:ceab:3a2b with SMTP id 18-20020a250b12000000b00dbcceab3a2bmr3600559ybl.32.1702667555917;
        Fri, 15 Dec 2023 11:12:35 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:cff8:4904:6a61:98b6? ([2600:1700:6cf8:1240:cff8:4904:6a61:98b6])
        by smtp.gmail.com with ESMTPSA id 18-20020a250b12000000b00dbccef3a8fcsm2173069ybl.28.2023.12.15.11.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 11:12:35 -0800 (PST)
Message-ID: <185a3177-3281-4ead-838e-6d621151ea36@gmail.com>
Date: Fri, 15 Dec 2023 11:12:33 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net/ipv6: insert a f6i to a GC list only
 if the f6i is in a fib6_table tree.
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, thinker.li@gmail.com,
 netdev@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: kuifeng@meta.com, syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com
References: <20231213213735.434249-1-thinker.li@gmail.com>
 <20231213213735.434249-2-thinker.li@gmail.com>
 <28f016bc-3514-444f-82df-719aeb2d013a@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <28f016bc-3514-444f-82df-719aeb2d013a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/13/23 22:11, David Ahern wrote:
> On 12/13/23 2:37 PM, thinker.li@gmail.com wrote:
>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>> index b132feae3393..dcaeb88d73aa 100644
>> --- a/net/ipv6/route.c
>> +++ b/net/ipv6/route.c
>> @@ -3763,10 +3763,10 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
>>   		rt->dst_nocount = true;
>>   
>>   	if (cfg->fc_flags & RTF_EXPIRES)
>> -		fib6_set_expires_locked(rt, jiffies +
>> -					clock_t_to_jiffies(cfg->fc_expires));
>> +		__fib6_set_expires(rt, jiffies +
>> +				   clock_t_to_jiffies(cfg->fc_expires));
>>   	else
>> -		fib6_clean_expires_locked(rt);
>> +		__fib6_clean_expires(rt);
> 
> as Eric noted in a past comment, the clean is not needed in this
> function since memory is initialized to 0 (expires is never set).
> 
> Also, this patch set does not fundamentally change the logic, so it
> cannot fix the bug reported in
> 
> https://lore.kernel.org/all/20231205173250.2982846-1-edumazet@google.com/
> 
> please hold off future versions of this set until the problem in that
> stack traced is fixed. I have tried a few things using RA's, but have
> not been able to recreate UAF.

I tried to reproduce the issue yesterday, according to the hypothesis
behind the patch of this thread. The following is the instructions
to reproduce the UAF issue. However, this instruction doesn't create
a crash at the place since the memory is still available even it has
been free. But, the log shows a UAF.

The patch at the end of this message is required to reproduce and
show UAF. The most critical change in the patch is to insert
a 'mdelay(3000)' to sleep 3s in rt6_route_rcv(). That gives us
a chance to manipulate the kernel to reproduce the UAF.

Here is my conclusion. There is no protection between finding
a route and changing the route in rt6_route_rcv(), including inserting
the entry to the gc list. It is possible to insert an entry that will be
free later to the gc list, causing a UAF. There is more explanations
along with the following logs.

Instructions:
      - Preparation
        - install ipv6toolkit on the host.
        - run qemu with a patched kernel as a guest through
          with the host through qemubr0 a bridge.
        - On the guest
          - stop systemd-networkd.service & systemd-networkd.socket if 
there are.
          - sysctl -w net.ipv6.conf.enp0s3.accept_ra=2
          - sysctl -w net.ipv6.conf.enp0s3.accept_ra_rt_info_max_plen=127
        - Assume the address of qemubr0 in the host is
          fe80::4ce9:92ff:fe27:75df.
      - Test
        - ra6 -i qemubr0 -d ff02::1 -R 'fe82::/64#1#300' -t 300 # On the 
host
        - sleep 2; ip -6 route del fe82::/64                    # On the 
guest
        - ra6 -i qemubr0 -d ff02::1 -R 'fe82::/64#1#300' -t 300 # On the 
host
        - ra6 -i qemubr0 -d ff02::1 -R 'fe81::/64#1#300' -t 0   # On the 
host
      - The step 3 should start immediately after step 2 since we have
        a gap of merely 3 seconds in the kernel.


The log generated by the test:

# this is the log triggered by step 1

qemu login: [    4.673867] __ip6_ins_rt fe80::5054:ff:fe12:3456/128
[   82.138139] rt = 0000000000000000
[   82.138731] fib6_info_alloc: ffff888103950200
[   82.139088] __ip6_ins_rt ::/0
[   82.139993] fib6_add: add ffff888103950200 to gc list 
ffff888103950238 pprev ffff888102878200 next 0000000000000000
[   82.141719] rt = ffff888103950200
[   82.141748] rt6_route_rcv
[   82.141748] fib6_info_alloc: ffff88810093be00
[   82.141748] __ip6_ins_rt fe82::/64
[   82.141748] rt6_route_rcv: route info ffff88810093be00, sleep 3s
[   85.121803] fib6_set_expires_locked: add ffff88810093be00 to gc list 
ffff88810093be38 pprev ffff888102878200 next ffff888103950238
[   85.146497] rt6_route_rcv: route info ffff88810093be00, after release


# This is the log triggered by step 2 & 3.
#
# The line containing fib6_clean_expires_locked is specifically
# triggered by step 2. Step 2 removes the entry from the tree and
# gc list. Step 3 free the entry by calling
# fib6_info_release() at the very end of rt6_route_rcv() since it is
# the last owner of that entry. fib6_info_destroy_rcu proves that.
#
# However, even the entry will be free later, rt6_route_rcv() still add
# the entry back to the gc list before freeing the entry. In other
# words, it create an entry (ffff88810093be38) that is free in
# a gc list.
#
# Keep an eye on ffff88810093be38 and ffff88810093be00. ffff88810093be00
# is the address of a fib6_info and ffff88810093be38 is the address of
# its gc_link.
#
# This log also complies with the log in
#
#  https://lore.kernel.org/all/20231205173250.2982846-1-edumazet@google.com/
#
# The entry is free by the call of fib6_info_release() in
# rt6_route_rcv().

[  105.158140] rt = ffff888103950200
[  105.158590] rt6_route_rcv
[  105.158924] rt6_route_rcv: route info ffff88810093be00, sleep 3s
[  106.368875] fib6_clean_expires_locked: del ffff88810093be00 from gc 
list pprev ffff888102878200 next ffff888103950238
[  107.201815] fib6_set_expires_locked: add ffff88810093be00 to gc list 
ffff88810093be38 pprev ffff888102878200 next ffff888103950238
[  108.159815] rt6_route_rcv: route info ffff88810093be00, after release
[  108.168807] fib6_info_destroy_rcu ffff88810093be00


# This is the log triggered by step 4.
# The line containing fib6_clean_expires_locked shows the free entry
# mentioned in the previous part is still in the gc list. (pprev
# ffff88810093be38)
# Since fib6_clean_expires_locked() calls hlist_del_init() to remove
# an entry from the gc list, it will change the value of *pprev
# (ffff88810093be38). It causes an UAF case.

[  131.882130] rt = ffff888103950200
[  131.882567] __ip6_del_rt ::/0
[  131.882932] fib6_clean_expires_locked: del ffff888103950200 from gc 
list pprev ffff88810093be38 next 0000000000000000
[  131.883296] rt6_route_rcv
[  131.883296] fib6_info_alloc: ffff88810093be00
[  131.884517] __ip6_ins_rt fe81::/64
[  131.884517] rt6_route_rcv: route info ffff88810093be00, sleep 3s
[  134.305866] fib6_set_expires_locked: add ffff88810093be00 to gc list 
ffff88810093be38 pprev ffff888102878200 next ffff88810093be38
[  134.537866] rt6_route_rcv: route info ffff88810093be00, after release
[  134.896801] fib6_info_destroy_rcu ffff888103950200


# The following log is the kernel errors that printed after 10s seconds.

[  168.321812] watchdog: BUG: soft lockup - CPU#3 stuck for 26s! 
[swapper/3:0]
[  196.289823] watchdog: BUG: soft lockup - CPU#3 stuck for 52s! 
[swapper/3:0]
[  214.244784] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[  214.245723] rcu:     3-....: (7 ticks this GP) idle=198c/0/0x1 
softirq=2002/2003 fqs=12309
[  214.245774] rcu:     (detected by 2, t=60002 jiffies, g=1213, q=282 
ncpus=4)
[  240.321823] watchdog: BUG: soft lockup - CPU#3 stuck for 93s! 
[swapper/3:0]
[  268.353804] watchdog: BUG: soft lockup - CPU#3 stuck for 119s! 
[swapper/3:0]
[  296.388805] watchdog: BUG: soft lockup - CPU#3 stuck for 146s! 
[swapper/3:0]





diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 1ba9f4ddf2f6..6e059ba3d2d0 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -510,8 +510,11 @@ static inline void fib6_set_expires_locked(struct 
fib6_info *f6i,

  	tb6 = f6i->fib6_table;
  	f6i->expires = expires;
-	if (tb6 && !fib6_has_expires(f6i))
+	if (tb6 && !fib6_has_expires(f6i)) {
  		hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
+		printk(KERN_CRIT "fib6_set_expires_locked: add %px to gc list %px 
pprev %px next %px\n",
+		       f6i, &f6i->gc_link, f6i->gc_link.pprev, f6i->gc_link.next);
+	}
  	f6i->fib6_flags |= RTF_EXPIRES;
  }

@@ -529,8 +532,11 @@ static inline void fib6_set_expires(struct 
fib6_info *f6i,

  static inline void fib6_clean_expires_locked(struct fib6_info *f6i)
  {
-	if (fib6_has_expires(f6i))
+	if (fib6_has_expires(f6i)) {
+		printk(KERN_CRIT "fib6_clean_expires_locked: del %px from gc list 
pprev %px next %px\n",
+		       f6i, f6i->gc_link.pprev, f6i->gc_link.next);
  		hlist_del_init(&f6i->gc_link);
+	}
  	f6i->fib6_flags &= ~RTF_EXPIRES;
  	f6i->expires = 0;
  }
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 28b01a068412..b275b9798b5e 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -162,6 +162,8 @@ struct fib6_info *fib6_info_alloc(gfp_t gfp_flags, 
bool with_fib6_nh)

  	INIT_HLIST_NODE(&f6i->gc_link);

+	printk(KERN_CRIT "fib6_info_alloc: %px\n", f6i);
+
  	return f6i;
  }

@@ -178,6 +180,7 @@ void fib6_info_destroy_rcu(struct rcu_head *head)

  	ip_fib_metrics_put(f6i->fib6_metrics);
  	kfree(f6i);
+	printk(KERN_CRIT "fib6_info_destroy_rcu %px\n", f6i);
  }
  EXPORT_SYMBOL_GPL(fib6_info_destroy_rcu);

@@ -1486,8 +1489,10 @@ int fib6_add(struct fib6_node *root, struct 
fib6_info *rt,
  			list_add(&rt->nh_list, &rt->nh->f6i_list);
  		__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));

-		if (fib6_has_expires(rt))
+		if (fib6_has_expires(rt)) {
  			hlist_add_head(&rt->gc_link, &table->tb6_gc_hlist);
+			printk(KERN_CRIT "fib6_add: add %px to gc list %px pprev %px next 
%px\n", rt, &rt->gc_link, rt->gc_link.pprev, rt->gc_link.next);
+		}

  		fib6_start_gc(info->nl_net, rt);
  	}
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b132feae3393..52283a80f79e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -935,6 +935,8 @@ int rt6_route_rcv(struct net_device *dev, u8 *opt, 
int len,
  	unsigned long lifetime;
  	struct fib6_info *rt;

+	printk(KERN_CRIT "rt6_route_rcv\n");
+
  	if (len < sizeof(struct route_info)) {
  		return -EINVAL;
  	}
@@ -989,12 +991,15 @@ int rt6_route_rcv(struct net_device *dev, u8 *opt, 
int len,
  				 (rt->fib6_flags & ~RTF_PREF_MASK) | RTF_PREF(pref);

  	if (rt) {
+		printk(KERN_CRIT "rt6_route_rcv: route info %px, sleep 3s\n", rt);
+		mdelay(3000);
  		if (!addrconf_finite_timeout(lifetime))
  			fib6_clean_expires(rt);
  		else
  			fib6_set_expires(rt, jiffies + HZ * lifetime);

  		fib6_info_release(rt);
+		printk(KERN_CRIT "rt6_route_rcv: route info %px, after release\n", rt);
  	}
  	return 0;
  }
@@ -1297,6 +1302,9 @@ static int __ip6_ins_rt(struct fib6_info *rt, 
struct nl_info *info,
  {
  	int err;
  	struct fib6_table *table;
+	if (rt)
+		printk(KERN_CRIT "__ip6_ins_rt %pI6c/%d\n",
+		       &rt->fib6_dst.addr, rt->fib6_dst.plen);

  	table = rt->fib6_table;
  	spin_lock_bh(&table->tb6_lock);
@@ -3855,6 +3863,9 @@ static int __ip6_del_rt(struct fib6_info *rt, 
struct nl_info *info)
  	struct net *net = info->nl_net;
  	struct fib6_table *table;
  	int err;
+	if (rt)
+		printk(KERN_CRIT "__ip6_del_rt %pI6c/%d\n",
+		       &rt->fib6_dst.addr, rt->fib6_dst.plen);

  	if (rt == net->ipv6.fib6_null_entry) {
  		err = -ENOENT;
@@ -4345,8 +4356,10 @@ struct fib6_info *rt6_get_dflt_router(struct net 
*net,
  		    ipv6_addr_equal(&nh->fib_nh_gw6, addr))
  			break;
  	}
-	if (rt && !fib6_info_hold_safe(rt))
+	if (rt && !fib6_info_hold_safe(rt)) {
  		rt = NULL;
+	}
+	printk(KERN_CRIT "rt = %px\n", rt);
  	rcu_read_unlock();
  	return rt;
  }

