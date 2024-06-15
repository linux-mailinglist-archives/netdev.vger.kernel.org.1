Return-Path: <netdev+bounces-103803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F24C9098C7
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 17:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450DA1F21A65
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD041DA21;
	Sat, 15 Jun 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oITqWQkL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337234437;
	Sat, 15 Jun 2024 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718464607; cv=none; b=AzRSLfiL9aR1lY7d/wU0JZV/BxLd/4vC+bspPuar+wp9MacTms4kwFo4hB+3Rz35tiZvmQE5egH1hGotNFBNmv8Dy9UKw2RFI/Sv7+K2y/dVQYsbX9bD0PhPQRJ6Ubv7f4s4gDpHQSWM8JaYCYDLsmYVGxhgPYE3Z8g7K8yyaME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718464607; c=relaxed/simple;
	bh=40Wj6XVGNuJpJuinT1FRLIVr94RxlZv+LTy0tHJIxw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FV8wYtrTHctj7Tqo+8I/++fvvOfMk+zQR69teNBbsKihBJoATt50qJAIak5ThUL5fmg+nAhxiqENDhmKrE4Z6CN+A+gUyfdQL7+wm6OPWBbAaQcgBtCc8crWpVy0MIBwPq9AjvcbfWQEbB/X7KTXu1LHBSU9a1LSMoJWpaT71XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oITqWQkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39B0C116B1;
	Sat, 15 Jun 2024 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718464606;
	bh=40Wj6XVGNuJpJuinT1FRLIVr94RxlZv+LTy0tHJIxw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oITqWQkLtoirbzPziEOi8v1w2dJiXHu+NmH1id2OgsJQkJu21MBaSc/z1dJFdFzs2
	 x6jiFctC069hir6E/AtWT/rgAA+qP7/M+PmvgUh4zEAkESVjXTPvWECHcTsN3rpkPK
	 Dvp3g+rO4u6JhEjvVbffH/bWbylm45AVTHRRuD+a9k2n/XcweJSQJFkrc4DcVXatSA
	 w5aaGFOm2SHa2U9qNa/YsqiSMn/x8zkHl9MnFe1r4oERx3YAqub5LgFP3K7m6CjP1b
	 4xbguxZnP1O9UTmBMBl2+6fPm63hqJzVedAsBtjt5HZEQhI0nLXo5K+/e3tzH5/IYg
	 CDAKXPm2TzyIA==
Date: Sat, 15 Jun 2024 16:16:41 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, ivecera@redhat.com,
	przemyslaw.kitszel@intel.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Konrad Knitter <konrad.knitter@intel.com>,
	Marcin Domagala <marcinx.domagala@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2] ice: use proper macro for testing bit
Message-ID: <20240615151641.GG8447@kernel.org>
References: <20240614094338.467052-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614094338.467052-1-poros@redhat.com>

On Fri, Jun 14, 2024 at 11:43:38AM +0200, Petr Oros wrote:
> Do not use _test_bit() macro for testing bit. The proper macro for this
> is one without underline.

Hi Petr,

it might be nice to include a brief explanation as to
why test_bit() is correct.

> 
> Fixes: 4da71a77fc3b ("ice: read internal temperature sensor")
> Signed-off-by: Petr Oros <poros@redhat.com>
> Acked-by: Ivan Vecera <ivecera@redhat.com>

...

