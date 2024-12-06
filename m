Return-Path: <netdev+bounces-149665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5369E6B43
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EA21883F43
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101351DC182;
	Fri,  6 Dec 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpzpwZxv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0CE28684
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733479489; cv=none; b=E7eLlIadmi6b2afZI8ijmKLRk0O/VhlXznGCMjpVm52U6CymW4KyAgTVRKvWdSkqYPH73FvKbGgpxCYMXYxjSoobx+Lfc4zNl8VjagX67gTUUX9xhS0G7cuzmY1YeqSQWFl9BPcU02HMU3lSD+lCtRy+bZEgn3pWgoRhqEuDGno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733479489; c=relaxed/simple;
	bh=cQliueYDTCLaMXFuVjbuqXyh5MZQan2jdcOdntJ2SLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVL6TIJ2OJ45ECsUVthCQyVe87ALWErMY+v2oBVRfy5enNUwUQ+bBk3AGKHh4kT2Ft/+sKqqdapByCHpe6N/pJn8Sec73LTBFcOeI+umF+5CFTXUGbKUlrr9UcFXx1hPMHGxyt+CFX7U6tU+DdALJHQipgUPGqZfPZePOPLp/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpzpwZxv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733479487; x=1765015487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cQliueYDTCLaMXFuVjbuqXyh5MZQan2jdcOdntJ2SLk=;
  b=hpzpwZxvFabRdgi7FZjKwyCOxVZyE5xrTdO7fbbcEsJWkO6Ovm1wUJyO
   ryrM8QWWXKgI32Ad9d/pPuADGLWc6cPIOHJBaMJ7DT57Ovbi4JMfTaEdn
   0X9HlUqGc1+QJYo575nPva8nn8iiEnyrq42Z1aAPZjYYg7vSZbvjgNwZd
   QHJghvMvirhEK53T3ffE6mi6zIsBbu8YhQuMFe4cBrJiQd+x77UDzcdeX
   +wCC+KirPMCf4G+TnF83EY4Xk66mrC5mo+x2tDMbFvXx8coLRVgmufigZ
   p7150/oEy+Oo/js9Xoh9fUYaaDZKQhQUdvB0oXCg0BHyKRoZvG2z+sHRS
   w==;
X-CSE-ConnectionGUID: Ls7xUWk/SmuzEh+pSDcdNA==
X-CSE-MsgGUID: LmYup16wQyyhLWmOe6xVcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="59227790"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="59227790"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 02:04:46 -0800
X-CSE-ConnectionGUID: uzNhHJCwQtS0XqTmA7JWCg==
X-CSE-MsgGUID: 6mF5ijbEQaihoCEiIh5ljw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="98814840"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 02:04:44 -0800
Date: Fri, 6 Dec 2024 11:01:46 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: bharat@chelsio.com, netdev@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net] cxgb4: use port number to set mac addr
Message-ID: <Z1LLinT4O18ISBM6@mev-dev.igk.intel.com>
References: <20241203144149.92032-1-anumula@chelsio.com>
 <Z1AwgqSRsHxWgLn+@mev-dev.igk.intel.com>
 <Z1KS7JOtChxB6EbR@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1KS7JOtChxB6EbR@chelsio.com>

On Fri, Dec 06, 2024 at 01:00:12AM -0500, Anumula Murali Mohan Reddy wrote:
> O Wednesday, December 12/04/24, 2024 at 16:05:46 +0530, Michal Swiatkowski wrote:
> > On Tue, Dec 03, 2024 at 08:11:49PM +0530, Anumula Murali Mohan Reddy wrote:
> > > t4_set_vf_mac_acl() uses pf to set mac addr, but t4vf_get_vf_mac_acl()
> > > uses port number to get mac addr, this leads to error when an attempt
> > > to set MAC address on VF's of PF2 and PF3.
> > > This patch fixes the issue by using port number to set mac address.
> > > 
> > > Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> > > Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> > > ---
> > >  drivers/net/ethernet/chelsio/cxgb4/cxgb4.h      | 2 +-
> > >  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 2 +-
> > >  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c      | 5 +++--
> > >  3 files changed, 5 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
> > > index 75bd69ff61a8..c7c2c15a1815 100644
> > > --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
> > > +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
> > > @@ -2076,7 +2076,7 @@ void t4_idma_monitor(struct adapter *adapter,
> > >  		     struct sge_idma_monitor_state *idma,
> > >  		     int hz, int ticks);
> > >  int t4_set_vf_mac_acl(struct adapter *adapter, unsigned int vf,
> > > -		      unsigned int naddr, u8 *addr);
> > > +		      u8 start, unsigned int naddr, u8 *addr);
> > >  void t4_tp_pio_read(struct adapter *adap, u32 *buff, u32 nregs,
> > >  		    u32 start_index, bool sleep_ok);
> > >  void t4_tp_tm_pio_read(struct adapter *adap, u32 *buff, u32 nregs,
> > > diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> > > index 97a261d5357e..bc3af0054406 100644
> > > --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> > > +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> > > @@ -3234,7 +3234,7 @@ static int cxgb4_mgmt_set_vf_mac(struct net_device *dev, int vf, u8 *mac)
> > >  
> > >  	dev_info(pi->adapter->pdev_dev,
> > >  		 "Setting MAC %pM on VF %d\n", mac, vf);
> > > -	ret = t4_set_vf_mac_acl(adap, vf + 1, 1, mac);
> > > +	ret = t4_set_vf_mac_acl(adap, vf + 1, pi->lport, 1, mac);
> > >  	if (!ret)
> > >  		ether_addr_copy(adap->vfinfo[vf].vf_mac_addr, mac);
> > >  	return ret;
> > > diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> > > index 76de55306c4d..175bf9b13058 100644
> > > --- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> > > +++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
> > > @@ -10215,11 +10215,12 @@ int t4_load_cfg(struct adapter *adap, const u8 *cfg_data, unsigned int size)
> > >   *	t4_set_vf_mac_acl - Set MAC address for the specified VF
> > >   *	@adapter: The adapter
> > >   *	@vf: one of the VFs instantiated by the specified PF
> > > + *	@start: The start port id associated with specified VF
> > >   *	@naddr: the number of MAC addresses
> > >   *	@addr: the MAC address(es) to be set to the specified VF
> > >   */
> > >  int t4_set_vf_mac_acl(struct adapter *adapter, unsigned int vf,
> > > -		      unsigned int naddr, u8 *addr)
> > > +		      u8 start, unsigned int naddr, u8 *addr)
> > >  {
> > >  	struct fw_acl_mac_cmd cmd;
> > >  
> > > @@ -10234,7 +10235,7 @@ int t4_set_vf_mac_acl(struct adapter *adapter, unsigned int vf,
> > >  	cmd.en_to_len16 = cpu_to_be32((unsigned int)FW_LEN16(cmd));
> > >  	cmd.nmac = naddr;
> > >  
> > > -	switch (adapter->pf) {
> > > +	switch (start) {
> > >  	case 3:
> > >  		memcpy(cmd.macaddr3, addr, sizeof(cmd.macaddr3));
> > You can use ether_addr_copy().
> > 
> > Beside that and fixes tag:
> > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > 
> > >  		break;
> > > -- 
> > > 2.39.3
> there are multiple instances where memcpy needs to be replaced. I will
> send a separate patch to replace memcpy with ethr_addr_copy().
> 

Great, thanks.

> Thanks

