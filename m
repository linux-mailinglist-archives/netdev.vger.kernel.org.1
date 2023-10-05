Return-Path: <netdev+bounces-38154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26BF7B993D
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 51921B20997
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F723367;
	Thu,  5 Oct 2023 00:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m47GQZxh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F247F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843CFC433C7;
	Thu,  5 Oct 2023 00:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696465714;
	bh=uWTH6rsS6HG9J3HMkU9PhJ14lnUr14RxNqpXF5vE0ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m47GQZxhk7CQoikIPKdurTHNOqRpUM6mNcUcCS70yvYgsB9SOkBWSkajV4/LjPYBf
	 7PLFZUHwSQYizofs8IcrAr/wLxBuvtUqMHiGsG4DztfD/mHCRhir4vyHaHZVSVpdeG
	 aiW0dOEXW+zpgGCkR2DEXSdvmC3IxISfr0689kbrawTzrakzQbNXgZ2X4SFSoqKc33
	 1gjK4aSkw1tbNThqD6WOFoDUM3kp5QToQbD2dFFYcUkG8s6fhszSw+mTLDL9BFfXX1
	 DfrQh8hXFC6BnCg7l5o03EUKIi90BXpdlOH3G4pKT7NHE2CbfW6lndpX/iGfdnOJld
	 LGF/lelmDMy3Q==
Date: Wed, 4 Oct 2023 17:28:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2][pull request] Intel Wired LAN Driver
 Updates 2023-10-03 (i40e, iavf)
Message-ID: <20231004172833.12033543@kernel.org>
In-Reply-To: <20231003223610.2004976-1-anthony.l.nguyen@intel.com>
References: <20231003223610.2004976-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Oct 2023 15:36:08 -0700 Tony Nguyen wrote:
> This series contains updates to i40e and iavf drivers.
> 
> Yajun Deng aligns reporting of buffer exhaustion statistics to follow
> documentation for i40e.
> 
> Jake removes undesired 'inline' from functions in iavf.
> ---
> v2:
> - Drop, previous patch 3, as a better solution [1] is upcoming [2]

Ah, here it is. Maybe it'd be safer not to change the title of 
the cover letter for v2? Sooner or later it may trip some jet
lagged netdev maintainer if patchwork doesn't recognize v2
and auto-supersede v1 ;)

