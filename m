Return-Path: <netdev+bounces-299951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +SjhE8GvMWqhpAUAu9opvQ
	(envelope-from <netdev+bounces-299951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:19:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70199695287
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 22:19:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=m2Ze3Nqr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299951-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299951-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7326300348B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 20:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7C338911B;
	Tue, 16 Jun 2026 20:19:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CD1378826
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 20:19:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781641148; cv=none; b=dnZ3q7Hqn1/8JB0B8iAcx54FryWoFBR7ctngSMektw6DBQ1r22KiH2noap7XOf4kp1ELxoaxiY3aJQYzlTSCDZIHD9JVbKvavJHOVAJHMwt/vnt8Q6bDwwNlPL0z/qSW7JqH7UJ9wNlXzTZVXpYIsCbXvUkjDA3jzrX1IjGpDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781641148; c=relaxed/simple;
	bh=ZQumMHxrTNTS76WJKpYqSc08gwtx7rqu3YrU8AEhN7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKfl6aA948iE0Q0sBWkrjl7WDmXoi/3QWpCOsmesiqFwi75FnTwmMjTqf7gYTpJJH+eVnPzprZgIYo4ui2s0hY6HJ/j2/Mj8MaUhcfy+m0dJiyu4a73mRBtZ+6WGtWoRKxPtBEzrIJMPvg4oUzmWsUuJLsiWgEQnUKRuV+ALR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m2Ze3Nqr; arc=none smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781641144; x=1813177144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZQumMHxrTNTS76WJKpYqSc08gwtx7rqu3YrU8AEhN7U=;
  b=m2Ze3NqrzAgHDt36uKzC0kLrnIGZvd1eoRzlVGngRCluA+iu1iDbChiz
   mQpOSzI2El5aXPbgtg0eNn0O65QJHjphjKWluUGRMdA6TvtdLdOZmMDom
   ECYvFtksesgBrt97dHSIKRA683J1+QwNDrWyLBH+k6Zkaiwov4NtC3h9g
   Jwu6xTC61gbUyTbQB+e9XC7JFXytlZoNgw5irxg3TkcP/qA3lTSBf5UZY
   l9wiecEf1f3ezpD+c/mNm9EUTj/3jAIrYZ1GmQcu0c6BNdSgdOiTItODP
   cmYjCmH3LuEtXJ+zS9kEmmMb5tvVNjXp9jWgDCT8qfGki2KEWRr6+2Owa
   w==;
X-CSE-ConnectionGUID: iv4facG0RyKXAYCr4FqP4w==
X-CSE-MsgGUID: c92TN8PgQiCvWGMcCETdKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="92744728"
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="92744728"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 13:19:04 -0700
X-CSE-ConnectionGUID: zTrHQPL/TL2Y9+7eSsJv5A==
X-CSE-MsgGUID: GQLbJOLPQc6kdvUO4GXLtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,208,1774335600"; 
   d="scan'208";a="271945306"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa001.fm.intel.com with ESMTP; 16 Jun 2026 13:19:02 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZaFQ-000000005B3-12Qh;
	Tue, 16 Jun 2026 20:19:00 +0000
Date: Tue, 16 Jun 2026 22:18:27 +0200
From: kernel test robot <lkp@intel.com>
To: Robert Malz <robert.malz@canonical.com>, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: oe-kbuild-all@lists.linux.dev, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] ice: retry reading NVM if admin queue returns EBUSY
Message-ID: <202606162237.EIrFZKip-lkp@intel.com>
References: <20260616104521.1545053-1-robert.malz@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616104521.1545053-1-robert.malz@canonical.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299951-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:robert.malz@canonical.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:oe-kbuild-all@lists.linux.dev,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70199695287

Hi Robert,

kernel test robot noticed the following build errors:

