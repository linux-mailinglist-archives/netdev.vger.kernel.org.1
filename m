Return-Path: <netdev+bounces-41779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6927CBE2A
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1271C208D9
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93DA3D3A2;
	Tue, 17 Oct 2023 08:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiiVqtxe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA28BE6D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CABC433C8;
	Tue, 17 Oct 2023 08:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697532774;
	bh=ZXiD3v3xW6mT881pmg1qu7t1aMwVELExalcBREgBnUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HiiVqtxezjgr2cNsOz78HncsbwhCxKvN8zhcWmlJsn8yt+EEdaRPFVYS6NP5SHlZT
	 ow0zj5N5K2EMFKhi5Sjn1TcOKJabTJ6fjhT90pk/DP1QyaT78QarfQXyeI9DjZ6K6B
	 HLQ7Ed39hzmI3iuupe+5eGiCUu+jIgPoTy1+xo+j8wxxwoOMhD/1gf8Ny7EBliOXQr
	 NECbQt0bR6SIKhcFlZ+DfmQeOfGfQSQR0WtSIWDu7wp7cfdNawveE+4mTmd4ANlkDN
	 DZkGunKsD5i2/oDz0IXP9UESdUyUgQwbzfXRsIVvvkwSvHpRnlp9w4Me6sjqjwBsok
	 IQDbUQnWGIMMw==
Date: Tue, 17 Oct 2023 10:52:50 +0200
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com
Subject: Re: [patch net-next v3 5/7] Documentation: devlink: add nested
 instance section
Message-ID: <20231017085250.GM1751252@kernel.org>
References: <20231013121029.353351-1-jiri@resnulli.us>
 <20231013121029.353351-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013121029.353351-6-jiri@resnulli.us>

On Fri, Oct 13, 2023 at 02:10:27PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add a part talking about nested devlink instances describing
> the helpers and locking ordering.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


