Return-Path: <netdev+bounces-221949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9170AB5266F
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 04:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CBCF445931
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 02:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B99120F08C;
	Thu, 11 Sep 2025 02:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPOQD+p9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D0D433B3
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 02:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757557620; cv=none; b=TZ66bJbupu1yPdMqj9J/HxtOXaMscB5PP2QaG9TkYIx4PvfmfaXVmf2cug4x3BF1lY7B7LImx4SS1XgoohN0H7HyUs22A3nUTMTyLK8RMwqhXkxTTBeHMm5XJPpGIUydpzLvtHIjKYs5ch2j7dBmUNpujC1n1KSypem6RSie5eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757557620; c=relaxed/simple;
	bh=9SXtoheFb2qMc3X5oT8Cd74I5HXrK0lvY5Xw3TrxIAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5fVbUeAirE1eoDD3jNv6xaIJEvfsfKUdHNZCQgT74Y6/Aeel+om0D8LFPCOfE9NYJp3hT+HCVzELwAkR/i3DOdi/tEFQLvtdGDc9u6+tZuQmULBBIhEKTWe1yA/7tXlnaikUSjxnxMiuymXkN9v8whqwDR8wK6BRwDFVD+JUgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPOQD+p9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7673DC4CEEB;
	Thu, 11 Sep 2025 02:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757557619;
	bh=9SXtoheFb2qMc3X5oT8Cd74I5HXrK0lvY5Xw3TrxIAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HPOQD+p9baXGuasEAr/rTt4XtQ8/jv7lg+iCC/DBnCnh5aMzkSnrGb+GKg7e97PY0
	 vPKUgiWKGqPz4t+RXPukOeBhXG6wOEppdMw6XACeedsgTfkjgYbfpz6NNkrX5S8XdN
	 D0F1knBXRwCIA3A/+mGZ1gQWChbILoyQplgJ7CEm0sUzXYNW4g++EbyavG8XteHBwY
	 fle6UV2MMsie4gcRE0tSWE7LeUvf+uq6ZBclmazu8I+zDhInqSIGSrycGDAnsRyDJZ
	 iIwgj5DOiSfRnDZfSK/+oBWaq2QxCFbEe16bjJ5TDzAHMoqyB2h7qeqLEYR3DgjUeQ
	 DPWauK7b4nvMQ==
Date: Wed, 10 Sep 2025 19:26:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kamal Heib <kheib@redhat.com>
Cc: netdev@vger.kernel.org, Veerasenareddy Burru <vburru@marvell.com>,
 Sathesh Edara <sedara@marvell.com>, Shinas Rasheed <srasheed@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH net v2] octeon_ep: Validate the VF ID
Message-ID: <20250910192658.55383c60@kernel.org>
In-Reply-To: <20250909131020.1397422-1-kheib@redhat.com>
References: <20250909131020.1397422-1-kheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Sep 2025 09:10:20 -0400 Kamal Heib wrote:
> +static bool octep_is_vf_valid(struct octep_device *oct, int vf)
> +{
> +	if (vf >= CFG_GET_ACTIVE_VFS(oct->conf)) {
> +		dev_err(&oct->pdev->dev, "Invalid VF ID %d\n", vf);
> +		return false;

perhaps a nit, but why did you choose dev_err() over netdev_err()?
The incoming handle is a netdev.
-- 
pw-bot: cr

