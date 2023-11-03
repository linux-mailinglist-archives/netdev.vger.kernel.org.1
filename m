Return-Path: <netdev+bounces-45930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B797E0732
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 18:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EED8281E95
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F48E1EA78;
	Fri,  3 Nov 2023 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkhmF8t+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CC11A5B3
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 17:09:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4560C433C8;
	Fri,  3 Nov 2023 17:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699031373;
	bh=sq3L5gUrO9wxalfWm5HOiwIfw0lC8DkpESy25Odx+hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkhmF8t+hdszhtvZFdcxIUCkZguAyqoHMDR2jOPEL+5Ked3zu9OKkuNyiwqVLy/zr
	 fdB95qyMygnaWOzw5t9vbfRhjzYrKSYi0JNsxd4zmLq+FPUmFeRWegt7XPiFDEx7GV
	 nPHRTjDtBEdyok9/nLUpZjzEpOVgRY7Tw1o/izNpDfFzPrsq23Y+FKgxPNH/UktSUJ
	 /CtAipVpNhDWss8cxTM8wD9nSarGpkH8RRjHX+MX5ID9pKEz0AtOrbGxFD5OcFW72x
	 QoCRp1XTBISxXF0s+oDYMZF6LmxK1aygn1ecLzoFztXYt4+2ERqi6gg3p4tv4H1DhN
	 ZWAFlbJpccrZw==
Date: Fri, 3 Nov 2023 17:09:28 +0000
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
Subject: Re: [PATCH iwl-next] iavf: Remove queue tracking fields from
 iavf_adminq_ring
Message-ID: <20231103170928.GD714036@kernel.org>
References: <20231026083932.2623631-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026083932.2623631-1-ivecera@redhat.com>

On Thu, Oct 26, 2023 at 10:39:32AM +0200, Ivan Vecera wrote:
> Fields 'head', 'tail', 'len', 'bah' and 'bal' in iavf_adminq_ring
> are used to store register offsets. These offsets are initialized
> and remains constant so there is no need to store them in the
> iavf_adminq_ring structure.
> 
> Remove these fields from iavf_adminq_ring and use register offset
> constants instead. Remove iavf_adminq_init_regs() that originally
> stores these constants into these fields.
> 
> Finally improve iavf_check_asq_alive() that assumes that
> non-zero value of hw->aq.asq.len indicates fully initialized
> AdminQ send queue. Replace it by check for non-zero value
> of field hw->aq.asq.count that is non-zero when the sending
> queue is initialized and is zeroed during shutdown of
> the queue.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks, this is a nice cleanup.

Reviewed-by: Simon Horman <horms@kernel.org>

...

