Return-Path: <netdev+bounces-181749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425D4A86586
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ACC544347E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DF025C6E8;
	Fri, 11 Apr 2025 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdz9gLQ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C942367DC;
	Fri, 11 Apr 2025 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744396186; cv=none; b=u9/O64ubhBm3l5G//RYvUC4u2tVpyWveqfEqLktQYttG266775CinHXkFdMSvk1Uh/2Dg4MpgogVxV6ShrWPr1lslwMPDLsWDmR6LotUE7EzEEA2D47jrE8SQNLsM/Z7BmEOBzDJDVI7+h3FRjy4qikMbH3OCzGOrRfpZbj3/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744396186; c=relaxed/simple;
	bh=CzoWDLggbQ35EU7dIhJdBlfGx2o0jRfrpK7rR1Z9fZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fC6ZRHre1Y4rmvD6a93c2E1NyvEJ4xl28iz3dq88MQ4ZcB8WImRVxUM/Rui7xSlFr6aDVu4vgQLvG53vziF1+vU5WDVb8jtlHMnVXwKvAA6xy1j/2BLQHPGKqceZk2vxPh43m4VKA/be0eltE32pz3mKd4L3FUJ9o7AqNQsJBMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdz9gLQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFF1C4CEE2;
	Fri, 11 Apr 2025 18:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744396185;
	bh=CzoWDLggbQ35EU7dIhJdBlfGx2o0jRfrpK7rR1Z9fZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdz9gLQ08RPj3Ev2eETay9KKUOXvzU/POkFSrk+hBNhsrF8NVWFkca/PDU2u358Mu
	 kRzOY5uZwDc6BzBqQketTIeae930n3LbBoW4aWvEDj3qIjshVGDixq/E1oaMu40D7s
	 kTcJ2udErRjCndUWEFkEMbw/zwWOPyvHHOn2RGoRTdWT519ufqPpVjUUGkfVIFk8G5
	 nXf/dei6wMGKBkQ3OzCGqz+Kdim6As/PvSmPaCQY89qzjNj0JG7Ka8xLOsoZNAvxW7
	 z8rpPGBUF9YOpO7IU+myyjQ4BVz9mvJHWHpoA3DUnZqayvQx3KcrfZC36NOvi/bLqK
	 t/4wADjdvafqA==
Date: Fri, 11 Apr 2025 19:29:40 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Josh Hay <joshua.a.hay@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net] idpf: protect shutdown from reset
Message-ID: <20250411182940.GO395307@horms.kernel.org>
References: <20250410115225.59462-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410115225.59462-1-larysa.zaremba@intel.com>

On Thu, Apr 10, 2025 at 01:52:23PM +0200, Larysa Zaremba wrote:
> Before the referenced commit, the shutdown just called idpf_remove(),
> this way IDPF_REMOVE_IN_PROG was protecting us from the serv_task
> rescheduling reset. Without this flag set the shutdown process is
> vulnerable to HW reset or any other triggering conditions (such as
> default mailbox being destroyed).
> 
> When one of conditions checked in idpf_service_task becomes true,
> vc_event_task can be rescheduled during shutdown, this leads to accessing
> freed memory e.g. idpf_req_rel_vector_indexes() trying to read
> vport->q_vector_idxs. This in turn causes the system to become defunct
> during e.g. systemctl kexec.
> 
> Considering using IDPF_REMOVE_IN_PROG would lead to more heavy shutdown
> process, instead just cancel the serv_task before cancelling
> adapter->serv_task before cancelling adapter->vc_event_task to ensure that
> reset will not be scheduled while we are doing a shutdown.
> 
> Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


