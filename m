Return-Path: <netdev+bounces-242738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7573EC9462B
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 18:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B653A607E
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 17:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29595310650;
	Sat, 29 Nov 2025 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtsPuylX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28911EB9F2;
	Sat, 29 Nov 2025 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764439126; cv=none; b=EpVlB2fxOPsqY1ffM37GtDaNdFh6CDxDbEc/bxFUTuSHZSfu7UKBzKJguJUuZbS0u+X7Vs9Wt4vMZmNO52kZQXQdvSvmsS1HhAGzhwYOoQrHhm01e/x12vS40f7610OQxgkXtSNBo9Z5EHTmYrm6pk4+GYEWyDzP6h6Mc11WZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764439126; c=relaxed/simple;
	bh=PXsvXs0P6QIHZFy8DIQsKir+mPzceZIj16cevjs+9gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu8bcn1HnzoHv8KXugOuBJUdk7lPU/uv/ml/5taz4+zId4QOsL2n183d0N43WaBv7L1LTt10oj4ZONdpdy8tVjzn4c02WSBY8FR3lc4DLa2sTWRhEEbx6MRN9sx1Sd5c9Z6UwvhggXYD09a/Dsh/pwaFftnjdhkNVL1+9/knx2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtsPuylX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07B6C4CEF7;
	Sat, 29 Nov 2025 17:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764439125;
	bh=PXsvXs0P6QIHZFy8DIQsKir+mPzceZIj16cevjs+9gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtsPuylXljK9+V9ak7L2qdVNX3VyHRic71Q6+gid/ahI3d809Pj7ZCbDfsw9YhwJD
	 nEpEbkXRlIXWCyDyGLPMlZm/LAv4kNb7CN5C0WPhZODGl54QQPPO6+HqrJr9ZAGGBq
	 CBTpMa/E2PwbL/bfFvyHYasXdQXf7qI7mHiNDii7wBJgt26ZJsuFCD2j0KqX/4rbIf
	 nrdnjYYFIjO2FfaErvXbxDiI9XzrQfBQ4mIQY+zyds4GrjUBeex48ulKoxhVkzCEWr
	 BVyQ43a+gaKDgtBPHtS0/QzY2JsIQDbo7dHti32r5hzXbLWl2LAC90FoaFeKXTtLcR
	 mWy3blFXbPw5A==
Date: Sat, 29 Nov 2025 17:58:40 +0000
From: Simon Horman <horms@kernel.org>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next] team: Add matching error label for failed action
Message-ID: <aSs0ULj4jaPxjCcW@horms.kernel.org>
References: <20251128072544.223645-1-zlatistiv@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128072544.223645-1-zlatistiv@gmail.com>

On Fri, Nov 28, 2025 at 09:25:44AM +0200, Nikola Z. Ivanov wrote:
> Follow the "action" - "err_action" pairing of labels
> found across the source code of team net device.
> 
> Currently in team_port_add the err_set_slave_promisc
> label is reused for exiting on error when setting
> allmulti level of the new slave.
> 
> Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
> ---
> Related discussion:
> https://lore.kernel.org/netdev/admyw5vnd3hup26xew7yxfwqo4ypr5sfb3esk7spv4jx3yqpxu@g47iffagagah/

Reviewed-by: Simon Horman <horms@kernel.org>


