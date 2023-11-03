Return-Path: <netdev+bounces-45932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E117E0737
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56DA281E8E
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03121F608;
	Fri,  3 Nov 2023 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5to2z2e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1B1A5B3
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF03C433C8;
	Fri,  3 Nov 2023 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699031640;
	bh=i1/OCP6nHwLYZipGp9hjEQ3J+qcqL4DAmtnlCVaSDqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s5to2z2eyOIQrYaKX3IjmVMzsSpkh2bZkXp3Sqv27KBCY6mmo/R2twyhRcxqpzpyj
	 H5dGKPKcwqvbFQJ/mi8MtB/CwI7mhPLMOxKJoi+z/1xm20XxplGjR5FdYtzqk7OWaq
	 y5ayxEyYL2pzmNy+JuvGsE4mTJXsQ1wklVC6G81wYR/TwD0mfOqx9QCVx87MsD8HHQ
	 kvRA7K0lIi/+FJdbogUsko5plKqmEzYPTZP07RIsz2FUETDojmrh55pZxy2u6JwbG+
	 NZvWx/NLyX9qjon10RPbalzWtg16ebUfqwHp4av1NLDDSNKiffldCjRVCGVOySt/wq
	 wrZrczhJZcWRQ==
Date: Fri, 3 Nov 2023 17:13:54 +0000
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH iwl-next] i40e: Remove AQ register definitions for VF
 types
Message-ID: <20231103171354.GE714036@kernel.org>
References: <20231026083822.2622930-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026083822.2622930-1-ivecera@redhat.com>

On Thu, Oct 26, 2023 at 10:38:22AM +0200, Ivan Vecera wrote:
> The i40e driver does not handle its VF device types so there
> is no need to keep AdminQ register definitions for such
> device types. Remove them.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks, another nice cleanup.

Reviewed-by: Simon Horman <horms@kernel.org>


