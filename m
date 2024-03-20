Return-Path: <netdev+bounces-80715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A00348809E1
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 03:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D191C22CF9
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 02:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93E31171D;
	Wed, 20 Mar 2024 02:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNTm1ZFV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B586911711
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 02:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902579; cv=none; b=HbYCNFyUItZt/JIkZwsJWDpr2DN1IwRKFrl5LtPtS64Lp8hEZErEhdUC1pHMdZTVUKHs7icBLc8/cRGB2bqY9z4rueWJYaM+T4ouRwNKoBujlQ28S7ejuq/lam8BGuUtNO4P4kET5c/Bf8x1CwRmVg2G1cW8ED1lHRUnOypI0kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902579; c=relaxed/simple;
	bh=F8NGpCj1jR92X9Qw5YCBFPjrtlm0hhuZplf2rTkLnic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCg27IkhIXSOYsZjkirmgYwObEAI20pO/c0p0XHIm4VRwiL1dhb8r6pQ5a2ajbTjx7QWe31TFBgj6KEd/hrHL9zRAjjOBSIUSY52ix4hJ1Q08eUzcLarkPV78Mv8TU/K5jAZqICNakbO6NrAbi89y1dlwDNIYEWJr3tpRNp7H9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNTm1ZFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004CFC433C7;
	Wed, 20 Mar 2024 02:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710902579;
	bh=F8NGpCj1jR92X9Qw5YCBFPjrtlm0hhuZplf2rTkLnic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GNTm1ZFVRqxAn7b41A6u/uDatNFkSePM5iiC7z63om1debzJFCK3iQRP3msWlaFJD
	 78IewdMfYssiW+oX9Aw0ST+ObjyAINOXD2GR1Yn+vaJM0/woC0NYZR5QuSSuwcYdE7
	 5h1HCyMufyiER86/jtoskY7EmEXUR64vEnW2NA4EBXwp8/moHZ3O6/4kCO+JiWjv+p
	 GzJ37ZqCm2ThmWaPdL5IwG3mEIAQH17ZDVXwX3NBFlZoJ538dv0Fwi8g7StxsxViKU
	 xJtXVJ81qvrsGQ3BKefCN4eFhIsGVG381x+csOs/WfmSZcqXWcsLkdgH2h0Dr+wlMt
	 K8nWsCTOvvuBA==
Date: Tue, 19 Mar 2024 19:42:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Balazs Scheidler <bazsi77@gmail.com>
Cc: netdev@vger.kernel.org, Balazs Scheidler <balazs.scheidler@axoflow.com>
Subject: Re: [PATCH net-next v2 0/2] Add IP/port information to UDP drop
 tracepoint
Message-ID: <20240319194258.039a2bfe@kernel.org>
In-Reply-To: <cover.1710866188.git.balazs.scheidler@axoflow.com>
References: <cover.1710866188.git.balazs.scheidler@axoflow.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 17:39:06 +0100 Balazs Scheidler wrote:
> In our use-case we would like to recover the properties of dropped UDP
> packets. Unfortunately the current udp_fail_queue_rcv_skb tracepoint
> only exposes the port number of the receiving socket.
> 
> This patch-set will add the source/dest ip/port to the tracepoint, while 
> keeping the socket's local port as well for compatibility.


This doesn't apply to current net-next, please rebase.
Please repost in a week, until -rc1 is cut we do not accept any
net-next patches, see:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: cr