[auto build test ERROR on tnguy-next-queue/dev-queue]
[also build test ERROR on tnguy-net-queue/dev-queue linus/master v7.1 next-20260616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Malz/ice-retry-reading-NVM-if-admin-queue-returns-EBUSY/20260616-185349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20260616104521.1545053-1-robert.malz%40canonical.com
patch subject: [PATCH] ice: retry reading NVM if admin queue returns EBUSY
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260616/202606162237.EIrFZKip-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260616/202606162237.EIrFZKip-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606162237.EIrFZKip-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_nvm.c: In function 'ice_read_flat_nvm':
>> drivers/net/ethernet/intel/ice/ice_nvm.c:101:58: error: 'ICE_AQ_RC_EBUSY' undeclared (first use in this function); did you mean 'LIBIE_AQ_RC_EBUSY'?
     101 |                         if (hw->adminq.sq_last_status != ICE_AQ_RC_EBUSY ||
         |                                                          ^~~~~~~~~~~~~~~
         |                                                          LIBIE_AQ_RC_EBUSY
   drivers/net/ethernet/intel/ice/ice_nvm.c:101:58: note: each undeclared identifier is reported only once for each function it appears in


vim +101 drivers/net/ethernet/intel/ice/ice_nvm.c

    48	
    49	/**
    50	 * ice_read_flat_nvm - Read portion of NVM by flat offset
    51	 * @hw: pointer to the HW struct
    52	 * @offset: offset from beginning of NVM
    53	 * @length: (in) number of bytes to read; (out) number of bytes actually read
    54	 * @data: buffer to return data in (sized to fit the specified length)
    55	 * @read_shadow_ram: if true, read from shadow RAM instead of NVM
    56	 *
    57	 * Reads a portion of the NVM, as a flat memory space. This function correctly
    58	 * breaks read requests across Shadow RAM sectors and ensures that no single
    59	 * read request exceeds the maximum 4KB read for a single AdminQ command.
    60	 *
    61	 * Returns a status code on failure. Note that the data pointer may be
    62	 * partially updated if some reads succeed before a failure.
    63	 */
    64	int
    65	ice_read_flat_nvm(struct ice_hw *hw, u32 offset, u32 *length, u8 *data,
    66			  bool read_shadow_ram)
    67	{
    68		u32 inlen = *length;
    69		u32 bytes_read = 0;
    70		int retry_cnt = 0;
    71		bool last_cmd;
    72		int status;
    73	
    74		*length = 0;
    75	
    76		/* Verify the length of the read if this is for the Shadow RAM */
    77		if (read_shadow_ram && ((offset + inlen) > (hw->flash.sr_words * 2u))) {
    78			ice_debug(hw, ICE_DBG_NVM, "NVM error: requested offset is beyond Shadow RAM limit\n");
    79			return -EINVAL;
    80		}
    81	
    82		do {
    83			u32 read_size, sector_offset;
    84	
    85			/* ice_aq_read_nvm cannot read more than 4KB at a time.
    86			 * Additionally, a read from the Shadow RAM may not cross over
    87			 * a sector boundary. Conveniently, the sector size is also
    88			 * 4KB.
    89			 */
    90			sector_offset = offset % ICE_AQ_MAX_BUF_LEN;
    91			read_size = min_t(u32, ICE_AQ_MAX_BUF_LEN - sector_offset,
    92					  inlen - bytes_read);
    93	
    94			last_cmd = !(bytes_read + read_size < inlen);
    95	
    96			status = ice_aq_read_nvm(hw, ICE_AQC_NVM_START_POINT,
    97						 offset, read_size,
    98						 data + bytes_read, last_cmd,
    99						 read_shadow_ram, NULL);
   100			if (status) {
 > 101				if (hw->adminq.sq_last_status != ICE_AQ_RC_EBUSY ||
   102				    retry_cnt > ICE_SQ_SEND_MAX_EXECUTE)
   103					break;
   104				ice_debug(hw, ICE_DBG_NVM,
   105					  "NVM read EBUSY error, retry %d\n",
   106					  retry_cnt + 1);
   107				last_cmd = false;
   108				ice_release_nvm(hw);
   109				msleep(ICE_SQ_SEND_DELAY_TIME_MS);
   110				status = ice_acquire_nvm(hw, ICE_RES_READ);
   111				if (status)
   112					break;
   113				retry_cnt++;
   114			} else {
   115				bytes_read += read_size;
   116				offset += read_size;
   117				retry_cnt = 0;
   118			}
   119		} while (!last_cmd);
   120	
   121		*length = bytes_read;
   122		return status;
   123	}
   124	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

