Return-Path: <netdev+bounces-99809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23468D68EA
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 20:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C20228A8FD
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 18:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D08417E460;
	Fri, 31 May 2024 18:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfidlvOl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945717E45E
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179529; cv=none; b=pIpLGeqtx76p21atXe+C4HGCwdRNXjul1x7u/HSAZdcihYjmCn6OIpBCkd0dmn+S6G7X7i+bgOquPc4CDnFWgkr8SraTbaiNxPK8LCyW5iBREMV5I79DDiP+cmK6K8v/aPjDMljUVzO+1H8DLScX7TYCQEKP2FKWQKfANR4TBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179529; c=relaxed/simple;
	bh=yTCk9ONn+AOISS6mJp230I9j1L/ri//w8UIENOBzFPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ov/Or0GeAIwKMSPLwgA4QBF8oRai//0YCDMDFisBnH37Yw9WfgbBjMscuqXUD4uFhbWbsg1axJOcjFx+mBAKCA3mzRW1zQ5StqPkKIelipLSllEheoViJYpzrXkGxR9oSaX5oW9fwCE7r85mw9l/Mhl/b0pAKOjubc9CT3ibUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfidlvOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA081C116B1;
	Fri, 31 May 2024 18:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717179528;
	bh=yTCk9ONn+AOISS6mJp230I9j1L/ri//w8UIENOBzFPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QfidlvOlpLSKaHgutW+r451uKcLN6lLcvKxKUgLDI+e6GzUMd/qAyhAMhYR1WH+Ui
	 Y1JbX/Wo6EurlcaVbQsR/0xzjQYc7RKuhsvtAU8IMvjlFxsfSXa541VsLuL6bRsKun
	 n1tOeaAhYLMWtxt0iR2rDmLxI4YHsmgPJcK7skkk0obt25PfIdWcuh1Sjb7J+mx1H9
	 QuSW08O/aPeQOdFq6FH3sM7HPkzg3KyI/JBVz0dLNUaIFESAd5jdGQLNnAWf+LAnlD
	 l9EgT08L/ct085jsdG2OElixxFQV7LRl4RjMWc4IgPHRycfMIH+KsUdoy+FPni9TgY
	 PqaOdGM9+40ug==
Date: Fri, 31 May 2024 19:18:43 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [iwl-next v3 15/15] ice: allow to activate and deactivate
 subfunction
Message-ID: <20240531181843.GQ491852@kernel.org>
References: <20240528043813.1342483-1-michal.swiatkowski@linux.intel.com>
 <20240528043813.1342483-16-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528043813.1342483-16-michal.swiatkowski@linux.intel.com>

On Tue, May 28, 2024 at 06:38:13AM +0200, Michal Swiatkowski wrote:
> From: Piotr Raczynski <piotr.raczynski@intel.com>
> 
> Use previously implemented SF aux driver. It is probe during SF
> activation and remove after deactivation.
> 
> Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


