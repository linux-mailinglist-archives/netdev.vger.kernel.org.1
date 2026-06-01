Return-Path: <netdev+bounces-293858-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ8GIJDHHWrgdwkAu9opvQ
	(envelope-from <netdev+bounces-293858-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:55:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F40AD6238CB
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 19:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF69C306A63F
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 17:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1B63E0C78;
	Mon,  1 Jun 2026 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1XqAMxD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BA23E1220
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336405; cv=none; b=aswfsSgeRVBVK1Xp+IdrfVOvzjAGW9w/7tsCZsl7NzXs9kzVOtbfgwkyWfDH5ENYoKXvhzaYjlIv4gNX+KMQy1RBsmO9QObCNnhXQ57Ms2yzsVCSQLg7fkyMVoglXA4nqsQljS6qvE1yPUTHlFme+vK0mYmJE2M29H3EwDiNthY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336405; c=relaxed/simple;
	bh=WRfOe0RWs25AtPRCRm97YZQP2oRBirOhTTiBl3XaWC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LT5OztpDSbg/EZvmYLE7ldqigaURRPQN05MiQQ5WBBh+a1l+BA0U0mAbVk3zUk1wAdJAYrCYCHLE+uYbCdORJjGAu+SRylKSjJpSTX9lkfrxtuYM9mU/PgMiY06s8td2F4U9G78AGywkBJrO8/Po9iMkuGCkqXvdAWzZbPWPN4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1XqAMxD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780336401; x=1811872401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WRfOe0RWs25AtPRCRm97YZQP2oRBirOhTTiBl3XaWC8=;
  b=a1XqAMxDZYkWZIeB2nkdmcl34nE0jMw3+LgJSsQp3fBOiuoK4Y4c4zNs
   HisetbwsbYQelD8sJYck/VzGl3vFwFduPEtXrrpp3SzzDrgg8wnzSGDx8
   t0TggmwZeiLEC8/pYj9jFxUnxhECxeYnWG7cQAymgkfxH9L46RBOxfIUT
   b2cV9wIXRtoXrAwMdILRkqR1UaIcotfpblo/aLjYwvVgRc9tmNFSNWbOY
   KrP4Gl6dOEUwR+ivpWyjRlhx0WNnO7ohz4qXdaZVOksrvgSoN4tz5GD7v
   1nsMxFYa0qeP+A5eReIX6CKp451+j5ohLFZ3z7gek+XaJ7QrDY5fa+zgy
   g==;
X-CSE-ConnectionGUID: oNG2zrYoRgyeWD4zvzlESg==
X-CSE-MsgGUID: KEQH91sBT2G3J5Fh80uLyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81163601"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="81163601"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 10:53:20 -0700
X-CSE-ConnectionGUID: eu1U6JSdTVKqz656e67pYg==
X-CSE-MsgGUID: HPjciOlzT461v4RZYqQE+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="241136374"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa008.fm.intel.com with ESMTP; 01 Jun 2026 10:53:16 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wU6p8-000000001cP-34OC;
	Mon, 01 Jun 2026 17:53:14 +0000
Date: Mon, 1 Jun 2026 19:52:58 +0200
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next] mptcp: change mptcp_established_options() to
 return opt_size
