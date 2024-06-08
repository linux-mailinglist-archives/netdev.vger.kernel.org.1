Return-Path: <netdev+bounces-102015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331DF90118E
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 14:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A8F51C20C32
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E901779BC;
	Sat,  8 Jun 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfUl0t4T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B917C68
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851502; cv=none; b=EW5VYZnIhzEDF4vyR0ntV/0fMg4Uflu4b0GvjEM+a+nuN2qhmeWqbrs8rpXnsaWPDxreT696um1dCGJ0rGttQSGQ8YkDX+9M5Fnujon6xWpBsAl6lyV7/E4D6UmzVD0Ubr/BIhTejkBE2hzQqvQap9g+z3VKQF/L4qMHffpSJJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851502; c=relaxed/simple;
	bh=54Xh9Wz7EJxKcPESg+VRQVI6gfrctMlq/VGRmr0KWYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bI2pszywLObnv04w4Pz2s+UhwQ/+6uKUdYyYnf8y+ic4pbkTSV7wvo9bkzbHeljm0LCM5qGm0eKCQC76FBeP3e2CgYrd78/OJfEr64bpA/zEL15PjJnhHgfdeqiaQEhKHl0NTcf+QFCBz+PxYrVCWRetbJ5YmbDItcSwuBrQEas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfUl0t4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDE2C2BD11;
	Sat,  8 Jun 2024 12:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717851501;
	bh=54Xh9Wz7EJxKcPESg+VRQVI6gfrctMlq/VGRmr0KWYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EfUl0t4TaYPL7kh093aYRIJmjU4AF8RVUd6g+cG920ByTrGAevRwwrRT315fhrMJ6
	 AVHIOSX+WBWG3il2b4R0Or4TEjJvyF+fYASDqqxqtbN94D8nxtTSGqacy1xj/6i1Vd
	 7jR+5btkN6YB1tDIgudWJOqu2q/n2wU+Qq5eoTr+QkUKTUt8D65vdhK+pYcVoa4nuh
	 G00xgLBmGyvbpgL2JBqWNAX8zvnA7PNNINQ6Jdn/k+0QRyETPLpK/yz8g3yMheICHu
	 ZFRSc0/6dYqP1MZ66viGVc/xDTFozyA4GLKm0YotTeSdn9teLCzMN+kju3BE5hc8cl
	 bT47bahqV7jZw==
Date: Sat, 8 Jun 2024 13:58:18 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 05/12] iavf: negotiate PTP
 capabilities
Message-ID: <20240608125818.GX27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-6-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-6-mateusz.polchlopek@intel.com>

On Tue, Jun 04, 2024 at 09:13:53AM -0400, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Add a new extended capabilities negotiation to exchange information from
> the PF about what PTP capabilities are supported by this VF. This
> requires sending a VIRTCHNL_OP_1588_PTP_GET_CAPS message, and waiting
> for the response from the PF. Handle this early on during the VF
> initialization.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


