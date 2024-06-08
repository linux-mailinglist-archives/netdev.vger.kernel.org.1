Return-Path: <netdev+bounces-102017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 825C8901192
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 14:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CADE1C20C13
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571C0178370;
	Sat,  8 Jun 2024 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4bhP3bv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330A1178362
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851548; cv=none; b=H+nGXnqGm/U8LA3kGHGImgPXU7v2gnBorx+o4/om2htoI+l/2BLj7q559avG9tHS9JYnPOdrtNUbpPw+nHWV/ghJn4cmD4hjUPne0mAYii+yCOcm6yviQrOi2/7EBlS1TkAuxr/Z8H0XmNx8mCyl7YlRSEXQoZjwjwRqB1kUnmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851548; c=relaxed/simple;
	bh=/mfXYyiZLGR+cGtCegAQMVUyskz7NtbY6gJqGOnLYCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2+LRHE9CQrXWQdqJcdqVEPi1Ld2GcyDvSb3YI514ptf/aV3iofDLK02vW9Cpt9kQN2UPp/i44hudzuAcNXkRrbYXmFDrzwZtm9LvwIdGnSZYIDgR2SpFFovhuEDKE3Mqx/mxNLUF7wLt5NMb3EsZ/lXMrYGXakqi45d19N8O6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4bhP3bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CC1C2BD11;
	Sat,  8 Jun 2024 12:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717851547;
	bh=/mfXYyiZLGR+cGtCegAQMVUyskz7NtbY6gJqGOnLYCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4bhP3bvDJ5LdTjkPZsPah0kxjtCs9l0uGFNYr1xeyfhS5054lRPLcMYUedluZfOh
	 bOj/IWF1Ll2rGMKp+H4/YV98Us/VJMdlj01+olUBd/2wPOb1KBCN7OCtImB7ryr8Fe
	 mL9XKiCiNWdE7NSQZquUGCfvxDihrvJjlo0BbCLR+nQwCG/qm+z/8IJfDy82YHLMe5
	 DNFfLPaX9DTIfAh2xwNeDn0OMnf8/2jkNBXnrk8cVt7psRoFKJg9P9mngkt2MtNet7
	 rX8UU9LfnxGxY48yxDAA1zumlEPEYfzXzs6WZPsgiqf4mgeOTE7xmkiDaDV++O/BQO
	 UVo8txHpwpqEQ==
Date: Sat, 8 Jun 2024 13:59:04 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 07/12] iavf: add support
 for indirect access to PHC time
Message-ID: <20240608125904.GZ27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-8-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-8-mateusz.polchlopek@intel.com>

On Tue, Jun 04, 2024 at 09:13:55AM -0400, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Implement support for reading the PHC time indirectly via the
> VIRTCHNL_OP_1588_PTP_GET_TIME operation.
> 
> Based on some simple tests with ftrace, the latency of the indirect
> clock access appears to be about ~110 microseconds. This is due to the
> cost of preparing a message to send over the virtchnl queue.
> 
> This is expected, due to the increased jitter caused by sending messages
> over virtchnl. It is not easy to control the precise time that the
> message is sent by the VF, or the time that the message is responded to
> by the PF, or the time that the message sent from the PF is received by
> the VF.
> 
> For sending the request, note that many PTP related operations will
> require sending of VIRTCHNL messages. Instead of adding a separate AQ
> flag and storage for each operation, setup a simple queue mechanism for
> queuing up virtchnl messages.
> 
> Each message will be converted to a iavf_ptp_aq_cmd structure which ends
> with a flexible array member. A single AQ flag is added for processing
> messages from this queue. In principle this could be extended to handle
> arbitrary virtchnl messages. For now it is kept to PTP-specific as the
> need is primarily for handling PTP-related commands.
> 
> Use this to implement .gettimex64 using the indirect method via the
> virtchnl command. The response from the PF is processed and stored into
> the cached_phc_time. A wait queue is used to allow the PTP clock gettime
> request to sleep until the message is sent from the PF.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


