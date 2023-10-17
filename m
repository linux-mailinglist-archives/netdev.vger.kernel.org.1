Return-Path: <netdev+bounces-41774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B247CBE15
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8312813A8
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503643C6B4;
	Tue, 17 Oct 2023 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtzyePjH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34305BE6D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7388CC433C8;
	Tue, 17 Oct 2023 08:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697532641;
	bh=DFZVY3YlqzA0Lbcxg4qieXe/4q0/1sdvPGHoBv5Yo9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qtzyePjH8PG9jCyMHqfPU49+LguCMwJWsqCJwoU995hAr47LDttDijjgRuliCYaQ/
	 hJIZ+SRZCYlmnWa/F7TlqTHaLT7FImZGe3oDeq4sQLXhXy0lfcKsVVH2rityoX/WNc
	 LEzdcodKKEFY0UpzxDEkMAGG6wAewlCNWekrR/PjLjaUUdwRRNtVN2X+H0XrCGiNiQ
	 7as97SeiYyD5PAEccC/e96Ei72bi/umxfnC07GBBkM4sFsW5s7YhRM99BVaam6OY1t
	 db0KMgTnE5xDlPLK9QM8gPzeNYQh/2K5zD7gBfgkEvTxFdR6ZOo0Dy/UmZtkQxdhzv
	 5xiOeYOvKfmlQ==
Date: Tue, 17 Oct 2023 10:50:38 +0200
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com
Subject: Re: [patch net-next v3 3/7] devlink: take device reference for
 devlink object
Message-ID: <20231017085038.GK1751252@kernel.org>
References: <20231013121029.353351-1-jiri@resnulli.us>
 <20231013121029.353351-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013121029.353351-4-jiri@resnulli.us>

On Fri, Oct 13, 2023 at 02:10:25PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> In preparation to allow to access device pointer without devlink
> instance lock held, make sure the device pointer is usable until
> devlink_release() is called.
> 
> Fixes: c137743bce02 ("devlink: introduce object and nested devlink relationship infra")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


