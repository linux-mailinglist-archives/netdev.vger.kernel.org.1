Return-Path: <netdev+bounces-128074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80794977D02
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBDA1C21A5C
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 10:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E361D7E51;
	Fri, 13 Sep 2024 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="dVCn/rys"
X-Original-To: netdev@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B41D6C7F
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222462; cv=none; b=Gqw4074o/imIAcne8c4pcUO57Zivuc541XzOsqzG/HtyupJS4gGU7cWW/KyBSL9dfJbWmM1YEgT9FUxmaE2pqnr5UB5E3kkN2OtfFVNNOWtn8PO4SWWVlY5PfEy7i78tQRYGMXw3oLViH37DXVcwyRemntQxC8benuxBRWg9JYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222462; c=relaxed/simple;
	bh=jwnUKFwawSYD1vuSblqX+PfrC395ExZkCFFaSIohnmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbpUoNPpEdP9SdIlaUJ7c2A2okUOx6fLWVKIweNnchoT60ovFGA94h507bTYOZL9yMH4aRzAtRp9JJq0ymz3aiigXTCv4IhVWbvtv9/trzylk+BnR2nFB1yg9IKVOKQxT2ioVQmrkzFyEUrxyNiaipcYK9rDYlO9BxVY3IbxmhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=dVCn/rys; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
	by cmsmtp with ESMTPS
	id oJcEsZGg0Vpzpp3Jks6ZRl; Fri, 13 Sep 2024 10:14:20 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id p3JjstSgAk5Y2p3Jjse9ax; Fri, 13 Sep 2024 10:14:19 +0000
X-Authority-Analysis: v=2.4 cv=R5QFG8RX c=1 sm=1 tr=0 ts=66e4107b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=rpUMG24A1zG+UrzXDtAMsg==:17
 a=IkcTkHD0fZMA:10 a=EaEq8P2WXUwA:10 a=7T7KSl7uo7wA:10 a=anyJmfQTAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8 a=QyXUC8HyAAAA:8
 a=Co-KuMXxJcsvc7DC3HAA:9 a=QEXdDO2ut3YA:10 a=mmqRlSCDY2ywfjPLJ4af:22
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/i8RPO9eFL0DrWzxkq+6NW6yIxztwoW7oSYVe/XjxhU=; b=dVCn/rys8mxpvhTDhfDYs3l5Xq
	788w1/MnJX0vAj7vyX6Q1iaeQ4CmVKXq3a6BH5yIn/Sv4SiXLVZHYZVBi8IZWJyLAZnKNv935qsJ1
	aK9/K2DT1gCz5WL8grPJNGma3y52tUxbrkFoNn9P45lAj3NH8gM9eiEDa8RlsdymGCkMDjomH8Aip
	BrfPFBlhpgztlI7kyphcRu28QcXy2N3ITByp56x+kgkNb0wotj1hoeQVuzI39u0M3N/6vUw+Cex0h
	q44r37cmljPwp7qUycQ07vm/MxwBoKAWTUYvtx96mbIpwnk9YvJrmsYxbXNPvn713tSXofLP/HIXZ
	1oS0nlmQ==;
Received: from [185.44.53.103] (port=34042 helo=[192.168.1.187])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sp3Jg-001LX5-1t;
	Fri, 13 Sep 2024 05:14:17 -0500
Message-ID: <7e1d4077-51d7-45ce-bab4-efec875b36f2@embeddedor.com>
Date: Fri, 13 Sep 2024 12:14:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2][next] wifi: iwlwifi: mvm: Use __counted_by() and avoid
 -Wfamnae warnings
To: kernel test robot <lkp@intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZrZs5KL5Pz9tIinr@cute> <202408110634.V68RFEtW-lkp@intel.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202408110634.V68RFEtW-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 185.44.53.103
X-Source-L: No
X-Exim-ID: 1sp3Jg-001LX5-1t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.187]) [185.44.53.103]:34042
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH+eLJnx11ftEIXaty+RAcQQuhB0Jk44F+kuUMKOmW8WpWRLLrCc33VY6juirpHcSuEQvwBERQaKXH/yGg1kSNVQW/odPcLOoxfP4t9pV07eFP/r1QHm
 gCFTCL+b6YuLQQ5Y1GhoqHClL6PIOFqerGmyUOBag+8gPgUQzpIpzTmcS8/UHFil66rXuDhe8nbigqPC1WONunxaoVnuMZPFXaQ=



