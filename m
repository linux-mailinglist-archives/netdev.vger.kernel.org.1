Return-Path: <netdev+bounces-176474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DADA6A791
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D29B175434
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 13:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0833221F07;
	Thu, 20 Mar 2025 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIt8RGAR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42471EDA38;
	Thu, 20 Mar 2025 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478540; cv=none; b=CZQAkzJLOsX4pIKn7MrgatRWiGwBNjJtXkLMfUX8K5N7dbIFuq7wNoGtXF0PiaWfsFhjWFVD/64yUe1rwS4PSkUVLaXrSCrAJUr7Iu/uhgXTBz2iOtgn5dL7mphtyiwCuP1DAT+/JQE8zVi2PfCXknEK8fkMek6/o8A8JurHBO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478540; c=relaxed/simple;
	bh=eYHw0J9ErBXMczW8Jujicztf/RKplfSLDQPsq1mHYnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9/UwB0IikNybgbpN5H0vPSE8lHn9TREiQ0h7fUd4l5VAIFtjmfI+9ULoeINKIrX48az52eJAzgw9UaLHL2MjLz6gJsVclD0PIaIQjhZbXKJ5KjlyGuUc7x5u2Fa/5rJCTx4w5NFpW7yxdT3WPwa8BMsAx0hsspxYWP1jHm4UHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIt8RGAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66294C4CEDD;
	Thu, 20 Mar 2025 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742478540;
	bh=eYHw0J9ErBXMczW8Jujicztf/RKplfSLDQPsq1mHYnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIt8RGARrtyPSwZrU/EtBE1s7nZpRr/iCIY4Be4ra0O7ZJJaCJzLJGg/+lUJZepi+
	 14N1N0FEm6Jlj6QpOhKcY2K19X5sqCj/3vMYbQdWTpUUij65SxK8C7JHf7yD3gzsU6
	 0polw5EiHg40Z99fTrzXEkKgIl33rmQEEkZJy7FOLtd5k/fJcobN7pfikBkJa9u5di
	 A19eVQ53nWG0EG5j1xRoneNVLt7bSm3YoKbqDinofmRL77HASC2aLNWvY5hj/FvvaH
	 d6qvAZ4RFQZ/k1A3qqBnX+1QmYAtVLYDRp5nYtlUfeHOV3YVkuaWbZxzISajjPB3m7
	 CXT5IHuXN6OSw==
Date: Thu, 20 Mar 2025 13:48:56 +0000
From: Simon Horman <horms@kernel.org>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] net: ch9200: remove extraneous return in
 control_write() to propagate failures
Message-ID: <20250320134856.GT280585@kernel.org>
References: <20250319112156.48312-1-qasdev00@gmail.com>
 <20250319112156.48312-3-qasdev00@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319112156.48312-3-qasdev00@gmail.com>

On Wed, Mar 19, 2025 at 11:21:54AM +0000, Qasim Ijaz wrote:
> The control_write() function sets err to -EINVAL however there 
> is an incorrectly placed 'return 0' statement after it which stops 
> the propogation of the error.
> 
> Fix this issue by removing the 'return 0'.
> 
> Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


