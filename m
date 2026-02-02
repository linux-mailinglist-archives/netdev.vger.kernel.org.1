Return-Path: <netdev+bounces-255687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Y6BAC5Ltf2kI0gIAu9opvQ
	(envelope-from <netdev+bounces-255687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 01:19:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F3CC79DF
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 01:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63D0C30045A3
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 00:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F14126BF1;
	Mon,  2 Feb 2026 00:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Igkj4qN+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F082B14A8E;
	Mon,  2 Feb 2026 00:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769991564; cv=none; b=Mtkhk3A7fFOiDhyQycF5hmr9I5cpyNKMKVKNjZfJYQPwoNeM4pVOMt2qbn47O9U/unPRz+9cSW0ukM5ZdnwwLKMcUhn2sKhjGAMtsOM3xeJ14bTIbe9WqFyMr2K7IPmxwwdrga+E3kL0yJ7Y+DxRkXNFx3wDXfa9YCvtaKgkiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769991564; c=relaxed/simple;
	bh=2wJYMharzyU0A3c+gnlDUj8Cz+B7jQpQOidusbBIA+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cde1DxERr5YOFlh+HT5C7jFBE6DyHbn1tm7JMu2NqcQ9ncgFDFFJ2/vyPrTcCN4JxsO2l6bkeW81Nlnn1Rc44HR0yR9PIVZQtO2wYka7tOEmF4Wtu/8I8/g65iryiYU3RSgvQvz0e1R2eabYV28Irm+jsAZMohPfiQ14dQ6AgFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Igkj4qN+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769991561; x=1801527561;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2wJYMharzyU0A3c+gnlDUj8Cz+B7jQpQOidusbBIA+g=;
  b=Igkj4qN+8nbP4DOEyAfLdJ0fXKGJFQ/deLSulbXzV642/vm2V9sxuhhK
   iLdedG4UqVCgvl+cElmUHR3P/Tt7UQy2ch2JbBSZDk3emaMc8FUZSh+Ks
   UQ1mm8y3wlz1rcxjoB6/PDNe3AamVnXZQFOiVlusuQu0bLlGcPEF+h2ZN
   VWDPPo+Z+zVnf8sPUyqdmOAv2xG+3PR/AKN1VhcmwKSReZYJHW2MaKKSC
   InVQRMIZdEe0eY4PNv9xmBaOKDwN7u/CSEk5rfiRUP0Wps0cqPI/9sn6Z
   S4ciMWHbYTwWhQnzhEuUy82HKP8LWm1ak2bQOKeyBwG1+Mte6puf3Rv1/
   A==;
X-CSE-ConnectionGUID: qGjbDjBlRi+Sm7x7PEYZXA==
X-CSE-MsgGUID: l8dc/Wc/Sca/428CfOAt4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11689"; a="71064100"
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="71064100"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2026 16:19:20 -0800
X-CSE-ConnectionGUID: 0DRXyFw5S1mz0txU+GhzEA==
X-CSE-MsgGUID: vgIAn5BoTK2mMKVVgvngjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,267,1763452800"; 
   d="scan'208";a="246977905"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 01 Feb 2026 16:19:16 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmheq-00000000f80-3vi7;
	Mon, 02 Feb 2026 00:19:12 +0000
Date: Mon, 2 Feb 2026 08:19:12 +0800
From: kernel test robot <lkp@intel.com>
To: Vikas Gupta <vikas.gupta@broadcom.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com, ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Subject: Re: [net-next] bnge: Add a new HSI
Message-ID: <202602020845.jaEGCtNd-lkp@intel.com>
References: <20260131023133.836333-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131023133.836333-1-vikas.gupta@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255687-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 11F3CC79DF
X-Rspamd-Action: no action

Hi Vikas,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vikas-Gupta/bnge-Add-a-new-HSI/20260131-103758
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260131023133.836333-1-vikas.gupta%40broadcom.com
patch subject: [net-next] bnge: Add a new HSI
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20260202/202602020845.jaEGCtNd-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260202/202602020845.jaEGCtNd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602020845.jaEGCtNd-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/broadcom/bnge/bnge.h:11,
                    from drivers/infiniband/hw/bng_re/bng_dev.c:13:
>> include/linux/bnge/hsi.h:10:8: error: redefinition of 'struct hwrm_cmd_hdr'
      10 | struct hwrm_cmd_hdr {
         |        ^~~~~~~~~~~~
   In file included from drivers/infiniband/hw/bnxt_re/roce_hsi.h:43,
                    from drivers/infiniband/hw/bng_re/bng_res.h:7,
                    from drivers/infiniband/hw/bng_re/bng_dev.c:10:
   include/linux/bnxt/hsi.h:18:8: note: originally defined here
      18 | struct hwrm_cmd_hdr {
         |        ^~~~~~~~~~~~
>> include/linux/bnge/hsi.h:19:8: error: redefinition of 'struct hwrm_resp_hdr'
      19 | struct hwrm_resp_hdr {
         |        ^~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:27:8: note: originally defined here
      27 | struct hwrm_resp_hdr {
         |        ^~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:52:8: error: redefinition of 'struct tlv'
      52 | struct tlv {
         |        ^~~
   include/linux/bnxt/hsi.h:62:8: note: originally defined here
      62 | struct tlv {
         |        ^~~
>> include/linux/bnge/hsi.h:68:8: error: redefinition of 'struct input'
      68 | struct input {
         |        ^~~~~
   include/linux/bnxt/hsi.h:78:8: note: originally defined here
      78 | struct input {
         |        ^~~~~
>> include/linux/bnge/hsi.h:77:8: error: redefinition of 'struct output'
      77 | struct output {
         |        ^~~~~~
   include/linux/bnxt/hsi.h:87:8: note: originally defined here
      87 | struct output {
         |        ^~~~~~
>> include/linux/bnge/hsi.h:85:8: error: redefinition of 'struct hwrm_short_input'
      85 | struct hwrm_short_input {
         |        ^~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:95:8: note: originally defined here
      95 | struct hwrm_short_input {
         |        ^~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:99:8: error: redefinition of 'struct cmd_nums'
      99 | struct cmd_nums {
         |        ^~~~~~~~
   include/linux/bnxt/hsi.h:109:8: note: originally defined here
     109 | struct cmd_nums {
         |        ^~~~~~~~
>> include/linux/bnge/hsi.h:590:8: error: redefinition of 'struct ret_codes'
     590 | struct ret_codes {
         |        ^~~~~~~~~
   include/linux/bnxt/hsi.h:593:8: note: originally defined here
     593 | struct ret_codes {
         |        ^~~~~~~~~
>> include/linux/bnge/hsi.h:621:8: error: redefinition of 'struct hwrm_err_output'
     621 | struct hwrm_err_output {
         |        ^~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:624:8: note: originally defined here
     624 | struct hwrm_err_output {
         |        ^~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:643:9: warning: 'HWRM_VERSION_MINOR' redefined
     643 | #define HWRM_VERSION_MINOR 15
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:645:9: note: this is the location of the previous definition
     645 | #define HWRM_VERSION_MINOR 10
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:644:9: warning: 'HWRM_VERSION_UPDATE' redefined
     644 | #define HWRM_VERSION_UPDATE 1
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:646:9: note: this is the location of the previous definition
     646 | #define HWRM_VERSION_UPDATE 3
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:645:9: warning: 'HWRM_VERSION_RSVD' redefined
     645 | #define HWRM_VERSION_RSVD 1
         |         ^~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:647:9: note: this is the location of the previous definition
     647 | #define HWRM_VERSION_RSVD 151
         |         ^~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:646:9: warning: 'HWRM_VERSION_STR' redefined
     646 | #define HWRM_VERSION_STR "1.15.1.1"
         |         ^~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:648:9: note: this is the location of the previous definition
     648 | #define HWRM_VERSION_STR "1.10.3.151"
         |         ^~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:649:8: error: redefinition of 'struct hwrm_ver_get_input'
     649 | struct hwrm_ver_get_input {
         |        ^~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:651:8: note: originally defined here
     651 | struct hwrm_ver_get_input {
         |        ^~~~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:662:8: error: redefinition of 'struct hwrm_ver_get_output'
     662 | struct hwrm_ver_get_output {
         |        ^~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:664:8: note: originally defined here
     664 | struct hwrm_ver_get_output {
         |        ^~~~~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:762:8: error: redefinition of 'struct eject_cmpl'
     762 | struct eject_cmpl {
         |        ^~~~~~~~~~
   include/linux/bnxt/hsi.h:758:8: note: originally defined here
     758 | struct eject_cmpl {
         |        ^~~~~~~~~~
>> include/linux/bnge/hsi.h:789:8: error: redefinition of 'struct hwrm_cmpl'
     789 | struct hwrm_cmpl {
         |        ^~~~~~~~~
   include/linux/bnxt/hsi.h:785:8: note: originally defined here
     785 | struct hwrm_cmpl {
         |        ^~~~~~~~~
>> include/linux/bnge/hsi.h:803:8: error: redefinition of 'struct hwrm_fwd_req_cmpl'
     803 | struct hwrm_fwd_req_cmpl {
         |        ^~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:799:8: note: originally defined here
     799 | struct hwrm_fwd_req_cmpl {
         |        ^~~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:820:8: error: redefinition of 'struct hwrm_fwd_resp_cmpl'
     820 | struct hwrm_fwd_resp_cmpl {
         |        ^~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:816:8: note: originally defined here
     816 | struct hwrm_fwd_resp_cmpl {
         |        ^~~~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:836:8: error: redefinition of 'struct hwrm_async_event_cmpl'
     836 | struct hwrm_async_event_cmpl {
         |        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:832:8: note: originally defined here
     832 | struct hwrm_async_event_cmpl {
         |        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:894:17: warning: 'ASYNC_EVENT_CMPL_EVENT_ID_ADPTV_QOS' redefined
     894 |         #define ASYNC_EVENT_CMPL_EVENT_ID_ADPTV_QOS                       0x53UL
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:888:17: note: this is the location of the previous definition
     888 |         #define ASYNC_EVENT_CMPL_EVENT_ID_ADPTV_QOS                       0x51UL
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:896:17: warning: 'ASYNC_EVENT_CMPL_EVENT_ID_MAX_RGTR_EVENT_ID' redefined
     896 |         #define ASYNC_EVENT_CMPL_EVENT_ID_MAX_RGTR_EVENT_ID               0x55UL
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:889:17: note: this is the location of the previous definition
     889 |         #define ASYNC_EVENT_CMPL_EVENT_ID_MAX_RGTR_EVENT_ID               0x52UL
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:912:8: error: redefinition of 'struct hwrm_async_event_cmpl_link_status_change'
     912 | struct hwrm_async_event_cmpl_link_status_change {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:904:8: note: originally defined here
     904 | struct hwrm_async_event_cmpl_link_status_change {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:942:8: error: redefinition of 'struct hwrm_async_event_cmpl_port_conn_not_allowed'
     942 | struct hwrm_async_event_cmpl_port_conn_not_allowed {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:934:8: note: originally defined here
     934 | struct hwrm_async_event_cmpl_port_conn_not_allowed {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:971:8: error: redefinition of 'struct hwrm_async_event_cmpl_link_speed_cfg_change'
     971 | struct hwrm_async_event_cmpl_link_speed_cfg_change {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:963:8: note: originally defined here
     963 | struct hwrm_async_event_cmpl_link_speed_cfg_change {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:995:8: error: redefinition of 'struct hwrm_async_event_cmpl_reset_notify'
     995 | struct hwrm_async_event_cmpl_reset_notify {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:987:8: note: originally defined here
     987 | struct hwrm_async_event_cmpl_reset_notify {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1032:8: error: redefinition of 'struct hwrm_async_event_cmpl_error_recovery'
    1032 | struct hwrm_async_event_cmpl_error_recovery {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1024:8: note: originally defined here
    1024 | struct hwrm_async_event_cmpl_error_recovery {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1056:8: error: redefinition of 'struct hwrm_async_event_cmpl_ring_monitor_msg'
    1056 | struct hwrm_async_event_cmpl_ring_monitor_msg {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1048:8: note: originally defined here
    1048 | struct hwrm_async_event_cmpl_ring_monitor_msg {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1082:8: error: redefinition of 'struct hwrm_async_event_cmpl_vf_cfg_change'
    1082 | struct hwrm_async_event_cmpl_vf_cfg_change {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1074:8: note: originally defined here
    1074 | struct hwrm_async_event_cmpl_vf_cfg_change {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1110:8: error: redefinition of 'struct hwrm_async_event_cmpl_default_vnic_change'
    1110 | struct hwrm_async_event_cmpl_default_vnic_change {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1102:8: note: originally defined here
    1102 | struct hwrm_async_event_cmpl_default_vnic_change {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1141:8: error: redefinition of 'struct hwrm_async_event_cmpl_hw_flow_aged'
    1141 | struct hwrm_async_event_cmpl_hw_flow_aged {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1133:8: note: originally defined here
    1133 | struct hwrm_async_event_cmpl_hw_flow_aged {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1167:8: error: redefinition of 'struct hwrm_async_event_cmpl_eem_cache_flush_req'
    1167 | struct hwrm_async_event_cmpl_eem_cache_flush_req {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1159:8: note: originally defined here
    1159 | struct hwrm_async_event_cmpl_eem_cache_flush_req {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1187:8: error: redefinition of 'struct hwrm_async_event_cmpl_eem_cache_flush_done'
    1187 | struct hwrm_async_event_cmpl_eem_cache_flush_done {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1179:8: note: originally defined here
    1179 | struct hwrm_async_event_cmpl_eem_cache_flush_done {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1209:8: error: redefinition of 'struct hwrm_async_event_cmpl_deferred_response'
    1209 | struct hwrm_async_event_cmpl_deferred_response {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1201:8: note: originally defined here
    1201 | struct hwrm_async_event_cmpl_deferred_response {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1231:8: error: redefinition of 'struct hwrm_async_event_cmpl_echo_request'
    1231 | struct hwrm_async_event_cmpl_echo_request {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1223:8: note: originally defined here
    1223 | struct hwrm_async_event_cmpl_echo_request {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1251:8: error: redefinition of 'struct hwrm_async_event_cmpl_phc_update'
    1251 | struct hwrm_async_event_cmpl_phc_update {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1243:8: note: originally defined here
    1243 | struct hwrm_async_event_cmpl_phc_update {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1284:8: error: redefinition of 'struct hwrm_async_event_cmpl_pps_timestamp'
    1284 | struct hwrm_async_event_cmpl_pps_timestamp {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1276:8: note: originally defined here
    1276 | struct hwrm_async_event_cmpl_pps_timestamp {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1314:8: error: redefinition of 'struct hwrm_async_event_cmpl_error_report'
    1314 | struct hwrm_async_event_cmpl_error_report {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1306:8: note: originally defined here
    1306 | struct hwrm_async_event_cmpl_error_report {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1336:8: error: redefinition of 'struct hwrm_async_event_cmpl_dbg_buf_producer'
    1336 | struct hwrm_async_event_cmpl_dbg_buf_producer {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1328:8: note: originally defined here
    1328 | struct hwrm_async_event_cmpl_dbg_buf_producer {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1374:17: warning: 'ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_LAST' redefined
    1374 |         #define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_LAST                ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_MPC_CMPL_TRACE
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1362:17: note: this is the location of the previous definition
    1362 |         #define ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_LAST                ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_ERR_QPC_TRACE
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1378:8: error: redefinition of 'struct hwrm_async_event_cmpl_hwrm_error'
    1378 | struct hwrm_async_event_cmpl_hwrm_error {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1366:8: note: originally defined here
    1366 | struct hwrm_async_event_cmpl_hwrm_error {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1405:8: error: redefinition of 'struct hwrm_async_event_cmpl_error_report_base'
    1405 | struct hwrm_async_event_cmpl_error_report_base {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1393:8: note: originally defined here
    1393 | struct hwrm_async_event_cmpl_error_report_base {


vim +10 include/linux/bnge/hsi.h

     8	
     9	/* hwrm_cmd_hdr (size:128b/16B) */
  > 10	struct hwrm_cmd_hdr {
    11		__le16	req_type;
    12		__le16	cmpl_ring;
    13		__le16	seq_id;
    14		__le16	target_id;
    15		__le64	resp_addr;
    16	};
    17	
    18	/* hwrm_resp_hdr (size:64b/8B) */
  > 19	struct hwrm_resp_hdr {
    20		__le16	error_code;
    21		__le16	req_type;
    22		__le16	seq_id;
    23		__le16	resp_len;
    24	};
    25	
    26	#define CMD_DISCR_TLV_ENCAP 0x8000UL
    27	#define CMD_DISCR_LAST     CMD_DISCR_TLV_ENCAP
    28	
    29	#define TLV_TYPE_HWRM_REQUEST                    0x1UL
    30	#define TLV_TYPE_HWRM_RESPONSE                   0x2UL
    31	#define TLV_TYPE_ROCE_SP_COMMAND                 0x3UL
    32	#define TLV_TYPE_QUERY_ROCE_CC_GEN1              0x4UL
    33	#define TLV_TYPE_MODIFY_ROCE_CC_GEN1             0x5UL
    34	#define TLV_TYPE_QUERY_ROCE_CC_GEN2              0x6UL
    35	#define TLV_TYPE_MODIFY_ROCE_CC_GEN2             0x7UL
    36	#define TLV_TYPE_QUERY_ROCE_CC_GEN1_EXT          0x8UL
    37	#define TLV_TYPE_MODIFY_ROCE_CC_GEN1_EXT         0x9UL
    38	#define TLV_TYPE_QUERY_ROCE_CC_GEN2_EXT          0xaUL
    39	#define TLV_TYPE_MODIFY_ROCE_CC_GEN2_EXT         0xbUL
    40	#define TLV_TYPE_ENGINE_CKV_ALIAS_ECC_PUBLIC_KEY 0x8001UL
    41	#define TLV_TYPE_ENGINE_CKV_IV                   0x8003UL
    42	#define TLV_TYPE_ENGINE_CKV_AUTH_TAG             0x8004UL
    43	#define TLV_TYPE_ENGINE_CKV_CIPHERTEXT           0x8005UL
    44	#define TLV_TYPE_ENGINE_CKV_HOST_ALGORITHMS      0x8006UL
    45	#define TLV_TYPE_ENGINE_CKV_HOST_ECC_PUBLIC_KEY  0x8007UL
    46	#define TLV_TYPE_ENGINE_CKV_ECDSA_SIGNATURE      0x8008UL
    47	#define TLV_TYPE_ENGINE_CKV_FW_ECC_PUBLIC_KEY    0x8009UL
    48	#define TLV_TYPE_ENGINE_CKV_FW_ALGORITHMS        0x800aUL
    49	#define TLV_TYPE_LAST                           TLV_TYPE_ENGINE_CKV_FW_ALGORITHMS
    50	
    51	/* tlv (size:64b/8B) */
  > 52	struct tlv {
    53		__le16	cmd_discr;
    54		u8	reserved_8b;
    55		u8	flags;
    56		#define TLV_FLAGS_MORE         0x1UL
    57		#define TLV_FLAGS_MORE_LAST      0x0UL
    58		#define TLV_FLAGS_MORE_NOT_LAST  0x1UL
    59		#define TLV_FLAGS_REQUIRED     0x2UL
    60		#define TLV_FLAGS_REQUIRED_NO    (0x0UL << 1)
    61		#define TLV_FLAGS_REQUIRED_YES   (0x1UL << 1)
    62		#define TLV_FLAGS_REQUIRED_LAST TLV_FLAGS_REQUIRED_YES
    63		__le16	tlv_type;
    64		__le16	length;
    65	};
    66	
    67	/* input (size:128b/16B) */
  > 68	struct input {
    69		__le16	req_type;
    70		__le16	cmpl_ring;
    71		__le16	seq_id;
    72		__le16	target_id;
    73		__le64	resp_addr;
    74	};
    75	
    76	/* output (size:64b/8B) */
  > 77	struct output {
    78		__le16	error_code;
    79		__le16	req_type;
    80		__le16	seq_id;
    81		__le16	resp_len;
    82	};
    83	
    84	/* hwrm_short_input (size:128b/16B) */
  > 85	struct hwrm_short_input {
    86		__le16	req_type;
    87		__le16	signature;
    88		#define SHORT_REQ_SIGNATURE_SHORT_CMD 0x4321UL
    89		#define SHORT_REQ_SIGNATURE_LAST     SHORT_REQ_SIGNATURE_SHORT_CMD
    90		__le16	target_id;
    91		#define SHORT_REQ_TARGET_ID_DEFAULT 0x0UL
    92		#define SHORT_REQ_TARGET_ID_TOOLS   0xfffdUL
    93		#define SHORT_REQ_TARGET_ID_LAST   SHORT_REQ_TARGET_ID_TOOLS
    94		__le16	size;
    95		__le64	req_addr;
    96	};
    97	
    98	/* cmd_nums (size:64b/8B) */
  > 99	struct cmd_nums {
   100		__le16	req_type;
   101		#define HWRM_VER_GET                              0x0UL
   102		#define HWRM_FUNC_ECHO_RESPONSE                   0xbUL
   103		#define HWRM_ERROR_RECOVERY_QCFG                  0xcUL
   104		#define HWRM_FUNC_DRV_IF_CHANGE                   0xdUL
   105		#define HWRM_FUNC_BUF_UNRGTR                      0xeUL
   106		#define HWRM_FUNC_VF_CFG                          0xfUL
   107		#define HWRM_RESERVED1                            0x10UL
   108		#define HWRM_FUNC_RESET                           0x11UL
   109		#define HWRM_FUNC_GETFID                          0x12UL
   110		#define HWRM_FUNC_VF_ALLOC                        0x13UL
   111		#define HWRM_FUNC_VF_FREE                         0x14UL
   112		#define HWRM_FUNC_QCAPS                           0x15UL
   113		#define HWRM_FUNC_QCFG                            0x16UL
   114		#define HWRM_FUNC_CFG                             0x17UL
   115		#define HWRM_FUNC_QSTATS                          0x18UL
   116		#define HWRM_FUNC_CLR_STATS                       0x19UL
   117		#define HWRM_FUNC_DRV_UNRGTR                      0x1aUL
   118		#define HWRM_FUNC_VF_RESC_FREE                    0x1bUL
   119		#define HWRM_FUNC_VF_VNIC_IDS_QUERY               0x1cUL
   120		#define HWRM_FUNC_DRV_RGTR                        0x1dUL
   121		#define HWRM_FUNC_DRV_QVER                        0x1eUL
   122		#define HWRM_FUNC_BUF_RGTR                        0x1fUL
   123		#define HWRM_PORT_PHY_CFG                         0x20UL
   124		#define HWRM_PORT_MAC_CFG                         0x21UL
   125		#define HWRM_PORT_TS_QUERY                        0x22UL
   126		#define HWRM_PORT_QSTATS                          0x23UL
   127		#define HWRM_PORT_LPBK_QSTATS                     0x24UL
   128		#define HWRM_PORT_CLR_STATS                       0x25UL
   129		#define HWRM_PORT_LPBK_CLR_STATS                  0x26UL
   130		#define HWRM_PORT_PHY_QCFG                        0x27UL
   131		#define HWRM_PORT_MAC_QCFG                        0x28UL
   132		#define HWRM_PORT_MAC_PTP_QCFG                    0x29UL
   133		#define HWRM_PORT_PHY_QCAPS                       0x2aUL
   134		#define HWRM_PORT_PHY_I2C_WRITE                   0x2bUL
   135		#define HWRM_PORT_PHY_I2C_READ                    0x2cUL
   136		#define HWRM_PORT_LED_CFG                         0x2dUL
   137		#define HWRM_PORT_LED_QCFG                        0x2eUL
   138		#define HWRM_PORT_LED_QCAPS                       0x2fUL
   139		#define HWRM_QUEUE_QPORTCFG                       0x30UL
   140		#define HWRM_QUEUE_QCFG                           0x31UL
   141		#define HWRM_QUEUE_CFG                            0x32UL
   142		#define HWRM_FUNC_VLAN_CFG                        0x33UL
   143		#define HWRM_FUNC_VLAN_QCFG                       0x34UL
   144		#define HWRM_QUEUE_PFCENABLE_QCFG                 0x35UL
   145		#define HWRM_QUEUE_PFCENABLE_CFG                  0x36UL
   146		#define HWRM_QUEUE_PRI2COS_QCFG                   0x37UL
   147		#define HWRM_QUEUE_PRI2COS_CFG                    0x38UL
   148		#define HWRM_QUEUE_COS2BW_QCFG                    0x39UL
   149		#define HWRM_QUEUE_COS2BW_CFG                     0x3aUL
   150		#define HWRM_QUEUE_DSCP_QCAPS                     0x3bUL
   151		#define HWRM_QUEUE_DSCP2PRI_QCFG                  0x3cUL
   152		#define HWRM_QUEUE_DSCP2PRI_CFG                   0x3dUL
   153		#define HWRM_VNIC_ALLOC                           0x40UL
   154		#define HWRM_VNIC_FREE                            0x41UL
   155		#define HWRM_VNIC_CFG                             0x42UL
   156		#define HWRM_VNIC_QCFG                            0x43UL
   157		#define HWRM_VNIC_TPA_CFG                         0x44UL
   158		#define HWRM_VNIC_TPA_QCFG                        0x45UL
   159		#define HWRM_VNIC_RSS_CFG                         0x46UL
   160		#define HWRM_VNIC_RSS_QCFG                        0x47UL
   161		#define HWRM_VNIC_PLCMODES_CFG                    0x48UL
   162		#define HWRM_VNIC_PLCMODES_QCFG                   0x49UL
   163		#define HWRM_VNIC_QCAPS                           0x4aUL
   164		#define HWRM_VNIC_UPDATE                          0x4bUL
   165		#define HWRM_RING_ALLOC                           0x50UL
   166		#define HWRM_RING_FREE                            0x51UL
   167		#define HWRM_RING_CMPL_RING_QAGGINT_PARAMS        0x52UL
   168		#define HWRM_RING_CMPL_RING_CFG_AGGINT_PARAMS     0x53UL
   169		#define HWRM_RING_AGGINT_QCAPS                    0x54UL
   170		#define HWRM_RING_SCHQ_ALLOC                      0x55UL
   171		#define HWRM_RING_SCHQ_CFG                        0x56UL
   172		#define HWRM_RING_SCHQ_FREE                       0x57UL
   173		#define HWRM_RING_RESET                           0x5eUL
   174		#define HWRM_RING_GRP_ALLOC                       0x60UL
   175		#define HWRM_RING_GRP_FREE                        0x61UL
   176		#define HWRM_RING_CFG                             0x62UL
   177		#define HWRM_RING_QCFG                            0x63UL
   178		#define HWRM_RESERVED5                            0x64UL
   179		#define HWRM_RESERVED6                            0x65UL
   180		#define HWRM_VNIC_RSS_COS_LB_CTX_ALLOC            0x70UL
   181		#define HWRM_VNIC_RSS_COS_LB_CTX_FREE             0x71UL
   182		#define HWRM_PSP_CFG                              0x72UL
   183		#define HWRM_QUEUE_MPLS_QCAPS                     0x80UL
   184		#define HWRM_QUEUE_MPLSTC2PRI_QCFG                0x81UL
   185		#define HWRM_QUEUE_MPLSTC2PRI_CFG                 0x82UL
   186		#define HWRM_QUEUE_VLANPRI_QCAPS                  0x83UL
   187		#define HWRM_QUEUE_VLANPRI2PRI_QCFG               0x84UL
   188		#define HWRM_QUEUE_VLANPRI2PRI_CFG                0x85UL
   189		#define HWRM_QUEUE_GLOBAL_CFG                     0x86UL
   190		#define HWRM_QUEUE_GLOBAL_QCFG                    0x87UL
   191		#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_QCFG      0x88UL
   192		#define HWRM_QUEUE_ADPTV_QOS_RX_FEATURE_CFG       0x89UL
   193		#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_QCFG      0x8aUL
   194		#define HWRM_QUEUE_ADPTV_QOS_TX_FEATURE_CFG       0x8bUL
   195		#define HWRM_QUEUE_QCAPS                          0x8cUL
   196		#define HWRM_QUEUE_ADPTV_QOS_RX_TUNING_QCFG       0x8dUL
   197		#define HWRM_QUEUE_ADPTV_QOS_RX_TUNING_CFG        0x8eUL
   198		#define HWRM_QUEUE_ADPTV_QOS_TX_TUNING_QCFG       0x8fUL
   199		#define HWRM_CFA_L2_FILTER_ALLOC                  0x90UL
   200		#define HWRM_CFA_L2_FILTER_FREE                   0x91UL
   201		#define HWRM_CFA_L2_FILTER_CFG                    0x92UL
   202		#define HWRM_CFA_L2_SET_RX_MASK                   0x93UL
   203		#define HWRM_CFA_VLAN_ANTISPOOF_CFG               0x94UL
   204		#define HWRM_CFA_TUNNEL_FILTER_ALLOC              0x95UL
   205		#define HWRM_CFA_TUNNEL_FILTER_FREE               0x96UL
   206		#define HWRM_CFA_ENCAP_RECORD_ALLOC               0x97UL
   207		#define HWRM_CFA_ENCAP_RECORD_FREE                0x98UL
   208		#define HWRM_CFA_NTUPLE_FILTER_ALLOC              0x99UL
   209		#define HWRM_CFA_NTUPLE_FILTER_FREE               0x9aUL
   210		#define HWRM_CFA_NTUPLE_FILTER_CFG                0x9bUL
   211		#define HWRM_CFA_EM_FLOW_ALLOC                    0x9cUL
   212		#define HWRM_CFA_EM_FLOW_FREE                     0x9dUL
   213		#define HWRM_CFA_EM_FLOW_CFG                      0x9eUL
   214		#define HWRM_TUNNEL_DST_PORT_QUERY                0xa0UL
   215		#define HWRM_TUNNEL_DST_PORT_ALLOC                0xa1UL
   216		#define HWRM_TUNNEL_DST_PORT_FREE                 0xa2UL
   217		#define HWRM_QUEUE_ADPTV_QOS_TX_TUNING_CFG        0xa3UL
   218		#define HWRM_STAT_CTX_ENG_QUERY                   0xafUL
   219		#define HWRM_STAT_CTX_ALLOC                       0xb0UL
   220		#define HWRM_STAT_CTX_FREE                        0xb1UL
   221		#define HWRM_STAT_CTX_QUERY                       0xb2UL
   222		#define HWRM_STAT_CTX_CLR_STATS                   0xb3UL
   223		#define HWRM_PORT_QSTATS_EXT                      0xb4UL
   224		#define HWRM_PORT_PHY_MDIO_WRITE                  0xb5UL
   225		#define HWRM_PORT_PHY_MDIO_READ                   0xb6UL
   226		#define HWRM_PORT_PHY_MDIO_BUS_ACQUIRE            0xb7UL
   227		#define HWRM_PORT_PHY_MDIO_BUS_RELEASE            0xb8UL
   228		#define HWRM_PORT_QSTATS_EXT_PFC_WD               0xb9UL
   229		#define HWRM_PORT_QSTATS_EXT_PFC_ADV              0xbaUL
   230		#define HWRM_PORT_TX_FIR_CFG                      0xbbUL
   231		#define HWRM_PORT_TX_FIR_QCFG                     0xbcUL
   232		#define HWRM_PORT_ECN_QSTATS                      0xbdUL
   233		#define HWRM_FW_LIVEPATCH_QUERY                   0xbeUL
   234		#define HWRM_FW_LIVEPATCH                         0xbfUL
   235		#define HWRM_FW_RESET                             0xc0UL
   236		#define HWRM_FW_QSTATUS                           0xc1UL
   237		#define HWRM_FW_HEALTH_CHECK                      0xc2UL
   238		#define HWRM_FW_SYNC                              0xc3UL
   239		#define HWRM_FW_STATE_QCAPS                       0xc4UL
   240		#define HWRM_FW_STATE_QUIESCE                     0xc5UL
   241		#define HWRM_FW_STATE_BACKUP                      0xc6UL
   242		#define HWRM_FW_STATE_RESTORE                     0xc7UL
   243		#define HWRM_FW_SET_TIME                          0xc8UL
   244		#define HWRM_FW_GET_TIME                          0xc9UL
   245		#define HWRM_FW_SET_STRUCTURED_DATA               0xcaUL
   246		#define HWRM_FW_GET_STRUCTURED_DATA               0xcbUL
   247		#define HWRM_FW_IPC_MAILBOX                       0xccUL
   248		#define HWRM_FW_ECN_CFG                           0xcdUL
   249		#define HWRM_FW_ECN_QCFG                          0xceUL
   250		#define HWRM_FW_SECURE_CFG                        0xcfUL
   251		#define HWRM_EXEC_FWD_RESP                        0xd0UL
   252		#define HWRM_REJECT_FWD_RESP                      0xd1UL
   253		#define HWRM_FWD_RESP                             0xd2UL
   254		#define HWRM_FWD_ASYNC_EVENT_CMPL                 0xd3UL
   255		#define HWRM_OEM_CMD                              0xd4UL
   256		#define HWRM_PORT_PRBS_TEST                       0xd5UL
   257		#define HWRM_PORT_SFP_SIDEBAND_CFG                0xd6UL
   258		#define HWRM_PORT_SFP_SIDEBAND_QCFG               0xd7UL
   259		#define HWRM_FW_STATE_UNQUIESCE                   0xd8UL
   260		#define HWRM_PORT_DSC_DUMP                        0xd9UL
   261		#define HWRM_PORT_EP_TX_QCFG                      0xdaUL
   262		#define HWRM_PORT_EP_TX_CFG                       0xdbUL
   263		#define HWRM_PORT_CFG                             0xdcUL
   264		#define HWRM_PORT_QCFG                            0xddUL
   265		#define HWRM_PORT_MAC_QCAPS                       0xdfUL
   266		#define HWRM_TEMP_MONITOR_QUERY                   0xe0UL
   267		#define HWRM_REG_POWER_QUERY                      0xe1UL
   268		#define HWRM_CORE_FREQUENCY_QUERY                 0xe2UL
   269		#define HWRM_REG_POWER_HISTOGRAM                  0xe3UL
   270		#define HWRM_MONITOR_PAX_HISTOGRAM_START          0xe4UL
   271		#define HWRM_MONITOR_PAX_HISTOGRAM_COLLECT        0xe5UL
   272		#define HWRM_STAT_QUERY_ROCE_STATS                0xe6UL
   273		#define HWRM_STAT_QUERY_ROCE_STATS_EXT            0xe7UL
   274		#define HWRM_WOL_FILTER_ALLOC                     0xf0UL
   275		#define HWRM_WOL_FILTER_FREE                      0xf1UL
   276		#define HWRM_WOL_FILTER_QCFG                      0xf2UL
   277		#define HWRM_WOL_REASON_QCFG                      0xf3UL
   278		#define HWRM_CFA_METER_QCAPS                      0xf4UL
   279		#define HWRM_CFA_METER_PROFILE_ALLOC              0xf5UL
   280		#define HWRM_CFA_METER_PROFILE_FREE               0xf6UL
   281		#define HWRM_CFA_METER_PROFILE_CFG                0xf7UL
   282		#define HWRM_CFA_METER_INSTANCE_ALLOC             0xf8UL
   283		#define HWRM_CFA_METER_INSTANCE_FREE              0xf9UL
   284		#define HWRM_CFA_METER_INSTANCE_CFG               0xfaUL
   285		#define HWRM_CFA_VFR_ALLOC                        0xfdUL
   286		#define HWRM_CFA_VFR_FREE                         0xfeUL
   287		#define HWRM_CFA_VF_PAIR_ALLOC                    0x100UL
   288		#define HWRM_CFA_VF_PAIR_FREE                     0x101UL
   289		#define HWRM_CFA_VF_PAIR_INFO                     0x102UL
   290		#define HWRM_CFA_FLOW_ALLOC                       0x103UL
   291		#define HWRM_CFA_FLOW_FREE                        0x104UL
   292		#define HWRM_CFA_FLOW_FLUSH                       0x105UL
   293		#define HWRM_CFA_FLOW_STATS                       0x106UL
   294		#define HWRM_CFA_FLOW_INFO                        0x107UL
   295		#define HWRM_CFA_DECAP_FILTER_ALLOC               0x108UL
   296		#define HWRM_CFA_DECAP_FILTER_FREE                0x109UL
   297		#define HWRM_CFA_VLAN_ANTISPOOF_QCFG              0x10aUL
   298		#define HWRM_CFA_REDIRECT_TUNNEL_TYPE_ALLOC       0x10bUL
   299		#define HWRM_CFA_REDIRECT_TUNNEL_TYPE_FREE        0x10cUL
   300		#define HWRM_CFA_PAIR_ALLOC                       0x10dUL
   301		#define HWRM_CFA_PAIR_FREE                        0x10eUL
   302		#define HWRM_CFA_PAIR_INFO                        0x10fUL
   303		#define HWRM_FW_IPC_MSG                           0x110UL
   304		#define HWRM_CFA_REDIRECT_TUNNEL_TYPE_INFO        0x111UL
   305		#define HWRM_CFA_REDIRECT_QUERY_TUNNEL_TYPE       0x112UL
   306		#define HWRM_CFA_FLOW_AGING_TIMER_RESET           0x113UL
   307		#define HWRM_CFA_FLOW_AGING_CFG                   0x114UL
   308		#define HWRM_CFA_FLOW_AGING_QCFG                  0x115UL
   309		#define HWRM_CFA_FLOW_AGING_QCAPS                 0x116UL
   310		#define HWRM_CFA_CTX_MEM_RGTR                     0x117UL
   311		#define HWRM_CFA_CTX_MEM_UNRGTR                   0x118UL
   312		#define HWRM_CFA_CTX_MEM_QCTX                     0x119UL
   313		#define HWRM_CFA_CTX_MEM_QCAPS                    0x11aUL
   314		#define HWRM_CFA_COUNTER_QCAPS                    0x11bUL
   315		#define HWRM_CFA_COUNTER_CFG                      0x11cUL
   316		#define HWRM_CFA_COUNTER_QCFG                     0x11dUL
   317		#define HWRM_CFA_COUNTER_QSTATS                   0x11eUL
   318		#define HWRM_CFA_TCP_FLAG_PROCESS_QCFG            0x11fUL
   319		#define HWRM_CFA_EEM_QCAPS                        0x120UL
   320		#define HWRM_CFA_EEM_CFG                          0x121UL
   321		#define HWRM_CFA_EEM_QCFG                         0x122UL
   322		#define HWRM_CFA_EEM_OP                           0x123UL
   323		#define HWRM_CFA_ADV_FLOW_MGNT_QCAPS              0x124UL
   324		#define HWRM_CFA_TFLIB                            0x125UL
   325		#define HWRM_CFA_LAG_GROUP_MEMBER_RGTR            0x126UL
   326		#define HWRM_CFA_LAG_GROUP_MEMBER_UNRGTR          0x127UL
   327		#define HWRM_CFA_TLS_FILTER_ALLOC                 0x128UL
   328		#define HWRM_CFA_TLS_FILTER_FREE                  0x129UL
   329		#define HWRM_CFA_RELEASE_AFM_FUNC                 0x12aUL
   330		#define HWRM_ENGINE_CKV_STATUS                    0x12eUL
   331		#define HWRM_ENGINE_CKV_CKEK_ADD                  0x12fUL
   332		#define HWRM_ENGINE_CKV_CKEK_DELETE               0x130UL
   333		#define HWRM_ENGINE_CKV_KEY_ADD                   0x131UL
   334		#define HWRM_ENGINE_CKV_KEY_DELETE                0x132UL
   335		#define HWRM_ENGINE_CKV_FLUSH                     0x133UL
   336		#define HWRM_ENGINE_CKV_RNG_GET                   0x134UL
   337		#define HWRM_ENGINE_CKV_KEY_GEN                   0x135UL
   338		#define HWRM_ENGINE_CKV_KEY_LABEL_CFG             0x136UL
   339		#define HWRM_ENGINE_CKV_KEY_LABEL_QCFG            0x137UL
   340		#define HWRM_ENGINE_QG_CONFIG_QUERY               0x13cUL
   341		#define HWRM_ENGINE_QG_QUERY                      0x13dUL
   342		#define HWRM_ENGINE_QG_METER_PROFILE_CONFIG_QUERY 0x13eUL
   343		#define HWRM_ENGINE_QG_METER_PROFILE_QUERY        0x13fUL
   344		#define HWRM_ENGINE_QG_METER_PROFILE_ALLOC        0x140UL
   345		#define HWRM_ENGINE_QG_METER_PROFILE_FREE         0x141UL
   346		#define HWRM_ENGINE_QG_METER_QUERY                0x142UL
   347		#define HWRM_ENGINE_QG_METER_BIND                 0x143UL
   348		#define HWRM_ENGINE_QG_METER_UNBIND               0x144UL
   349		#define HWRM_ENGINE_QG_FUNC_BIND                  0x145UL
   350		#define HWRM_ENGINE_SG_CONFIG_QUERY               0x146UL
   351		#define HWRM_ENGINE_SG_QUERY                      0x147UL
   352		#define HWRM_ENGINE_SG_METER_QUERY                0x148UL
   353		#define HWRM_ENGINE_SG_METER_CONFIG               0x149UL
   354		#define HWRM_ENGINE_SG_QG_BIND                    0x14aUL
   355		#define HWRM_ENGINE_QG_SG_UNBIND                  0x14bUL
   356		#define HWRM_ENGINE_CONFIG_QUERY                  0x154UL
   357		#define HWRM_ENGINE_STATS_CONFIG                  0x155UL
   358		#define HWRM_ENGINE_STATS_CLEAR                   0x156UL
   359		#define HWRM_ENGINE_STATS_QUERY                   0x157UL
   360		#define HWRM_ENGINE_STATS_QUERY_CONTINUOUS_ERROR  0x158UL
   361		#define HWRM_ENGINE_RQ_ALLOC                      0x15eUL
   362		#define HWRM_ENGINE_RQ_FREE                       0x15fUL
   363		#define HWRM_ENGINE_CQ_ALLOC                      0x160UL
   364		#define HWRM_ENGINE_CQ_FREE                       0x161UL
   365		#define HWRM_ENGINE_NQ_ALLOC                      0x162UL
   366		#define HWRM_ENGINE_NQ_FREE                       0x163UL
   367		#define HWRM_ENGINE_ON_DIE_RQE_CREDITS            0x164UL
   368		#define HWRM_ENGINE_FUNC_QCFG                     0x165UL
   369		#define HWRM_FUNC_RESOURCE_QCAPS                  0x190UL
   370		#define HWRM_FUNC_VF_RESOURCE_CFG                 0x191UL
   371		#define HWRM_FUNC_BACKING_STORE_QCAPS             0x192UL
   372		#define HWRM_FUNC_BACKING_STORE_CFG               0x193UL
   373		#define HWRM_FUNC_BACKING_STORE_QCFG              0x194UL
   374		#define HWRM_FUNC_VF_BW_CFG                       0x195UL
   375		#define HWRM_FUNC_VF_BW_QCFG                      0x196UL
   376		#define HWRM_FUNC_HOST_PF_IDS_QUERY               0x197UL
   377		#define HWRM_FUNC_QSTATS_EXT                      0x198UL
   378		#define HWRM_STAT_EXT_CTX_QUERY                   0x199UL
   379		#define HWRM_FUNC_SPD_CFG                         0x19aUL
   380		#define HWRM_FUNC_SPD_QCFG                        0x19bUL
   381		#define HWRM_FUNC_PTP_PIN_QCFG                    0x19cUL
   382		#define HWRM_FUNC_PTP_PIN_CFG                     0x19dUL
   383		#define HWRM_FUNC_PTP_CFG                         0x19eUL
   384		#define HWRM_FUNC_PTP_TS_QUERY                    0x19fUL
   385		#define HWRM_FUNC_PTP_EXT_CFG                     0x1a0UL
   386		#define HWRM_FUNC_PTP_EXT_QCFG                    0x1a1UL
   387		#define HWRM_FUNC_KEY_CTX_ALLOC                   0x1a2UL
   388		#define HWRM_FUNC_BACKING_STORE_CFG_V2            0x1a3UL
   389		#define HWRM_FUNC_BACKING_STORE_QCFG_V2           0x1a4UL
   390		#define HWRM_FUNC_DBR_PACING_CFG                  0x1a5UL
   391		#define HWRM_FUNC_DBR_PACING_QCFG                 0x1a6UL
   392		#define HWRM_FUNC_DBR_PACING_BROADCAST_EVENT      0x1a7UL
   393		#define HWRM_FUNC_BACKING_STORE_QCAPS_V2          0x1a8UL
   394		#define HWRM_FUNC_DBR_PACING_NQLIST_QUERY         0x1a9UL
   395		#define HWRM_FUNC_DBR_RECOVERY_COMPLETED          0x1aaUL
   396		#define HWRM_FUNC_SYNCE_CFG                       0x1abUL
   397		#define HWRM_FUNC_SYNCE_QCFG                      0x1acUL
   398		#define HWRM_FUNC_KEY_CTX_FREE                    0x1adUL
   399		#define HWRM_FUNC_LAG_MODE_CFG                    0x1aeUL
   400		#define HWRM_FUNC_LAG_MODE_QCFG                   0x1afUL
   401		#define HWRM_FUNC_LAG_CREATE                      0x1b0UL
   402		#define HWRM_FUNC_LAG_UPDATE                      0x1b1UL
   403		#define HWRM_FUNC_LAG_FREE                        0x1b2UL
   404		#define HWRM_FUNC_LAG_QCFG                        0x1b3UL
   405		#define HWRM_FUNC_TTX_PACING_RATE_PROF_QUERY      0x1c3UL
   406		#define HWRM_FUNC_TTX_PACING_RATE_QUERY           0x1c4UL
   407		#define HWRM_FUNC_PTP_QCFG                        0x1c5UL
   408		#define HWRM_SELFTEST_QLIST                       0x200UL
   409		#define HWRM_SELFTEST_EXEC                        0x201UL
   410		#define HWRM_SELFTEST_IRQ                         0x202UL
   411		#define HWRM_SELFTEST_RETRIEVE_SERDES_DATA        0x203UL
   412		#define HWRM_PCIE_QSTATS                          0x204UL
   413		#define HWRM_MFG_FRU_WRITE_CONTROL                0x205UL
   414		#define HWRM_MFG_TIMERS_QUERY                     0x206UL
   415		#define HWRM_MFG_OTP_CFG                          0x207UL
   416		#define HWRM_MFG_OTP_QCFG                         0x208UL
   417		#define HWRM_MFG_HDMA_TEST                        0x209UL
   418		#define HWRM_MFG_FRU_EEPROM_WRITE                 0x20aUL
   419		#define HWRM_MFG_FRU_EEPROM_READ                  0x20bUL
   420		#define HWRM_MFG_SOC_IMAGE                        0x20cUL
   421		#define HWRM_MFG_SOC_QSTATUS                      0x20dUL
   422		#define HWRM_MFG_PARAM_CRITICAL_DATA_FINALIZE     0x20eUL
   423		#define HWRM_MFG_PARAM_CRITICAL_DATA_READ         0x20fUL
   424		#define HWRM_MFG_PARAM_CRITICAL_DATA_HEALTH       0x210UL
   425		#define HWRM_MFG_PRVSN_EXPORT_CSR                 0x211UL
   426		#define HWRM_MFG_PRVSN_IMPORT_CERT                0x212UL
   427		#define HWRM_MFG_PRVSN_GET_STATE                  0x213UL
   428		#define HWRM_MFG_GET_NVM_MEASUREMENT              0x214UL
   429		#define HWRM_MFG_PSOC_QSTATUS                     0x215UL
   430		#define HWRM_MFG_SELFTEST_QLIST                   0x216UL
   431		#define HWRM_MFG_SELFTEST_EXEC                    0x217UL
   432		#define HWRM_STAT_GENERIC_QSTATS                  0x218UL
   433		#define HWRM_MFG_PRVSN_EXPORT_CERT                0x219UL
   434		#define HWRM_STAT_DB_ERROR_QSTATS                 0x21aUL
   435		#define HWRM_MFG_TESTS                            0x21bUL
   436		#define HWRM_MFG_WRITE_CERT_NVM                   0x21cUL
   437		#define HWRM_PORT_POE_CFG                         0x230UL
   438		#define HWRM_PORT_POE_QCFG                        0x231UL
   439		#define HWRM_PORT_PHY_FDRSTAT                     0x232UL
   440		#define HWRM_PORT_PHY_DBG                         0x23aUL
   441		#define HWRM_UDCC_QCAPS                           0x258UL
   442		#define HWRM_UDCC_CFG                             0x259UL
   443		#define HWRM_UDCC_QCFG                            0x25aUL
   444		#define HWRM_UDCC_SESSION_CFG                     0x25bUL
   445		#define HWRM_UDCC_SESSION_QCFG                    0x25cUL
   446		#define HWRM_UDCC_SESSION_QUERY                   0x25dUL
   447		#define HWRM_UDCC_COMP_CFG                        0x25eUL
   448		#define HWRM_UDCC_COMP_QCFG                       0x25fUL
   449		#define HWRM_UDCC_COMP_QUERY                      0x260UL
   450		#define HWRM_QUEUE_PFCWD_TIMEOUT_QCAPS            0x261UL
   451		#define HWRM_QUEUE_PFCWD_TIMEOUT_CFG              0x262UL
   452		#define HWRM_QUEUE_PFCWD_TIMEOUT_QCFG             0x263UL
   453		#define HWRM_QUEUE_ADPTV_QOS_RX_QCFG              0x264UL
   454		#define HWRM_QUEUE_ADPTV_QOS_TX_QCFG              0x265UL
   455		#define HWRM_TF                                   0x2bcUL
   456		#define HWRM_TF_VERSION_GET                       0x2bdUL
   457		#define HWRM_TF_SESSION_OPEN                      0x2c6UL
   458		#define HWRM_TF_SESSION_REGISTER                  0x2c8UL
   459		#define HWRM_TF_SESSION_UNREGISTER                0x2c9UL
   460		#define HWRM_TF_SESSION_CLOSE                     0x2caUL
   461		#define HWRM_TF_SESSION_QCFG                      0x2cbUL
   462		#define HWRM_TF_SESSION_RESC_QCAPS                0x2ccUL
   463		#define HWRM_TF_SESSION_RESC_ALLOC                0x2cdUL
   464		#define HWRM_TF_SESSION_RESC_FREE                 0x2ceUL
   465		#define HWRM_TF_SESSION_RESC_FLUSH                0x2cfUL
   466		#define HWRM_TF_SESSION_RESC_INFO                 0x2d0UL
   467		#define HWRM_TF_SESSION_HOTUP_STATE_SET           0x2d1UL
   468		#define HWRM_TF_SESSION_HOTUP_STATE_GET           0x2d2UL
   469		#define HWRM_TF_TBL_TYPE_GET                      0x2daUL
   470		#define HWRM_TF_TBL_TYPE_SET                      0x2dbUL
   471		#define HWRM_TF_TBL_TYPE_BULK_GET                 0x2dcUL
   472		#define HWRM_TF_EM_INSERT                         0x2eaUL
   473		#define HWRM_TF_EM_DELETE                         0x2ebUL
   474		#define HWRM_TF_EM_HASH_INSERT                    0x2ecUL
   475		#define HWRM_TF_EM_MOVE                           0x2edUL
   476		#define HWRM_TF_TCAM_SET                          0x2f8UL
   477		#define HWRM_TF_TCAM_GET                          0x2f9UL
   478		#define HWRM_TF_TCAM_MOVE                         0x2faUL
   479		#define HWRM_TF_TCAM_FREE                         0x2fbUL
   480		#define HWRM_TF_GLOBAL_CFG_SET                    0x2fcUL
   481		#define HWRM_TF_GLOBAL_CFG_GET                    0x2fdUL
   482		#define HWRM_TF_IF_TBL_SET                        0x2feUL
   483		#define HWRM_TF_IF_TBL_GET                        0x2ffUL
   484		#define HWRM_TF_RESC_USAGE_SET                    0x300UL
   485		#define HWRM_TF_RESC_USAGE_QUERY                  0x301UL
   486		#define HWRM_TF_TBL_TYPE_ALLOC                    0x302UL
   487		#define HWRM_TF_TBL_TYPE_FREE                     0x303UL
   488		#define HWRM_TFC_TBL_SCOPE_QCAPS                  0x380UL
   489		#define HWRM_TFC_TBL_SCOPE_ID_ALLOC               0x381UL
   490		#define HWRM_TFC_TBL_SCOPE_CONFIG                 0x382UL
   491		#define HWRM_TFC_TBL_SCOPE_DECONFIG               0x383UL
   492		#define HWRM_TFC_TBL_SCOPE_FID_ADD                0x384UL
   493		#define HWRM_TFC_TBL_SCOPE_FID_REM                0x385UL
   494		#define HWRM_TFC_TBL_SCOPE_POOL_ALLOC             0x386UL
   495		#define HWRM_TFC_TBL_SCOPE_POOL_FREE              0x387UL
   496		#define HWRM_TFC_SESSION_ID_ALLOC                 0x388UL
   497		#define HWRM_TFC_SESSION_FID_ADD                  0x389UL
   498		#define HWRM_TFC_SESSION_FID_REM                  0x38aUL
   499		#define HWRM_TFC_IDENT_ALLOC                      0x38bUL
   500		#define HWRM_TFC_IDENT_FREE                       0x38cUL
   501		#define HWRM_TFC_IDX_TBL_ALLOC                    0x38dUL
   502		#define HWRM_TFC_IDX_TBL_ALLOC_SET                0x38eUL
   503		#define HWRM_TFC_IDX_TBL_SET                      0x38fUL
   504		#define HWRM_TFC_IDX_TBL_GET                      0x390UL
   505		#define HWRM_TFC_IDX_TBL_FREE                     0x391UL
   506		#define HWRM_TFC_GLOBAL_ID_ALLOC                  0x392UL
   507		#define HWRM_TFC_TCAM_SET                         0x393UL
   508		#define HWRM_TFC_TCAM_GET                         0x394UL
   509		#define HWRM_TFC_TCAM_ALLOC                       0x395UL
   510		#define HWRM_TFC_TCAM_ALLOC_SET                   0x396UL
   511		#define HWRM_TFC_TCAM_FREE                        0x397UL
   512		#define HWRM_TFC_IF_TBL_SET                       0x398UL
   513		#define HWRM_TFC_IF_TBL_GET                       0x399UL
   514		#define HWRM_TFC_TBL_SCOPE_CONFIG_GET             0x39aUL
   515		#define HWRM_TFC_RESC_USAGE_QUERY                 0x39bUL
   516		#define HWRM_TFC_GLOBAL_ID_FREE                   0x39cUL
   517		#define HWRM_TFC_TCAM_PRI_UPDATE                  0x39dUL
   518		#define HWRM_TFC_HOT_UPGRADE_PROCESS              0x3a0UL
   519		#define HWRM_TFC_SPR_BA_SET                       0x3a1UL
   520		#define HWRM_TFC_SPR_BA_GET                       0x3a2UL
   521		#define HWRM_MGMT_FILTER_ALLOC                    0x3e8UL
   522		#define HWRM_MGMT_FILTER_FREE                     0x3e9UL
   523		#define HWRM_MGMT_FILTER_CFG                      0x3eaUL
   524		#define HWRM_SV                                   0x400UL
   525		#define HWRM_DBG_SERDES_TEST                      0xff0eUL
   526		#define HWRM_DBG_LOG_BUFFER_FLUSH                 0xff0fUL
   527		#define HWRM_DBG_READ_DIRECT                      0xff10UL
   528		#define HWRM_DBG_READ_INDIRECT                    0xff11UL
   529		#define HWRM_DBG_WRITE_DIRECT                     0xff12UL
   530		#define HWRM_DBG_WRITE_INDIRECT                   0xff13UL
   531		#define HWRM_DBG_DUMP                             0xff14UL
   532		#define HWRM_DBG_ERASE_NVM                        0xff15UL
   533		#define HWRM_DBG_CFG                              0xff16UL
   534		#define HWRM_DBG_COREDUMP_LIST                    0xff17UL
   535		#define HWRM_DBG_COREDUMP_INITIATE                0xff18UL
   536		#define HWRM_DBG_COREDUMP_RETRIEVE                0xff19UL
   537		#define HWRM_DBG_FW_CLI                           0xff1aUL
   538		#define HWRM_DBG_I2C_CMD                          0xff1bUL
   539		#define HWRM_DBG_RING_INFO_GET                    0xff1cUL
   540		#define HWRM_DBG_CRASHDUMP_HEADER                 0xff1dUL
   541		#define HWRM_DBG_CRASHDUMP_ERASE                  0xff1eUL
   542		#define HWRM_DBG_DRV_TRACE                        0xff1fUL
   543		#define HWRM_DBG_QCAPS                            0xff20UL
   544		#define HWRM_DBG_QCFG                             0xff21UL
   545		#define HWRM_DBG_CRASHDUMP_MEDIUM_CFG             0xff22UL
   546		#define HWRM_DBG_USEQ_ALLOC                       0xff23UL
   547		#define HWRM_DBG_USEQ_FREE                        0xff24UL
   548		#define HWRM_DBG_USEQ_FLUSH                       0xff25UL
   549		#define HWRM_DBG_USEQ_QCAPS                       0xff26UL
   550		#define HWRM_DBG_USEQ_CW_CFG                      0xff27UL
   551		#define HWRM_DBG_USEQ_SCHED_CFG                   0xff28UL
   552		#define HWRM_DBG_USEQ_RUN                         0xff29UL
   553		#define HWRM_DBG_USEQ_DELIVERY_REQ                0xff2aUL
   554		#define HWRM_DBG_USEQ_RESP_HDR                    0xff2bUL
   555		#define HWRM_DBG_COREDUMP_CAPTURE                 0xff2cUL
   556		#define HWRM_DBG_PTRACE                           0xff2dUL
   557		#define HWRM_DBG_SIM_CABLE_STATE                  0xff2eUL
   558		#define HWRM_DBG_TOKEN_QUERY_AUTH_IDS             0xff2fUL
   559		#define HWRM_DBG_TOKEN_CFG                        0xff30UL
   560		#define HWRM_DBG_TRACE_TRIGGER                    0xff31UL
   561		#define HWRM_DBG_TRACE_TRIGGER_STATUS             0xff32UL
   562		#define HWRM_NVM_SET_PROFILE                      0xffe9UL
   563		#define HWRM_NVM_GET_VPD_FIELD_INFO               0xffeaUL
   564		#define HWRM_NVM_SET_VPD_FIELD_INFO               0xffebUL
   565		#define HWRM_NVM_DEFRAG                           0xffecUL
   566		#define HWRM_NVM_REQ_ARBITRATION                  0xffedUL
   567		#define HWRM_NVM_FACTORY_DEFAULTS                 0xffeeUL
   568		#define HWRM_NVM_VALIDATE_OPTION                  0xffefUL
   569		#define HWRM_NVM_FLUSH                            0xfff0UL
   570		#define HWRM_NVM_GET_VARIABLE                     0xfff1UL
   571		#define HWRM_NVM_SET_VARIABLE                     0xfff2UL
   572		#define HWRM_NVM_INSTALL_UPDATE                   0xfff3UL
   573		#define HWRM_NVM_MODIFY                           0xfff4UL
   574		#define HWRM_NVM_VERIFY_UPDATE                    0xfff5UL
   575		#define HWRM_NVM_GET_DEV_INFO                     0xfff6UL
   576		#define HWRM_NVM_ERASE_DIR_ENTRY                  0xfff7UL
   577		#define HWRM_NVM_MOD_DIR_ENTRY                    0xfff8UL
   578		#define HWRM_NVM_FIND_DIR_ENTRY                   0xfff9UL
   579		#define HWRM_NVM_GET_DIR_ENTRIES                  0xfffaUL
   580		#define HWRM_NVM_GET_DIR_INFO                     0xfffbUL
   581		#define HWRM_NVM_RAW_DUMP                         0xfffcUL
   582		#define HWRM_NVM_READ                             0xfffdUL
   583		#define HWRM_NVM_WRITE                            0xfffeUL
   584		#define HWRM_NVM_RAW_WRITE_BLK                    0xffffUL
   585		#define HWRM_LAST                                HWRM_NVM_RAW_WRITE_BLK
   586		__le16	unused_0[3];
   587	};
   588	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

