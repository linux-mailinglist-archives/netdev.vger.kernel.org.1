Return-Path: <netdev+bounces-257281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPInAJTahGna5wMAu9opvQ
	(envelope-from <netdev+bounces-257281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:59:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A188F6429
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 18:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F2EA302E911
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 17:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1733033CB;
	Thu,  5 Feb 2026 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRSPxXPy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5733033C8;
	Thu,  5 Feb 2026 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314368; cv=none; b=qKJEFSwAvpkuXgyf2MW3alNVlkj6OvzhE9djbg/QfcwLlYL1jugoF8cMpNs2PoSNfpTLNLpeqTzqPXsvWVCThTu8BZF3FsmtiWgHB5zoTvFobs6pF6blOmJ66w4wWt82xvcD/daMgi7xkrSHvAVpVLAnF+dr2KY5VUGWAhzY0gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314368; c=relaxed/simple;
	bh=NhzhwITI9ZBOqgCkCO1eRGUL4UGRqOM83DHf5ZgY1ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRfDtRPpsvELsKhuAnNbFjzmbCS1ly/kwcvSMP4zF9lgs/s1vrSFKQkao446m0gQ04a0DJPOi0cZ7ccu/2juORTvW+oEeQ51HwcdE91DiwPklGeLe+cxFeJiAiJtmySNUvowRLCIdB4sE5SM/4jRcd3Q1VOfR+ArFxT8wH93t8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRSPxXPy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770314368; x=1801850368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NhzhwITI9ZBOqgCkCO1eRGUL4UGRqOM83DHf5ZgY1ds=;
  b=lRSPxXPya21uDhJ1tPfp1UNFSt35mQKqpxsvIGgyQAxAlfQnDkvPuGFp
   wljR2DUojZBuE2w/Q8LED1NCAjF7LwWBLSEW3dTmas//4VZB9abaGZrJi
   13RZoDbMMe8/7+IeEdMgq00x4JP2L8r7vpR9tlbGS0mv+VN2zoH71IpEk
   Ar8NMNcMS+ia/0h2qql+GZSKfwZXI0GlT7dYoK2cG8WJ2I0Hnl53OwY28
   FfWk1Mwf0qF6agvS3bvHO+B6vTwDDlQMd/dgIVa5U754pUtyjo+uDuv3P
   rLAuOfsRQ2gKenSTtEq0Lz9QIX9xfgLVSc6NI/9Ogtn/BTsdWOJeHTPCm
   g==;
X-CSE-ConnectionGUID: aVzHUc9tQgmjh1YWv6as3A==
X-CSE-MsgGUID: qrRH0wnYRre2VF6yJan8sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="70714607"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="70714607"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 09:59:27 -0800
X-CSE-ConnectionGUID: AMadNLnoR8imejMCY6honQ==
X-CSE-MsgGUID: MjlpLEqHQce48LJ0uGeHOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="210569208"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Feb 2026 09:59:24 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vo3dS-00000000k5C-1E0r;
	Thu, 05 Feb 2026 17:59:22 +0000
Date: Fri, 6 Feb 2026 01:58:32 +0800
From: kernel test robot <lkp@intel.com>
To: Feng Yang <yangfeng59949@163.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bpf: test_run: Fix the null pointer dereference issue
 in bpf_lwt_xmit_push_encap
Message-ID: <202602060101.PefMJeTB-lkp@intel.com>
References: <20260205092227.126665-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205092227.126665-1-yangfeng59949@163.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257281-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[163.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,bpf_test_run_lwt_xmit_dst.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url,git-scm.com:url]
X-Rspamd-Queue-Id: 4A188F6429
X-Rspamd-Action: no action

Hi Feng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bpf-next/net]
[also build test WARNING on bpf-next/master bpf/master net-next/main net/main linus/master v6.19-rc8 next-20260205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Feng-Yang/bpf-test_run-Fix-the-null-pointer-dereference-issue-in-bpf_lwt_xmit_push_encap/20260205-172527
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git net
patch link:    https://lore.kernel.org/r/20260205092227.126665-1-yangfeng59949%40163.com
patch subject: [PATCH v2] bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
config: hexagon-randconfig-r132-20260205 (https://download.01.org/0day-ci/archive/20260206/202602060101.PefMJeTB-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260206/202602060101.PefMJeTB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602060101.PefMJeTB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/bpf/test_run.c:617:18: sparse: sparse: symbol 'bpf_kfunc_call_test_release_dtor' was not declared. Should it be static?
   net/bpf/test_run.c:627:18: sparse: sparse: symbol 'bpf_kfunc_call_memb_release_dtor' was not declared. Should it be static?
>> net/bpf/test_run.c:984:18: sparse: sparse: symbol 'bpf_test_run_lwt_xmit_dst' was not declared. Should it be static?

vim +/bpf_test_run_lwt_xmit_dst +984 net/bpf/test_run.c

   983	
 > 984	struct dst_entry bpf_test_run_lwt_xmit_dst;
   985	int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
   986				  union bpf_attr __user *uattr)
   987	{
   988		bool is_l2 = false, is_direct_pkt_access = false, is_lwt = false;
   989		u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
   990		struct net *net = current->nsproxy->net_ns;
   991		struct net_device *dev = net->loopback_dev;
   992		u32 headroom = NET_SKB_PAD + NET_IP_ALIGN;
   993		u32 linear_sz = kattr->test.data_size_in;
   994		u32 repeat = kattr->test.repeat;
   995		struct __sk_buff *ctx = NULL;
   996		struct sk_buff *skb = NULL;
   997		struct sock *sk = NULL;
   998		u32 retval, duration;
   999		int hh_len = ETH_HLEN;
  1000		void *data = NULL;
  1001		int ret;
  1002	
  1003		if ((kattr->test.flags & ~BPF_F_TEST_SKB_CHECKSUM_COMPLETE) ||
  1004		    kattr->test.cpu || kattr->test.batch_size)
  1005			return -EINVAL;
  1006	
  1007		if (kattr->test.data_size_in < ETH_HLEN)
  1008			return -EINVAL;
  1009	
  1010		switch (prog->type) {
  1011		case BPF_PROG_TYPE_SCHED_CLS:
  1012		case BPF_PROG_TYPE_SCHED_ACT:
  1013			is_direct_pkt_access = true;
  1014			is_l2 = true;
  1015			break;
  1016		case BPF_PROG_TYPE_LWT_IN:
  1017		case BPF_PROG_TYPE_LWT_OUT:
  1018		case BPF_PROG_TYPE_LWT_XMIT:
  1019			is_lwt = true;
  1020			fallthrough;
  1021		case BPF_PROG_TYPE_CGROUP_SKB:
  1022			is_direct_pkt_access = true;
  1023			break;
  1024		default:
  1025			break;
  1026		}
  1027	
  1028		ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
  1029		if (IS_ERR(ctx))
  1030			return PTR_ERR(ctx);
  1031	
  1032		if (ctx) {
  1033			if (ctx->data_end > kattr->test.data_size_in || ctx->data || ctx->data_meta) {
  1034				ret = -EINVAL;
  1035				goto out;
  1036			}
  1037			if (ctx->data_end) {
  1038				/* Non-linear LWT test_run is unsupported for now. */
  1039				if (is_lwt) {
  1040					ret = -EINVAL;
  1041					goto out;
  1042				}
  1043				linear_sz = max(ETH_HLEN, ctx->data_end);
  1044			}
  1045		}
  1046	
  1047		linear_sz = min_t(u32, linear_sz, PAGE_SIZE - headroom - tailroom);
  1048	
  1049		data = bpf_test_init(kattr, linear_sz, linear_sz, headroom, tailroom);
  1050		if (IS_ERR(data)) {
  1051			ret = PTR_ERR(data);
  1052			data = NULL;
  1053			goto out;
  1054		}
  1055	
  1056		sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
  1057		if (!sk) {
  1058			ret = -ENOMEM;
  1059			goto out;
  1060		}
  1061		sock_init_data(NULL, sk);
  1062	
  1063		skb = slab_build_skb(data);
  1064		if (!skb) {
  1065			ret = -ENOMEM;
  1066			goto out;
  1067		}
  1068		skb->sk = sk;
  1069	
  1070		data = NULL; /* data released via kfree_skb */
  1071	
  1072		skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
  1073		__skb_put(skb, linear_sz);
  1074	
  1075		if (unlikely(kattr->test.data_size_in > linear_sz)) {
  1076			void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
  1077			struct skb_shared_info *sinfo = skb_shinfo(skb);
  1078			u32 copied = linear_sz;
  1079	
  1080			while (copied < kattr->test.data_size_in) {
  1081				struct page *page;
  1082				u32 data_len;
  1083	
  1084				if (sinfo->nr_frags == MAX_SKB_FRAGS) {
  1085					ret = -ENOMEM;
  1086					goto out;
  1087				}
  1088	
  1089				page = alloc_page(GFP_KERNEL);
  1090				if (!page) {
  1091					ret = -ENOMEM;
  1092					goto out;
  1093				}
  1094	
  1095				data_len = min_t(u32, kattr->test.data_size_in - copied,
  1096						 PAGE_SIZE);
  1097				skb_fill_page_desc(skb, sinfo->nr_frags, page, 0, data_len);
  1098	
  1099				if (copy_from_user(page_address(page), data_in + copied,
  1100						   data_len)) {
  1101					ret = -EFAULT;
  1102					goto out;
  1103				}
  1104				skb->data_len += data_len;
  1105				skb->truesize += PAGE_SIZE;
  1106				skb->len += data_len;
  1107				copied += data_len;
  1108			}
  1109		}
  1110	
  1111		if (ctx && ctx->ifindex > 1) {
  1112			dev = dev_get_by_index(net, ctx->ifindex);
  1113			if (!dev) {
  1114				ret = -ENODEV;
  1115				goto out;
  1116			}
  1117		}
  1118		skb->protocol = eth_type_trans(skb, dev);
  1119		skb_reset_network_header(skb);
  1120	
  1121		switch (skb->protocol) {
  1122		case htons(ETH_P_IP):
  1123			sk->sk_family = AF_INET;
  1124			if (sizeof(struct iphdr) <= skb_headlen(skb)) {
  1125				sk->sk_rcv_saddr = ip_hdr(skb)->saddr;
  1126				sk->sk_daddr = ip_hdr(skb)->daddr;
  1127			}
  1128			break;
  1129	#if IS_ENABLED(CONFIG_IPV6)
  1130		case htons(ETH_P_IPV6):
  1131			sk->sk_family = AF_INET6;
  1132			if (sizeof(struct ipv6hdr) <= skb_headlen(skb)) {
  1133				sk->sk_v6_rcv_saddr = ipv6_hdr(skb)->saddr;
  1134				sk->sk_v6_daddr = ipv6_hdr(skb)->daddr;
  1135			}
  1136			break;
  1137	#endif
  1138		default:
  1139			break;
  1140		}
  1141	
  1142		if (is_l2)
  1143			__skb_push(skb, hh_len);
  1144		if (is_direct_pkt_access)
  1145			bpf_compute_data_pointers(skb);
  1146	
  1147		ret = convert___skb_to_skb(skb, ctx);
  1148		if (ret)
  1149			goto out;
  1150	
  1151		if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
  1152			const int off = skb_network_offset(skb);
  1153			int len = skb->len - off;
  1154	
  1155			skb->csum = skb_checksum(skb, off, len, 0);
  1156			skb->ip_summed = CHECKSUM_COMPLETE;
  1157		}
  1158	
  1159		if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
  1160			bpf_test_run_lwt_xmit_dst.dev = dev;
  1161			skb_dst_set(skb, &bpf_test_run_lwt_xmit_dst);
  1162		}
  1163		ret = bpf_test_run(prog, skb, repeat, &retval, &duration, false);
  1164		if (prog->type == BPF_PROG_TYPE_LWT_XMIT)
  1165			skb_dst_set(skb, NULL);
  1166		if (ret)
  1167			goto out;
  1168		if (!is_l2) {
  1169			if (skb_headroom(skb) < hh_len) {
  1170				int nhead = HH_DATA_ALIGN(hh_len - skb_headroom(skb));
  1171	
  1172				if (pskb_expand_head(skb, nhead, 0, GFP_USER)) {
  1173					ret = -ENOMEM;
  1174					goto out;
  1175				}
  1176			}
  1177			memset(__skb_push(skb, hh_len), 0, hh_len);
  1178		}
  1179	
  1180		if (kattr->test.flags & BPF_F_TEST_SKB_CHECKSUM_COMPLETE) {
  1181			const int off = skb_network_offset(skb);
  1182			int len = skb->len - off;
  1183			__wsum csum;
  1184	
  1185			csum = skb_checksum(skb, off, len, 0);
  1186	
  1187			if (csum_fold(skb->csum) != csum_fold(csum)) {
  1188				ret = -EBADMSG;
  1189				goto out;
  1190			}
  1191		}
  1192	
  1193		convert_skb_to___skb(skb, ctx);
  1194	
  1195		if (skb_is_nonlinear(skb))
  1196			/* bpf program can never convert linear skb to non-linear */
  1197			WARN_ON_ONCE(linear_sz == kattr->test.data_size_in);
  1198		ret = bpf_test_finish(kattr, uattr, skb->data, skb_shinfo(skb), skb->len,
  1199				      skb->data_len, retval, duration);
  1200		if (!ret)
  1201			ret = bpf_ctx_finish(kattr, uattr, ctx,
  1202					     sizeof(struct __sk_buff));
  1203	out:
  1204		if (dev && dev != net->loopback_dev)
  1205			dev_put(dev);
  1206		kfree_skb(skb);
  1207		kfree(data);
  1208		if (sk)
  1209			sk_free(sk);
  1210		kfree(ctx);
  1211		return ret;
  1212	}
  1213	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

