Return-Path: <netdev+bounces-168141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F22A3DB09
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 14:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE693B8C00
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5171F7916;
	Thu, 20 Feb 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ1ymUiM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570901F790C
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740057219; cv=none; b=B9updU/wi5uOVGEC7kqBdcBQtEXWjfKbhlPrsM/iCPLQmFPipaoWg933vOBCEPbyFwmSfILI5T4NJFauST01tljyFIT5c9z2YfJ8RfNDzLH0qNXZQ5a6AOBk4Kn8r4FKM273b04vDfRCnazSOakDkwubL4/OR7WUOlFPMGIsst8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740057219; c=relaxed/simple;
	bh=WQcEldoWuMY6VD0LP+8O3EEjoZrdZmMF74r13S0RwKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lv/fgZlcH8E+jYyfRd2LCyOFKxwcCJ8cfFzkykdtbrzc91GdPTv0nb8Xs+f2JCP9vvTKhd0Sk8C6mIDN4zeV/8on+VGa3oLbSgekKuGoSvkxdldz42Yy18ENOD71XfF2Ma2ijvdH82daKi+jZU0w0HK49fVXDKEngT2vw2U5rf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ1ymUiM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41FDC4CEE2;
	Thu, 20 Feb 2025 13:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740057218;
	bh=WQcEldoWuMY6VD0LP+8O3EEjoZrdZmMF74r13S0RwKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQ1ymUiMCKGtZOeo15FjA+xnOiX2xHNY4jqtmA0dSTQayzX+9IAEmXhvD5TdCpmF1
	 2hiJYNpIuaZxb8cecPil++fiZpFZia7HioE1vdUB87yGOsEwJaMdd1jf9BSs3rALkv
	 UWPQmVtp72Pr8iavg5wCD99rUilsKZqkgMUX34ZsQYYd1Bq7TIDITClLrlsPiemxPU
	 RzQl9Ads1Wxzy/ABPGhGDpXRRudkHG8Cqd8dMRf0ovEJjNrcX0wd84h6oDku4yxnVR
	 ELONhRGhMkohFOxte1AhH8N1OcXdlglM8tnUErGhDsVHFO5dRF9hMzX+ZzfyEe5Qrb
	 I3p1JMdkf6jiA==
Date: Thu, 20 Feb 2025 13:13:35 +0000
From: Simon Horman <horms@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-next 2/3] ice: change SMA pins to SDP in PTP API
Message-ID: <20250220131335.GW1615191@kernel.org>
References: <20250207180254.549314-1-arkadiusz.kubalewski@intel.com>
 <20250207180254.549314-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207180254.549314-3-arkadiusz.kubalewski@intel.com>

On Fri, Feb 07, 2025 at 07:02:53PM +0100, Arkadiusz Kubalewski wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> This change aligns E810 PTP pin control to all other products.
> 
> Currently, SMA/U.FL port expanders are controlled together with SDP pins
> connected to 1588 clock. To align this, separate this control by
> exposing only SDP20..23 pins in PTP API on adapters with DPLL.
> 
> Clear error for all E810 on absent NVM pin section or other errors to
> allow proper initialization on SMA E810 with NVM section.
> 
> Use ARRAY_SIZE for pin array instead of internal definition.
> 
> Reviewed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


