Return-Path: <netdev+bounces-88178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777EC8A62E2
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 07:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D78C1F238F9
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 05:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686FF37160;
	Tue, 16 Apr 2024 05:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnjRglU9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8271CD06
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 05:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713244513; cv=none; b=Fr+Bd5Hmot27AITp3OpCeUogczNJ7fRk+QKTR7zh9KZLaxOFbxoJJX7F3LRGBPsXPgOWfkWg2homBZaPS7SEzCQ1UcNGqScZh/m7N/LywPoPJhS7opbP/BQzd90eIC1DE26vQWBZJLYytY7jUq4PXlShptEnqMfcOGp0KN4sTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713244513; c=relaxed/simple;
	bh=WfSW2fVy8MmEj/24vCs7MxT/+kMMLLr7ED9NEYvKF/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjYUqjyQkmhYxnDv+U9n0QUdosG6lM+b6rMIFMW5qxsSxHKh5PXxSQQQS7AuUhfJRzchcWPeZ9AH6/Z3tfcKO0xIfnVLs6jwZkUtFjW2LFyBt26tioBO+f17oooJRjDZqquf+txt8wqFo0RI8cRMnn4xIWYuDfH5ElvwqNipFWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnjRglU9; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713244512; x=1744780512;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WfSW2fVy8MmEj/24vCs7MxT/+kMMLLr7ED9NEYvKF/8=;
  b=LnjRglU9QIXYW2Y415sJ8kBoVwYhg2rNUqWKatF0iEJ4E0hmZADtv1Jb
   0LoNibSipdeb6INhXGvbbkR45loF1RcLkNZqLASgGAFNO6YVa7xNYU2xQ
   PU1mN5l+4Wg6NP3A2ZPzlt0zsjyx1vndinngQp7GRnaulG6/9Hqg5c5hP
   vXFzFfB5TltFL580iPoHAZmEf6NPjF5KBwDwFFXwQGNQtGld3LG6STG4+
   Ip8jYU+9bxAxvuHJsg8VZ0bc/bvQ/6/KAYE6HXnD1nGzHpXQLGaSobioh
   v6RDe+2lfcpmpzHK4FNmikG0Kn3XyY+oKlELFcYWIHl0FPlQ4MOMEH3DW
   g==;
X-CSE-ConnectionGUID: oy1G0DV3RtO1CPlUHDNbvA==
X-CSE-MsgGUID: 72CV4ErJTpu2Yfsy/o4TSQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8829163"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8829163"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:15:11 -0700
X-CSE-ConnectionGUID: x0z0GotsSq2zUkovfnWCqA==
X-CSE-MsgGUID: nrBr4JvnRyi3YWuefjX0gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="22210031"
Received: from unknown (HELO mev-dev) ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 22:15:08 -0700
Date: Tue, 16 Apr 2024 07:14:43 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	mateusz.polchlopek@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v3 3/7] ice: add basic devlink subfunctions support
Message-ID: <Zh4JQ4RDRIAYC+V7@mev-dev>
References: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
 <20240412063053.339795-4-michal.swiatkowski@linux.intel.com>
 <Zhje0mQgQTMXwICb@nanopsycho>
 <Zhzny769lYYmLUs0@mev-dev>
 <ZhzvGlDiuaPSEHCX@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhzvGlDiuaPSEHCX@nanopsycho>

On Mon, Apr 15, 2024 at 11:10:50AM +0200, Jiri Pirko wrote:
> Mon, Apr 15, 2024 at 10:39:39AM CEST, michal.swiatkowski@linux.intel.com wrote:
> >On Fri, Apr 12, 2024 at 09:12:18AM +0200, Jiri Pirko wrote:
> >> Fri, Apr 12, 2024 at 08:30:49AM CEST, michal.swiatkowski@linux.intel.com wrote:
> >> >From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> [...]
> 
> >> >+static int
> >> >+ice_devlink_port_fn_state_get(struct devlink_port *port,
> >> >+			      enum devlink_port_fn_state *state,
> >> >+			      enum devlink_port_fn_opstate *opstate,
> >> >+			      struct netlink_ext_ack *extack)
> >> >+{
> >> >+	struct ice_dynamic_port *dyn_port;
> >> >+
> >> >+	dyn_port = ice_devlink_port_to_dyn(port);
> >> >+
> >> >+	if (dyn_port->active) {
> >> >+		*state = DEVLINK_PORT_FN_STATE_ACTIVE;
> >> >+		*opstate = DEVLINK_PORT_FN_OPSTATE_ATTACHED;
> >> 
> >> Interesting. This means that you don't distinguish between admin state
> >> and operational state. Meaning, when user does activate, you atomically
> >> achive the hw attachment and it is ready to go before activation cmd
> >> returns, correct? I'm just making sure I understand the code.
> >> 
> >
> >I am setting the dyn_port->active after the activation heppens, so it is
> >true, when active is set it is ready to go.
> >
> >Do you mean that dyn_port->active should be set even before the activation is
> >finished? I mean when user only call devlink to active the port?
> 
> The devlink instance lock is taken the whole time, isn't it?
> 

I don't take PF devlink lock here. Only subfunction devlink lock is
taken during the initialization of subfunction.

> >
> >> 
> >> >+	} else {
> >> >+		*state = DEVLINK_PORT_FN_STATE_INACTIVE;
> >> >+		*opstate = DEVLINK_PORT_FN_OPSTATE_DETACHED;
> >> >+	}
> >> >+
> >> >+	return 0;
> >> >+}
> >> >+
> 
> [...]

