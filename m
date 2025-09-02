Return-Path: <netdev+bounces-219319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1501B40F56
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B687A7A96FC
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518B82EFD82;
	Tue,  2 Sep 2025 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyAPyapl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7611832254B;
	Tue,  2 Sep 2025 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848269; cv=none; b=i7uYB03AVlgupFMsQGcIGZvGfc+n/En1fvs98uMQDs9px6ErZJW57R1zg+eyz38GmzbnJ9slgyxzCkcw+AEE6xYH8m3IOxKQIJOoWF+LHCxJyvv2OJwds+rU8/AQwS3+bY+p2s70yeOtozVZmey9NU58Xo3YJLFdQCK+2cIG3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848269; c=relaxed/simple;
	bh=dp4DI3MP3LNfvzq43YKzfAVDtkE62mbd1WIEzYkl+6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nd/QGrqF1Lc4vo4PZMI8fnO2XGDm+eEAaw720Xgq80ettuHzzKCU2517NGoSZSqN1LhItcOFN2dk8WN9sGIlU05yQV1+WVtHmKmX6z9P/pMtGeB163ZrRPSDipVrcbFlo0yiPqZj8DVgPe2nnBggTb4DCCS4Fi6LQ0D0rnsISSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyAPyapl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756848268; x=1788384268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dp4DI3MP3LNfvzq43YKzfAVDtkE62mbd1WIEzYkl+6I=;
  b=UyAPyaplBVP62ZchmPEKGogdCxfZPgFwOX/AeofoKXND7y9LiFB5F0sS
   c1+Rrt0tc2iu5YJcivCSLqS0Z+1hOCa3dm2A8GsJ0CVpmsbOaBARwOQbn
   gvdccZoEnZ62tXRxWWR4xEyzGzblDOEbDnnVm870BBb6OnIgr8clKpfH5
   a2dEtnGywY0SJHnRsdVhas73+EkIj+6/EYoBKTcG0Cq2ZCzQV/6FT9Rfk
   o3tJtGSmAn2esM7oatpo6hK3xpzpFx6O0/sVl06QnPnwLQxVNe6NSXboX
   TVriWfALgSldExz9idPk+VbL3O5bNBm+cMWVu3VFqp+pmfZlRE517NPx5
   A==;
X-CSE-ConnectionGUID: 6yiiy2qyQQC682nahG/40w==
X-CSE-MsgGUID: Rpp5trZnQw22AKARYIofrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59214894"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59214894"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 14:24:27 -0700
X-CSE-ConnectionGUID: P022I5ruQgyEpxSfHXWY7Q==
X-CSE-MsgGUID: s3IpHuhXRiiKgo0PyvOBQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="175534815"
Received: from lkp-server02.sh.intel.com (HELO 06ba48ef64e9) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 02 Sep 2025 14:24:23 -0700
Received: from kbuild by 06ba48ef64e9 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1utYUG-00032F-2R;
	Tue, 02 Sep 2025 21:24:20 +0000
Date: Wed, 3 Sep 2025 05:24:16 +0800
From: kernel test robot <lkp@intel.com>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Damien Le'Moal <dlemoal@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v2] net/tls: support maximum record size limit
Message-ID: <202509030542.ZW9r1S1c-lkp@intel.com>
References: <20250902033809.177182-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902033809.177182-2-wilfred.opensource@gmail.com>