Message-ID: <202606011921.XxnF0IB7-lkp@intel.com>
References: <20260601091816.444738-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601091816.444738-1-edumazet@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lists.linux.dev,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-293858-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,01.org:url,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: F40AD6238CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/mptcp-change-mptcp_established_options-to-return-opt_size/20260601-174435
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260601091816.444738-1-edumazet%40google.com
patch subject: [PATCH net-next] mptcp: change mptcp_established_options() to return opt_size
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260601/202606011921.XxnF0IB7-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260601/202606011921.XxnF0IB7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606011921.XxnF0IB7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/ipv4/tcp_output.c:1187:24: error: too few arguments to function call, expected 5, have 4
    1186 |                 opt_size = mptcp_established_options(sk, skb, remaining,
         |                            ~~~~~~~~~~~~~~~~~~~~~~~~~
    1187 |                                                      &opts->mptcp);
         |                                                                  ^
   include/net/mptcp.h:269:19: note: 'mptcp_established_options' declared here
     269 | static inline int mptcp_established_options(struct sock *sk,
         |                   ^                         ~~~~~~~~~~~~~~~~
     270 |                                             struct sk_buff *skb,
         |                                             ~~~~~~~~~~~~~~~~~~~~
     271 |                                             unsigned int *size,
         |                                             ~~~~~~~~~~~~~~~~~~~
     272 |                                             unsigned int remaining,
         |                                             ~~~~~~~~~~~~~~~~~~~~~~~
     273 |                                             struct mptcp_out_options *opts)
         |                                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +1187 net/ipv4/tcp_output.c

  1145	
  1146	/* Compute TCP options for ESTABLISHED sockets. This is not the
  1147	 * final wire format yet.
  1148	 */
  1149	static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb,
  1150						struct tcp_out_options *opts,
  1151						struct tcp_key *key)
  1152	{
  1153		struct tcp_sock *tp = tcp_sk(sk);
  1154		unsigned int size = 0;
  1155		unsigned int eff_sacks;
  1156	
  1157		opts->options = 0;
  1158	
  1159		/* Better than switch (key.type) as it has static branches */
  1160		if (tcp_key_is_md5(key)) {
  1161			opts->options |= OPTION_MD5;
  1162			size += TCPOLEN_MD5SIG_ALIGNED;
  1163		} else if (tcp_key_is_ao(key)) {
  1164			opts->options |= OPTION_AO;
  1165			size += tcp_ao_len_aligned(key->ao_key);
  1166		}
  1167	
  1168		if (likely(tp->rx_opt.tstamp_ok)) {
  1169			opts->options |= OPTION_TS;
  1170			opts->tsval = skb ? tcp_skb_timestamp_ts(tp->tcp_usec_ts, skb) +
  1171					tp->tsoffset : 0;
  1172			opts->tsecr = tp->rx_opt.ts_recent;
  1173			size += TCPOLEN_TSTAMP_ALIGNED;
  1174		}
  1175	
  1176		/* MPTCP options have precedence over SACK for the limited TCP
  1177		 * option space because a MPTCP connection would be forced to
  1178		 * fall back to regular TCP if a required multipath option is
  1179		 * missing. SACK still gets a chance to use whatever space is
  1180		 * left.
  1181		 */
  1182		if (sk_is_mptcp(sk)) {
  1183			unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
  1184			int opt_size;
  1185	
  1186			opt_size = mptcp_established_options(sk, skb, remaining,
> 1187							     &opts->mptcp);
  1188			if (opt_size >= 0) {
  1189				opts->options |= OPTION_MPTCP;
  1190				size += opt_size;
  1191			}
  1192		}
  1193	
  1194		eff_sacks = tp->rx_opt.num_sacks + tp->rx_opt.dsack;
  1195		if (unlikely(eff_sacks)) {
  1196			const unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
  1197			if (likely(remaining >= TCPOLEN_SACK_BASE_ALIGNED +
  1198						TCPOLEN_SACK_PERBLOCK)) {
  1199				opts->num_sack_blocks =
  1200					min_t(unsigned int, eff_sacks,
  1201					      (remaining - TCPOLEN_SACK_BASE_ALIGNED) /
  1202					      TCPOLEN_SACK_PERBLOCK);
  1203	
  1204				size += TCPOLEN_SACK_BASE_ALIGNED +
  1205					opts->num_sack_blocks * TCPOLEN_SACK_PERBLOCK;
  1206			} else {
  1207				opts->num_sack_blocks = 0;
  1208			}
  1209		} else {
  1210			opts->num_sack_blocks = 0;
  1211		}
  1212	
  1213		if (tcp_ecn_mode_accecn(tp)) {
  1214			int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
  1215	
  1216			if (ecn_opt && tp->saw_accecn_opt &&
  1217			    (ecn_opt >= TCP_ACCECN_OPTION_PERSIST ||
  1218			     !tcp_accecn_opt_fail_send(tp)) &&
  1219			    (ecn_opt >= TCP_ACCECN_OPTION_FULL || tp->accecn_opt_demand ||
  1220			     tcp_accecn_option_beacon_check(sk))) {
  1221				opts->use_synack_ecn_bytes = 0;
  1222				size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
  1223							       MAX_TCP_OPTION_SPACE - size);
  1224			}
  1225		}
  1226	
  1227		if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
  1228						    BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG))) {
  1229			unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
  1230	
  1231			bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts, &remaining);
  1232	
  1233			size = MAX_TCP_OPTION_SPACE - remaining;
  1234		}
  1235	
  1236		return size;
  1237	}
  1238	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