On 10/08/24 22:26, kernel test robot wrote:
> Hi Gustavo,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on wireless-next/main]
> [also build test ERROR on wireless/main linus/master v6.11-rc2 next-20240809]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Gustavo-A-R-Silva/wifi-iwlwifi-mvm-Use-__counted_by-and-avoid-Wfamnae-warnings/20240810-103759
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
> patch link:    https://lore.kernel.org/r/ZrZs5KL5Pz9tIinr%40cute
> patch subject: [PATCH v2][next] wifi: iwlwifi: mvm: Use __counted_by() and avoid -Wfamnae warnings
> config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20240811/202408110634.V68RFEtW-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f86594788ce93b696675c94f54016d27a6c21d18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240811/202408110634.V68RFEtW-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408110634.V68RFEtW-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     In file included from drivers/net/wireless/intel/iwlwifi/mvm/d3.c:7:
>     In file included from include/linux/etherdevice.h:20:
>     In file included from include/linux/if_ether.h:19:
>     In file included from include/linux/skbuff.h:17:
>     In file included from include/linux/bvec.h:10:
>     In file included from include/linux/highmem.h:8:
>     In file included from include/linux/cacheflush.h:5:
>     In file included from arch/riscv/include/asm/cacheflush.h:9:
>     In file included from include/linux/mm.h:2228:
>     include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       501 |                            item];
>           |                            ~~~~
>     include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       508 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>           |                               ~~~~~~~~~~~ ^ ~~~
>     include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       520 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>     include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>       528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>       529 |                            NR_VM_NUMA_EVENT_ITEMS +
>           |                            ~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2149:2: error: call to '__compiletime_assert_1044' declared with 'error' attribute: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_GCMP_256
>      2149 |         BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_GCMP_256);
>           |         ^
>     include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
>        50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>           |         ^
>     include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
>        39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>           |                                     ^
>     include/linux/compiler_types.h:510:2: note: expanded from macro 'compiletime_assert'
>       510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>           |         ^
>     include/linux/compiler_types.h:498:2: note: expanded from macro '_compiletime_assert'
>       498 |         __compiletime_assert(condition, msg, prefix, suffix)
>           |         ^
>     include/linux/compiler_types.h:491:4: note: expanded from macro '__compiletime_assert'
>       491 |                         prefix ## suffix();                             \
>           |                         ^
>     <scratch space>:38:1: note: expanded from here
>        38 | __compiletime_assert_1044
>           | ^
>>> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2148:2: error: call to '__compiletime_assert_1043' declared with 'error' attribute: BUILD_BUG_ON failed: conf->keylen < WLAN_KEY_LEN_CCMP
>      2148 |         BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_CCMP);
>           |         ^
>     include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
>        50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>           |         ^
>     include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
>        39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>           |                                     ^
>     include/linux/compiler_types.h:510:2: note: expanded from macro 'compiletime_assert'
>       510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>           |         ^
>     include/linux/compiler_types.h:498:2: note: expanded from macro '_compiletime_assert'
>       498 |         __compiletime_assert(condition, msg, prefix, suffix)
>           |         ^
>     include/linux/compiler_types.h:491:4: note: expanded from macro '__compiletime_assert'
>       491 |                         prefix ## suffix();                             \
>           |                         ^
>     <scratch space>:34:1: note: expanded from here
>        34 | __compiletime_assert_1043
>           | ^
>     5 warnings and 2 errors generated.
> 
> 
> vim +2149 drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> 
>    2134	
>    2135	static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
>    2136				      struct ieee80211_vif *vif,
>    2137				      struct iwl_mvm *mvm, u32 gtk_cipher)
>    2138	{
>    2139		int i, j;
>    2140		struct ieee80211_key_conf *key;
>    2141		DEFINE_FLEX(struct ieee80211_key_conf, conf, key, keylen,
>    2142			    WOWLAN_KEY_MAX_SIZE);
>    2143		int link_id = vif->active_links ? __ffs(vif->active_links) : -1;


Holy molly guaca-guaca... swapping the above two lines fixes the issue:

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 581455ab5e6d..764580cf6c58 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -2138,9 +2138,8 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
  {
         int i, j;
         struct ieee80211_key_conf *key;
-       DEFINE_FLEX(struct ieee80211_key_conf, conf, key, keylen,
-                   WOWLAN_KEY_MAX_SIZE);
         int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
+       DEFINE_FLEX(struct ieee80211_key_conf, conf, key, keylen, WOWLAN_KEY_MAX_SIZE);

         conf->cipher = gtk_cipher;


This is the first time I've seen this compiler behavior when building DEFINE_FLEX() changes...

--
Gustavo

>    2144	
>    2145		conf->cipher = gtk_cipher;
>    2146	
>    2147		BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
>> 2148		BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_CCMP);
>> 2149		BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_GCMP_256);
>    2150		BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_TKIP);
>    2151		BUILD_BUG_ON(conf->keylen < sizeof(status->gtk[0].key));
>    2152	
>    2153		switch (gtk_cipher) {
>    2154		case WLAN_CIPHER_SUITE_CCMP:
>    2155		case WLAN_CIPHER_SUITE_GCMP:
>    2156			conf->keylen = WLAN_KEY_LEN_CCMP;
>    2157			break;
>    2158		case WLAN_CIPHER_SUITE_GCMP_256:
>    2159			conf->keylen = WLAN_KEY_LEN_GCMP_256;
>    2160			break;
>    2161		case WLAN_CIPHER_SUITE_TKIP:
>    2162			conf->keylen = WLAN_KEY_LEN_TKIP;
>    2163			break;
>    2164		default:
>    2165			WARN_ON(1);
>    2166		}
>    2167	
>    2168		for (i = 0; i < ARRAY_SIZE(status->gtk); i++) {
>    2169			if (!status->gtk[i].len)
>    2170				continue;
>    2171	
>    2172			conf->keyidx = status->gtk[i].id;
>    2173			IWL_DEBUG_WOWLAN(mvm,
>    2174					 "Received from FW GTK cipher %d, key index %d\n",
>    2175					 conf->cipher, conf->keyidx);
>    2176			memcpy(conf->key, status->gtk[i].key,
>    2177			       sizeof(status->gtk[i].key));
>    2178	
>    2179			key = ieee80211_gtk_rekey_add(vif, conf, link_id);
>    2180			if (IS_ERR(key))
>    2181				return false;
>    2182	
>    2183			for (j = 0; j < ARRAY_SIZE(status->gtk_seq); j++) {
>    2184				if (!status->gtk_seq[j].valid ||
>    2185				    status->gtk_seq[j].key_id != key->keyidx)
>    2186					continue;
>    2187				iwl_mvm_set_key_rx_seq_idx(key, status, j);
>    2188				break;
>    2189			}
>    2190			WARN_ON(j == ARRAY_SIZE(status->gtk_seq));
>    2191		}
>    2192	
>    2193		return true;
>    2194	}
>    2195	
> 