Hi Wilfred,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]
[also build test WARNING on net/main linus/master horms-ipvs/master v6.17-rc4 next-20250902]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wilfred-Mallawa/net-tls-support-maximum-record-size-limit/20250902-114005
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250902033809.177182-2-wilfred.opensource%40gmail.com
patch subject: [PATCH v2] net/tls: support maximum record size limit
config: i386-buildonly-randconfig-001-20250903 (https://download.01.org/0day-ci/archive/20250903/202509030542.ZW9r1S1c-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250903/202509030542.ZW9r1S1c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509030542.ZW9r1S1c-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/tls/tls_sw.c: In function 'tls_sw_sendmsg_locked':
>> net/tls/tls_sw.c:1036:13: warning: variable 'record_size_limit' set but not used [-Wunused-but-set-variable]
    1036 |         u16 record_size_limit;
         |             ^~~~~~~~~~~~~~~~~


vim +/record_size_limit +1036 net/tls/tls_sw.c

  1024	
  1025	static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
  1026					 size_t size)
  1027	{
  1028		long timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
  1029		struct tls_context *tls_ctx = tls_get_ctx(sk);
  1030		struct tls_prot_info *prot = &tls_ctx->prot_info;
  1031		struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
  1032		bool async_capable = ctx->async_capable;
  1033		unsigned char record_type = TLS_RECORD_TYPE_DATA;
  1034		bool is_kvec = iov_iter_is_kvec(&msg->msg_iter);
  1035		bool eor = !(msg->msg_flags & MSG_MORE);
> 1036		u16 record_size_limit;
  1037		size_t try_to_copy;
  1038		ssize_t copied = 0;
  1039		struct sk_msg *msg_pl, *msg_en;
  1040		struct tls_rec *rec;
  1041		int required_size;
  1042		int num_async = 0;
  1043		bool full_record;
  1044		int record_room;
  1045		int num_zc = 0;
  1046		int orig_size;
  1047		int ret = 0;
  1048	
  1049		if (!eor && (msg->msg_flags & MSG_EOR))
  1050			return -EINVAL;
  1051	
  1052		if (unlikely(msg->msg_controllen)) {
  1053			ret = tls_process_cmsg(sk, msg, &record_type);
  1054			if (ret) {
  1055				if (ret == -EINPROGRESS)
  1056					num_async++;
  1057				else if (ret != -EAGAIN)
  1058					goto send_end;
  1059			}
  1060		}
  1061	
  1062		record_size_limit = tls_ctx->record_size_limit ?
  1063				    tls_ctx->record_size_limit : TLS_MAX_PAYLOAD_SIZE;
  1064	
  1065		while (msg_data_left(msg)) {
  1066			if (sk->sk_err) {
  1067				ret = -sk->sk_err;
  1068				goto send_end;
  1069			}
  1070	
  1071			if (ctx->open_rec)
  1072				rec = ctx->open_rec;
  1073			else
  1074				rec = ctx->open_rec = tls_get_rec(sk);
  1075			if (!rec) {
  1076				ret = -ENOMEM;
  1077				goto send_end;
  1078			}
  1079	
  1080			msg_pl = &rec->msg_plaintext;
  1081			msg_en = &rec->msg_encrypted;
  1082	
  1083			orig_size = msg_pl->sg.size;
  1084			full_record = false;
  1085			try_to_copy = msg_data_left(msg);
  1086			record_room = TLS_MAX_PAYLOAD_SIZE - msg_pl->sg.size;
  1087			if (try_to_copy >= record_room) {
  1088				try_to_copy = record_room;
  1089				full_record = true;
  1090			}
  1091	
  1092			required_size = msg_pl->sg.size + try_to_copy +
  1093					prot->overhead_size;
  1094	
  1095			if (!sk_stream_memory_free(sk))
  1096				goto wait_for_sndbuf;
  1097	
  1098	alloc_encrypted:
  1099			ret = tls_alloc_encrypted_msg(sk, required_size);
  1100			if (ret) {
  1101				if (ret != -ENOSPC)
  1102					goto wait_for_memory;
  1103	
  1104				/* Adjust try_to_copy according to the amount that was
  1105				 * actually allocated. The difference is due
  1106				 * to max sg elements limit
  1107				 */
  1108				try_to_copy -= required_size - msg_en->sg.size;
  1109				full_record = true;
  1110			}
  1111	
  1112			if (try_to_copy && (msg->msg_flags & MSG_SPLICE_PAGES)) {
  1113				ret = tls_sw_sendmsg_splice(sk, msg, msg_pl,
  1114							    try_to_copy, &copied);
  1115				if (ret < 0)
  1116					goto send_end;
  1117				tls_ctx->pending_open_record_frags = true;
  1118	
  1119				if (sk_msg_full(msg_pl))
  1120					full_record = true;
  1121	
  1122				if (full_record || eor)
  1123					goto copied;
  1124				continue;
  1125			}
  1126	
  1127			if (!is_kvec && (full_record || eor) && !async_capable) {
  1128				u32 first = msg_pl->sg.end;
  1129	
  1130				ret = sk_msg_zerocopy_from_iter(sk, &msg->msg_iter,
  1131								msg_pl, try_to_copy);
  1132				if (ret)
  1133					goto fallback_to_reg_send;
  1134	
  1135				num_zc++;
  1136				copied += try_to_copy;
  1137	
  1138				sk_msg_sg_copy_set(msg_pl, first);
  1139				ret = bpf_exec_tx_verdict(msg_pl, sk, full_record,
  1140							  record_type, &copied,
  1141							  msg->msg_flags);
  1142				if (ret) {
  1143					if (ret == -EINPROGRESS)
  1144						num_async++;
  1145					else if (ret == -ENOMEM)
  1146						goto wait_for_memory;
  1147					else if (ctx->open_rec && ret == -ENOSPC) {
  1148						if (msg_pl->cork_bytes) {
  1149							ret = 0;
  1150							goto send_end;
  1151						}
  1152						goto rollback_iter;
  1153					} else if (ret != -EAGAIN)
  1154						goto send_end;
  1155				}
  1156				continue;
  1157	rollback_iter:
  1158				copied -= try_to_copy;
  1159				sk_msg_sg_copy_clear(msg_pl, first);
  1160				iov_iter_revert(&msg->msg_iter,
  1161						msg_pl->sg.size - orig_size);
  1162	fallback_to_reg_send:
  1163				sk_msg_trim(sk, msg_pl, orig_size);
  1164			}
  1165	
  1166			required_size = msg_pl->sg.size + try_to_copy;
  1167	
  1168			ret = tls_clone_plaintext_msg(sk, required_size);
  1169			if (ret) {
  1170				if (ret != -ENOSPC)
  1171					goto send_end;
  1172	
  1173				/* Adjust try_to_copy according to the amount that was
  1174				 * actually allocated. The difference is due
  1175				 * to max sg elements limit
  1176				 */
  1177				try_to_copy -= required_size - msg_pl->sg.size;
  1178				full_record = true;
  1179				sk_msg_trim(sk, msg_en,
  1180					    msg_pl->sg.size + prot->overhead_size);
  1181			}
  1182	
  1183			if (try_to_copy) {
  1184				ret = sk_msg_memcopy_from_iter(sk, &msg->msg_iter,
  1185							       msg_pl, try_to_copy);
  1186				if (ret < 0)
  1187					goto trim_sgl;
  1188			}
  1189	
  1190			/* Open records defined only if successfully copied, otherwise
  1191			 * we would trim the sg but not reset the open record frags.
  1192			 */
  1193			tls_ctx->pending_open_record_frags = true;
  1194			copied += try_to_copy;
  1195	copied:
  1196			if (full_record || eor) {
  1197				ret = bpf_exec_tx_verdict(msg_pl, sk, full_record,
  1198							  record_type, &copied,
  1199							  msg->msg_flags);
  1200				if (ret) {
  1201					if (ret == -EINPROGRESS)
  1202						num_async++;
  1203					else if (ret == -ENOMEM)
  1204						goto wait_for_memory;
  1205					else if (ret != -EAGAIN) {
  1206						if (ret == -ENOSPC)
  1207							ret = 0;
  1208						goto send_end;
  1209					}
  1210				}
  1211			}
  1212	
  1213			continue;
  1214	
  1215	wait_for_sndbuf:
  1216			set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
  1217	wait_for_memory:
  1218			ret = sk_stream_wait_memory(sk, &timeo);
  1219			if (ret) {
  1220	trim_sgl:
  1221				if (ctx->open_rec)
  1222					tls_trim_both_msgs(sk, orig_size);
  1223				goto send_end;
  1224			}
  1225	
  1226			if (ctx->open_rec && msg_en->sg.size < required_size)
  1227				goto alloc_encrypted;
  1228		}
  1229	
  1230		if (!num_async) {
  1231			goto send_end;
  1232		} else if (num_zc || eor) {
  1233			int err;
  1234	
  1235			/* Wait for pending encryptions to get completed */
  1236			err = tls_encrypt_async_wait(ctx);
  1237			if (err) {
  1238				ret = err;
  1239				copied = 0;
  1240			}
  1241		}
  1242	
  1243		/* Transmit if any encryptions have completed */
  1244		if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
  1245			cancel_delayed_work(&ctx->tx_work.work);
  1246			tls_tx_records(sk, msg->msg_flags);
  1247		}
  1248	
  1249	send_end:
  1250		ret = sk_stream_error(sk, msg->msg_flags, ret);
  1251		return copied > 0 ? copied : ret;
  1252	}
  1253	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

