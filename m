Return-Path: <netdev+bounces-162917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64272A286DD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 10:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3365167FCE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 09:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C5522A4FE;
	Wed,  5 Feb 2025 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fUuCAvQK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C1F21A458;
	Wed,  5 Feb 2025 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748692; cv=none; b=t8YufhxlUS2guBh2W+iiTFdykAPMaqda2+N+M9fW514c1ttNETiH7YXYz2oTbXJjdPtqAFjMh7xUDuAb85384XbKkSjzkNEi3zehzBm3XkpoZXscRcJuuKbleMyNsvsOZjdLOPmWeEYETLlQX44vrruXj/hDSZkZme5yFFKR6iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748692; c=relaxed/simple;
	bh=J6AXsn3lH7MBCqC6dF7yAkLsCQbHWrYkDB7bo9+iMlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbG2fi4XSAo5IIn0B3LQixOnyr8BCzCBEVmow6zooqwNdBlxNeNsYVDXMX71XNq4eC9nC2X/SZOyXY6bs3v66vmgJYMtSfJ7DMwq9QMSdDALK6q4Ke9bUqClu2SluS/WGejnBzPYY5x76ecPgBJeexmZQg9WU18pN17wk4j6UNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fUuCAvQK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748687; x=1770284687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J6AXsn3lH7MBCqC6dF7yAkLsCQbHWrYkDB7bo9+iMlY=;
  b=fUuCAvQK1H9xny/lo4SBZ7vn2djeCn0cjUQvjQdVGNXliVydg8DXSrL0
   6otbPX0dMwdG3l81Ge2JDaSolGbjqQ5RgUoIvBi9jm9lUrEDrAoPYjCcZ
   QTqjunuJUw97Rn8mNsykiY8FlpzAenZTSPNxmMHZf65wJNiPlYbt9P1e9
   RRsOiOnX5EgRk3/raTYQiaI+wb9lusS9C/a3pCT1K7lGqW3gVwYWSPKAS
   dLPXqPRuwGvtnozMJrW6Hjh4qPR8fEWa1Xmvvse1JOtOApbxFt6Eq9fcP
   /zPugS+q285zX5vyg6Q30iNtzBXlnqk6eR+P0jQ4Dpe8o4i1J+1Q8KTQh
   w==;
X-CSE-ConnectionGUID: RT2ZXwbQSuOb1x8C7ITICQ==
X-CSE-MsgGUID: 67HaaBpVScmY2GbozbQ6Sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39463536"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39463536"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:44:46 -0800
X-CSE-ConnectionGUID: gsJi0kixTue3luxQo5W+OA==
X-CSE-MsgGUID: JKqigt94Szu8N4LOKnQWqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="110707699"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:44:43 -0800
Date: Wed, 5 Feb 2025 10:41:11 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Knitter, Konrad" <konrad.knitter@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Build error on
 "drivers/net/ethernet/intel/ice/devlink/health.c:35:3: error: initializer
 element is not constant"
Message-ID: <Z6MyN8U6rt/6Ayye@mev-dev.igk.intel.com>
References: <CY8PR11MB7134BF7A46D71E50D25FA7A989F72@CY8PR11MB7134.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY8PR11MB7134BF7A46D71E50D25FA7A989F72@CY8PR11MB7134.namprd11.prod.outlook.com>

On Wed, Feb 05, 2025 at 03:18:30AM +0000, Zhuo, Qiuxu wrote:
> Hi,
> 
> I got the build error messages as below:
> My GCC is: gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0.
> 

Try compiling with gcc 8.1 or newer.

Thanks,
Michal

> 
>   CC [M]  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.o
> drivers/net/ethernet/intel/ice/devlink/health.c:35:3: error: initializer element is not constant
>    ice_common_port_solutions, {ice_port_number_label}},
>    ^~~~~~~~~~~~~~~~~~~~~~~~~

