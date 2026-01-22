Return-Path: <netdev+bounces-252235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gESjOGjacWk+MgAAu9opvQ
	(envelope-from <netdev+bounces-252235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:06:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED4262D68
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B74DD7A22A5
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 07:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65134350291;
	Thu, 22 Jan 2026 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GgNnH/HN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AEE30596D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769068491; cv=none; b=g2yMTdJH5J67yWsc+4ct+JL3WRZTsLaraF3bIqHs6I0ye84C+FZelYGk9vcbRuUWuDRe5LYbV6ZW51IV9+WqK0VkYsTU544hyUN+HnYRlJzCSt7Zd22QtNLac7hizxeQnXbzRVhm2SESeN67vE0L5iXXjBoKc/5bspSsMG6Wxgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769068491; c=relaxed/simple;
	bh=nyMGeoOkL0QdzBs/NrnaOdhm6/U4oVNKyz0gPRixEf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxmlorAP+CAbSiC89poCfeD6VddngsmC7PMnyA58QPFIX90yrF3+5G+wFX3kb8CgXvJLsQi84VA0dJmJ6eHEwHbQLzrM0E/8FSAnNDVKMYmL2av2fRm9BgacVpVVtDMLO4QCCVD+/ccT0741nfm4UUISyUBazn0bfaOkGoVVa8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GgNnH/HN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769068489; x=1800604489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nyMGeoOkL0QdzBs/NrnaOdhm6/U4oVNKyz0gPRixEf0=;
  b=GgNnH/HNMZOm6w0hq9o9/HEQwC7FPMgmlwYjqicX20PpLFGWPIba6VIS
   KaNVOf8tCatHsLL8oyR84rOAVBoWL/2fignl9IoacAk5bD5eVyFkPhFiZ
   pGEX1bQm1zCOaWQjFwiyMW0lqHX37bOyUa1gGgWtZqRgoloN1+VQFCrCd
   MiPkRs4t2wVCrmlrDi0BtJuj0/z0DsJMOuDX+jUlFzE1uVvb540lZuXyJ
   XxqQC/Kfm1xKJoaPs0LzekueAWRFGj1/Ei8OwUaI1usikN5HdOJO3L1Wv
   npGdO6x8jisRAZ6QcIcjrI2AY2p6XOWOzE8XPGt76wi/ydiqWaR+iDjVo
   g==;
X-CSE-ConnectionGUID: j3Z5bUdeRaGJYxAcPLk4SA==
X-CSE-MsgGUID: /53CJO2UTpK8IdxPzYTsdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="80929094"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="80929094"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 23:54:49 -0800
X-CSE-ConnectionGUID: l7j7o6K/SImEFTiDyTJELw==
X-CSE-MsgGUID: 3NNZIlqUQO6sRj11CBolGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="205793400"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 21 Jan 2026 23:54:44 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vipWb-00000000SZd-1kBe;
	Thu, 22 Jan 2026 07:54:41 +0000
Date: Thu, 22 Jan 2026 15:54:05 +0800
From: kernel test robot <lkp@intel.com>
To: Rishikesh Jethwani <rjethwani@purestorage.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, saeedm@nvidia.com,
	tariqt@nvidia.com, mbloch@nvidia.com, borisp@nvidia.com,
	john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	leon@kernel.org, Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: Re: [PATCH v4 2/3] tls: add hardware offload key update support
Message-ID: <202601221546.bR6QG2oX-lkp@intel.com>
References: <20260121215727.3994324-3-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121215727.3994324-3-rjethwani@purestorage.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252235-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,git-scm.com:url]
X-Rspamd-Queue-Id: 6ED4262D68
X-Rspamd-Action: no action

