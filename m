Return-Path: <netdev+bounces-164908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5258A2F97A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8865F3A5DC8
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3D25C713;
	Mon, 10 Feb 2025 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhAPR63n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5725C6FE;
	Mon, 10 Feb 2025 19:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217045; cv=none; b=O8oT8HqT1iWNYSmCEgryiq1aw4zTi1nVxNnHCO48fy27Tu4gG+WSSsMxqG2yPeDKCQ6HNzJGqaSkVQgT9NsK+F6F5/ZWUlE4fBrNXTP88mciVjMZHJcS35S3p5hbgCHuml34A02jgXlcVkxmRqYTp1uABOeouWYNrm56rwuJ5b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217045; c=relaxed/simple;
	bh=lsRw1nYOB0Ky35tq2kHbyaBWbfVL/GD32aU42Mm9axo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhouGXkmj/N64V5h7IcpNov+aOM0E+Oz4K1u9da/Qq7Jv/igDrkHdx0FdKsq+lrN6s51Uz08ko5BrHLxLs6C+v/4tNiw3LmDmJxn0hY8QdYpdc5UEye7giILbY20dujBTiiwhDYgoDQFkaeEgBFoPkE5n+Y7Ci55Sj+eQeUYlw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhAPR63n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 228DEC4CED1;
	Mon, 10 Feb 2025 19:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739217045;
	bh=lsRw1nYOB0Ky35tq2kHbyaBWbfVL/GD32aU42Mm9axo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MhAPR63nMdf4sK6Xe62+edHSWos2kiE8csg6j/5QLoryPJ9LcGHcYz0ywiDn+JKVa
	 F+wjPtD6P5cJANro1V3KqaD8xp52YVkd4SmkuLEJ75xGeSq0lOAbRcZc+Y4s98MRWZ
	 NARhIbUlppJuSt4nJPyPW3CrjWXkV+VAtvBsgFx1wtv9QSISgocpk7CJeaAetOeGDO
	 ATd8cWP8FIS03XmxnM9D0E+B0DsDVuSu2pZKqXe5AmXsgF1d8JwsbCBiPh9ssOUkEy
	 dr3NnAAxW92NRSqksiRAzMTddfcJuIEF9LYSKdBmhBWOyxwhT/CbVtCymu0eE4pT1d
	 +OhM6iQzw1+kw==
Date: Mon, 10 Feb 2025 19:50:41 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 05/15] mptcp: pm: userspace: use
 GENL_REQ_ATTR_CHECK
Message-ID: <20250210195041.GS554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-5-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-5-71753ed957de@kernel.org>

On Fri, Feb 07, 2025 at 02:59:23PM +0100, Matthieu Baerts (NGI0) wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> A more general way to check if MPTCP_PM_ATTR_* exists in 'info'
> is to use GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_*) instead of
> directly reading info->attrs[MPTCP_PM_ATTR_*] and then checking
> if it's NULL.
> 
> So this patch uses GENL_REQ_ATTR_CHECK() for userspace PM in
> mptcp_pm_nl_announce_doit(), mptcp_pm_nl_remove_doit(),
> mptcp_pm_nl_subflow_create_doit(), mptcp_pm_nl_subflow_destroy_doit()
> and mptcp_userspace_pm_get_sock().
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


