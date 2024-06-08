Return-Path: <netdev+bounces-102010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D787C901183
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 14:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8742827D4
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6E3176FA7;
	Sat,  8 Jun 2024 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/nimq3P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B132BAE9
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851334; cv=none; b=rmS2C4mAam7bySVqBI0myniUVJxuvQtAlanDxcGQwUy1F6tpz6z3paikyOlA77iBNd48ytydDxPabpQ+/JGniTd/5gy64v2ncJGm0VnphPT7EHKInaZxk7L6Qwfa0dD3+EhfaRtM3Vta0eB7i0HpfjPirLx6viXLyrNeV7BXDgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851334; c=relaxed/simple;
	bh=9KLc5ZWRKVzzD/hO+CFXAsPG5/vZtKSbef/xgGiW+6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zg1e3VzZC1Wjy0/kA0Zjtwbj7rjHHQXRa6jGzm5hy9ReM4LMvU75MjmdWs3W8jjBYBzsUb79zwGIqK0XtPZZF4bAi+oZ+5Xtzbp0AERgzQrisy69Kp/h8q0s2bOf9YddDMf+1BocwxbuMwbdrWWBU6qinlCIWPpOOOlhfNDOZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/nimq3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C59FC2BD11;
	Sat,  8 Jun 2024 12:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717851333;
	bh=9KLc5ZWRKVzzD/hO+CFXAsPG5/vZtKSbef/xgGiW+6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B/nimq3PGfrD4oEsSVvQ6yJVKPXKAcKFnJ3JEJ47B4AJJ3JjXsXWM+lmOB9w/dYSa
	 6aj9TT3i+i+yfC1Ztk1DP/ntzmiem5sXpbsmGkzDDhC2EZIJLH4CsGHTEy4o5zqxv4
	 W0aGY9ykTNXjExOeNtD7QA0vja3E/YWNlYDw958JIUnZBp9v9s/H0C/ooIOqOxg6z5
	 HX6x75I8cFq9MhXeiy599noN8XUy7z3nUS7UNiq+Z/0Pih4GJvxW+zM/RN2mW92Dd5
	 bEEjvsxb5Q7FKVoGQWR0VDvMJj4ICmJek1iIfj8nPX5MvS0E4473jIUyX9suEFRJtm
	 9K/cALe3cko3g==
Date: Sat, 8 Jun 2024 13:55:30 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 01/12] virtchnl: add
 support for enabling PTP on iAVF
Message-ID: <20240608125530.GS27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-2-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-2-mateusz.polchlopek@intel.com>

On Tue, Jun 04, 2024 at 09:13:49AM -0400, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Add support for allowing a VF to enable PTP feature - Rx timestamps
> 
> The new capability is gated by VIRTCHNL_VF_CAP_PTP, which must be
> set by the VF to request access to the new operations. In addition, the
> VIRTCHNL_OP_1588_PTP_CAPS command is used to determine the specific
> capabilities available to the VF.
> 
> This support includes the following additional capabilities:
> 
> * Rx timestamps enabled in the Rx queues (when using flexible advanced
>   descriptors)
> * Read access to PHC time over virtchnl using
>   VIRTCHNL_OP_1588_PTP_GET_TIME
> 
> Extra space is reserved in most structures to allow for future
> extension (like set clock, Tx timestamps).  Additional opcode numbers
> are reserved and space in the virtchnl_ptp_caps structure is
> specifically set aside for this.
> Additionally, each structure has some space reserved for future
> extensions to allow some flexibility.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Hi Mateusz, Jacob, all,

If you need to respin this for some reason, please consider updating
the Kernel doc for the following to include a short description.
Else, please consider doing so as a follow-up

* struct virtchnl_ptp_caps
* struct virtchnl_phc_time

Likewise as a follow-up, as it was not introduced by this patch, for:

* virtchnl_vc_validate_vf_msg

Flagged by kernel-doc -none -Wall

The above not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

