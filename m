Return-Path: <netdev+bounces-272267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDUEOO+wxWlrAwUAu9opvQ
	(envelope-from <netdev+bounces-272267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:19:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0B933C4AD
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 23:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E74F301F4AC
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 22:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAD131F988;
	Thu, 26 Mar 2026 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TR9hJYiw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05072FDC2C;
	Thu, 26 Mar 2026 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563387; cv=none; b=aQt2CP0DMtc21qyD55Ha3M1MX9bt+FP+hUSfX18YTjr1Ggoeof0Ke8osv4d5RqxScxDmY+I+Vyew09cMYKR7uxXQhybIBEWcWaxzHocG29kx96Tmz4TYU2m3vmv6o2DclXuVhLmyDl3NWOP1La4P3aydcVMjK32ybGDF5WzCSUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563387; c=relaxed/simple;
	bh=YOSJL3ZbWWzth1tihGZMzEyUwAdDEdd4LPoVWKuEock=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYV6Wd6/BgFZZx81rXUlEkYQTcsBe4c+phTqsRTBIpvSiE1Gc1S7JOWnAx/zkvq2O8Cw3U70Y8HU5cybKfBTmhEJrcmWWplL2xpIwRY6A73tyKcKVORTEbJDJzUrVGHt6IQuDT9VKnh6/cHTMF9F7weuMU3ryca2iR1HOGSlCtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TR9hJYiw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774563386; x=1806099386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YOSJL3ZbWWzth1tihGZMzEyUwAdDEdd4LPoVWKuEock=;
  b=TR9hJYiwM6hcRK/s6CJmNHC9jmtQOhjLhv0xjftcQyq7gIEa35IbuxQZ
   TaETFecGF85NZVO0j3ApgSGQggDf5Ty3vyhs/VDYdOwGInkn+edkgsGQD
   pUQ/frcRaQjGMDZZ24RAZxzJoMDa/U1hC+U0YA6blHhUIwD89KVP1vWy+
   a490LiZqkkD4HixXnw3XQI5gDOSTxJMJmt/aKrCZcYVSKMCXAbSJFt7M5
   UPSQjanoFF0adfDe4i0Er8Attj1EJz5EW6HsY1FX8Ceu0HGddXz3QE4e/
   FFEVz84hOlf0BHDq7GN7KrbJOwyvg18sS5oKbtPy3GZgrzwHcp0p+eW/V
   A==;
X-CSE-ConnectionGUID: IQeULMkMQ0S8oLcp0WO65w==
X-CSE-MsgGUID: V/A7zVldT6OML1k56ZTv1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75749407"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75749407"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 15:16:25 -0700
X-CSE-ConnectionGUID: Dip07NFMROe6r/pQ9wVM7w==
X-CSE-MsgGUID: LRo6rxZ5QYKkYzaB4fTlFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="225389378"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Mar 2026 15:16:21 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5szy-000000009Qn-2XtG;
	Thu, 26 Mar 2026 22:16:18 +0000
Date: Fri, 27 Mar 2026 06:16:04 +0800
From: kernel test robot <lkp@intel.com>
To: luka.gejak@linux.dev, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, horms@kernel.org,
	fmaurer@redhat.com, liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org, Luka Gejak <luka.gejak@linux.dev>
Subject: Re: [PATCH net-next v1 2/7] net: hsr: replace fallthrough comments
 with fallthrough macro
Message-ID: <202603270658.FJCTgZee-lkp@intel.com>
References: <20260324144630.189094-3-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324144630.189094-3-luka.gejak@linux.dev>
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272267-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,redhat.com,gmail.com,vger.kernel.org,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: 6B0B933C4AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/luka-gejak-linux-dev/net-hsr-constify-hsr_ops-and-prp_ops-protocol-operation-structures/20260326-143638
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260324144630.189094-3-luka.gejak%40linux.dev
patch subject: [PATCH net-next v1 2/7] net: hsr: replace fallthrough comments with fallthrough macro
config: i386-randconfig-001-20260327 (https://download.01.org/0day-ci/archive/20260327/202603270658.FJCTgZee-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603270658.FJCTgZee-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603270658.FJCTgZee-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/hsr/hsr_netlink.c:436:2: error: fallthrough annotation is outside switch statement
     436 |         fallthrough;
         |         ^
   include/linux/compiler_attributes.h:214:56: note: expanded from macro 'fallthrough'
     214 | # define fallthrough                    __attribute__((__fallthrough__))
         |                                                        ^
   net/hsr/hsr_netlink.c:527:2: error: fallthrough annotation is outside switch statement
     527 |         fallthrough;
         |         ^
   include/linux/compiler_attributes.h:214:56: note: expanded from macro 'fallthrough'
     214 | # define fallthrough                    __attribute__((__fallthrough__))
         |                                                        ^
   2 errors generated.


vim +436 net/hsr/hsr_netlink.c

   300	
   301	/* HSR_C_GET_NODE_STATUS lets userspace query the internal HSR node table
   302	 * about the status of a specific node in the network, defined by its MAC
   303	 * address.
   304	 *
   305	 * Input: hsr ifindex, node mac address
   306	 * Output: hsr ifindex, node mac address (copied from request),
   307	 *	   age of latest frame from node over slave 1, slave 2 [ms]
   308	 */
   309	static int hsr_get_node_status(struct sk_buff *skb_in, struct genl_info *info)
   310	{
   311		/* For receiving */
   312		struct nlattr *na;
   313		struct net_device *hsr_dev;
   314	
   315		/* For sending */
   316		struct sk_buff *skb_out;
   317		void *msg_head;
   318		struct hsr_priv *hsr;
   319		struct hsr_port *port;
   320		unsigned char hsr_node_addr_b[ETH_ALEN];
   321		int hsr_node_if1_age;
   322		u16 hsr_node_if1_seq;
   323		int hsr_node_if2_age;
   324		u16 hsr_node_if2_seq;
   325		int addr_b_ifindex;
   326		int res;
   327	
   328		if (!info)
   329			goto invalid;
   330	
   331		na = info->attrs[HSR_A_IFINDEX];
   332		if (!na)
   333			goto invalid;
   334		na = info->attrs[HSR_A_NODE_ADDR];
   335		if (!na)
   336			goto invalid;
   337	
   338		rcu_read_lock();
   339		hsr_dev = dev_get_by_index_rcu(genl_info_net(info),
   340					       nla_get_u32(info->attrs[HSR_A_IFINDEX]));
   341		if (!hsr_dev)
   342			goto rcu_unlock;
   343		if (!is_hsr_master(hsr_dev))
   344			goto rcu_unlock;
   345	
   346		/* Send reply */
   347		skb_out = genlmsg_new(NLMSG_GOODSIZE, GFP_ATOMIC);
   348		if (!skb_out) {
   349			res = -ENOMEM;
   350			goto fail;
   351		}
   352	
   353		msg_head = genlmsg_put(skb_out, NETLINK_CB(skb_in).portid,
   354				       info->snd_seq, &hsr_genl_family, 0,
   355				       HSR_C_SET_NODE_STATUS);
   356		if (!msg_head) {
   357			res = -ENOMEM;
   358			goto nla_put_failure;
   359		}
   360	
   361		res = nla_put_u32(skb_out, HSR_A_IFINDEX, hsr_dev->ifindex);
   362		if (res < 0)
   363			goto nla_put_failure;
   364	
   365		hsr = netdev_priv(hsr_dev);
   366		res = hsr_get_node_data(hsr,
   367					(unsigned char *)
   368					nla_data(info->attrs[HSR_A_NODE_ADDR]),
   369						 hsr_node_addr_b,
   370						 &addr_b_ifindex,
   371						 &hsr_node_if1_age,
   372						 &hsr_node_if1_seq,
   373						 &hsr_node_if2_age,
   374						 &hsr_node_if2_seq);
   375		if (res < 0)
   376			goto nla_put_failure;
   377	
   378		res = nla_put(skb_out, HSR_A_NODE_ADDR, ETH_ALEN,
   379			      nla_data(info->attrs[HSR_A_NODE_ADDR]));
   380		if (res < 0)
   381			goto nla_put_failure;
   382	
   383		if (addr_b_ifindex > -1) {
   384			res = nla_put(skb_out, HSR_A_NODE_ADDR_B, ETH_ALEN,
   385				      hsr_node_addr_b);
   386			if (res < 0)
   387				goto nla_put_failure;
   388	
   389			res = nla_put_u32(skb_out, HSR_A_ADDR_B_IFINDEX,
   390					  addr_b_ifindex);
   391			if (res < 0)
   392				goto nla_put_failure;
   393		}
   394	
   395		res = nla_put_u32(skb_out, HSR_A_IF1_AGE, hsr_node_if1_age);
   396		if (res < 0)
   397			goto nla_put_failure;
   398		res = nla_put_u16(skb_out, HSR_A_IF1_SEQ, hsr_node_if1_seq);
   399		if (res < 0)
   400			goto nla_put_failure;
   401		port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_A);
   402		if (port)
   403			res = nla_put_u32(skb_out, HSR_A_IF1_IFINDEX,
   404					  port->dev->ifindex);
   405		if (res < 0)
   406			goto nla_put_failure;
   407	
   408		res = nla_put_u32(skb_out, HSR_A_IF2_AGE, hsr_node_if2_age);
   409		if (res < 0)
   410			goto nla_put_failure;
   411		res = nla_put_u16(skb_out, HSR_A_IF2_SEQ, hsr_node_if2_seq);
   412		if (res < 0)
   413			goto nla_put_failure;
   414		port = hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
   415		if (port)
   416			res = nla_put_u32(skb_out, HSR_A_IF2_IFINDEX,
   417					  port->dev->ifindex);
   418		if (res < 0)
   419			goto nla_put_failure;
   420	
   421		rcu_read_unlock();
   422	
   423		genlmsg_end(skb_out, msg_head);
   424		genlmsg_unicast(genl_info_net(info), skb_out, info->snd_portid);
   425	
   426		return 0;
   427	
   428	rcu_unlock:
   429		rcu_read_unlock();
   430	invalid:
   431		netlink_ack(skb_in, nlmsg_hdr(skb_in), -EINVAL, NULL);
   432		return 0;
   433	
   434	nla_put_failure:
   435		kfree_skb(skb_out);
 > 436		fallthrough;
   437	
   438	fail:
   439		rcu_read_unlock();
   440		return res;
   441	}
   442	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

