Return-Path: <netdev+bounces-255396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COZKNZf9fWk2UwIAu9opvQ
	(envelope-from <netdev+bounces-255396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:03:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38838C1DEE
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D33253008233
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DE2348896;
	Sat, 31 Jan 2026 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBdi7HTI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEDC2877E5;
	Sat, 31 Jan 2026 13:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769864597; cv=none; b=Zbwhp+N/uDGkXEBASYDkoISI9ATtX/rHsT0afjgGa8MS4s9nB8ZdLrcqGXWkzj2HHlunvEAw6dBXdvX/o1Ka1a3erG1nLlD3CK8qVXbPiPhEjP5zPzrTKT2MhRRQ33WPNfktaDlf96WX+Yaz43+B3YEVXkRtgyhYORMzAq915ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769864597; c=relaxed/simple;
	bh=kVGTF110mxeU2LgBe9IupGDIxUgzF+xKZmSBK/d5agY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSAQ50OxF2hQtxFiPEW/vmAJk8ppXoZ7M8VHIrgClfobmNH//yG8qbQKV8dOLXjwYv53bsZLw9iXGGkvD8LOLxO/04r8lWGOsr1EMv2y/9rXj6QmzfZMhlMmXNK7cgescuVQHpi4hk+bO9JYKu6H1hvG+/05kYd6r2pmWo07rkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBdi7HTI; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769864595; x=1801400595;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kVGTF110mxeU2LgBe9IupGDIxUgzF+xKZmSBK/d5agY=;
  b=VBdi7HTIlO4JXy0VqKeh3RlRjVM+LXYlkAn79x84kYKX572HqjGrmTnB
   cmhNK7631RdrYFbcI16jOrS3QK1eubSiY3tja0BUj7czcPlsD/rBHxrTq
   i+fDpeKrpU7+cDpVV0y8iI41r6oH6OqSHamP2mEvadW8GzL/pBsi0zHNy
   2J/y/HWpzo/Cg0gwc+WpqPV8e6sEtGjJ8Oa5bhTZBD38Vahgqh+LdIsfA
   ighfnEQ2Dx0i7xmQICzh23cpCe8tZ5F3eD9qmlvwFpvpLhBxV63aC+Jwt
   9zoLrSr+au5wOtlwsI219yqqogp5pwH0uqa11hRCKI98afvcLQ/4+iW5B
   w==;
X-CSE-ConnectionGUID: dvkFpDr7TLS18kobkkSdxQ==
X-CSE-MsgGUID: p7ViKt+gQXWi5nAYJl9WaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="81410511"
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="81410511"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2026 05:03:15 -0800
X-CSE-ConnectionGUID: N8g1LtsuQxqhBFEGXup48w==
X-CSE-MsgGUID: e6oji5efTaG9+ig5eb41CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,265,1763452800"; 
   d="scan'208";a="209478549"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 31 Jan 2026 05:03:10 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vmAd2-00000000e2m-14qu;
	Sat, 31 Jan 2026 13:03:08 +0000
Date: Sat, 31 Jan 2026 21:02:48 +0800
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
Message-ID: <202601312052.Ov3kuezz-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255396-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Queue-Id: 38838C1DEE
X-Rspamd-Action: no action

Hi Vikas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Vikas-Gupta/bnge-Add-a-new-HSI/20260131-103758
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260131023133.836333-1-vikas.gupta%40broadcom.com
patch subject: [net-next] bnge: Add a new HSI
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20260131/202601312052.Ov3kuezz-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260131/202601312052.Ov3kuezz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601312052.Ov3kuezz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/broadcom/bnge/bnge.h:11,
                    from drivers/infiniband/hw/bng_re/bng_dev.c:13:
   include/linux/bnge/hsi.h:10:8: error: redefinition of 'struct hwrm_cmd_hdr'
      10 | struct hwrm_cmd_hdr {
         |        ^~~~~~~~~~~~
   In file included from drivers/infiniband/hw/bnxt_re/roce_hsi.h:43,
                    from drivers/infiniband/hw/bng_re/bng_res.h:7,
                    from drivers/infiniband/hw/bng_re/bng_dev.c:10:
   include/linux/bnxt/hsi.h:18:8: note: originally defined here
      18 | struct hwrm_cmd_hdr {
         |        ^~~~~~~~~~~~
   include/linux/bnge/hsi.h:19:8: error: redefinition of 'struct hwrm_resp_hdr'
      19 | struct hwrm_resp_hdr {
         |        ^~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:27:8: note: originally defined here
      27 | struct hwrm_resp_hdr {
         |        ^~~~~~~~~~~~~
   include/linux/bnge/hsi.h:52:8: error: redefinition of 'struct tlv'
      52 | struct tlv {
         |        ^~~
   include/linux/bnxt/hsi.h:62:8: note: originally defined here
      62 | struct tlv {
         |        ^~~
   include/linux/bnge/hsi.h:68:8: error: redefinition of 'struct input'
      68 | struct input {
         |        ^~~~~
   include/linux/bnxt/hsi.h:78:8: note: originally defined here
      78 | struct input {
         |        ^~~~~
   include/linux/bnge/hsi.h:77:8: error: redefinition of 'struct output'
      77 | struct output {
         |        ^~~~~~
   include/linux/bnxt/hsi.h:87:8: note: originally defined here
      87 | struct output {
         |        ^~~~~~
   include/linux/bnge/hsi.h:85:8: error: redefinition of 'struct hwrm_short_input'
      85 | struct hwrm_short_input {
         |        ^~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:95:8: note: originally defined here
      95 | struct hwrm_short_input {
         |        ^~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:99:8: error: redefinition of 'struct cmd_nums'
      99 | struct cmd_nums {
         |        ^~~~~~~~
   include/linux/bnxt/hsi.h:109:8: note: originally defined here
     109 | struct cmd_nums {
         |        ^~~~~~~~
   include/linux/bnge/hsi.h:590:8: error: redefinition of 'struct ret_codes'
     590 | struct ret_codes {
         |        ^~~~~~~~~
   include/linux/bnxt/hsi.h:593:8: note: originally defined here
     593 | struct ret_codes {
         |        ^~~~~~~~~
   include/linux/bnge/hsi.h:621:8: error: redefinition of 'struct hwrm_err_output'
     621 | struct hwrm_err_output {
         |        ^~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:624:8: note: originally defined here
     624 | struct hwrm_err_output {
         |        ^~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:643:9: warning: 'HWRM_VERSION_MINOR' redefined
     643 | #define HWRM_VERSION_MINOR 15
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:645:9: note: this is the location of the previous definition
     645 | #define HWRM_VERSION_MINOR 10
         |         ^~~~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:644:9: warning: 'HWRM_VERSION_UPDATE' redefined
     644 | #define HWRM_VERSION_UPDATE 1
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:646:9: note: this is the location of the previous definition
     646 | #define HWRM_VERSION_UPDATE 3
         |         ^~~~~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:645:9: warning: 'HWRM_VERSION_RSVD' redefined
     645 | #define HWRM_VERSION_RSVD 1
         |         ^~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:647:9: note: this is the location of the previous definition
     647 | #define HWRM_VERSION_RSVD 151
         |         ^~~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:646:9: warning: 'HWRM_VERSION_STR' redefined
     646 | #define HWRM_VERSION_STR "1.15.1.1"
         |         ^~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:648:9: note: this is the location of the previous definition
     648 | #define HWRM_VERSION_STR "1.10.3.151"
         |         ^~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:649:8: error: redefinition of 'struct hwrm_ver_get_input'
     649 | struct hwrm_ver_get_input {
         |        ^~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:651:8: note: originally defined here
     651 | struct hwrm_ver_get_input {
         |        ^~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:662:8: error: redefinition of 'struct hwrm_ver_get_output'
     662 | struct hwrm_ver_get_output {
         |        ^~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:664:8: note: originally defined here
     664 | struct hwrm_ver_get_output {
         |        ^~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:762:8: error: redefinition of 'struct eject_cmpl'
     762 | struct eject_cmpl {
         |        ^~~~~~~~~~
   include/linux/bnxt/hsi.h:758:8: note: originally defined here
     758 | struct eject_cmpl {
         |        ^~~~~~~~~~
   include/linux/bnge/hsi.h:789:8: error: redefinition of 'struct hwrm_cmpl'
     789 | struct hwrm_cmpl {
         |        ^~~~~~~~~
   include/linux/bnxt/hsi.h:785:8: note: originally defined here
     785 | struct hwrm_cmpl {
         |        ^~~~~~~~~
   include/linux/bnge/hsi.h:803:8: error: redefinition of 'struct hwrm_fwd_req_cmpl'
     803 | struct hwrm_fwd_req_cmpl {
         |        ^~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:799:8: note: originally defined here
     799 | struct hwrm_fwd_req_cmpl {
         |        ^~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:820:8: error: redefinition of 'struct hwrm_fwd_resp_cmpl'
     820 | struct hwrm_fwd_resp_cmpl {
         |        ^~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:816:8: note: originally defined here
     816 | struct hwrm_fwd_resp_cmpl {
         |        ^~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:836:8: error: redefinition of 'struct hwrm_async_event_cmpl'
     836 | struct hwrm_async_event_cmpl {
         |        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:832:8: note: originally defined here
     832 | struct hwrm_async_event_cmpl {
         |        ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:894:17: warning: 'ASYNC_EVENT_CMPL_EVENT_ID_ADPTV_QOS' redefined
     894 |         #define ASYNC_EVENT_CMPL_EVENT_ID_ADPTV_QOS                       0x53UL
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:888:17: note: this is the location of the previous definition
     888 |         #define ASYNC_EVENT_CMPL_EVENT_ID_ADPTV_QOS                       0x51UL
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:896:17: warning: 'ASYNC_EVENT_CMPL_EVENT_ID_MAX_RGTR_EVENT_ID' redefined
     896 |         #define ASYNC_EVENT_CMPL_EVENT_ID_MAX_RGTR_EVENT_ID               0x55UL
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:889:17: note: this is the location of the previous definition
     889 |         #define ASYNC_EVENT_CMPL_EVENT_ID_MAX_RGTR_EVENT_ID               0x52UL
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:912:8: error: redefinition of 'struct hwrm_async_event_cmpl_link_status_change'
     912 | struct hwrm_async_event_cmpl_link_status_change {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:904:8: note: originally defined here
     904 | struct hwrm_async_event_cmpl_link_status_change {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:942:8: error: redefinition of 'struct hwrm_async_event_cmpl_port_conn_not_allowed'
     942 | struct hwrm_async_event_cmpl_port_conn_not_allowed {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:934:8: note: originally defined here
     934 | struct hwrm_async_event_cmpl_port_conn_not_allowed {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:971:8: error: redefinition of 'struct hwrm_async_event_cmpl_link_speed_cfg_change'
     971 | struct hwrm_async_event_cmpl_link_speed_cfg_change {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:963:8: note: originally defined here
     963 | struct hwrm_async_event_cmpl_link_speed_cfg_change {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:995:8: error: redefinition of 'struct hwrm_async_event_cmpl_reset_notify'
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
>> include/linux/bnge/hsi.h:1374:17: warning: 'ASYNC_EVENT_CMPL_DBG_BUF_PRODUCER_EVENT_DATA1_TYPE_LAST' redefined
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
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/bnge/hsi.h:1435:17: warning: 'ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_LAST' redefined
    1435 |         #define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_LAST                         ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_VNIC_ERR
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1424:17: note: this is the location of the previous definition
    1424 |         #define ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_LAST                         ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_L2_TX_RING
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1439:8: error: redefinition of 'struct hwrm_async_event_cmpl_error_report_pause_storm'
    1439 | struct hwrm_async_event_cmpl_error_report_pause_storm {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1428:8: note: originally defined here
    1428 | struct hwrm_async_event_cmpl_error_report_pause_storm {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1463:8: error: redefinition of 'struct hwrm_async_event_cmpl_error_report_invalid_signal'
    1463 | struct hwrm_async_event_cmpl_error_report_invalid_signal {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1452:8: note: originally defined here
    1452 | struct hwrm_async_event_cmpl_error_report_invalid_signal {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1489:8: error: redefinition of 'struct hwrm_async_event_cmpl_error_report_nvm'
    1489 | struct hwrm_async_event_cmpl_error_report_nvm {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1478:8: note: originally defined here
    1478 | struct hwrm_async_event_cmpl_error_report_nvm {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1520:8: error: redefinition of 'struct hwrm_async_event_cmpl_error_report_doorbell_drop_threshold'
    1520 | struct hwrm_async_event_cmpl_error_report_doorbell_drop_threshold {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1509:8: note: originally defined here
    1509 | struct hwrm_async_event_cmpl_error_report_doorbell_drop_threshold {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1546:8: error: redefinition of 'struct hwrm_async_event_cmpl_error_report_thermal'
    1546 | struct hwrm_async_event_cmpl_error_report_thermal {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1535:8: note: originally defined here
    1535 | struct hwrm_async_event_cmpl_error_report_thermal {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1585:8: error: redefinition of 'struct hwrm_async_event_cmpl_error_report_dual_data_rate_not_supported'
    1585 | struct hwrm_async_event_cmpl_error_report_dual_data_rate_not_supported {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1574:8: note: originally defined here
    1574 | struct hwrm_async_event_cmpl_error_report_dual_data_rate_not_supported {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1609:8: error: redefinition of 'struct hwrm_func_reset_input'
    1609 | struct hwrm_func_reset_input {
         |        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1598:8: note: originally defined here
    1598 | struct hwrm_func_reset_input {
         |        ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1628:8: error: redefinition of 'struct hwrm_func_reset_output'
    1628 | struct hwrm_func_reset_output {
         |        ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1617:8: note: originally defined here
    1617 | struct hwrm_func_reset_output {
         |        ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1638:8: error: redefinition of 'struct hwrm_func_getfid_input'
    1638 | struct hwrm_func_getfid_input {
         |        ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1627:8: note: originally defined here
    1627 | struct hwrm_func_getfid_input {
         |        ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1651:8: error: redefinition of 'struct hwrm_func_getfid_output'
    1651 | struct hwrm_func_getfid_output {
         |        ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1640:8: note: originally defined here
    1640 | struct hwrm_func_getfid_output {
         |        ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1662:8: error: redefinition of 'struct hwrm_func_vf_alloc_input'
    1662 | struct hwrm_func_vf_alloc_input {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1651:8: note: originally defined here
    1651 | struct hwrm_func_vf_alloc_input {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1675:8: error: redefinition of 'struct hwrm_func_vf_alloc_output'
    1675 | struct hwrm_func_vf_alloc_output {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1664:8: note: originally defined here
    1664 | struct hwrm_func_vf_alloc_output {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1686:8: error: redefinition of 'struct hwrm_func_vf_free_input'
    1686 | struct hwrm_func_vf_free_input {
         |        ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1675:8: note: originally defined here
    1675 | struct hwrm_func_vf_free_input {
         |        ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1699:8: error: redefinition of 'struct hwrm_func_vf_free_output'
    1699 | struct hwrm_func_vf_free_output {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1688:8: note: originally defined here
    1688 | struct hwrm_func_vf_free_output {
         |        ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1709:8: error: redefinition of 'struct hwrm_func_vf_cfg_input'
    1709 | struct hwrm_func_vf_cfg_input {
         |        ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1698:8: note: originally defined here
    1698 | struct hwrm_func_vf_cfg_input {
         |        ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnge/hsi.h:1764:8: error: redefinition of 'struct hwrm_func_vf_cfg_output'
    1764 | struct hwrm_func_vf_cfg_output {
         |        ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bnxt/hsi.h:1753:8: note: originally defined here
    1753 | struct hwrm_func_vf_cfg_output {
..


vim +/HWRM_VERSION_MINOR +643 include/linux/bnge/hsi.h

   631	
   632	#define HWRM_NA_SIGNATURE ((__le32)(-1))
   633	#define HWRM_MAX_REQ_LEN 128
   634	#define HWRM_MAX_RESP_LEN 704
   635	#define HW_HASH_INDEX_SIZE 0x80
   636	#define HW_HASH_KEY_SIZE 40
   637	#define HWRM_RESP_VALID_KEY 1
   638	#define HWRM_TARGET_ID_BONO 0xFFF8
   639	#define HWRM_TARGET_ID_KONG 0xFFF9
   640	#define HWRM_TARGET_ID_APE 0xFFFA
   641	#define HWRM_TARGET_ID_TOOLS 0xFFFD
   642	#define HWRM_VERSION_MAJOR 1
 > 643	#define HWRM_VERSION_MINOR 15
 > 644	#define HWRM_VERSION_UPDATE 1
 > 645	#define HWRM_VERSION_RSVD 1
 > 646	#define HWRM_VERSION_STR "1.15.1.1"
   647	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