Hi Rishikesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.19-rc6 next-20260121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rishikesh-Jethwani/tls-add-TLS-1-3-hardware-offload-support/20260122-060724
base:   linus/master
patch link:    https://lore.kernel.org/r/20260121215727.3994324-3-rjethwani%40purestorage.com
patch subject: [PATCH v4 2/3] tls: add hardware offload key update support
config: x86_64-randconfig-071-20260122 (https://download.01.org/0day-ci/archive/20260122/202601221546.bR6QG2oX-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260122/202601221546.bR6QG2oX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601221546.bR6QG2oX-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/tls/tls_device.c:1249:4: warning: 'volatile' qualifier on function type 'typeof (*sk->sk_validate_xmit_skb)' (aka 'struct sk_buff *(struct sock *, struct net_device *, struct sk_buff *)') has no effect and is a Clang extension [-Wignored-qualifiers]
    1249 |                         smp_store_release(sk->sk_validate_xmit_skb,
         |                         ^
   include/asm-generic/barrier.h:172:55: note: expanded from macro 'smp_store_release'
     172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^
   arch/x86/include/asm/barrier.h:63:2: note: expanded from macro '__smp_store_release'
      63 |         WRITE_ONCE(*p, v);                                              \
         |         ^
   include/asm-generic/rwonce.h:61:2: note: expanded from macro 'WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ^
   include/asm-generic/rwonce.h:55:4: note: expanded from macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |           ^
>> net/tls/tls_device.c:1249:4: error: non-object type 'typeof (*sk->sk_validate_xmit_skb)' (aka 'struct sk_buff *(struct sock *, struct net_device *, struct sk_buff *)') is not assignable
    1249 |                         smp_store_release(sk->sk_validate_xmit_skb,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1250 |                                    tls_validate_xmit_skb_sw);
         |                                    ~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/barrier.h:172:55: note: expanded from macro 'smp_store_release'
     172 | #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
         |                                                       ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/barrier.h:63:2: note: expanded from macro '__smp_store_release'
      63 |         WRITE_ONCE(*p, v);                                              \
         |         ^~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:61:2: note: expanded from macro 'WRITE_ONCE'
      61 |         __WRITE_ONCE(x, val);                                           \
         |         ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:55:30: note: expanded from macro '__WRITE_ONCE'
      55 |         *(volatile typeof(x) *)&(x) = (val);                            \
         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
   1 warning and 1 error generated.


vim +1249 net/tls/tls_device.c

  1086	
  1087	int tls_set_device_offload(struct sock *sk,
  1088				   struct tls_crypto_info *new_crypto_info)
  1089	{
  1090		struct tls_crypto_info *crypto_info, *src_crypto_info;
  1091		struct tls_record_info *start_marker_record;
  1092		struct tls_offload_context_tx *offload_ctx;
  1093		const struct tls_cipher_desc *cipher_desc;
  1094		struct tls_prot_info *prot;
  1095		struct net_device *netdev;
  1096		struct tls_context *ctx;
  1097		char *iv, *rec_seq;
  1098		int rc;
  1099	
  1100		ctx = tls_get_ctx(sk);
  1101		prot = &ctx->prot_info;
  1102	
  1103		/* Rekey is only supported for connections that are already
  1104		 * using HW offload. For SW offload connections, the caller
  1105		 * should fall back to tls_set_sw_offload() for rekey.
  1106		 */
  1107		if (new_crypto_info && ctx->tx_conf != TLS_HW)
  1108			return -EINVAL;
  1109	
  1110		netdev = get_netdev_for_sock(sk);
  1111		if (!netdev) {
  1112			pr_err_ratelimited("%s: netdev not found\n", __func__);
  1113			return -EINVAL;
  1114		}
  1115	
  1116		if (!(netdev->features & NETIF_F_HW_TLS_TX)) {
  1117			rc = -EOPNOTSUPP;
  1118			goto release_netdev;
  1119		}
  1120	
  1121		crypto_info = &ctx->crypto_send.info;
  1122		src_crypto_info = new_crypto_info ?: crypto_info;
  1123		if (src_crypto_info->version != TLS_1_2_VERSION &&
  1124		    src_crypto_info->version != TLS_1_3_VERSION) {
  1125			rc = -EOPNOTSUPP;
  1126			goto release_netdev;
  1127		}
  1128	
  1129		cipher_desc = get_cipher_desc(src_crypto_info->cipher_type);
  1130		if (!cipher_desc || !cipher_desc->offloadable) {
  1131			rc = -EINVAL;
  1132			goto release_netdev;
  1133		}
  1134	
  1135		iv = crypto_info_iv(src_crypto_info, cipher_desc);
  1136		rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);
  1137	
  1138		if (!new_crypto_info) {
  1139			rc = init_prot_info(prot, src_crypto_info, cipher_desc);
  1140			if (rc)
  1141				goto release_netdev;
  1142	
  1143			memcpy(ctx->tx.iv + cipher_desc->salt, iv, cipher_desc->iv);
  1144			memcpy(ctx->tx.rec_seq, rec_seq, cipher_desc->rec_seq);
  1145	
  1146			start_marker_record = kmalloc(sizeof(*start_marker_record),
  1147						      GFP_KERNEL);
  1148			if (!start_marker_record) {
  1149				rc = -ENOMEM;
  1150				goto release_netdev;
  1151			}
  1152	
  1153			offload_ctx = alloc_offload_ctx_tx(ctx);
  1154			if (!offload_ctx) {
  1155				rc = -ENOMEM;
  1156				goto free_marker_record;
  1157			}
  1158	
  1159			rc = tls_sw_fallback_init(sk, offload_ctx, src_crypto_info);
  1160			if (rc)
  1161				goto free_offload_ctx;
  1162	
  1163			start_marker_record->end_seq = tcp_sk(sk)->write_seq;
  1164			start_marker_record->len = 0;
  1165			start_marker_record->num_frags = 0;
  1166			list_add_tail(&start_marker_record->list,
  1167				      &offload_ctx->records_list);
  1168	
  1169			clean_acked_data_enable(tcp_sk(sk), &tls_tcp_clean_acked);
  1170			ctx->push_pending_record = tls_device_push_pending_record;
  1171	
  1172			/* TLS offload is greatly simplified if we don't send
  1173			 * SKBs where only part of the payload needs to be encrypted.
  1174			 * So mark the last skb in the write queue as end of record.
  1175			 */
  1176			tcp_write_collapse_fence(sk);
  1177		}
  1178	
  1179		/* Avoid offloading if the device is down
  1180		 * We don't want to offload new flows after
  1181		 * the NETDEV_DOWN event
  1182		 *
  1183		 * device_offload_lock is taken in tls_devices's NETDEV_DOWN
  1184		 * handler thus protecting from the device going down before
  1185		 * ctx was added to tls_device_list.
  1186		 */
  1187		down_read(&device_offload_lock);
  1188		if (!(netdev->flags & IFF_UP)) {
  1189			rc = -EINVAL;
  1190			goto release_lock;
  1191		}
  1192	
  1193		if (!new_crypto_info) {
  1194			ctx->priv_ctx_tx = offload_ctx;
  1195		} else {
  1196			char *key = crypto_info_key(src_crypto_info, cipher_desc);
  1197	
  1198			offload_ctx = tls_offload_ctx_tx(ctx);
  1199	
  1200			rc = crypto_aead_setkey(offload_ctx->aead_send, key,
  1201						cipher_desc->key);
  1202			if (rc)
  1203				goto release_lock;
  1204	
  1205			/* For rekey, delete old HW context before adding new one. */
  1206			if (!test_bit(TLS_TX_DEV_CLOSED, &ctx->flags))
  1207				netdev->tlsdev_ops->tls_dev_del(netdev, ctx,
  1208								TLS_OFFLOAD_CTX_DIR_TX);
  1209		}
  1210	
  1211		rc = netdev->tlsdev_ops->tls_dev_add(netdev, sk, TLS_OFFLOAD_CTX_DIR_TX,
  1212						     src_crypto_info,
  1213						     tcp_sk(sk)->write_seq);
  1214		trace_tls_device_offload_set(sk, TLS_OFFLOAD_CTX_DIR_TX,
  1215					     tcp_sk(sk)->write_seq, rec_seq, rc);
  1216	
  1217		if (new_crypto_info) {
  1218			unsigned long flags;
  1219			__be64 rcd_sn;
  1220	
  1221			memcpy(ctx->tx.iv + cipher_desc->salt, iv, cipher_desc->iv);
  1222			memcpy(ctx->tx.rec_seq, rec_seq, cipher_desc->rec_seq);
  1223	
  1224			spin_lock_irqsave(&offload_ctx->lock, flags);
  1225			/* Delete old records, can't be retransmitted with new key */
  1226			delete_all_records(offload_ctx);
  1227	
  1228			/* Update unacked_record_sn for the new key's rec_seq.
  1229			 * This is critical for SW fallback encryption to use
  1230			 * the correct record sequence number after rekey.
  1231			 */
  1232			memcpy(&rcd_sn, rec_seq, sizeof(rcd_sn));
  1233			offload_ctx->unacked_record_sn = be64_to_cpu(rcd_sn);
  1234			spin_unlock_irqrestore(&offload_ctx->lock, flags);
  1235	
  1236			unsafe_memcpy(crypto_info, new_crypto_info,
  1237				      cipher_desc->crypto_info,
  1238				      /* size was checked in do_tls_setsockopt_conf */);
  1239			memzero_explicit(new_crypto_info, cipher_desc->crypto_info);
  1240		}
  1241	
  1242		if (rc) {
  1243			if (new_crypto_info) {
  1244				/* HW rekey failed, gracefully degrade to SW encryption.
  1245				 * SW fallback already has new key, IV, and rec_seq.
  1246				 * Old HW ctx was deleted, continue with SW encryption.
  1247				 */
  1248				set_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
> 1249				smp_store_release(sk->sk_validate_xmit_skb,
  1250					   tls_validate_xmit_skb_sw);
  1251			} else {
  1252				goto release_lock;
  1253			}
  1254		} else {
  1255			if (new_crypto_info)
  1256				clear_bit(TLS_TX_DEV_CLOSED, &ctx->flags);
  1257	
  1258			tls_device_attach(ctx, sk, netdev);
  1259	
  1260			/* following this assignment tls_is_skb_tx_device_offloaded
  1261			 * will return true and the context might be accessed
  1262			 * by the netdev's xmit function.
  1263			*/
  1264			smp_store_release(&sk->sk_validate_xmit_skb,
  1265					  tls_validate_xmit_skb);
  1266		}
  1267	
  1268		up_read(&device_offload_lock);
  1269	
  1270		dev_put(netdev);
  1271	
  1272		return 0;
  1273	
  1274	release_lock:
  1275		up_read(&device_offload_lock);
  1276		if (new_crypto_info)
  1277			goto release_netdev;
  1278		clean_acked_data_disable(tcp_sk(sk));
  1279		crypto_free_aead(offload_ctx->aead_send);
  1280	free_offload_ctx:
  1281		kfree(offload_ctx);
  1282		ctx->priv_ctx_tx = NULL;
  1283	free_marker_record:
  1284		kfree(start_marker_record);
  1285	release_netdev:
  1286		dev_put(netdev);
  1287		return rc;
  1288	}
  1289	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

